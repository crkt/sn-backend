# Introduction to sn-backend
TODO: write [great documentation](http://jacobian.org/writing/what-to-write/)

The link between the database and client.

## General information
### Clojure
Learning clojure is not as hard as learning java. NOTHING IS IMPOSSIBLE.
Some good resources to read and follow to get feel for it are:
[BraveClojure](http://www.braveclojure.com/introduction/)
Follow that and I suggest you use Emacs, he covers a guide for how the get a good emacs enviroment setup. Just follow the steps.
Emacs is availabe for windows as well.
### Third party tools
All of the "imports" can be found in the project.clj file under dependencies. Leiningen will then install all of the dependencies for you. Pretty neat.

The server uses [compojure](https://github.com/weavejester/compojure) for routing requests to the server. Additional information and usage can be found in the link. The routing is done in core.clj

For running the server on a port it uses [clojure/ring](https://github.com/ring-clojure/ring) We use the Jetty adapter and run it on port 3000. See the main function in core.clj

The database uses [SQLKorma](http://sqlkorma.com/docs) for creating queries to our database. The database is a MySQL using [MariaDB](https://mariadb.org/). We run it on port 3306. To change the database config edit it in the db.clj file.

## Writing Code
### Coding standard
A function in clojure will look like this:
```
;; function-name : args : returns  // a comment about the function
   - args, the args it takes e.g nubmer, text 
   - returns, what the function will return, e.g a list() or a map{}
(defn function-name
      "" - comment about the function
      [] - args
      () - the code to run ) - end of function definition
```
### Where do I write the code?
#### Request code
For now we write all the routing code in core.clj. We write the handlers for a request on a specific url and a method there. e.g /search/movie has a handler in core.clj 
#### Specific code
This means for example the user specific code is in user.clj and the search specific code is in search.clj
#### Database queries
All database queries to the database are written in db.clj.

#### All together
e.g Create a route in core.clj let's say 
```
(PUT "/search/movie" request
     (response (search-for-movie request)))
```
The response function returns a json response of the data given to it. In this case it will be a list of movies which will become [Obj,Obj,Obj] in JSON.

The search-movie is in the core.clj and looks like this:
```
;; search-for-movie : request map (json) -> response (json)
(defn search-for-movie 
  "Searches for a movie in the database with a request object.
  The response is an json array of movie objects."
  [req]
  (let [body (:body req)]
    (search/search-movie body)))
```
The search/search-for-movie is a function located in the search.clj file that is imported at the top of core.clj like this:
```
(:require [sn-backend.search :as search])
```
So we can refer to the search.clj as search in core.clj. We then call the search-for-movie that's located in the search.clj file and it looks like this:
```
(defn search-movie       
      "Searches for a movie with the attributes"
      [body]
      (let [genres (:genres body)
        runtime (:runtime body)
        year (:year body)
        title (:title body)]
    (db/search-movie :genres genres :runtime runtime :year year :title title)))
```
Note that db/function in this case uses the imported db.clj files search-movie function. Using the same require as in the previsous example, like this:
```
(:require [sn-backend.db : as db])        
```
This function uses the database query for searching for a movie, it looks like this:
```
(defn search-movie [& {:keys [genres runtime year title]}]
  (map create-movie (select "movie"
                            (where (create-constraints :genres genres :runtime runtime :year year :title title)))))
```
This query uses SQLKorma and some custom functions to create where params to select the movies with the attributes. It will return a list of movie objects, e.g (Movie1, Movie2)

There is no "return" syntax in clojure. What is evaluated last get's returned. So you never write return x

Good, you should now be prepared to break something in the project. Go ahead and do it. But beware, you might learn something from it!