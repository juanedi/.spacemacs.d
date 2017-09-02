# .spacemacs.d

I try to keep my `.spacemacs` as small as possible, moving everything that makes sense to separate configuration layers (idea borrowed from ![this post](http://www.modernemacs.com/post/migrate-layers/)).


## Usage

```bash
$ git clone git@github.com:juanedi/.spacemacs.d .spacemacs.d
$ ln -s .spacemacs.d .spacemacs
```

### Using layers only

Just modify your `.spacemacs` to include the cloned repo in it's layer path:

```lisp
   ;; ...
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '("~/.spacemacs.d/layers/")
   ;; ...
   dotspacemacs-configuration-layers
   '(
     ;; ...
     misc-conf
     timeclock-conf
     langs
     org-notes
     )
```
