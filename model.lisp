(in-package :parsing-tool)

(defclass user ()
  ((name          :accessor user-name          :col-type (varchar 512) :unique t :initarg :name)
   (display-name  :accessor user-display-name  :col-type (or db-null (varchar 512)) :initform :null)
   (date-created  :accessor user-date-created  :col-type (or db-null timestamp)     :initform :null)
   (email         :accessor user-email         :col-type (or db-null (varchar 512)) :initform :null)
   (date-of-birth :accessor user-date-of-birth :col-type (or db-null timestamp)     :initform :null)
   (gender        :accessor user-gender        :col-type (or db-null smallint)      :initform :null)
   (country       :accessor user-country       :col-type (or db-null (varchar 512)) :initform :null)
   (city          :accessor user-city          :col-type (or db-null (varchar 512)) :initform :null)
   (last-active   :accessor user-last-active   :col-type (or db-null timestamp)     :initform :null)
   (interests     :accessor user-interests :initform '()))
  (:keys name)
  (:metaclass dao-class)
  (:table-name users))

(defclass interest ()
  ((name :col-type (varchar 1024) :unique t :initarg :name))
  (:keys name)
  (:metaclass dao-class)
  (:table-name interests))

(defclass activity ()
  ((user-name :col-type (or db-null (varchar 512)) :initform :null :initarg :user-name)
   (time      :col-type (or db-null timestamp)     :initform :null :initarg :time))
  (:keys user-name)
  (:metaclass dao-class))

(defclass community ()
  ((name         :col-type (varchar 512) :unique t)
   (display-name :col-type (or db-null (varchar 512)) :initform :null)
   (date-created :col-type (or db-null timestamp)     :initform :null)
   (last-active  :col-type (or db-null timestamp)     :initform :null))
  (:keys name)
  (:metaclass dao-class)
  (:table-name communities))

(defclass user-interest-map ()
  ((user-name     :col-type (varchar 512)  :initarg :user-name)
   (interest-name :col-type (varchar 1024) :initarg :interest-name))
  (:keys user-name interest-name)
  (:metaclass dao-class))

(defclass site-online-log ()
  ((time    :col-type timestamp)
   (online  :col-type integer)
   (offline :col-type integer))
  (:metaclass dao-class)
  (:keys time))