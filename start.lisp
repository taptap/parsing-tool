#!/usr/bin/sbcl --script 
(unless (equalp
         (lisp-implementation-type)
         "SBCL")
  (write-line "Sorry, currently SBCL is required to operate this script")
  (quit))

(load #P"/etc/sbclrc")
(load (merge-pathnames (user-homedir-pathname) #P"/.sbclrc")

(load #P"parser.asd")
(let ((*standard-output* nil))
  (asdf:operate 'asdf:load-op 'parsing-tools))
(handler-case
    (user:capture (cadr sb-ext:*posix-argv*))
  (SB-SYS:INTERACTIVE-INTERRUPT ()
      (write-line "User interrupt, exitting")))
