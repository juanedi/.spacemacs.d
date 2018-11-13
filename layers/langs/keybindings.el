(spacemacs/set-leader-keys-for-major-mode 'ruby-mode "t B" 'langs/rspec-verify-fdoc)

(spacemacs/set-leader-keys-for-major-mode 'ruby-mode "t o"
  (lambda ()
    (interactive)
    (langs/run-in-split-window 'rspec-toggle-spec-and-target)))
