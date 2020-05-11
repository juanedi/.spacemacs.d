(deftheme ayu-dark
  "Created 2018-05-06. An emacs-port of the dark verions of the amazing Ayu-theme")

(custom-theme-set-variables
 'ayu-dark
)

(custom-theme-set-faces
 'ayu-dark
 ;; basic theming.

 '(default ((t (:foreground "#e6e1cf" :background "#0f1419"))))
 '(region ((t (:background "#253340"))))
 '(cursor ((t (:background "#FFCC66"))))

 ;; Temporary defaults
 '(linum ((t (:foreground "#29323b" :background "031419"))))

 '(minibuffer-prompt ((t (:foreground "#1278A8" :background nil :weight bold))))
 '(escape-glyph ((t (:foreground "#95E6CB" :background nil))))
 '(highlight ((t (:foreground nil :background "#253340"))))
 '(shadow ((t (:foreground "#777777" :background nil))))

 '(trailing-whitespace ((t (:foreground "#FFFFFF" :background "#C74000"))))
 '(link ((t (:foreground "#00B7F0" :background nil :underline t))))
 '(link-visited ((t (:foreground "#4488CC" :underline t :inherit (link)))))
 '(button ((t (:foreground "#FFFFFF" :background "#444444" :underline t :inherit (link)))))
 '(next-error ((t ( :inherit (region)))))
 '(query-replace ((t ( :inherit (isearch)))))
 '(header-line ((t (:foreground "#EEEEEE" :background "#444444" :box nil :inherit (mode-line)))))

 '(mode-line-highlight ((t ( :background "#242B38" :box nil))))
 '(mode-line-emphasis ((t ( :weight bold))))
 '(mode-line-buffer-id ((t ( :box nil :weight bold))))

 '(mode-line-inactive ((t (:foreground "#B4B09E" :background "#333942" :box nil :weight light :inherit (mode-line)))))
 '(mode-line ((t (:foreground "#FFFFFF" :background "#333942" :box nil))))

 '(isearch ((t (:foreground "#99CCEE" :background "#444444"))))
 '(isearch-fail ((t ( :background "#FFAAAA"))))
 '(lazy-highlight ((t ( :background "#77BBDD"))))
 '(match ((t ( :background "#3388CC"))))

 '(tooltip ((t (:foreground "black" :background "LightYellow" :inherit (variable-pitch)))))

 '(js3-function-param-face ((t (:foreground "#BFC3A9"))))
 '(js3-external-variable-face ((t (:foreground "#F0B090" :bold t))))

 '(secondary-selection ((t ( :background "#342858"))))
 '(cua-rectangle ((t (:foreground "#E0E4CC" :background "#342858"))))

 ;; Magit hightlight
 '(magit-item-highlight ((t (:foreground "white" :background "#1278A8" :inherit nil))))

 ;; flyspell-mode
 '(flyspell-incorrect ((t (:underline "#AA0000" :background nil :inherit nil))))
 '(flyspell-duplicate ((t (:underline "#009945" :background nil :inherit nil))))

 ;; flymake-mode
 '(flymake-errline ((t (:underline "#AA0000" :background nil :inherit nil))))
 '(flymake-warnline ((t (:underline "#009945" :background nil :inherit nil))))

 ;;git-gutter
 '(git-gutter:added ((t (:foreground "#609F60" :bold t))))
 '(git-gutter:modified ((t (:foreground "#3388CC" :bold t))))
 '(git-gutter:deleted ((t (:foreground "#CC3333" :bold t))))

 '(diff-added ((t (:background "#305030"))))
 '(diff-removed ((t (:background "#903010"))))
 '(diff-file-header ((t (:background "#362145"))))
 '(diff-context ((t (:foreground "#E0E4CC"))))
 '(diff-changed ((t (:foreground "#3388CC"))))
 '(diff-hunk-header ((t (:background "#242130"))))


 '(font-lock-comment-face ((t (:foreground "#5C6773" :italic t))))
 '(font-lock-variable-name-face ((t (:foreground "#D9D7CE"))))
 '(font-lock-keyword-face ((t (:foreground "#FFAE57"))))
 '(font-lock-constant-face ((t (:foreground "#FFAE57"))))
 '(git-gutter:deleted ((t (:foreground "#5CCFE6"))))
 '(font-lock-function-name-face ((t (:foreground "#FFD580"))))
 '(font-lock-builtin-face ((t (:foreground "#FF7733"))))
 '(font-lock-string-face ((t (:foreground "#BAE67E" :normal t))))
 '(font-lock-type-face ((t (:foreground "#5CCFE6"))))
 '(font-lock-warning-face ((t (:foreground "#FFFFFF" :background "#FFAE57"))))
 '(diff-added ((t (:foreground "#BAE67E"))))
 '(diff-removed ((t (:foreground "#5CCFE6"))))
 '(diff-changed ((t (:foreground "#FFAE57"))))
 '(markdown-list-face ((t (:foreground "#D9D7CE"))))
 '(markdown-blockquote-face ((t (:foreground "#80D4FF" :italic t))))
 '(markdown-link-title-face ((t (:foreground "#FFC44C" :underline t))))
 '(git-gutter:untracked ((t (:foreground "#5C6773"))))
 '(font-lock-comment-delimiter-face ((t (:foreground "#5C6773" :italic t))))

;; Rainbow delimiters
 '(rainbow-delimiters-depth-1-face ((t (:foreground "#4192A1"))))
 '(rainbow-delimiters-depth-2-face ((t (:foreground "#47A0B1"))))
 '(rainbow-delimiters-depth-3-face ((t (:foreground "#55AABB"))))
 '(rainbow-delimiters-depth-4-face ((t (:foreground "#65B2C1"))))
 '(rainbow-delimiters-depth-5-face ((t (:foreground "#75BAC7"))))
 '(rainbow-delimiters-depth-6-face ((t (:foreground "#85C2CE"))))
 '(rainbow-delimiters-depth-7-face ((t (:foreground "#95CAD4"))))
 '(rainbow-delimiters-depth-8-face ((t (:foreground "#A5D2DB"))))
 '(rainbow-delimiters-depth-9-face ((t (:foreground "#B5DAE1"))))
 '(rainbow-delimiters-unmatched-face ((t (:foreground "#FF0000"))))

 ;; Powerline
 '(mode-line ((t (:foreground "#FFFFFF"))))
 '(powerline-active0 ((t (:foreground "#FFFFFF"))))
 '(powerline-active1 ((t (:foreground "#FFFFFF"))))
 '(powerline-active2 ((t (:foreground "#FFFFFF"))))

 ;; Company
 '(company-tooltip ((t (:inherit (company-tooltip-search-selection)))))
 '(company-tooltip-search-selection ((t (:background nil))))
 '(company-tooltip-selection ((t (:background "#2D333D"))))
 '(company-preview ((t (:inherit (company-tooltip)))))
 '(company-preview-common ((t (:inherit (company-tooltip-common-selection)))))
 '(company-tooltip-common ((t (:foreground "#FFAE57"))))
 '(company-scrollbar-fg ((t (:background "#FFAE57"))))
 '(company-scrollbar-bg ((t (:inherit (company-tooltip)))))

 ;; Auto highlight symbol
 '(ahs-plugin-whole-buffer-face ((t (:inherit (spacemacs-visual-face)))))

 ;; Org headers
 '(org-document-title ((t (:height 1.44 :foreground "#FFD580"))))
 '(org-level-1 ((t (:foreground "#5CCFE6" :height 1.1))))
 '(org-level-2 ((t (:foreground "#FFAE57" :height 1.1))))
 '(org-level-3 ((t (:foreground "#FF7733" :height 1.1))))

 ;; Org agenda
 '(org-warning ((t (:foreground "#FFAE57" :height 1))))
 '(org-scheduled-previously ((t (:foreground "chocolate1" :height 1))))
 '(org-scheduled-today ((t (:foreground "#FFD580" :height 1))))

 ;; Helm
 '(helm-source-header ((t (:inherit (info-title-3)))))
 '(helm-selection ((t (:background "#252B37"))))
 '(helm-minibuffer-prompt ((t (:background nil :foreground "#FFFFFF"))))
 '(helm-ff-file ((t (:foreground nil))))
 '(helm-ff-directory ((t (:inherit (helm-ff-file)))))
 '(helm-selection ((t (:background "#2D333D"))))

 ;; Misc
 '(hl-line ((t (:background "#151A1E"))))

 '(vertical-border ((t (:foreground "#343F4C"))))
 '(fringe ((t (:inherit (default)))))
 '(line-number-current-line ((t (:inherit (line-number) :foreground "#FFD580"))))

 '(spacemacs-insert-face ((t (:background "#FF7733"))))

) ;; End face definitions

;;;###autoload
(when load-file-name
  (add-to-list 'custom-theme-load-path
               (file-name-as-directory (file-name-directory load-file-name))))

(provide-theme 'ayu-dark)

;; Local Variables:
;; eval: (when (fboundp 'rainbow-mode) (rainbow-mode +1))
;; End:

;;; ayu-dark-theme.el ends here
