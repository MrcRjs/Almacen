SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

DROP SCHEMA IF EXISTS `Almacen` ;
CREATE SCHEMA IF NOT EXISTS `Almacen` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `Almacen` ;

-- -----------------------------------------------------
-- Tipo
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Almacen`.`Tipo` ;

CREATE TABLE IF NOT EXISTS `Almacen`.`Tipo` (
  `idTipo` VARCHAR(3) NOT NULL,
  `Descripcion` VARCHAR(50) NULL,
  `Nombre` VARCHAR(15) NULL,
  PRIMARY KEY (`idTipo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Pieza
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Almacen`.`Pieza` ;

CREATE TABLE IF NOT EXISTS `Almacen`.`Pieza` (
  `Precio` DECIMAL(19,4) NULL,
  `Modelo` TINYINT UNSIGNED NOT NULL,
  `Tipo` VARCHAR(3) NOT NULL,
  CONSTRAINT `idPieza`
    PRIMARY KEY (`Tipo`, `Modelo`),
  CONSTRAINT `fkTipoPieza`
    FOREIGN KEY (`Tipo`)
    REFERENCES `Almacen`.`Tipo` (`idTipo`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE INDEX `fkTipoPiezaIdx` ON `Almacen`.`Pieza` (`Tipo` ASC);


-- -----------------------------------------------------
-- Almacen
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Almacen`.`Almacen` ;

CREATE TABLE IF NOT EXISTS `Almacen`.`Almacen` (
  `Nombre`  VARCHAR(15) NOT NULL,
  `Municipio`  VARCHAR(15) NULL,
  `Estado`  VARCHAR(15) NULL,
  `Calle`   VARCHAR(15) NULL,
  `Colonia` VARCHAR(15) NULL,
  `CP` MEDIUMINT NULL,
  PRIMARY KEY (`Nombre`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Estanteria
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Almacen`.`Estanteria` ;

CREATE TABLE IF NOT EXISTS `Almacen`.`Estanteria` (
  `idEstanteria` VARCHAR(3) NOT NULL,
  `Descripcion` VARCHAR(50) NULL,
  `Almacen` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`idEstanteria`),
  CONSTRAINT `fkAlmacen`
    FOREIGN KEY (`Almacen`)
    REFERENCES `Almacen`.`Almacen` (`Nombre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fkEstanteriaAlmacenIdx` ON `Almacen`.`Estanteria` (`Almacen` ASC);


-- -----------------------------------------------------
-- Existencias
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Almacen`.`Existencias` ;

CREATE TABLE IF NOT EXISTS `Almacen`.`Existencias` (
  `idEstanteria` VARCHAR(3) NOT NULL,
  `PiezaT` VARCHAR(3) NOT NULL,
  `PiezaM` TINYINT UNSIGNED NOT NULL,
  `Cantidad` INT NULL,
  CONSTRAINT pkExist
    PRIMARY KEY (`idEstanteria`, `PiezaT`, `PiezaM`),
  CONSTRAINT `fkEstanteria`
    FOREIGN KEY (`idEstanteria`)
    REFERENCES `Almacen`.`Estanteria` (`idEstanteria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fkPieza`
    FOREIGN KEY (`PiezaT`,`PiezaM`)
    REFERENCES `Almacen`.`Pieza` (`Tipo`, `Modelo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fkPiezaTIdx` ON `Almacen`.`Existencias` (`PiezaT` ASC);

CREATE INDEX `fkPiezaMIdx` ON `Almacen`.`Existencias` (`PiezaM` ASC);

CREATE INDEX `fkEstanteriaIdx` ON `Almacen`.`Existencias` (`idEstanteria` ASC);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
