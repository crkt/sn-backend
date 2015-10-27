(ns sn-backend.core
  (:require [compojure.core :refer :all]
            [compojure.route :as route]
            [ring.util.response :refer :all]
            [ring.middleware.json :refer :all]
            [ring.middleware.reload :refer :all]
            [ring.middleware.stacktrace :refer :all])
  (:gen-class))

;; @TODO
;; Abstract the register function to be handeld in a different scope?
;; Add validation of the Movie model
;; Add all the routes needed for the application
;; Add search possibilites

;; register-movie : request map (json) -> response (json)
;; takes a json request with movie data and creates a map of it
;; to the register it in the database.
(defn register-movie [req]
  (let [title (get-in req [:body :title])
        year (get-in req [:body :year])
        runtime (get-in req [:body :runtime])
        genre (get-in req [:body :genre])]
    (response {:title title :year year :runtime runtime :genre genre})))

;; search-for-movie : request map (json) -> response (json)
;; search for a movie with a json body of attributes to search for
;; the response is a json array of all the results.
;; {movies: [m1,m2,m3........m100]};
(defn search-for-movie [req]
  (response {:title "ASDF" :year "1993" :runtime "123" :genre "[\"Action\",\"Drama\""}))

;; handler : void -> response
;; the routing of the application
;; returns a response depending on the requested resource.
(defroutes handler
  (GET "/" [] (response {}))
  (POST "/movie" request
        (register-movie request))
  (PUT "/movie" request
       (search-for-movie request))
  (route/not-found "The requested resource does not exist"))


;; app : void -> void
;; the app to run on the server
;; uses ring and compojure handlers to handle routing.
(def app
  (-> 
   handler
   (wrap-json-body {:keywords? true :bigdecimals? true})
   (wrap-json-response)
   (wrap-reload '[sn-backend.core])
   (wrap-stacktrace)))





