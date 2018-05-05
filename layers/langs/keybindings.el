(spacemacs/set-leader-keys-for-major-mode 'ruby-mode "t B" 'jedi/rspec-verify-fdoc)

(spacemacs/set-leader-keys-for-major-mode 'elm-mode "m i i" 'jedi/elm-import)
(spacemacs/set-leader-keys-for-major-mode 'elm-mode "m i f" 'jedi/elm-import-from-file)
(spacemacs/set-leader-keys-for-major-mode 'elm-mode "m i /" 'jedi/elm-find-imports-of-current-module)
(spacemacs/set-leader-keys-for-major-mode 'elm-mode "m y" 'jedi/elm-show-and-copy-module-name)

(spacemacs/set-leader-keys-for-major-mode 'elm-mode "t o"
  (lambda ()
    (interactive)
    (jedi/run-in-split-window 'elm-test-toggle-test-and-target)))

(spacemacs/set-leader-keys-for-major-mode 'ruby-mode "t o"
  (lambda ()
    (interactive)
    (jedi/run-in-split-window 'rspec-toggle-spec-and-target)))
