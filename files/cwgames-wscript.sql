-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema cwgames
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `cwgames` ;

-- -----------------------------------------------------
-- Schema cwgames
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `cwgames` DEFAULT CHARACTER SET utf8 ;
USE `cwgames` ;

-- -----------------------------------------------------
-- Table `cwgames`.`rating`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cwgames`.`rating` ;

CREATE TABLE IF NOT EXISTS `cwgames`.`rating` (
  `rating_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `rating_level` ENUM('E', 'E10+', 'T', 'M', 'NR') NOT NULL COMMENT 'ESRB rating system',
  PRIMARY KEY (`rating_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cwgames`.`game`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cwgames`.`game` ;

CREATE TABLE IF NOT EXISTS `cwgames`.`game` (
  `game_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `game_title` VARCHAR(45) NOT NULL,
  `release_date` DATE NULL,
  `rating_id` INT UNSIGNED NULL,
  PRIMARY KEY (`game_id`),
  CONSTRAINT `fk_game_rating1`
    FOREIGN KEY (`rating_id`)
    REFERENCES `cwgames`.`rating` (`rating_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_game_rating1_idx` ON `cwgames`.`game` (`rating_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `cwgames`.`owner`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cwgames`.`owner` ;

CREATE TABLE IF NOT EXISTS `cwgames`.`owner` (
  `owner_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`owner_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cwgames`.`company`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cwgames`.`company` ;

CREATE TABLE IF NOT EXISTS `cwgames`.`company` (
  `company_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_name` VARCHAR(45) NOT NULL,
  `is_developer` TINYINT NULL,
  `is_publisher` TINYINT NULL,
  PRIMARY KEY (`company_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cwgames`.`platform`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cwgames`.`platform` ;

CREATE TABLE IF NOT EXISTS `cwgames`.`platform` (
  `platform_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `platform_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`platform_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cwgames`.`genre`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cwgames`.`genre` ;

CREATE TABLE IF NOT EXISTS `cwgames`.`genre` (
  `genre_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `genre_type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`genre_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cwgames`.`price`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cwgames`.`price` ;

CREATE TABLE IF NOT EXISTS `cwgames`.`price` (
  `price_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `price_value` DECIMAL(5,2) NOT NULL,
  PRIMARY KEY (`price_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cwgames`.`game_platform`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cwgames`.`game_platform` ;

CREATE TABLE IF NOT EXISTS `cwgames`.`game_platform` (
  `game_id` INT UNSIGNED NOT NULL,
  `platform_id` INT UNSIGNED NOT NULL,
  `owner_id` INT UNSIGNED NOT NULL,
  `price_id` INT UNSIGNED NULL,
  `has_played` TINYINT NULL,
  PRIMARY KEY (`game_id`, `platform_id`, `owner_id`),
  CONSTRAINT `fk_gameplatform_game1`
    FOREIGN KEY (`game_id`)
    REFERENCES `cwgames`.`game` (`game_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_gameplatform_platform1`
    FOREIGN KEY (`platform_id`)
    REFERENCES `cwgames`.`platform` (`platform_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_game_platform_price1`
    FOREIGN KEY (`price_id`)
    REFERENCES `cwgames`.`price` (`price_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_game_platform_owner1`
    FOREIGN KEY (`owner_id`)
    REFERENCES `cwgames`.`owner` (`owner_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_gameplatform_platform1_idx` ON `cwgames`.`game_platform` (`platform_id` ASC) VISIBLE;

CREATE INDEX `fk_gameplatform_game1_idx` ON `cwgames`.`game_platform` (`game_id` ASC) VISIBLE;

CREATE INDEX `fk_game_platform_price1_idx` ON `cwgames`.`game_platform` (`price_id` ASC) VISIBLE;

CREATE INDEX `fk_game_platform_owner1_idx` ON `cwgames`.`game_platform` (`owner_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `cwgames`.`game_genre`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cwgames`.`game_genre` ;

CREATE TABLE IF NOT EXISTS `cwgames`.`game_genre` (
  `game_id` INT UNSIGNED NOT NULL,
  `genre_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`game_id`, `genre_id`),
  CONSTRAINT `fk_gamegenre_game1`
    FOREIGN KEY (`game_id`)
    REFERENCES `cwgames`.`game` (`game_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_gamegenre_genre1`
    FOREIGN KEY (`genre_id`)
    REFERENCES `cwgames`.`genre` (`genre_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_gamegenre_genre1_idx` ON `cwgames`.`game_genre` (`genre_id` ASC) VISIBLE;

CREATE INDEX `fk_gamegenre_game1_idx` ON `cwgames`.`game_genre` (`game_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `cwgames`.`game_company`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cwgames`.`game_company` ;

CREATE TABLE IF NOT EXISTS `cwgames`.`game_company` (
  `game_id` INT UNSIGNED NOT NULL,
  `company_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`game_id`, `company_id`),
  CONSTRAINT `fk_gamecompany_game1`
    FOREIGN KEY (`game_id`)
    REFERENCES `cwgames`.`game` (`game_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_gamecompany_company1`
    FOREIGN KEY (`company_id`)
    REFERENCES `cwgames`.`company` (`company_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_gamecompany_company1_idx` ON `cwgames`.`game_company` (`company_id` ASC) VISIBLE;

CREATE INDEX `fk_gamecompany_game1_idx` ON `cwgames`.`game_company` (`game_id` ASC) VISIBLE;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
