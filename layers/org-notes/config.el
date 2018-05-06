(setq org-default-notes-file "~/Dropbox/Apps/org-notes/things.org")

(setq org-capture-templates
      '(("t" "Todo" item (file+headline org-default-notes-file "TODO")
         "[ ] %i %?\n")))
