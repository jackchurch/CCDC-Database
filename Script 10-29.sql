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
-- Table `mydb`.`User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`User` (
  `UserID` INT NOT NULL,
  `FirstName` VARCHAR(45) NOT NULL,
  `LastName` VARCHAR(45) NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`UserID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Password`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Password` (
  `PasswordID` INT NOT NULL AUTO_INCREMENT,
  `Username` VARCHAR(45) NOT NULL,
  `Password` VARBINARY(255) NOT NULL,
  `Salt` VARBINARY(255) NOT NULL,
  `IsActive` BINARY(1) NOT NULL,
  `UserID` INT NOT NULL,
  PRIMARY KEY (`PasswordID`),
  UNIQUE INDEX `PasswordID_UNIQUE` (`PasswordID` ASC) VISIBLE,
  INDEX `Password_User_idx` (`UserID` ASC) VISIBLE,
  CONSTRAINT `Password_User`
    FOREIGN KEY (`UserID`)
    REFERENCES `mydb`.`User` (`UserID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Company`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Company` (
  `CompanyID` INT NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `ContactName` VARCHAR(45) NULL,
  `ContactPhone` VARCHAR(45) NULL,
  `ContactAddress` VARCHAR(100) NULL,
  PRIMARY KEY (`CompanyID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Company_User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Company_User` (
  `CompanyID` INT NOT NULL,
  `UserID` INT NOT NULL,
  PRIMARY KEY (`CompanyID`, `UserID`),
  INDEX `Company_User_User1_idx` (`UserID` ASC) VISIBLE,
  INDEX `Company_User_Company1_idx` (`CompanyID` ASC) VISIBLE,
  CONSTRAINT `Company_User_Company1`
    FOREIGN KEY (`CompanyID`)
    REFERENCES `mydb`.`Company` (`CompanyID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Company_User_User1`
    FOREIGN KEY (`UserID`)
    REFERENCES `mydb`.`User` (`UserID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


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
  `AccountName` VARCHAR(45) NOT NULL,
  `Description` VARCHAR(45) NULL,
  `CompanyID` INT NOT NULL,
  `UserID` INT NOT NULL,
  PRIMARY KEY (`AccountID`),
  INDEX `Account_Company_User1_idx` (`CompanyID` ASC, `UserID` ASC) VISIBLE,
  CONSTRAINT `Account_Company_User1`
    FOREIGN KEY (`CompanyID` , `UserID`)
    REFERENCES `mydb`.`Company_User` (`CompanyID` , `UserID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
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
-- Table `mydb`.`Calendar`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Calendar` (
  `CalendarID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(30) NOT NULL,
  `Location` VARCHAR(100) NULL,
  `Description` VARCHAR(100) NULL,
  PRIMARY KEY (`CalendarID`),
  UNIQUE INDEX `CalendarID_UNIQUE` (`CalendarID` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`NonWorkingDay`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`NonWorkingDay` (
  `NonWorkingDayID` INT NOT NULL AUTO_INCREMENT,
  `Date` DATE NOT NULL,
  `Name` VARCHAR(20) NOT NULL,
  `Description` VARCHAR(45) NOT NULL,
  `CalendarID` INT NOT NULL,
  PRIMARY KEY (`NonWorkingDayID`),
  UNIQUE INDEX `NonWorkingDayID_UNIQUE` (`NonWorkingDayID` ASC) VISIBLE,
  INDEX `NonWorkingDay_Calendar1_idx` (`CalendarID` ASC) VISIBLE,
  CONSTRAINT `NonWorkingDay_Calendar1`
    FOREIGN KEY (`CalendarID`)
    REFERENCES `mydb`.`Calendar` (`CalendarID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Calendar_Account`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Calendar_Account` (
  `CalendarID` INT NOT NULL,
  `AccountID` INT NOT NULL,
  PRIMARY KEY (`CalendarID`, `AccountID`),
  INDEX `Calendar_Account_Account1_idx` (`AccountID` ASC) VISIBLE,
  INDEX `Calendar_Account_Calendar1_idx` (`CalendarID` ASC) VISIBLE,
  CONSTRAINT `Calendar_Account_Calendar1`
    FOREIGN KEY (`CalendarID`)
    REFERENCES `mydb`.`Calendar` (`CalendarID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Calendar_Account_Account1`
    FOREIGN KEY (`AccountID`)
    REFERENCES `mydb`.`Account` (`AccountID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
