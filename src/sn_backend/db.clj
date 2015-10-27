(ns sn-backend.db
  (:require [sn-backend.domain.movie :as movie]
            [clojure.java.jdbc :refer :all :as jdbc])
  (:gen-class))

;; How to write queries 
;; https://github.com/clojure/java.jdbc
;; https://en.wikibooks.org/wiki/Clojure_Programming/Examples/JDBC_Examples
;; @TODO
;; Add the JDBC driver
;; Create a Movie Domain map/vector

;; Creates a global database variable.
;; earmuffs since it's global.
(let [db-host "localhost"
      db-port 3306
      db-name "sortnight"]
  (def *db* {:classname "com.mysql.jdbc.Driver"
           :subprotocol "mysql"
           :subname (str "//" db-host ":" db-port "/" db-name)
           :user "phcr"
           :password "awt800"}))

;; Test code for the database.
;; Will be removed later.
(defn list-all []
  (with-db-connection [db-con *db*]
    (jdbc/query db-con ["select * from movie"])))


;; add-movie : map -> boolean
;; adds a movie to the database to persist it.
;; returns a boolean if it was successfull or not.
(defn add-movie [movie])

;; search-movie : map -> movies
;; searches the database for movies with the attributes in the search.
;; returns the result of all the movie found.
(defn search-movie [attributes])

;; delete-movie : string -> boolean
;; delets the movie in the database with the id supplied.
;; returns a boolean if it was successfull or not.
(defn delete-movie [id])

;; create-user-account : user -> boolean
;; takes information about a user and adds them to the database
;; returns a boolean if it was successfull or not.
(defn create-user-account [user])


;; delete-user-account : string -> boolean
;; removes a user from the database
;; returns a boolean if it was successfull or not.
(defn delete-user-account [id])


;; add-user-to-group : string, string -> boolean
;; takes a user id and group id and creates a relation 
;; between the user and the group, so the user belongs to the group.
(defn add-user-to-group [user, group])
