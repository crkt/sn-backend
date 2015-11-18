(ns sn-backend.db
  (:require [korma.core :refer :all :rename {update sql-update}]
            [korma.db :refer :all])
  (:gen-class))

;;*****************************************************
;; Movie Record
;;*****************************************************
(defrecord Movie [id title year runtime genres])

;;*****************************************************
;; User Record
;;*****************************************************
(defrecord User [id email password])

;;*****************************************************
;; Database connection config
;;*****************************************************
(defdb ^{:dynamic false} db (mysql {:db "sortnight"
                       :user "sortnight"
                       :password "secret"
                       :host "localhost"
                       :port "3306"
                       :delimiters ""}))

;;*****************************************************
;; Base queries
;;*****************************************************

;; genres-q : vector -> vector
(defn genres-q 
  "Get all id's for genres specified. Returns a vector of the ids
  [crime drama action adventure] -> [1 2 3 4]"
  [genres]
  (into [] (map (fn [x]
                  (:id x)) (select "genre" 
                  (fields :id)
                  (where {:genre.genre [in genres]})))))

;; movie-genres : vector -> vector
(defn movie-genres-q
  "Returns movie id's in a vector
  [crime drama] -> [1 2 3] (Consists of movie_ids)
  that have the genres specified."
  [genres]
  (into [] (map (fn [x]
                  (:movie_id x)) (select "movie_genre"
                        (fields :movie_id)
                        (where {:movie_genre.genre_id [in (genres-q genres)]})))))

;; all-movie-genres : number -> seq({:genre ""},{:genre ""})
(defn all-movie-genres
  "Get the movies genres"
  [id]
  (into [] (map (fn [x]
                  (:genre x)) 
                (select "genre"
                        (fields :genre)
                        (join "movie_genre" (= :movie_genre.movie_id id))
                        (where (= :genre.id :movie_genre.genre_id))))))

;;*****************************************************
;; Record creation
;;*****************************************************
;; create-movie : {:key val...} -> Movie Record
(defn create-movie 
  "Creates a movie record from a hash of movie values"
  [row]
  (let [genres (all-movie-genres (:id row))
        m (->Movie (:id row)
                   (:title row)
                   (:year row)
                   (:runtime row)
                   genres)]
    m))

;; create-user : {:key val...} -> User Record
(defn create-user
  "Creates a user record from a hash of user values"
  [row]
  (let [id (:id row)
        email (:email row)
        password (:password row)
        u (->User id email password)]
    u))


;;*****************************************************
;; User queries
;;*****************************************************
;; PASSWORD(password)
(defn insert-user 
  [email password]
  (insert "user"
          (values {:email email :password password})))

(defn select-user-id
  [id]
  (select "user"
          (fields :email :id)
          (where (= :id id))))

(defn select-user-email
  [email password]
  (select "user"
          (fields :email :id)
          (where (and (= :email email)
                      (= :password password)))))

(defn does-user-exist?
  [email]
  (not (nil? (first (select "user"
                            (where (= :email email)))))))

;;*****************************************************
;; Search queries
;;*****************************************************

(defn not-nil? 
  [x]
  (not (nil? x)))


;; filter nil values in the future...?
(defn create-constraints [& {:keys [genres runtime year title] :as args}]
  (into {} (map (fn [x]
                  (cond
                   (and (= (key x) :genres) (not-nil? (val x))) {:id ['in (movie-genres-q (val x))]}
                   (and (= (key x) :runtime) (not-nil? (val x))) {:runtime ['= (val x)]}
                   (and (= (key x) :year) (not-nil? (val x))) {:year ['= (val x)]}
                   (and (= (key x) :title) (not-nil? (val x))) {:title ['like (val x)]})) 
                args)))

(defn search-movie [& {:keys [genres runtime year title]}]
  (map create-movie (select "movie"
                            (where (create-constraints :genres genres :runtime runtime :year year :title title)))))


