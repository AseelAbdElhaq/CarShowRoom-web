CREATE DATABASE  IF NOT EXISTS `car_showroom` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `car_showroom`;
-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: car_showroom
-- ------------------------------------------------------
-- Server version	8.0.36

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
-- Table structure for table `branch`
--

DROP TABLE IF EXISTS `branch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `branch` (
  `BranchNumber` varchar(32) NOT NULL,
  `Address` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`BranchNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `branch`
--

LOCK TABLES `branch` WRITE;
/*!40000 ALTER TABLE `branch` DISABLE KEYS */;
INSERT INTO `branch` VALUES ('B001','123 Main Street'),('B002','456 Elm Street');
/*!40000 ALTER TABLE `branch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `byworkingtime`
--

DROP TABLE IF EXISTS `byworkingtime`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `byworkingtime` (
  `SSN` varchar(32) NOT NULL,
  `HourSalary` double DEFAULT NULL,
  `HourWork` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`SSN`),
  CONSTRAINT `byworkingtime_ibfk_1` FOREIGN KEY (`SSN`) REFERENCES `employee` (`SSN`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `byworkingtime`
--

LOCK TABLES `byworkingtime` WRITE;
/*!40000 ALTER TABLE `byworkingtime` DISABLE KEYS */;
INSERT INTO `byworkingtime` VALUES ('1212508',10,'40 hours per week'),('1221024',12,'35 hours per week');
/*!40000 ALTER TABLE `byworkingtime` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `car`
--

DROP TABLE IF EXISTS `car`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `car` (
  `Color` varchar(32) DEFAULT NULL,
  `Price` double DEFAULT NULL,
  `ReleaseYear` int DEFAULT NULL,
  `Model` varchar(32) DEFAULT NULL,
  `MotorSize` float DEFAULT NULL,
  `FuelType` varchar(32) DEFAULT NULL,
  `TransmissionType` varchar(32) DEFAULT NULL,
  `ChassisNumber` varchar(32) NOT NULL,
  `ManufacturingCompany` varchar(32) DEFAULT NULL,
  `BranchNumber` varchar(32) DEFAULT NULL,
  `SSN` varchar(32) DEFAULT NULL,
  `is_Sold` int DEFAULT '0',
  `is_Reserved` int DEFAULT '0',
  PRIMARY KEY (`ChassisNumber`),
  KEY `BranchNumber` (`BranchNumber`),
  KEY `SSN` (`SSN`),
  CONSTRAINT `car_ibfk_1` FOREIGN KEY (`BranchNumber`) REFERENCES `branch` (`BranchNumber`),
  CONSTRAINT `car_ibfk_2` FOREIGN KEY (`SSN`) REFERENCES `customer` (`SSN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `car`
--

LOCK TABLES `car` WRITE;
/*!40000 ALTER TABLE `car` DISABLE KEYS */;
INSERT INTO `car` VALUES ('Red',42,2023,'SUV',1.6,'Solar','Automatic','1FTYR10D8WP654321','Kia','B002',NULL,0,0),('Black',68,2022,'Vintage',2,'Electric','Automatic','1FTYR10D8WPA12345','Audi','B002','1212508',0,1),('Blue',42,2019,'Coupes',1.4,'Electric','Manual','1HGCM82633A123987','BMW','B002',NULL,0,0),('Gray',53,2021,'Coupes',2,'Solar','Manual','1HGCM82633A321654','Audi','B002',NULL,0,0),('Brown',30,2019,'Sedan',1.4,'Solar','Manual','1HGCM82633A321987','Mercedes','B002',NULL,0,0),('Blue',24,2022,'Hybrid',1.2,'Electric','Manual','1HGCM82633A987654','Kia','B002',NULL,0,0),('Red',28,2020,'Sedan',1.2,'Electric','Manual','1N4AL11D75C654321','Hyundai','B002',NULL,0,0),('blue',70,2021,'4x4',2,'gas','automatic','2FTYR10D8WP654321','JEEP','B001',NULL,0,0),('Brown',29,2021,'SUV',1.4,'Gas','Manual','2HGFG118X8H654321','Chevrolet','B002',NULL,0,0),('Red',37,2020,'Van',1.6,'Gas','Manual','2T1BR32E04C123456','Mercedes','B001',NULL,0,0),('White',60,2023,'Sedan',2,'Gas','Automatic','3FTYR10D8WP654321','Mercedes','B001',NULL,0,0),('Gray',53,2023,'SUV',2,'Solar','Automatic','3VWFE21C04M123456','Chevrolet','B001',NULL,0,0),('Black',80,2020,'4x4',2,'Gas','Manual','4FTYR10D8WP654321','JEEP','B001',NULL,0,0),('Brown',32,2021,'4x4',2,'Gas','Automatic','4T1BE46KX1U123456','Hyundai','B002',NULL,0,0),('Black',33,2022,'Pick-Up',2,'Electric','Automatic','4T1BE46KX1U987654','Volkswagen','B002',NULL,0,0),('White',27,2020,'Sedan',1.6,'Solar','Manual','5FNYF4H51BB123456','Ford','B002',NULL,0,0),('Grey',38,2020,'Van',2,'Gas','Manual','5FNYF4H51BB987654','Fiat','B002',NULL,0,0),('Black',90,2023,'Sedan',1.6,'Gas','Automatic','5FTYR10D8WP654321','Mercedes','B001',NULL,0,0),('Blue',36,2019,'Hybrid',1.6,'Gas','Automatic','5J6RE4H59BL654321','Ford','B002',NULL,0,0),('Black',34,2020,'Pick-Up',1.2,'Gas','Manual','5YJSA1E26FFP321987','Mercedes','B002',NULL,0,0),('White',37,2020,'Coupes',1.6,'Solar','Manual','5YJSA1E26FFP54321','Toyota','B002',NULL,0,0),('Yellow',30,2018,'Sedan',1.6,'Solar','Automatic','6FTYR10D8WP654321','Skoda','B001',NULL,0,0),('Red',60,2024,'Sedan',2,'Solar','Manual','8FTYR10D8WP654321','Volkswagen','B001',NULL,0,0),('Blue',39,2023,'Van',2,'Solar','Automatic','9BWZZZ377VT321987','Hyundai','B002',NULL,0,0),('Black',52,2023,'Van',2,'Electric','Automatic','9BWZZZ377VT987654','Mercedes','B002',NULL,0,0),('Blue',47,2022,'4x4',2,'Gas','Automatic','JH4KA7550MC321654','Toyota','B002',NULL,0,0),('Red',35,2023,'Van',2,'Solar','Automatic','JH4KA7550MC654321','Fiat','B002',NULL,0,0),('Gray',63,2021,'Vintage',1.6,'Electric','Automatic','KM8SRDHF6HU321987','Chevrolet','B002',NULL,0,0),('Gray',45,2021,'SUV',2,'Gas','Automatic','KM8SRDHF6HU678901','Mazda','B002',NULL,0,0),('Green',41,2022,'4x4',1.6,'Solar','Automatic','WDBJF65JX3B654321','BMW','B002',NULL,0,0),('White',45,2022,'4x4',2,'Gas','Automatic','WDBJF65JX3B655555','BMW','B001',NULL,0,0),('Blue',31,2024,'Pick-Up',2,'Gas','Manual','WVWZZZ1JZXW123456','Volkswagen','B002',NULL,0,0),('White',26,2024,'Hybrid',2.5,'Electric','Automatic','WVWZZZ1JZXW654321','Mazda','B002',NULL,0,0);
/*!40000 ALTER TABLE `car` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `Address` varchar(32) DEFAULT NULL,
  `Phone` varchar(32) DEFAULT NULL,
  `SSN` varchar(32) NOT NULL,
  `Name` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`SSN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES ('Hebron','0597471347','1212508','Qusay Taradeh');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee` (
  `SSN` varchar(32) NOT NULL,
  `Phone` varchar(32) DEFAULT NULL,
  `Name` varchar(32) DEFAULT NULL,
  `Address` varchar(32) DEFAULT NULL,
  `Profession` varchar(32) DEFAULT NULL,
  `DOB` date DEFAULT NULL,
  `BranchNumber` varchar(32) DEFAULT NULL,
  `password` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`SSN`),
  KEY `BranchNumber` (`BranchNumber`),
  CONSTRAINT `employee_ibfk_1` FOREIGN KEY (`BranchNumber`) REFERENCES `branch` (`BranchNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` VALUES ('1211441','0568899231','Moaid Karakra','Ramallah','Manager','2003-12-30','B001','123'),('1212508','0597471347','Qusay Taradeh','Hebron','Manager','2003-03-18','B002','123'),('1220002','0598585751','Deema Abu Nimeh','Ramallah','Manager','2004-05-28','B001','123'),('1221024','0598347004','Aseel Abd Elhaq','Ramallah','Manager','2004-07-01','B001','123');
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `worksbycontract`
--

DROP TABLE IF EXISTS `worksbycontract`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `worksbycontract` (
  `SSN` varchar(32) NOT NULL,
  `MonthSalary` double DEFAULT NULL,
  `EndDate` date DEFAULT NULL,
  `StartDate` date DEFAULT NULL,
  PRIMARY KEY (`SSN`),
  CONSTRAINT `worksbycontract_ibfk_1` FOREIGN KEY (`SSN`) REFERENCES `employee` (`SSN`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `worksbycontract`
--

LOCK TABLES `worksbycontract` WRITE;
/*!40000 ALTER TABLE `worksbycontract` DISABLE KEYS */;
INSERT INTO `worksbycontract` VALUES ('1211441',2000,'2034-12-31','2024-01-01'),('1220002',1500,'2034-06-30','2024-03-15');
/*!40000 ALTER TABLE `worksbycontract` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-06-10  0:34:17
