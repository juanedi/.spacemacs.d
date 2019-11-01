(defun ruby-extra/rspec-verify-fdoc ()
  "Run the specified spec, or the spec file for the current buffer using DOC formatter."
  (interactive)
  (rspec--autosave-buffer-maybe)
  (rspec-run-single-file (rspec-spec-file-for (buffer-file-name))
                         "--colour --require spec_helper --format doc"))

(defun ruby-exra/rspec-outline ()
    "Display an outline of specs in the current buffer without actually running them."
  (interactive)
  (rspec--autosave-buffer-maybe)
  (rspec-run-single-file (rspec-spec-file-for (buffer-file-name))
                         "--colour --dry-run --format doc"))

(defun ruby-extra/current-module-name ()
  (let*
      ((raw-components (ruby-extra//extract-module-segments-from-file-path (buffer-file-name)))
       (components
        (seq-map 's-upper-camel-case (split-string raw-components "/"))))
    (string-join components "::")))

(defun ruby-extra//extract-module-segments-from-file-path (file-name)
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
