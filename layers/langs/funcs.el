(defun langs/rspec-verify-fdoc ()
  "Run the specified spec, or the spec file for the current buffer using DOC formatter."
  (interactive)
  (rspec--autosave-buffer-maybe)
  (rspec-run-single-file (rspec-spec-file-for (buffer-file-name))
                         "--colour --require spec_helper --format doc"))

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
