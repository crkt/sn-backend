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
  (let [genres (genre-ids (:genres body))
        runtime (:runtime body)
        year (:year body)
        title (:title body)]
    (db/search-movie :genres genres :runtime runtime :year year :title title)))



