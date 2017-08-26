(defun timeclock//aggregate-entry-length (mapping)
  (let* ((activity-name (car mapping))
         (activity-entries (cdr mapping))
         (seconds (seq-reduce
                   (lambda (r e) (+ r (timeclock-entry-length e)))
                   activity-entries
                   0)))
    (cons activity-name seconds)))

(defun timeclock//seconds-by-activity (day-string)
  (let* ((today-entries (cddr (assoc day-string (timeclock-day-alist))))
         (entries-by-activity (seq-group-by 'third today-entries)))
    (seq-map 'timeclock//aggregate-entry-length entries-by-activity)))

(defun timeclock/current-activity ()
  (interactive)
  (if (equal (car timeclock-last-event) "i")
      (nth 2 timeclock-last-event)))

(defun timeclock/in ()
  (interactive)
  (if (eq (timeclock/current-activity) nil)
      (call-interactively 'timeclock-in)
    (call-interactively 'timeclock-change)))

(defun timeclock/out ()
  (interactive)
  (timeclock-out nil "" nil))

(defun timeclock/print-day-report ()
  (interactive)
  (let* ((_ (timeclock-reread-log))
         (today (format-time-string "%Y/%m/%d"))
         (today-summary (timeclock//seconds-by-activity today))
         (current-activity (timeclock/current-activity))
         (format-entry (lambda (entry)
                         (concat " - "
                                 (timeclock-seconds-to-string (cdr entry)) " hs "
                                 "on " (first entry)
                                 (if (string-equal current-activity (first entry)) " (current)" "")))))
    (message
     (if (seq-empty-p today-summary)
         "No activity has been recorded today yet"
       (concat
        "Report for " today "\n\n"
        (s-join "\n" (seq-map format-entry today-summary))
        "\n\n"
        "Total worked time: " (timeclock-workday-elapsed-string) " hs")))))
