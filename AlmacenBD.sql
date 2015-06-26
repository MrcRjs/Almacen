SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

DROP SCHEMA IF EXISTS `Almacen` ;
CREATE SCHEMA IF NOT EXISTS `Almacen` DEFAULT CHARACTER SET utf8 ;
USE `Almacen` ;

-- -----------------------------------------------------
-- Table `Almacen`.`Almacen`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Almacen`.`Almacen` ;

CREATE TABLE IF NOT EXISTS `Almacen`.`Almacen` (
  `idAlmacen` CHAR(3) NOT NULL,
  `Nombre` VARCHAR(15) NOT NULL,
  `Municipio` VARCHAR(15) NULL DEFAULT NULL,
  `Estado` VARCHAR(15) NULL DEFAULT NULL,
  `Calle` VARCHAR(15) NULL DEFAULT NULL,
  `Colonia` VARCHAR(15) NULL DEFAULT NULL,
  `CP` MEDIUMINT(9) NULL DEFAULT NULL,
  PRIMARY KEY (`idAlmacen`),
  INDEX `idAlmacenIdx` (`idAlmacen` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `Almacen`.`Estanteria`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Almacen`.`Estanteria` ;

CREATE TABLE IF NOT EXISTS `Almacen`.`Estanteria` (
  `idEstanteria` SMALLINT(6) NOT NULL AUTO_INCREMENT,
  `Descripcion` VARCHAR(50) NULL DEFAULT NULL,
  `idAlmacen` CHAR(3) NOT NULL,
  PRIMARY KEY (`idEstanteria`),
  INDEX `fkAlmacn` (`idAlmacen` ASC),
  CONSTRAINT `fkAlmacn`
    FOREIGN KEY (`idAlmacen`)
    REFERENCES `Almacen`.`Almacen` (`idAlmacen`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `Almacen`.`Tipo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Almacen`.`Tipo` ;

CREATE TABLE IF NOT EXISTS `Almacen`.`Tipo` (
  `idTipo` VARCHAR(3) NOT NULL,
  `Descripcion` VARCHAR(50) NULL DEFAULT NULL,
  `Nombre` VARCHAR(15) NULL DEFAULT NULL,
  PRIMARY KEY (`idTipo`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `Almacen`.`Pieza`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Almacen`.`Pieza` ;

CREATE TABLE IF NOT EXISTS `Almacen`.`Pieza` (
  `Precio` DECIMAL(19,4) NULL DEFAULT NULL,
  `Modelo` TINYINT(3) UNSIGNED NOT NULL,
  `Descripcion` VARCHAR(50) NULL DEFAULT NULL,
  `Tipo` VARCHAR(3) NOT NULL,
  PRIMARY KEY (`Tipo`, `Modelo`),
  INDEX `fkPiezaTipo` (`Tipo` ASC, `Modelo` ASC),
  CONSTRAINT `fkTipoPieza`
    FOREIGN KEY (`Tipo`)
    REFERENCES `Almacen`.`Tipo` (`idTipo`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `Almacen`.`Existencias`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Almacen`.`Existencias` ;

CREATE TABLE IF NOT EXISTS `Almacen`.`Existencias` (
  `idEstanteria` SMALLINT(6) NOT NULL,
  `PiezaT` VARCHAR(3) NOT NULL,
  `PiezaM` TINYINT(3) UNSIGNED NOT NULL,
  `Cantidad` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`PiezaT`, `PiezaM`, `idEstanteria`),
  INDEX `fkPieza` (`PiezaT` ASC, `PiezaM` ASC),
  INDEX `fkEstanteria` (`idEstanteria` ASC),
  CONSTRAINT `fkEstanteria`
    FOREIGN KEY (`idEstanteria`)
    REFERENCES `Almacen`.`Estanteria` (`idEstanteria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fkPieza`
    FOREIGN KEY (`PiezaT` , `PiezaM`)
    REFERENCES `Almacen`.`Pieza` (`Tipo` , `Modelo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
