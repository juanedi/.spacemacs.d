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
  (use-package elm-mode
    :config
    ;; reverts the following commit that made '.' be considered part of symbols for compatibility with language servers:
    ;; https://github.com/jcollard/elm-mode/commit/3f042ec430e7d915bfdca21d4f4d6201a882434b
    (setq elm--syntax-table
          (let ((st (make-syntax-table)))
            (modify-syntax-entry ?\{  "(}1nb" st)
            (modify-syntax-entry ?\}  "){4nb" st)
            (modify-syntax-entry ?-  ". 123" st)
            (modify-syntax-entry ?\n ">" st)
            ;; THIS CHANGED!
            ;; (modify-syntax-entry ?. "_" st)

            (modify-syntax-entry ?\" "\"\"" st)
            (modify-syntax-entry ?\\ "\\" st)
            st)))

  (add-hook
   'elm-mode-hook
   (lambda ()
     (if (string-empty-p (buffer-string))
         (yas-expand-snippet (yas-lookup-snippet 'module))))))
;;; packages.el ends here
