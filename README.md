# sn-backend

The sortnight backend, designed to handle requests and add movies to a database.

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

### Database
#### Linux/Mac
The database we use is [MariaDB](https://mariadb.org/) Install it on your system.

Then proced to create the sortnight database and user.
To connect to the database (in linux/mac) do:
```
mysql -u root
```

Once inside the database you need to create the sortnight database:
```
CREATE DATABASE sortnight;
USE sortnight;
```

Then create a sortnight user and give it access to the database:
```
CREATE USER 'sortnight'@'localhost';
SET PASSWORD FOR 'sortnight'@'localhost' = PASSWORD('secret');
GRANT ALL ON sortnight.* TO 'sortnight'@'localhost';
```

The users name is: sortnight, and it's password is "secret".

You then need to add the database tables,relations and data. This is done by doing:
(While logged in as your sortnight user, mysql -u sortnight -p)
```
SOURCE file.sql (The source for the db.sql file in the backend project, if you ran mysql -u sortnight -p inside the directory you could then just type,
SOURCE db.sql)
```

You can then proceed to update the db.clj file (if needed) to say:
```
(let [db-host "localhost"
      db-port 3306
      db-name "sortnight"]
  (def *db* {:classname "com.mysql.jdbc.Driver"
           :subprotocol "mysql"
           :subname (str "//" db-host ":" db-port "/" db-name)
           :user "sortnight"
           :password "secret"}))
```

#### Windows with XAMPP
Create a sortnight database.

Create a sortnight user:

Username: sortnight

Password: secret

Change the db.clj file to look like it does above (if needed)


## License

Copyright © 2015 SortNight

Distributed under the Eclipse Public License either version 1.0 or (at
your option) any later version. 
