-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Permission`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Permission` (
  `PermissionID` INT NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `Code` CHAR(10) NOT NULL,
  `Description` LONGTEXT NULL,
  PRIMARY KEY (`PermissionID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Account`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Account` (
  `AccountID` INT NOT NULL AUTO_INCREMENT,
  `FirstName` VARCHAR(45) NOT NULL,
  `LastName` VARCHAR(45) NOT NULL,
  `Email` VARCHAR(45) NULL,
  `Password` VARBINARY(255) NOT NULL,
  `IsActive` BINARY(0) NULL,
  `Salt` VARCHAR(255) NULL,
  PRIMARY KEY (`AccountID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Account_Permission`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Account_Permission` (
  `AccountID` INT NOT NULL,
  `PermissionID` INT NOT NULL,
  PRIMARY KEY (`AccountID`, `PermissionID`),
  INDEX `Account_Permission_Permission1_idx` (`PermissionID` ASC) VISIBLE,
  INDEX `Account_Permission_Account1_idx` (`AccountID` ASC) VISIBLE,
  CONSTRAINT `Account_Permission_Account1`
    FOREIGN KEY (`AccountID`)
    REFERENCES `mydb`.`Account` (`AccountID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Account_Permission_Permission1`
    FOREIGN KEY (`PermissionID`)
    REFERENCES `mydb`.`Permission` (`PermissionID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`NonWorkingDay`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`NonWorkingDay` (
  `NonWorkingDayID` INT NOT NULL AUTO_INCREMENT,
  `Date` DATE NOT NULL,
  `Name` VARCHAR(20) NOT NULL,
  `Description` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`NonWorkingDayID`),
  UNIQUE INDEX `NonWorkingDayID_UNIQUE` (`NonWorkingDayID` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Calendar`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Calendar` (
  `CalendarID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(30) NOT NULL,
  `Location` VARCHAR(100) NULL,
  `Description` VARCHAR(100) NULL,
  `AccountID` INT NOT NULL,
  PRIMARY KEY (`CalendarID`),
  UNIQUE INDEX `CalendarID_UNIQUE` (`CalendarID` ASC) VISIBLE,
  INDEX `Calendar_Account1_idx` (`AccountID` ASC) VISIBLE,
  CONSTRAINT `Calendar_Account1`
    FOREIGN KEY (`AccountID`)
    REFERENCES `mydb`.`Account` (`AccountID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Calendar_NonWorkingDay`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Calendar_NonWorkingDay` (
  `CalendarID` INT NOT NULL,
  `NonWorkingDayID` INT NOT NULL,
  PRIMARY KEY (`CalendarID`, `NonWorkingDayID`),
  INDEX `Calendar_NonWorkingDay_NonWorkingDay1_idx` (`NonWorkingDayID` ASC) VISIBLE,
  INDEX `Calendar_NonWorkingDay_Calendar1_idx` (`CalendarID` ASC) VISIBLE,
  CONSTRAINT `Calendar_NonWorkingDay_Calendar1`
    FOREIGN KEY (`CalendarID`)
    REFERENCES `mydb`.`Calendar` (`CalendarID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Calendar_NonWorkingDay_NonWorkingDay1`
    FOREIGN KEY (`NonWorkingDayID`)
    REFERENCES `mydb`.`NonWorkingDay` (`NonWorkingDayID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
