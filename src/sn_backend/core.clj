(ns sn-backend.core
  (:require [compojure.core :refer :all]
            [compojure.route :as route]
            [ring.util.response :refer :all]
            [ring.middleware.json :refer :all]
            [ring.middleware.reload :refer :all]
            [ring.middleware.stacktrace :refer :all]
            [ring.adapter.jetty :refer :all]
            [sn-backend.db :as db]
            [sn-backend.domain.movie :refer :all])
  (:gen-class))

;; @TODO
;; Abstract the register function to be handeld in a different scope?
;; Add validation of the Movie model
;; Add all the routes needed for the application
;; Add search possibilites

;; register-movie : request map (json) -> response (json)
;; takes a json request with movie data and creates a map of it
;; to the register it in the database.
;;                   (get-in req [:body :title])
;;                   (get-in req [:body :year])
;;                   (get-in req [:body :runtime])
;;                   (get-in req [:body :genres])


;; search-for-movie : request map (json) -> response (json)
;; search for a movie with a json body of attributes to search for
;; the response is a json array of all the results.
;; {movies: [m1,m2,m3........m100]};
(defn search-for-movie [req]
  (println (get-in req [:body :genres]))
  (println "result from db" (db/search-for-genre (first (get-in req [:body :genres]))))
  (response (db/search-for-genre (first (get-in req [:body :genres])))))

;; handler : void -> response
;; the routing of the application
;; returns a response depending on the requested resource.
(defroutes handler
  (GET "/" [] (response {}))
  (GET "/movie" [] (response (db/list-all)))
  (PUT "/search/movie" request
       (search-for-movie request))
  (route/not-found "The requested resource does not exist"))


;; app : void -> void
;; the app to run on the server
;; uses ring and compojure handlers to handle routing.
(def app
  (-> 
   (wrap-json-response handler)
   (wrap-json-body {:keywords? true :bigdecimals? true})
   (wrap-reload '[sn-backend.core])
   (wrap-stacktrace)))


(defn -main []
  (run-jetty #'app {:port 3000}))


