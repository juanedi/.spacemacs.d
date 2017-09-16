(configuration-layer/declare-layers
 '(
   (auto-completion
    :variables
    auto-completion-enable-help-tooltip t
    auto-completion-tab-key-behavior 'cycle
    auto-completion-enable-snippets-in-popup t)

   (syntax-checking
    :variables
    ;; use flycheck-popup-tip to display errors
    syntax-checking-enable-tooltips nil
    flycheck-highlighting-mode 'lines
    )
   ))
