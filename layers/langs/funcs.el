(defun jedi/rspec-verify-fdoc ()
  "Run the specified spec, or the spec file for the current buffer using DOC formatter."
  (interactive)
  (rspec--autosave-buffer-maybe)
  (rspec-run-single-file (rspec-spec-file-for (buffer-file-name))
                         "--colour --require spec_helper --format doc"))

(defun jedi/rspec-verify-single-fdoc ()
  "Run the specified example at point using DOC formatter."
  (interactive)
  (rspec--autosave-buffer-maybe)
  (rspec-run-single-file
   (cons
    (rspec-spec-file-for (buffer-file-name))
    (save-restriction
      (widen)
      (number-to-string (line-number-at-pos))))
   "--colour --require spec_helper --format doc"))
