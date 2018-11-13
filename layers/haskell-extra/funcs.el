(defun haskell-extra/import (&optional input)
  "Prompts for an import statement to add to the current file"
  (interactive)
  (let ((statement (read-string "Import statement: " (concat "import " input))))
    (save-excursion
      (goto-char (point-min))
      (if (re-search-forward "^import " nil t)
          (beginning-of-line)
        (forward-line 1)
        (insert "\n"))
      (insert (concat statement "\n")))
    (elm-sort-imports)))

(defun haskell-extra/run-brittany-on-buffer ()
  ;; strongly inspired by elm-mode-format-buffer
  (interactive)
  (let* ((in-file (make-temp-file "brittany" nil ".hs"))
         (err-file (make-temp-file "brittany"))
         (contents (buffer-substring-no-properties (point-min) (point-max)))
         (scratch-text (get-buffer "*scratch-text*"))
         (_ (with-temp-file in-file (insert contents))))

    (if-let (command (executable-find "brittany"))
        (unwind-protect
            (let*
                ((error-buffer (get-buffer-create "*brittany errors*"))
                 (retcode
                  (with-temp-buffer
                    (call-process command
                                  nil
                                  (list (current-buffer) err-file)
                                  nil
                                  in-file
                                  "--write-mode" "inplace"
                                  ))))
              (with-current-buffer error-buffer
                (read-only-mode 0)
                (insert-file-contents err-file nil nil nil t)
                (ansi-color-apply-on-region (point-min) (point-max))
                (special-mode))
              (if (eq retcode 0)
                  (progn
                    (insert-file-contents in-file nil nil nil t)
                    (message "brittany applied"))
                (message "brittany failed: see %s" (buffer-name error-buffer))))
          (delete-file in-file)
          (delete-file err-file))
      (message "Could not find brittany on the path"))))

(defun haskell-extra/sort-imports-on-buffer ()
  (interactive)
  (save-excursion
    (goto-char 0)
    (re-search-forward haskell-sort-imports-regexp nil t)
    (haskell-sort-imports)))

(defun haskell-extra/align-unqualified-imports ()
  (interactive)
  (if (haskell-extra/any-qualified-imports)
      ;; if there is a qualified import, add extra spacing to unqualified imports
      (save-excursion
        (goto-char 0)
        (while (re-search-forward "^import \\([^q ]\\)" nil t)
          (replace-match "import           \\1" t nil)))
      ;; otherwise, remove extra spacing
      (save-excursion
        (goto-char 0)
        (while (re-search-forward "^import           " nil t)
          (replace-match "import " t nil)))))

(defun haskell-extra/any-qualified-imports ()
  (save-excursion
    (goto-char 0)
    (re-search-forward "^import qualified" nil t)))

(defun haskell-extra/after-save-hook ()
  (when (equal 'haskell-mode major-mode)
    (when haskell-extra/run-brittany-after-save
      (haskell-extra/run-brittany-on-buffer))

    (when haskell-extra/sort-imports-after-save
      (haskell-extra/sort-imports-on-buffer))

    (when haskell-extra/align-unqualified-imports-after-save
      (haskell-extra/align-unqualified-imports))

    (let ((before-save-hook '())
          (after-save-hook '()))
      (basic-save-buffer))))
