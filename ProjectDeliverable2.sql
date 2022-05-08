CREATE DATABASE  IF NOT EXISTS `cs336projectdb` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `cs336projectdb`;
-- MySQL dump 10.13  Distrib 8.0.28, for Win64 (x86_64)
--
-- Host: localhost    Database: cs336projectdb
-- ------------------------------------------------------
-- Server version	8.0.28

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `username` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `isAdmin` boolean NOT NULL,
  `isRep` boolean NOT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('Ethan','ethan@gmail.com', false, false),
	('admin', 'admin@gmail.com', true, false),
    ('sne', 'sne@gmail.com', false, false),
    ('devin', 'devin@gmail.com', false, false),
    ('ruan', 'ruan@gmail.com', false, false);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;


--
-- Table structure for table `items`
--

SET foreign_key_checks = 0;
DROP TABLE IF EXISTS `items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `items` (
  `itemID` bigint NOT NULL,
  `clothingType` varchar(50) NOT NULL,
  `size` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `color` varchar(50) DEFAULT NULL,
  `season` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`itemID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `auction`
--

DROP TABLE IF EXISTS `auctions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `auctions` (
  `auctionID` bigint NOT NULL,
  `itemID` bigint NOT NULL,
  `dateOpen` datetime DEFAULT NULL,
  `dateClose` datetime NOT NULL,
  `minPrice` float DEFAULT 0,
  `increment` float NOT NULL,
  `bidding` float,
  `winner` varchar(50) DEFAULT NULL,
  `owner` varchar(50) NOT NULL,
  `ownWin` boolean DEFAULT false,
  PRIMARY KEY (`auctionID`), FOREIGN KEY (`winner`) references `users`(`email`),
  FOREIGN KEY (`owner`) references `users`(`email`) ON DELETE CASCADE, 
  FOREIGN KEY (`itemID`) references `items`(`itemID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

SET foreign_key_checks = 1;

--
-- Table structure for table `bids`
--

DROP TABLE IF EXISTS `bids`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `bids` (
  `bidID` bigint NOT NULL,
  `auctionID` bigint NOT NULL,
  `amount` float NOT NULL,
  `bidder` varchar(50) NOT NULL,
  `autoIncrement` boolean NOT NULL,
  `incrementAmount` float,
  `maxBid` float,
  `reachedMax` boolean,
  `didAlertNorm` boolean DEFAULT false,
  `didAlertAuto` boolean DEFAULT false,
  `didAlertWin` boolean DEFAULT false,
  PRIMARY KEY (`bidID`), FOREIGN KEY (`bidder`) references `users`(`email`) ON DELETE CASCADE, 
  FOREIGN KEY (`auctionID`) references `auctions`(`auctionID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;


DROP TABLE IF EXISTS `customerServ`;
CREATE TABLE `customerServ` (
	`questionID` BIGINT NOT NULL,
	`question` VARCHAR(1000),
    `askingUser` VARCHAR(50),
    `dateAsked` DATETIME,
    `answer` VARCHAR(1000),
    `answeringRep` VARCHAR(50),
    `dateAnswered` DATETIME,
    `resolved` BOOLEAN,
    PRIMARY KEY (`questionID`), 
    FOREIGN KEY (`askingUser`) REFERENCES `users`(`email`) ON DELETE CASCADE,
    FOREIGN KEY (`answeringRep`) REFERENCES `users`(`email`) ON DELETE CASCADE
    );

--
-- Table structure for table `customerServ`
--

DROP TABLE IF EXISTS `itemsReq`;
CREATE TABLE `itemsReq` (
	`requestID` BIGINT NOT NULL,
	`user` VARCHAR(50) NOT NULL,
	`clothingType` VARCHAR(50) NOT NULL,
	`size` VARCHAR(50) DEFAULT NULL,
	`name` VARCHAR(50) DEFAULT NULL,
	`color` VARCHAR(50) DEFAULT NULL,
	`season` VARCHAR(20) DEFAULT NULL,
    `fulfilled` BOOLEAN DEFAULT False,
    PRIMARY KEY (`requestID`),
    FOREIGN KEY (`user`) REFERENCES `users`(`email`) ON DELETE CASCADE
    );

-- Dump completed on 2022-04-05 21:35:43