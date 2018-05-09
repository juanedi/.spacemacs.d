;;; packages.el --- misc layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2017 Sylvain Benner & Contributors
;;
;; Author: Juan Edi <jedi@chappie.local>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Code:

(defconst misc-packages
  '(
    avy
    drag-stuff
    neotree
    projectile
    (ansi-colors :location built-in)
    jq-mode
    helm-google
    flycheck
    )
)

(defun misc/post-init-avy ()
  (setq-default
   avy-background nil
   avy-highlight-first t
   ))

(defun misc/init-drag-stuff ()
  (drag-stuff-global-mode))

(defun misc/post-init-neotree ()
  ;; colors
  (defface neo-link-face
    '((((background dark)) (:foreground "#abb2bf"))
      (t                   (:foreground "Black")))
    "*Face used for open file/dir in neotree buffer."
    :group 'neotree :group 'font-lock-highlighting-faces)
  (defvar neo-dir-link-face 'neo-link-face)
  (defvar neo-file-link-face 'neo-link-face)

  ;; font size
  (add-hook 'neotree-mode-hook (lambda () (text-scale-set -1)))

  ;; hide stuff
  (add-hook 'neotree-mode-hook (lambda () (add-to-list 'neo-hidden-regexp-list "^elm-stuff$")))

  (add-hook 'projectile-before-switch-project-hook 'neotree-hide)

  ;; having neotree open breaks layout switching
  (add-hook 'persp-before-switch-functions (lambda (&rest _args) (neotree-hide)))

  ;; Use same binding as in helm to open file in vertical split
  (evil-define-key 'evilified neotree-mode-map (kbd "C-c o") 'neotree-enter-vertical-split)

  (setq-default
   ;; always open neotree focused on the current file
   neo-smart-open t
   ;; do not show folder icons
   neo-theme 'icons
   ;; do not show hidden files
   neo-show-hidden-files nil
   ;; hide "press ? for help"
   neo-banner-message nil
   ;; accidentally pressing the escape sequence leaves neotree in a weird state
   evil-escape-excluded-major-modes '(neotree-mode)
   ))

(defun misc/post-init-projectile ()
  (setq projectile-switch-project-action 'misc/projectile-home)

  ;; clear cache after switching branches
  (use-package magit
    :defer t
    :config
    (advice-add 'magit-checkout :after 'misc//invalidate-projectile-cache)
    (advice-add 'magit-reset-internal :after 'misc//invalidate-projectile-cache)))

(defun misc/post-init-ansi-colors ()
  (add-hook 'compilation-filter-hook 'misc//colorize-compilation-buffer))

(defun misc/init-helm-google ())

(defun misc/init-jq-mode ())

(defun misc/post-init-flycheck ()
  ;; restore focus to the code window after displaying a buffer with long error messages
  (advice-add 'flycheck-display-error-messages :around
              (lambda (orig-fun &rest args)
                (let ((current-window (selected-window))
                      (result (apply orig-fun args)))
                  (progn
                    (select-window current-window)
                    result)))))
;;; packages.el ends here
