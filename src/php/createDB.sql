-- MySQL Script generated by MySQL Workbench
-- 02/13/17 13:56:00
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema friendshipTroopers
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema friendshipTroopers
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `friendshipTroopers` DEFAULT CHARACTER SET utf8 ;
USE `friendshipTroopers` ;

-- -----------------------------------------------------
-- Table `friendshipTroopers`.`PLANET`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `friendshipTroopers`.`PLANET` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(30) NOT NULL,
  `description` VARCHAR(500) NOT NULL,
  `history` TEXT NULL,
  `imagePath` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC),
  UNIQUE INDEX `imagePath_UNIQUE` (`imagePath` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `friendshipTroopers`.`ROLE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `friendshipTroopers`.`ROLE` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `label` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `label_UNIQUE` (`label` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `friendshipTroopers`.`USER`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `friendshipTroopers`.`USER` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `firstName` VARCHAR(45) NULL,
  `lastName` VARCHAR(45) NULL,
  `username` VARCHAR(30) NOT NULL,
  `mail` VARCHAR(100) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `description` VARCHAR(500) NULL,
  `birthDate` DATE NULL,
  `planetId` INT NOT NULL,
  `roleId` INT NOT NULL,
  `activated` TINYINT NOT NULL,
  PRIMARY KEY (`id`, `planetId`, `roleId`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC),
  UNIQUE INDEX `mail_UNIQUE` (`mail` ASC),
  INDEX `fk_USER_PLANET1_idx` (`planetId` ASC),
  INDEX `fk_USER_ROLE2_idx` (`roleId` ASC),
  CONSTRAINT `fk_USER_PLANET1`
    FOREIGN KEY (`planetId`)
    REFERENCES `friendshipTroopers`.`PLANET` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_USER_ROLE2`
    FOREIGN KEY (`roleId`)
    REFERENCES `friendshipTroopers`.`ROLE` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `friendshipTroopers`.`AVATAR`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `friendshipTroopers`.`AVATAR` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `imagePath` VARCHAR(100) NOT NULL,
  `description` VARCHAR(500) NOT NULL,
  `pack` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `imagePath_UNIQUE` (`imagePath` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `friendshipTroopers`.`BADGE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `friendshipTroopers`.`BADGE` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `label` VARCHAR(60) NOT NULL,
  `description` VARCHAR(500) NOT NULL,
  `funFact` TEXT NULL,
  `imagePath` VARCHAR(100) NOT NULL,
  `locked` TINYINT NULL,
  `requirement` INT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `label_UNIQUE` (`label` ASC),
  UNIQUE INDEX `imagePath_UNIQUE` (`imagePath` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `friendshipTroopers`.`RIDDLE_TYPE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `friendshipTroopers`.`RIDDLE_TYPE` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `label` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `label_UNIQUE` (`label` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `friendshipTroopers`.`RIDDLE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `friendshipTroopers`.`RIDDLE` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(100) NOT NULL,
  `description` VARCHAR(500) NOT NULL,
  `level` INT NOT NULL,
  `minReward` INT NOT NULL,
  `maxReward` INT NOT NULL,
  `nbParticipants` INT NOT NULL,
  `riddleTypeId` INT NOT NULL,
  PRIMARY KEY (`id`, `riddleTypeId`),
  UNIQUE INDEX `title_UNIQUE` (`title` ASC),
  --UNIQUE INDEX `description_UNIQUE` (`description` ASC),
  INDEX `fk_RIDDLE_RIDDLE_TYPE1_idx` (`riddleTypeId` ASC),
  CONSTRAINT `fk_RIDDLE_RIDDLE_TYPE1`
    FOREIGN KEY (`riddleTypeId`)
    REFERENCES `friendshipTroopers`.`RIDDLE_TYPE` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `friendshipTroopers`.`EVENT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `friendshipTroopers`.`EVENT` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `startDate` DATETIME NOT NULL,
  `endDate` DATETIME NOT NULL,
  `description` VARCHAR(500) NOT NULL,
  `RIDDLE_id` INT NOT NULL,
  PRIMARY KEY (`id`, `RIDDLE_id`),
  INDEX `fk_EVENT_RIDDLE1_idx` (`RIDDLE_id` ASC),
  CONSTRAINT `fk_EVENT_RIDDLE1`
    FOREIGN KEY (`RIDDLE_id`)
    REFERENCES `friendshipTroopers`.`RIDDLE` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `friendshipTroopers`.`RIDDLEPHASE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `friendshipTroopers`.`RIDDLEPHASE` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `step` INT NOT NULL,
  `description` VARCHAR(500) NOT NULL,
  `answer` VARCHAR(500) NULL,
  `RIDDLE_id` INT NOT NULL,
  PRIMARY KEY (`id`, `RIDDLE_id`),
  UNIQUE INDEX `step_UNIQUE` (`step` ASC),
  INDEX `fk_RIDDLEPHASE_RIDDLE1_idx` (`RIDDLE_id` ASC),
  CONSTRAINT `fk_RIDDLEPHASE_RIDDLE1`
    FOREIGN KEY (`RIDDLE_id`)
    REFERENCES `friendshipTroopers`.`RIDDLE` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `friendshipTroopers`.`SMILEY`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `friendshipTroopers`.`SMILEY` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `code` VARCHAR(20) NULL,
  `label` VARCHAR(20) NULL,
  `price` INT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `friendshipTroopers`.`INTEREST`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `friendshipTroopers`.`INTEREST` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `label` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `friendshipTroopers`.`IMGUPLOAD`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `friendshipTroopers`.`IMGUPLOAD` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `imagePath` VARCHAR(100) NOT NULL,
  `alt` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `imagePath_UNIQUE` (`imagePath` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `friendshipTroopers`.`PUBLICATION`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `friendshipTroopers`.`PUBLICATION` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(100) NULL,
  `content` TEXT NOT NULL,
  `publishDate` DATETIME NOT NULL,
  `modified` TINYINT NULL,
  `userId` INT NOT NULL,
  `imageUploadId` INT NOT NULL,
  PRIMARY KEY (`id`, `userId`),
  INDEX `fk_POST_USER1_idx` (`userId` ASC),
  INDEX `fk_PUBLICATION_IMGUPLOAD1_idx` (`imageUploadId` ASC),
  CONSTRAINT `fk_POST_USER1`
    FOREIGN KEY (`userId`)
    REFERENCES `friendshipTroopers`.`USER` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PUBLICATION_IMGUPLOAD1`
    FOREIGN KEY (`imageUploadId`)
    REFERENCES `friendshipTroopers`.`IMGUPLOAD` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `friendshipTroopers`.`USER_INTEREST`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `friendshipTroopers`.`USER_INTEREST` (
  `userId` INT NOT NULL,
  `interestId` INT NOT NULL,
  PRIMARY KEY (`userId`, `interestId`),
  INDEX `fk_USER_has_INTEREST_INTEREST1_idx` (`interestId` ASC),
  INDEX `fk_USER_has_INTEREST_USER1_idx` (`userId` ASC),
  CONSTRAINT `fk_USER_has_INTEREST_USER1`
    FOREIGN KEY (`userId`)
    REFERENCES `friendshipTroopers`.`USER` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_USER_has_INTEREST_INTEREST1`
    FOREIGN KEY (`interestId`)
    REFERENCES `friendshipTroopers`.`INTEREST` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `friendshipTroopers`.`USER_SMILEY`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `friendshipTroopers`.`USER_SMILEY` (
  `userId` INT NOT NULL,
  `smileyId` INT NOT NULL,
  `lastUseDate` DATETIME NULL,
  `obtentionDate` DATETIME NULL,
  PRIMARY KEY (`userId`, `smileyId`),
  INDEX `fk_USER_has_SMILEY_SMILEY1_idx` (`smileyId` ASC),
  INDEX `fk_USER_has_SMILEY_USER1_idx` (`userId` ASC),
  CONSTRAINT `fk_USER_has_SMILEY_USER1`
    FOREIGN KEY (`userId`)
    REFERENCES `friendshipTroopers`.`USER` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_USER_has_SMILEY_SMILEY1`
    FOREIGN KEY (`smileyId`)
    REFERENCES `friendshipTroopers`.`SMILEY` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `friendshipTroopers`.`USER_AVATAR`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `friendshipTroopers`.`USER_AVATAR` (
  `userId` INT NOT NULL,
  `avatarId` INT NOT NULL,
  `currentAvatar` TINYINT NOT NULL,
  PRIMARY KEY (`userId`, `avatarId`),
  INDEX `fk_USER_has_AVATAR_AVATAR1_idx` (`avatarId` ASC),
  INDEX `fk_USER_has_AVATAR_USER1_idx` (`userId` ASC),
  CONSTRAINT `fk_USER_has_AVATAR_USER1`
    FOREIGN KEY (`userId`)
    REFERENCES `friendshipTroopers`.`USER` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_USER_has_AVATAR_AVATAR1`
    FOREIGN KEY (`avatarId`)
    REFERENCES `friendshipTroopers`.`AVATAR` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `friendshipTroopers`.`USER_BADGE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `friendshipTroopers`.`USER_BADGE` (
  `userId` INT NOT NULL,
  `badgeId` INT NOT NULL,
  `display` TINYINT NOT NULL,
  PRIMARY KEY (`userId`, `badgeId`),
  INDEX `fk_USER_has_BADGE_BADGE1_idx` (`badgeId` ASC),
  INDEX `fk_USER_has_BADGE_USER1_idx` (`userId` ASC),
  CONSTRAINT `fk_USER_has_BADGE_USER1`
    FOREIGN KEY (`userId`)
    REFERENCES `friendshipTroopers`.`USER` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_USER_has_BADGE_BADGE1`
    FOREIGN KEY (`badgeId`)
    REFERENCES `friendshipTroopers`.`BADGE` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `friendshipTroopers`.`USER_RIDDLE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `friendshipTroopers`.`USER_RIDDLE` (
  `userId` INT NOT NULL,
  `riddleId` INT NOT NULL,
  `startDate` DATETIME NULL,
  `endDate` DATETIME NULL,
  `current` TINYINT NULL,
  PRIMARY KEY (`userId`, `riddleId`),
  INDEX `fk_USER_has_RIDDLE_RIDDLE1_idx` (`riddleId` ASC),
  INDEX `fk_USER_has_RIDDLE_USER1_idx` (`userId` ASC),
  CONSTRAINT `fk_USER_has_RIDDLE_USER1`
    FOREIGN KEY (`userId`)
    REFERENCES `friendshipTroopers`.`USER` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_USER_has_RIDDLE_RIDDLE1`
    FOREIGN KEY (`riddleId`)
    REFERENCES `friendshipTroopers`.`RIDDLE` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `friendshipTroopers`.`LIKE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `friendshipTroopers`.`LIKE` (
  `userId` INT NOT NULL,
  `publicationId` INT NOT NULL,
  PRIMARY KEY (`userId`, `publicationId`),
  INDEX `fk_PUBLICATION_has_USER_USER1_idx` (`userId` ASC),
  INDEX `fk_PUBLICATION_has_USER_PUBLICATION1_idx` (`publicationId` ASC),
  CONSTRAINT `fk_PUBLICATION_has_USER_PUBLICATION1`
    FOREIGN KEY (`publicationId`)
    REFERENCES `friendshipTroopers`.`PUBLICATION` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PUBLICATION_has_USER_USER1`
    FOREIGN KEY (`userId`)
    REFERENCES `friendshipTroopers`.`USER` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `friendshipTroopers`.`COMMENT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `friendshipTroopers`.`COMMENT` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `content` TEXT NOT NULL,
  `userId` INT NOT NULL,
  `publicationId` INT NOT NULL,
  `publishDate` DATETIME NULL,
  `modified` TINYINT NULL,
  INDEX `fk_USER_has_PUBLICATION_PUBLICATION1_idx` (`publicationId` ASC),
  INDEX `fk_USER_has_PUBLICATION_USER1_idx` (`userId` ASC),
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_USER_has_PUBLICATION_USER1`
    FOREIGN KEY (`userId`)
    REFERENCES `friendshipTroopers`.`USER` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_USER_has_PUBLICATION_PUBLICATION1`
    FOREIGN KEY (`publicationId`)
    REFERENCES `friendshipTroopers`.`PUBLICATION` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `friendshipTroopers`.`SIGNALEMENT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `friendshipTroopers`.`SIGNALEMENT` (
  `PUBLICATION_id` INT NOT NULL,
  `USER_id` INT NOT NULL,
  INDEX `fk_SIGNALEMENT_PUBLICATION1_idx` (`PUBLICATION_id` ASC),
  INDEX `fk_SIGNALEMENT_USER1_idx` (`USER_id` ASC),
  PRIMARY KEY (`PUBLICATION_id`, `USER_id`),
  CONSTRAINT `fk_SIGNALEMENT_PUBLICATION1`
    FOREIGN KEY (`PUBLICATION_id`)
    REFERENCES `friendshipTroopers`.`PUBLICATION` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_SIGNALEMENT_USER1`
    FOREIGN KEY (`USER_id`)
    REFERENCES `friendshipTroopers`.`USER` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
