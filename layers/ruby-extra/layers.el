(configuration-layer/declare-layers
 '((ruby
    :variables
    ruby-insert-encoding-magic-comment nil
    ruby-test-runner 'rspec

    ;; always set ruby version via direnv to avoid weird race conditions between
    ;; chruby and direnv
    ruby-version-manager nil

    ruby-enable-enh-ruby-mode nil
    )))
