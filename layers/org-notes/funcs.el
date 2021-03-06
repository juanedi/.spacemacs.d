(defun org-notes//new-note-from-template (template)
  "Read a filename and create an org mode note with a template."
  (let* ((current-dir (file-name-as-directory default-directory))
         (file-name (read-file-name "Filename:" current-dir)))
    (when (and (not (eq file-name nil))
               (not (string= "" file-name))
               (file-readable-p (file-name-directory file-name)))
      (write-region template nil file-name)
      (find-file file-name)
      (goto-line 1)
      (evil-append-line 1))))

(defun org-notes/new-note ()
  "Read a filename and create an org mode note with a simple template."
  (interactive)
  (org-notes//new-note-from-template
   (concat
    "#+TITLE: \n"
    "\n")))

(defun org-notes//capture-todo ()
  (interactive)
  (let ((split-width-threshold nil))
    (org-capture nil "t")
    (evil-insert-state)))

(defun org-notes/new-pivotal-note ()
  "Read a filename and create an org mode note with a template for tracking PT stories context."
  (interactive)
  (org-notes//new-note-from-template
   (concat
    "#+TITLE: \n"
    "\n"
    "* Story: [fill]\n"
    "\n"
    "* Notes\n"
    "\n"
    "* TODOs\n"
    "  - [ ] ")))

(defun org-notes/go-to-default-notes-file (&optional arg)
  (interactive "P")
  (if arg
      (find-file-other-window org-default-notes-file)
    (find-file org-default-notes-file)))

(defun org-notes/open-agenda (fill)
  (interactive "P")
  (org-agenda nil "c")
  (when fill
    (delete-other-windows)))
