(ns sn-backend.core
  (:require [compojure.core :refer :all]
            [compojure.route :as route]
            [ring.util.response :refer :all]
            [ring.middleware.json :refer :all]
            [ring.middleware.reload :refer :all]
            [ring.middleware.stacktrace :refer :all]
            [ring.adapter.jetty :refer :all]
            [sn-backend.search :as search])
  (:gen-class))


;; search-for-movie : request map (json) -> response (json)
(defn search-for-movie 
  "Searches for a movie in the database with a request object.
  The response is an json array of movie objects."
  [req]
  (let [body (:body req)]
    (search/search-movie body)))

;; handler : nil -> response
;; the routing of the application
;; returns a response depending on the requested resource.
(defroutes  handler
  (GET "/" [] (response {}))
  (PUT "/search/movie" request
       (response (search-for-movie request)))
  (route/not-found "The requested resource does not exist"))


;; app : nil -> nil
;; the app to run on the server
;; uses ring and compojure handlers to handle routing.
(def app
  "The app handler for the server, wraps requests and respones."
  (-> 
   (wrap-json-response handler)
   (wrap-json-body {:keywords? true :bigdecimals? true})
   (wrap-reload '[sn-backend.core])
   (wrap-stacktrace)))


(defn -main 
  "Main method for the server, runs a jetty server on port 3000 with our app handler"  []
  (run-jetty #'app {:port 3000}))


