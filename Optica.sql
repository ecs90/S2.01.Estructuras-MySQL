SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Optica
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `Optica` ;

-- -----------------------------------------------------
-- Schema Optica
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Optica` DEFAULT CHARACTER SET utf8 ;
USE `Optica` ;

-- -----------------------------------------------------
-- Table `Optica`.`direccion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Optica`.`direccion` ;

CREATE TABLE IF NOT EXISTS `Optica`.`direccion` (
  `direccion_id` INT NOT NULL AUTO_INCREMENT,
  `calle` VARCHAR(45) NOT NULL,
  `numero` INT NOT NULL,
  `piso` VARCHAR(20) NULL,
  `puerta` VARCHAR(5) NULL,
  `ciudad` VARCHAR(45) NOT NULL,
  `codigo_postal` INT NOT NULL,
  `pais` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`direccion_id`),
  UNIQUE INDEX `direccion_id_UNIQUE` (`direccion_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Optica`.`proveedor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Optica`.`proveedor` ;

CREATE TABLE IF NOT EXISTS `Optica`.`proveedor` (
  `proveedor_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `fk_direccion_id` INT NOT NULL,
  `telefono` INT NULL,
  `fax` INT NULL,
  `nie` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`proveedor_id`),
  UNIQUE INDEX `IdProveedor_UNIQUE` (`proveedor_id` ASC) VISIBLE,
  INDEX `fk_direccion_id_idx` (`fk_direccion_id` ASC) VISIBLE,
  CONSTRAINT `fk_direccion_id`
    FOREIGN KEY (`fk_direccion_id`)
    REFERENCES `Optica`.`direccion` (`direccion_id`)
    ON DELETE RESTRICT
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = DEFAULT;


-- -----------------------------------------------------
-- Table `Optica`.`marca`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Optica`.`marca` ;

CREATE TABLE IF NOT EXISTS `Optica`.`marca` (
  `marca_id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `fk_proveedor_id` INT UNSIGNED NULL,
  PRIMARY KEY (`marca_id`),
  UNIQUE INDEX `idmarca_UNIQUE` (`marca_id` ASC) VISIBLE,
  INDEX `fk_proveedor_id_idx` (`fk_proveedor_id` ASC) VISIBLE,
  CONSTRAINT `fk_proveedor_id`
    FOREIGN KEY (`fk_proveedor_id`)
    REFERENCES `Optica`.`proveedor` (`proveedor_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Optica`.`gafas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Optica`.`gafas` ;

CREATE TABLE IF NOT EXISTS `Optica`.`gafas` (
  `gafas_id` INT NOT NULL AUTO_INCREMENT,
  `fk_marca_id` INT NOT NULL,
  `graduacion_derecha` FLOAT NOT NULL,
  `graduacion_izquierda` FLOAT NOT NULL,
  `tipo_montura` VARCHAR(10) NULL,
  `color_vidrios` VARCHAR(20) NULL,
  `color_montura` VARCHAR(20) NULL,
  `precio` FLOAT NOT NULL,
  PRIMARY KEY (`gafas_id`),
  UNIQUE INDEX `idgafas_UNIQUE` (`gafas_id` ASC) VISIBLE,
  INDEX `fk_marca_id_idx` (`fk_marca_id` ASC) VISIBLE,
  CONSTRAINT `fk_marca_id`
    FOREIGN KEY (`fk_marca_id`)
    REFERENCES `Optica`.`marca` (`marca_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Optica`.`cliente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Optica`.`cliente` ;

CREATE TABLE IF NOT EXISTS `Optica`.`cliente` (
  `cliente_id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `fk_direccion_id` INT NULL,
  `telefono` INT NULL,
  `correo_electronico` VARCHAR(45) NULL,
  `fecha_registro` DATETIME NULL,
  `fk_cliente_referencia_id` INT NULL,
  `fk_empleado_id` INT NULL,
  PRIMARY KEY (`cliente_id`),
  UNIQUE INDEX `cliente_id_UNIQUE` (`cliente_id` ASC) VISIBLE,
  INDEX `fk_direccion_id_idx` (`fk_direccion_id` ASC) VISIBLE,
  INDEX `fk_cliente_referencia_id_idx` (`fk_cliente_referencia_id` ASC) VISIBLE,
  CONSTRAINT `fk_direccion_id`
    FOREIGN KEY (`fk_direccion_id`)
    REFERENCES `Optica`.`direccion` (`direccion_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cliente_referencia_id`
    FOREIGN KEY (`fk_cliente_referencia_id`)
    REFERENCES `Optica`.`cliente` (`cliente_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Optica`.`empleado`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Optica`.`empleado` ;

CREATE TABLE IF NOT EXISTS `Optica`.`empleado` (
  `empleado_id` INT NOT NULL AUTO_INCREMENT,
  `fk_direccion_id` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `telefono` INT NULL,
  `correo_electronico` VARCHAR(45) NULL,
  PRIMARY KEY (`empleado_id`),
  UNIQUE INDEX `empleado_id_UNIQUE` (`empleado_id` ASC) VISIBLE,
  INDEX `fk_direccion_id_idx` (`fk_direccion_id` ASC) VISIBLE,
  CONSTRAINT `fk_direccion_id`
    FOREIGN KEY (`fk_direccion_id`)
    REFERENCES `Optica`.`direccion` (`direccion_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Optica`.`venta`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Optica`.`venta` ;

CREATE TABLE IF NOT EXISTS `Optica`.`venta` (
  `gafasXclienteXempleado_id` INT NOT NULL AUTO_INCREMENT,
  `fk_gafas_id` INT NULL,
  `fk_cliente_id` INT NULL,
  `fk_empleado_id` INT NULL,
  PRIMARY KEY (`gafasXclienteXempleado_id`),
  UNIQUE INDEX `gafasXclienteXempleado_id_UNIQUE` (`gafasXclienteXempleado_id` ASC) VISIBLE,
  INDEX `fk_gafas_id_idx` (`fk_gafas_id` ASC) VISIBLE,
  INDEX `fk_empleado_id_idx` (`fk_empleado_id` ASC) VISIBLE,
  INDEX `fk_cliente_id_idx` (`fk_cliente_id` ASC) VISIBLE,
  CONSTRAINT `fk_gafas_id`
    FOREIGN KEY (`fk_gafas_id`)
    REFERENCES `Optica`.`gafas` (`gafas_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_empleado_id`
    FOREIGN KEY (`fk_empleado_id`)
    REFERENCES `Optica`.`empleado` (`empleado_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cliente_id`
    FOREIGN KEY (`fk_cliente_id`)
    REFERENCES `Optica`.`cliente` (`cliente_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
