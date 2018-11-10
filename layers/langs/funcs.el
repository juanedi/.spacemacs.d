(defun langs/rspec-verify-fdoc ()
  "Run the specified spec, or the spec file for the current buffer using DOC formatter."
  (interactive)
  (rspec--autosave-buffer-maybe)
  (rspec-run-single-file (rspec-spec-file-for (buffer-file-name))
                         "--colour --require spec_helper --format doc"))

(defun langs/haskell-import (&optional input)
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

(defun langs/elm-import (&optional input)
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

(defun langs/elm-import-from-file ()
  "Selects an elm file interactively and adds an import for the corresponding module"
  (interactive)
  (let*
      ((all-files (projectile-current-project-files))
       (elm-files (seq-filter (lambda (f) (s-ends-with-p ".elm" f)) all-files))
       (file-name (projectile-completing-read "Module to import: " elm-files)))
    (when file-name
      (let*
          ((full-file-name (expand-file-name file-name (projectile-project-root)))
           (module-name (with-current-buffer (find-file-noselect full-file-name)
                          (elm--get-module-name))))
        (langs/elm-import module-name)))))

(defun langs/elm-find-imports-of-current-module ()
  "Searches for imports of the current module in the project"
  (interactive)
  (let ((module-name (regexp-quote (elm--get-module-name)))
        (default-directory (elm-test-runner--project-root))
        (compilation-environment '("TERM=ansi")))
    (find-grep
     (concat
      "git grep"
      " --no-color -nH"
      " -e 'import " module-name "$'"
      " -e 'import " module-name " '"
      " -e 'import " module-name " '"
     ))))

(defun langs/elm-show-and-copy-module-name ()
  "Show and copy the current module's name in the minibuffer."
  (interactive)
  (message (kill-new (elm--get-module-name))))

(defun langs/elm-current-module-name ()
  (let*
      ((raw-components
        (file-name-sans-extension (file-relative-name (buffer-file-name) (elm-test-runner--project-root))))
       (components
        (split-string raw-components "/"))
       (modules
        (remove-if (lambda (c) (string-equal c (downcase c)))
                   components)))
    (string-join modules ".")))

(defun langs/ruby-current-module-name ()
  (let*
      ((raw-components (langs//ruby-extract-module-segments-from-file-path (buffer-file-name)))
       (components
        (seq-map 's-upper-camel-case (split-string raw-components "/"))))
    (string-join components "::")))

(defun langs//ruby-extract-module-segments-from-file-path (file-name)
  "Return a resource name extracted from the name of the currently visiting file."
  (let* ((ruby-module-regex
          `("/spec/controllers/\\(.+\\)_spec.rb\\'"
            "/spec/lib/\\(.+\\)_spec.rb\\'"
            "/spec/\\(.+\\)_spec.rb\\'"))
         (name (and file-name
                    (loop for re in ruby-module-regex
                          do (if (string-match re file-name)
                                 (return (match-string 1 file-name)))))))
    (and name
         (singularize-string name))))

(defun langs/run-in-split-window (fun)
  (delete-other-windows)
  (split-window-right-and-focus)
  (call-interactively fun))

(defun langs/open-test-or-implementation-other-window ()
  "Opens the matching test or implementation for the current buffer in a split window"
  (interactive)
  (let
      ((toggle-fun
        (cond ((eq major-mode 'elm-mode) 'elm-test-runner-toggle-test-and-target)
              ((eq major-mode 'ruby-mode) 'rspec-toggle-spec-and-target))))
    (when toggle-fun
      (delete-other-windows)
      (split-window-right-and-focus)
      (call-interactively toggle-fun))))

(defun langs/haskell-run-brittany-on-buffer ()
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

(defun langs/haskell-sort-imports-on-buffer ()
  (interactive)
  (save-excursion
    (goto-char 0)
    (re-search-forward haskell-sort-imports-regexp nil t)
    (haskell-sort-imports)))

(defun langs/haskell-align-unqualified-imports ()
  (interactive)
  (if (langs//haskell-any-qualified-imports)
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

(defun langs//haskell-any-qualified-imports ()
  (save-excursion
    (goto-char 0)
    (re-search-forward "^import qualified" nil t)))

(defun langs/haskell-after-save-hook ()
  (when (equal 'haskell-mode major-mode)
    (when langs/haskell-run-brittany-after-save
      (langs/haskell-run-brittany-on-buffer))

    (when langs/haskell-sort-imports-after-save
      (langs/haskell-sort-imports-on-buffer))

    (when langs/haskell-align-unqualified-imports-after-save
      (langs/haskell-align-unqualified-imports))

    (let ((before-save-hook '())
          (after-save-hook '()))
      (basic-save-buffer))))
