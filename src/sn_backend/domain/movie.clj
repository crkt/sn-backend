(ns sn-backend.domain.movie
  (:gen-class))

;;@ TODO
;; Create a map of fields for the movie.
;; Parse json -> movie map
;; Create a validation function for a movie.


;; defrecord Movie,
;; The movie with corresponding fields
;; https://clojuredocs.org/clojure.core/defrecord
(defrecord Movie [title year runtime genre])
