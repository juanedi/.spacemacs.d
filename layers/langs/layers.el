(configuration-layer/declare-layers
 '(
   react
   erlang
   python
   yaml
   clojure
   elixir
   groovy
   ;; latex
   purescript
   vimscript
   csv
   graphviz
   coffeescript
   lua

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
