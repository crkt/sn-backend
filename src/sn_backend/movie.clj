(ns sn-backend.movie
  (:require [sn-backend.db :as db])
  (:gen-class))

;; update rating for user
(defn update-rating
  [body]
  (let [movie_id (:movie body)
        rating (:rating body)
        user_id (:user_id body)]
    (if (db/has-user-rated-movie? movie_id user_id)
      (db/update-rating movie_id rating user_id)
      (db/insert-rating movie_id rating user_id))))

(defn all-genres
  []
  (db/get-all-genres))

(defn all-movies
  []
  (db/get-all-movies))
  
(defn get-user-rated-movies
  [body]
  (db/get-rated-movies (:user body)))

(defn get-movie
  [body]
  (db/get-movie (:movie body)))

(defn register-movie
	[body]			 
	(db/insert-movie (rename-keys body {:plot :description, :directors :director, :writers :writer, :mature :mature_rating_id})))
	