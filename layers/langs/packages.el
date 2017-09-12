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
  '(popwin)
)

(defun langs/post-init-popwin ()
  (push '("*rspec-compilation*" :dedicated t :position right :stick t :noselect nil :width 0.5)
        popwin:special-display-config)

  (push '("*Flycheck errors*" :dedicated t :position right :stick t :noselect nil :width 0.4)
        popwin:special-display-config))
;;; packages.el ends here
