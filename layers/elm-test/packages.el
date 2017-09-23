;;; packages.el --- elm-test layer packages file for Spacemacs.
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

(defconst elm-test-packages
  '(
    (elm-test :location local)
    )
  )

(defun elm-test/init-elm-test ()
  (use-package elm-test
    :after elm-mode
    :init
    (progn
      (spacemacs/declare-prefix-for-mode 'elm-mode "mt" "elm/test")
      (spacemacs/set-leader-keys-for-major-mode 'elm-mode
        "tb" 'elm-test-run
        "tw" 'elm-test-watch
        "tr" 'elm-test-rerun))))

;;; packages.el ends here