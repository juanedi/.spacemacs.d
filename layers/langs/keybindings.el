(spacemacs/set-leader-keys-for-major-mode 'ruby-mode "t B" 'langs/rspec-verify-fdoc)

(spacemacs/set-leader-keys-for-major-mode 'elm-mode "m i i" 'langs/elm-import)
(spacemacs/set-leader-keys-for-major-mode 'elm-mode "m i f" 'langs/elm-import-from-file)
(spacemacs/set-leader-keys-for-major-mode 'elm-mode "m i /" 'langs/elm-find-imports-of-current-module)
(spacemacs/set-leader-keys-for-major-mode 'elm-mode "m y" 'langs/elm-show-and-copy-module-name)

(spacemacs/set-leader-keys-for-major-mode 'elm-mode "t o"
  (lambda ()
    (interactive)
    (langs/run-in-split-window 'elm-test-runner-toggle-test-and-target)))

(spacemacs/set-leader-keys-for-major-mode 'ruby-mode "t o"
  (lambda ()
    (interactive)
    (langs/run-in-split-window 'rspec-toggle-spec-and-target)))
