(ns sn-backend.movie
  (:require [sn-backend.db :as db]
            [clojure.set :refer :all])
  (:gen-class))

;;*****************************************************
;; Movie
;; This file handles the movie related requests.
;;*****************************************************


;; update-rating : {:movie :rating :user_id} -> movie_id
(defn update-rating
  "Updates a rating of a movie. Expects a movie id, a rating value and a user id."
  [body]
  (let [movie_id (:movie body)
        rating (:rating body)
        user_id (:user_id body)]
    (if (db/has-user-rated-movie? movie_id user_id)
      (db/update-rating movie_id rating user_id)
      (db/insert-rating movie_id rating user_id))))

;; all-genres : nil -> [{genre},{genre}]
(defn all-genres
  "Gets all the genres in the database"
  []
  (db/get-all-genres))

;; all-movies : nil -> [{movie},{movie}]
(defn all-movies
  []
  (db/get-all-movies))
  
;; get-user-rated-movies : {:user} -> [{movie},{movie}]
(defn get-user-rated-movies
  "Gets the users rated movies."
  [body]
  (db/get-rated-movies (:user body)))

;; get-movie : {:movie, (optional :user)} -> {movie}
(defn get-movie
  "Get's a movie if a user key is supplied it will return the users rating of the movie."
  [body]
  (let [movie_id (:movie body)]
    (if (contains? body :user)
      (db/get-movie-with-user-rating movie_id (:user body))
      (db/get-movie movie_id))))

;; register-movie : {:title :description :picture :writers :directors :mature :runtime :year} -> generated_key
(defn register-movie
  "Registers a movie, renames the keys into the database fields.
  Returns the generated id of the insert. Will also create the genres if they do not exists."
  [body]
  (db/insert-movie (rename-keys body {:plot :description,
                                      :writers :writer,
                                      :directors :director,
                                      :mature :mature_rating_id})))
