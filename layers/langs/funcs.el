(defun jedi/rspec-verify-fdoc ()
  "Run the specified spec, or the spec file for the current buffer using DOC formatter."
  (interactive)
  (rspec--autosave-buffer-maybe)
  (rspec-run-single-file (rspec-spec-file-for (buffer-file-name))
                         "--colour --require spec_helper --format doc"))

(defun jedi/elm-import (&optional input)
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

(defun jedi/elm-import-from-file ()
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
        (jedi/elm-import module-name)))))

(defun jedi/elm-find-imports-of-current-module ()
  "Searches for imports of the current module in the project"
  (interactive)
  (let ((module-name (regexp-quote (elm--get-module-name)))
        (default-directory (elm-test--project-root))
        (compilation-environment '("TERM=ansi")))
    (find-grep
     (concat
      "git grep"
      " --no-color -nH"
      " -e 'import " module-name "$'"
      " -e 'import " module-name " '"
      " -e 'import " module-name " '"
     ))))

(defun jedi/elm-show-and-copy-module-name ()
  "Show and copy the current module's name in the minibuffer."
  (interactive)
  (message (kill-new (elm--get-module-name))))

(defun jedi/elm-module-for-path ()
  (let*
      ((raw-components
        (file-name-sans-extension (file-relative-name (buffer-file-name) (elm-test--project-root))))
       (components
        (split-string raw-components "/"))
       (modules
        (remove-if (lambda (c) (string-equal c (downcase c)))
                   components)))
    (string-join modules ".")))

(defun jedi/run-in-split-window (fun)
  (delete-other-windows)
  (split-window-right-and-focus)
  (call-interactively fun))

(defun jedi/open-test-or-implementation-other-window ()
  "Opens the matching test or implementation for the current buffer in a split window"
  (interactive)
  (let
      ((toggle-fun
        (cond ((eq major-mode 'elm-mode) 'elm-test-toggle-test-and-target)
              ((eq major-mode 'ruby-mode) 'rspec-toggle-spec-and-target))))
    (when toggle-fun
      (delete-other-windows)
      (split-window-right-and-focus)
      (call-interactively toggle-fun))))
