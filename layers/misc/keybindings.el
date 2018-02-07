;; Avy
;; Swap these shortcuts (I use the char-2 version a lot more)
(spacemacs/set-leader-keys "j j" 'evil-avy-goto-char-2)
(spacemacs/set-leader-keys "j J" 'evil-avy-goto-char)


;; Drag stuff
(define-key drag-stuff-mode-map (kbd "M-k") 'drag-stuff-up)
(define-key drag-stuff-mode-map (kbd "M-j") 'drag-stuff-down)


;; Neotree
;; shortcut to highlight current file in (possibly currently open) neotree
(spacemacs/set-leader-keys "p T" 'misc//neotree-find-in-project)


;; Projectile
(spacemacs/set-leader-keys "p A" 'misc//projectile-toogle-between-implementation-and-test-splitting)


;; Named macros
;; split line at comma
(evil-set-register ?c [?f ?, ?l ?s return escape ?l])
;; rpsec: turn assignment into let binding
(evil-set-register ?l [?y ?s ?i ?o ?\) ?i ?l ?e ?t ?j ?k ?l ?a ?: escape ?f ?= ?l ?v ?$ ?h ?s ?\} ?h ?x ?\C-l ?$ ?i ?  escape ?\C-h ?^])


;; Window management
(evil-ex-define-cmd "vsp" 'split-window-right-and-focus)
(spacemacs/set-leader-keys "w v" 'split-window-right-and-focus)
(spacemacs/set-leader-keys "w V" 'split-window-right)

(evil-ex-define-cmd "sp" 'split-window-below-and-focus)
(spacemacs/set-leader-keys "w s" 'split-window-below-and-focus)
(spacemacs/set-leader-keys "w S" 'split-window-below)


(spacemacs/set-leader-keys "b S" 'misc/switch-to-text-scratch-buffer)

;; Navigation
(define-key evil-normal-state-map (kbd "C-H") (kbd "^"))
(define-key evil-normal-state-map (kbd "C-L") (kbd "$"))


;; (spacemacs/set-leader-keys "o e p" 'eval-print-last-sexp)
(spacemacs/set-leader-keys "o f y" 'misc/show-and-copy-relative-buffer-filename)
(spacemacs/set-leader-keys "j F" 'find-function-at-point)
(spacemacs/set-leader-keys "o g" 'helm-google)
(spacemacs/set-leader-keys "o b" 'misc/open-bookmark)

;; PREFIX: o l
;; switching to persp layouts
;; use misc/set-project-shortcut to define keybindings to switch to most used projects.
;;
;; Example: the following code bind "SPC o l c" to ~/code/cool-project
;;
;;   (misc/set-project-shortcut "p" "cool-project" "~/Dropbox/Apps/cool-project/")
(spacemacs/declare-prefix "o l" "persp-switch")
(spacemacs/set-leader-keys "o l l" 'spacemacs/helm-persp-switch-project)

(spacemacs/declare-prefix "o c" "compilation")
(spacemacs/set-leader-keys "o c e" 'misc//flycheck-first-error)
(spacemacs/set-leader-keys "o c c" 'flycheck-buffer)

;; CMD+S saves file and exits insert mode
(define-key evil-insert-state-map (kbd "s-s") (lambda () (interactive)
                                                (progn
                                                  (evil-escape)
                                                  (save-buffer))))

(global-set-key (kbd "C-SPC") 'helm-projectile-switch-to-buffer)
