(ns sn-backend.core
  (:require [compojure.core :refer :all]
            [compojure.route :as route]
            [ring.util.response :refer :all]
            [ring.middleware.json :refer :all]
            [ring.middleware.reload :refer :all]
            [ring.middleware.stacktrace :refer :all]
            [ring.adapter.jetty :refer :all]
            [sn-backend.search :as search]
            [sn-backend.user :as user])
  (:gen-class))


;; handle-request : map{} function number number -> http response
(defmacro handle-request 
  "This macro is for returning a response to a client. Expects a request map, a function to handle the request map and an http error code if the request fails and an http ok code if the request is good."
  [req f error ok]
  `(let [res# (~f (:body ~req))]
     (if  (contains? res# :error)
       (status (response res#) ~error)
       (status (response res#) ~ok))))


(defn search-for-movie 
  "Searches for a movie in the database with a request object.
  The response is an json array of movie objects."
  [req]
  (handle-request req search/search-movie 400 200))

(defn create-user
  "Creates a user in the database, if the email is taken returns an error object. Refer to the user file to see what it contains."
  [req]
  (handle-request req user/register-user 400 201))

(defn login-user
  "Logins a user, returns error if the user doesn't exist"
  [req]
  (handle-request req user/login-user 400 202))

;; handler : nil -> response
;; the routing of the application
;; returns a response depending on the requested resource.
(defroutes  handler
  (GET "/" [] (response {}))
  (PUT "/search/movie" request
       (search-for-movie request))
  (POST "/user/register" request
        (create-user request))
  (PUT "/user/login" request
       (login-user request))
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


