(ns sn-backend.db
  (:require [korma.core :refer :all :rename {update sql-update}]
            [korma.db :refer :all])
  (:gen-class))

;;*****************************************************
;; Storage
;; This file handles the protocol between the storage.
;; All the CRUD, will be found in this file.
;; Uses the SQLKorma Library.
;;*****************************************************


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
 
;; get-movie-rating : number -> {:rating :nr_votes}
(defn get-movie-rating
  "Gets the rating for a movie"
  [movie_id]
  (into {} (select "avg_rating"
                   (fields :rating :nr_votes)
                   (where (= :movie_id movie_id)))))

;; get-movie-rating-user : number,number -> {:rating :nr_votes :user_rating}
(defn get-movie-rating-user
  "Gets a movies rating and the rating it recieved by the user."
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
  "Creates a rating record from a rating row."
  [row]
  (let [r (->Rating (:rating row)
                    (:nr_votes row)
                    nil)]
    r))
;; create user-rating
(defn create-user-rating 
  "Creates a rating record with a user rating."
  [row]
  (let [r (->Rating (:rating row)
                    (:nr_votes row)
                    (:user_rating row))]
    r))

;;*****************************************************
;; Movie queries
;;*****************************************************

;; has-user-rated-movie? : number,number -> bool
(defn has-user-rated-movie?
  "Checks if the user has rated the movie already."
  [movie_id user_id]
  (not (nil? (first (select "rating"
                            (where {:user_id [= user_id]
                                    :movie_id [= movie_id]}))))))
					
;; does-genre-exist? : string -> bool				
(defn does-genre-exist? 
  "Checks if the genre name is added in the database."
  [genre]
  (not (nil? (first (select "genre"
                            (where {:genre genre}))))))

;; update-rating : number,number,number -> {:rating :nr_votes :user_rating}
(defn update-rating 
  "Updates the rating of a movie, returns the new user_rating."
  [movie_id rating user_id]  
  (sql-update "rating"
              (set-fields {:rating rating})
              (where {:user_id [= user_id]
                      :movie_id [= movie_id]}))
  (get-movie-rating-user user_id movie_id))

;; insert-rating : number,number,number -> {:rating :nr_votes :user_rating}
(defn insert-rating
  "Insert a rating into the database. Returns the rating map."
  [movie_id rating user_id]
  (insert "rating"
          (values {:user_id user_id :movie_id movie_id :rating rating}))
  (get-movie-rating-user user_id movie_id))
					
;; insert-genre : string -> {:generated_key}
(defn insert-genre 
  "Inserts a genre, checks if the genre exists before adding it."
  [genre]
  (println "Checking if genre needs to be added" genre)
  (if (does-genre-exist? genre)
    nil
    (insert "genre"
            (values {:genre genre}))))        
			
;; add-genre-to-movie : number,string -> {:generated_key}
(defn add-genre-to-movie 
  "Adds a genre relation to a movie."
  [id genre]  
  (println "Adding genre to movie" id "and genre" genre)
  (insert "movie_genre"
          (values {:movie_id id :genre_id genre})))

;; insert-movie : {movie} -> {:id}
(defn insert-movie
  "Inserts a movie map into the database. It will then return the id of the added movie."
  [movie]
  (let [movie_id (:generated_key (insert "movie"
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
    (dorun (map insert-genre (:genres movie)))
    (dorun (map (partial add-genre-to-movie movie_id) (genres-q (:genres movie))))
    {:id movie_id}))

;; get-all-genres : nil -> ({genre},{genre})
(defn get-all-genres
  "Gets all the genres in the database."
  []
  (select "genre"))

;; get-all-movies : nil -> ({movie},{movie})
(defn get-all-movies
  "Gets all the movies in the database. Returns a list of movies."
  []
  (map create-movie (select "movie")))

;; movie_id : {row} -> id
(defn movie_id
  "Gets the movie id in a movie row."
  [movie]
  (:movie_id movie))
  
;; get-user-rated-movies : number -> [{movie},{movie}]
(defn get-user-rated-movies
  "Get's the user rated movies, creates movie Records and then returns them
  in a vector."
  [user_id]
  (into [] (map movie_id (select "rating"
                                 (fields [:movie_id])
                                 (where  (= :user_id user_id))))))

;; get-rated-movies : number -> [{movie},{movie}]
(defn get-rated-movies
  "Returns all the user rated movies."
  [user_id]
  (into [] (map create-movie (select "movie"
                                     (where {:id [in (get-user-rated-movies user_id)]})))))

;; get-movie : number -> {movie}
(defn get-movie
  "Takes a movie id and returns the movie."
  [id]
  (into {} (map create-movie (select "movie"
                                     (where {:id [= id]})))))

;; get-movie-with-user-rating : number, number -> {movie}
(defn get-movie-with-user-rating
  "Gets a movie with a movie id and a user id. Returns the movie as a movie Record."
  [id user]
  (into {} (map (partial create-movie-user user)) (select "movie"
                                                          (where {:id [= id]}))))

;;*****************************************************
;; Movie generation
;;*****************************************************
;; read-movies : nil -> ({:id}...{:id})
(defn read-movies 
  "Reads the movies found in the movies.clj file. Adds them all to the database."
  []
  (let [movies (read-from-file-with-trusted-contents "movies.clj")]
    (dorun (map insert-movie movies))))

;;*****************************************************
;; User queries
;;*****************************************************
;; PASSWORD(password)

;; insert-user : string,string,string -> {:generated_key}
(defn insert-user 
  "Inserts a user. WARNING, THE PASSWORD IS IN PLAIN TEXT."
  [email name password]
  (insert "users"
          (values {:email email :username name :password password})))

;; select-user-id : number -> {:username :id}
(defn select-user-id
  "Selects a user with the user id."
  [id]
  (select "users"
          (fields :username :id)
          (where (= :id id))))


;; select-user-name : string,string -> {:id :username}
(defn select-user-name
  "Takes a username and a password and checks if it exists."
  [name password]
  (select "users"
          (fields :id :username)
          (where (and (= :username name)
                      (= :password password)))))

;; does-user-exist? : string -> bool
(defn does-user-exist?
  "Checks if the email exists in the database."
  [email]
  (not (nil? (first (select "users"
                            (where (= :email email)))))))

;;*****************************************************
;; Search queries
;;*****************************************************

;; not-nil? : x -> bool
(defn not-nil? 
  "Checks if x is value other than nil."
  [x]
  (not (nil? x)))

;; not-empty? : list -> bool
(defn not-empty?
  "Checks if x is a non empty collection."
  [x]
  (not (empty? x)))


;; filter nil values in the future...?
;; create-constraints : & {:genres :runtime :year :title} -> {:genres [] :runtime []:year [] :title []}
(defn create-constraints 
  "Creates search constraints for the supplied keys that are not nil or not empty."
  [& {:keys [genres runtime year title] :as args}]
  (into {} (map (fn [x]
                  (cond
                   (and (= (key x) :genres) (and (not-nil? (val x)) (not-empty? (val x)))) {:id ['in (movie-genres-q (val x))]}
                   (and (= (key x) :runtime) (not-nil? (val x))) {:runtime ['between (vector (:min (val x)) (:max (val x)))]}
                   (and (= (key x) :year) (not-nil? (val x))) {:year ['between (vector (:min (val x)) (:max (val x)))]}
                   (and (= (key x) :title) (not-nil? (val x))) {:title ['like (str "%" (val x) "%")]})) 
                args)))

;; search-movie : & {:genres :runtime :year :title} -> [{movie},{movie}]
(defn search-movie 
  "Seaches for a movie. Uses the create-constraints to create search constraints.
  Returns the found movies as movie records."
  [& {:keys [genres runtime year title] :as args}]
  (map create-movie (select "movie"
                            (where (create-constraints :genres genres :runtime runtime :year year :title title)))))

;; query for user rating
;; search-movie-user : {:user & :genres :runtime :year :title} -> [{movie},{movie}]
(defn search-movie-user 
  "Searches for movies with a user to get the users rating of the movies."
  [user & {:keys [genres runtime year title] :as args}]
  (map (partial create-movie-user user) (select "movie"
                                                (where (create-constraints :genres genres :runtime runtime :year year :title title)))))

;; random-movie : nil -> {movie}
(defn random-movie
  "Selects a random movie from the collection of movies."
  []
  (rand-nth (map create-movie (select "movie"))))


;;; -main : nil -> nil
(defn -main
  "Adds all the movies found in movies.clj"
  []
  (read-movies))
