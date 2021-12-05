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
-- -----------------------------------------------------
-- Schema universidad
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema universidad
-- -----------------------------------------------------
create table hola;
CREATE SCHEMA IF NOT EXISTS `universidad` DEFAULT CHARACTER SET utf8 COLLATE utf8_spanish_ci ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `universidad`.`centro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `universidad`.`centro` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(50) NULL,
  `direccion` VARCHAR(100) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `universidad`.`pueblo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `universidad`.`pueblo` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(50) NULL,
  `provincia` VARCHAR(50) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`alumno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`alumno` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(50) NULL,
  `paterno` VARCHAR(50) NULL,
  `materno` VARCHAR(50) NULL,
  `matricula` INT NOT NULL,
  `centro_id` INT NOT NULL,
  `pueblo_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_alumno_centro_idx` (`centro_id` ASC) VISIBLE,
  INDEX `fk_alumno_pueblo1_idx` (`pueblo_id` ASC) VISIBLE,
  CONSTRAINT `fk_alumno_centro`
    FOREIGN KEY (`centro_id`)
    REFERENCES `universidad`.`centro` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_alumno_pueblo1`
    FOREIGN KEY (`pueblo_id`)
    REFERENCES `universidad`.`pueblo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `universidad`.`compañia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `universidad`.`compañia` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(50) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`autobus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`autobus` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `matricula` VARCHAR(10) NULL,
  `asientos` INT NULL,
  `compañia_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_autobus_compañia1_idx` (`compañia_id` ASC) VISIBLE,
  CONSTRAINT `fk_autobus_compañia1`
    FOREIGN KEY (`compañia_id`)
    REFERENCES `universidad`.`compañia` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`alumno_autobus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`alumno_autobus` (
  `autobus_id` INT NOT NULL,
  `alumno_id` INT NOT NULL,
  INDEX `fk_alumno_autobus_autobus1_idx` (`autobus_id` ASC) VISIBLE,
  INDEX `fk_alumno_autobus_alumno1_idx` (`alumno_id` ASC) VISIBLE,
  CONSTRAINT `fk_alumno_autobus_autobus1`
    FOREIGN KEY (`autobus_id`)
    REFERENCES `mydb`.`autobus` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_alumno_autobus_alumno1`
    FOREIGN KEY (`alumno_id`)
    REFERENCES `mydb`.`alumno` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`autobus_centro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`autobus_centro` (
  `centro_id` INT NOT NULL,
  `autobus_id` INT NOT NULL,
  INDEX `fk_autobus_centro_centro1_idx` (`centro_id` ASC) VISIBLE,
  INDEX `fk_autobus_centro_autobus1_idx` (`autobus_id` ASC) VISIBLE,
  CONSTRAINT `fk_autobus_centro_centro1`
    FOREIGN KEY (`centro_id`)
    REFERENCES `universidad`.`centro` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_autobus_centro_autobus1`
    FOREIGN KEY (`autobus_id`)
    REFERENCES `mydb`.`autobus` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`parada`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`parada` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `calle` VARCHAR(50) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`autobus_parada`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`autobus_parada` (
  `autobus_id` INT NOT NULL,
  `parada_id` INT NOT NULL,
  INDEX `fk_autobus_parada_autobus1_idx` (`autobus_id` ASC) VISIBLE,
  INDEX `fk_autobus_parada_parada1_idx` (`parada_id` ASC) VISIBLE,
  CONSTRAINT `fk_autobus_parada_autobus1`
    FOREIGN KEY (`autobus_id`)
    REFERENCES `mydb`.`autobus` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_autobus_parada_parada1`
    FOREIGN KEY (`parada_id`)
    REFERENCES `mydb`.`parada` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `universidad` ;

-- -----------------------------------------------------
-- Table `universidad`.`curso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `universidad`.`curso` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(50) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `universidad`.`alumno_curso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `universidad`.`alumno_curso` (
  `curso_id` INT NOT NULL,
  `alumno_id` INT NOT NULL,
  INDEX `fk_alumno_curso_curso_idx` (`curso_id` ASC) VISIBLE,
  INDEX `fk_alumno_curso_alumno1_idx` (`alumno_id` ASC) VISIBLE,
  CONSTRAINT `fk_alumno_curso_curso`
    FOREIGN KEY (`curso_id`)
    REFERENCES `universidad`.`curso` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_alumno_curso_alumno1`
    FOREIGN KEY (`alumno_id`)
    REFERENCES `mydb`.`alumno` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
