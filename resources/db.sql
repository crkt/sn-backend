drop table if exists movie_genre;

drop table if exists genre;
drop table if exists movie;
drop table if exists user;



create table genre (id integer AUTO_INCREMENT PRIMARY KEY,
                   genre varchar(30));

create table movie (id integer AUTO_INCREMENT PRIMARY KEY, 
                   title varchar(50), 
                   year integer, 
                   description text,
                   runtime integer);

create table movie_genre (movie_id integer, 
                         genre_id integer,
                         FOREIGN KEY (movie_id) REFERENCES movie(id),
                         FOREIGN KEY (genre_id) REFERENCES genre(id));

create table user (id integer AUTO_INCREMENT PRIMARY KEY,
                  email varchar(255) UNIQUE NOT NULL,
                  password text NOT NULL);


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

insert into user (email, password) values ("phil@mail.com", "secret");
