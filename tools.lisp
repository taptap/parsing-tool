(in-package :parsing-tool)

(defparameter *database-path*  (merge-pathnames *default-pathname-defaults* #P"./database.sqlite"))

(defun make-diary-url (username base-url)
  (concatenate 'string "http://" username "." base-url "/"))

(defun make-user-info-url (username base-url)
  (concatenate 'string "http://" base-url "/users/" username "/"))

(defmacro referer-query (referer useragent usernames)
  (let ((uname (gensym)))
    `(dolist (,uname ,usernames)
       (drakma:http-request (make-diary-url ,uname) :user-agent ,useragent
			    :additional-headers '(("Referer" . ,referer))))))

(defun replace-all (string char replacement-string)
  (let ((list (coerce string 'list)))
    (with-output-to-string (out)
      (dolist (c list)
	(if (char-equal c char)
	    (write-string replacement-string out)
	    (write-char c out))))))

(defun delete-every (char-list string)
  (let ((clean-string string))
    (dolist (c char-list)
      (setf clean-string (delete c clean-string)))
    clean-string))

(defun parse-date (date)
  (destructuring-bind (year month day)
      (split-sequence #\- date)
    (encode-timestamp (read-from-string year)
                      (read-from-string month)
                      (read-from-string day))))

(defun format-date ()
  (macrolet ((format-2-digits (name)
	       `(if (= (mod ,name 10) ,name)
		    (format nil "0~A" ,name)
		    (format nil "~A" ,name))))
    (multiple-value-bind (raw-seconds raw-minutes raw-hours
				      raw-day raw-month year)
	(get-decoded-time)
      (let ((seconds (format-2-digits raw-seconds))
	    (minutes (format-2-digits raw-minutes))
	    (hours (format-2-digits raw-hours))
	    (day (format-2-digits raw-day))
	    (month (format-2-digits raw-month)))
	(format nil "~A-~A-~A ~A:~A:~A"
		day
		month
		year
		hours
		minutes
		seconds)))))

(defun normalize-interest-name (name)
  (string-downcase (delete-every '(#\. #\, #\! #\; #\:) name)))
