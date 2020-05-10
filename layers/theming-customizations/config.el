(setq theming-modifications
      '(
        (spacegray
         (popup-tip-face
          :background "#f5f5f5"
          :foreground "#232830")
         (vertical-border
          :background "#232830"
          :foreground "#4f5b67")
         (mode-line
          :inherit default
          :background "#343d46"
          :family unspecified
          )
         (powerline-active1
          :background "#1c1f26"
          )
         (helm-source-header
          :height 1.1
          :box (:line-width 4 :color "#232830")
          :weight unspecified
          )
         (header-line
          :foreground "#FFFFFF"
          :background "#232830"
          )
         (helm-minibuffer-prompt
          :foreground "#DCA432"
          :background "#232830"
          :box (:line-width 2 :color "#232830")
          )
         (line-number-current-line
          :foreground "#DCA432"
          :background "#343d46"
          )
         )
        (sanityinc-tomorrow-night
         (popup-tip-face
          :background "#c5c8c6"
          :foreground "#1d1f21")
         (fringe :background "#1d1f21")
         )
        (sanityinc-tomorrow-day
         (popup-tip-face
          :background "grey20"
          :foreground "white")
         (fringe :background "#ffffff")
         )
        (sanityinc-tomorrow-bright
         (popup-tip-face :background "#424242")
         (fringe :background "#000000")
         )
        (doom-vibrant
         (fringe :background nil)
         )
        (doom-nord-light
         (popup-tip-face
          :background "#C2D0E7"
          :foreground "#3B4252"
          ))
        (doom-city-lights
         (fringe :background nil)
         (popup-tip-face
          :background "#56697A"
          :foreground "#1D252C"))
        (monokai
         (mode-line :box nil))
        ))
