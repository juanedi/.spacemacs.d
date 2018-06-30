;;; packages.el --- langs layer packages file for Spacemacs.
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

(defconst langs-packages
  '(
    rspec-mode
    elm-mode
    )
)

(defun langs/post-init-rspec-mode ()
  (advice-add
   'rspec-toggle-spec-and-target
   :after
   (lambda ()
     (if (string-empty-p (buffer-string))
         (yas-expand-snippet (yas-lookup-snippet 'spec))))))

(defun langs/post-init-elm-mode ()
  (add-hook
   'elm-mode-hook
   (lambda ()
     (if (string-empty-p (buffer-string))
         (yas-expand-snippet (yas-lookup-snippet 'module))))))
;;; packages.el ends here
