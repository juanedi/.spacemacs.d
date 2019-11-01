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
;; parenthesize until end of line
(evil-set-register ?p "v$hs)")

;; Window management
(evil-ex-define-cmd "vsp" 'split-window-right-and-focus)
(spacemacs/set-leader-keys "w v" 'split-window-right-and-focus)
(spacemacs/set-leader-keys "w V" 'split-window-right)

(evil-ex-define-cmd "sp" 'split-window-below-and-focus)
(spacemacs/set-leader-keys "w s" 'split-window-below-and-focus)
(spacemacs/set-leader-keys "w S" 'split-window-below)

(spacemacs/set-leader-keys "o x" 'kill-buffer-and-window)

(spacemacs/set-leader-keys "b S" 'misc/switch-to-org-scratch-buffer)

;; Navigation
(define-key evil-normal-state-map (kbd "C-H") (kbd "^"))
(define-key evil-normal-state-map (kbd "C-L") (kbd "$"))


;; (spacemacs/set-leader-keys "o e p" 'eval-print-last-sexp)
(spacemacs/set-leader-keys "o f y" 'misc/show-and-copy-relative-buffer-filename)
(spacemacs/set-leader-keys "j F" 'find-function-at-point)
(spacemacs/set-leader-keys "o g" 'helm-google)

;; PREFIX: o p
;; switch to or open file in a project
;; use misc/set-project-shortcut to define keybindings for frequently used projects.
;;
;; Example: the following code adds keybindings to ~/code/cool-project
;;
;;   (misc/set-project-shortcut "p" "cool-project" "~/code/cool-project/")
(spacemacs/declare-prefix "o p" "projects")

(spacemacs/declare-prefix "o c" "compilation")
(spacemacs/set-leader-keys "o c e" 'misc//flycheck-first-error)
(spacemacs/set-leader-keys "o c c" 'flycheck-buffer)

;; CMD+S saves file and exits insert mode
(define-key evil-insert-state-map (kbd "s-s") (lambda () (interactive)
                                                (progn
                                                  (evil-escape)
                                                  (save-buffer))))

;; C-SPC: show buffer list using helm
(global-set-key (kbd "C-SPC") 'lazy-helm/helm-mini)

;; expand snippets
(define-key evil-insert-state-map (kbd "C-/") 'hippie-expand)
(define-key evil-insert-state-map (kbd "M-/") 'spacemacs/helm-yas)
