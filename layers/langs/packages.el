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
    popwin
    elm-mode
    )
)

(defun langs/post-init-popwin ()
  (push '("*rspec-compilation*" :dedicated t :position right :stick t :noselect nil :width 0.5)
        popwin:special-display-config)

  (push '("*Flycheck errors*" :dedicated t :position right :stick t :noselect nil :width 0.4)
        popwin:special-display-config))

(defun langs/post-init-elm-mode ()
  ; superhack!
  ; elm-mode uses 'message to display elm-format errors, but when I have a
  ; syntax problem I want flycheck to notify me, not the message popup.
  (defun elm-format--display-error ()))
;;; packages.el ends here
