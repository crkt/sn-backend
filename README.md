# sn-backend

The sortnight backend, designed to handle requests and add movies to a database.

## Wiki
Refer to [Wiki](https://github.com/Fruitschinpo/sn-backend/wiki)

## Usage

### How to run
You need to install [leiningen](http://leiningen.org/)
You will also need to install [Clojure](http://clojure.org/getting_started)

Once you have installed both of them you will run the server by doing:
(in the terminal of your choice)
```
lein run
```
That will start the main function of the project. You can find it in the project.clj file.

You can then test to go to http://localhost:3000 and see that the server is running.

You did it!

### Profiles
movies - This profile will read the movies.clj file and add them all to the database. Make sure and run the db.sql query file before ruinning this profile. To run it type:
```
lein with-profile movies run
```
Afterwards you'll have all the movies in the file.

## Database
Check the [Database](https://github.com/Fruitschinpo/sn-backend/wiki/Configuration)
To read about how to configure the database for use.

## Running the JAR file
```
java -jar <project>-<version>-standalone.jar
```
This will run the server on port 3000.

## License

Copyright © 2015 SortNight

Distributed under the Eclipse Public License either version 1.0 or (at
your option) any later version. 
