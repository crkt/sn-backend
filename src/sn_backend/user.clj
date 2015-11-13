(ns sn-backend.user
  (:require [sn-backend.db :as db])
  (:gen-class))



(defn register-user
  [body]
  (let [email (:email body)
        password (:password body)    
        id (:generated_key (db/insert-user email password))]
    (db/select-user-id id)))

(defn login-user
  [body]
  (let [email (:email body)
        password (:password body)]))
