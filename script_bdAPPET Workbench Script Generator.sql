-- MySQL Workbench Forward Engineering
-- -----------------------------------------------------
-- Projeto: APPet
-- Autores: 
-- Alefe Albert
-- Diogo Esteves
-- Felipe Domiciano
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Database `appet`
-- -----------------------------------------------------
DROP DATABASE IF EXISTS `appet`;
CREATE DATABASE IF NOT EXISTS `appet` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
USE `appet`;

-- -----------------------------------------------------
-- Table `Usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Usuario` ;

CREATE TABLE IF NOT EXISTS `Usuario` (
  `idUsuario` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(100) NOT NULL,
  `Email` VARCHAR(100) NOT NULL,
  `Telefone` VARCHAR(12) NOT NULL,
  `Cidade` VARCHAR(50) NOT NULL,
  `Bairro` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`idUsuario`),
  UNIQUE INDEX `Email_UNIQUE` (`Email` ASC));

-- -----------------------------------------------------
-- Table `Notificacao`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Notificacao` ;

CREATE TABLE IF NOT EXISTS `Notificacao` (
  `idNotificacao` INT NOT NULL AUTO_INCREMENT,
  `Mensagem` VARCHAR(1000) NULL,
  `DataNotificacao` DATETIME NULL,
  `idUsuario` INT NOT NULL,
  `Notificada` TINYINT(1) NOT NULL DEFAULT 0,
  `Lida` TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`idNotificacao`),
  CONSTRAINT `fk_Notificacao_Usuario1`
    FOREIGN KEY (`idUsuario`)
    REFERENCES `Usuario` (`idUsuario`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

-- -----------------------------------------------------
-- Table `EstabelecimentoFavorito`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `EstabelecimentoFavorito` ;

CREATE TABLE IF NOT EXISTS `EstabelecimentoFavorito` (
  `idEstabelecimentoFavorito` INT NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  `Latitude` VARCHAR(45) NOT NULL,
  `Longitude` VARCHAR(45) NOT NULL,
  `idUsuario` INT NOT NULL,
  PRIMARY KEY (`idEstabelecimentoFavorito`),
  CONSTRAINT `fk_EstabelecimentoFavorito_Usuario1`
    FOREIGN KEY (`idUsuario`)
    REFERENCES `Usuario` (`idUsuario`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);
	
-- -----------------------------------------------------
-- Table `Especie`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Especie` ;

CREATE TABLE IF NOT EXISTS `Especie` (
  `idEspecie` INT NOT NULL,
  `Nome` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`idEspecie`));

-- -----------------------------------------------------
-- Table `Raca`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Raca` ;

CREATE TABLE IF NOT EXISTS `Raca` (
  `idRaca` INT NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  `Descricao` VARCHAR(1000) NULL,
  `idEspecie` INT NOT NULL,
  PRIMARY KEY (`idRaca`),
  CONSTRAINT `fk_Raca_Especie1`
    FOREIGN KEY (`idEspecie`)
    REFERENCES `Especie` (`idEspecie`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

-- -----------------------------------------------------
-- Table `Animal`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Animal` ;

CREATE TABLE IF NOT EXISTS `Animal` (
  `idAnimal` INT NOT NULL,
  `Nome` VARCHAR(100) NOT NULL,
  `Genero` ENUM('Macho', 'Fêmea') NOT NULL,
  `Cor` VARCHAR(50) NOT NULL,
  `Porte` ENUM('Pequeno', 'Médio', 'Grande') NOT NULL,
  `Idade` INT NOT NULL,
  `Caracteristicas` VARCHAR(2000) NULL,
  `QRCode` VARCHAR(5000) NOT NULL,
  `Foto` VARCHAR(5000) NOT NULL,
  `Desaparecido` TINYINT(1) NOT NULL DEFAULT 0,
  `FotoCarteira` VARCHAR(5000) NULL,
  `DataFotoCarteira` DATE NULL,
  `idUsuario` INT NOT NULL,
  `idRaca` INT NOT NULL,
  PRIMARY KEY (`idAnimal`),
  CONSTRAINT `fk_Animal_Usuario1`
    FOREIGN KEY (`idUsuario`)
    REFERENCES `Usuario` (`idUsuario`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Animal_Raca1`
    FOREIGN KEY (`idRaca`)
    REFERENCES `Raca` (`idRaca`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE);

-- -----------------------------------------------------
-- Table `Foto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Foto` ;

CREATE TABLE IF NOT EXISTS `Foto` (
  `idFoto` INT NOT NULL,
  `Caminho` VARCHAR(2000) NOT NULL,
  `idAnimal` INT NOT NULL,
  PRIMARY KEY (`idFoto`),
  CONSTRAINT `fk_Foto_Animal1`
    FOREIGN KEY (`idAnimal`)
    REFERENCES `Animal` (`idAnimal`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

-- -----------------------------------------------------
-- Table `Alerta`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Alerta` ;

CREATE TABLE IF NOT EXISTS `Alerta` (
  `idAlerta` INT NOT NULL,
  `NivelAlerta` ENUM('Baixo', 'Médio', 'Alto') NOT NULL DEFAULT 'Médio',
  `Frequencia` INT NOT NULL DEFAULT 1,
  PRIMARY KEY (`idAlerta`));

-- -----------------------------------------------------
-- Table `Evento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Evento` ;

CREATE TABLE IF NOT EXISTS `Evento` (
  `idEvento` INT NOT NULL,
  `Nome` VARCHAR(100) NOT NULL,
  `Observacoes` VARCHAR(1000) NULL,
  `FlagAlerta` TINYINT(1) NOT NULL DEFAULT 0,
  `idAlerta` INT NOT NULL,
  `idAnimal` INT NOT NULL,
  `Tipo` ENUM('Medicamento', 'Vacina', 'Compromisso') NOT NULL,
  PRIMARY KEY (`idEvento`),
  CONSTRAINT `fk_Evento_Alerta1`
    FOREIGN KEY (`idAlerta`)
    REFERENCES `Alerta` (`idAlerta`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Evento_Animal1`
    FOREIGN KEY (`idAnimal`)
    REFERENCES `Animal` (`idAnimal`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

-- -----------------------------------------------------
-- Table `Medicamento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Medicamento` ;

CREATE TABLE IF NOT EXISTS `Medicamento` (
  `idEvento` INT NOT NULL,
  `Inicio` DATE NOT NULL,
  `Fim` DATE NOT NULL,
  `FrequenciaDiaria` INT NOT NULL,
  `HorasDeEspera` TIME NULL,
  PRIMARY KEY (`idEvento`),
  CONSTRAINT `fk_Medicamento_Evento1`
    FOREIGN KEY (`idEvento`)
    REFERENCES `Evento` (`idEvento`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

-- -----------------------------------------------------
-- Table `Vacina`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Vacina` ;

CREATE TABLE IF NOT EXISTS `Vacina` (
  `idEvento` INT NOT NULL,
  `Aplicada` TINYINT(1) NOT NULL DEFAULT 0,
  `DataAplicacao` DATE NULL,
  `DataValidade` DATE NULL,
  `FrequenciaAnual` INT NULL,
  `QtdDoses` INT NULL,
  PRIMARY KEY (`idEvento`),
  CONSTRAINT `fk_Vacina_Evento1`
    FOREIGN KEY (`idEvento`)
    REFERENCES `Evento` (`idEvento`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

-- -----------------------------------------------------
-- Table `Compromisso`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Compromisso` ;

CREATE TABLE IF NOT EXISTS `Compromisso` (
  `idEvento` INT NOT NULL,
  `NomeLocal` VARCHAR(100) NOT NULL,
  `Latitude` VARCHAR(45) NULL,
  `Longitude` VARCHAR(45) NULL,
  `DataHora` DATETIME NOT NULL,
  PRIMARY KEY (`idEvento`),
  CONSTRAINT `fk_Compromissos_Evento1`
    FOREIGN KEY (`idEvento`)
    REFERENCES `Evento` (`idEvento`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

-- -----------------------------------------------------
-- Table `Desaparecimento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Desaparecimento` ;

CREATE TABLE IF NOT EXISTS `Desaparecimento` (
  `idDesaparecimento` INT NOT NULL,
  `DataDesaparecimento` DATE NOT NULL,
  `idAnimal` INT NOT NULL,
  PRIMARY KEY (`idDesaparecimento`),
  CONSTRAINT `fk_Desaparecimento_Animal1`
    FOREIGN KEY (`idAnimal`)
    REFERENCES `Animal` (`idAnimal`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

-- -----------------------------------------------------
-- Table `Localizacao`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Localizacao` ;

CREATE TABLE IF NOT EXISTS `Localizacao` (
  `idLocalizacao` INT NOT NULL,
  `Latitude` VARCHAR(45) NOT NULL,
  `Longitude` VARCHAR(45) NOT NULL,
  `idDesaparecimento` INT NOT NULL,
  PRIMARY KEY (`idLocalizacao`),
  CONSTRAINT `fk_Localizacao_Desaparecimento1`
    FOREIGN KEY (`idDesaparecimento`)
    REFERENCES `Desaparecimento` (`idDesaparecimento`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

-- -----------------------------------------------------
-- Table `Dispositivo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Dispositivo` ;

CREATE TABLE IF NOT EXISTS `Dispositivo` (
  `idDispositivo` INT NOT NULL,
  `ChaveAPI` VARCHAR(32) NOT NULL,
  `IMEI` VARCHAR(16) NOT NULL,
  `Principal` TINYINT(1) NOT NULL DEFAULT 0,
  `idUsuario` INT NOT NULL,
  PRIMARY KEY (`idDispositivo`),
  CONSTRAINT `fk_Dispositivo_Usuario1`
    FOREIGN KEY (`idUsuario`)
    REFERENCES `Usuario` (`idUsuario`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

-- -----------------------------------------------------
-- Table `Alteracao`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Alteracao` ;

CREATE TABLE IF NOT EXISTS `Alteracao` (
  `idAlteracao` INT NOT NULL,
  `idRegistroAlterado` INT NOT NULL,
  `Sincronizado` TINYINT(1) NOT NULL DEFAULT 0,
  `Tabela` VARCHAR(45) NOT NULL,
  `DataAlteracao` DATETIME NOT NULL,
  `idDispositivo` INT NOT NULL,
  PRIMARY KEY (`idAlteracao`),
  CONSTRAINT `fk_Alteracao_Dispositivo1`
    FOREIGN KEY (`idDispositivo`)
    REFERENCES `Dispositivo` (`idDispositivo`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);
