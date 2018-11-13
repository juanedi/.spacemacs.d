;;; packages.el --- haskell-extra layer packages file for Spacemacs.
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

(defconst haskell-extra-packages
  '(
    haskell-mode
    )
  )

(defun haskell-extra/post-init-haskell-mode ()
  (add-hook 'after-save-hook 'haskell-extra/after-save-hook))
;;; packages.el ends here
