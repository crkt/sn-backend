(ns sn-backend.search
  (:require [sn-backend.db :as db])
  (:gen-class))



(defn not-nil? [x]
  (not (nil? x)))


(defn search-movie 
  [body]
  (let [genres (:genres body)
        runtime (:runtime body)
        year (:year body)]
    (cond
     (and (not-nil? genres) (not-nil? runtime) (not-nil? year)) 
     (db/movie-with-attributes :genres genres, :runtime runtime, :year year)
     (and (not-nil? genres) (not-nil? runtime) (nil? year))
     (db/movies-with-attributes :genres genres :runtime runtime)
     (and (not-nil? genres) (nil? runtime) (nil? year))
     (db/movies-with-attributes :genres genres)
     (and (nil? genres) (not-nil? runtime) (not-nil? year))
     (db/movies-with-attributes :runtime runtime :year year)
     (and (nil? genres (not-nil? runtime) (nil? year)))
     (db/movies-with-attributes :runtime runtime)
     (and (nil? genres) (nil? runtime) (not-nil? year))
     (db/movies-with-attributes :year year))))
