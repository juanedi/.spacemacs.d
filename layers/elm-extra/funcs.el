(defun elm-extra/import (&optional input)
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

(defun elm-extra/import-from-file ()
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
                          (elm--get-module-name)))
           (aliased-module-name (elm-extra/aliased-module-name module-name)))
        (elm-extra/import aliased-module-name)))))

(defun elm-extra/find-imports-of-current-module ()
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

(defun elm-extra/show-and-copy-module-name ()
  "Show and copy the current module's name in the minibuffer."
  (interactive)
  (message (kill-new (elm--get-module-name))))

(defun elm-extra/current-module-name ()
  (let*
      ((raw-components
        (file-name-sans-extension (file-relative-name (buffer-file-name) (elm-test-runner--project-root))))
       (components
        (split-string raw-components "/"))
       (modules
        (remove-if (lambda (c) (string-equal c (downcase c)))
                   components)))
    (string-join modules ".")))

(defun elm-extra/aliased-module-name (module-name)
  (concat "import " module-name " as Foo")
  (let ((components (s-split "\\." module-name)))
    (if (< 1 (length components))
        (concat module-name " as " (car (last components)))
        (concat module-name))))
