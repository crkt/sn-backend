(ns sn-backend.search
  (:require [sn-backend.db :as db])
  (:gen-class))

(defn genre-id
  [genre]
  (:id genre))

(defn genre-ids 
  [genres]
  (into [] (map genre-id genres)))


(defn search-movie 
  [body]
  (let [genres (:genres body)
        runtime (:runtime body)
        year (:year body)
        title (:title body)]
    (db/search-movie :genres genres :runtime runtime :year year :title title)))

;; user search
(defn search-movie-user
  [body]
  (let [genres (:genres body)
        runtime (:runtime body)
        year (:year body)
        title (:title body)
        user (:user body)]
    (db/search-movie-user user :genres genres :runtime runtime :year year :title title)))

(defn random-movie
  []
  (db/random-movie))



