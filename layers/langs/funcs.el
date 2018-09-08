(defun langs/rspec-verify-fdoc ()
  "Run the specified spec, or the spec file for the current buffer using DOC formatter."
  (interactive)
  (rspec--autosave-buffer-maybe)
  (rspec-run-single-file (rspec-spec-file-for (buffer-file-name))
                         "--colour --require spec_helper --format doc"))

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
