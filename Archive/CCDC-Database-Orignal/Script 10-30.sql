-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema CalendarDatabases
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema CalendarDatabases
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `CalendarDatabases` DEFAULT CHARACTER SET utf8 ;
USE `CalendarDatabases` ;

-- -----------------------------------------------------
-- Table `CalendarDatabases`.`Permission`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CalendarDatabases`.`Permission` (
  `PermissionID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NOT NULL,
  `Code` CHAR(10) NOT NULL,
  `Description` LONGTEXT NULL,
  PRIMARY KEY (`PermissionID`),
  UNIQUE INDEX `PermissionID_UNIQUE` (`PermissionID` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CalendarDatabases`.`User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CalendarDatabases`.`User` (
  `UserID` INT NOT NULL AUTO_INCREMENT,
  `FirstName` VARCHAR(45) NOT NULL,
  `LastName` VARCHAR(45) NOT NULL,
  `Email` VARCHAR(45) NULL,
  `Password` VARBINARY(255) NOT NULL,
  `Salt` VARCHAR(255) NULL,
  `IsActive` BINARY(0) NOT NULL,
  PRIMARY KEY (`UserID`),
  UNIQUE INDEX `UserID_UNIQUE` (`UserID` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CalendarDatabases`.`Permission_User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CalendarDatabases`.`Permission_User` (
  `PermissionID` INT NOT NULL,
  `UserID` INT NOT NULL,
  PRIMARY KEY (`PermissionID`, `UserID`),
  INDEX `Permission_User_User1_idx` (`UserID` ASC) VISIBLE,
  INDEX `Permission_User_Permission_idx` (`PermissionID` ASC) VISIBLE,
  CONSTRAINT `Permission_User_Permission`
    FOREIGN KEY (`PermissionID`)
    REFERENCES `CalendarDatabases`.`Permission` (`PermissionID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Permission_User_User1`
    FOREIGN KEY (`UserID`)
    REFERENCES `CalendarDatabases`.`User` (`UserID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CalendarDatabases`.`Calendar`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CalendarDatabases`.`Calendar` (
  `CalendarID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NOT NULL,
  `Location` VARCHAR(45) NULL,
  `Description` VARCHAR(45) NULL,
  `UserID` INT NOT NULL,
  PRIMARY KEY (`CalendarID`),
  UNIQUE INDEX `CalendarID_UNIQUE` (`CalendarID` ASC) VISIBLE,
  INDEX `Calendar_User1_idx` (`UserID` ASC) VISIBLE,
  CONSTRAINT `Calendar_User1`
    FOREIGN KEY (`UserID`)
    REFERENCES `CalendarDatabases`.`User` (`UserID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CalendarDatabases`.`NonWorkingDay`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CalendarDatabases`.`NonWorkingDay` (
  `NonWorkingDayID` INT NOT NULL AUTO_INCREMENT,
  `Date` DATE NOT NULL,
  `Name` VARCHAR(20) NOT NULL,
  `Description` MEDIUMTEXT NULL,
  PRIMARY KEY (`NonWorkingDayID`),
  UNIQUE INDEX `NonWorkingDayID_UNIQUE` (`NonWorkingDayID` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CalendarDatabases`.`Calendar_NonWorkingDay`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CalendarDatabases`.`Calendar_NonWorkingDay` (
  `CalendarID` INT NOT NULL,
  `NonWorkingDayID` INT NOT NULL,
  PRIMARY KEY (`CalendarID`, `NonWorkingDayID`),
  INDEX `Calendar_NonWorkingDay_NonWorkingDay1_idx` (`NonWorkingDayID` ASC) VISIBLE,
  INDEX `Calendar_NonWorkingDay_Calendar1_idx` (`CalendarID` ASC) VISIBLE,
  CONSTRAINT `Calendar_NonWorkingDay_Calendar1`
    FOREIGN KEY (`CalendarID`)
    REFERENCES `CalendarDatabases`.`Calendar` (`CalendarID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Calendar_NonWorkingDay_NonWorkingDay1`
    FOREIGN KEY (`NonWorkingDayID`)
    REFERENCES `CalendarDatabases`.`NonWorkingDay` (`NonWorkingDayID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
