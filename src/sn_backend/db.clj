(ns sn-backend.db
  (:require [korma.core :refer :all]
            [korma.db :refer :all]
            [clojure.string :refer :all :as string]
            [clojure.java.jdbc :refer :all :as jdbc])
  (:gen-class))

;; Movie record
(defrecord Movie [id title year runtime genres])

;; Creates a global database variable.
;; earmuffs since it's global.
(defdb *db (mysql {:db "sortnight"
                   :user "sortnight"
                   :password "secret"
                   :host "localhost"
                   :port "3306"
                   :delimiters ""}))



;;
;;         "select * from movie where id in "
;;                  "(select movie_id from movie_genre where genre_id in"
;;
;;                  "(select id from genre where genre in ("
;;
;; (where {:email.id [in (subselect email
;;                          (fields :id)
;;                          (where {:sent true})
;;
;;

(defn search-movie
  [{:keys [genres year runtime]}]
  (select "movie"
            (where {:movie.id [in (subselect "movie_genre"
                                             (fields :movie_id)
                                             (where {:genre_id [in (subselect "genre"
                                                                              (fields :genre)
                                                                              (where {:genre.genre [in genres]}))]}))]})))
