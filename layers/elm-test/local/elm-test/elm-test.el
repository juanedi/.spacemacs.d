;;; elm-test.el --- Enhance elm-mode for elm-test

;; Copyright (C) 2017  Juan Edi

;; Author: Juan Edi
;; Keywords: elm elm-tesst
;; Version: 0.0.1

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;;; Commentary:

;; At least for the moment, this package just sets up a few fuctions to run elm
;; tests from inside emacs when using elm-mode.
;;
;; Most of it is just a copy of the fantastic rspec-mode
;; (https://github.com/pezra/rspec-mode)

;;; Code:

(require 'compile)
(require 'ansi-color)

(define-compilation-mode elm-test-compilation-mode "Elm Test Compilation"
  "Compilation mode for elm-test output."
  ;; (add-hook 'compilation-filter-hook 'elm-test--colorize-compilation-buffer nil t)
  )

(defun elm-test-run ()
  "Run elm-test on the current buffer's file."
  (interactive)
  (elm-test--run-single-file (buffer-file-name)
                         nil ;; do we need options?
                         ))

(defun elm-test--run-single-file (test-file &rest opts)
  "Run elm-test on SPEC_FILE with the specified options OPTS."
  ;; TODO: equivalent to rspec-runner-target to fix quoting
  (elm-test--compile test-file opts))

(defun elm-test--compile (target &optional opts)
  "Run a compile for TARGET with the specified options OPTS."

  (setq elm-test-last-directory default-directory
        elm-test-last-arguments (list target opts))

  (let ((default-directory (or (elm-test--project-root)
                               (locate-dominating-file (buffer-file-name) "script")
                               default-directory)))
    (compile
     (elm-test--compile-command target opts)
     'elm-test-compilation-mode)))

(defun elm-test-rerun ()
  "Re-run the last elm-test invocation."
  (interactive)
  (if (not elm-test-last-directory)
      (error "No previous verification")
    (let ((default-directory elm-test-last-directory))
      (apply #'elm-test--compile elm-test-last-arguments))))

(defun elm-test--project-root ()
  ;; TODO
  nil)

(defun elm-test--compile-command (target &optional opts)
  "Composes elm-test command line for the compile function"
  (mapconcat 'identity `(,(elm-test--runner)
                         ,(elm-test--runner-options opts)
                         ,target) " "))

(defun elm-test--runner ()
  "Return command line to run elm-test."
  ;; TODO: let us customize this via dir-locals to use ./script/elm-test
  "./script/elm-test")

(defun elm-test--runner-options (&optional opts)
  "Return string of options from OPTS for command line."
  (let ((opts (if (listp opts)
                  opts
                (list opts))))
    (mapconcat 'identity opts " ")))

(provide 'elm-test)
;;; elm-test.el ends here
