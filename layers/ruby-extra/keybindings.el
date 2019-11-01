(seq-do
 (lambda (mode)
   (spacemacs/set-leader-keys-for-major-mode mode "t B" 'ruby-extra/rspec-verify-fdoc)
   (spacemacs/set-leader-keys-for-major-mode mode "t O" 'ruby-exra/rspec-outline)

   (spacemacs/set-leader-keys-for-major-mode mode "t o"
     (lambda ()
       (interactive)
       (misc/run-in-split-window 'rspec-toggle-spec-and-target)))
   )
 '(ruby-mode enh-ruby-mode))
