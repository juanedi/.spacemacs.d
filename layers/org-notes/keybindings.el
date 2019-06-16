(spacemacs/declare-prefix "o n" "org-notes")
(spacemacs/set-leader-keys "o n n" 'org-notes/go-to-default-notes-file)
(spacemacs/set-leader-keys "o n t" 'org-notes//capture-todo)
(evil-define-key 'insert org-mode-map (kbd "M-RET") 'org-insert-item)

(define-key evil-normal-state-map (kbd "S-SPC") 'org-notes/open-agenda)
