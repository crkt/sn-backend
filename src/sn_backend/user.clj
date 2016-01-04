(ns sn-backend.user
  (:require [sn-backend.db :as db]
            [dire.core :refer [with-handler! with-postcondition!]])
  (:gen-class))


;;*****************************************************
;; Movie
;; This file handles the user related requests.
;;*****************************************************

;; register-user : {:email :password :username} -> {:id :username}
(defn register-user
  "Registers a user in the database. Will catch the sql exception if the user alread exists. Or the email."
  [body]
  (let [email (:email body)
        password (:password body)
        name (:username body)
        id (:generated_key (db/insert-user email name password))]
    (into {} (db/select-user-id id))))

;; login-user : {:username :password} -> {:id :username}
(defn login-user
  "Tries to login the user and returns the id and username of the user."
  [body]
  (let [name (:username body)
        password (:password body)]
    (into {} (db/select-user-name name password))))


;; This catches the Duplicate entry expection in the SQL.
(with-handler! #'register-user
  "Duplicate entry exception"
  java.sql.SQLException
  (fn [e body]
    (if (= (.getErrorCode e) 1062)
      {:error "User already exists" :field "email"}
      e)))

;; This is tested after the functions has been run, to check if the user already exists.
(with-postcondition! #'login-user
  "Check that the user exists"
  :exists
  (fn [result]
    (not (nil? (first result)))))

;; If the user doesn't exist we throw an exception
(with-handler! #'login-user
  "Returns an error map for the login-user function if the postcondition fails"
  {:postcondition :exists}
  (fn [e result]
    {:error "User doesn't exist" :field "username"}))

