;;; packages.el --- ruby-extra layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2017 Sylvain Benner & Contributors
;;
;; Author: Juan Edi <jedi@chappie.local>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Code:

(defconst ruby-extra-packages
  '(
    rspec-mode
    )
  )

(defun ruby-extra/post-init-rspec-mode ()
  (advice-add
   'rspec-toggle-spec-and-target
   :after
   (lambda ()
     (if (string-empty-p (buffer-string))
         (yas-expand-snippet (yas-lookup-snippet 'spec))))))
;;; packages.el ends here
