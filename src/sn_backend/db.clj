(ns sn-backend.db
  (:require [korma.core :refer :all :rename {update sql-update}]
            [korma.db :refer :all])
  (:gen-class))

;;*****************************************************
;; Movie Record
;;*****************************************************
(defrecord Movie [id title plot picture year runtime genres rating characters writers directors stars matureRating])

;;*****************************************************
;; User Record
;;*****************************************************
(defrecord User [id username email password])

;;*****************************************************
;; Rating Record
;;*****************************************************
(defrecord Rating [average votes userRating])

;;*****************************************************
;; Read from a file
;;*****************************************************
(defn read-from-file-with-trusted-contents [filename]
  (with-open [r (java.io.PushbackReader.
                 (clojure.java.io/reader filename))]
    (binding [*read-eval* false]
      (read r))))


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
                        (where {:movie_genre.genre_id [in genres]})))))

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
 
(defn get-movie-rating
  [movie_id]
  (into {} (select "avg_rating"
                   (fields :rating :nr_votes)
                   (where (= :movie_id movie_id)))))

(defn get-movie-rating-user
  [user_id movie_id]
  (let [avg_rating (get-movie-rating movie_id)
        user_rating  (into {} (select "rating"
                                      (fields [:rating :user_rating])
                                      (where {:user_id [= user_id]
                                              :movie_id [= movie_id]})))]
    (conj avg_rating user_rating)))

;;*****************************************************
;; Record creation
;;*****************************************************
;; create-movie : {:key val...} -> Movie Record
(defn create-movie 
  "Creates a movie record from a hash of movie values"
  [row]
  (let [genres (all-movie-genres (:id row))
        rating (get-movie-rating (:id row))
        m (->Movie (:id row)
                   (:title row)
                   (:description row)
                   (:picture row)
                   (:year row)
                   (:runtime row)
                   genres
                   rating
                   (:characters row)
                   (:writer row)
                   (:director row)
                   (:stars row)
                   (:mature_rating_id row))]
    m))

(defn create-movie-user
  "Creates a movie record from a hash of movie values"
  [user row]
  (let [genres (all-movie-genres (:id row))
        rating (get-movie-rating-user user (:id row))
        m (->Movie (:id row)
                   (:title row)
                   (:description row)
                   (:picture row)
                   (:year row)
                   (:runtime row)
                   genres
                   rating
                   (:characters row)
                   (:writer row)
                   (:director row)
                   (:stars row)
                   (:mature_rating_id row))]
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
;; create rating 
(defn create-rating
  [row]
  (let [r (->Rating (:rating row)
                    (:nr_votes row)
                    nil)]
    r))
;; create user-rating
(defn create-user-rating 
  [row]
  (let [r (->Rating (:rating row)
                    (:nr_votes row)
                    (:user_rating row))]
    r))

;;*****************************************************
;; Movie queries
;;*****************************************************
(defn has-user-rated-movie?
  [movie_id user_id]
  (not (nil? (first (select "rating"
                            (where {:user_id [= user_id]
                                    :movie_id [= movie_id]}))))))
									
(defn does-genre-exist? [genre]
	(not (nil? (first (select "genre"
							(where {:genre genre}))))))

(defn update-rating 
  [movie_id rating user_id]  
  (sql-update "rating"
              (set-fields {:rating rating})
              (where {:user_id [= user_id]
                      :movie_id [= movie_id]}))
  (into {} (select "rating"
                   (where {:user_id [= user_id]
                           :movie_id [= movie_id]}))))

(defn insert-rating
  [movie_id rating user_id]
  (insert "rating"
          (values {:user_id user_id :movie_id movie_id :rating rating}))
  (into {} (select "rating"
                   (where {:user_id [= user_id]
                           :movie_id [= movie_id]}))))
						   
(defn insert-genre [genre]
	(if (does-genre-exist? genre)
		nil
		(insert "genre"
			(values {:genre genre}))))        
			
(defn add-genre-to-movie [id genre]
	(insert "movie_genre"
		(values {:movie_id id :genre_id genre})))
						   
(defn insert-movie
  [movie]
  (let [movie_id (:generated-key (insert "movie"
                                         (values {:title (:title movie)
                                                  :description (:description movie)
                                                  :picture (:picture movie)
                                                  :year (:year movie)
                                                  :country_id (:country_id movie)
                                                  :characters (:characters movie)
                                                  :runtime (:runtime movie)
                                                  :mature_rating_id (:mature_rating_id movie)
                                                  :director (:director movie)
                                                  :writer (:writer movie)
                                                  :stars (:stars movie)
                                                  })))]
    (map insert-genre (:genres movie))
    (map (partial add-genre-to-movie movie_id) (genres-q (:genres movie)))
    nil))

(defn get-all-genres
  []
  (select "genre"))

(defn get-all-movies
  []
  (map create-movie (select "movie")))

(defn get-movie
  [id]
  (into {} (map create-movie (select "movie"
                                     (where {:id [= id]})))))

;;*****************************************************
;; Movie generation
;;*****************************************************
(defn read-movies []
  (let [movies (read-from-file-with-trusted-contents "movies.clj")]
    (map insert-movie movies)
    nil))

;;*****************************************************
;; User queries
;;*****************************************************
;; PASSWORD(password)
(defn insert-user 
  [email name password]
  (insert "users"
          (values {:email email :username name :password password})))

(defn select-user-id
  [id]
  (select "users"
          (fields :username :id)
          (where (= :id id))))

(defn select-user-name
  [name password]
  (select "users"
          (fields :id :username)
          (where (and (= :username name)
                      (= :password password)))))

(defn does-user-exist?
  [email]
  (not (nil? (first (select "users"
                            (where (= :email email)))))))

;;*****************************************************
;; Search queries
;;*****************************************************

(defn not-nil? 
  [x]
  (not (nil? x)))

(defn not-empty?
  [x]
  (not (empty? x)))


;; filter nil values in the future...?
(defn create-constraints [& {:keys [genres runtime year title] :as args}]
  (into {} (map (fn [x]
                  (cond
                   (and (= (key x) :genres) (and (not-nil? (val x)) (not-empty? (val x)))) {:id ['in (movie-genres-q (val x))]}
                   (and (= (key x) :runtime) (not-nil? (val x))) {:runtime ['= (val x)]}
                   (and (= (key x) :year) (not-nil? (val x))) {:year ['= (val x)]}
                   (and (= (key x) :title) (not-nil? (val x))) {:title ['like (val x)]})) 
                args)))


(defn search-movie [& {:keys [genres runtime year title] :as args}]
  (map create-movie (select "movie"
                            (where (create-constraints :genres genres :runtime runtime :year year :title title)))))

;; query for user rating
(defn search-movie-user [user & {:keys [genres runtime year title] :as args}]
  (map (partial create-movie-user user) (select "movie"
                                                (where (create-constraints :genres genres :runtime runtime :year year :title title)))))

(defn random-movie
  []
  (rand-nth (map create-movie (select "movie"))))
