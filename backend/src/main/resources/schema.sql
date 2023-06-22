-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema kiosk
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema kiosk
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `kiosk` DEFAULT CHARACTER SET utf8 ;
USE `kiosk` ;

-- -----------------------------------------------------
-- Table `kiosk`.`category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `kiosk`.`category` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(45) NOT NULL,
    PRIMARY KEY (`id`))
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `kiosk`.`menu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `kiosk`.`menu` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(45) NOT NULL,
    `price` INT NOT NULL,
    `image` VARCHAR(512) NOT NULL,
    `category_id` INT NOT NULL,
    PRIMARY KEY (`id`),
    INDEX `fk_menu_category_idx` (`category_id` ASC),
    CONSTRAINT `fk_menu_category`
    FOREIGN KEY (`category_id`)
    REFERENCES `kiosk`.`category` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `kiosk`.`payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `kiosk`.`payment` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(45) NOT NULL,
    PRIMARY KEY (`id`))
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `kiosk`.`order_status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `kiosk`.`order_status` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(45) NOT NULL,
    PRIMARY KEY (`id`))
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `kiosk`.`order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `kiosk`.`order` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `total_amount` INT NOT NULL COMMENT '총 결제금액',
    `received_amount` INT NOT NULL COMMENT '지불 금액',
    `change` INT NOT NULL COMMENT '거스름돈',
    `payment_id` INT NOT NULL,
    `order_status_id` INT NOT NULL,
    PRIMARY KEY (`id`),
    INDEX `fk_order_payment_idx` (`payment_id` ASC) ,
    INDEX `fk_order_order_status_idx` (`order_status_id` ASC) ,
    CONSTRAINT `fk_order_payment`
    FOREIGN KEY (`payment_id`)
    REFERENCES `kiosk`.`payment` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    CONSTRAINT `fk_order_order_status`
    FOREIGN KEY (`order_status_id`)
    REFERENCES `kiosk`.`order_status` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `kiosk`.`order_menu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `kiosk`.`order_menu` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `count` INT NOT NULL,
    `menu_id` INT NOT NULL,
    `order_id` INT NOT NULL,
    PRIMARY KEY (`id`),
    INDEX `fk_order_menu_menu_idx` (`menu_id` ASC) ,
    INDEX `fk_order_menu_order_idx` (`order_id` ASC) ,
    CONSTRAINT `fk_order_menu_menu`
    FOREIGN KEY (`menu_id`)
    REFERENCES `kiosk`.`menu` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    CONSTRAINT `fk_order_menu_order`
    FOREIGN KEY (`order_id`)
    REFERENCES `kiosk`.`order` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `kiosk`.`option`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `kiosk`.`option` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(45) NOT NULL,
    PRIMARY KEY (`id`))
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `kiosk`.`order_menu_option`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `kiosk`.`order_menu_option` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `option_id` INT NOT NULL,
    `order_menu_id` INT NOT NULL,
    PRIMARY KEY (`id`),
    INDEX `fk_order_menu_option_option_idx` (`option_id` ASC) ,
    INDEX `fk_order_menu_option_order_menu_idx` (`order_menu_id` ASC) ,
    CONSTRAINT `fk_order_menu_option_option`
    FOREIGN KEY (`option_id`)
    REFERENCES `kiosk`.`option` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    CONSTRAINT `fk_order_menu_option_order_menu`
    FOREIGN KEY (`order_menu_id`)
    REFERENCES `kiosk`.`order_menu` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `kiosk`.`sales`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `kiosk`.`sales` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `count` INT NOT NULL,
    `date` DATETIME NOT NULL,
    `menu_id` INT NOT NULL,
    PRIMARY KEY (`id`),
    INDEX `fk_sales_menu_idx` (`menu_id` ASC) ,
    CONSTRAINT `fk_sales_menu`
    FOREIGN KEY (`menu_id`)
    REFERENCES `kiosk`.`menu` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
    ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;