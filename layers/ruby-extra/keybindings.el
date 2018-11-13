(spacemacs/set-leader-keys-for-major-mode 'ruby-mode "t B" 'ruby-extra/rspec-verify-fdoc)

(spacemacs/set-leader-keys-for-major-mode 'ruby-mode "t o"
  (lambda ()
    (interactive)
    (misc/run-in-split-window 'rspec-toggle-spec-and-target)))
