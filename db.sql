/*
SQLyog Community v13.1.6 (64 bit)
MySQL - 8.0.28 : Database - db
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`db` /*!40100 DEFAULT CHARACTER SET utf8 */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `db`;

/*Table structure for table `activity` */

DROP TABLE IF EXISTS `activity`;

CREATE TABLE `activity` (
  `activityId` int NOT NULL AUTO_INCREMENT,
  `activityName` varchar(50) NOT NULL,
  `activityDes` varchar(500) NOT NULL,
  `discount` float DEFAULT '1',
  `fullPrice` int DEFAULT NULL,
  `reducePrice` int DEFAULT NULL,
  `fullNum` int DEFAULT NULL,
  `reduceNum` int DEFAULT NULL,
  PRIMARY KEY (`activityId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

/*Data for the table `activity` */

insert  into `activity`(`activityId`,`activityName`,`activityDes`,`discount`,`fullPrice`,`reducePrice`,`fullNum`,`reduceNum`) values 
(1,'测试活动','1231',1,123,123,1231,12),
(2,'开业大酬宾','开业大酬宾，全场9折。',9.2,100,8,200,20);

/*Table structure for table `address` */

DROP TABLE IF EXISTS `address`;

CREATE TABLE `address` (
  `addressID` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL,
  `province` varchar(50) NOT NULL,
  `city` varchar(50) NOT NULL,
  `county` varchar(50) NOT NULL,
  `detailAddr` varchar(50) NOT NULL,
  `conName` varchar(50) NOT NULL,
  `conTel` varchar(50) NOT NULL,
  PRIMARY KEY (`addressID`),
  KEY `addressID` (`addressID`),
  KEY `userId` (`userId`),
  CONSTRAINT `address_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `user` (`userId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3;

/*Data for the table `address` */

insert  into `address`(`addressID`,`userId`,`province`,`city`,`county`,`detailAddr`,`conName`,`conTel`) values 
(7,1,'北京市','北京市市辖区','东城区','12312','123123','2131231321'),
(8,3,'河南省','洛阳市','涧西区','河南科技大学','张三','1234567890');

/*Table structure for table `admin` */

DROP TABLE IF EXISTS `admin`;

CREATE TABLE `admin` (
  `adminId` int NOT NULL AUTO_INCREMENT,
  `adminName` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  PRIMARY KEY (`adminId`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;

/*Data for the table `admin` */

insert  into `admin`(`adminId`,`adminName`,`password`) values 
(1,'admin','25d55ad283aa400af464c76d713c07ad');

/*Table structure for table `category` */

DROP TABLE IF EXISTS `category`;

CREATE TABLE `category` (
  `cateId` int NOT NULL AUTO_INCREMENT,
  `cateName` varchar(50) NOT NULL,
  PRIMARY KEY (`cateId`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;

/*Data for the table `category` */

insert  into `category`(`cateId`,`cateName`) values 
(1,'数码'),
(2,'服饰'),
(3,'家电'),
(4,'书籍'),
(5,'其他');

/*Table structure for table `collection` */

DROP TABLE IF EXISTS `collection`;

CREATE TABLE `collection` (
  `userId` int NOT NULL,
  `goodsId` int NOT NULL,
  `collectTime` datetime NOT NULL,
  PRIMARY KEY (`userId`,`goodsId`),
  KEY `collection_ibfk_2` (`goodsId`),
  CONSTRAINT `collection_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `user` (`userId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `collection_ibfk_2` FOREIGN KEY (`goodsId`) REFERENCES `goods` (`goodsId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

/*Data for the table `collection` */

insert  into `collection`(`userId`,`goodsId`,`collectTime`) values 
(3,93,'2019-05-13 10:47:26'),
(3,94,'2019-05-13 10:16:11'),
(3,95,'2019-05-13 10:37:35'),
(3,97,'2019-05-13 10:23:11');

/*Table structure for table `comment` */

DROP TABLE IF EXISTS `comment`;

CREATE TABLE `comment` (
  `commentId` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL,
  `goodsId` int NOT NULL,
  `point` int NOT NULL,
  `content` varchar(255) NOT NULL,
  `commentTime` datetime NOT NULL,
  PRIMARY KEY (`commentId`),
  KEY `userId` (`userId`),
  KEY `goodsId` (`goodsId`),
  CONSTRAINT `comment_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `user` (`userId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `comment_ibfk_2` FOREIGN KEY (`goodsId`) REFERENCES `goods` (`goodsId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

/*Data for the table `comment` */

insert  into `comment`(`commentId`,`userId`,`goodsId`,`point`,`content`,`commentTime`) values 
(2,3,93,4,'商品特别好，我非常喜欢','2019-05-13 10:48:51');

/*Table structure for table `deliver` */

DROP TABLE IF EXISTS `deliver`;

CREATE TABLE `deliver` (
  `deliverId` int NOT NULL AUTO_INCREMENT,
  `orderId` int NOT NULL,
  `sendId` int NOT NULL,
  PRIMARY KEY (`deliverId`),
  KEY `orderId` (`orderId`),
  CONSTRAINT `deliver_ibfk_1` FOREIGN KEY (`orderId`) REFERENCES `indent` (`orderId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

/*Data for the table `deliver` */

/*Table structure for table `goods` */

DROP TABLE IF EXISTS `goods`;

CREATE TABLE `goods` (
  `goodsId` int NOT NULL AUTO_INCREMENT,
  `goodsName` varchar(50) NOT NULL,
  `price` int NOT NULL,
  `num` int NOT NULL,
  `upTime` datetime NOT NULL,
  `category` int NOT NULL,
  `detailCate` varchar(50) NOT NULL,
  `description` text NOT NULL,
  `activityId` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`goodsId`),
  KEY `activityId` (`activityId`),
  KEY `category` (`category`),
  CONSTRAINT `goods_ibfk_1` FOREIGN KEY (`activityId`) REFERENCES `activity` (`activityId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `goods_ibfk_2` FOREIGN KEY (`category`) REFERENCES `category` (`cateId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb3;

/*Data for the table `goods` */

insert  into `goods`(`goodsId`,`goodsName`,`price`,`num`,`upTime`,`category`,`detailCate`,`description`,`activityId`) values 
(93,'手机',10,29,'2019-05-10 19:43:04',1,'测试','这是测试商品1',1),
(94,'大衣',23,34,'2019-05-10 19:44:28',2,'测试','这是测试商品2',1),
(95,'电视机',123,1231,'2019-05-11 11:41:24',1,'测试','测试商品',1),
(96,'笔记本',213,222,'2019-05-11 11:42:00',1,'12321','这是一个测试商品4',1),
(97,'电脑',213,212,'2019-05-13 10:22:58',1,'测试','这是测试商品',1),
(98,'冰箱',10,100,'2021-07-24 11:50:07',1,'测试','测试商品',1),
(99,'风扇',1231,1231,'2021-07-24 11:51:20',1,'1231231','1231',1);

/*Table structure for table `imagepath` */

DROP TABLE IF EXISTS `imagepath`;

CREATE TABLE `imagepath` (
  `pathId` int NOT NULL AUTO_INCREMENT,
  `goodId` int NOT NULL,
  `path` varchar(255) NOT NULL,
  PRIMARY KEY (`pathId`),
  KEY `goodid` (`goodId`),
  CONSTRAINT `imagepath_ibfk_1` FOREIGN KEY (`goodId`) REFERENCES `goods` (`goodsId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=131 DEFAULT CHARSET=utf8mb3;

/*Data for the table `imagepath` */

insert  into `imagepath`(`pathId`,`goodId`,`path`) values 
(114,93,'3a25测试商品1新公司录用offer.png'),
(115,93,'6a7b测试商品1原公司解约通知.png'),
(116,94,'c1a9测试商品2user3.png'),
(117,95,'bd30这是测试商品QQ浏览器截图20181120200039.png'),
(118,96,'94e9123QQ浏览器截图20180925163930.png'),
(119,96,'7c68123QQ浏览器截图20181120200033.png'),
(120,96,'669e123QQ浏览器截图20181120200038.png'),
(121,97,'c2e5测试商品5QQ浏览器截图20180628082816.png'),
(122,97,'61dd测试商品5QQ浏览器截图20180910091336.png'),
(123,97,'0f0b测试商品5QQ浏览器截图20180917082049.png'),
(124,97,'8020测试商品5QQ浏览器截图20180925163930.png'),
(125,97,'d8f2测试商品5QQ浏览器截图20181120200033.png'),
(126,97,'776b测试商品5QQ浏览器截图20181120200038.png'),
(127,97,'65be测试商品5QQ浏览器截图20181120200039.png'),
(128,97,'c2a3测试商品5QQ浏览器截图20190307101645.png'),
(129,98,'a0a9test商品1复制算法.png'),
(130,99,'false');

/*Table structure for table `indent` */

DROP TABLE IF EXISTS `indent`;

CREATE TABLE `indent` (
  `orderId` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL,
  `orderTime` datetime NOT NULL,
  `oldPrice` float NOT NULL,
  `newPrice` float NOT NULL,
  `isPay` tinyint(1) NOT NULL,
  `isSend` tinyint(1) NOT NULL,
  `isReceive` tinyint(1) NOT NULL,
  `isComplete` tinyint(1) NOT NULL,
  `addressId` int NOT NULL,
  PRIMARY KEY (`orderId`),
  KEY `userId` (`userId`),
  KEY `orderGoods` (`orderTime`),
  KEY `addressId` (`addressId`),
  CONSTRAINT `indent_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `user` (`userId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `indent_ibfk_2` FOREIGN KEY (`addressId`) REFERENCES `address` (`addressID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb3;

/*Data for the table `indent` */

insert  into `indent`(`orderId`,`userId`,`orderTime`,`oldPrice`,`newPrice`,`isPay`,`isSend`,`isReceive`,`isComplete`,`addressId`) values 
(28,3,'2019-05-11 11:33:10',10,10,1,1,1,1,8),
(29,3,'2019-05-11 11:39:39',125,125,1,1,1,1,8),
(30,3,'2019-05-13 10:16:19',109,109,1,1,1,1,8),
(31,3,'2019-05-13 10:37:59',10,10,0,1,1,1,8),
(32,3,'2019-05-13 10:43:05',10,10,1,1,0,0,8),
(33,3,'2019-05-13 10:47:42',40,40,1,1,1,1,8),
(34,3,'2021-07-24 12:02:01',40,40,1,1,1,1,8);

/*Table structure for table `orderitem` */

DROP TABLE IF EXISTS `orderitem`;

CREATE TABLE `orderitem` (
  `itemId` int NOT NULL AUTO_INCREMENT,
  `orderId` int NOT NULL,
  `goodsId` int NOT NULL,
  `num` int NOT NULL,
  PRIMARY KEY (`itemId`),
  KEY `orderId` (`orderId`),
  KEY `goodsId` (`goodsId`),
  CONSTRAINT `orderitem_ibfk_1` FOREIGN KEY (`orderId`) REFERENCES `indent` (`orderId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `orderitem_ibfk_2` FOREIGN KEY (`goodsId`) REFERENCES `goods` (`goodsId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb3;

/*Data for the table `orderitem` */

insert  into `orderitem`(`itemId`,`orderId`,`goodsId`,`num`) values 
(14,28,93,1),
(15,29,93,1),
(16,29,94,5),
(17,30,93,4),
(18,30,94,3),
(19,31,93,1),
(20,32,93,1),
(21,33,93,4),
(22,34,98,4);

/*Table structure for table `shopcart` */

DROP TABLE IF EXISTS `shopcart`;

CREATE TABLE `shopcart` (
  `userId` int NOT NULL,
  `goodsid` int NOT NULL,
  `cateDate` datetime NOT NULL,
  `goodsNum` int NOT NULL,
  PRIMARY KEY (`userId`,`goodsid`),
  KEY `userId` (`userId`),
  KEY `goodsid` (`goodsid`),
  CONSTRAINT `shopcart_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `user` (`userId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `shopcart_ibfk_2` FOREIGN KEY (`goodsid`) REFERENCES `goods` (`goodsId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

/*Data for the table `shopcart` */

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `userId` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `regTime` datetime NOT NULL,
  `email` varchar(50) NOT NULL,
  `telephone` varchar(50) NOT NULL,
  PRIMARY KEY (`userId`),
  KEY `userId` (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;

/*Data for the table `user` */

insert  into `user`(`userId`,`username`,`password`,`regTime`,`email`,`telephone`) values 
(1,'root','25d55ad283aa400af464c76d713c07ad','2019-04-18 17:16:34','916877983@qq.com','18229819406'),
(2,'codingzx','25d55ad283aa400af464c76d713c07ad','2019-04-22 15:29:12','994683607@qq.com','18229819406'),
(3,'admin','25d55ad283aa400af464c76d713c07ad','2019-05-16 10:46:46','123123','1231321'),
(6,'123','25d55ad283aa400af464c76d713c07ad','2022-03-02 11:24:04','1472734314@qq.com','64189181261');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
