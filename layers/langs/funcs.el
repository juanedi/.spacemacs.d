;; (defun langs/open-test-or-implementation-other-window ()
;;   "Opens the matching test or implementation for the current buffer in a split window"
;;   (interactive)
;;   (let
;;       ((toggle-fun
;;         (cond ((eq major-mode 'elm-mode) 'elm-test-runner-toggle-test-and-target)
;;               ((eq major-mode 'ruby-mode) 'rspec-toggle-spec-and-target))))
;;     (when toggle-fun
;;       (delete-other-windows)
;;       (split-window-right-and-focus)
;;       (call-interactively toggle-fun))))
