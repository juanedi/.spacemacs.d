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
(evil-set-register ?c [?f ?, ?l ?s return escape ?l])


;; Window mandagement
(evil-ex-define-cmd "vsp" 'split-window-right-and-focus)
(spacemacs/set-leader-keys "w v" 'split-window-right-and-focus)
(spacemacs/set-leader-keys "w V" 'split-window-right)

(evil-ex-define-cmd "sp" 'split-window-below-and-focus)
(spacemacs/set-leader-keys "w s" 'split-window-below-and-focus)
(spacemacs/set-leader-keys "w S" 'split-window-below)


;; Navigation
(define-key evil-normal-state-map (kbd "C-H") (kbd "^"))
(define-key evil-normal-state-map (kbd "C-L") (kbd "$"))


;; Misc
(spacemacs/set-leader-keys "o e" 'eval-print-last-sexp)

;; CMD+S saves file and exits insert mode
(define-key evil-insert-state-map (kbd "s-s") (lambda () (interactive)
                                                (progn
                                                  (evil-escape)
                                                  (save-buffer))))
