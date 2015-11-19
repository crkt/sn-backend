(ns sn-backend.user
  (:require [sn-backend.db :as db]
            [dire.core :refer [with-handler! with-postcondition!]])
  (:gen-class))



(defn register-user
  [body]
  (let [email (:email body)
        password (:password body)    
        id (:generated_key (db/insert-user email password))]
    (into {} (db/select-user-id id))))

(defn login-user
  [body]
  (let [email (:email body)
        password (:password body)]
    (into {} (db/select-user-email email password))))


(with-handler! #'register-user
  "Duplicate entry exception"
  java.sql.SQLException
  (fn [e body]
    (if (= (.getErrorCode e) 1062)
      {:error "User already exists" :field "email"}
      e)))

(with-postcondition! #'login-user
  "Check that the user exists"
  :exists
  (fn [result]
    (not (nil? (first result)))))

(with-handler! #'login-user
  "Returns an error map for the login-user function if the postcondition fails"
  {:postcondition :exists}
  (fn [e result]
    {:error "User doesn't exist" :field "email"}))

