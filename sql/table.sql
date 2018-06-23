-- MySQL Script generated by MySQL Workbench
-- 2018年06月23日 星期六 15时22分10秒
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`t_forum`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`t_forum` ;

CREATE TABLE IF NOT EXISTS `mydb`.`t_forum` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `forum_name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`t_topic`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`t_topic` ;

CREATE TABLE IF NOT EXISTS `mydb`.`t_topic` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `author_nickname` VARCHAR(45) NOT NULL,
  `author_id` BIGINT NOT NULL,
  `forum_id` INT NOT NULL,
  `title` VARCHAR(45) NOT NULL,
  `pub_time` DATETIME NOT NULL DEFAULT now(),
  `last_reply_time` DATETIME NOT NULL DEFAULT now(),
  `last_reply_nickname` VARCHAR(45) NOT NULL,
  `last_reply_uid` BIGINT NOT NULL,
  `views` INT NOT NULL DEFAULT 0,
  `replies` INT NOT NULL DEFAULT 0,
  `main_post_id` BIGINT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_t_topic_t_forum1_idx` (`forum_id` ASC),
  CONSTRAINT `fk_t_topic_t_forum1`
    FOREIGN KEY (`forum_id`)
    REFERENCES `mydb`.`t_forum` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`t_post`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`t_post` ;

CREATE TABLE IF NOT EXISTS `mydb`.`t_post` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `content` VARCHAR(255) NULL,
  `author_id` BIGINT NOT NULL,
  `author_nickname` VARCHAR(45) NOT NULL,
  `pub_time` DATETIME NOT NULL DEFAULT now(),
  `last_modified_time` DATETIME NOT NULL DEFAULT now(),
  `reply_post_id` BIGINT NULL,
  `topic_id` BIGINT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_t_post_t_topic1_idx` (`topic_id` ASC),
  CONSTRAINT `fk_t_post_t_topic1`
    FOREIGN KEY (`topic_id`)
    REFERENCES `mydb`.`t_topic` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`t_user_principal`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`t_user_principal` ;

CREATE TABLE IF NOT EXISTS `mydb`.`t_user_principal` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `credential` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`t_user_profile`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`t_user_profile` ;

CREATE TABLE IF NOT EXISTS `mydb`.`t_user_profile` (
  `nickname` VARCHAR(45) NOT NULL,
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `sex` TINYINT NOT NULL,
  `credit` INT NULL,
  INDEX `fk_t_user_profile_t_user_principal1_idx` (`id` ASC),
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_t_user_profile_t_user_principal1`
    FOREIGN KEY (`id`)
    REFERENCES `mydb`.`t_user_principal` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`t_subscription`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`t_subscription` ;

CREATE TABLE IF NOT EXISTS `mydb`.`t_subscription` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `last_read_time` DATETIME NOT NULL,
  `user_id` BIGINT NOT NULL,
  `subscription_type` TINYINT NOT NULL,
  `topic_id` BIGINT NOT NULL,
  `post_id` BIGINT NOT NULL,
  `follower_id` BIGINT NULL,
  `forum_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_t_subscription_t_topic1_idx` (`topic_id` ASC),
  INDEX `fk_t_subscription_t_post1_idx` (`post_id` ASC),
  CONSTRAINT `fk_t_subscription_t_topic1`
    FOREIGN KEY (`topic_id`)
    REFERENCES `mydb`.`t_topic` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_t_subscription_t_post1`
    FOREIGN KEY (`post_id`)
    REFERENCES `mydb`.`t_post` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`t_subscription_config`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`t_subscription_config` ;

CREATE TABLE IF NOT EXISTS `mydb`.`t_subscription_config` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `like_topic` TINYINT NULL DEFAULT 1,
  `like_post` TINYINT NULL DEFAULT 1,
  `pub_topic` TINYINT NULL DEFAULT 1,
  `pub_post` TINYINT NULL DEFAULT 1,
  `user_id` BIGINT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`t_role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`t_role` ;

CREATE TABLE IF NOT EXISTS `mydb`.`t_role` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `role_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`t_permission`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`t_permission` ;

CREATE TABLE IF NOT EXISTS `mydb`.`t_permission` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `perm_name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`t_role_perm`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`t_role_perm` ;

CREATE TABLE IF NOT EXISTS `mydb`.`t_role_perm` (
  `role_id` INT NOT NULL,
  `permission_id` INT NOT NULL,
  PRIMARY KEY (`role_id`, `permission_id`),
  INDEX `fk_t_role_perm_t_permission1_idx` (`permission_id` ASC),
  CONSTRAINT `fk_t_role_perm_t_role1`
    FOREIGN KEY (`role_id`)
    REFERENCES `mydb`.`t_role` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_t_role_perm_t_permission1`
    FOREIGN KEY (`permission_id`)
    REFERENCES `mydb`.`t_permission` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`t_user_role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`t_user_role` ;

CREATE TABLE IF NOT EXISTS `mydb`.`t_user_role` (
  `user_principal_id` BIGINT NOT NULL,
  `role_id` INT NOT NULL,
  PRIMARY KEY (`user_principal_id`, `role_id`),
  INDEX `fk_t_user_role_t_role1_idx` (`role_id` ASC),
  CONSTRAINT `fk_t_user_role_t_user_principal1`
    FOREIGN KEY (`user_principal_id`)
    REFERENCES `mydb`.`t_user_principal` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_t_user_role_t_role1`
    FOREIGN KEY (`role_id`)
    REFERENCES `mydb`.`t_role` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`t_topic_trend_action`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`t_topic_trend_action` ;

CREATE TABLE IF NOT EXISTS `mydb`.`t_topic_trend_action` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `pub_time` DATETIME NOT NULL,
  `reply_post_id` BIGINT NOT NULL,
  `topic_id` BIGINT NOT NULL,
  `replier_id` BIGINT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_t_topic_action_t_post1_idx` (`reply_post_id` ASC),
  INDEX `fk_t_topic_action_t_topic1_idx` (`topic_id` ASC),
  CONSTRAINT `fk_t_topic_action_t_post1`
    FOREIGN KEY (`reply_post_id`)
    REFERENCES `mydb`.`t_post` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_t_topic_action_t_topic1`
    FOREIGN KEY (`topic_id`)
    REFERENCES `mydb`.`t_topic` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`t_user_trend_action`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`t_user_trend_action` ;

CREATE TABLE IF NOT EXISTS `mydb`.`t_user_trend_action` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `action_type` TINYINT NULL,
  `target_type` TINYINT NULL,
  `user_id` BIGINT NOT NULL,
  `post_id` BIGINT NOT NULL,
  `topic_id` BIGINT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_t_follower_trend_action_t_post1_idx` (`post_id` ASC),
  INDEX `fk_t_follower_trend_action_t_topic1_idx` (`topic_id` ASC),
  CONSTRAINT `fk_t_follower_trend_action_t_post1`
    FOREIGN KEY (`post_id`)
    REFERENCES `mydb`.`t_post` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_t_follower_trend_action_t_topic1`
    FOREIGN KEY (`topic_id`)
    REFERENCES `mydb`.`t_topic` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`t_forum_manager`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`t_forum_manager` ;

CREATE TABLE IF NOT EXISTS `mydb`.`t_forum_manager` (
  `forum_id` INT NOT NULL,
  `manager_id` BIGINT NOT NULL,
  PRIMARY KEY (`forum_id`, `manager_id`),
  CONSTRAINT `fk_t_forum_manager_t_forum1`
    FOREIGN KEY (`forum_id`)
    REFERENCES `mydb`.`t_forum` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`t_bbs_manager`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`t_bbs_manager` ;

CREATE TABLE IF NOT EXISTS `mydb`.`t_bbs_manager` (
  `manager_id` BIGINT NOT NULL,
  PRIMARY KEY (`manager_id`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `mydb`.`t_forum`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`t_forum` (`id`, `forum_name`) VALUES (DEFAULT, 'game');
INSERT INTO `mydb`.`t_forum` (`id`, `forum_name`) VALUES (DEFAULT, 'movie');
INSERT INTO `mydb`.`t_forum` (`id`, `forum_name`) VALUES (DEFAULT, 'noval');
INSERT INTO `mydb`.`t_forum` (`id`, `forum_name`) VALUES (DEFAULT, 'music');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`t_topic`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`t_topic` (`id`, `author_nickname`, `author_id`, `forum_id`, `title`, `pub_time`, `last_reply_time`, `last_reply_nickname`, `last_reply_uid`, `views`, `replies`, `main_post_id`) VALUES (DEFAULT, 'verrickt', 1, 1, 'test game topic 1', DEFAULT, DEFAULT, 'verrickt', 1, DEFAULT, DEFAULT, 1);
INSERT INTO `mydb`.`t_topic` (`id`, `author_nickname`, `author_id`, `forum_id`, `title`, `pub_time`, `last_reply_time`, `last_reply_nickname`, `last_reply_uid`, `views`, `replies`, `main_post_id`) VALUES (DEFAULT, 'verrickt', 1, 1, 'test game topic #2', DEFAULT, DEFAULT, 'verrickt', 1, DEFAULT, DEFAULT, 2);
INSERT INTO `mydb`.`t_topic` (`id`, `author_nickname`, `author_id`, `forum_id`, `title`, `pub_time`, `last_reply_time`, `last_reply_nickname`, `last_reply_uid`, `views`, `replies`, `main_post_id`) VALUES (DEFAULT, 'verrickt', 1, 1, 'test game topic #3', DEFAULT, DEFAULT, 'verrickt', 1, DEFAULT, DEFAULT, 3);
INSERT INTO `mydb`.`t_topic` (`id`, `author_nickname`, `author_id`, `forum_id`, `title`, `pub_time`, `last_reply_time`, `last_reply_nickname`, `last_reply_uid`, `views`, `replies`, `main_post_id`) VALUES (DEFAULT, 'zhou', 2, 2, 'test movie topic #1', DEFAULT, DEFAULT, 'zhou', 2, DEFAULT, DEFAULT, 7);
INSERT INTO `mydb`.`t_topic` (`id`, `author_nickname`, `author_id`, `forum_id`, `title`, `pub_time`, `last_reply_time`, `last_reply_nickname`, `last_reply_uid`, `views`, `replies`, `main_post_id`) VALUES (DEFAULT, 'zhou', 2, 2, 'test movie topic #2', DEFAULT, DEFAULT, 'zhou', 2, DEFAULT, DEFAULT, 8);
INSERT INTO `mydb`.`t_topic` (`id`, `author_nickname`, `author_id`, `forum_id`, `title`, `pub_time`, `last_reply_time`, `last_reply_nickname`, `last_reply_uid`, `views`, `replies`, `main_post_id`) VALUES (DEFAULT, 'zhou', 2, 2, 'test movie topic #3', DEFAULT, DEFAULT, 'zhou', 2, DEFAULT, DEFAULT, 9);
INSERT INTO `mydb`.`t_topic` (`id`, `author_nickname`, `author_id`, `forum_id`, `title`, `pub_time`, `last_reply_time`, `last_reply_nickname`, `last_reply_uid`, `views`, `replies`, `main_post_id`) VALUES (DEFAULT, 'jay', 3, 2, 'test movie topic #4', DEFAULT, DEFAULT, 'jay', 3, DEFAULT, DEFAULT, 10);
INSERT INTO `mydb`.`t_topic` (`id`, `author_nickname`, `author_id`, `forum_id`, `title`, `pub_time`, `last_reply_time`, `last_reply_nickname`, `last_reply_uid`, `views`, `replies`, `main_post_id`) VALUES (DEFAULT, 'jay', 3, 2, 'test movie topic #5', DEFAULT, DEFAULT, 'jay', 3, DEFAULT, DEFAULT, 11);
INSERT INTO `mydb`.`t_topic` (`id`, `author_nickname`, `author_id`, `forum_id`, `title`, `pub_time`, `last_reply_time`, `last_reply_nickname`, `last_reply_uid`, `views`, `replies`, `main_post_id`) VALUES (DEFAULT, 'jay', 3, 2, 'test movie topic #6', DEFAULT, DEFAULT, 'jay', 3, DEFAULT, DEFAULT, 12);
INSERT INTO `mydb`.`t_topic` (`id`, `author_nickname`, `author_id`, `forum_id`, `title`, `pub_time`, `last_reply_time`, `last_reply_nickname`, `last_reply_uid`, `views`, `replies`, `main_post_id`) VALUES (DEFAULT, 'zhou', 2, 1, 'test game topic #4', DEFAULT, DEFAULT, 'zhou', 2, DEFAULT, DEFAULT, 13);
INSERT INTO `mydb`.`t_topic` (`id`, `author_nickname`, `author_id`, `forum_id`, `title`, `pub_time`, `last_reply_time`, `last_reply_nickname`, `last_reply_uid`, `views`, `replies`, `main_post_id`) VALUES (DEFAULT, 'jay', 3, 1, 'test game topic #5', DEFAULT, DEFAULT, 'jay', 3, DEFAULT, DEFAULT, 14);
INSERT INTO `mydb`.`t_topic` (`id`, `author_nickname`, `author_id`, `forum_id`, `title`, `pub_time`, `last_reply_time`, `last_reply_nickname`, `last_reply_uid`, `views`, `replies`, `main_post_id`) VALUES (DEFAULT, 'boy', 4, 1, 'test game topic #6', DEFAULT, DEFAULT, 'boy', 4, DEFAULT, DEFAULT, 15);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`t_post`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`t_post` (`id`, `content`, `author_id`, `author_nickname`, `pub_time`, `last_modified_time`, `reply_post_id`, `topic_id`) VALUES (DEFAULT, 'test game topic#1 main post ', 1, 'verrickt', DEFAULT, DEFAULT, NULL, 1);
INSERT INTO `mydb`.`t_post` (`id`, `content`, `author_id`, `author_nickname`, `pub_time`, `last_modified_time`, `reply_post_id`, `topic_id`) VALUES (DEFAULT, 'test game topic#2 main post ', 1, 'verrickt', DEFAULT, DEFAULT, NULL, 2);
INSERT INTO `mydb`.`t_post` (`id`, `content`, `author_id`, `author_nickname`, `pub_time`, `last_modified_time`, `reply_post_id`, `topic_id`) VALUES (DEFAULT, 'test game topic#3 main post ', 1, 'verrickt', DEFAULT, DEFAULT, NULL, 3);
INSERT INTO `mydb`.`t_post` (`id`, `content`, `author_id`, `author_nickname`, `pub_time`, `last_modified_time`, `reply_post_id`, `topic_id`) VALUES (DEFAULT, 'test game topic#1 comment post ', 2, 'zhou', DEFAULT, DEFAULT, NULL, 1);
INSERT INTO `mydb`.`t_post` (`id`, `content`, `author_id`, `author_nickname`, `pub_time`, `last_modified_time`, `reply_post_id`, `topic_id`) VALUES (DEFAULT, 'test game topic#1 reply comment post ', 3, 'jay', DEFAULT, DEFAULT, 4, 1);
INSERT INTO `mydb`.`t_post` (`id`, `content`, `author_id`, `author_nickname`, `pub_time`, `last_modified_time`, `reply_post_id`, `topic_id`) VALUES (DEFAULT, 'test game topic#2 comment post ', 1, 'verrickt', DEFAULT, DEFAULT, NULL, 2);
INSERT INTO `mydb`.`t_post` (`id`, `content`, `author_id`, `author_nickname`, `pub_time`, `last_modified_time`, `reply_post_id`, `topic_id`) VALUES (DEFAULT, 'test movie topic#1 main post ', 2, 'zhou', DEFAULT, DEFAULT, NULL, 4);
INSERT INTO `mydb`.`t_post` (`id`, `content`, `author_id`, `author_nickname`, `pub_time`, `last_modified_time`, `reply_post_id`, `topic_id`) VALUES (DEFAULT, 'test movie topic#2 main post ', 2, 'zhou', DEFAULT, DEFAULT, NULL, 5);
INSERT INTO `mydb`.`t_post` (`id`, `content`, `author_id`, `author_nickname`, `pub_time`, `last_modified_time`, `reply_post_id`, `topic_id`) VALUES (DEFAULT, 'test movie topic#3 main post ', 2, 'zhou', DEFAULT, DEFAULT, NULL, 6);
INSERT INTO `mydb`.`t_post` (`id`, `content`, `author_id`, `author_nickname`, `pub_time`, `last_modified_time`, `reply_post_id`, `topic_id`) VALUES (DEFAULT, 'test movie topic#4 main post ', 3, 'jay', DEFAULT, DEFAULT, NULL, 7);
INSERT INTO `mydb`.`t_post` (`id`, `content`, `author_id`, `author_nickname`, `pub_time`, `last_modified_time`, `reply_post_id`, `topic_id`) VALUES (DEFAULT, 'test movie topic#5 main post ', 3, 'jay', DEFAULT, DEFAULT, NULL, 8);
INSERT INTO `mydb`.`t_post` (`id`, `content`, `author_id`, `author_nickname`, `pub_time`, `last_modified_time`, `reply_post_id`, `topic_id`) VALUES (DEFAULT, 'test movie topic#6 main post ', 3, 'jay', DEFAULT, DEFAULT, NULL, 9);
INSERT INTO `mydb`.`t_post` (`id`, `content`, `author_id`, `author_nickname`, `pub_time`, `last_modified_time`, `reply_post_id`, `topic_id`) VALUES (DEFAULT, 'test game topic#4 main post ', 2, 'zhou', DEFAULT, DEFAULT, NULL, 10);
INSERT INTO `mydb`.`t_post` (`id`, `content`, `author_id`, `author_nickname`, `pub_time`, `last_modified_time`, `reply_post_id`, `topic_id`) VALUES (DEFAULT, 'test game topic#5 main post ', 3, 'jay', DEFAULT, DEFAULT, NULL, 11);
INSERT INTO `mydb`.`t_post` (`id`, `content`, `author_id`, `author_nickname`, `pub_time`, `last_modified_time`, `reply_post_id`, `topic_id`) VALUES (DEFAULT, 'test game topic#6 main post ', 4, 'boy', DEFAULT, DEFAULT, NULL, 12);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`t_user_principal`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`t_user_principal` (`id`, `username`, `credential`, `email`) VALUES (DEFAULT, 'verrickt', '123456', 'zhoujian1237@gmail.com');
INSERT INTO `mydb`.`t_user_principal` (`id`, `username`, `credential`, `email`) VALUES (DEFAULT, 'zhou', '123456', NULL);
INSERT INTO `mydb`.`t_user_principal` (`id`, `username`, `credential`, `email`) VALUES (DEFAULT, 'jay', '123456', NULL);
INSERT INTO `mydb`.`t_user_principal` (`id`, `username`, `credential`, `email`) VALUES (DEFAULT, 'boy', '123456', NULL);
INSERT INTO `mydb`.`t_user_principal` (`id`, `username`, `credential`, `email`) VALUES (DEFAULT, 'girl', '123456', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`t_user_profile`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`t_user_profile` (`nickname`, `id`, `sex`, `credit`) VALUES ('verrickt', 1, 0, 0);
INSERT INTO `mydb`.`t_user_profile` (`nickname`, `id`, `sex`, `credit`) VALUES ('zhou', 2, 0, 1);
INSERT INTO `mydb`.`t_user_profile` (`nickname`, `id`, `sex`, `credit`) VALUES ('jay', 3, 1, 2);
INSERT INTO `mydb`.`t_user_profile` (`nickname`, `id`, `sex`, `credit`) VALUES ('boy', 4, 0, 3);
INSERT INTO `mydb`.`t_user_profile` (`nickname`, `id`, `sex`, `credit`) VALUES ('girl', 5, 1, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`t_role`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`t_role` (`id`, `role_name`) VALUES (DEFAULT, 'normal_user');
INSERT INTO `mydb`.`t_role` (`id`, `role_name`) VALUES (DEFAULT, 'broad_manager');
INSERT INTO `mydb`.`t_role` (`id`, `role_name`) VALUES (DEFAULT, 'forum_manager');
INSERT INTO `mydb`.`t_role` (`id`, `role_name`) VALUES (DEFAULT, 'bbs_manager');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`t_permission`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`t_permission` (`id`, `perm_name`) VALUES (DEFAULT, 'pub post');
INSERT INTO `mydb`.`t_permission` (`id`, `perm_name`) VALUES (DEFAULT, 'delete own post');
INSERT INTO `mydb`.`t_permission` (`id`, `perm_name`) VALUES (DEFAULT, 'search post');
INSERT INTO `mydb`.`t_permission` (`id`, `perm_name`) VALUES (DEFAULT, 'edit own post');
INSERT INTO `mydb`.`t_permission` (`id`, `perm_name`) VALUES (DEFAULT, 'pub topic');
INSERT INTO `mydb`.`t_permission` (`id`, `perm_name`) VALUES (DEFAULT, 'delete own topic');
INSERT INTO `mydb`.`t_permission` (`id`, `perm_name`) VALUES (DEFAULT, 'edit own topic');
INSERT INTO `mydb`.`t_permission` (`id`, `perm_name`) VALUES (DEFAULT, 'delete any post');
INSERT INTO `mydb`.`t_permission` (`id`, `perm_name`) VALUES (DEFAULT, 'edit own user_profile');
INSERT INTO `mydb`.`t_permission` (`id`, `perm_name`) VALUES (DEFAULT, 'edit own user_principal');
INSERT INTO `mydb`.`t_permission` (`id`, `perm_name`) VALUES (DEFAULT, 'edit any user_profile');
INSERT INTO `mydb`.`t_permission` (`id`, `perm_name`) VALUES (DEFAULT, 'edit any user_principal');
INSERT INTO `mydb`.`t_permission` (`id`, `perm_name`) VALUES (DEFAULT, 'add broad_manager');
INSERT INTO `mydb`.`t_permission` (`id`, `perm_name`) VALUES (DEFAULT, 'add forum_manager');
INSERT INTO `mydb`.`t_permission` (`id`, `perm_name`) VALUES (DEFAULT, 'delete broad_manager');
INSERT INTO `mydb`.`t_permission` (`id`, `perm_name`) VALUES (DEFAULT, 'delete forum_manager');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`t_role_perm`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`t_role_perm` (`role_id`, `permission_id`) VALUES (1, 1);
INSERT INTO `mydb`.`t_role_perm` (`role_id`, `permission_id`) VALUES (1, 2);
INSERT INTO `mydb`.`t_role_perm` (`role_id`, `permission_id`) VALUES (1, 3);
INSERT INTO `mydb`.`t_role_perm` (`role_id`, `permission_id`) VALUES (1, 4);
INSERT INTO `mydb`.`t_role_perm` (`role_id`, `permission_id`) VALUES (1, 5);
INSERT INTO `mydb`.`t_role_perm` (`role_id`, `permission_id`) VALUES (1, 6);
INSERT INTO `mydb`.`t_role_perm` (`role_id`, `permission_id`) VALUES (1, 7);
INSERT INTO `mydb`.`t_role_perm` (`role_id`, `permission_id`) VALUES (1, 9);
INSERT INTO `mydb`.`t_role_perm` (`role_id`, `permission_id`) VALUES (1, 10);
INSERT INTO `mydb`.`t_role_perm` (`role_id`, `permission_id`) VALUES (2, 8);
INSERT INTO `mydb`.`t_role_perm` (`role_id`, `permission_id`) VALUES (2, 11);
INSERT INTO `mydb`.`t_role_perm` (`role_id`, `permission_id`) VALUES (2, 12);
INSERT INTO `mydb`.`t_role_perm` (`role_id`, `permission_id`) VALUES (3, 13);
INSERT INTO `mydb`.`t_role_perm` (`role_id`, `permission_id`) VALUES (4, 14);
INSERT INTO `mydb`.`t_role_perm` (`role_id`, `permission_id`) VALUES (3, 15);
INSERT INTO `mydb`.`t_role_perm` (`role_id`, `permission_id`) VALUES (4, 16);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`t_user_role`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`t_user_role` (`user_principal_id`, `role_id`) VALUES (4, 1);
INSERT INTO `mydb`.`t_user_role` (`user_principal_id`, `role_id`) VALUES (5, 1);
INSERT INTO `mydb`.`t_user_role` (`user_principal_id`, `role_id`) VALUES (1, 4);
INSERT INTO `mydb`.`t_user_role` (`user_principal_id`, `role_id`) VALUES (2, 3);
INSERT INTO `mydb`.`t_user_role` (`user_principal_id`, `role_id`) VALUES (3, 2);

COMMIT;

