-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema calendardatabases
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema calendardatabases
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `calendardatabases` DEFAULT CHARACTER SET utf8 ;
USE `calendardatabases` ;

-- -----------------------------------------------------
-- Table `calendardatabases`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `calendardatabases`.`user` (
  `username` VARCHAR(20) NOT NULL,
  `password` VARCHAR(20) NULL,
  `firstname` VARCHAR(20) NULL,
  `lastname` VARCHAR(20) NULL,
  PRIMARY KEY (`username`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `calendardatabases`.`calendar`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `calendardatabases`.`calendar` (
  `calendar_code` VARCHAR(10) NOT NULL,
  `calendar_name` VARCHAR(45) NULL,
  `place` VARCHAR(45) NULL,
  `description` VARCHAR(200) NULL,
  PRIMARY KEY (`calendar_code`),
  UNIQUE INDEX `calendar_code_UNIQUE` (`calendar_code` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `calendardatabases`.`nonworkingday`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `calendardatabases`.`nonworkingday` (
  `nwday_code` VARCHAR(10) NOT NULL,
  `nwday_name` VARCHAR(45) NULL,
  `date` DATE NULL,
  PRIMARY KEY (`nwday_code`),
  UNIQUE INDEX `nwday_code_UNIQUE` (`nwday_code` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `calendardatabases`.`calendarnonworkingday`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `calendardatabases`.`calendarnonworkingday` (
  `calendar_code` VARCHAR(10) NOT NULL,
  `nwday_code` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`calendar_code`, `nwday_code`),
  INDEX `fk_nonworkingday_has_calendar_calendar1_idx` (`calendar_code` ASC) VISIBLE,
  INDEX `fk_nonworkingday_has_calendar_nonworkingday_idx` (`nwday_code` ASC) VISIBLE,
  CONSTRAINT `fk_nonworkingday_has_calendar_nonworkingday`
    FOREIGN KEY (`nwday_code`)
    REFERENCES `calendardatabases`.`nonworkingday` (`nwday_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_nonworkingday_has_calendar_calendar1`
    FOREIGN KEY (`calendar_code`)
    REFERENCES `calendardatabases`.`calendar` (`calendar_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `calendardatabases`.`usercalendar`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `calendardatabases`.`usercalendar` (
  `username` VARCHAR(20) NOT NULL,
  `calendar_code` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`username`, `calendar_code`),
  INDEX `fk_user_has_calendar_calendar1_idx` (`calendar_code` ASC) VISIBLE,
  INDEX `fk_user_has_calendar_user1_idx` (`username` ASC) VISIBLE,
  CONSTRAINT `fk_user_has_calendar_user1`
    FOREIGN KEY (`username`)
    REFERENCES `calendardatabases`.`user` (`username`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_calendar_calendar1`
    FOREIGN KEY (`calendar_code`)
    REFERENCES `calendardatabases`.`calendar` (`calendar_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
