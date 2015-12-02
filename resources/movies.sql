drop table if exists movie_genre;
drop table if exists rating;

drop table if exists user;
drop table if exists genre;
drop table if exists movie;
drop table if exists user;

create table genre (id integer AUTO_INCREMENT PRIMARY KEY,
                   genre varchar(30));

create table movie (id integer AUTO_INCREMENT PRIMARY KEY, 
                   title varchar(50), 
                   year integer, 
                   runtime integer);
                   

create table detailedmovie (id integer AUTO_INCEREMENT PRIMARY KEY,
                   title varchar(50), 
                   year integer, 
                   description text,
                   runtime integer,
                   characters text,
                   mature_rating_id varchar(1)
                   director text,
                   writer text,
                   stars text);

insert into genre (genre) values ('crime');
insert into genre (genre) values ('drama');
insert into genre (genre) values ('action');
insert into genre (genre) values ('biography');
insert into genre (genre) values ('history');
insert into genre (genre) values ('western');
insert into genre (genre) values ('adventure');
insert into genre (genre) values ('fantasy');
insert into genre (genre) values ('romance');
insert into genre (genre) values ('mystery');
insert into genre (genre) values ('sci-fi');
insert into genre (genre) values ('thriller');
insert into genre (genre) values ('family');
insert into genre (genre) values ('comedy');
insert into genre (genre) values ('war');
insert into genre (genre) values ('animation');	
insert into genre (genre) values ('horror');
insert into genre (genre) values ('music');
insert into genre (genre) values ('film-noir');				

insert into movie (movie_id, title, description, picture, year, country_id, characters, runtime, mature_rating_id, director, writer, stars) values (1,'The Shawshank Redemption','Two imprisoned men bond over a number of years, finding solace and eventual redemption through acts of common decency.',the-shawshank-redemption.jpg,1994,1,'Andy Dufresne, Ellis Boyed Red Redding, Warden Norton',142,'R','Frank Darabont','Stephen King, Frank Darabont','Tim Robbins, Morgan Freeman, Bob Gunton')
insert into movie_genre (movie_id, genre_id) values (1,1);
insert into movie_genre (movie_id, genre_id) values (1,2);

insert into movie (movie_id, title, description, picture, year, country_id, characters, runtime, mature_rating_id, director, writer, stars) values (2,'The Godfather','The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son.',the-godfather.jpg,,1972,1,'Don Vito Corleone, Michael Corleone, Sonny Corleone',175,'R','Francis Ford Coppola','Mario Puzo, Francis Ford Coppola','Marlon Brando, Al Pacino, James Caan')
insert into movie_genre (movie_id, genre_id) values (2,1);
insert into movie_genre (movie_id, genre_id) values (2,2);

insert into movie (movie_id, title, description, picture, year, country_id, characters, runtime, mature_rating_id, director, writer, stars) values (3,'The Godfather Part II','The early life and career of Vito Corleone in 1920s New York is portrayed while his son, Michael, expands and tightens his grip on his crime syndicate stretching from Lake Tahoe, Nevada to pre-revolution 1958 Cuba.',the-godfather-part-ii.jpg,,1974,1,'Michael, Tom Hagen, Kay',200,'R','Francis Ford Coppola','Mario Puzo, Francis Ford Coppola','Al Pacino, Robert De Niro, Robert Duvall')
insert into movie_genre (movie_id, genre_id) values (3,1);
insert into movie_genre (movie_id, genre_id) values (3,2);

insert into movie (movie_id, title, description, picture, year, country_id, characters, runtime, mature_rating_id, director, writer, stars) values (4,'The Dark Knight','When the menace known as the Joker wreaks havoc and chaos on the people of Gotham, the caped crusader must come to terms with one of the greatest psychological tests of his ability to fight injustice.',the-dark-knight.jpg,,2008,1,'Bruce Wayne, Joker, Harvey Dent',152,'PG','Christopher Nolan','Jonathan Nolan, Christopher Nolan','Christian Bale, Heath Ledger, Aaron Eckhart')
insert into movie_genre (movie_id, genre_id) values (4,3);
insert into movie_genre (movie_id, genre_id) values (4,2);
insert into movie_genre (movie_id, genre_id) values (4,1);

insert into movie (movie_id, title, description, picture, year, country_id, characters, runtime, mature_rating_id, director, writer, stars) values (5,'12 Angry Men','A dissenting juror in a murder trial slowly manages to convince the others that the case is not as obviously clear as it seemed in court.',12-angry-men.jpg,,1957,1,'Juror #1, Juror #2, Juror #3',96,'NR','Sidney Lumet','Reginald Rose','Henry Fonda, Lee J. Cobb, Martin Balsam')
insert into movie_genre (movie_id, genre_id) values (5,1);
insert into movie_genre (movie_id, genre_id) values (5,2);

insert into movie (movie_id, title, description, picture, year, country_id, characters, runtime, mature_rating_id, director, writer, stars) values (6,'Schindlers List','In Poland during World War II, Oskar Schindler gradually becomes concerned for his Jewish workforce after witnessing their persecution by the Nazis.',schindlers-list.jpg,,1993,1,'Oskar Schindler, Itzhak Stern, Amon Goeth',195,'R','Steven Spielberg','Thomas Keneally, Steven Zaillian','Liam Neeson, Ralph Fiennes, Ben Kingsley')
insert into movie_genre (movie_id, genre_id) values (6,4);
insert into movie_genre (movie_id, genre_id) values (6,2);
insert into movie_genre (movie_id, genre_id) values (6,5);

insert into movie (movie_id, title, description, picture, year, country_id, characters, runtime, mature_rating_id, director, writer, stars) values (7,'Pulp Fiction','The lives of two mob hit men, a boxer, a gangsters wife, and a pair of diner bandits intertwine in four tales of violence and redemption.',pulp-fiction.jpg,,1994,1,'Pumpkin / Ringo, Waitress, Vincent Vega',154,'R','Quentin Tarantino','Quentin Tarantino, Roger Avary','John Travolta, Uma Thurman, Samuel L. Jackson')
insert into movie_genre (movie_id, genre_id) values (7,1);
insert into movie_genre (movie_id, genre_id) values (7,2);

insert into movie (movie_id, title, description, picture, year, country_id, characters, runtime, mature_rating_id, director, writer, stars) values (8,'The Good, the Bad and the Ugly','A bounty hunting scam joins two men in an uneasy alliance against a third in a race to find a fortune in gold buried in a remote cemetery.','the-good,-the-bad-and-the-ugly.jpg',,1966,2,'Tuco, Blondie, Sentenza / Angel Eyes',161,'NR','Sergio Leone','Luciano Vincenzoni, Sergio Leone','Clint Eastwood, Eli Wallach, Lee Van Cleef')
insert into movie_genre (movie_id, genre_id) values (8,6);

insert into movie (movie_id, title, description, picture, year, country_id, characters, runtime, mature_rating_id, director, writer, stars) values (9,'The Lord of the Rings The Return of the King','Gandalf and Aragorn lead the World of Men against Saurons army to draw his gaze from Frodo and Sam as they approach Mount Doom with the One Ring.',the-lord-of-the-rings-the-return-of-the-king.jpg,,2003,1,'Everard Proudfoot, Elanor Gamgee (as Alexandra Astin), Sam',201,'PG','Peter Jackson','J. R. R. Tolkien, Fran Walsh','Elijah Wood, Viggo Mortensen, Ian McKellen')
insert into movie_genre (movie_id, genre_id) values (9,7);
insert into movie_genre (movie_id, genre_id) values (9,8);

insert into movie (movie_id, title, description, picture, year, country_id, characters, runtime, mature_rating_id, director, writer, stars) values (10,'Fight Club','An insomniac office worker, looking for a way to change his life, crosses paths with a devil-may-care soap maker, forming an underground fight club that evolves into something much, much more...',fight-club.jpg,,1999,1,'The Narrator, Tyler Durden, Marla Singe',139,'R','David Fincher','Chuck Palahniuk, Jim Uhls','Brad Pitt, Edward Norton, Helena Bonham Carter')
insert into movie_genre (movie_id, genre_id) values (10,2);

insert into movie (movie_id, title, description, picture, year, country_id, characters, runtime, mature_rating_id, director, writer, stars) values (11,'The Lord of the Rings: The Fellowship of the Ring','A meek Hobbit and eight companions set out on a journey to destroy the One Ring and the Dark Lord Sauron.',the-lord-of-the-rings:-the-fellowship-of-the-ring.jpg,,2001,1,'Voice of the Ring (voice), Everard Proudfoot, Sam',178,'PG','Peter Jackson','J.R.R. Tolkien, Fran Walsh','Elijah Wood, Ian McKellen, Orlando Bloom')
insert into movie_genre (movie_id, genre_id) values (11,7);
insert into movie_genre (movie_id, genre_id) values (11,8);

insert into movie (movie_id, title, description, picture, year, country_id, characters, runtime, mature_rating_id, director, writer, stars) values (12,'Star Wars Episode V The Empire Strikes Back','After the rebels have been brutally overpowered by the Empire on their newly established base, Luke Skywalker takes advanced Jedi training with Master Yoda, while his friends are pursued by Darth Vader as part of his plan to capture Luke.',star-wars-episode-v-the-empire-strikes-back.jpg,,1980,1,'Luke Skywalker, Han Solo, Princess Leia',124,'PG','Irvin Kershner,' 'Leigh Brackett, Lawrence Kasdan','Mark Hamill, Harrison Ford, Carrie Fisher')
insert into movie_genre (movie_id, genre_id) values (12,3);
insert into movie_genre (movie_id, genre_id) values (12,7);
insert into movie_genre (movie_id, genre_id) values (12,8);

insert into movie (movie_id, title, description, picture, year, country_id, characters, runtime, mature_rating_id, director, writer, stars) values (13,'Forrest Gump','Forrest Gump, while not intelligent, has accidentally been present at many historic moments, but his true love, Jenny Curran, eludes him.',forrest-gump.jpg,,1994,1,'Forrest Gump, Nurse at Park Bench, Mrs. Gump',142,'PG','Robert Zemeckis','Winston Groom, Eric Roth','Tom Hanks, Robin Wright, Gary Sinise')
insert into movie_genre (movie_id, genre_id) values (13,2);
insert into movie_genre (movie_id, genre_id) values (13,9);	

insert into movie (movie_id, title, description, picture, year, country_id, characters, runtime, mature_rating_id, director, writer, stars) values (14,'Inception' ,'A thief who steals corporate secrets through use of the dream-sharing technology is given the inverse task of planting an idea into the mind of a CEO.',inception.jpg,,2010,1,'Cobb, Arthur, Ariadne',148,'PG','Christopher Nolan','Christopher Nolan','Leonardo DiCaprio, Joseph Gordon-Levitt, Ellen')
insert into movie_genre (movie_id, genre_id) values (14,3);
insert into movie_genre (movie_id, genre_id) values (14,10);
insert into movie_genre (movie_id, genre_id) values (14,11);	

insert into movie (movie_id, title, description, picture, year, country_id, characters, runtime, mature_rating_id, director, writer, stars) values (15,'One Flew Over the Cuckoos Nest','Upon admittance to a mental institution, a brash rebel rallies the patients to take on the oppressive head nurse.',one-flew-over-the-cuckoos-nest.jpg,1975,1,'Ellis, Col. Matterson, Dr. Spivey',133,'R','Milos Forman','Lawrence Hauben, Bo Goldman','Jack Nicholson, Louise Fletcher, Michael Berryman')
insert into movie_genre (movie_id, genre_id) values (15,2);	

insert into movie (movie_id, title, description, picture, year, country_id, characters, runtime, mature_rating_id, director, writer, stars) values (16,'The Lord of the Rings The Two Towers','While Frodo and Sam edge closer to Mordor with the help of the shifty Gollum, the divided fellowship makes a stand against Saurons new ally, Saruman, and his hordes of Isengard.',the-lord-of-the-rings-the-two-towers.jpg,,2002,1,'Aldor, Sam, Madril',179,'PG','Peter Jackson','J.R.R. Tolkien, Fran Walsh',' Elijah Wood, Ian McKellen, Viggo Mortensen')
insert into movie_genre (movie_id, genre_id) values (16,7);
insert into movie_genre (movie_id, genre_id) values (16,8);	

insert into movie (movie_id, title, description, picture, year, country_id, characters, runtime, mature_rating_id, director, writer, stars) values (17,'Goodfellas','Henry Hill and his friends work their way up through the mob hierarchy.',goodfellas.jpg,,1990,1,'James Conway, Henry Hill, Tommy DeVito',146,'R','Martin Scorsese','Nicholas Pileggi', 'Robert De Niro, Ray Liotta, Joe Pesci')
insert into movie_genre (movie_id, genre_id) values (17,4);
insert into movie_genre (movie_id, genre_id) values (17,1);
insert into movie_genre (movie_id, genre_id) values (17,2);	

insert into movie (movie_id, title, description, picture, year, country_id, characters, runtime, mature_rating_id, director, writer, stars) values (18,'The Matrix','A computer hacker learns from mysterious rebels about the true nature of his reality and his role in the war against its controllers.',the-matrix.jpg,,1999,1,'Neo, Morpheus, Trinity',136,'R','Andy Wachowski, Lana Wachowski','Andy Wachowski, Lana Wachowski',' Keanu Reeves, Laurence Fishburne, Carrie-Anne Moss')
insert into movie_genre (movie_id, genre_id) values (18,3);
insert into movie_genre (movie_id, genre_id) values (18,11);

insert into movie (movie_id, title, description, picture, year, country_id, characters, runtime, mature_rating_id, director, writer, stars) values (19,'Star Wars Episode IV-A New Hope','Luke Skywalker joins forces with a Jedi Knight, a cocky pilot, a wookiee and two droids to save the universe from the Empires world-destroying battle-station, while also attempting to rescue Princess Leia from the evil Darth Vader.',star-wars-episode-iv-a-new-hope.jpg,,1977,1,'Luke Skywalker, Han Solo, Princess Leia Organa',121,'PG','George Lucas','George Lucas,' 'Mark Hamill, Harrison Ford, Carrie Fisher')
insert into movie_genre (movie_id, genre_id) values (19,3);
insert into movie_genre (movie_id, genre_id) values (19,7);
insert into movie_genre (movie_id, genre_id) values (19,8);	

insert into movie (movie_id, title, description, picture, year, country_id, characters, runtime, mature_rating_id, director, writer, stars) values (20,'Seven Samurai','A poor village under attack by bandits recruits seven unemployed samurai to help them defend themselves.',seven-samurai.jpg,,1956,1,'Kikuchiyo, Kambei Shimada, Shino',207,'NR','Akira Kurosawa','Akira Kurosawa, Shinobu Hashimoto','Toshirô Mifune, Takashi Shimura, Keiko Tsushima')
insert into movie_genre (movie_id, genre_id) values (20,2);

insert into movie (movie_id, title, description, picture, year, country_id, characters, runtime, mature_rating_id, director, writer, stars) values (21,'City of God','Two boys growing up in a violent neighborhood of Rio de Janeiro take different paths: one becomes a photographer, the other a drug dealer.',city-of-god.jpg,,2002,1,'Buscapé - Rocket, Zé Pequeno - Lil Zé, Bené - Benny',130,'R','Fernando Meirelles, Kátia Lund',' Paulo Lins, Bráulio Mantovani',' Alexandre Rodrigues, Matheus Nachtergaele, Leandro Firmino')
insert into movie_genre (movie_id, genre_id) values (21,1);
insert into movie_genre (movie_id, genre_id) values (21,2);	

insert into movie (movie_id, title, description, picture, year, country_id, characters, runtime, mature_rating_id, director, writer, stars) values (22,'Se7en','Two detectives, a rookie and a veteran, hunt a serial killer who uses the seven deadly sins as his modus operandi.',se7en.jpg,,1995,1,'Somerset, Dead Man at 1st Crime Scene, Detective Taylor',127,'R','David Fincher','Andrew Kevin Walker','Morgan Freeman, Brad Pitt, Kevin Spacey')
insert into movie_genre (movie_id, genre_id) values (22,1);
insert into movie_genre (movie_id, genre_id) values (22,2);
insert into movie_genre (movie_id, genre_id) values (22,10);	

insert into movie (movie_id, title, description, picture, year, country_id, characters, runtime, mature_rating_id, director, writer, stars) values (23,'The Silence of the Lambs','A young F.B.I. cadet must confide in an incarcerated and manipulative killer to receive his help on catching another serial killer who skins his victims.',the-silence-of-the-lambs.jpg,,1991,1,'Clarice Starling, FBI Instructor, Ardelia Mapp',118,'R','Jonathan Demme',' Thomas Harris, Ted Tally','Jodie Foster, Anthony Hopkins, Lawrence A. Bonney')
insert into movie_genre (movie_id, genre_id) values (23,1);
insert into movie_genre (movie_id, genre_id) values (23,2);
insert into movie_genre (movie_id, genre_id) values (23,12);	

insert into movie (movie_id, title, description, picture, year, country_id, characters, runtime, mature_rating_id, director, writer, stars) values (24,'The Usual Suspects','A sole survivor tells of the twisty events leading up to a horrific gun battle on a boat, which begin when five criminals meet at a seemingly random police lineup.',the-usual-suspects.jpg,,1995,1,'McManus, Keaton, Fenster',106,'R','Bryan Singer','Christopher McQuarrie','Kevin Spacey, Gabriel Byrne, Chazz Palminteri')
insert into movie_genre (movie_id, genre_id) values (24,1);
insert into movie_genre (movie_id, genre_id) values (24,2);
insert into movie_genre (movie_id, genre_id) values (24,12);	

insert into movie (movie_id, title, description, picture, year, country_id, characters, runtime, mature_rating_id, director, writer, stars) values (25,'Its a Wonderful Life','An angel helps a compassionate but despairingly frustrated businessman by showing what life would have been like if he never existed.',its-a-wonderful-life.jpg,,1946,1,'George Bailey, Mary Hatch, Mr. Potter',130,'Approved','Frank Capra','Frances Goodrich,Albert Hackett','James Stewart, Donna Reed, Lionel Barrymore')
insert into movie_genre (movie_id, genre_id) values (25,2);
insert into movie_genre (movie_id, genre_id) values (25,13);
insert into movie_genre (movie_id, genre_id) values (25,8);	

insert into movie (movie_id, title, description, picture, year, country_id, characters, runtime, mature_rating_id, director, writer, stars) values (26,'Life Is Beautiful','When an open-minded Jewish librarian and his son become victims of the Holocaust, he uses a perfect mixture of will, humor and imagination to protect his son from the dangers around their camp.',life-is-beautiful.jpg,,1997,1,'Guido, Dora, Joshua',116,'PG-13','Roberto Benigni',' Vincenzo Cerami, Roberto Benigni',' Roberto Benigni, Nicoletta Braschi, Giorgio Cantarini ')
insert into movie_genre (movie_id, genre_id) values (26,14);
insert into movie_genre (movie_id, genre_id) values (26,2);
insert into movie_genre (movie_id, genre_id) values (26,9);	

insert into movie (movie_id, title, description, picture, year, country_id, characters, runtime, mature_rating_id, director, writer, stars) values (27,'Léon The Professional','Mathilda, a 12-year-old girl, is reluctantly taken in by Léon, a professional assassin, after her family is murdered. Léon and Mathilda form an unusual relationship, as she becomes his protégée and learns the assassins trade.',léon-the-professional.jpg,,1994,1,'Léon, Stansfield, Mathilda',110,'R','Luc Besson,Luc Besson','Jean Reno, Gary Oldman, Natalie Portman')
insert into movie_genre (movie_id, genre_id) values (27,1);
insert into movie_genre (movie_id, genre_id) values (27,2);
insert into movie_genre (movie_id, genre_id) values (27,12);

insert into movie (movie_id, title, description, picture, year, country_id, characters, runtime, mature_rating_id, director, writer, stars) values (28,'Once Upon a Time in the West','Epic story of a mysterious stranger with a harmonica who joins forces with a notorious desperado to protect a beautiful widow from a ruthless assassin working for the railroad.',once-upon-a-time-in-the-west.jpg,,1968,2,'Jill McBain, Frank, Cheyenne',175,'PG-13','Sergio Leone',' Sergio Donati, Sergio Leone',' Henry Fonda, Charles Bronson, Claudia Cardinale')
insert into movie_genre (movie_id, genre_id) values (28,6);

insert into movie (movie_id, title, description, picture, year, country_id, characters, runtime, mature_rating_id, director, writer, stars) values (29,'Interstellar','A team of explorers travel through a wormhole in space in an attempt to ensure humanitys survival.',interstellar.jpg,,2014,1,'Murph (older), Cooper, Murph (10 Yrs.)',169,'PG-13','Christopher Nolan','Jonathan Nolan, Christopher Nolan',' Matthew McConaughey, Anne Hathaway, Jessica Chastain')
insert into movie_genre (movie_id, genre_id) values (29,7);
insert into movie_genre (movie_id, genre_id) values (29,2);	
insert into movie_genre (movie_id, genre_id) values (29,11);

insert into movie (movie_id, title, description, picture, year, country_id, characters, runtime, mature_rating_id, director, writer, stars) values (30,'Saving Private Ryan','Following the Normandy Landings, a group of U.S. soldiers go behind enemy lines to retrieve a paratrooper whose brothers have been killed in action.',saving-private-ryan.jpg,,1998,1,'Captain Miller, Sergeant Horvath, Private Reiben',169,'R','Steven Spielberg,Robert Rodat,'' Tom Hanks, Matt Damon, Tom Sizemore')
insert into movie_genre (movie_id, genre_id) values (30,3);
insert into movie_genre (movie_id, genre_id) values (30,2);
insert into movie_genre (movie_id, genre_id) values (30,15);	

insert into movie (movie_id, title, description, picture, year, country_id, characters, runtime, mature_rating_id, director, writer, stars) values (31,'Spirited Away','During her familys move to the suburbs, a sullen 10-year-old girl wanders into a world ruled by gods, witches, and spirits, and where humans are changed into beasts.',spirited-away.jpg,,2001,1,'Chihiro Ogino / Sen, Haku, Yubaba / Zeniba',125,PG,Hayao Miyazaki,Hayao Miyazaki,' Daveigh Chase, Suzanne Pleshette, Miyu Irino')
insert into movie_genre (movie_id, genre_id) values (31,16);
insert into movie_genre (movie_id, genre_id) values (31,7);
insert into movie_genre (movie_id, genre_id) values (31,13);	

insert into movie (movie_id, title, description, picture, year, country_id, characters, runtime, mature_rating_id, director, writer, stars) values (32,'American History X','A former neo-nazi skinhead tries to prevent his younger brother from going down the same wrong path that he did.,american-history-x.jpg,,1998,1,'Derek Vinyard, Danny Vinyard, Doris Vinyard',119,R,Tony Kaye,David McKenna,' 'Edward Norton, Edward Furlong, Beverly DAngelo')
insert into movie_genre (movie_id, genre_id) values (32,1);
insert into movie_genre (movie_id, genre_id) values (32,2);	

insert into movie (movie_id, title, description, picture, year, country_id, characters, runtime, mature_rating_id, director, writer, stars) values (33,'Casablanca','Set in Casablanca, Morocco during the early days of World War II: An American expatriate meets a former lover, with unforeseen complications.',casablanca.jpg,,1942,1,'Rick Blaine, Ilsa Lund, Victor Laszlo',120,PG,Michael Curtiz,' Julius J. Epstein, Philip G. Epstein','Humphrey Bogart, Ingrid Bergman, Paul Henreid')
insert into movie_genre (movie_id, genre_id) values (33,2);
insert into movie_genre (movie_id, genre_id) values (33,9);
insert into movie_genre (movie_id, genre_id) values (33,15);	

insert into movie (movie_id, title, description, picture, year, country_id, characters, runtime, mature_rating_id, director, writer, stars) values (34,'Psycho','A Phoenix secretary steals $40,000 from her employers client, goes on the run and checks into a remote motel run by a young man under the domination of his mother.',psycho.jpg,,1960,1,'Norman Bates, Lila Crane, Sam Loomis',109,R,Alfred Hitchcock,'Joseph Stefano, Robert Bloch','Anthony Perkins, Janet Leigh, Vera Miles')
insert into movie_genre (movie_id, genre_id) values (34,17);
insert into movie_genre (movie_id, genre_id) values (34,10);	
insert into movie_genre (movie_id, genre_id) values (34,12);

insert into movie (movie_id, title, description, picture, year, country_id, characters, runtime, mature_rating_id, director, writer, stars) values (35,'City Lights','With the aid of a wealthy erratic tippler, a dewy-eyed tramp who has fallen in love with a sightless flower girl accumulates money to be able to help her medically.',city-lights.jpg,,1931,1,'A Blind Girl, The Blind Girls Grandmother, An Eccentric Millionaire',87,'Passed,Charles Chaplin,Charles Chaplin,''Charles Chaplin, Virginia Cherrill, Florence Lee')
insert into movie_genre (movie_id, genre_id) values (35,14);
insert into movie_genre (movie_id, genre_id) values (35,2);
insert into movie_genre (movie_id, genre_id) values (35,9);	

insert into movie (movie_id, title, description, picture, year, country_id, characters, runtime, mature_rating_id, director, writer, stars) values (36,'Raiders of the Lost Ark','Archaeologist and adventurer Indiana Jones is hired by the US government to find the Ark of the Covenant before the Nazis.',raiders-of-the-lost-ark.jpg,1981,1,'Indy, Marion Ravenwood, Dr. René Belloq',115,'PG','Steven Spielberg','Lawrence Kasdan, George Lucas','Harrison Ford, Karen Allen, Paul Freeman')
insert into movie_genre (movie_id, genre_id) values (36,3);
insert into movie_genre (movie_id, genre_id) values (36,7);	

insert into movie (movie_id, title, description, picture, year, country_id, characters, runtime, mature_rating_id, director, writer, stars) values (37,'Rear Window','A wheelchair bound photographer spies on his neighbours from his apartment window and becomes convinced one of them has committed murder.',rear-window.jpg,,1954,4,'L.B. 'Jeff' Jefferies, Lisa Carol Fremont, Det. Lt. Thomas J. Doyle',112,'Approved' ,'Alfred Hitchcock','John Michael Hayes, Cornell Woolrich','James Stewart, Grace Kelly, Wendell Corey')
insert into movie_genre (movie_id, genre_id) values (37,10);
insert into movie_genre (movie_id, genre_id) values (37,12);	

insert into movie (movie_id, title, description, picture, year, country_id, characters, runtime, mature_rating_id, director, writer, stars) values (38,'The Intouchables','After he becomes a quadriplegic from a paragliding accident, an aristocrat hires a young man from the projects to be his caregiver.',the-intouchables.jpg,,2011,1,'Philippe, Driss, Yvonne',112,'R','Olivier Nakache, Eric Toledano',' Olivier Nakache, Eric Toledano','François Cluzet, Omar Sy, Anne Le Ny')
insert into movie_genre (movie_id, genre_id) values (38,4);
insert into movie_genre (movie_id, genre_id) values (38,14);
insert into movie_genre (movie_id, genre_id) values (38,2);

insert into movie (movie_id, title, description, picture, year, country_id, characters, runtime, mature_rating_id, director, writer, stars) values (39,'Modern Times','The Tramp struggles to live in modern industrial society with the help of a young homeless woman.',modern-times.jpg,,1936,1,'A Factory Worker, A Gamin, Cafe Proprietor',87,'G', 'Charles Chaplin, Charles Chaplin,''Charles Chaplin, Paulette Goddard, Henry Bergman')
insert into movie_genre (movie_id, genre_id) values (39,14);
insert into movie_genre (movie_id, genre_id) values (39,2);

insert into movie (movie_id, title, description, picture, year, country_id, characters, runtime, mature_rating_id, director, writer, stars) values (40,'The Green Mile','The lives of guards on Death Row are affected by one of their charges: a black man accused of child murder and rape, yet who has a mysterious gift.',the-green-mile.jpg,,1999,1,'Paul Edgecomb, Brutus Howell, John Coffey',189,'R','Frank Darabont','Stephen King, Frank Darabont',' Tom Hanks, Michael Clarke Duncan, David Morse')
insert into movie_genre (movie_id, genre_id) values (40,1);
insert into movie_genre (movie_id, genre_id) values (40,2);
insert into movie_genre (movie_id, genre_id) values (40,8);

insert into movie (movie_id, title, description, picture, year, country_id, characters, runtime, mature_rating_id, director, writer, stars) values (41,'Terminator 2 Judgment Day','A cyborg, identical to the one who failed to kill Sarah Connor, must now protect her young son, John Connor, from a more advanced cyborg, made out of liquid metal.',terminator-2-judgment-day.jpg,,1991,1,'The Terminator, Sarah Connor, John Connor',137,'R','James Cameron',' James Cameron, William Wisher Jr.',' Arnold Schwarzenegger, Linda Hamilton, Edward Furlong')
insert into movie_genre (movie_id, genre_id) values (41,11);

insert into movie (movie_id, title, description, picture, year, country_id, characters, runtime, mature_rating_id, director, writer, stars) values (42,'Whiplash','A promising young drummer enrolls at a cut-throat music conservatory where his dreams of greatness are mentored by an instructor who will stop at nothing to realize a students potential.',whiplash.jpg,,2014,1,'Andrew, Fletcher, Jim Neimann',107,'R','Damien Chazelle,Damien Chazelle','Miles Teller, J.K. Simmons, Melissa Benoist')
insert into movie_genre (movie_id, genre_id) values (42,2);
insert into movie_genre (movie_id, genre_id) values (42,18);	

insert into movie (movie_id, title, description, picture, year, country_id, characters, runtime, mature_rating_id, director, writer, stars) values (43,'The Pianist','A Polish Jewish musician struggles to survive the destruction of the Warsaw ghetto of World War II.',the-pianist.jpg,,2002,1,'Wladyslaw Szpilman, Dorota, Jurek',150,'R','Roman Polanski',' Ronald Harwood, Wladyslaw Szpilman','Adrien Brody, Thomas Kretschmann, Frank Finlay')
insert into movie_genre (movie_id, genre_id) values (43,4);
insert into movie_genre (movie_id, genre_id) values (43,2);
insert into movie_genre (movie_id, genre_id) values (43,15);	

insert into movie (movie_id, title, description, picture, year, country_id, characters, runtime, mature_rating_id, director, writer, stars) values (44,'The Departed','An undercover cop and a mole in the police attempt to identify each other while infiltrating an Irish gang in South Boston.',the-departed.jpg,,2006,1,'Billy, Colin Sullivan, Frank Costello',151,'R','Martin Scorsese','William Monahan,  Alan Mak',' Leonardo DiCaprio, Matt Damon, Jack Nicholson')
insert into movie_genre (movie_id, genre_id) values (44,1);
insert into movie_genre (movie_id, genre_id) values (44,2);
insert into movie_genre (movie_id, genre_id) values (44,12);

insert into movie (movie_id, title, description, picture, year, country_id, characters, runtime, mature_rating_id, director, writer, stars) values (45,'Memento','A man creates a strange system to help him remember things so he can hunt for the murderer of his wife without his short-term memory loss being an obstacle.',memento.jpg,,2000,1,'Leonard, Natalie, Teddy',113,'R','Christopher Nolan','Christopher Nolan, Jonathan Nolan',' Guy Pearce, Carrie-Anne Moss, Joe Pantoliano')
insert into movie_genre (movie_id, genre_id) values (45,10);
insert into movie_genre (movie_id, genre_id) values (45,12);

insert into movie (movie_id, title, description, picture, year, country_id, characters, runtime, mature_rating_id, director, writer, stars) values (46,'Back to the Future','A young man is accidentally sent 30 years into the past in a time-traveling DeLorean invented by his friend, Dr. Emmett Brown, and must make sure his high-school-age parents unite in order to save his own existence.',back-to-the-future.jpg,,1985,1,'Marty McFly, Dr. Emmett Brown, Lorraine Baines',116,'PG','Robert Zemeckis,''Robert Zemeckis, Bob Gale','Michael J. Fox, Christopher Lloyd, Lea Thompson')
insert into movie_genre (movie_id, genre_id) values (46,7);
insert into movie_genre (movie_id, genre_id) values (46,14);
insert into movie_genre (movie_id, genre_id) values (46,11);
	
insert into movie (movie_id, title, description, picture, year, country_id, characters, runtime, mature_rating_id, director, writer, stars) values (47,'Gladiator','When a Roman general is betrayed and his family murdered by an emperors corrupt son, he comes to Rome as a gladiator to seek revenge.',gladiator.jpg,,2000,1,'Maximus, Commodus, Lucilla',155,'R','Ridley Scott,''David Franzoni, David Franzoni',' Russell Crowe, Joaquin Phoenix, Connie Nielsen')
insert into movie_genre (movie_id, genre_id) values (47,3);
insert into movie_genre (movie_id, genre_id) values (47,2);

insert into movie (movie_id, title, description, picture, year, country_id, characters, runtime, mature_rating_id, director, writer, stars) values (48,'Apocalypse Now','During the Vietnam War, Captain Willard is sent on a dangerous mission into Cambodia to assassinate a renegade colonel who has set himself up as a god among a local tribe.',apocalypse-now.jpg,,1979,1,'Colonel Walter E. Kurtz, Captain Benjamin L. Willard, Lieutenant Colonel Bill Kilgore',153,'R','Francis Ford Coppola','John Milius, Francis Ford Coppola',' Martin Sheen, Marlon Brando, Robert Duvall')
insert into movie_genre (movie_id, genre_id) values (48,2);
insert into movie_genre (movie_id, genre_id) values (48,15);

insert into movie (movie_id, title, description, picture, year, country_id, characters, runtime, mature_rating_id, director, writer, stars) values (49,'Dr. Strangelove or How I Learned to Stop Worrying and Love the Bomb','An insane general triggers a path to nuclear holocaust that a war room full of politicians and generals frantically try to stop.',dr.-strangelove-or-how-i-learned-to-stop-worrying-and-love-the-bomb.jpg,,1964,1,'Group Capt. Lionel Mandrake / President Merkin Muffley / Dr. Strangelove, Gen. Buck Turgidson, Brig. Gen. Jack D. Ripper',95,'PG','Stanley Kubrick','Stanley Kubrick, Terry Southern',' Peter Sellers, George C. Scott, Sterling Hayden')
insert into movie_genre (movie_id, genre_id) values (49,14);
insert into movie_genre (movie_id, genre_id) values (49,15);	

insert into movie (movie_id, title, description, picture, year, country_id, characters, runtime, mature_rating_id, director, writer, stars) values (50,'Sunset Blvd.','A hack screenwriter writes a screenplay for a former silent-film star who has faded into Hollywood obscurity.',sunset-blvd..jpg,,1950,1,'Joe Gillis, Norma Desmond, Max Von Mayerling',110,'NR','Billy Wilder',' Charles Brackett, Billy Wilder',' William Holden, Gloria Swanson, Erich von Stroheim')
insert into movie_genre (movie_id, genre_id) values (50,2);
insert into movie_genre (movie_id, genre_id) values (50,19);	

