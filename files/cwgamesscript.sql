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
-- Table `cwgames`.`ratings`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cwgames`.`ratings` ;

CREATE TABLE IF NOT EXISTS `cwgames`.`ratings` (
  `ratingId` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `ratingLevel` ENUM('E', 'E10+', 'T', 'M', 'NR') NOT NULL,
  PRIMARY KEY (`ratingId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cwgames`.`games`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cwgames`.`games` ;

CREATE TABLE IF NOT EXISTS `cwgames`.`games` (
  `gameId` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `gameTitle` VARCHAR(45) NOT NULL,
  `releaseDate` DATE NOT NULL,
  `ratingId` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`gameId`),
  INDEX `fk_game_rating1_idx` (`ratingId` ASC) VISIBLE,
  CONSTRAINT `fk_game_rating1`
    FOREIGN KEY (`ratingId`)
    REFERENCES `cwgames`.`ratings` (`ratingId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cwgames`.`owners`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cwgames`.`owners` ;

CREATE TABLE IF NOT EXISTS `cwgames`.`owners` (
  `ownerId` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `firstName` VARCHAR(45) NOT NULL,
  `lastName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ownerId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cwgames`.`companies`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cwgames`.`companies` ;

CREATE TABLE IF NOT EXISTS `cwgames`.`companies` (
  `companyId` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `companyName` VARCHAR(45) NOT NULL,
  `isDeveloper` TINYINT NULL,
  `isPublisher` TINYINT NULL,
  PRIMARY KEY (`companyId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cwgames`.`platforms`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cwgames`.`platforms` ;

CREATE TABLE IF NOT EXISTS `cwgames`.`platforms` (
  `platformId` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `platformName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`platformId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cwgames`.`genres`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cwgames`.`genres` ;

CREATE TABLE IF NOT EXISTS `cwgames`.`genres` (
  `genreId` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `genreType` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`genreId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cwgames`.`prices`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cwgames`.`prices` ;

CREATE TABLE IF NOT EXISTS `cwgames`.`prices` (
  `priceId` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `priceValue` DECIMAL(5,2) NOT NULL,
  PRIMARY KEY (`priceId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cwgames`.`gameOwners`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cwgames`.`gameOwners` ;

CREATE TABLE IF NOT EXISTS `cwgames`.`gameOwners` (
  `gameId` INT UNSIGNED NOT NULL,
  `ownerId` INT UNSIGNED NOT NULL,
  `hasPlayed` TINYINT NOT NULL,
  PRIMARY KEY (`gameId`, `ownerId`),
  INDEX `fk_gameowner_owner1_idx` (`ownerId` ASC) VISIBLE,
  INDEX `fk_gameowner_game_idx` (`gameId` ASC) VISIBLE,
  CONSTRAINT `fk_gameowner_game`
    FOREIGN KEY (`gameId`)
    REFERENCES `cwgames`.`games` (`gameId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_gameowner_owner1`
    FOREIGN KEY (`ownerId`)
    REFERENCES `cwgames`.`owners` (`ownerId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cwgames`.`gamePlatforms`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cwgames`.`gamePlatforms` ;

CREATE TABLE IF NOT EXISTS `cwgames`.`gamePlatforms` (
  `gameId` INT UNSIGNED NOT NULL,
  `platformId` INT UNSIGNED NOT NULL,
  `priceId` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`gameId`, `platformId`),
  INDEX `fk_gameplatform_platform1_idx` (`platformId` ASC) VISIBLE,
  INDEX `fk_gameplatform_game1_idx` (`gameId` ASC) VISIBLE,
  INDEX `fk_game_platform_price1_idx` (`priceId` ASC) VISIBLE,
  CONSTRAINT `fk_gameplatform_game1`
    FOREIGN KEY (`gameId`)
    REFERENCES `cwgames`.`games` (`gameId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_gameplatform_platform1`
    FOREIGN KEY (`platformId`)
    REFERENCES `cwgames`.`platforms` (`platformId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_game_platform_price1`
    FOREIGN KEY (`priceId`)
    REFERENCES `cwgames`.`prices` (`priceId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cwgames`.`gameGenres`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cwgames`.`gameGenres` ;

CREATE TABLE IF NOT EXISTS `cwgames`.`gameGenres` (
  `gameId` INT UNSIGNED NOT NULL,
  `genreId` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`gameId`, `genreId`),
  INDEX `fk_gamegenre_genre1_idx` (`genreId` ASC) VISIBLE,
  INDEX `fk_gamegenre_game1_idx` (`gameId` ASC) VISIBLE,
  CONSTRAINT `fk_gamegenre_game1`
    FOREIGN KEY (`gameId`)
    REFERENCES `cwgames`.`games` (`gameId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_gamegenre_genre1`
    FOREIGN KEY (`genreId`)
    REFERENCES `cwgames`.`genres` (`genreId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cwgames`.`gameCompanies`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cwgames`.`gameCompanies` ;

CREATE TABLE IF NOT EXISTS `cwgames`.`gameCompanies` (
  `gameId` INT UNSIGNED NOT NULL,
  `companyId` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`gameId`, `companyId`),
  INDEX `fk_gamecompany_company1_idx` (`companyId` ASC) VISIBLE,
  INDEX `fk_gamecompany_game1_idx` (`gameId` ASC) VISIBLE,
  CONSTRAINT `fk_gamecompany_game1`
    FOREIGN KEY (`gameId`)
    REFERENCES `cwgames`.`games` (`gameId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_gamecompany_company1`
    FOREIGN KEY (`companyId`)
    REFERENCES `cwgames`.`companies` (`companyId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
