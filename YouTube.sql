SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema N2Exercici1 - YouTube
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `N2Exercici1 - YouTube` ;

-- -----------------------------------------------------
-- Schema N2Exercici1 - YouTube
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `N2Exercici1 - YouTube` DEFAULT CHARACTER SET utf8 ;
USE `N2Exercici1 - YouTube` ;

-- -----------------------------------------------------
-- Table `N2Exercici1 - YouTube`.`Usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `N2Exercici1 - YouTube`.`Usuario` ;

CREATE TABLE IF NOT EXISTS `N2Exercici1 - YouTube`.`Usuario` (
  `usuario_id` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `usuario` VARCHAR(45) NOT NULL,
  `fecha_nacimiento` DATETIME NOT NULL,
  `sexo` ENUM('f', 'm') NULL,
  `pais` VARCHAR(50) NULL,
  `codigo_postal` INT NULL,
  PRIMARY KEY (`usuario_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `N2Exercici1 - YouTube`.`canal`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `N2Exercici1 - YouTube`.`canal` ;

CREATE TABLE IF NOT EXISTS `N2Exercici1 - YouTube`.`canal` (
  `canal_id` INT NOT NULL AUTO_INCREMENT,
  `fk_usuario_id` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(200) NOT NULL,
  `fecha_creacion` DATETIME NOT NULL,
  PRIMARY KEY (`canal_id`),
  INDEX `fk_usuario_id_idx` (`fk_usuario_id` ASC) VISIBLE,
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC) VISIBLE,
  CONSTRAINT `fk_usuario_id`
    FOREIGN KEY (`fk_usuario_id`)
    REFERENCES `N2Exercici1 - YouTube`.`Usuario` (`usuario_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `N2Exercici1 - YouTube`.`usuario_suscripto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `N2Exercici1 - YouTube`.`usuario_suscripto` ;

CREATE TABLE IF NOT EXISTS `N2Exercici1 - YouTube`.`usuario_suscripto` (
  `fk_canal_id` INT NOT NULL,
  `fk_usuario_id` INT NOT NULL,
  INDEX `fk_usuario_id_idx` (`fk_usuario_id` ASC) VISIBLE,
  INDEX `fk_canal_id_idx` (`fk_canal_id` ASC) VISIBLE,
  PRIMARY KEY (`fk_canal_id`, `fk_usuario_id`),
  CONSTRAINT `fk_usuario_id`
    FOREIGN KEY (`fk_usuario_id`)
    REFERENCES `N2Exercici1 - YouTube`.`Usuario` (`usuario_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_canal_id`
    FOREIGN KEY (`fk_canal_id`)
    REFERENCES `N2Exercici1 - YouTube`.`canal` (`canal_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `N2Exercici1 - YouTube`.`video`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `N2Exercici1 - YouTube`.`video` ;

CREATE TABLE IF NOT EXISTS `N2Exercici1 - YouTube`.`video` (
  `video_id` INT NOT NULL AUTO_INCREMENT,
  `fk_usuario_id` INT NOT NULL,
  `titulo` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(200) NOT NULL,
  `tamaño` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `miniatura` BLOB NOT NULL,
  `reproducciones` INT NOT NULL,
  `estado` ENUM('publico', 'oculto', 'privado') NOT NULL DEFAULT 0,
  `fecha_publicacion` DATETIME NOT NULL,
  PRIMARY KEY (`video_id`),
  INDEX `fk_usuario_id_idx` (`fk_usuario_id` ASC) VISIBLE,
  CONSTRAINT `fk_usuario_id`
    FOREIGN KEY (`fk_usuario_id`)
    REFERENCES `N2Exercici1 - YouTube`.`Usuario` (`usuario_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `N2Exercici1 - YouTube`.`like_video`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `N2Exercici1 - YouTube`.`like_video` ;

CREATE TABLE IF NOT EXISTS `N2Exercici1 - YouTube`.`like_video` (
  `fk_video_id` INT NOT NULL,
  `fk_usuario_id` INT NOT NULL,
  `fecha` DATETIME NOT NULL,
  `reaccion` ENUM('like', 'dislike') NOT NULL,
  INDEX `fk_video_id_idx` (`fk_video_id` ASC) VISIBLE,
  INDEX `fk_usuario_id_idx` (`fk_usuario_id` ASC) VISIBLE,
  PRIMARY KEY (`fk_video_id`, `fk_usuario_id`),
  CONSTRAINT `fk_video_id`
    FOREIGN KEY (`fk_video_id`)
    REFERENCES `N2Exercici1 - YouTube`.`video` (`video_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuario_id`
    FOREIGN KEY (`fk_usuario_id`)
    REFERENCES `N2Exercici1 - YouTube`.`Usuario` (`usuario_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `N2Exercici1 - YouTube`.`etiqueta`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `N2Exercici1 - YouTube`.`etiqueta` ;

CREATE TABLE IF NOT EXISTS `N2Exercici1 - YouTube`.`etiqueta` (
  `etiqueta_id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`etiqueta_id`),
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `N2Exercici1 - YouTube`.`playlist`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `N2Exercici1 - YouTube`.`playlist` ;

CREATE TABLE IF NOT EXISTS `N2Exercici1 - YouTube`.`playlist` (
  `playlist_id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `fecha_creacion` DATETIME NOT NULL,
  `estado` ENUM('publica', 'privada') NOT NULL,
  `fk_usuario_id` INT NOT NULL,
  PRIMARY KEY (`playlist_id`),
  INDEX `fk_usuario_id_idx` (`fk_usuario_id` ASC) VISIBLE,
  CONSTRAINT `fk_usuario_id`
    FOREIGN KEY (`fk_usuario_id`)
    REFERENCES `N2Exercici1 - YouTube`.`Usuario` (`usuario_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `N2Exercici1 - YouTube`.`videos_por_playlist`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `N2Exercici1 - YouTube`.`videos_por_playlist` ;

CREATE TABLE IF NOT EXISTS `N2Exercici1 - YouTube`.`videos_por_playlist` (
  `fk_video_id` INT NOT NULL,
  `fk_playlist_id` INT NOT NULL,
  INDEX `fk_video_id_idx` (`fk_video_id` ASC) VISIBLE,
  INDEX `fk_playlist_id_idx` (`fk_playlist_id` ASC) VISIBLE,
  PRIMARY KEY (`fk_video_id`, `fk_playlist_id`),
  CONSTRAINT `fk_video_id`
    FOREIGN KEY (`fk_video_id`)
    REFERENCES `N2Exercici1 - YouTube`.`video` (`video_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_playlist_id`
    FOREIGN KEY (`fk_playlist_id`)
    REFERENCES `N2Exercici1 - YouTube`.`playlist` (`playlist_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `N2Exercici1 - YouTube`.`comentario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `N2Exercici1 - YouTube`.`comentario` ;

CREATE TABLE IF NOT EXISTS `N2Exercici1 - YouTube`.`comentario` (
  `comentario_id` INT NOT NULL AUTO_INCREMENT,
  `fk_video_id` INT NOT NULL,
  `fk_usuario_id` INT NOT NULL,
  `texto` VARCHAR(100) NOT NULL,
  `fecha` DATETIME NOT NULL,
  PRIMARY KEY (`comentario_id`),
  INDEX `fk_video_id_idx` (`fk_video_id` ASC) VISIBLE,
  INDEX `fk_usuario_id_idx` (`fk_usuario_id` ASC) VISIBLE,
  CONSTRAINT `fk_video_id`
    FOREIGN KEY (`fk_video_id`)
    REFERENCES `N2Exercici1 - YouTube`.`video` (`video_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuario_id`
    FOREIGN KEY (`fk_usuario_id`)
    REFERENCES `N2Exercici1 - YouTube`.`Usuario` (`usuario_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `N2Exercici1 - YouTube`.`like_comentario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `N2Exercici1 - YouTube`.`like_comentario` ;

CREATE TABLE IF NOT EXISTS `N2Exercici1 - YouTube`.`like_comentario` (
  `fk_comentario_id` INT NOT NULL,
  `fk_usuario_id` INT NOT NULL,
  `fecha` DATETIME NOT NULL,
  `reaccion` ENUM('like', 'dislike') NOT NULL,
  INDEX `fk_usuario_id_idx` (`fk_usuario_id` ASC) VISIBLE,
  INDEX `fk_comentario_id_idx` (`fk_comentario_id` ASC) VISIBLE,
  PRIMARY KEY (`fk_comentario_id`, `fk_usuario_id`),
  CONSTRAINT `fk_usuario_id`
    FOREIGN KEY (`fk_usuario_id`)
    REFERENCES `N2Exercici1 - YouTube`.`Usuario` (`usuario_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comentario_id`
    FOREIGN KEY (`fk_comentario_id`)
    REFERENCES `N2Exercici1 - YouTube`.`comentario` (`comentario_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `N2Exercici1 - YouTube`.`video_etiqueta`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `N2Exercici1 - YouTube`.`video_etiqueta` ;

CREATE TABLE IF NOT EXISTS `N2Exercici1 - YouTube`.`video_etiqueta` (
  `fk_video_id` INT NOT NULL,
  `fk_etiqueta_id` INT NOT NULL,
  PRIMARY KEY (`fk_video_id`, `fk_etiqueta_id`),
  INDEX `fk_etiqueta_id_idx` (`fk_etiqueta_id` ASC) VISIBLE,
  CONSTRAINT `fk_video_id`
    FOREIGN KEY (`fk_video_id`)
    REFERENCES `N2Exercici1 - YouTube`.`video` (`video_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_etiqueta_id`
    FOREIGN KEY (`fk_etiqueta_id`)
    REFERENCES `N2Exercici1 - YouTube`.`etiqueta` (`etiqueta_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
