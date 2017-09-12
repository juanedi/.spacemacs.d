(configuration-layer/declare-layers
 '(
   react
   haskell
   erlang
   python
   yaml
   clojure
   elixir
   latex
   purescript
   vimscript
   csv

   (syntax-checking
    :variables
    syntax-checking-enable-tooltips nil
    flycheck-highlighting-mode 'lines
    )

   (ruby
    :variables
    ruby-insert-encoding-magic-comment nil
    ruby-test-runner 'rspec
    ruby-version-manager 'chruby
    )

   (elm
    :variables
    elm-format-on-save t
    elm-sort-imports-on-save t
    )

   (javascript
    :variables
    js-indent-level 2
    js2-strict-missing-semi-warning nil
    js2-basic-offset 2
    )

   (html
    :variables
    css-indent-offset 2
    web-mode-markup-indent-offset 2
    web-mode-css-indent-offset 2
    web-mode-code-indent-offset 2
    web-mode-attr-indent-offset 2
    )
   ))
