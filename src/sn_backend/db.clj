(ns sn-backend.db
  (:require [sn-backend.domain.movie :refer :all]
            [clojure.string :refer :all :as string]
            [clojure.java.jdbc :refer :all :as jdbc])
  (:gen-class))

;; Creates a global database variable.
;; earmuffs since it's global.
(let [db-host "localhost"
      db-port 3306
      db-name "sortnight"]
  (def *db* {:classname "com.mysql.jdbc.Driver"
           :subprotocol "mysql"
           :subname (str "//" db-host ":" db-port "/" db-name)
           :user "sortnight"
           :password "secret"}))

(defn get-movie-genres 
  "get's all the genres of a movie, returns a sequence of genres
  [{:genre action :genre drama}]"
  [id]
  (with-db-connection [db-con *db*]
    (jdbc/query db-con ["select genre from genre join (select genre_id from movie_genre where movie_id=?) as gm on (gm.genre_id = genre.id)" id])))

(defn params-sql-query 
  "Creates a sql vector that the jdbc expects, 
  changes all symbols into strings in the parameters. e.g
  [sql params]
  [select * from movie where id = ? and name = ? 1 Park]" 
  [sql params]
  (into [] (flatten (cons sql (map str params)))))

(defn add-args-to-query 
  "Adds all the ? needed in the preparedStatement, lst is the arguments to count
  Since prepared statements are not 'dynamic' this is required. You must know all
  of the ? in advance."
  [lst]
  (clojure.string/join ", " (take (count lst) (repeat "?"))))

(defn create-movie 
  "creates a movie record with a movie row from the database"
  [row]
  (let [genres (get-movie-genres (:id row))
        m (->Movie (:id row)
                   (:title row)
                   (:year row)
                   (:runtime row)
                   genres)]
    m))

(defn search-for-genres 
  "Searches for movies with the genres given.
   Expects a vector of genres, [action drama]"
  [genres]
  (with-db-connection [db-con *db*]
    ;; the query is a sql vector query [sql-query & params]
    (let [query (params-sql-query
                 (str
                  "select * from movie where id in "
                  "(select movie_id from movie_genre where genre_id in "
                  "(select id from genre where genre in (" 
                  (add-args-to-query genres) ")))")
                 genres)
          ;; store the result in the rs
          rs (jdbc/query db-con query)]
      ;; create movies of all the rows retrieved from the database
      (println query)
      (map create-movie rs))))


(defn search-movie 
  "Unsupported function"
  [attributes])
