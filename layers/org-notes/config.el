(setq
 org-blank-before-new-entry (quote ((heading) (plain-list-item)))
 org-todo-keywords
  '((sequence "TODO" "IN-PROGRESS" "|" "DONE"))
 org-capture-templates
 '(("t" "TODO entry" entry (file+headline  "~/Dropbox/Apps/org-notes/agenda.org" "Tasks")
     "** TODO%i %?\n   SCHEDULED: %t\n\n"))
 org-agenda-custom-commands
  '(("c" "Agenda and unschedueld TODOs"
     ((agenda "")
      (todo
       nil                           ; keyword. nil means any state
       ((org-agenda-skip-function    ; filter to determine included entries
         '(org-agenda-skip-entry-if
           'scheduled
           'deadline))))
      ))))
