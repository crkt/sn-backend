**Table of Contents**  *generated with [DocToc](http://doctoc.herokuapp.com/)*

- [Introduction to sn-backend](#introduction-to-sn-backend)
	- [General information](#general-information)
		- [Clojure](#clojure)
		- [Third party tools](#third-party-tools)
			- [Add a tool to the project](#add-a-tool-to-the-project)
			- [Our Tools](#our-tools)
	- [Writing Code](#writing-code)
		- [Coding standard](#coding-standard)
		- [Where do I write the code?](#where-do-i-write-the-code)
			- [Request code](#request-code)
			- [Specific code](#specific-code)
			- [Database queries](#database-queries)
			- [All together](#all-together)

# Introduction to sn-backend
TODO: write [great documentation](http://jacobian.org/writing/what-to-write/) 

The link between the database and client.

## General information
### Clojure
Learning clojure is not as hard as learning java. NOTHING IS IMPOSSIBLE.

Some good resources to read and follow to get feel for it are:
* [BraveClojure](http://www.braveclojure.com/introduction/)

Follow that and I suggest you use Emacs, he covers a guide for how the get a good emacs enviroment setup. Just follow the steps.
There are other options, check the clojure tools section here: [Clojure Tools](http://clojure.org/getting_started)

Emacs is availabe for windows as well.
### Third party tools
Here you can find information on what third party tools we use.

#### Add a tool to the project
All of the "imports" can be found in the [project.clj](https://github.com/Fruitschinpo/sn-backend/blob/master/project.clj) file under dependencies. Leiningen will then install all of the dependencies for you. Pretty neat.

It will look like this
```
:dependencies [[org.clojure/clojure "1.7.0"]
               [add tool here]
               [korma "0.4.2"]]
```

#### Our Tools
* [compojure](https://github.com/weavejester/compojure)
* [clojure/ring](https://github.com/ring-clojure/ring)
* [json-ring](https://github.com/ring-clojure/ring-json)
* [SQLKorma](http://sqlkorma.com/docs)
* [Dire](https://github.com/MichaelDrogalis/dire) 

The server uses [compojure](https://github.com/weavejester/compojure) for routing requests to the server. Additional information and usage can be found in the link. The routing is done in core.clj

For running the server on a port it uses [clojure/ring](https://github.com/ring-clojure/ring) We use the Jetty adapter and run it on port 3000. See the main function in core.clj

Creating json responses, we use [json-ring](https://github.com/ring-clojure/ring-json) This is setup in our handler, located in core.clj.

The database uses [SQLKorma](http://sqlkorma.com/docs) for creating queries to our database. The database is a MySQL using [MariaDB](https://mariadb.org/). We run it on port 3306. To change the database config edit it in the [db.clj](https://github.com/Fruitschinpo/sn-backend/blob/master/src/sn_backend/db.clj) file.

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
      () - the code to run)
```
### Where do I write the code?
#### Request code

First, make sure that the route you want to add is in the handler macro. Located in core.clj. This is where all routes in our server are defined.

Second, create a function that takes a request argument and then performs the things it needs with the request argument, e.q
```
(defn search-for-movie 
  "Searches for a movie in the database with a request object.
  The response is an json array of movie objects."
  [req]
  (handle-request req search/search-movie 400 200))
```
The function the searches for movies.

The Handle-request function call is actually a macro, that looks like this:
```
(defmacro handle-request 
  "This macro is for returning a response to a client. Expects a request map, a function to handle the request map and an http error code if the request fails and an http ok code if the request is good."
  [req f error ok]
  `(let [res# (~f (:body ~req))]
     (if  (contains? res# :error)
       (status (response res#) ~error)
       (status (response res#) ~ok))))
```
The first argument is the http request map, the f is a function. As you can see I'm giving it a function as an argument. Since all of our functions for getting something from the database are quite simillar we can do an abstraction like this. So the search/search-movie is the search-movie function in the search.clj file. Which is pretty fucking awesome.

The error arg is a HTTP Error Code. [W3](http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html)
The ok arg is a HTTP OK Code. [W3](http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html)


#### Specific code
The specific code is written in an appropriate file accompanied to it. e.g search.clj user.clj etc. In it, there will be a function that uses the database to get data from it or alter it. 
For example:
```
(defn register-user
  [body]
  (let [email (:email body)
        password (:password body)    
        id (:generated_key (db/insert-user email password))]
    (into {} (db/select-user-id id))))
```
This is the function for registering a user. As you can see it returns a user object in a map {}.

It uses the db.clj for doing the sql queries.

In this user example user.clj it also houses the error handling code. For error handling we use [Dire](https://github.com/MichaelDrogalis/dire) 

With it we keep our functions clean, and avoid getting stuck in a try{} catch{} forest. 

Since the register user function, can get an sqlexception since the email is already added, we create  handler for that with Dire, like this: 
```
(with-handler! #'register-user
  "Duplicate entry exception"
  java.sql.SQLException
  (fn [e body]
    (if (= (.getErrorCode e) 1062)
      {:error "User already exists" :field "email"}
      e)))
```
This will catch the SQLException that the db.clj throws when it tries to insert something that already exists. The 1062 error code is the duplicate entry key. If it's another error code, we currently just return the whole damm thing.

But with this our register-user function, when called upon, if it gets an exception, it will instead return and error map 
```
{:error "User already exists" :field "email"}
```

The error key is so that the client can get the message, the field key is the name of the property that failed, so we can highlight that field in the frontend later.

You can also add postconditions and preconditions to functions with [Dire](https://github.com/MichaelDrogalis/dire)

I suggest you check out the documentation for it. It's really useful.

#### Database queries
Writing the SQL queries for our MariaDB is currently done in our db.clj file.

There is no error management in here, this is to keep the queries minimal and keep the file from being enourmous. Error handling is done in specific files, search.clj etc. 

To write queries, we use [SQLKorma](http://sqlkorma.com/docs) Here is an example of the insert a new user query:
```
(defn insert-user 
  [email password]
  (insert "user"
          (values {:email email :password password})))
```
In this example the password is not hashed, which is kind of stupid.

But it resembles an sql query, using clojure syntax.

And to select a user my email and password, in order to login:
```
(defn select-user-email
  [email password]
  (select "user"
          (fields :email :id)
          (where (and (= :email email)
                      (= :password password)))))
```

#### All together
e.g Create a route in core.clj let's say 
```
(PUT "/search/movie" request
     (search-for-movie request))
```
The search-for-movie returns a http response with a status code.

IMPORTANT!!! 

Don't forget, that every route you add, you need to create the ProxyPass in the apache config for it.

The search-movie is a function in core.clj and looks like this:
```
(defn search-for-movie 
  "Searches for a movie in the database with a request object.
  The response is an json array of movie objects."
  [req]
  (handle-request req search/search-movie 400 200))
```
This function is explained more in depth under the [Request code](#request-code) section

We need the search.clj file to be "imported" into our core.clj in order to say search/search-movie
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

There is no "return" syntax in clojure. What is evaluated last get's returned. So you never write 
```
return x.
```

Good, you should now be prepared to break something in the project. Go ahead and do it. But beware, you might learn something from it! JUST DO IT.