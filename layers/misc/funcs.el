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

(defun misc//customize-flycheck-popups ()
  ;; ugly hack!
  ;; right now flycheck-popup-tip does now allow customizing the error format
  ;; nor the margins used.
  ;; it should probably be cleaner to do this using defadvice, or making a PR :)
    (with-eval-after-load 'flycheck-popup-tip
      (defun flycheck-popup-tip-show-popup (errors)
        "Display ERRORS, using popup.el library."
        (flycheck-popup-tip-delete-popup)
        (when errors
          (setq flycheck-popup-tip-object
                (popup-tip
                 (concat "\n "(flycheck-popup-tip-format-errors errors) "\n")
                 :nostrip t
                 :margin 2
                 :nowait t))
          (add-hook 'pre-command-hook 'flycheck-popup-tip-delete-popup nil t)))))
