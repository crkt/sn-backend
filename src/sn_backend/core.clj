(ns sn-backend.core
  (:require [compojure.core :refer :all]
            [compojure.route :as route]
            [ring.util.response :refer :all]
            [ring.middleware.json :refer :all]
            [ring.middleware.reload :refer :all]
            [ring.middleware.stacktrace :refer :all])
  (:gen-class))


(defroutes handler
  (GET "/" [] (response {:name "Hello"}))
  (POST "/" [name] (response {:name name}))
  (route/not-found "The requested resource does not exist"))


(def app
  (-> 
   handler
   (wrap-json-body {:keywords? true :bigdecimals? true})
   (wrap-json-response)
   (wrap-reload '[sn-backend.core])
   (wrap-stacktrace)))




