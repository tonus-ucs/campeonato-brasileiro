-- MySQL Script generated by MySQL Workbench
-- ter 03 dez 2019 20:24:08 -03
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema campeonato
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `campeonato` ;

-- -----------------------------------------------------
-- Schema campeonato
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `campeonato` DEFAULT CHARACTER SET utf8 ;
USE `campeonato` ;

-- -----------------------------------------------------
-- Table `campeonato`.`campeonato`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `campeonato`.`campeonato` ;

CREATE TABLE IF NOT EXISTS `campeonato`.`campeonato` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `data` DATE NOT NULL,
  `nome` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `campeonato`.`time`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `campeonato`.`time` ;

CREATE TABLE IF NOT EXISTS `campeonato`.`time` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(120) NOT NULL,
  `estado` CHAR(2) NOT NULL,
  `cidade` VARCHAR(100) NOT NULL,
  `estadio` VARCHAR(100) NOT NULL,
  `sigla` CHAR(3) NOT NULL,
  `imagem` VARCHAR(500) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `campeonato`.`rodada`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `campeonato`.`rodada` ;

CREATE TABLE IF NOT EXISTS `campeonato`.`rodada` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `idCampeonato` INT UNSIGNED NOT NULL,
  `numero` INT UNSIGNED NOT NULL,
  `data` DATE NOT NULL,
  `fechada` TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  INDEX `fk_rodada_campeonato1_idx` (`idCampeonato` ASC),
  CONSTRAINT `fk_rodada_campeonato1`
    FOREIGN KEY (`idCampeonato`)
    REFERENCES `campeonato`.`campeonato` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `campeonato`.`jogo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `campeonato`.`jogo` ;

CREATE TABLE IF NOT EXISTS `campeonato`.`jogo` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `idRodada` INT UNSIGNED NOT NULL,
  `idTimeMandante` INT UNSIGNED NOT NULL,
  `idTimeVisitante` INT UNSIGNED NOT NULL,
  `golTimeMandante` TINYINT UNSIGNED NOT NULL,
  `golTimeVisitante` TINYINT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_rodada_time1_idx` (`idTimeMandante` ASC),
  INDEX `fk_jogo_rodada1_idx` (`idRodada` ASC),
  INDEX `fk_jogo_time1_idx` (`idTimeVisitante` ASC),
  CONSTRAINT `fk_rodada_time1`
    FOREIGN KEY (`idTimeMandante`)
    REFERENCES `campeonato`.`time` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_jogo_rodada1`
    FOREIGN KEY (`idRodada`)
    REFERENCES `campeonato`.`rodada` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_jogo_time1`
    FOREIGN KEY (`idTimeVisitante`)
    REFERENCES `campeonato`.`time` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `campeonato`.`usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `campeonato`.`usuario` ;

CREATE TABLE IF NOT EXISTS `campeonato`.`usuario` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(120) NOT NULL,
  `login` VARCHAR(50) NOT NULL,
  `senha` CHAR(32) NOT NULL,
  `tipo` CHAR(1) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `campeonato`.`campeonato_usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `campeonato`.`campeonato_usuario` ;

CREATE TABLE IF NOT EXISTS `campeonato`.`campeonato_usuario` (
  `idCampeonato` INT UNSIGNED NOT NULL,
  `idUsuario` INT UNSIGNED NOT NULL,
  INDEX `fk_campeonato_has_usuario_usuario1_idx` (`idUsuario` ASC),
  INDEX `fk_campeonato_has_usuario_campeonato1_idx` (`idCampeonato` ASC),
  CONSTRAINT `fk_campeonato_has_usuario_campeonato1`
    FOREIGN KEY (`idCampeonato`)
    REFERENCES `campeonato`.`campeonato` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_campeonato_has_usuario_usuario1`
    FOREIGN KEY (`idUsuario`)
    REFERENCES `campeonato`.`usuario` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `campeonato`.`campeonato_time`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `campeonato`.`campeonato_time` ;

CREATE TABLE IF NOT EXISTS `campeonato`.`campeonato_time` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `idCampeonato` INT UNSIGNED NOT NULL,
  `idTime` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_campeonato_time_campeonato1_idx` (`idCampeonato` ASC),
  INDEX `fk_campeonato_time_time1_idx` (`idTime` ASC),
  CONSTRAINT `fk_campeonato_time_campeonato1`
    FOREIGN KEY (`idCampeonato`)
    REFERENCES `campeonato`.`campeonato` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_campeonato_time_time1`
    FOREIGN KEY (`idTime`)
    REFERENCES `campeonato`.`time` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `campeonato`.`classificacao`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `campeonato`.`classificacao` ;

CREATE TABLE IF NOT EXISTS `campeonato`.`classificacao` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `idCampeonatoTime` INT UNSIGNED NOT NULL,
  `pontuacao` INT UNSIGNED NOT NULL DEFAULT 0,
  `saldoGolPro` INT UNSIGNED NOT NULL DEFAULT 0,
  `saldoGolContra` INT UNSIGNED NOT NULL DEFAULT 0,
  `numeroVitoria` INT UNSIGNED NOT NULL DEFAULT 0,
  `numeroEmpate` INT UNSIGNED NOT NULL DEFAULT 0,
  `numeroDerrota` INT UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  INDEX `fk_classificacao_campeonato_time1_idx` (`idCampeonatoTime` ASC),
  CONSTRAINT `fk_classificacao_campeonato_time1`
    FOREIGN KEY (`idCampeonatoTime`)
    REFERENCES `campeonato`.`campeonato_time` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `campeonato`.`campeonato`
-- -----------------------------------------------------
START TRANSACTION;
USE `campeonato`;
INSERT INTO `campeonato`.`campeonato` (`id`, `data`, `nome`) VALUES (1, '2019-05-05', 'Campeonato Brasileiro 2019 - Série A');

COMMIT;


-- -----------------------------------------------------
-- Data for table `campeonato`.`time`
-- -----------------------------------------------------
START TRANSACTION;
USE `campeonato`;
INSERT INTO `campeonato`.`time` (`id`, `nome`, `estado`, `cidade`, `estadio`, `sigla`, `imagem`) VALUES (1, 'Athletico-PR', 'PR', 'Curitiba', 'Estádio Joaquim Américo Guimarães', 'CAP', 'https://s.glbimg.com/es/sde/f/organizacoes/2019/09/09/Athletico-PR.svg');
INSERT INTO `campeonato`.`time` (`id`, `nome`, `estado`, `cidade`, `estadio`, `sigla`, `imagem`) VALUES (2, 'Atlético-MG', 'MG', 'Belo Horizonte', 'Arena Independência', 'CAM', 'https://s.glbimg.com/es/sde/f/organizacoes/2018/03/10/atletico-mg.svg');
INSERT INTO `campeonato`.`time` (`id`, `nome`, `estado`, `cidade`, `estadio`, `sigla`, `imagem`) VALUES (3, 'Avaí', 'SC', 'Florianópolis', 'Estádio Aderbal Ramos da Silva', 'AVA', 'https://s.glbimg.com/es/sde/f/organizacoes/2018/09/04/avai-futebol-clube.svg');
INSERT INTO `campeonato`.`time` (`id`, `nome`, `estado`, `cidade`, `estadio`, `sigla`, `imagem`) VALUES (4, 'Bahia', 'BH', 'Salvador', 'Itaipava Arena Fonte Nova', 'BAH', 'https://s.glbimg.com/es/sde/f/organizacoes/2018/03/11/bahia.svg');
INSERT INTO `campeonato`.`time` (`id`, `nome`, `estado`, `cidade`, `estadio`, `sigla`, `imagem`) VALUES (5, 'Botafogo', 'RJ', 'Rio de Janeiro', 'Estádio Nilton Santos', 'BOT', 'https://s.glbimg.com/es/sde/f/organizacoes/2019/02/04/botafogo-svg.svg');
INSERT INTO `campeonato`.`time` (`id`, `nome`, `estado`, `cidade`, `estadio`, `sigla`, `imagem`) VALUES (6, 'CSA', 'AL', 'Maceió', 'Rei Pelé', 'CSA', 'https://s.glbimg.com/es/sde/f/organizacoes/2018/03/11/csa.svg');
INSERT INTO `campeonato`.`time` (`id`, `nome`, `estado`, `cidade`, `estadio`, `sigla`, `imagem`) VALUES (7, 'Ceará', 'CE', 'Fortaleza', 'Estádio Presidente Vargas', 'CEA', 'https://s.glbimg.com/es/sde/f/organizacoes/2019/10/10/ceara.svg');
INSERT INTO `campeonato`.`time` (`id`, `nome`, `estado`, `cidade`, `estadio`, `sigla`, `imagem`) VALUES (8, 'Chapecoense', 'SC', 'Chapecó', 'Arena Condá', 'CHA', 'https://s.glbimg.com/es/sde/f/organizacoes/2018/03/11/chapecoense.svg');
INSERT INTO `campeonato`.`time` (`id`, `nome`, `estado`, `cidade`, `estadio`, `sigla`, `imagem`) VALUES (9, 'Corinthians', 'SP', 'São Paulo', 'Arena Corinthians', 'COR', 'https://s.glbimg.com/es/sde/f/organizacoes/2019/09/30/Corinthians.svg');
INSERT INTO `campeonato`.`time` (`id`, `nome`, `estado`, `cidade`, `estadio`, `sigla`, `imagem`) VALUES (10, 'Cruzeiro', 'MG', 'Belo Horizonte', 'Mineirão', 'CRU', 'https://s.glbimg.com/es/sde/f/organizacoes/2018/03/11/cruzeiro.svg');
INSERT INTO `campeonato`.`time` (`id`, `nome`, `estado`, `cidade`, `estadio`, `sigla`, `imagem`) VALUES (11, 'Flamengo', 'RJ', 'Rio de Janeiro', 'Estádio da Gávea', 'FLA', 'https://s.glbimg.com/es/sde/f/organizacoes/2018/04/10/Flamengo-2018.svg');
INSERT INTO `campeonato`.`time` (`id`, `nome`, `estado`, `cidade`, `estadio`, `sigla`, `imagem`) VALUES (12, 'Fluminense', 'RJ', 'Rio de Janeiro', 'Laranjeiras', 'FLU', 'https://s.glbimg.com/es/sde/f/organizacoes/2018/03/11/fluminense.svg');
INSERT INTO `campeonato`.`time` (`id`, `nome`, `estado`, `cidade`, `estadio`, `sigla`, `imagem`) VALUES (13, 'Fortaleza', 'CE', 'Fortaleza', 'Estádio Alcides Santos', 'FOR', 'https://s.glbimg.com/es/sde/f/organizacoes/2018/06/10/optimised.svg');
INSERT INTO `campeonato`.`time` (`id`, `nome`, `estado`, `cidade`, `estadio`, `sigla`, `imagem`) VALUES (14, 'Goiás', 'GO', 'Goiânia', 'Estádio Serra Dourada', 'GOI', 'https://s.glbimg.com/es/sde/f/organizacoes/2019/05/01/Goias_SVG.svg');
INSERT INTO `campeonato`.`time` (`id`, `nome`, `estado`, `cidade`, `estadio`, `sigla`, `imagem`) VALUES (15, 'Grêmio', 'RS', 'Porto Alegre', 'Arena do Grêmio', 'GRE', 'https://s.glbimg.com/es/sde/f/organizacoes/2018/03/12/gremio.svg');
INSERT INTO `campeonato`.`time` (`id`, `nome`, `estado`, `cidade`, `estadio`, `sigla`, `imagem`) VALUES (16, 'Internacional', 'RS', 'Porto Alegre', 'Beira Rio', 'INT', 'https://s.glbimg.com/es/sde/f/organizacoes/2018/03/11/internacional.svg');
INSERT INTO `campeonato`.`time` (`id`, `nome`, `estado`, `cidade`, `estadio`, `sigla`, `imagem`) VALUES (17, 'Palmeiras', 'SP', 'São Paulo', 'Allianz Parque', 'PAL', 'https://s.glbimg.com/es/sde/f/equipes/2019/07/07/palmeiras.svg');
INSERT INTO `campeonato`.`time` (`id`, `nome`, `estado`, `cidade`, `estadio`, `sigla`, `imagem`) VALUES (18, 'Santos', 'SP', 'Santos', 'Vila Belmiro', 'SAN', 'https://s.glbimg.com/es/sde/f/organizacoes/2018/03/12/santos.svg');
INSERT INTO `campeonato`.`time` (`id`, `nome`, `estado`, `cidade`, `estadio`, `sigla`, `imagem`) VALUES (19, 'São Paulo', 'SP', 'São Paulo', 'Estádio Cícero Pompeu de Toledo', 'SAO', 'https://s.glbimg.com/es/sde/f/organizacoes/2018/03/11/sao-paulo.svg');
INSERT INTO `campeonato`.`time` (`id`, `nome`, `estado`, `cidade`, `estadio`, `sigla`, `imagem`) VALUES (20, 'Vasco', 'RJ', 'Rio de Janeiro', 'Estádio São Januário', 'VAS', 'https://s.glbimg.com/es/sde/f/organizacoes/2018/03/11/vasco.svg');

COMMIT;


-- -----------------------------------------------------
-- Data for table `campeonato`.`usuario`
-- -----------------------------------------------------
START TRANSACTION;
USE `campeonato`;
INSERT INTO `campeonato`.`usuario` (`id`, `nome`, `login`, `senha`, `tipo`) VALUES (1, 'Administrador', 'admin', '21232f297a57a5a743894a0e4a801fc3', 'A');

COMMIT;


-- -----------------------------------------------------
-- Data for table `campeonato`.`campeonato_usuario`
-- -----------------------------------------------------
START TRANSACTION;
USE `campeonato`;
INSERT INTO `campeonato`.`campeonato_usuario` (`idCampeonato`, `idUsuario`) VALUES (1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `campeonato`.`campeonato_time`
-- -----------------------------------------------------
START TRANSACTION;
USE `campeonato`;
INSERT INTO `campeonato`.`campeonato_time` (`id`, `idCampeonato`, `idTime`) VALUES (1, 1, 1);
INSERT INTO `campeonato`.`campeonato_time` (`id`, `idCampeonato`, `idTime`) VALUES (2, 1, 2);
INSERT INTO `campeonato`.`campeonato_time` (`id`, `idCampeonato`, `idTime`) VALUES (3, 1, 3);
INSERT INTO `campeonato`.`campeonato_time` (`id`, `idCampeonato`, `idTime`) VALUES (4, 1, 4);
INSERT INTO `campeonato`.`campeonato_time` (`id`, `idCampeonato`, `idTime`) VALUES (5, 1, 5);
INSERT INTO `campeonato`.`campeonato_time` (`id`, `idCampeonato`, `idTime`) VALUES (6, 1, 6);
INSERT INTO `campeonato`.`campeonato_time` (`id`, `idCampeonato`, `idTime`) VALUES (7, 1, 7);
INSERT INTO `campeonato`.`campeonato_time` (`id`, `idCampeonato`, `idTime`) VALUES (8, 1, 8);
INSERT INTO `campeonato`.`campeonato_time` (`id`, `idCampeonato`, `idTime`) VALUES (9, 1, 9);
INSERT INTO `campeonato`.`campeonato_time` (`id`, `idCampeonato`, `idTime`) VALUES (10, 1, 10);
INSERT INTO `campeonato`.`campeonato_time` (`id`, `idCampeonato`, `idTime`) VALUES (11, 1, 11);
INSERT INTO `campeonato`.`campeonato_time` (`id`, `idCampeonato`, `idTime`) VALUES (12, 1, 12);
INSERT INTO `campeonato`.`campeonato_time` (`id`, `idCampeonato`, `idTime`) VALUES (13, 1, 13);
INSERT INTO `campeonato`.`campeonato_time` (`id`, `idCampeonato`, `idTime`) VALUES (14, 1, 14);
INSERT INTO `campeonato`.`campeonato_time` (`id`, `idCampeonato`, `idTime`) VALUES (15, 1, 15);
INSERT INTO `campeonato`.`campeonato_time` (`id`, `idCampeonato`, `idTime`) VALUES (16, 1, 16);
INSERT INTO `campeonato`.`campeonato_time` (`id`, `idCampeonato`, `idTime`) VALUES (17, 1, 17);
INSERT INTO `campeonato`.`campeonato_time` (`id`, `idCampeonato`, `idTime`) VALUES (18, 1, 18);
INSERT INTO `campeonato`.`campeonato_time` (`id`, `idCampeonato`, `idTime`) VALUES (19, 1, 19);
INSERT INTO `campeonato`.`campeonato_time` (`id`, `idCampeonato`, `idTime`) VALUES (20, 1, 20);

COMMIT;
