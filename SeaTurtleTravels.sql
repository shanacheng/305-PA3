-- MySQL dump 10.13  Distrib 8.0.20, for Win64 (x86_64)
--
-- Host: localhost    Database: sys
-- ------------------------------------------------------
-- Server version	8.0.20

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
-- Table structure for table `advpurchasediscount`
--

DROP TABLE IF EXISTS `advpurchasediscount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `advpurchasediscount` (
  `AirlineID` char(2) NOT NULL,
  `Days` int NOT NULL,
  `DiscountRate` decimal(10,2) NOT NULL,
  PRIMARY KEY (`AirlineID`,`Days`),
  CONSTRAINT `advpurchasediscount_ibfk_1` FOREIGN KEY (`AirlineID`) REFERENCES `airline` (`Id`),
  CONSTRAINT `advpurchasediscount_chk_1` CHECK ((`Days` > 0)),
  CONSTRAINT `advpurchasediscount_chk_2` CHECK (((`DiscountRate` > 0) and (`DiscountRate` < 100)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `advpurchasediscount`
--

LOCK TABLES `advpurchasediscount` WRITE;
/*!40000 ALTER TABLE `advpurchasediscount` DISABLE KEYS */;
/*!40000 ALTER TABLE `advpurchasediscount` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `airline`
--

DROP TABLE IF EXISTS `airline`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `airline` (
  `Id` char(2) NOT NULL,
  `Name` varchar(100) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `airline`
--

LOCK TABLES `airline` WRITE;
/*!40000 ALTER TABLE `airline` DISABLE KEYS */;
INSERT INTO `airline` VALUES ('AA','American Airlines'),('AB','Air Berlin'),('AJ','Air Japan'),('AM','Air Madagascar'),('BA','British Airways'),('DA','Delta Airlines'),('JA','JetBlue Airways'),('L','Lufthansa'),('SA','Southwest Airlines'),('UA','United Airlines');
/*!40000 ALTER TABLE `airline` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `airport`
--

DROP TABLE IF EXISTS `airport`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `airport` (
  `Id` varchar(3) NOT NULL,
  `Name` varchar(100) NOT NULL,
  `City` varchar(50) NOT NULL,
  `Country` varchar(50) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `airport`
--

LOCK TABLES `airport` WRITE;
/*!40000 ALTER TABLE `airport` DISABLE KEYS */;
INSERT INTO `airport` VALUES ('BT','Berlin Tegel','Berlin','Germany'),('COI','Chicago O\'Hare International','Chicago','Illinois'),('HAI','Hartsfield-Jackson Atlanta Int','Atlanta','United States of America'),('II','Ivato International','Antananarivo','Madagascar'),('JFK','John F. Kennedy International','New York','United States of America'),('LAI','Los Angeles International','Los Angeles','United States of America'),('LGA','LaGuardia','New York','United States of America'),('LH','London Heathrow','London','United Kingdom'),('LI','Logan International','Boston','United States of America'),('SFI','San Francisco International','San Francisco','United States of America'),('TI','Tokyo International','Tokyo','Japan');
/*!40000 ALTER TABLE `airport` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auctions`
--

DROP TABLE IF EXISTS `auctions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auctions` (
  `AccountNo` int NOT NULL,
  `AirlineID` char(2) NOT NULL,
  `FlightNo` int NOT NULL,
  `Class` varchar(20) NOT NULL,
  `Date` datetime NOT NULL,
  `NYOP` decimal(10,2) NOT NULL,
  `Accepted` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`AccountNo`,`AirlineID`,`FlightNo`,`Class`,`Date`),
  KEY `AirlineID` (`AirlineID`,`FlightNo`),
  CONSTRAINT `auctions_ibfk_1` FOREIGN KEY (`AccountNo`) REFERENCES `customer` (`AccountNo`),
  CONSTRAINT `auctions_ibfk_2` FOREIGN KEY (`AirlineID`, `FlightNo`) REFERENCES `flight` (`AirlineID`, `FlightNo`),
  CONSTRAINT `auctions_chk_1` CHECK ((`NYOP` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auctions`
--

LOCK TABLES `auctions` WRITE;
/*!40000 ALTER TABLE `auctions` DISABLE KEYS */;
INSERT INTO `auctions` VALUES (1,'AA',111,'Economy','2010-04-30 07:27:39',300.00,1),(1,'AA',111,'Economy','2010-05-30 07:27:39',200.00,0),(1,'AA',111,'First Class','2010-05-30 07:27:39',500.00,0),(1,'DA',111,'Economy','2010-03-30 07:27:39',200.00,0);
/*!40000 ALTER TABLE `auctions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `Id` int NOT NULL,
  `AccountNo` int NOT NULL,
  `CreditCardNo` char(16) DEFAULT NULL,
  `Email` varchar(50) DEFAULT NULL,
  `CreationDate` datetime NOT NULL,
  `Rating` int DEFAULT NULL,
  PRIMARY KEY (`AccountNo`),
  KEY `Id` (`Id`),
  CONSTRAINT `customer_ibfk_1` FOREIGN KEY (`Id`) REFERENCES `person` (`Id`),
  CONSTRAINT `customer_chk_1` CHECK (((`Rating` >= 0) and (`Rating` <= 10)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1,1,'111','Henry.chu013198@gmail.com','2010-04-30 07:27:39',10),(2,2,'3218392','Dlam@gmail.com','2012-12-12 08:39:39',9),(5,5,'112','awesomejane@ftw.com','2010-04-30 07:27:39',10),(6,6,'113','jdoe@woot.com','2010-04-30 07:27:39',9),(7,7,'114','rickroller@rolld.com','2010-04-30 07:27:39',9);
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customerpreferences`
--

DROP TABLE IF EXISTS `customerpreferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customerpreferences` (
  `AccountNo` int NOT NULL,
  `Preference` varchar(50) NOT NULL,
  PRIMARY KEY (`AccountNo`,`Preference`),
  CONSTRAINT `customerpreferences_ibfk_1` FOREIGN KEY (`AccountNo`) REFERENCES `customer` (`AccountNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customerpreferences`
--

LOCK TABLES `customerpreferences` WRITE;
/*!40000 ALTER TABLE `customerpreferences` DISABLE KEYS */;
/*!40000 ALTER TABLE `customerpreferences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee` (
  `Id` int NOT NULL,
  `SSN` int NOT NULL,
  `isManager` tinyint(1) NOT NULL,
  `StartDate` date NOT NULL,
  `HourlyRate` decimal(10,2) NOT NULL,
  `Email` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`SSN`),
  UNIQUE KEY `Id` (`Id`),
  CONSTRAINT `employee_ibfk_1` FOREIGN KEY (`Id`) REFERENCES `person` (`Id`),
  CONSTRAINT `employee_chk_1` CHECK ((`SSN` > 0)),
  CONSTRAINT `employee_chk_2` CHECK ((`HourlyRate` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` VALUES (3,1234,0,'1998-02-02',12.50,'123@stonybrook.edu'),(4,48329,1,'1996-02-02',12.50,'123M@stonybrook.edu');
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fare`
--

DROP TABLE IF EXISTS `fare`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fare` (
  `AirlineID` char(2) NOT NULL,
  `FlightNo` int NOT NULL,
  `FareType` varchar(20) NOT NULL,
  `Class` varchar(20) NOT NULL,
  `Fare` decimal(10,2) NOT NULL,
  PRIMARY KEY (`AirlineID`,`FlightNo`,`FareType`,`Class`),
  CONSTRAINT `fare_ibfk_1` FOREIGN KEY (`AirlineID`, `FlightNo`) REFERENCES `flight` (`AirlineID`, `FlightNo`),
  CONSTRAINT `fare_chk_1` CHECK ((`Fare` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fare`
--

LOCK TABLES `fare` WRITE;
/*!40000 ALTER TABLE `fare` DISABLE KEYS */;
INSERT INTO `fare` VALUES ('AA',111,'oneway','Economy',400.00),('AA',111,'oneway','First',800.00),('AM',1337,'oneway','Economy',500.00),('AM',1337,'oneway','First',1000.00),('AM',7331,'oneway','Economy',600.00),('AM',7331,'oneway','First',1200.00),('AM',7332,'oneway','Economy',600.00),('AM',7332,'oneway','First',1200.00);
/*!40000 ALTER TABLE `fare` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flight`
--

DROP TABLE IF EXISTS `flight`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flight` (
  `AirlineID` char(2) NOT NULL,
  `FlightNo` int NOT NULL,
  `NoOfSeats` int NOT NULL,
  `DaysOperating` char(7) NOT NULL,
  `MinLengthOfStay` int NOT NULL,
  `MaxLengthOfStay` int NOT NULL,
  PRIMARY KEY (`AirlineID`,`FlightNo`),
  CONSTRAINT `flight_ibfk_1` FOREIGN KEY (`AirlineID`) REFERENCES `airline` (`Id`),
  CONSTRAINT `flight_chk_1` CHECK ((`NoOfSeats` > 0)),
  CONSTRAINT `flight_chk_2` CHECK ((`MinLengthOfStay` >= 0)),
  CONSTRAINT `flight_chk_3` CHECK ((`MaxLengthOfStay` > `MinLengthOfStay`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flight`
--

LOCK TABLES `flight` WRITE;
/*!40000 ALTER TABLE `flight` DISABLE KEYS */;
INSERT INTO `flight` VALUES ('AA',111,100,'1010100',1,2),('AM',1337,33,'0000011',1,2),('AM',7331,100,'1111111',1,2),('AM',7332,100,'1111111',1,2),('DA',111,100,'1010100',1,2),('JA',111,150,'1111111',1,2);
/*!40000 ALTER TABLE `flight` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `includes`
--

DROP TABLE IF EXISTS `includes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `includes` (
  `ResrNo` int NOT NULL,
  `AirlineID` char(2) NOT NULL,
  `FlightNo` int NOT NULL,
  `LegNo` int NOT NULL,
  `Date` date NOT NULL,
  PRIMARY KEY (`ResrNo`,`AirlineID`,`FlightNo`,`LegNo`),
  KEY `AirlineID` (`AirlineID`,`FlightNo`,`LegNo`),
  CONSTRAINT `includes_ibfk_1` FOREIGN KEY (`ResrNo`) REFERENCES `reservation` (`ResrNo`),
  CONSTRAINT `includes_ibfk_2` FOREIGN KEY (`AirlineID`, `FlightNo`, `LegNo`) REFERENCES `leg` (`AirlineID`, `FlightNo`, `LegNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `includes`
--

LOCK TABLES `includes` WRITE;
/*!40000 ALTER TABLE `includes` DISABLE KEYS */;
INSERT INTO `includes` VALUES (1,'AA',111,1,'2011-01-02'),(2,'JA',111,1,'2011-01-04'),(3,'AA',111,1,'2011-01-05'),(4,'JA',111,1,'2011-01-07'),(5,'DA',111,1,'2011-01-05'),(6,'DA',111,1,'2011-01-07'),(111,'AA',111,1,'2011-01-05'),(111,'AA',111,2,'2011-01-05'),(222,'JA',111,1,'2011-01-14'),(333,'AM',1337,1,'2011-01-13');
/*!40000 ALTER TABLE `includes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `leg`
--

DROP TABLE IF EXISTS `leg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `leg` (
  `AirlineID` char(2) NOT NULL,
  `FlightNo` int NOT NULL,
  `LegNo` int NOT NULL,
  `DepAirportID` char(3) NOT NULL,
  `ArrAirportID` char(3) NOT NULL,
  `ArrTime` datetime NOT NULL,
  `DepTime` datetime NOT NULL,
  `ActualArrTime` datetime NOT NULL,
  `ActualDepTime` datetime NOT NULL,
  PRIMARY KEY (`AirlineID`,`FlightNo`,`LegNo`),
  UNIQUE KEY `AirlineID` (`AirlineID`,`FlightNo`,`DepAirportID`),
  KEY `DepAirportID` (`DepAirportID`),
  KEY `ArrAirportID` (`ArrAirportID`),
  CONSTRAINT `leg_ibfk_1` FOREIGN KEY (`AirlineID`, `FlightNo`) REFERENCES `flight` (`AirlineID`, `FlightNo`),
  CONSTRAINT `leg_ibfk_2` FOREIGN KEY (`DepAirportID`) REFERENCES `airport` (`Id`),
  CONSTRAINT `leg_ibfk_3` FOREIGN KEY (`ArrAirportID`) REFERENCES `airport` (`Id`),
  CONSTRAINT `leg_chk_1` CHECK ((`LegNo` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `leg`
--

LOCK TABLES `leg` WRITE;
/*!40000 ALTER TABLE `leg` DISABLE KEYS */;
INSERT INTO `leg` VALUES ('AA',111,1,'LGA','LAI','2011-01-05 17:00:00','2011-01-05 11:00:00','2011-01-05 17:20:00','2011-01-05 10:00:40'),('AA',111,2,'LAI','TI','2011-01-06 07:30:00','2011-01-05 19:00:00','2011-01-06 07:30:00','2011-01-05 19:00:00'),('AM',1337,1,'JFK','II','2021-01-13 23:00:00','2021-01-13 07:00:00','2021-01-13 23:00:00','2021-01-13 07:00:00'),('AM',7331,1,'II','JFK','2021-01-15 23:00:00','2021-01-15 07:00:00','2021-01-14 23:00:00','2021-01-14 07:00:00'),('AM',7332,1,'JFK','LAI','2021-01-17 23:00:00','2021-01-17 07:00:00','2021-01-16 23:00:00','2021-01-16 07:00:00'),('DA',111,1,'LGA','LAI','2020-05-30 17:00:00','2020-05-30 11:00:00','2020-05-30 18:00:00','2020-05-30 12:00:00'),('DA',111,2,'LAI','TI','2020-06-01 07:30:00','2020-06-01 19:00:00','2020-06-01 08:30:00','2020-06-01 20:00:00'),('JA',111,1,'SFI','LI','2011-01-10 19:30:00','2011-01-10 14:00:00','2011-01-10 19:30:00','2011-01-10 13:00:20'),('JA',111,2,'LI','LH','2011-01-11 05:00:00','2011-01-10 22:30:00','2011-01-11 05:00:00','2011-01-10 22:30:00');
/*!40000 ALTER TABLE `leg` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `login`
--

DROP TABLE IF EXISTS `login`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `login` (
  `username` varchar(30) NOT NULL,
  `password` varchar(30) DEFAULT NULL,
  `role` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `login`
--

LOCK TABLES `login` WRITE;
/*!40000 ALTER TABLE `login` DISABLE KEYS */;
INSERT INTO `login` VALUES ('123@stonybrook.edu','123','customerRepresentative'),('123M@stonybrook.edu','123','manager'),('awesomejane@ftw.com','123','customer'),('Dlam@gmail.com','123','customer'),('Henry.chu013198@gmail.com','123','customer'),('jdoe@woot.com','123','customer'),('rickroller@rolld.com','123','customer');
/*!40000 ALTER TABLE `login` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `passenger`
--

DROP TABLE IF EXISTS `passenger`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `passenger` (
  `Id` int NOT NULL,
  `AccountNo` int NOT NULL,
  PRIMARY KEY (`Id`,`AccountNo`),
  KEY `AccountNo` (`AccountNo`),
  CONSTRAINT `passenger_ibfk_1` FOREIGN KEY (`Id`) REFERENCES `person` (`Id`),
  CONSTRAINT `passenger_ibfk_2` FOREIGN KEY (`AccountNo`) REFERENCES `customer` (`AccountNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `passenger`
--

LOCK TABLES `passenger` WRITE;
/*!40000 ALTER TABLE `passenger` DISABLE KEYS */;
INSERT INTO `passenger` VALUES (1,1),(2,2),(5,5),(6,6),(7,7);
/*!40000 ALTER TABLE `passenger` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `person`
--

DROP TABLE IF EXISTS `person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `person` (
  `Id` int NOT NULL,
  `FirstName` varchar(50) NOT NULL,
  `LastName` varchar(50) NOT NULL,
  `Address` varchar(100) NOT NULL,
  `City` varchar(50) NOT NULL,
  `State` varchar(50) NOT NULL,
  `ZipCode` int NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `person_chk_1` CHECK ((`Id` > 0)),
  CONSTRAINT `person_chk_2` CHECK ((`ZipCode` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person`
--

LOCK TABLES `person` WRITE;
/*!40000 ALTER TABLE `person` DISABLE KEYS */;
INSERT INTO `person` VALUES (1,'Henry','Chu','100th','Flushing','NY',11355),(2,'Derrick','Lam','5000th','Flushing','NY',11355),(3,'Employee','1','48','Bayside','NY',11355),(4,'Manager','1','48','Queens','NY',11356),(5,'Jane','Smith','100 Nicolls Rd','Stony Brook','NY',17790),(6,'John','Doe','123 N Fake Street','New York','NY',10001),(7,'Rick','Astley','1337 Internet Lane','Los Angeles','CA',90001);
/*!40000 ALTER TABLE `person` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservation`
--

DROP TABLE IF EXISTS `reservation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reservation` (
  `ResrNo` int NOT NULL,
  `ResrDate` datetime NOT NULL,
  `BookingFee` decimal(10,2) NOT NULL,
  `TotalFare` decimal(10,2) NOT NULL,
  `RepSSN` int DEFAULT NULL,
  `AccountNo` int NOT NULL,
  PRIMARY KEY (`ResrNo`),
  KEY `RepSSN` (`RepSSN`),
  KEY `AccountNo` (`AccountNo`),
  CONSTRAINT `reservation_ibfk_1` FOREIGN KEY (`RepSSN`) REFERENCES `employee` (`SSN`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `reservation_ibfk_2` FOREIGN KEY (`AccountNo`) REFERENCES `customer` (`AccountNo`),
  CONSTRAINT `reservation_chk_1` CHECK ((`ResrNo` > 0)),
  CONSTRAINT `reservation_chk_2` CHECK ((`BookingFee` >= 0)),
  CONSTRAINT `reservation_chk_3` CHECK ((`TotalFare` > `BookingFee`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservation`
--

LOCK TABLES `reservation` WRITE;
/*!40000 ALTER TABLE `reservation` DISABLE KEYS */;
INSERT INTO `reservation` VALUES (1,'2010-04-30 07:27:39',40.00,400.00,1234,1),(2,'2012-05-30 07:27:39',50.00,500.00,1234,2),(3,'2012-04-30 07:27:39',20.00,200.00,1234,1),(4,'2012-04-30 07:27:39',20.00,200.00,48329,1),(5,'2020-05-30 07:27:39',20.00,200.00,1234,1),(6,'2020-05-30 07:27:39',20.00,200.00,48329,1),(111,'2010-04-30 07:27:39',200.00,1200.00,1234,6),(222,'2010-05-30 07:27:39',200.00,500.00,1234,5),(333,'2010-06-30 07:27:39',200.00,3333.33,1234,7);
/*!40000 ALTER TABLE `reservation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservationpassenger`
--

DROP TABLE IF EXISTS `reservationpassenger`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reservationpassenger` (
  `ResrNo` int NOT NULL,
  `Id` int NOT NULL,
  `AccountNo` int NOT NULL,
  `SeatNo` char(5) NOT NULL,
  `Class` varchar(20) NOT NULL,
  `Meal` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ResrNo`,`Id`,`AccountNo`),
  KEY `Id` (`Id`,`AccountNo`),
  CONSTRAINT `reservationpassenger_ibfk_1` FOREIGN KEY (`ResrNo`) REFERENCES `reservation` (`ResrNo`),
  CONSTRAINT `reservationpassenger_ibfk_2` FOREIGN KEY (`Id`, `AccountNo`) REFERENCES `passenger` (`Id`, `AccountNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservationpassenger`
--

LOCK TABLES `reservationpassenger` WRITE;
/*!40000 ALTER TABLE `reservationpassenger` DISABLE KEYS */;
INSERT INTO `reservationpassenger` VALUES (1,1,1,'2A','First','Sushi'),(2,2,2,'3A','First','Steak'),(3,1,1,'4A','Business','Soda'),(4,1,1,'4B','Business','Sandwich'),(5,1,1,'4A','Business','Soda'),(6,1,1,'4B','Business','Sandwich'),(111,6,6,'33F','Economy','Chips'),(222,5,5,'13A','First','Fish and Chips'),(333,7,7,'1A','First','Sushi');
/*!40000 ALTER TABLE `reservationpassenger` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_config`
--

DROP TABLE IF EXISTS `sys_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_config` (
  `variable` varchar(128) NOT NULL,
  `value` varchar(128) DEFAULT NULL,
  `set_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `set_by` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`variable`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_config`
--

LOCK TABLES `sys_config` WRITE;
/*!40000 ALTER TABLE `sys_config` DISABLE KEYS */;
INSERT INTO `sys_config` VALUES ('diagnostics.allow_i_s_tables','OFF','2020-05-06 06:14:40',NULL),('diagnostics.include_raw','OFF','2020-05-06 06:14:40',NULL),('ps_thread_trx_info.max_length','65535','2020-05-06 06:14:40',NULL),('statement_performance_analyzer.limit','100','2020-05-06 06:14:40',NULL),('statement_performance_analyzer.view',NULL,'2020-05-06 06:14:40',NULL),('statement_truncate_len','64','2020-05-06 06:14:40',NULL);
/*!40000 ALTER TABLE `sys_config` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-05-10 17:14:13
