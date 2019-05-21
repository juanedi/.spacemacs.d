;;; packages.el --- org-notes layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2017 Sylvain Benner & Contributors
;;
;; Author: Juan Edi <jedi@chappie.local>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `org-notes-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `org-notes/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `org-notes/pre-init-PACKAGE' and/or
;;   `org-notes/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst org-notes-packages
  '(org)
)

(defun org-notes/post-init-org ()
  (setq
   ;; for some reason this setting is overwritten if I put this in config.el
   org-default-notes-file "~/Dropbox/Apps/org-notes/things.org"
   org-agenda-files (list "~/Dropbox/Apps/org-notes/agenda.org")))

;;; packages.el ends here
