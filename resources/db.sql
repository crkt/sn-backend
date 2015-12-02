drop table if exists movie_genre;
drop table if exists avg_rating;
drop table if exists rating;
drop table if exists count_rating;

drop table if exists users;
drop table if exists genre;
drop table if exists movie;

drop trigger if exists create_rating;
drop trigger if exists update_avg;
drop trigger if exists update_rating;

create table genre (id integer AUTO_INCREMENT PRIMARY KEY,
                   genre varchar(30));

create table movie (id integer AUTO_INCREMENT PRIMARY KEY, 
                   title varchar(50), 
                   year integer, 
                   runtime integer,
                   description text,
                   characters text,
                   mature_rating_id integer,
                   director text,
                   writer text,
                   stars text);




create table users (id integer AUTO_INCREMENT PRIMARY KEY,
                   email varchar(255) UNIQUE NOT NULL,
                   password text NOT NULL);

create table rating (user_id integer,
                    movie_id integer,
                    rating integer,
                    PRIMARY KEY (user_id, movie_id),
                    FOREIGN KEY (user_id) REFERENCES users(id),
                    FOREIGN KEY (movie_id) REFERENCES movie(id));

create table avg_rating (movie_id integer,
                        rating float,
                        nr_votes integer,
                        FOREIGN KEY (movie_id) REFERENCES movie(id));

create table count_rating (movie_id integer,
                          votes integer,
                          FOREIGN KEY (movie_id) REFERENCES movie(id));

create table movie_genre (movie_id integer, 
                         genre_id integer,
                         FOREIGN KEY (movie_id) REFERENCES movie(id),
                         FOREIGN KEY (genre_id) REFERENCES genre(id));



source triggers.sql
source movies.sql

insert into users (email, password) values ("phil@mail.com", "secret");
