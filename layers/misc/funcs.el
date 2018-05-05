(defun misc//projectile-toogle-between-implementation-and-test-splitting ()
  (interactive)
  (split-window-right-and-focus)
  (projectile-toggle-between-implementation-and-test))

(defun misc//neotree-find-in-project ()
  (interactive)
  (if (neo-global--window-exists-p)
      (neotree-hide))
  (neotree-find-project-root))

(defun misc/backup-branch ()
  (interactive)
  (let* ((current-branch (magit-get-current-branch))
         (backup-name (concat "backup/" current-branch)))
    (if (stringp current-branch)
        (magit-branch backup-name current-branch "-f"))))

(defun misc/show-and-copy-relative-buffer-filename ()
  "Show and copy the full path to the current file in the minibuffer."
  (interactive)
  (let ((file-name (file-relative-name buffer-file-name (projectile-project-root))))
    (if file-name
        (message (kill-new file-name))
      (error "Buffer not visiting a file"))))

(defun misc//colorize-compilation-buffer ()
  "Interpret ansi colors on the compilation buffer. Spacemacs does this by
default in the spacemacs-ui-visual layer, but seems this fixes some quirks."
  (let ((inhibit-read-only t))
    (ansi-color-apply-on-region (point-min) (point-max))))

(defun misc//flycheck-first-error ()
  "Go to first flycheck error in the current buffer, regardless of whether it was already inspected or not."
  (interactive)
  (flycheck-next-error 1 t))

(autoload 'projectile-switch-project-by-name "projectile")

(defun misc/open-or-create-perspective (project)
  (if (member project (persp-names-current-frame-fast-ordered))
      (persp-switch project)
    (let ((persp-reset-windows-on-nil-window-conf t))
      (persp-switch project)
      (projectile-switch-project-by-name project))))

(defun misc/set-project-shortcut (key shortname project)
  (lexical-let
      ((project project)
       (switch-fn (intern (concat "persp-switch-" shortname))))
    (progn
      (defalias
        switch-fn
        (lambda () (interactive) (misc/open-or-create-perspective project))
        (concat "Creates a layout for " project ", or switches to the currently open layout for the project"))
      (spacemacs/set-leader-keys (concat "o l " key) switch-fn))))

(defun misc/jq-interactively-other-buffer ()
  (interactive)
  (let ((tmp-buffer-name (concat "jq-interactively: " (buffer-name))))
    (get-buffer-create tmp-buffer-name)
    (copy-to-buffer tmp-buffer-name (point-min) (point-max))
    (switch-to-buffer-other-window tmp-buffer-name)
    (call-interactively 'jq-interactively)))

(defun misc/customize-popwin-display-config ()
  ;; this overrides configuratio made by other spacemacs layers, so needs to be
  ;; called at the end of the initialization process
  (push '("^\\*Flycheck.+\\*$"    :regexp t :dedicated t :position right :stick t :noselect nil :width 0.5) popwin:special-display-config)
  (push '("^\\*.+compilation\\*$" :regexp t :dedicated t :position right :stick t :noselect t :width 0.5) popwin:special-display-config))

(defun misc/open-bookmark ()
  (interactive)
  (let*
      ((bookmark-names (sort (seq-map 'car misc/bookmarks-alist) 'string<))
       (selection (completing-read "Bookmarks:" bookmark-names nil t))
       (url (when selection (cdr (assoc selection misc/bookmarks-alist)))))
    (when url (browse-url url))))

(defun misc/switch-to-text-scratch-buffer (&optional arg)
  "Switch to the `*scratch-text*' buffer, creating it first if needed.
if prefix argument ARG is given, switch to it in an other, possibly new window."
  (interactive "P")
  (let ((exists (get-buffer "*scratch-text*")))
    (if arg
        (switch-to-buffer-other-window (get-buffer-create "*scratch-text*"))
      (switch-to-buffer (get-buffer-create "*scratch-text*")))
    (when (and (not exists)
               (not (eq major-mode 'text-mode)))
      (text-mode))))
