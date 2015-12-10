(ns sn-backend.add-movies
	(:require [sn-backend.db :as db])
	(:gen-class))
	
(defn read-movies []
	(let [movies (db/read-from-file-with-trusted-content "movies.clj")]
		(map db/insert-movie movies)))	
	