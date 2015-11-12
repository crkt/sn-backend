(ns sn-backend.search
  (:require [sn-backend.db :as db])
  (:gen-class))



;;
;; base sql ->
;; conditions
;;
;;

(defn not-nil? [x]
  (not (nil? x)))


(defn search-movie [body]
  (let [genres (:genres body)
        runtime (:runtime body)
        year (:year body)]
    (cond
     (and (not-nil? genres) (not-nil? runtime) (not-nil? year)) (db/movie-with-attributes :genres genres, :runtime runtime, :year year))))
