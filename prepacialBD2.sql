-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema billetera
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema aseguradorasa
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema aseguradorasa
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `aseguradorasa` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `aseguradorasa` ;

-- -----------------------------------------------------
-- Table `aseguradorasa`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aseguradorasa`.`users` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NULL DEFAULT NULL,
  `EMAIL` VARCHAR(100) NULL DEFAULT NULL,
  `PASSWORD` VARCHAR(100) NULL DEFAULT NULL,
  `PHONE` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id` (`id` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `aseguradorasa`.`juzgado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aseguradorasa`.`juzgado` (
  `ID` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `JUZGADO` VARCHAR(200) NULL DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID` (`ID` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `aseguradorasa`.`proceso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aseguradorasa`.`proceso` (
  `ID` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `TIPO` VARCHAR(100) NULL DEFAULT NULL,
  `id_juz` INT NULL DEFAULT NULL,
  `juzgado_ID` BIGINT UNSIGNED NOT NULL,
  PRIMARY KEY (`ID`, `juzgado_ID`),
  UNIQUE INDEX `ID` (`ID` ASC) VISIBLE,
  INDEX `fk_proceso_juzgado_idx` (`juzgado_ID` ASC) VISIBLE,
  CONSTRAINT `fk_proceso_juzgado`
    FOREIGN KEY (`juzgado_ID`)
    REFERENCES `aseguradorasa`.`juzgado` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `aseguradorasa`.`expediente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aseguradorasa`.`expediente` (
  `ID` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `CONDUCTOR` VARCHAR(100) NULL DEFAULT NULL,
  `ID_AS` INT NULL DEFAULT NULL,
  `NO_CASO` INT NULL DEFAULT NULL,
  `ID_PRO` INT NULL DEFAULT NULL,
  `FECHA` DATE NULL DEFAULT NULL,
  `aseguradora_ID` BIGINT UNSIGNED NOT NULL,
  `proceso_ID` BIGINT UNSIGNED NOT NULL,
  `proceso_juzgado_ID` BIGINT UNSIGNED NOT NULL,
  PRIMARY KEY (`ID`, `aseguradora_ID`, `proceso_ID`, `proceso_juzgado_ID`),
  UNIQUE INDEX `ID` (`ID` ASC) VISIBLE,
  INDEX `fk_expediente_aseguradora1_idx` (`aseguradora_ID` ASC) VISIBLE,
  INDEX `fk_expediente_proceso1_idx` (`proceso_ID` ASC, `proceso_juzgado_ID` ASC) VISIBLE,
  CONSTRAINT `fk_expediente_aseguradora1`
    FOREIGN KEY (`aseguradora_ID`)
    REFERENCES `aseguradorasa`.`aseguradora` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_expediente_proceso1`
    FOREIGN KEY (`proceso_ID` , `proceso_juzgado_ID`)
    REFERENCES `aseguradorasa`.`proceso` (`ID` , `juzgado_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `aseguradorasa`.`reportes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aseguradorasa`.`reportes` (
  `ID` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `REPO` VARCHAR(100) NULL DEFAULT NULL,
  `DESCRIPCION` VARCHAR(500) NULL DEFAULT NULL,
  `ID_AS` INT NULL DEFAULT NULL,
  `ID_EX` INT NULL DEFAULT NULL,
  `ID_US` INT NULL DEFAULT NULL,
  `FECHA` TIMESTAMP NULL DEFAULT NULL,
  `users_id` BIGINT UNSIGNED NOT NULL,
  `expediente_ID` BIGINT UNSIGNED NOT NULL,
  `expediente_aseguradora_ID` BIGINT UNSIGNED NOT NULL,
  `expediente_proceso_ID` BIGINT UNSIGNED NOT NULL,
  `expediente_proceso_juzgado_ID` BIGINT UNSIGNED NOT NULL,
  PRIMARY KEY (`ID`, `users_id`, `expediente_ID`, `expediente_aseguradora_ID`, `expediente_proceso_ID`, `expediente_proceso_juzgado_ID`),
  UNIQUE INDEX `ID` (`ID` ASC) VISIBLE,
  INDEX `fk_reportes_users1_idx` (`users_id` ASC) VISIBLE,
  INDEX `fk_reportes_expediente1_idx` (`expediente_ID` ASC, `expediente_aseguradora_ID` ASC, `expediente_proceso_ID` ASC, `expediente_proceso_juzgado_ID` ASC) VISIBLE,
  CONSTRAINT `fk_reportes_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `aseguradorasa`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reportes_expediente1`
    FOREIGN KEY (`expediente_ID` , `expediente_aseguradora_ID` , `expediente_proceso_ID` , `expediente_proceso_juzgado_ID`)
    REFERENCES `aseguradorasa`.`expediente` (`ID` , `aseguradora_ID` , `proceso_ID` , `proceso_juzgado_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `aseguradorasa`.`aseguradora`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aseguradorasa`.`aseguradora` (
  `ID` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NULL DEFAULT NULL,
  `ENCARGADO` VARCHAR(100) NULL DEFAULT NULL,
  `UBICACION` VARCHAR(255) NULL DEFAULT NULL,
  `reportes_ID` BIGINT UNSIGNED NOT NULL,
  `reportes_users_id` BIGINT UNSIGNED NOT NULL,
  `reportes_expediente_ID` BIGINT UNSIGNED NOT NULL,
  `reportes_expediente_aseguradora_ID` BIGINT UNSIGNED NOT NULL,
  `reportes_expediente_proceso_ID` BIGINT UNSIGNED NOT NULL,
  `reportes_expediente_proceso_juzgado_ID` BIGINT UNSIGNED NOT NULL,
  PRIMARY KEY (`ID`, `reportes_ID`, `reportes_users_id`, `reportes_expediente_ID`, `reportes_expediente_aseguradora_ID`, `reportes_expediente_proceso_ID`, `reportes_expediente_proceso_juzgado_ID`),
  UNIQUE INDEX `ID` (`ID` ASC) VISIBLE,
  INDEX `fk_aseguradora_reportes1_idx` (`reportes_ID` ASC, `reportes_users_id` ASC, `reportes_expediente_ID` ASC, `reportes_expediente_aseguradora_ID` ASC, `reportes_expediente_proceso_ID` ASC, `reportes_expediente_proceso_juzgado_ID` ASC) VISIBLE,
  CONSTRAINT `fk_aseguradora_reportes1`
    FOREIGN KEY (`reportes_ID` , `reportes_users_id` , `reportes_expediente_ID` , `reportes_expediente_aseguradora_ID` , `reportes_expediente_proceso_ID` , `reportes_expediente_proceso_juzgado_ID`)
    REFERENCES `aseguradorasa`.`reportes` (`ID` , `users_id` , `expediente_ID` , `expediente_aseguradora_ID` , `expediente_proceso_ID` , `expediente_proceso_juzgado_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
