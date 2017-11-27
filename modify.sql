ALTER TABLE `category` CHANGE `id` `category_id` INT(11) NOT NULL AUTO_INCREMENT;
ALTER TABLE `user` CHANGE `wecahat_id` `wechat_id` VARCHAR(45) NOT NULL COMMENT '微信账号';




-- MySQL Script generated by MySQL Workbench
-- Tue Mar 21 18:44:09 2017
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema civil
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema civil
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `civil` DEFAULT CHARACTER SET utf8 ;
USE `civil` ;

-- -----------------------------------------------------
-- Table `civil`.`table1`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `civil`.`table1` ;

CREATE TABLE IF NOT EXISTS `civil`.`table1` (
  `id` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `civil`.`admin`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `civil`.`admin` ;

CREATE TABLE IF NOT EXISTS `civil`.`admin` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `admin_name` VARCHAR(45) NOT NULL COMMENT '管理员名称',
  `admin_pwd` VARCHAR(45) NOT NULL COMMENT '密码',
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `civil`.`user_information`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `civil`.`user_information` ;

CREATE TABLE IF NOT EXISTS `civil`.`user_information` (
  `id` INT NOT NULL,
  `company_url` VARCHAR(50) NOT NULL COMMENT '公司图片',
  `company_name` VARCHAR(100) NOT NULL COMMENT '公司名称',
  `company_address` VARCHAR(100) NOT NULL COMMENT '公司地址',
  `company_authentication` VARCHAR(50) NOT NULL COMMENT '企业认证(图片)',
  `is_authentication` SMALLINT(5) NOT NULL COMMENT '是否认证',
  `tel` VARCHAR(20) NOT NULL COMMENT '联系方式\'',
  `qq` VARCHAR(45) NOT NULL COMMENT 'qq',
  `business` VARCHAR(100) NOT NULL COMMENT '业务范围',
  `introduce` VARCHAR(300) NOT NULL COMMENT '公司介绍',
  `user_id` VARCHAR(45) NOT NULL COMMENT '注册用户id',
  `create_time` TIMESTAMP(6) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `civil`.`customer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `civil`.`customer` ;

CREATE TABLE IF NOT EXISTS `civil`.`customer` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `customer_id` VARCHAR(50) NOT NULL COMMENT '客户id',
  `contract_name` VARCHAR(50) NOT NULL COMMENT '合同名称',
  `user_id` VARCHAR(50) NOT NULL COMMENT '客户拥有者id',
  `status` SMALLINT(5) NOT NULL COMMENT '合同状态',
  `create_time` TIMESTAMP(6) NOT NULL COMMENT '时间',
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `civil`.`evaluate`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `civil`.`evaluate` ;

CREATE TABLE IF NOT EXISTS `civil`.`evaluate` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `evaluate_content` VARCHAR(500) NOT NULL COMMENT '评价',
  `create_time` TIMESTAMP(6) NOT NULL COMMENT '评价时间',
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `civil`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `civil`.`user` ;

CREATE TABLE IF NOT EXISTS `civil`.`user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `login_cell` VARCHAR(45) NOT NULL COMMENT '\'登录账号(手机号)',
  `user_pwd` VARCHAR(45) NOT NULL COMMENT '用户密码',
  `wecahat_id` INT NOT NULL COMMENT '微信账号',
  `register_time` TIMESTAMP(6) NOT NULL COMMENT '注册时间',
  `evaluate_time` INT NOT NULL COMMENT '评价次数（默认一次）',
  `is_top` INT NOT NULL COMMENT '企业是否推荐',
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `civil`.`evaluate_user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `civil`.`evaluate_user` ;

CREATE TABLE IF NOT EXISTS `civil`.`evaluate_user` (
  `evaluate_id` INT NOT NULL COMMENT '评价id',
  `user_id` INT NOT NULL COMMENT '被评价者id',
  `evaluator_id` INT NOT NULL COMMENT '评价者id',
  PRIMARY KEY (`evaluate_id`, `user_id`),
  INDEX `fk_evaluate_has_user_user1_idx` (`user_id` ASC),
  INDEX `fk_evaluate_has_user_evaluate1_idx` (`evaluate_id` ASC),
  CONSTRAINT `fk_evaluate_has_user_evaluate1`
    FOREIGN KEY (`evaluate_id`)
    REFERENCES `civil`.`evaluate` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_evaluate_has_user_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `civil`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `civil`.`category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `civil`.`category` ;

CREATE TABLE IF NOT EXISTS `civil`.`category` (
  `category_id` INT NOT NULL AUTO_INCREMENT,
  `level` INT NOT NULL COMMENT '类别层级',
  `pid` INT NOT NULL COMMENT '父级类别',
  `c_name` VARCHAR(45) NOT NULL COMMENT '类别名称',
  `is_show` INT NOT NULL COMMENT '是否首页显示',
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `civil`.`user_category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `civil`.`user_category` ;

CREATE TABLE IF NOT EXISTS `civil`.`user_category` (
  `user_id` INT NOT NULL,
  `category_id` INT NOT NULL,
  PRIMARY KEY (`user_id`, `category_id`),
  INDEX `fk_user_type_has_user_information_user_information1_idx` (`category_id` ASC),
  INDEX `fk_user_type_has_user_information_user_type1_idx` (`user_id` ASC),
  CONSTRAINT `fk_user_type_has_user_information_user_type1`
    FOREIGN KEY (`user_id`)
    REFERENCES `civil`.`category` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_type_has_user_information_user_information1`
    FOREIGN KEY (`category_id`)
    REFERENCES `civil`.`user_information` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `civil`.`notice`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `civil`.`notice` ;

CREATE TABLE IF NOT EXISTS `civil`.`notice` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `notice_content` VARCHAR(45) NOT NULL COMMENT '公告内容(文内内容)',
  `create_time` TIMESTAMP(6) NOT NULL COMMENT '发布时间',
  `edit_time` TIMESTAMP(6) NOT NULL COMMENT '修改时间',
  `notice_url` VARCHAR(45) NOT NULL COMMENT '公告图片',
  `notice_video` VARCHAR(100) NOT NULL COMMENT '公告视频',
  `category_id` INT NOT NULL COMMENT '公告分类id',
  `user_id` INT NOT NULL COMMENT '公告发布者id',
  `is_on` INT NOT NULL COMMENT '是否推荐',
  `is_top` INT NOT NULL COMMENT '是否置顶',
  `start_time` TIMESTAMP(6) NOT NULL COMMENT '开始时间',
  `stop_time` TIMESTAMP(6) NOT NULL COMMENT '结束时间',
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `civil`.`user_notice`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `civil`.`user_notice` ;

CREATE TABLE IF NOT EXISTS `civil`.`user_notice` (
  `user_id` INT NOT NULL COMMENT '发布者id',
  `notice_id` INT NOT NULL COMMENT '公告id',
  PRIMARY KEY (`user_id`, `notice_id`),
  INDEX `fk_user_has_Notice_Notice1_idx` (`notice_id` ASC),
  INDEX `fk_user_has_Notice_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_user_has_Notice_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `civil`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_Notice_Notice1`
    FOREIGN KEY (`notice_id`)
    REFERENCES `civil`.`notice` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `civil`.`collection`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `civil`.`collection` ;

CREATE TABLE IF NOT EXISTS `civil`.`collection` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `collection_user_id` INT NOT NULL COMMENT '收藏者id',
  `collectioned_user_id` INT NOT NULL COMMENT '被收藏公司id',
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `civil`.`news`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `civil`.`news` ;

CREATE TABLE IF NOT EXISTS `civil`.`news` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL COMMENT '标题',
  `content` VARCHAR(500) NOT NULL COMMENT '新闻内容',
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `civil`.`web_notice`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `civil`.`web_notice` ;

CREATE TABLE IF NOT EXISTS `civil`.`web_notice` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `content` VARCHAR(300) NOT NULL COMMENT '网站公告内容',
  `pic` VARCHAR(45) NOT NULL COMMENT '图片',
  `create_time` TIMESTAMP(6) NOT NULL COMMENT '创建时间',
  `edit_time` TIMESTAMP(6) NOT NULL COMMENT '修改时间',
  `is_show` INT NOT NULL COMMENT '是否显示',
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `civil`.`banner`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `civil`.`banner` ;

CREATE TABLE IF NOT EXISTS `civil`.`banner` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `pic` VARCHAR(45) NOT NULL COMMENT '图片',
  `url` VARCHAR(45) NOT NULL COMMENT '跳转地址',
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `civil`.`technology`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `civil`.`technology` ;

CREATE TABLE IF NOT EXISTS `civil`.`technology` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL COMMENT '标题',
  `category_id` INT NOT NULL COMMENT '分类id',
  `is_show` TINYINT(10) NOT NULL COMMENT '是否显示',
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


CREATE TABLE `civil`.`evaluate_user` ( `evaluate_id` INT(10) NOT NULL COMMENT '评价id' , `evaluator_id` INT(10) NOT NULL COMMENT '评价者id' , `user_id` INT(10) NOT NULL COMMENT '被评价者id' ) ENGINE = InnoDB;

ALTER TABLE `user_information` ADD `company_video` VARCHAR(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '宣传视频' AFTER `company_url`;