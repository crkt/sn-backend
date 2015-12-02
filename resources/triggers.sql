CREATE TRIGGER create_rating AFTER INSERT ON movie
       FOR EACH ROW INSERT INTO avg_rating values (NEW.id, 0, 0);

CREATE TRIGGER update_avg AFTER INSERT ON rating
       FOR EACH ROW UPDATE avg_rating
       SET rating = (SELECT AVG(rating) from rating where rating.movie_id=avg_rating.movie_id),
           nr_votes = (SELECT COUNT(user_id) from rating where rating.movie_id=avg_rating.movie_id) 
       WHERE avg_rating.movie_id=NEW.movie_id;

CREATE TRIGGER update_rating AFTER UPDATE ON rating
       FOR EACH ROW UPDATE avg_rating
       SET rating = (SELECT AVG(rating) from rating where rating.movie_id=avg_rating.movie_id) 
       WHERE avg_rating.movie_id=NEW.movie_id;
