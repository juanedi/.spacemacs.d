(defvar theming-customizations--cycle-index 0)

(defun theming-customizations--cycle ()
  (interactive)
  (let*
      ((custom-safe-themes t)
       (all-themes (custom-available-themes))
       (current-index (or theming-customizations--cycle-index 0))
       (next-theme (nth current-index all-themes))
       )
    (progn
      (message "Loaded theme: %s" next-theme)
      (load-theme next-theme)
      (setq theming-customizations--cycle-index (mod (+ 1 theming-customizations--cycle-index) (length all-themes))))))

(defun theming-customizations--cycle-reset ()
  (setq theming-customizations--cycle-index 0))
