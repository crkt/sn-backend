(ns sn-backend.db
  (:require [korma.core :refer :all :rename {update sql-update}]
            [korma.db :refer :all])
  (:gen-class))

;;*****************************************************
;; Movie Record
;;*****************************************************
(defrecord Movie [id title year runtime genres])

;;*****************************************************
;; Database connection config
;;*****************************************************
(defdb ^{:dynamic false} db (mysql {:db "sortnight"
                       :user "sortnight"
                       :password "secret"
                       :host "localhost"
                       :port "3306"
                       :delimiters ""}))

;;*****************************************************
;; Base queries
;;*****************************************************

;; genres-q : vector -> vector
(defn genres-q 
  "Get all id's for genres specified. Returns a vector of the ids
  [crime drama action adventure] -> [1 2 3 4]"
  [genres]
  (into [] (map (fn [x]
                  (:id x)) (select "genre" 
                  (fields :id)
                  (where {:genre.genre [in genres]})))))

;; movie-genres : vector -> vector
(defn movie-genres-q
  "Returns movie id's in a vector
  [crime drama] -> [1 2 3] (Consists of movie_ids)
  that have the genres specified."
  [genres]
  (into [] (map (fn [x]
                  (:movie_id x)) (select "movie_genre"
                        (fields :movie_id)
                        (where {:movie_genre.genre_id [in (genres-q genres)]})))))

;; all-movie-genres : number -> seq({:genre ""},{:genre ""})
(defn all-movie-genres
  "Get the movies genres"
  [id]
  (into [] (map (fn [x]
                  (:genre x)) 
                (select "genre"
                        (fields :genre)
                        (join "movie_genre" (= :movie_genre.movie_id id))
                        (where (= :genre.id :movie_genre.genre_id))))))

;;*****************************************************
;; Movie Record creation
;;*****************************************************
;; create-movie : {:key val...} -> Movie Record
(defn create-movie 
  "Creates a movie record from a hash of movie values"
  [row]
  (let [genres (all-movie-genres (:id row))
        m (->Movie (:id row)
                   (:title row)
                   (:year row)
                   (:runtime row)
                   genres)]
    m))

;;*****************************************************
;; User queries
;;*****************************************************
;; PASSWORD(password)
(defn create-user-with [body]
  (insert "user"
          (values {:email (:email body)}
                  {:password (:password body)})))


;;*****************************************************
;; Search queries
;;*****************************************************

;; all-movies-with-genres : vector -> seq(movie)
(defn all-movie-with-genres 
  "Returns movie objects with the genres specified.
  [crime drama] -> (#movieObj #movieObj)"
  [genres]
  (map create-movie (select "movie"
                            (where {:id [in (movie-genres-q genres)]}))))

;; all-movie-with-runtime : number -> seq(movie)
(defn all-movie-with-runtime
  "searches for movie with runtime"
  [runtime]
  (map create-movie (select "movie"
                            (where (< :runtime runtime)))))

;; all-movie-with-year : number -> seq(movie)
(defn all-movie-with-year
  "searcher for a movie with a year"
  [year]
  (map create-movie (select "movie"
                            (where (= :year year)))))


(defmacro movie-q [body]
  `(select "movie"
           (where (and ~@body))))

;; all-movie-with-attributes : vector, number, number -> seq(movie)
(defn movie-with-attributes
  "Searches with all attributes"
  [& {:keys [genres runtime year]}]
  (map create-movie (movie-q ({:id [in (movie-genres-q genres)]}
                              (= :runtime runtime)
                              (= :year year))
                             )))
