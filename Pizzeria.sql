SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Pizzeria
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `Pizzeria` ;

-- -----------------------------------------------------
-- Schema Pizzeria
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Pizzeria` DEFAULT CHARACTER SET utf8 ;
USE `Pizzeria` ;

-- -----------------------------------------------------
-- Table `Pizzeria`.`provincia`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Pizzeria`.`provincia` ;

CREATE TABLE IF NOT EXISTS `Pizzeria`.`provincia` (
  `provincia_id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`provincia_id`),
  UNIQUE INDEX `provincia_id_UNIQUE` (`provincia_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`localidad`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Pizzeria`.`localidad` ;

CREATE TABLE IF NOT EXISTS `Pizzeria`.`localidad` (
  `localidad_id` INT NOT NULL AUTO_INCREMENT,
  `fk_provincia_id` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`localidad_id`),
  UNIQUE INDEX `localidad_id_UNIQUE` (`localidad_id` ASC) VISIBLE,
  INDEX `fk_provincia_id_idx` (`fk_provincia_id` ASC) VISIBLE,
  CONSTRAINT `fk_provincia_id`
    FOREIGN KEY (`fk_provincia_id`)
    REFERENCES `Pizzeria`.`provincia` (`provincia_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`cliente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Pizzeria`.`cliente` ;

CREATE TABLE IF NOT EXISTS `Pizzeria`.`cliente` (
  `cliente_id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(45) NOT NULL,
  `codigo_postal` INT NOT NULL,
  `fk_localidad_id` INT NOT NULL,
  `telefono` INT NOT NULL,
  PRIMARY KEY (`cliente_id`),
  UNIQUE INDEX `cliente_id_UNIQUE` (`cliente_id` ASC) VISIBLE,
  INDEX `fk_localidad_id_idx` (`fk_localidad_id` ASC) VISIBLE,
  CONSTRAINT `fk_localidad_id`
    FOREIGN KEY (`fk_localidad_id`)
    REFERENCES `Pizzeria`.`localidad` (`localidad_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`tienda`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Pizzeria`.`tienda` ;

CREATE TABLE IF NOT EXISTS `Pizzeria`.`tienda` (
  `tienda_id` INT NOT NULL AUTO_INCREMENT,
  `direccion` VARCHAR(45) NOT NULL,
  `codigo_postal` INT NOT NULL,
  `fk_localidad_id` INT NOT NULL,
  PRIMARY KEY (`tienda_id`),
  UNIQUE INDEX `producto_id_UNIQUE` (`tienda_id` ASC) VISIBLE,
  INDEX `fk_localidad_id_idx` (`fk_localidad_id` ASC) VISIBLE,
  CONSTRAINT `fk_localidad_id`
    FOREIGN KEY (`fk_localidad_id`)
    REFERENCES `Pizzeria`.`localidad` (`localidad_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`empleado`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Pizzeria`.`empleado` ;

CREATE TABLE IF NOT EXISTS `Pizzeria`.`empleado` (
  `empleado_id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellidos` VARCHAR(45) NOT NULL,
  `nif` VARCHAR(45) NOT NULL,
  `telefono` INT NOT NULL,
  `tipo_empleado` ENUM('cocinero', 'repartidor') NOT NULL,
  PRIMARY KEY (`empleado_id`),
  UNIQUE INDEX `empleado_id_UNIQUE` (`empleado_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`comanda`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Pizzeria`.`comanda` ;

CREATE TABLE IF NOT EXISTS `Pizzeria`.`comanda` (
  `fecha_id` DATETIME NOT NULL,
  `tipo_entrega` ENUM('domicilio', 'entrega') NOT NULL,
  `precio_total` FLOAT NOT NULL DEFAULT 0,
  `fk_cliente_id` INT NOT NULL,
  `fk_tienda_id` INT NOT NULL,
  `fk_empleado_cocinero_id` INT NOT NULL,
  `fk_empleado_repartidor_id` INT NULL,
  `fecha_entrega` DATETIME NULL,
  INDEX `fk_cliente_id_idx` (`fk_cliente_id` ASC) VISIBLE,
  INDEX `fk_tienda_id_idx` (`fk_tienda_id` ASC) VISIBLE,
  INDEX `fk_fk_empleado_id_idx` (`fk_empleado_cocinero_id` ASC) VISIBLE,
  PRIMARY KEY (`fecha_id`),
  INDEX `fk_empleado_repartidor_id_idx` (`fk_empleado_repartidor_id` ASC) VISIBLE,
  CONSTRAINT `fk_cliente_id`
    FOREIGN KEY (`fk_cliente_id`)
    REFERENCES `Pizzeria`.`cliente` (`cliente_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tienda_id`
    FOREIGN KEY (`fk_tienda_id`)
    REFERENCES `Pizzeria`.`tienda` (`tienda_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_empleado_cocinero_id`
    FOREIGN KEY (`fk_empleado_cocinero_id`)
    REFERENCES `Pizzeria`.`empleado` (`empleado_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_empleado_repartidor_id`
    FOREIGN KEY (`fk_empleado_repartidor_id`)
    REFERENCES `Pizzeria`.`empleado` (`empleado_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`categoria_pizza`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Pizzeria`.`categoria_pizza` ;

CREATE TABLE IF NOT EXISTS `Pizzeria`.`categoria_pizza` (
  `categoria_pizza_id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`categoria_pizza_id`),
  UNIQUE INDEX `categoria_pizza_id_UNIQUE` (`categoria_pizza_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`producto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Pizzeria`.`producto` ;

CREATE TABLE IF NOT EXISTS `Pizzeria`.`producto` (
  `producto_id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(120) NOT NULL,
  `imagen` BLOB NOT NULL,
  `precio` FLOAT NOT NULL,
  `tipo` ENUM('pizza', 'hamburguesa', 'bebida') NOT NULL,
  `fk_categoria_id` INT NULL,
  PRIMARY KEY (`producto_id`),
  UNIQUE INDEX `producto_id_UNIQUE` (`producto_id` ASC) VISIBLE,
  INDEX `fk_categoria_id_idx` (`fk_categoria_id` ASC) VISIBLE,
  CONSTRAINT `fk_categoria_id`
    FOREIGN KEY (`fk_categoria_id`)
    REFERENCES `Pizzeria`.`categoria_pizza` (`categoria_pizza_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`comanda_item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Pizzeria`.`comanda_item` ;

CREATE TABLE IF NOT EXISTS `Pizzeria`.`comanda_item` (
  `fk_fecha_comanda` DATETIME NOT NULL,
  `fk_producto_id` INT NOT NULL,
  `cantidad` INT NOT NULL,
  PRIMARY KEY (`fk_fecha_comanda`, `fk_producto_id`),
  INDEX `fk_producto_id_idx` (`fk_producto_id` ASC) VISIBLE,
  CONSTRAINT `fk_fecha_comanda_id`
    FOREIGN KEY (`fk_fecha_comanda`)
    REFERENCES `Pizzeria`.`comanda` (`fecha_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_producto_id`
    FOREIGN KEY (`fk_producto_id`)
    REFERENCES `Pizzeria`.`producto` (`producto_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
