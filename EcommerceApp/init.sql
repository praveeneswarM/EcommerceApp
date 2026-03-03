-- -----------------------------------------------------------------------------
-- EcommerceApp - MySQL initialization script
-- Creates database, user, tables, views, and seeds data.
-- Safe to re-run: uses DROP IF EXISTS and IF NOT EXISTS where possible.
-- Charset: utf8mb4 for full Unicode support.
-- -----------------------------------------------------------------------------

-- 1) Create database and user (adjust password as needed)
DROP DATABASE IF EXISTS `ecomdb`;
CREATE DATABASE `ecomdb` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;

-- Create dedicated application user (optional if you use root)
-- NOTE: MySQL 8: use caching_sha2_password by default
DROP USER IF EXISTS 'ecomuser'@'%';
CREATE USER 'ecomuser'@'%' IDENTIFIED BY 'ecomPass123!';
GRANT ALL PRIVILEGES ON `ecomdb`.* TO 'ecomuser'@'%';
FLUSH PRIVILEGES;

USE `ecomdb`;

-- 2) Tables
-- Using InnoDB and utf8mb4
-- Adjust lengths where necessary; converted Contact_No to VARCHAR for flexibility.

DROP TABLE IF EXISTS `order_details`;
DROP TABLE IF EXISTS `orders`;
DROP TABLE IF EXISTS `cart`;
DROP TABLE IF EXISTS `product`;
DROP TABLE IF EXISTS `brand`;
DROP TABLE IF EXISTS `category`;
DROP TABLE IF EXISTS `contactus`;
DROP TABLE IF EXISTS `customer`;
DROP TABLE IF EXISTS `login`;
DROP TABLE IF EXISTS `usermaster`;

CREATE TABLE `brand` (
  `bid` INT NOT NULL,
  `bname` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`bid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `category` (
  `cid` INT NOT NULL,
  `cname` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `product` (
  `pid` INT NOT NULL AUTO_INCREMENT,
  `pname` VARCHAR(50) NOT NULL,
  `pprice` INT NOT NULL,
  `pquantity` INT NOT NULL,
  `pimage` VARCHAR(200) DEFAULT NULL,
  `bid` INT DEFAULT NULL,
  `cid` INT DEFAULT NULL,
  PRIMARY KEY (`pid`),
  KEY `idx_product_bid` (`bid`),
  KEY `idx_product_cid` (`cid`),
  CONSTRAINT `fk_product_brand` FOREIGN KEY (`bid`) REFERENCES `brand` (`bid`)
    ON UPDATE CASCADE ON DELETE SET NULL,
  CONSTRAINT `fk_product_category` FOREIGN KEY (`cid`) REFERENCES `category` (`cid`)
    ON UPDATE CASCADE ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `cart` (
  `Name` VARCHAR(100),
  `bname` VARCHAR(50),
  `cname` VARCHAR(50),
  `pname` VARCHAR(50),
  `pprice` INT,
  `pquantity` INT,
  `pimage` VARCHAR(200)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `contactus` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(100) DEFAULT NULL,
  `Email_Id` VARCHAR(100) DEFAULT NULL,
  `Contact_No` VARCHAR(30) DEFAULT NULL,
  `Message` VARCHAR(8000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `customer` (
  `Name` VARCHAR(100) DEFAULT NULL,
  `Password` VARCHAR(255) DEFAULT NULL,
  `Email_Id` VARCHAR(100) DEFAULT NULL,
  `Contact_No` VARCHAR(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `login` (
  `username` VARCHAR(100) DEFAULT NULL,
  `password` VARCHAR(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `orders` (
  `Order_Id` INT NOT NULL AUTO_INCREMENT,
  `Customer_Name` VARCHAR(100) DEFAULT NULL,
  `Customer_City` VARCHAR(45) DEFAULT NULL,
  `Date` VARCHAR(100) DEFAULT NULL,
  `Total_Price` INT DEFAULT NULL,
  `Status` VARCHAR(45) DEFAULT NULL,
  PRIMARY KEY (`Order_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `order_details` (
  `Date` VARCHAR(100) DEFAULT NULL,
  `Name` VARCHAR(100) DEFAULT NULL,
  `bname` VARCHAR(50) DEFAULT NULL,
  `cname` VARCHAR(50) DEFAULT NULL,
  `pname` VARCHAR(50) DEFAULT NULL,
  `pprice` INT DEFAULT NULL,
  `pquantity` INT DEFAULT NULL,
  `pimage` VARCHAR(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `usermaster` (
  `Name` VARCHAR(100) DEFAULT NULL,
  `Password` VARCHAR(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 3) Seed data

INSERT INTO `brand` (`bid`,`bname`) VALUES
  (1,'samsung'),(2,'sony'),(3,'lenovo'),(4,'acer'),(5,'onida');

INSERT INTO `category` (`cid`,`cname`) VALUES
  (1,'laptop'),(2,'tv'),(3,'mobile'),(4,'watch');

INSERT INTO `login` (`username`,`password`) VALUES ('admin','admin');

INSERT INTO `usermaster` (`Name`,`Password`) VALUES ('admin','admin');

INSERT INTO `product` (`pid`,`pname`,`pprice`,`pquantity`,`pimage`,`bid`,`cid`) VALUES
(5,'sonysmart',50000,1,'sonywatch.webp',2,4),
(6,'GalaxyBook',45000,1,'samsunglaptop.jpg',1,1),
(7,'smarttv',28000,1,'onidatv.jpg',5,2),
(8,'smartphone',15000,1,'lenovomobile.webp',3,3),
(9,'aspire',52000,1,'acerlaptop.jpg',4,1),
(10,'Braviass',52,1,'sonytv.jpg',2,2),
(11,'GalaxyWatch',22000,1,'galaxywatch.webp',1,4),
(14,'kdl',45000,1,'sony kdl.jpg',2,2),
(15,'series a7',21000,1,'acer series a7.jpg',4,2),
(17,'leo',31000,1,'onida leo.jpg',5,2),
(18,'crystal',42000,1,'samsung crystal.webp',1,2),
(19,'Aspire 7',55000,1,'acer aspire7.jpg',4,1),
(20,'ideapad',37000,1,'lenovo ideapad.jpg',3,1),
(21,'legion',51000,1,'lenovo legion.jpg',3,1),
(22,'Galaxy Z Fold3',66000,1,'Galaxy z fold3.jpg',1,3),
(23,'Galaxy S22',55000,1,'Samsung galaxy s22.webp',1,3),
(24,'Xperia 1v',56000,1,'sony xperia 1v.jpg',2,3),
(26,'A850',14500,1,'lenovo a850.jpg',3,3),
(27,'Galaxy watch1',8000,1,'galaxy watch.jpg',1,4),
(28,'Galaxy Watch2',95000,1,'galaxy watch4.jpg',1,4),
(29,'Smart Fit',11000,1,'smart fit.jpg',3,4),
(30,'Sony Smart2',12000,1,'sony smart2.webp',2,4),
(31,'Gaming Predator',120000,1,'Acer Predator.jpg',4,1),
(32,'Liquid',16000,1,'Acer liquid.jpg',4,3),
(33,'Neo QLED',46000,1,'Samsung neo Qled.webp',1,2),
(34,'VAIO',53000,1,'Sony Vaio.jpg',2,1),
(35,'Xperia Z',32000,1,'sonyxperiaz.png',2,3);

-- 4) Views (drop if exist then recreate)

DROP VIEW IF EXISTS `viewlist`;
CREATE VIEW `viewlist` AS
SELECT b.bname, c.cname, p.pname, p.pprice, p.pquantity, p.pimage
FROM brand b
JOIN product p ON b.bid = p.bid
JOIN category c ON p.cid = c.cid;

DROP VIEW IF EXISTS `mobile`;
CREATE VIEW `mobile` AS
SELECT b.bname, c.cname, p.pname, p.pprice, p.pquantity, p.pimage
FROM brand b
JOIN product p ON b.bid = p.bid
JOIN category c ON p.cid = c.cid
WHERE c.cid = 3;

DROP VIEW IF EXISTS `laptop`;
CREATE VIEW `laptop` AS
SELECT b.bname, c.cname, p.pname, p.pprice, p.pquantity, p.pimage
FROM brand b
JOIN product p ON b.bid = p.bid
JOIN category c ON p.cid = c.cid
WHERE c.cid = 1;

DROP VIEW IF EXISTS `tv`;
CREATE VIEW `tv` AS
SELECT b.bname, c.cname, p.pname, p.pprice, p.pquantity, p.pimage
FROM brand b
JOIN product p ON b.bid = p.bid
JOIN category c ON p.cid = c.cid
WHERE c.cid = 2;

DROP VIEW IF EXISTS `watch`;
CREATE VIEW `watch` AS
SELECT b.bname, c.cname, p.pname, p.pprice, p.pquantity, p.pimage
FROM brand b
JOIN product p ON b.bid = p.bid
JOIN category c ON p.cid = c.cid
WHERE c.cid = 4;
