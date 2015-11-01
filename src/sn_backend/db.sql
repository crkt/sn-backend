drop table if exists genre;
drop table if exists movie;
drop table if exists movie_genre;


create table genre (id integer AUTO_INCREMENT PRIMARY KEY,
                   genre varchar(30));

create table movie (id integer AUTO_INCREMENT PRIMARY KEY, 
                   title varchar(50), 
                   year integer, 
                   runtime integer);

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

insert into movie (title, year, runtime) values ('Jurassic Park', 1993, 127);

insert into movie_genre (movie_id, genre_id) values (1,1);
insert into movie_genre (movie_id, genre_id) values (1,4);
insert into movie_genre (movie_id, genre_id) values (1,7);



select genre from genre join (select genre_id from movie_genre where movie_id=1) as gm
       on (gm.genre_id = genre.id);


select * from movie where in (select * from movie_genre where genre_id = ?);

select * from movie where id in (select movie_id from movie_genre where genre_id in (select id from genre where genre = 'action'))
