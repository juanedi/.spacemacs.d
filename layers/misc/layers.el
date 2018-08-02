(configuration-layer/declare-layers
 '(
   (auto-completion
    :variables
    auto-completion-enable-help-tooltip nil
    auto-completion-tab-key-behavior 'cycle
    auto-completion-enable-snippets-in-popup t
    :disabled-for
    elm
    )

   (syntax-checking
    :variables
    syntax-checking-enable-tooltips nil
    flycheck-highlighting-mode 'lines
    )

   (helm
    :variables
    ; do not limit buffer name width when swithing buffers using helm
    helm-buffer-max-length 50
    )

   (git
    :variables
    git-magit-status-fullscreen nil
    )

   ranger

   prodigy
   ))
