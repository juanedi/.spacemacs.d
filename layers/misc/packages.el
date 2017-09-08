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
    magit
    neotree
    projectile
    (ansi-colors :location built-in)
    )
)

(defun misc/post-init-avy ()
  (setq-default
   avy-background nil
   avy-highlight-first t
   ))

(defun misc/init-drag-stuff ()
  (drag-stuff-global-mode))

(defun misc/post-init-magit ()
  (add-hook 'git-commit-mode-hook 'evil-insert-state))

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

  ;; having neotree open breaks layout switching
  (add-hook 'persp-before-switch-functions (lambda (&rest _args) (neotree-hide)))

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
  ;; on project switch change neotree root and display an empty buffer
  ;; for some reason, without selecting window-1 the file chosen in
  ;; projectile appears in a new split window
  (setq projectile-switch-project-action
        (lambda ()
          (spacemacs/new-empty-buffer)
          (neotree-projectile-action)
          (winum-select-window-1)
          (projectile-find-file)
          )))

(defun misc/post-init-ansi-colors ()
  (add-hook 'compilation-filter-hook 'misc//colorize-compilation-buffer))

;;; packages.el ends here
