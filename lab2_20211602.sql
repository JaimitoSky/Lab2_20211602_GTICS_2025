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
-- Schema plataforma_reservas
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema plataforma_reservas
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `plataforma_reservas` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`estadio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`estadio` (
  `idEstadio` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `provincia` VARCHAR(45) NOT NULL,
  `club` VARCHAR(45) NULL,
  PRIMARY KEY (`idEstadio`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`seleccion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`seleccion` (
  `idSeleccion` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `tecnico` VARCHAR(45) NULL,
  `estadio_idEstadio` INT NOT NULL,
  PRIMARY KEY (`idSeleccion`),
  INDEX `fk_seleccion_estadio1_idx` (`estadio_idEstadio` ASC) VISIBLE,
  CONSTRAINT `fk_seleccion_estadio1`
    FOREIGN KEY (`estadio_idEstadio`)
    REFERENCES `mydb`.`estadio` (`idEstadio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`jugador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`jugador` (
  `idJugador` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `edad` INT NOT NULL,
  `posicion` VARCHAR(45) NOT NULL,
  `club` VARCHAR(45) NOT NULL,
  `seleccion_idSeleccion` INT NOT NULL,
  PRIMARY KEY (`idJugador`),
  INDEX `fk_jugador_seleccion_idx` (`seleccion_idSeleccion` ASC) VISIBLE,
  CONSTRAINT `fk_jugador_seleccion`
    FOREIGN KEY (`seleccion_idSeleccion`)
    REFERENCES `mydb`.`seleccion` (`idSeleccion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`arbitro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`arbitro` (
  `idArbitro` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `pais` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idArbitro`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Partido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Partido` (
  `idPartido` INT NOT NULL,
  `fecha` DATE NOT NULL,
  `numeroJornada` INT NOT NULL,
  `Partidocol` VARCHAR(45) NOT NULL,
  `arbitro_idArbitro` INT NOT NULL,
  `local_idSeleccion` INT NOT NULL,
  `visitante_idSeleccion1` INT NOT NULL,
  PRIMARY KEY (`idPartido`),
  INDEX `fk_Partido_arbitro1_idx` (`arbitro_idArbitro` ASC) VISIBLE,
  INDEX `fk_Partido_seleccion1_idx` (`local_idSeleccion` ASC) VISIBLE,
  INDEX `fk_Partido_seleccion2_idx` (`visitante_idSeleccion1` ASC) VISIBLE,
  CONSTRAINT `fk_Partido_arbitro1`
    FOREIGN KEY (`arbitro_idArbitro`)
    REFERENCES `mydb`.`arbitro` (`idArbitro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Partido_seleccion1`
    FOREIGN KEY (`local_idSeleccion`)
    REFERENCES `mydb`.`seleccion` (`idSeleccion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Partido_seleccion2`
    FOREIGN KEY (`visitante_idSeleccion1`)
    REFERENCES `mydb`.`seleccion` (`idSeleccion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `plataforma_reservas` ;

-- -----------------------------------------------------
-- Table `plataforma_reservas`.`rol`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `plataforma_reservas`.`rol` (
  `idrol` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(50) NOT NULL,
  `descripcion` TEXT NULL DEFAULT NULL,
  `nivel_acceso` INT NOT NULL DEFAULT '1',
  PRIMARY KEY (`idrol`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `plataforma_reservas`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `plataforma_reservas`.`usuario` (
  `idusuario` INT NOT NULL AUTO_INCREMENT,
  `dni` VARCHAR(8) NOT NULL,
  `nombres` VARCHAR(100) NOT NULL,
  `apellidos` VARCHAR(100) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `password_hash` VARCHAR(255) NOT NULL,
  `password_salt` VARCHAR(255) NOT NULL,
  `telefono` VARCHAR(20) NULL DEFAULT NULL,
  `direccion` VARCHAR(255) NULL DEFAULT NULL,
  `idrol` INT NOT NULL,
  `estado` ENUM('activo', 'inactivo') NULL DEFAULT 'activo',
  `notificar_recordatorio` TINYINT(1) NULL DEFAULT '1',
  `notificar_disponibilidad` TINYINT(1) NULL DEFAULT '1',
  `create_time` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idusuario`),
  UNIQUE INDEX `dni` (`dni` ASC) VISIBLE,
  UNIQUE INDEX `email` (`email` ASC) VISIBLE,
  INDEX `idrol` (`idrol` ASC) VISIBLE,
  CONSTRAINT `usuario_ibfk_1`
    FOREIGN KEY (`idrol`)
    REFERENCES `plataforma_reservas`.`rol` (`idrol`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `plataforma_reservas`.`asistencia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `plataforma_reservas`.`asistencia` (
  `idasistencia` INT NOT NULL AUTO_INCREMENT,
  `idusuario` INT NOT NULL,
  `fecha` DATE NOT NULL,
  `hora_entrada` TIME NULL DEFAULT NULL,
  `hora_salida` TIME NULL DEFAULT NULL,
  `latitud` DECIMAL(10,8) NULL DEFAULT NULL,
  `longitud` DECIMAL(11,8) NULL DEFAULT NULL,
  `observaciones` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`idasistencia`),
  INDEX `idusuario` (`idusuario` ASC) VISIBLE,
  CONSTRAINT `asistencia_ibfk_1`
    FOREIGN KEY (`idusuario`)
    REFERENCES `plataforma_reservas`.`usuario` (`idusuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `plataforma_reservas`.`chatbot_log`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `plataforma_reservas`.`chatbot_log` (
  `idchatbot` INT NOT NULL AUTO_INCREMENT,
  `idusuario` INT NOT NULL,
  `pregunta` TEXT NOT NULL,
  `respuesta` TEXT NOT NULL,
  `fecha` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idchatbot`),
  INDEX `idusuario` (`idusuario` ASC) VISIBLE,
  CONSTRAINT `chatbot_log_ibfk_1`
    FOREIGN KEY (`idusuario`)
    REFERENCES `plataforma_reservas`.`usuario` (`idusuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `plataforma_reservas`.`estado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `plataforma_reservas`.`estado` (
  `idestado` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(50) NOT NULL,
  `descripcion` TEXT NULL DEFAULT NULL,
  `tipo_aplicacion` ENUM('reserva', 'servicio', 'incidencia') NOT NULL,
  PRIMARY KEY (`idestado`),
  INDEX `idx_estado_tipo` (`tipo_aplicacion` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 22
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `plataforma_reservas`.`historial_perfil`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `plataforma_reservas`.`historial_perfil` (
  `idhistorial` INT NOT NULL AUTO_INCREMENT,
  `idusuario` INT NOT NULL,
  `campo_modificado` VARCHAR(100) NULL DEFAULT NULL,
  `valor_anterior` TEXT NULL DEFAULT NULL,
  `valor_nuevo` TEXT NULL DEFAULT NULL,
  `fecha_modificacion` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idhistorial`),
  INDEX `idusuario` (`idusuario` ASC) VISIBLE,
  CONSTRAINT `historial_perfil_ibfk_1`
    FOREIGN KEY (`idusuario`)
    REFERENCES `plataforma_reservas`.`usuario` (`idusuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `plataforma_reservas`.`log`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `plataforma_reservas`.`log` (
  `idlog` INT NOT NULL AUTO_INCREMENT,
  `idusuario` INT NULL DEFAULT NULL,
  `accion` VARCHAR(255) NULL DEFAULT NULL,
  `tabla_afectada` VARCHAR(100) NULL DEFAULT NULL,
  `valor_anterior` TEXT NULL DEFAULT NULL,
  `valor_nuevo` TEXT NULL DEFAULT NULL,
  `fecha` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlog`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `plataforma_reservas`.`tipo_servicio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `plataforma_reservas`.`tipo_servicio` (
  `idtipo` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`idtipo`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `plataforma_reservas`.`servicio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `plataforma_reservas`.`servicio` (
  `idservicio` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NOT NULL,
  `descripcion` TEXT NULL DEFAULT NULL,
  `idtipo` INT NOT NULL,
  `ubicacion` VARCHAR(255) NULL DEFAULT NULL,
  `contacto_soporte` VARCHAR(100) NULL DEFAULT NULL,
  `horario_inicio` TIME NULL DEFAULT NULL,
  `horario_fin` TIME NULL DEFAULT NULL,
  `idestado` INT NULL DEFAULT NULL,
  PRIMARY KEY (`idservicio`),
  INDEX `idtipo` (`idtipo` ASC) VISIBLE,
  INDEX `idestado` (`idestado` ASC) VISIBLE,
  CONSTRAINT `servicio_ibfk_1`
    FOREIGN KEY (`idtipo`)
    REFERENCES `plataforma_reservas`.`tipo_servicio` (`idtipo`),
  CONSTRAINT `servicio_ibfk_2`
    FOREIGN KEY (`idestado`)
    REFERENCES `plataforma_reservas`.`estado` (`idestado`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `plataforma_reservas`.`media_servicio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `plataforma_reservas`.`media_servicio` (
  `idmedia` INT NOT NULL AUTO_INCREMENT,
  `idservicio` INT NOT NULL,
  `tipo` ENUM('imagen', 'video') NOT NULL,
  `url` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`idmedia`),
  INDEX `idservicio` (`idservicio` ASC) VISIBLE,
  CONSTRAINT `media_servicio_ibfk_1`
    FOREIGN KEY (`idservicio`)
    REFERENCES `plataforma_reservas`.`servicio` (`idservicio`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `plataforma_reservas`.`notificacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `plataforma_reservas`.`notificacion` (
  `idnotificacion` INT NOT NULL AUTO_INCREMENT,
  `idusuario` INT NOT NULL,
  `titulo` VARCHAR(255) NULL DEFAULT NULL,
  `mensaje` TEXT NULL DEFAULT NULL,
  `leido` TINYINT(1) NULL DEFAULT '0',
  `fecha_envio` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idnotificacion`),
  INDEX `idusuario` (`idusuario` ASC) VISIBLE,
  CONSTRAINT `notificacion_ibfk_1`
    FOREIGN KEY (`idusuario`)
    REFERENCES `plataforma_reservas`.`usuario` (`idusuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `plataforma_reservas`.`pago`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `plataforma_reservas`.`pago` (
  `idpago` INT NOT NULL AUTO_INCREMENT,
  `idusuario` INT NOT NULL,
  `monto` DECIMAL(10,2) NULL DEFAULT NULL,
  `metodo` ENUM('online', 'banco') NOT NULL,
  `comprobante` LONGBLOB NULL DEFAULT NULL,
  `estado` ENUM('pendiente', 'validado', 'rechazado') NULL DEFAULT 'pendiente',
  `fecha_pago` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idpago`),
  INDEX `idusuario` (`idusuario` ASC) VISIBLE,
  CONSTRAINT `pago_ibfk_1`
    FOREIGN KEY (`idusuario`)
    REFERENCES `plataforma_reservas`.`usuario` (`idusuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `plataforma_reservas`.`reserva`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `plataforma_reservas`.`reserva` (
  `idreserva` INT NOT NULL AUTO_INCREMENT,
  `idusuario` INT NOT NULL,
  `idservicio` INT NOT NULL,
  `fecha_reserva` DATE NOT NULL,
  `hora_inicio` TIME NOT NULL,
  `hora_fin` TIME NOT NULL,
  `fecha_creacion` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `idestado` INT NULL DEFAULT NULL,
  `idpago` INT NULL DEFAULT NULL,
  PRIMARY KEY (`idreserva`),
  INDEX `idx_usuario` (`idusuario` ASC) VISIBLE,
  INDEX `idx_servicio` (`idservicio` ASC) VISIBLE,
  INDEX `idestado` (`idestado` ASC) VISIBLE,
  INDEX `idpago` (`idpago` ASC) VISIBLE,
  CONSTRAINT `reserva_ibfk_1`
    FOREIGN KEY (`idusuario`)
    REFERENCES `plataforma_reservas`.`usuario` (`idusuario`),
  CONSTRAINT `reserva_ibfk_2`
    FOREIGN KEY (`idservicio`)
    REFERENCES `plataforma_reservas`.`servicio` (`idservicio`),
  CONSTRAINT `reserva_ibfk_3`
    FOREIGN KEY (`idestado`)
    REFERENCES `plataforma_reservas`.`estado` (`idestado`),
  CONSTRAINT `reserva_ibfk_4`
    FOREIGN KEY (`idpago`)
    REFERENCES `plataforma_reservas`.`pago` (`idpago`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `plataforma_reservas`.`reembolso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `plataforma_reservas`.`reembolso` (
  `idreembolso` INT NOT NULL AUTO_INCREMENT,
  `idreserva` INT NOT NULL,
  `monto` DECIMAL(10,2) NULL DEFAULT NULL,
  `fecha_solicitud` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `estado` ENUM('pendiente', 'aprobado', 'rechazado') NULL DEFAULT 'pendiente',
  PRIMARY KEY (`idreembolso`),
  INDEX `idreserva` (`idreserva` ASC) VISIBLE,
  CONSTRAINT `reembolso_ibfk_1`
    FOREIGN KEY (`idreserva`)
    REFERENCES `plataforma_reservas`.`reserva` (`idreserva`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `plataforma_reservas`.`reporte`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `plataforma_reservas`.`reporte` (
  `idreporte` INT NOT NULL AUTO_INCREMENT,
  `idusuario` INT NOT NULL,
  `tipo` ENUM('PDF', 'Excel') NOT NULL,
  `filtro_aplicado` TEXT NULL DEFAULT NULL,
  `ruta_archivo` VARCHAR(255) NULL DEFAULT NULL,
  `fecha_generacion` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idreporte`),
  INDEX `idusuario` (`idusuario` ASC) VISIBLE,
  CONSTRAINT `reporte_ibfk_1`
    FOREIGN KEY (`idusuario`)
    REFERENCES `plataforma_reservas`.`usuario` (`idusuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `plataforma_reservas`.`solicitud_eliminacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `plataforma_reservas`.`solicitud_eliminacion` (
  `idsolicitud` INT NOT NULL AUTO_INCREMENT,
  `idusuario` INT NOT NULL,
  `fecha_solicitud` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `confirmado` TINYINT(1) NULL DEFAULT '0',
  PRIMARY KEY (`idsolicitud`),
  INDEX `idusuario` (`idusuario` ASC) VISIBLE,
  CONSTRAINT `solicitud_eliminacion_ibfk_1`
    FOREIGN KEY (`idusuario`)
    REFERENCES `plataforma_reservas`.`usuario` (`idusuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `plataforma_reservas`.`subrol`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `plataforma_reservas`.`subrol` (
  `idsubrol` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NOT NULL,
  `descripcion` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`idsubrol`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `plataforma_reservas`.`subrol_permiso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `plataforma_reservas`.`subrol_permiso` (
  `idsubrol` INT NOT NULL,
  `idpermiso` INT NOT NULL,
  PRIMARY KEY (`idsubrol`, `idpermiso`),
  CONSTRAINT `subrol_permiso_ibfk_1`
    FOREIGN KEY (`idsubrol`)
    REFERENCES `plataforma_reservas`.`subrol` (`idsubrol`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `plataforma_reservas`.`taller`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `plataforma_reservas`.`taller` (
  `idtaller` INT NOT NULL AUTO_INCREMENT,
  `idservicio` INT NOT NULL,
  `nombre` VARCHAR(100) NOT NULL,
  `descripcion` TEXT NULL DEFAULT NULL,
  `fecha_inicio` DATE NOT NULL,
  `fecha_fin` DATE NOT NULL,
  `hora_inicio` TIME NOT NULL,
  `hora_fin` TIME NOT NULL,
  `cupos_maximos` INT NOT NULL,
  `instructor` VARCHAR(100) NULL DEFAULT NULL,
  `estado` ENUM('activo', 'cancelado', 'finalizado') NULL DEFAULT 'activo',
  PRIMARY KEY (`idtaller`),
  INDEX `idservicio` (`idservicio` ASC) VISIBLE,
  CONSTRAINT `taller_ibfk_1`
    FOREIGN KEY (`idservicio`)
    REFERENCES `plataforma_reservas`.`servicio` (`idservicio`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `plataforma_reservas`.`taller_inscripcion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `plataforma_reservas`.`taller_inscripcion` (
  `idinscripcion` INT NOT NULL AUTO_INCREMENT,
  `idtaller` INT NOT NULL,
  `idusuario` INT NOT NULL,
  `fecha_inscripcion` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idinscripcion`),
  INDEX `idtaller` (`idtaller` ASC) VISIBLE,
  INDEX `idusuario` (`idusuario` ASC) VISIBLE,
  CONSTRAINT `taller_inscripcion_ibfk_1`
    FOREIGN KEY (`idtaller`)
    REFERENCES `plataforma_reservas`.`taller` (`idtaller`),
  CONSTRAINT `taller_inscripcion_ibfk_2`
    FOREIGN KEY (`idusuario`)
    REFERENCES `plataforma_reservas`.`usuario` (`idusuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `plataforma_reservas`.`tarifa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `plataforma_reservas`.`tarifa` (
  `idtarifa` INT NOT NULL AUTO_INCREMENT,
  `idservicio` INT NOT NULL,
  `descripcion` TEXT NULL DEFAULT NULL,
  `monto` DECIMAL(10,2) NULL DEFAULT NULL,
  `dia_semana` ENUM('lunes', 'martes', 'miércoles', 'jueves', 'viernes', 'sábado', 'domingo') NULL DEFAULT NULL,
  `hora_inicio` TIME NULL DEFAULT NULL,
  `hora_fin` TIME NULL DEFAULT NULL,
  PRIMARY KEY (`idtarifa`),
  INDEX `idservicio` (`idservicio` ASC) VISIBLE,
  CONSTRAINT `tarifa_ibfk_1`
    FOREIGN KEY (`idservicio`)
    REFERENCES `plataforma_reservas`.`servicio` (`idservicio`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `plataforma_reservas`.`validacion_usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `plataforma_reservas`.`validacion_usuario` (
  `idvalidacion` INT NOT NULL AUTO_INCREMENT,
  `idusuario` INT NOT NULL,
  `codigo_validacion` VARCHAR(100) NULL DEFAULT NULL,
  `password_temporal` VARCHAR(100) NULL DEFAULT NULL,
  `fecha_expiracion` DATETIME NULL DEFAULT NULL,
  `estado` ENUM('pendiente', 'aceptado', 'rechazado') NULL DEFAULT 'pendiente',
  PRIMARY KEY (`idvalidacion`),
  INDEX `idusuario` (`idusuario` ASC) VISIBLE,
  CONSTRAINT `validacion_usuario_ibfk_1`
    FOREIGN KEY (`idusuario`)
    REFERENCES `plataforma_reservas`.`usuario` (`idusuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
