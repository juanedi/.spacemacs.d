(spacemacs/set-leader-keys-for-major-mode 'elm-mode "m i i" 'elm-extra/import)
(spacemacs/set-leader-keys-for-major-mode 'elm-mode "m i f" 'elm-extra/import-from-file)
(spacemacs/set-leader-keys-for-major-mode 'elm-mode "m i /" 'elm-extra/find-imports-of-current-module)
(spacemacs/set-leader-keys-for-major-mode 'elm-mode "m y" 'elm-extra/show-and-copy-module-name)

(spacemacs/set-leader-keys-for-major-mode 'elm-mode "t o"
  (lambda ()
    (interactive)
    (misc/run-in-split-window 'elm-test-runner-toggle-test-and-target)))
