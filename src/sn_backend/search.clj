(ns sn-backend.search
  (:require [sn-backend.db :as db])
  (:gen-class))

;;*****************************************************
;; Search
;; This file handles the search related requests.
;;*****************************************************

;; genre-id : {:id :genre} -> id
(defn genre-id
  "Gets the id of the genre"
  [genre]
  (:id genre))

;; genre-ids : [{genre},{genre} -> [1,2,3]
(defn genre-ids 
  "Turns a map of genres into a vector of genre ids."
  [genres]
  (into [] (map genre-id genres)))

;; search-movie : & {:genres :runtime :year :title} -> [{movie},{movie}]
(defn search-movie 
  "Searches for a movie, all keys are optional. If no key is supplied it's equivalent to searching for all movies."
  [body]
  (let [genres (:genres body)
        runtime (:runtime body)
        year (:year body)
        title (:title body)]
    (db/search-movie :genres genres :runtime runtime :year year :title title)))

;; search-movie-user : {:user & :genres :runtime :year :title} -> [{movie},{movie}]
(defn search-movie-user
  "Expects a user key to perform a search with, this will perform the search and get the users rating of movies in the result movies."
  [body]
  (let [genres (:genres body)
        runtime (:runtime body)
        year (:year body)
        title (:title body)
        user (:user body)]
    (db/search-movie-user user :genres genres :runtime runtime :year year :title title)))

;; random-movie : nil -> {movie}
(defn random-movie
  "Randoms a movie in the database."
  []
  (db/random-movie))



