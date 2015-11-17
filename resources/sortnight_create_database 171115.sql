-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema movie_project
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema movie_project
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `movie_project` DEFAULT CHARACTER SET utf8 ;
USE `movie_project` ;

-- -----------------------------------------------------
-- Table `movie_project`.`country`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `movie_project`.`country` ;

CREATE TABLE IF NOT EXISTS `movie_project`.`country` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(125) NOT NULL,
  `country_code` VARCHAR(2) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC),
  UNIQUE INDEX `country_code_UNIQUE` (`country_code` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `movie_project`.`mature_rating`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `movie_project`.`mature_rating` ;

CREATE TABLE IF NOT EXISTS `movie_project`.`mature_rating` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `code` VARCHAR(5) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  UNIQUE INDEX `code_UNIQUE` (`code` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `movie_project`.`movie`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `movie_project`.`movie` ;

CREATE TABLE IF NOT EXISTS `movie_project`.`movie` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `description` TEXT NULL,
  `picture` TEXT NULL,
  `keywords` TEXT NULL COMMENT 'comma separated strings/tags',
  `year` INT NULL,
  `country_id` INT NULL,
  `characters` TEXT NULL COMMENT 'comma separated values',
  `running_time` INT NULL,
  `mature_rating_id` INT NULL,
  `director` TEXT NULL,
  `writer` TEXT NULL,
  `stars` TEXT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `country_fk_idx` (`country_id` ASC),
  INDEX `mature_rating_fk_idx` (`mature_rating_id` ASC),
  CONSTRAINT `country_fk`
    FOREIGN KEY (`country_id`)
    REFERENCES `movie_project`.`country` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `mature_rating_fk`
    FOREIGN KEY (`mature_rating_id`)
    REFERENCES `movie_project`.`mature_rating` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `movie_project`.`genre`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `movie_project`.`genre` ;

CREATE TABLE IF NOT EXISTS `movie_project`.`genre` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `movie_project`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `movie_project`.`user` ;

CREATE TABLE IF NOT EXISTS `movie_project`.`user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` TEXT NOT NULL,
  `password` TEXT NOT NULL,
  `email` TEXT NOT NULL,
  `profile_me` TINYINT(1) NOT NULL DEFAULT 0,
  `taste_profile` TEXT NULL DEFAULT '' COMMENT 'Comma separated values',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `movie_project`.`friendship`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `movie_project`.`friendship` ;

CREATE TABLE IF NOT EXISTS `movie_project`.`friendship` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_1_id` INT NOT NULL,
  `user_2_id` INT NOT NULL,
  `approved` TINYINT(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  CONSTRAINT `fr_user_1_id_fk`
    FOREIGN KEY (`user_1_id`)
    REFERENCES `movie_project`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fr_user_2_id_fk`
    FOREIGN KEY (`user_2_id`)
    REFERENCES `movie_project`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `movie_project`.`recommendation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `movie_project`.`recommendation` ;

CREATE TABLE IF NOT EXISTS `movie_project`.`recommendation` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_1_id` INT NOT NULL,
  `user_2_id` INT NOT NULL,
  `movie_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  CONSTRAINT `recommendation_user_1_id_fk`
    FOREIGN KEY (`user_1_id`)
    REFERENCES `movie_project`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `recommendation_user_2_id_fk`
    FOREIGN KEY (`user_2_id`)
    REFERENCES `movie_project`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `recommendation_movie_fk`
    FOREIGN KEY (`movie_id`)
    REFERENCES `movie_project`.`movie` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `movie_project`.`rating`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `movie_project`.`rating` ;

CREATE TABLE IF NOT EXISTS `movie_project`.`rating` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `movie_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `rating` INT NOT NULL COMMENT 'Values range from 1-10.',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  UNIQUE INDEX `RATING` (`movie_id` ASC, `user_id` ASC),
  INDEX `user_id_fk_idx` (`user_id` ASC),
  CONSTRAINT `movie_id_fk`
    FOREIGN KEY (`movie_id`)
    REFERENCES `movie_project`.`movie` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `user_id_fk`
    FOREIGN KEY (`user_id`)
    REFERENCES `movie_project`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `movie_project`.`movie_list_group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `movie_project`.`movie_list_group` ;

CREATE TABLE IF NOT EXISTS `movie_project`.`movie_list_group` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `group_id` INT NOT NULL,
  `name` TEXT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `group_id_fk_idx` (`group_id` ASC),
  CONSTRAINT `mlg_group_id_fk`
    FOREIGN KEY (`group_id`)
    REFERENCES `movie_project`.`group` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `movie_project`.`invite`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `movie_project`.`invite` ;

CREATE TABLE IF NOT EXISTS `movie_project`.`invite` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_1_id` INT NOT NULL,
  `user_2_id` INT NOT NULL,
  `group_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `user_1_id_fk_idx` (`user_1_id` ASC),
  INDEX `user_2_id_fk_idx` (`user_2_id` ASC),
  INDEX `group_id_fk_idx` (`group_id` ASC),
  CONSTRAINT `invite_user_1_id_fk`
    FOREIGN KEY (`user_1_id`)
    REFERENCES `movie_project`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `invite_user_2_id_fk`
    FOREIGN KEY (`user_2_id`)
    REFERENCES `movie_project`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `invite_group_id_fk`
    FOREIGN KEY (`group_id`)
    REFERENCES `movie_project`.`group` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `movie_project`.`group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `movie_project`.`group` ;

CREATE TABLE IF NOT EXISTS `movie_project`.`group` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` TEXT NOT NULL,
  `description` TEXT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  CONSTRAINT `group_movie_list_group_fk`
    FOREIGN KEY (`id`)
    REFERENCES `movie_project`.`movie_list_group` (`group_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `group_join_fk`
    FOREIGN KEY (`id`)
    REFERENCES `movie_project`.`join` (`group_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `group_invite_fk`
    FOREIGN KEY (`id`)
    REFERENCES `movie_project`.`invite` (`group_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `movie_project`.`join`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `movie_project`.`join` ;

CREATE TABLE IF NOT EXISTS `movie_project`.`join` (
  `user_id` INT NOT NULL,
  `group_id` INT NOT NULL,
  `id` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  UNIQUE INDEX `GROUP_JOIN` (`group_id` ASC, `user_id` ASC),
  INDEX `user_id_fk_idx` (`user_id` ASC),
  CONSTRAINT `join_user_id_fk`
    FOREIGN KEY (`user_id`)
    REFERENCES `movie_project`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `join_group_id_fk`
    FOREIGN KEY (`group_id`)
    REFERENCES `movie_project`.`group` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `movie_project`.`movie_list_user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `movie_project`.`movie_list_user` ;

CREATE TABLE IF NOT EXISTS `movie_project`.`movie_list_user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `name` TEXT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `user_id_fk_idx` (`user_id` ASC),
  CONSTRAINT `mlu_user_id_fk`
    FOREIGN KEY (`user_id`)
    REFERENCES `movie_project`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `movie_project`.`movie_list_group_item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `movie_project`.`movie_list_group_item` ;

CREATE TABLE IF NOT EXISTS `movie_project`.`movie_list_group_item` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `movie_id` INT NOT NULL,
  `list_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  UNIQUE INDEX `MOVIE_LIST` (`movie_id` ASC, `list_id` ASC),
  CONSTRAINT `mlgi_list_id_fk`
    FOREIGN KEY (`list_id`)
    REFERENCES `movie_project`.`movie_list_group` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `mlgi_movie_id`
    FOREIGN KEY (`movie_id`)
    REFERENCES `movie_project`.`movie` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `movie_project`.`movie_list_user_item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `movie_project`.`movie_list_user_item` ;

CREATE TABLE IF NOT EXISTS `movie_project`.`movie_list_user_item` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `movie_id` INT NOT NULL,
  `list_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  UNIQUE INDEX `MOVIE_USER` (`movie_id` ASC, `list_id` ASC),
  CONSTRAINT `mlui_list_id_fk`
    FOREIGN KEY (`list_id`)
    REFERENCES `movie_project`.`movie_list_user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `mlui_movie_id_fk`
    FOREIGN KEY (`movie_id`)
    REFERENCES `movie_project`.`movie` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `movie_project`.`search_history`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `movie_project`.`search_history` ;

CREATE TABLE IF NOT EXISTS `movie_project`.`search_history` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `field_name` TEXT NOT NULL,
  `search_word` TEXT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `user_id_fk_idx` (`user_id` ASC),
  CONSTRAINT `sh_user_id_fk`
    FOREIGN KEY (`user_id`)
    REFERENCES `movie_project`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `movie_project`.`movie_genre`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `movie_project`.`movie_genre` ;

CREATE TABLE IF NOT EXISTS `movie_project`.`movie_genre` (
  `movie_id` INT NOT NULL,
  `genre_id` INT NOT NULL,
  PRIMARY KEY (`movie_id`, `genre_id`),
  INDEX `movie_genre_genre_id_fk_idx` (`genre_id` ASC),
  CONSTRAINT `movie_genre_movie_id_fk`
    FOREIGN KEY (`movie_id`)
    REFERENCES `movie_project`.`movie` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `movie_genre_genre_id_fk`
    FOREIGN KEY (`genre_id`)
    REFERENCES `movie_project`.`genre` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
