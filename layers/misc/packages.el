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
    magithub
    direnv
    auto-highlight-symbol
    helm-projectile
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
  (setq projectile-switch-project-action 'misc/projectile-home))

(defun misc/post-init-helm-projectile ()
  (use-package magit
    :defer t
    :config
    ;; before opening the find-file dialog, check if the current commit the on
    ;; when we last cleared the cache. if not, rebuild it to make sure we shw a
    ;; fresh list of files.
    (advice-add
     'helm-projectile-find-file
     :before
     (lambda (&optional ARG)
       (let* ((project (projectile-project-root))
              (current-commit (magit-rev-parse "HEAD"))
              (last-rebuild (gethash project misc//projectile-cache-invalidation-record)))
         (when (and
                project
                current-commit
                (not (equal current-commit last-rebuild)))
           (message "Git HEAD changed! Rebuilding projectile cache")
           (projectile-invalidate-cache nil)
           (puthash project current-commit misc//projectile-cache-invalidation-record)))))

    ; after commiting, we track the new commit hash to avoid rebuilding the
    ; cache unnecessarilly (we can do this because committing doesn't change the index)
    (add-hook
     'git-commit-post-finish-hook
     (lambda ()
       (puthash
        (projectile-project-root)
        (magit-rev-parse "HEAD")
        misc//projectile-cache-invalidation-record)))))

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
                    result))))

  ;; fix race condition in which sometimes the direnv hook is run after flycheck
  ;; detects available chekers.
  (add-hook 'flycheck-before-syntax-check-hook 'direnv--maybe-update-environment))

(defun misc/init-magithub ()
  (use-package magithub
    :after magit
    :init
    (setq magithub-dir (concat spacemacs-cache-directory "magithub/"))
    :config
    (progn
      (magithub-feature-autoinject t)
      (define-key magit-status-mode-map "@" #'magithub-dispatch-popup))))

(defun misc/init-direnv ()
  (use-package direnv
    :config
    (direnv-mode))

  (advice-add 'direnv--show-summary :around #'misc//direnv--decorate-summary))

(defun misc/post-init-auto-highlight-symbol ()
  ;; (spacemacs/toggle-automatic-symbol-highlight-on)
  )
;;; packages.el ends here
