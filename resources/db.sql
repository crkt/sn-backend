drop table if exists movie_genre;
drop table if exists avg_rating;
drop table if exists rating;
drop table if exists count_rating;

drop table if exists users;
drop table if exists genre;
drop table if exists movie;





create table genre (id integer AUTO_INCREMENT PRIMARY KEY,
                   genre varchar(30));

create table movie (id integer AUTO_INCREMENT PRIMARY KEY, 
                   title varchar(50), 
                   year integer, 
                   description text,
                   runtime integer);

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


CREATE TRIGGER create_rating AFTER INSERT ON movie
       FOR EACH ROW INSERT INTO avg_rating values (NEW.id, 0, 0);

CREATE TRIGGER update_avg AFTER INSERT ON rating
       FOR EACH ROW UPDATE avg_rating
       SET rating = (SELECT AVG(rating) from rating where rating.movie_id=avg_rating.movie_id),
           nr_votes = (SELECT COUNT(user_id) from rating where rating.movie_id=avg_rating.movie_id) 
       WHERE avg_rating.movie_id=NEW.movie_id;

CREATE TRIGGER update_rating AFTER UPDATE ON rating
       FOR EACH ROW UPDATE avg_rating
       SET rating = (SELECT AVG(rating) from rating where rating.movie_id=avg_rating.movie_id),
           nr_votes = (SELECT COUNT(user_id) from rating where rating.movie_id=avg_rating.movie_id) 
       WHERE avg_rating.movie_id=NEW.movie_id;


insert into genre (genre) values ('action');
insert into genre (genre) values ('drama');
insert into genre (genre) values ('comedy');
insert into genre (genre) values ('sci-fi');
insert into genre (genre) values ('thriller');
insert into genre (genre) values ('slapstick');
insert into genre (genre) values ('adventure');
insert into genre (genre) values ('crime');

insert into movie (title, year, runtime) values ('Jurassic Park', 1993, 127);

insert into movie_genre (movie_id, genre_id) values (1,1);
insert into movie_genre (movie_id, genre_id) values (1,4);
insert into movie_genre (movie_id, genre_id) values (1,7);

insert into movie (title, year, runtime) values ('Nightcrawler', 2014, 117);

insert into movie_genre (movie_id, genre_id) values (2,5);
insert into movie_genre (movie_id, genre_id) values (2,8);


insert into movie(title, year, runtime) values ('The Godfather', 1972, 175);

insert into movie_genre (movie_id, genre_id) values (3,2);
insert into movie_genre (movie_id, genre_id) values (3,8);

insert into movie (title, year, runtime) values ('The Dark Knight', 2008, 152);

insert into movie_genre (movie_id, genre_id) values (4,1);
insert into movie_genre (movie_id, genre_id) values (4,2);
insert into movie_genre (movie_id, genre_id) values (4,8);

insert into users (email, password) values ("phil@mail.com", "secret");
insert into users (email, password) values ("phila@mail.com", "secret");
insert into users (email, password) values ("philb@mail.com", "secret");
insert into users (email, password) values ("philc@mail.com", "secret");
insert into users (email, password) values ("phild@mail.com", "secret");
