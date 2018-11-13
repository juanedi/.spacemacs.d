;;; packages.el --- elm-extra layer packages file for Spacemacs.
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

(defconst elm-extra-packages
  '(
    elm-mode
    )
  )

(defun elm-extra/post-init-elm-mode ()
  (add-hook
   'elm-mode-hook
   (lambda ()
     (if (string-empty-p (buffer-string))
         (yas-expand-snippet (yas-lookup-snippet 'module))))))
;;; packages.el ends here
