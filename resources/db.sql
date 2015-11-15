drop table if exists movie_genre;
drop table if exists rating;

drop table if exists user;
drop table if exists genre;
drop table if exists movie;



create table genre (id integer AUTO_INCREMENT PRIMARY KEY,
                   genre varchar(30));

create table movie (id integer AUTO_INCREMENT PRIMARY KEY, 
                   title varchar(50), 
                   year integer, 
                   description text,
                   runtime integer);
create table user
	(name varchar (25),
	mail varchar (50) PRIMARY KEY,
	password varchar (25));

create table rating 
	(user_mail varchar (50),
	movie_title varchar (50),
	rating integer,
	FOREIGN KEY (user_mail) REFERENCES user(mail),
	FOREIGN KEY (movie_title) REFERENCES movie movie(title));

create table movie_genre (movie_id integer, 
                         genre_id integer,
                         FOREIGN KEY (movie_id) REFERENCES movie(id),
                         FOREIGN KEY (genre_id) REFERENCES genre(id));


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




select * from movie where id in 
                 (select movie_id from movie_genre where genre_id in
                 (select id from genre where genre in ('crime','drama')))
                 and runtime < 127;
