-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: farmaciabd
-- ------------------------------------------------------
-- Server version	5.5.5-10.4.32-MariaDB

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
-- Temporary view structure for view `categoria_producto_activa_v`
--

DROP TABLE IF EXISTS `categoria_producto_activa_v`;
/*!50001 DROP VIEW IF EXISTS `categoria_producto_activa_v`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `categoria_producto_activa_v` AS SELECT 
 1 AS `ID_CATEGORIA_PRODUCTO`,
 1 AS `NOMBRE`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente` (
  `ID_CLIENTE` bigint(20) NOT NULL AUTO_INCREMENT,
  `ID_USUARIO` bigint(20) NOT NULL,
  `CEDULA` varchar(20) DEFAULT NULL,
  `TELEFONO` varchar(20) DEFAULT NULL,
  `DIRECCION` varchar(255) DEFAULT NULL,
  `FECHA_NACIMIENTO` date DEFAULT NULL,
  `SEXO` varchar(10) DEFAULT NULL,
  `ALERGIAS` text DEFAULT NULL,
  PRIMARY KEY (`ID_CLIENTE`),
  KEY `FK_CLIENTE_USUARIO` (`ID_USUARIO`),
  CONSTRAINT `FK_CLIENTE_USUARIO` FOREIGN KEY (`ID_USUARIO`) REFERENCES `usuario` (`ID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` VALUES (1,3,'60446','8-88--8888-8','QUEPOS','0000-00-00','MASCULINO ','NINGUNA');
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `codigos_activos_v`
--

DROP TABLE IF EXISTS `codigos_activos_v`;
/*!50001 DROP VIEW IF EXISTS `codigos_activos_v`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `codigos_activos_v` AS SELECT 
 1 AS `CODIGO`,
 1 AS `NOMBRE`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `farmacia_activa_v`
--

DROP TABLE IF EXISTS `farmacia_activa_v`;
/*!50001 DROP VIEW IF EXISTS `farmacia_activa_v`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `farmacia_activa_v` AS SELECT 
 1 AS `ID_FARMACIA`,
 1 AS `NOMBRE`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `farmacias_v`
--

DROP TABLE IF EXISTS `farmacias_v`;
/*!50001 DROP VIEW IF EXISTS `farmacias_v`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `farmacias_v` AS SELECT 
 1 AS `ID_FARMACIA`,
 1 AS `NOMBRE`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `fide_alerta_tb`
--

DROP TABLE IF EXISTS `fide_alerta_tb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fide_alerta_tb` (
  `ID_ALERTA` int(11) NOT NULL AUTO_INCREMENT,
  `FECHA_ALERTA` date NOT NULL,
  `ID_TIPO_ALERTA` int(11) DEFAULT NULL,
  `ID_INVENTARIO` int(11) DEFAULT NULL,
  `ID_ESTADO` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID_ALERTA`),
  KEY `FK_ALERTA_TIPO` (`ID_TIPO_ALERTA`),
  KEY `FK_ALERTA_INVENTARIO` (`ID_INVENTARIO`),
  KEY `FK_ALERTA_ESTADO` (`ID_ESTADO`),
  CONSTRAINT `FK_ALERTA_ESTADO` FOREIGN KEY (`ID_ESTADO`) REFERENCES `fide_estado_tb` (`ID_ESTADO`),
  CONSTRAINT `FK_ALERTA_INVENTARIO` FOREIGN KEY (`ID_INVENTARIO`) REFERENCES `fide_inventario_tb` (`ID_INVENTARIO`),
  CONSTRAINT `FK_ALERTA_TIPO` FOREIGN KEY (`ID_TIPO_ALERTA`) REFERENCES `tipo_alerta` (`ID_TIPO_ALERTA`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fide_alerta_tb`
--

LOCK TABLES `fide_alerta_tb` WRITE;
/*!40000 ALTER TABLE `fide_alerta_tb` DISABLE KEYS */;
/*!40000 ALTER TABLE `fide_alerta_tb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fide_categoria_producto_tb`
--

DROP TABLE IF EXISTS `fide_categoria_producto_tb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fide_categoria_producto_tb` (
  `ID_CATEGORIA_PRODUCTO` int(11) NOT NULL AUTO_INCREMENT,
  `NOMBRE` varchar(100) NOT NULL,
  `ID_ESTADO` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID_CATEGORIA_PRODUCTO`),
  KEY `FK_CATEGORIA_ESTADO` (`ID_ESTADO`),
  CONSTRAINT `FK_CATEGORIA_ESTADO` FOREIGN KEY (`ID_ESTADO`) REFERENCES `fide_estado_tb` (`ID_ESTADO`)
) ENGINE=InnoDB AUTO_INCREMENT=190 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fide_categoria_producto_tb`
--

LOCK TABLES `fide_categoria_producto_tb` WRITE;
/*!40000 ALTER TABLE `fide_categoria_producto_tb` DISABLE KEYS */;
INSERT INTO `fide_categoria_producto_tb` VALUES (1,'Analgésico',1),(2,'Antibiótico',1),(3,'Antiinflamatorio',1),(4,'Antialérgico',1),(5,'Antipirético',1),(6,'Antihipertensivo',1),(7,'Antidiabético',1),(8,'Anticonvulsivo',1),(9,'Antipsicótico',1),(10,'Ansiolítico',1),(11,'Antidepresivo',1),(12,'Gastrointestinal',1),(13,'Vitaminas y suplementos',1),(14,'Antimicótico',1),(15,'Antiviral',1),(16,'Hormonas',1),(17,'Cardiovascular',1),(18,'Anticoagulante',1),(19,'Antiparasitario',1),(20,'Cuidado dermatológico',1),(21,'Inmunológico',1),(22,'Pediátrico',1),(23,'Ginecológico',1),(24,'Respiratorio',1),(25,'Oftálmico',1),(26,'Odontológico',1),(27,'Otros',1),(28,'Analgésico',1),(29,'Antibiótico',1),(30,'Antiinflamatorio',1),(31,'Antialérgico',1),(32,'Antipirético',1),(33,'Antihipertensivo',1),(34,'Antidiabético',1),(35,'Anticonvulsivo',1),(36,'Antipsicótico',1),(37,'Ansiolítico',1),(38,'Antidepresivo',1),(39,'Gastrointestinal',1),(40,'Vitaminas y suplementos',1),(41,'Antimicótico',1),(42,'Antiviral',1),(43,'Hormonas',1),(44,'Cardiovascular',1),(45,'Anticoagulante',1),(46,'Antiparasitario',1),(47,'Cuidado dermatológico',1),(48,'Inmunológico',1),(49,'Pediátrico',1),(50,'Ginecológico',1),(51,'Respiratorio',1),(52,'Oftálmico',1),(53,'Odontológico',1),(54,'Otros',1),(55,'Analgésico',1),(56,'Antibiótico',1),(57,'Antiinflamatorio',1),(58,'Antialérgico',1),(59,'Antipirético',1),(60,'Antihipertensivo',1),(61,'Antidiabético',1),(62,'Anticonvulsivo',1),(63,'Antipsicótico',1),(64,'Ansiolítico',1),(65,'Antidepresivo',1),(66,'Gastrointestinal',1),(67,'Vitaminas y suplementos',1),(68,'Antimicótico',1),(69,'Antiviral',1),(70,'Hormonas',1),(71,'Cardiovascular',1),(72,'Anticoagulante',1),(73,'Antiparasitario',1),(74,'Cuidado dermatológico',1),(75,'Inmunológico',1),(76,'Pediátrico',1),(77,'Ginecológico',1),(78,'Respiratorio',1),(79,'Oftálmico',1),(80,'Odontológico',1),(81,'Otros',1),(82,'Analgésico',1),(83,'Antibiótico',1),(84,'Antiinflamatorio',1),(85,'Antialérgico',1),(86,'Antipirético',1),(87,'Antihipertensivo',1),(88,'Antidiabético',1),(89,'Anticonvulsivo',1),(90,'Antipsicótico',1),(91,'Ansiolítico',1),(92,'Antidepresivo',1),(93,'Gastrointestinal',1),(94,'Vitaminas y suplementos',1),(95,'Antimicótico',1),(96,'Antiviral',1),(97,'Hormonas',1),(98,'Cardiovascular',1),(99,'Anticoagulante',1),(100,'Antiparasitario',1),(101,'Cuidado dermatológico',1),(102,'Inmunológico',1),(103,'Pediátrico',1),(104,'Ginecológico',1),(105,'Respiratorio',1),(106,'Oftálmico',1),(107,'Odontológico',1),(108,'Otros',1),(109,'Analgésico',1),(110,'Antibiótico',1),(111,'Antiinflamatorio',1),(112,'Antialérgico',1),(113,'Antipirético',1),(114,'Antihipertensivo',1),(115,'Antidiabético',1),(116,'Anticonvulsivo',1),(117,'Antipsicótico',1),(118,'Ansiolítico',1),(119,'Antidepresivo',1),(120,'Gastrointestinal',1),(121,'Vitaminas y suplementos',1),(122,'Antimicótico',1),(123,'Antiviral',1),(124,'Hormonas',1),(125,'Cardiovascular',1),(126,'Anticoagulante',1),(127,'Antiparasitario',1),(128,'Cuidado dermatológico',1),(129,'Inmunológico',1),(130,'Pediátrico',1),(131,'Ginecológico',1),(132,'Respiratorio',1),(133,'Oftálmico',1),(134,'Odontológico',1),(135,'Otros',1),(136,'Analgésico',1),(137,'Antibiótico',1),(138,'Antiinflamatorio',1),(139,'Antialérgico',1),(140,'Antipirético',1),(141,'Antihipertensivo',1),(142,'Antidiabético',1),(143,'Anticonvulsivo',1),(144,'Antipsicótico',1),(145,'Ansiolítico',1),(146,'Antidepresivo',1),(147,'Gastrointestinal',1),(148,'Vitaminas y suplementos',1),(149,'Antimicótico',1),(150,'Antiviral',1),(151,'Hormonas',1),(152,'Cardiovascular',1),(153,'Anticoagulante',1),(154,'Antiparasitario',1),(155,'Cuidado dermatológico',1),(156,'Inmunológico',1),(157,'Pediátrico',1),(158,'Ginecológico',1),(159,'Respiratorio',1),(160,'Oftálmico',1),(161,'Odontológico',1),(162,'Otros',1),(163,'Analgésico',1),(164,'Antibiótico',1),(165,'Antiinflamatorio',1),(166,'Antialérgico',1),(167,'Antipirético',1),(168,'Antihipertensivo',1),(169,'Antidiabético',1),(170,'Anticonvulsivo',1),(171,'Antipsicótico',1),(172,'Ansiolítico',1),(173,'Antidepresivo',1),(174,'Gastrointestinal',1),(175,'Vitaminas y suplementos',1),(176,'Antimicótico',1),(177,'Antiviral',1),(178,'Hormonas',1),(179,'Cardiovascular',1),(180,'Anticoagulante',1),(181,'Antiparasitario',1),(182,'Cuidado dermatológico',1),(183,'Inmunológico',1),(184,'Pediátrico',1),(185,'Ginecológico',1),(186,'Respiratorio',1),(187,'Oftálmico',1),(188,'Odontológico',1),(189,'Otros',1);
/*!40000 ALTER TABLE `fide_categoria_producto_tb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fide_detalle_solicitud_tb`
--

DROP TABLE IF EXISTS `fide_detalle_solicitud_tb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fide_detalle_solicitud_tb` (
  `ID_DETALLE_SOLICITUD` int(11) NOT NULL AUTO_INCREMENT,
  `ID_SOLICITUD` int(11) NOT NULL,
  `ID_INVENTARIO` int(11) NOT NULL,
  `ID_USUARIO` bigint(20) NOT NULL,
  `CANTIDAD_SOLICITADA` int(11) NOT NULL,
  `CANTIDAD_ENTREGADA` int(11) DEFAULT 0,
  `ID_ESTADO` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID_DETALLE_SOLICITUD`),
  KEY `FK_DETALLE_SOLICITUD_SOLICITUD` (`ID_SOLICITUD`),
  KEY `FK_DETALLE_SOLICITUD_INVENTARIO` (`ID_INVENTARIO`),
  KEY `FK_DETALLE_SOLICITUD_USUARIO` (`ID_USUARIO`),
  KEY `FK_DETALLE_SOLICITUD_ESTADO` (`ID_ESTADO`),
  CONSTRAINT `FK_DETALLE_SOLICITUD_ESTADO` FOREIGN KEY (`ID_ESTADO`) REFERENCES `fide_estado_tb` (`ID_ESTADO`),
  CONSTRAINT `FK_DETALLE_SOLICITUD_INVENTARIO` FOREIGN KEY (`ID_INVENTARIO`) REFERENCES `fide_inventario_tb` (`ID_INVENTARIO`),
  CONSTRAINT `FK_DETALLE_SOLICITUD_SOLICITUD` FOREIGN KEY (`ID_SOLICITUD`) REFERENCES `fide_solicitud_tb` (`ID_SOLICITUD`),
  CONSTRAINT `FK_DETALLE_SOLICITUD_USUARIO` FOREIGN KEY (`ID_USUARIO`) REFERENCES `usuario` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fide_detalle_solicitud_tb`
--

LOCK TABLES `fide_detalle_solicitud_tb` WRITE;
/*!40000 ALTER TABLE `fide_detalle_solicitud_tb` DISABLE KEYS */;
/*!40000 ALTER TABLE `fide_detalle_solicitud_tb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fide_estado_tb`
--

DROP TABLE IF EXISTS `fide_estado_tb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fide_estado_tb` (
  `ID_ESTADO` int(11) NOT NULL AUTO_INCREMENT,
  `DESCRIPCION` varchar(100) NOT NULL,
  PRIMARY KEY (`ID_ESTADO`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fide_estado_tb`
--

LOCK TABLES `fide_estado_tb` WRITE;
/*!40000 ALTER TABLE `fide_estado_tb` DISABLE KEYS */;
INSERT INTO `fide_estado_tb` VALUES (1,'Activo'),(2,'Inactivo'),(3,'Eliminado'),(4,'Pendiente'),(5,'Vencido'),(6,'En revisión'),(7,'Completado'),(8,'Cancelado'),(9,'Activo'),(10,'Inactivo'),(11,'Eliminado'),(12,'Pendiente'),(13,'Vencido'),(14,'En revisión'),(15,'Completado'),(16,'Cancelado'),(17,'Activo'),(18,'Inactivo'),(19,'Eliminado'),(20,'Pendiente'),(21,'Vencido'),(22,'En revisión'),(23,'Completado'),(24,'Cancelado'),(25,'Activo'),(26,'Inactivo'),(27,'Eliminado'),(28,'Pendiente'),(29,'Vencido'),(30,'En revisión'),(31,'Completado'),(32,'Cancelado'),(33,'Activo'),(34,'Inactivo'),(35,'Eliminado'),(36,'Pendiente'),(37,'Vencido'),(38,'En revisión'),(39,'Completado'),(40,'Cancelado'),(41,'Activo'),(42,'Inactivo'),(43,'Eliminado'),(44,'Pendiente'),(45,'Vencido'),(46,'En revisión'),(47,'Completado'),(48,'Cancelado'),(49,'Activo'),(50,'Inactivo'),(51,'Eliminado'),(52,'Pendiente'),(53,'Vencido'),(54,'En revisión'),(55,'Completado'),(56,'Cancelado');
/*!40000 ALTER TABLE `fide_estado_tb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fide_factura_tb`
--

DROP TABLE IF EXISTS `fide_factura_tb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fide_factura_tb` (
  `ID_FACTURA` int(11) NOT NULL AUTO_INCREMENT,
  `FECHA` date NOT NULL,
  `TOTAL` decimal(10,2) NOT NULL,
  `IMPUESTO` decimal(10,2) NOT NULL,
  `ID_TIPO_PAGO` int(11) DEFAULT NULL,
  `ID_ESTADO` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID_FACTURA`),
  KEY `FK_FACTURA_TIPO_PAGO` (`ID_TIPO_PAGO`),
  KEY `FK_FACTURA_ESTADO` (`ID_ESTADO`),
  CONSTRAINT `FK_FACTURA_ESTADO` FOREIGN KEY (`ID_ESTADO`) REFERENCES `fide_estado_tb` (`ID_ESTADO`),
  CONSTRAINT `FK_FACTURA_TIPO_PAGO` FOREIGN KEY (`ID_TIPO_PAGO`) REFERENCES `fide_tipo_pago_tb` (`ID_TIPO_PAGO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fide_factura_tb`
--

LOCK TABLES `fide_factura_tb` WRITE;
/*!40000 ALTER TABLE `fide_factura_tb` DISABLE KEYS */;
/*!40000 ALTER TABLE `fide_factura_tb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fide_farmacia_tb`
--

DROP TABLE IF EXISTS `fide_farmacia_tb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fide_farmacia_tb` (
  `ID_FARMACIA` int(11) NOT NULL AUTO_INCREMENT,
  `NOMBRE` varchar(100) NOT NULL,
  `ID_ESTADO` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID_FARMACIA`),
  KEY `FK_FARMACIA_ESTADO` (`ID_ESTADO`),
  CONSTRAINT `FK_FARMACIA_ESTADO` FOREIGN KEY (`ID_ESTADO`) REFERENCES `fide_estado_tb` (`ID_ESTADO`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fide_farmacia_tb`
--

LOCK TABLES `fide_farmacia_tb` WRITE;
/*!40000 ALTER TABLE `fide_farmacia_tb` DISABLE KEYS */;
INSERT INTO `fide_farmacia_tb` VALUES (1,'Farmacia Central San José',1),(2,'Farmacia Heredia Norte',1),(3,'Farmacia Cartago Este',1),(4,'Farmacia Alajuela Centro',2),(5,'Farmacia Liberia Oeste',1),(6,'Farmacia Pérez Zeledón',1),(7,'Farmacia San Ramón',2),(8,'Farmacia Central San José',1),(9,'Farmacia Heredia Norte',1),(10,'Farmacia Cartago Este',1),(11,'Farmacia Alajuela Centro',2),(12,'Farmacia Liberia Oeste',1),(13,'Farmacia Pérez Zeledón',1),(14,'Farmacia San Ramón',2),(15,'Farmacia Central San José',1),(16,'Farmacia Heredia Norte',1),(17,'Farmacia Cartago Este',1),(18,'Farmacia Alajuela Centro',2),(19,'Farmacia Liberia Oeste',1),(20,'Farmacia Pérez Zeledón',1),(21,'Farmacia San Ramón',2),(22,'Farmacia Central San José',1),(23,'Farmacia Heredia Norte',1),(24,'Farmacia Cartago Este',1),(25,'Farmacia Alajuela Centro',2),(26,'Farmacia Liberia Oeste',1),(27,'Farmacia Pérez Zeledón',1),(28,'Farmacia San Ramón',2),(29,'Farmacia Central San José',1),(30,'Farmacia Heredia Norte',1),(31,'Farmacia Cartago Este',1),(32,'Farmacia Alajuela Centro',2),(33,'Farmacia Liberia Oeste',1),(34,'Farmacia Pérez Zeledón',1),(35,'Farmacia San Ramón',2),(36,'Farmacia Central San José',1),(37,'Farmacia Heredia Norte',1),(38,'Farmacia Cartago Este',1),(39,'Farmacia Alajuela Centro',2),(40,'Farmacia Liberia Oeste',1),(41,'Farmacia Pérez Zeledón',1),(42,'Farmacia San Ramón',2);
/*!40000 ALTER TABLE `fide_farmacia_tb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fide_inventario_tb`
--

DROP TABLE IF EXISTS `fide_inventario_tb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fide_inventario_tb` (
  `ID_INVENTARIO` int(11) NOT NULL AUTO_INCREMENT,
  `CODIGO` varchar(20) DEFAULT NULL,
  `CANTIDAD_DISPONIBLE` int(11) NOT NULL,
  `STOCK_MINIMO` int(11) DEFAULT NULL,
  `STOCK_MAXIMO` int(11) DEFAULT NULL,
  `ID_FARMACIA` int(11) DEFAULT NULL,
  `ID_ESTADO` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID_INVENTARIO`),
  KEY `FK_INVENTARIO_PRODUCTO` (`CODIGO`),
  KEY `FK_INVENTARIO_FARMACIA` (`ID_FARMACIA`),
  KEY `FK_INVENTARIO_ESTADO` (`ID_ESTADO`),
  CONSTRAINT `FK_INVENTARIO_ESTADO` FOREIGN KEY (`ID_ESTADO`) REFERENCES `fide_estado_tb` (`ID_ESTADO`),
  CONSTRAINT `FK_INVENTARIO_FARMACIA` FOREIGN KEY (`ID_FARMACIA`) REFERENCES `fide_farmacia_tb` (`ID_FARMACIA`),
  CONSTRAINT `FK_INVENTARIO_PRODUCTO` FOREIGN KEY (`CODIGO`) REFERENCES `fide_producto_tb` (`CODIGO`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fide_inventario_tb`
--

LOCK TABLES `fide_inventario_tb` WRITE;
/*!40000 ALTER TABLE `fide_inventario_tb` DISABLE KEYS */;
INSERT INTO `fide_inventario_tb` VALUES (1,'110010204',0,0,0,10,1),(2,'110010204',0,0,0,5,1),(3,'110010204',13,0,0,1,1),(4,'110010205',6,0,0,1,1),(5,'110010205',0,0,0,3,1),(6,'110010206',2,0,0,1,1);
/*!40000 ALTER TABLE `fide_inventario_tb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fide_lote_tb`
--

DROP TABLE IF EXISTS `fide_lote_tb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fide_lote_tb` (
  `ID_LOTE` int(11) NOT NULL AUTO_INCREMENT,
  `CODIGO` varchar(20) DEFAULT NULL,
  `NUMERO_LOTE` varchar(100) DEFAULT NULL,
  `FECHA_ELABORADO` date DEFAULT NULL,
  `FECHA_VENCIMIENTO` date DEFAULT NULL,
  `ID_ESTADO` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID_LOTE`),
  KEY `FK_LOTE_PRODUCTO` (`CODIGO`),
  KEY `FK_LOTE_ESTADO` (`ID_ESTADO`),
  CONSTRAINT `FK_LOTE_ESTADO` FOREIGN KEY (`ID_ESTADO`) REFERENCES `fide_estado_tb` (`ID_ESTADO`),
  CONSTRAINT `FK_LOTE_PRODUCTO` FOREIGN KEY (`CODIGO`) REFERENCES `fide_producto_tb` (`CODIGO`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fide_lote_tb`
--

LOCK TABLES `fide_lote_tb` WRITE;
/*!40000 ALTER TABLE `fide_lote_tb` DISABLE KEYS */;
INSERT INTO `fide_lote_tb` VALUES (1,'110010204','9999','2025-07-11','2025-07-12',1),(2,'110010205','9999','2025-07-17','2025-07-11',1),(3,'110010204','9999','2025-07-01','2025-07-01',1),(4,'110010204','88888','2025-07-13','2025-07-27',1),(5,'110010204','88888','2025-07-13','2025-08-03',1),(6,'110010204','9999','2025-07-13','2025-08-10',1),(7,'110010204','8888888','2025-07-13','2025-08-03',1),(8,'110010204','9999','2025-07-20','2025-07-26',1),(9,'110010204','8888888','2025-07-19','2025-07-20',1),(10,'110010204','8888888','2025-07-13','2025-07-27',1),(11,'110010204','888','2025-07-13','2025-08-02',1),(12,'110010204','777','2025-07-14','2025-08-08',1),(13,'110010204','8888888','2025-07-13','2025-07-13',1),(14,'110010204','888','2025-07-14','2025-07-26',1),(15,'110010204','8888888','2025-07-14','2025-07-26',1),(16,'110010204','9999','2025-07-13','2025-07-27',1),(17,'110010204','8888888','2025-07-13','2025-08-09',1),(18,'110010204','9999','2025-07-13','2025-08-02',1),(19,'110010204','9999','2025-07-13','2025-08-22',1),(20,'110010204','8888888','2025-07-13','2025-08-07',1),(21,'110010204','888','2025-07-14','2025-08-08',1),(22,'110010204','9999','2025-07-13','2025-08-08',1),(23,'110010204','88888','2025-07-13','2025-08-07',1),(24,'110010204','888','2025-07-14','2025-08-09',1),(25,'110010204','888','2025-07-13','2025-08-23',1),(26,'110010204','88888','2025-07-13','2025-08-16',1),(27,'110010204','88888','2025-07-13','2025-08-29',1),(28,'110010204','9999','2025-07-13','2025-08-09',1),(29,'110010204','8888','2025-07-13','2025-08-24',1),(30,'110010204','9999','2025-07-13','2025-08-06',1),(31,'110010204','9999','2025-07-13','2025-07-25',1),(32,'110010204','8888888','2025-07-13','2025-08-01',1),(33,'110010204','9999','2025-07-13','2025-08-07',1),(34,'110010204','9999','2025-07-13','2025-08-29',1),(35,'110010204','8888888','2025-07-13','2025-07-25',1),(36,'110010204','88888','2025-07-13','2025-07-25',1),(37,'110010204','88888','2025-07-13','2025-08-02',1),(38,'110010204','777','2025-07-27','2025-08-10',1),(39,'110010204','888','2025-07-27','2025-07-27',1),(40,'110010204','10','2025-07-27','2025-07-27',1),(41,'110010204','7777','2025-08-02','2025-08-16',1),(42,'110010204','1','2025-08-02','2025-09-06',1),(43,'110010204','22','2025-08-02','2025-08-03',1),(44,'110010204','7777','2025-08-02','2025-08-30',1),(45,'110010205','7777','2025-08-02','2025-08-02',1),(46,'110010205','9999','2025-08-02','2025-08-30',1),(47,'110010206','7777','2025-08-03','2025-08-23',1);
/*!40000 ALTER TABLE `fide_lote_tb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fide_movimiento_tb`
--

DROP TABLE IF EXISTS `fide_movimiento_tb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fide_movimiento_tb` (
  `ID_MOVIMIENTO` int(11) NOT NULL AUTO_INCREMENT,
  `ID_INVENTARIO` int(11) NOT NULL,
  `ID_LOTE` int(11) NOT NULL,
  `FECHA_MOVIMIENTO` date NOT NULL,
  `FECHA_VENCIMIENTO` date NOT NULL,
  `TIPO_MOVIMIENTO` varchar(10) DEFAULT NULL CHECK (`TIPO_MOVIMIENTO` in ('Entrada','Salida')),
  `CANTIDAD` int(11) NOT NULL,
  `DESCRIPCION` varchar(255) DEFAULT NULL,
  `EMPRESA` varchar(100) DEFAULT NULL,
  `ID_FARMACIA` int(11) NOT NULL,
  PRIMARY KEY (`ID_MOVIMIENTO`),
  KEY `FK_MOVIMIENTO_INVENTARIO` (`ID_INVENTARIO`),
  KEY `FK_MOVIMIENTO_LOTE` (`ID_LOTE`),
  KEY `FK_MOVIMIENTO_FARMACIA` (`ID_FARMACIA`),
  CONSTRAINT `FK_MOVIMIENTO_FARMACIA` FOREIGN KEY (`ID_FARMACIA`) REFERENCES `fide_farmacia_tb` (`ID_FARMACIA`),
  CONSTRAINT `FK_MOVIMIENTO_INVENTARIO` FOREIGN KEY (`ID_INVENTARIO`) REFERENCES `fide_inventario_tb` (`ID_INVENTARIO`),
  CONSTRAINT `FK_MOVIMIENTO_LOTE` FOREIGN KEY (`ID_LOTE`) REFERENCES `fide_lote_tb` (`ID_LOTE`)
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fide_movimiento_tb`
--

LOCK TABLES `fide_movimiento_tb` WRITE;
/*!40000 ALTER TABLE `fide_movimiento_tb` DISABLE KEYS */;
INSERT INTO `fide_movimiento_tb` VALUES (47,3,41,'2025-08-02','2025-08-31','Entrada',3,'','',1),(48,3,41,'2025-08-02','2025-09-24','Entrada',3,'','',1),(49,3,41,'2025-08-02','2025-08-30','Entrada',3,'','',1),(50,3,42,'2025-08-02','2025-09-06','Entrada',2,'','',1),(51,3,43,'2025-08-02','2025-08-03','Entrada',1,'','',1),(52,3,43,'2025-08-02','2025-08-03','Salida',1,'','',1),(53,3,41,'2025-08-02','2025-08-16','Salida',2,'','',1),(54,3,44,'2025-08-02','2025-08-30','Entrada',2,'','',1),(55,3,44,'2025-08-02','2025-08-30','Entrada',2,'','',1),(56,4,45,'2025-08-02','2025-08-02','Entrada',3,'','',1),(57,4,46,'2025-08-02','2025-08-30','Entrada',3,'','',1),(58,6,47,'2025-08-03','2025-08-23','Entrada',2,'','',1);
/*!40000 ALTER TABLE `fide_movimiento_tb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fide_producto_tb`
--

DROP TABLE IF EXISTS `fide_producto_tb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fide_producto_tb` (
  `CODIGO` varchar(20) NOT NULL,
  `NOMBRE` varchar(100) NOT NULL,
  `PRECIO_UNITARIO` decimal(10,2) DEFAULT NULL,
  `ID_CATEGORIA_PRODUCTO` int(11) DEFAULT NULL,
  `ID_UNIDAD_MEDIDA` int(11) DEFAULT NULL,
  `ID_ESTADO` int(11) DEFAULT NULL,
  `URL_IMAGEN` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`CODIGO`),
  KEY `FK_PRODUCTO_CATEGORIA` (`ID_CATEGORIA_PRODUCTO`),
  KEY `FK_PRODUCTO_UNIDAD` (`ID_UNIDAD_MEDIDA`),
  KEY `FK_PRODUCTO_ESTADO` (`ID_ESTADO`),
  CONSTRAINT `FK_PRODUCTO_CATEGORIA` FOREIGN KEY (`ID_CATEGORIA_PRODUCTO`) REFERENCES `fide_categoria_producto_tb` (`ID_CATEGORIA_PRODUCTO`),
  CONSTRAINT `FK_PRODUCTO_ESTADO` FOREIGN KEY (`ID_ESTADO`) REFERENCES `fide_estado_tb` (`ID_ESTADO`),
  CONSTRAINT `FK_PRODUCTO_UNIDAD` FOREIGN KEY (`ID_UNIDAD_MEDIDA`) REFERENCES `fide_unidad_medida_tb` (`ID_UNIDAD_MEDIDA`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fide_producto_tb`
--

LOCK TABLES `fide_producto_tb` WRITE;
/*!40000 ALTER TABLE `fide_producto_tb` DISABLE KEYS */;
INSERT INTO `fide_producto_tb` VALUES ('110010204','ATORVASTATINA 20 MG TABLETA',135.75,1,2,1,NULL),('110010205','ENALAPRIL 10 MG TABLETA',52.30,1,2,1,NULL),('110010206','FUROSEMIDA 40 MG TABLETA',25.00,1,2,1,NULL),('110010207','PREDNISONA 5 MG TABLETA',33.00,10,2,1,NULL),('110010208','CLORFENAMINA 4 MG TABLETA',19.50,6,2,1,NULL),('110010209','DICLOFENACO 50 MG TABLETA',27.75,4,2,1,NULL),('110010210','NAPROXENO 500 MG TABLETA',41.20,4,2,1,NULL),('110010211','RANITIDINA 150 MG TABLETA',60.00,5,2,1,NULL),('110010212','CIPROFLOXACINO 500 MG TABLETA',88.50,2,2,1,NULL),('110010213','CEFALEXINA 500 MG CÁPSULA',92.30,2,3,1,NULL),('110010214','ACICLOVIR 400 MG TABLETA',79.00,2,2,1,NULL),('110010215','AZITROMICINA 500 MG TABLETA',160.00,2,2,1,NULL),('110010216','CLARITROMICINA 500 MG TABLETA',175.00,2,2,1,NULL),('110010217','DOXICICLINA 100 MG TABLETA',67.25,2,2,1,NULL),('110010218','LEVOTIROXINA 50 MCG TABLETA',32.00,10,2,1,NULL),('110010219','GLIBENCLAMIDA 5 MG TABLETA',29.00,10,2,1,NULL),('110010220','INSULINA NPH 100 UI/ML FRASCO',4350.00,10,4,1,NULL),('110010221','INSULINA REGULAR 100 UI/ML FRASCO',4200.00,10,4,1,NULL),('110010222','ASPIRINA 100 MG TABLETA',23.00,3,2,1,NULL),('110010223','WARFARINA 5 MG TABLETA',95.00,1,2,1,NULL),('110010224','HEPARINA SÓDICA 5000 UI/ML',2250.00,1,3,1,NULL),('110010225','METRONIDAZOL 250 MG TABLETA',55.00,2,2,1,NULL),('110010226','NISTATINA 100000 UI TABLETA',61.00,2,2,1,NULL),('110010227','FLUCONAZOL 150 MG CÁPSULA',135.00,2,3,1,NULL),('110010228','KETOCONAZOL 200 MG TABLETA',115.00,2,2,1,NULL),('110010261','CLONAZEPAM 0.5 MG TABLETA',65.00,9,2,1,NULL),('110010262','DIAZEPAM 10 MG TABLETA',70.00,9,2,1,NULL),('110010263','BISACODILO 5 MG TABLETA',30.00,5,2,1,NULL),('110010264','LOPERAMIDA 2 MG CÁPSULA',40.00,5,3,1,NULL),('110010265','DOMPERIDONA 10 MG TABLETA',48.00,5,2,1,NULL),('110010266','ONDANSETRON 4 MG TABLETA',120.00,5,2,1,NULL),('110010267','RIVAROXABAN 20 MG TABLETA',320.00,1,2,1,NULL),('110010268','APIXABAN 5 MG TABLETA',290.00,1,2,1,NULL),('110010269','ENOXAPARINA 40 MG/0.4ML JERINGA',3850.00,1,4,1,NULL),('110010270','FENILEFRINA 10 MG TABLETA',35.00,6,2,1,NULL),('110010271','PSEUDOEFEDRINA 30 MG TABLETA',44.00,6,2,1,NULL),('110010272','OXIMETAZOLINA 0.05% GOTAS NASALES',120.00,6,5,1,NULL),('110010273','DEXTROMETORFANO 15 MG/5ML JARABE',112.00,8,11,1,NULL),('110010274','BROMEXINA 8 MG/5ML JARABE',105.00,8,11,1,NULL),('110010275','AMBROXOL 30 MG/5ML JARABE',99.00,8,11,1,NULL),('110010276','CLORURO DE SODIO 0.9% FRASCO',475.00,10,4,1,NULL),('110010277','GLUCOSA 5% FRASCO',510.00,10,4,1,NULL),('110010278','RINGER LACTATO FRASCO',490.00,10,4,1,NULL),('110010279','KETOROLACO 30 MG/ML AMPOLLAS',185.00,3,6,1,NULL),('110010280','TRAMADOL 100 MG/ML AMPOLLAS',220.00,3,6,1,NULL),('110010281','MORFINA 10 MG/ML AMPOLLAS',285.00,3,6,1,NULL),('110010282','FENTANILO 50 MCG/ML AMPOLLAS',300.00,3,6,1,NULL),('110010283','NEOMICINA + BACITRACINA UNGÜENTO',290.00,7,30,1,NULL),('110010284','HIDROCORTISONA 1% CREMA',210.00,7,8,1,NULL),('110010285','BETAMETASONA 0.1% CREMA',250.00,7,8,1,NULL),('110010286','CLOTRIMAZOL 1% CREMA',240.00,7,8,1,NULL),('110010287','MICONAZOL 2% CREMA',230.00,7,8,1,NULL),('110010288','NISTATINA 100,000 UI CREMA',225.00,7,8,1,NULL),('110010289','KETOCONAZOL 2% CHAMPÚ',650.00,7,29,1,NULL),('110010290','TRETINOÍNA 0.05% CREMA',800.00,7,8,1,NULL),('110010291','BENZOIL PERÓXIDO 5% GEL',475.00,7,9,1,NULL),('110010292','ACICLOVIR 5% CREMA',340.00,7,8,1,NULL),('110010293','NAPROXENO SÓDICO 550 MG TABLETA',90.00,4,2,1,NULL),('110010306','IBUPROFENO 400 MG TABLETA',85.00,3,2,1,NULL),('110010307','AMOXICILINA 500 MG CÁPSULA',110.00,2,3,1,NULL),('110010308','CLARITROMICINA 250 MG TABLETA',185.00,2,2,1,NULL),('110010309','ENALAPRIL 5 MG TABLETA',46.00,4,2,1,NULL),('110010310','LOSARTÁN 50 MG TABLETA',58.00,4,2,1,NULL),('110010311','METFORMINA 850 MG TABLETA',60.00,5,2,1,NULL),('110010312','GLICLAZIDA 30 MG TABLETA',72.00,5,2,1,NULL),('110010313','LORATADINA 10 MG TABLETA',42.00,6,2,1,NULL),('110010314','CETIRIZINA 10 MG TABLETA',49.00,6,2,1,NULL),('110010315','OMEPRAZOL 20 MG CÁPSULA',98.00,7,3,1,NULL),('110010316','FAMOTIDINA 40 MG TABLETA',88.00,7,2,1,NULL),('110010317','SALBUTAMOL SPRAY 100 MCG',2750.00,8,13,1,NULL),('110010318','BUDESONIDA 100 MCG INHALADOR',3600.00,8,17,1,NULL),('110010319','BETAMETASONA CREMA 0.05%',270.00,9,8,1,NULL),('110010320','KETOCONAZOL CREMA 2%',310.00,9,8,1,NULL),('200012','Alka-Seltzer',500.00,1,1,1,'/Cliente-Servidor-Farmacia/Views/ImagenProductos/Alka Setzer_0.png');
/*!40000 ALTER TABLE `fide_producto_tb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fide_solicitud_tb`
--

DROP TABLE IF EXISTS `fide_solicitud_tb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fide_solicitud_tb` (
  `ID_SOLICITUD` int(11) NOT NULL AUTO_INCREMENT,
  `FECHA` date NOT NULL,
  `ID_CLIENTE` bigint(20) NOT NULL,
  `ID_FACTURA` int(11) DEFAULT NULL,
  `ID_ESTADO` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID_SOLICITUD`),
  KEY `FK_SOLICITUD_CLIENTE` (`ID_CLIENTE`),
  KEY `FK_SOLICITUD_FACTURA` (`ID_FACTURA`),
  KEY `FK_SOLICITUD_ESTADO` (`ID_ESTADO`),
  CONSTRAINT `FK_SOLICITUD_CLIENTE` FOREIGN KEY (`ID_CLIENTE`) REFERENCES `cliente` (`ID_CLIENTE`),
  CONSTRAINT `FK_SOLICITUD_ESTADO` FOREIGN KEY (`ID_ESTADO`) REFERENCES `fide_estado_tb` (`ID_ESTADO`),
  CONSTRAINT `FK_SOLICITUD_FACTURA` FOREIGN KEY (`ID_FACTURA`) REFERENCES `fide_factura_tb` (`ID_FACTURA`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fide_solicitud_tb`
--

LOCK TABLES `fide_solicitud_tb` WRITE;
/*!40000 ALTER TABLE `fide_solicitud_tb` DISABLE KEYS */;
/*!40000 ALTER TABLE `fide_solicitud_tb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fide_tipo_pago_tb`
--

DROP TABLE IF EXISTS `fide_tipo_pago_tb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fide_tipo_pago_tb` (
  `ID_TIPO_PAGO` int(11) NOT NULL AUTO_INCREMENT,
  `NOMBRE` varchar(100) NOT NULL,
  `ID_ESTADO` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID_TIPO_PAGO`),
  KEY `FK_TIPO_PAGO_ESTADO` (`ID_ESTADO`),
  CONSTRAINT `FK_TIPO_PAGO_ESTADO` FOREIGN KEY (`ID_ESTADO`) REFERENCES `fide_estado_tb` (`ID_ESTADO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fide_tipo_pago_tb`
--

LOCK TABLES `fide_tipo_pago_tb` WRITE;
/*!40000 ALTER TABLE `fide_tipo_pago_tb` DISABLE KEYS */;
/*!40000 ALTER TABLE `fide_tipo_pago_tb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fide_unidad_medida_tb`
--

DROP TABLE IF EXISTS `fide_unidad_medida_tb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fide_unidad_medida_tb` (
  `ID_UNIDAD_MEDIDA` int(11) NOT NULL AUTO_INCREMENT,
  `NOMBRE` varchar(50) NOT NULL,
  `ID_ESTADO` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID_UNIDAD_MEDIDA`),
  KEY `FK_UNIDAD_MEDIDA_ESTADO` (`ID_ESTADO`),
  CONSTRAINT `FK_UNIDAD_MEDIDA_ESTADO` FOREIGN KEY (`ID_ESTADO`) REFERENCES `fide_estado_tb` (`ID_ESTADO`)
) ENGINE=InnoDB AUTO_INCREMENT=211 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fide_unidad_medida_tb`
--

LOCK TABLES `fide_unidad_medida_tb` WRITE;
/*!40000 ALTER TABLE `fide_unidad_medida_tb` DISABLE KEYS */;
INSERT INTO `fide_unidad_medida_tb` VALUES (1,'Unidad',1),(2,'Tableta',1),(3,'Cápsula',1),(4,'Frasco',1),(5,'Gotas',1),(6,'Ampolla',1),(7,'Sobre',1),(8,'Crema',1),(9,'Gel',1),(10,'Solución',1),(11,'Jarabe',1),(12,'Polvo',1),(13,'Spray',1),(14,'Parche',1),(15,'Supositorio',1),(16,'Enema',1),(17,'Inhalador',1),(18,'Colirio',1),(19,'Inyectable',1),(20,'Comprimido',1),(21,'Emulsión',1),(22,'Suspensión',1),(23,'Óvulo',1),(24,'Loción',1),(25,'Vial',1),(26,'Kit',1),(27,'Implante',1),(28,'Jeringa',1),(29,'Champú',1),(30,'Ungüento',1),(31,'Unidad',1),(32,'Tableta',1),(33,'Cápsula',1),(34,'Frasco',1),(35,'Gotas',1),(36,'Ampolla',1),(37,'Sobre',1),(38,'Crema',1),(39,'Gel',1),(40,'Solución',1),(41,'Jarabe',1),(42,'Polvo',1),(43,'Spray',1),(44,'Parche',1),(45,'Supositorio',1),(46,'Enema',1),(47,'Inhalador',1),(48,'Colirio',1),(49,'Inyectable',1),(50,'Comprimido',1),(51,'Emulsión',1),(52,'Suspensión',1),(53,'Óvulo',1),(54,'Loción',1),(55,'Vial',1),(56,'Kit',1),(57,'Implante',1),(58,'Jeringa',1),(59,'Champú',1),(60,'Ungüento',1),(61,'Unidad',1),(62,'Tableta',1),(63,'Cápsula',1),(64,'Frasco',1),(65,'Gotas',1),(66,'Ampolla',1),(67,'Sobre',1),(68,'Crema',1),(69,'Gel',1),(70,'Solución',1),(71,'Jarabe',1),(72,'Polvo',1),(73,'Spray',1),(74,'Parche',1),(75,'Supositorio',1),(76,'Enema',1),(77,'Inhalador',1),(78,'Colirio',1),(79,'Inyectable',1),(80,'Comprimido',1),(81,'Emulsión',1),(82,'Suspensión',1),(83,'Óvulo',1),(84,'Loción',1),(85,'Vial',1),(86,'Kit',1),(87,'Implante',1),(88,'Jeringa',1),(89,'Champú',1),(90,'Ungüento',1),(91,'Unidad',1),(92,'Tableta',1),(93,'Cápsula',1),(94,'Frasco',1),(95,'Gotas',1),(96,'Ampolla',1),(97,'Sobre',1),(98,'Crema',1),(99,'Gel',1),(100,'Solución',1),(101,'Jarabe',1),(102,'Polvo',1),(103,'Spray',1),(104,'Parche',1),(105,'Supositorio',1),(106,'Enema',1),(107,'Inhalador',1),(108,'Colirio',1),(109,'Inyectable',1),(110,'Comprimido',1),(111,'Emulsión',1),(112,'Suspensión',1),(113,'Óvulo',1),(114,'Loción',1),(115,'Vial',1),(116,'Kit',1),(117,'Implante',1),(118,'Jeringa',1),(119,'Champú',1),(120,'Ungüento',1),(121,'Unidad',1),(122,'Tableta',1),(123,'Cápsula',1),(124,'Frasco',1),(125,'Gotas',1),(126,'Ampolla',1),(127,'Sobre',1),(128,'Crema',1),(129,'Gel',1),(130,'Solución',1),(131,'Jarabe',1),(132,'Polvo',1),(133,'Spray',1),(134,'Parche',1),(135,'Supositorio',1),(136,'Enema',1),(137,'Inhalador',1),(138,'Colirio',1),(139,'Inyectable',1),(140,'Comprimido',1),(141,'Emulsión',1),(142,'Suspensión',1),(143,'Óvulo',1),(144,'Loción',1),(145,'Vial',1),(146,'Kit',1),(147,'Implante',1),(148,'Jeringa',1),(149,'Champú',1),(150,'Ungüento',1),(151,'Unidad',1),(152,'Tableta',1),(153,'Cápsula',1),(154,'Frasco',1),(155,'Gotas',1),(156,'Ampolla',1),(157,'Sobre',1),(158,'Crema',1),(159,'Gel',1),(160,'Solución',1),(161,'Jarabe',1),(162,'Polvo',1),(163,'Spray',1),(164,'Parche',1),(165,'Supositorio',1),(166,'Enema',1),(167,'Inhalador',1),(168,'Colirio',1),(169,'Inyectable',1),(170,'Comprimido',1),(171,'Emulsión',1),(172,'Suspensión',1),(173,'Óvulo',1),(174,'Loción',1),(175,'Vial',1),(176,'Kit',1),(177,'Implante',1),(178,'Jeringa',1),(179,'Champú',1),(180,'Ungüento',1),(181,'Unidad',1),(182,'Tableta',1),(183,'Cápsula',1),(184,'Frasco',1),(185,'Gotas',1),(186,'Ampolla',1),(187,'Sobre',1),(188,'Crema',1),(189,'Gel',1),(190,'Solución',1),(191,'Jarabe',1),(192,'Polvo',1),(193,'Spray',1),(194,'Parche',1),(195,'Supositorio',1),(196,'Enema',1),(197,'Inhalador',1),(198,'Colirio',1),(199,'Inyectable',1),(200,'Comprimido',1),(201,'Emulsión',1),(202,'Suspensión',1),(203,'Óvulo',1),(204,'Loción',1),(205,'Vial',1),(206,'Kit',1),(207,'Implante',1),(208,'Jeringa',1),(209,'Champú',1),(210,'Ungüento',1);
/*!40000 ALTER TABLE `fide_unidad_medida_tb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `historial_kardex_v`
--

DROP TABLE IF EXISTS `historial_kardex_v`;
/*!50001 DROP VIEW IF EXISTS `historial_kardex_v`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `historial_kardex_v` AS SELECT 
 1 AS `FECHA_MOVIMIENTO`,
 1 AS `TIPO_MOVIMIENTO`,
 1 AS `CANTIDAD`,
 1 AS `LOTES_AFECTADOS`,
 1 AS `SALDO`,
 1 AS `CODIGO`,
 1 AS `ID_FARMACIA`,
 1 AS `ID_INVENTARIO`,
 1 AS `UNIDAD_MEDIDA`,
 1 AS `FECHA_VENCIMIENTO`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `productos_activos_v`
--

DROP TABLE IF EXISTS `productos_activos_v`;
/*!50001 DROP VIEW IF EXISTS `productos_activos_v`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `productos_activos_v` AS SELECT 
 1 AS `CODIGO`,
 1 AS `NOMBRE`,
 1 AS `PRECIO_UNITARIO`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `rol`
--

DROP TABLE IF EXISTS `rol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rol` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `NOMBRE` varchar(50) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rol`
--

LOCK TABLES `rol` WRITE;
/*!40000 ALTER TABLE `rol` DISABLE KEYS */;
INSERT INTO `rol` VALUES (1,'CLIENTE'),(2,'ADMIN');
/*!40000 ALTER TABLE `rol` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `terror`
--

DROP TABLE IF EXISTS `terror`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `terror` (
  `ID_ERROR` int(11) NOT NULL AUTO_INCREMENT,
  `DESCRIPCION` text NOT NULL,
  `FECHAHORA` datetime NOT NULL,
  PRIMARY KEY (`ID_ERROR`)
) ENGINE=InnoDB AUTO_INCREMENT=199 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `terror`
--

LOCK TABLES `terror` WRITE;
/*!40000 ALTER TABLE `terror` DISABLE KEYS */;
INSERT INTO `terror` VALUES (1,'Column \'ID_INVENTARIO\' cannot be null','2025-07-12 22:49:34'),(2,'Column \'ID_INVENTARIO\' cannot be null','2025-07-12 23:08:36'),(3,'Column \'ID_INVENTARIO\' cannot be null','2025-07-12 23:14:18'),(4,'Column \'ID_INVENTARIO\' cannot be null','2025-07-12 23:14:49'),(5,'No hay suficiente stock en los lotes disponibles.','2025-07-13 14:04:41'),(6,'No hay suficiente stock en los lotes disponibles.','2025-07-13 14:22:09'),(7,'Incorrect number of arguments for PROCEDURE farmaciabd.BuscarProductoPorCodigo; expected 1, got 2','2025-07-13 14:25:23'),(8,'Incorrect number of arguments for PROCEDURE farmaciabd.BuscarProductoPorCodigo; expected 1, got 2','2025-07-13 14:25:37'),(9,'Incorrect number of arguments for PROCEDURE farmaciabd.BuscarProductoPorCodigo; expected 1, got 2','2025-07-13 14:25:44'),(10,'Incorrect number of arguments for PROCEDURE farmaciabd.BuscarProductoPorCodigo; expected 1, got 2','2025-07-13 14:43:21'),(11,'No hay suficiente stock en los lotes disponibles.','2025-07-13 14:44:12'),(12,'Incorrect number of arguments for PROCEDURE farmaciabd.BuscarProductoPorCodigo; expected 1, got 2','2025-07-13 14:48:53'),(13,'Incorrect number of arguments for PROCEDURE farmaciabd.BuscarProductoPorCodigo; expected 1, got 2','2025-07-13 15:05:47'),(14,'Incorrect number of arguments for PROCEDURE farmaciabd.BuscarProductoPorCodigo; expected 1, got 2','2025-07-13 15:09:04'),(15,'Incorrect number of arguments for PROCEDURE farmaciabd.BuscarProductoPorCodigo; expected 1, got 2','2025-07-13 15:25:54'),(16,'Incorrect number of arguments for PROCEDURE farmaciabd.BuscarProductoPorCodigo; expected 1, got 2','2025-07-13 15:29:58'),(17,'Incorrect number of arguments for PROCEDURE farmaciabd.BuscarProductoPorCodigo; expected 1, got 2','2025-07-13 15:44:33'),(18,'Incorrect number of arguments for PROCEDURE farmaciabd.BuscarProductoPorCodigo; expected 1, got 2','2025-07-13 15:51:35'),(19,'No hay suficiente stock acumulado hasta esa fecha para realizar la salida.','2025-07-13 15:54:01'),(20,'Incorrect number of arguments for PROCEDURE farmaciabd.BuscarProductoPorCodigo; expected 1, got 2','2025-07-13 15:58:23'),(21,'Incorrect number of arguments for PROCEDURE farmaciabd.BuscarProductoPorCodigo; expected 1, got 2','2025-07-13 16:41:34'),(22,'Incorrect number of arguments for PROCEDURE farmaciabd.BuscarProductoPorCodigo; expected 1, got 2','2025-07-13 16:46:17'),(23,'Incorrect number of arguments for PROCEDURE farmaciabd.BuscarProductoPorCodigo; expected 1, got 2','2025-07-13 16:49:29'),(24,'Incorrect number of arguments for PROCEDURE farmaciabd.BuscarProductoPorCodigo; expected 1, got 2','2025-07-13 16:54:05'),(25,'Incorrect number of arguments for PROCEDURE farmaciabd.BuscarProductoPorCodigo; expected 1, got 2','2025-07-13 16:56:28'),(26,'Incorrect number of arguments for PROCEDURE farmaciabd.BuscarProductoPorCodigo; expected 1, got 2','2025-07-13 16:58:35'),(27,'Incorrect number of arguments for PROCEDURE farmaciabd.BuscarProductoPorCodigo; expected 1, got 2','2025-07-13 17:00:46'),(28,'You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near \' , , 1, NULL)\' at line 1','2025-08-01 16:56:58'),(29,'You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near \' , , 1, NULL)\' at line 1','2025-08-01 17:02:50'),(30,'Table \'farmaciabd.productos\' doesn\'t exist','2025-08-01 18:11:32'),(31,'Table \'farmaciabd.productos\' doesn\'t exist','2025-08-01 18:11:38'),(32,'Table \'farmaciabd.productos\' doesn\'t exist','2025-08-01 18:11:41'),(33,'Table \'farmaciabd.productos\' doesn\'t exist','2025-08-01 18:21:39'),(34,'Table \'farmaciabd.productos\' doesn\'t exist','2025-08-01 18:23:43'),(35,'Table \'farmaciabd.productos\' doesn\'t exist','2025-08-01 18:23:57'),(36,'Table \'farmaciabd.productos\' doesn\'t exist','2025-08-01 18:24:00'),(37,'Table \'farmaciabd.productos\' doesn\'t exist','2025-08-01 18:24:02'),(38,'Table \'farmaciabd.productos\' doesn\'t exist','2025-08-01 18:24:04'),(39,'Table \'farmaciabd.productos\' doesn\'t exist','2025-08-01 18:24:31'),(40,'Table \'farmaciabd.productos\' doesn\'t exist','2025-08-01 18:24:33'),(41,'Table \'farmaciabd.productos\' doesn\'t exist','2025-08-01 18:24:35'),(42,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:37:50'),(43,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:37:50'),(44,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:37:50'),(45,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:37:50'),(46,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:37:50'),(47,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:37:50'),(48,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:37:50'),(49,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:37:50'),(50,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:37:50'),(51,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:37:50'),(52,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:37:50'),(53,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:37:50'),(54,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:37:50'),(55,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:37:50'),(56,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:37:50'),(57,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:37:51'),(58,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:37:51'),(59,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:37:51'),(60,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:37:51'),(61,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:37:51'),(62,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:37:51'),(63,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:37:51'),(64,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:37:51'),(65,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:37:51'),(66,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:37:51'),(67,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:37:51'),(68,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:37:51'),(69,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:37:51'),(70,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:37:51'),(71,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:37:51'),(72,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:37:51'),(73,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:37:51'),(74,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:37:51'),(75,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:37:51'),(76,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:37:51'),(77,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:37:51'),(78,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:37:51'),(79,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:37:51'),(80,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:37:51'),(81,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:37:51'),(82,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:37:51'),(83,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:37:51'),(84,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:37:51'),(85,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:37:51'),(86,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:37:51'),(87,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:37:51'),(88,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:37:51'),(89,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:37:51'),(90,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:37:51'),(91,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:37:51'),(92,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:37:51'),(93,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:37:51'),(94,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:37:51'),(95,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:37:51'),(96,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:37:51'),(97,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:37:51'),(98,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:37:51'),(99,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:37:51'),(100,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:37:51'),(101,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:37:51'),(102,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:37:52'),(103,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:37:52'),(104,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:37:52'),(105,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:37:52'),(106,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:37:52'),(107,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:37:52'),(108,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:37:52'),(109,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:37:52'),(110,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:37:52'),(111,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:37:52'),(112,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:37:52'),(113,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:37:52'),(114,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:37:52'),(115,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:37:52'),(116,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:39:12'),(117,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:39:12'),(118,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:39:12'),(119,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:39:12'),(120,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:39:12'),(121,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:39:12'),(122,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:39:12'),(123,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:39:12'),(124,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:39:12'),(125,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:39:12'),(126,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:39:12'),(127,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:39:12'),(128,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:39:12'),(129,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:39:12'),(130,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:39:12'),(131,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:39:12'),(132,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:39:12'),(133,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:39:12'),(134,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:39:12'),(135,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:39:12'),(136,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:39:12'),(137,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:39:12'),(138,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:39:12'),(139,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:39:12'),(140,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:39:12'),(141,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:39:12'),(142,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:39:12'),(143,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:39:12'),(144,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:39:12'),(145,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:39:12'),(146,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:39:12'),(147,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:39:12'),(148,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:39:12'),(149,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:39:12'),(150,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:39:12'),(151,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:39:12'),(152,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:39:12'),(153,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:39:12'),(154,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:39:12'),(155,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:39:12'),(156,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:39:12'),(157,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:39:12'),(158,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:39:12'),(159,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:39:12'),(160,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:39:13'),(161,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:39:13'),(162,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:39:13'),(163,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:39:13'),(164,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:39:13'),(165,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:39:13'),(166,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:39:13'),(167,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:39:13'),(168,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:39:13'),(169,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:39:13'),(170,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:39:13'),(171,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:39:13'),(172,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:39:13'),(173,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:39:13'),(174,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:39:13'),(175,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:39:13'),(176,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:39:13'),(177,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:39:13'),(178,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:39:13'),(179,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:39:13'),(180,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:39:13'),(181,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:39:13'),(182,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:39:13'),(183,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:39:13'),(184,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:39:13'),(185,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:39:13'),(186,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:39:13'),(187,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:39:13'),(188,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:39:13'),(189,'PROCEDURE farmaciabd.ObtenerStockTotalDisponibleDeTodasLasSedes does not exist','2025-08-02 19:39:13'),(190,'PROCEDURE farmaciabd.ConsultarUsuariosFarmacia does not exist','2025-08-06 19:41:56'),(191,'PROCEDURE farmaciabd.ConsultarUsuariosFarmacia does not exist','2025-08-06 19:41:57'),(192,'PROCEDURE farmaciabd.ConsultarUsuariosFarmacia does not exist','2025-08-06 20:22:04'),(193,'Unknown column \'U.ID_ESTADO\' in \'field list\'','2025-08-06 20:34:54'),(194,'Unknown column \'U.ID_ESTADO\' in \'field list\'','2025-08-06 20:35:00'),(195,'Unknown column \'U.ID_ESTADO\' in \'field list\'','2025-08-06 20:35:03'),(196,'Unknown column \'U.ID_ESTADO\' in \'field list\'','2025-08-06 20:35:04'),(197,'Unknown column \'U.ID_ESTADO\' in \'field list\'','2025-08-06 20:36:03'),(198,'Unknown column \'U.ID_ESTADO\' in \'field list\'','2025-08-06 20:37:11');
/*!40000 ALTER TABLE `terror` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_alerta`
--

DROP TABLE IF EXISTS `tipo_alerta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipo_alerta` (
  `ID_TIPO_ALERTA` int(11) NOT NULL AUTO_INCREMENT,
  `NOMBRE` varchar(100) NOT NULL,
  `ID_ESTADO` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID_TIPO_ALERTA`),
  KEY `FK_TIPO_ALERTA_ESTADO` (`ID_ESTADO`),
  CONSTRAINT `FK_TIPO_ALERTA_ESTADO` FOREIGN KEY (`ID_ESTADO`) REFERENCES `fide_estado_tb` (`ID_ESTADO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_alerta`
--

LOCK TABLES `tipo_alerta` WRITE;
/*!40000 ALTER TABLE `tipo_alerta` DISABLE KEYS */;
/*!40000 ALTER TABLE `tipo_alerta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `unidad_medida_activa_v`
--

DROP TABLE IF EXISTS `unidad_medida_activa_v`;
/*!50001 DROP VIEW IF EXISTS `unidad_medida_activa_v`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `unidad_medida_activa_v` AS SELECT 
 1 AS `ID_UNIDAD_MEDIDA`,
 1 AS `NOMBRE`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `NOMBRE` varchar(255) NOT NULL,
  `CORREO` varchar(100) NOT NULL,
  `USUARIO` varchar(50) NOT NULL,
  `CONTRASENA` varchar(100) NOT NULL,
  `ID_ESTADO` int(11) DEFAULT 1,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UQ_USUARIO` (`USUARIO`),
  KEY `FK_USUARIO_ESTADO` (`ID_ESTADO`),
  CONSTRAINT `FK_USUARIO_ESTADO` FOREIGN KEY (`ID_ESTADO`) REFERENCES `fide_estado_tb` (`ID_ESTADO`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (1,'Josue Navarro','josueadmin@email.com','josue','123',1),(2,'Abraham Cascante','abrahamcliente@email.com','abraham','123',1),(3,'USUARIO NACHO','cliente@gmail.com','usuario','123',1),(5,'USERCLIENTE ','PRUEBA@GMAIL.COM','JNAVARRO','123',2);
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario_rol`
--

DROP TABLE IF EXISTS `usuario_rol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario_rol` (
  `USUARIO_ID` bigint(20) NOT NULL,
  `ROL_ID` bigint(20) NOT NULL,
  PRIMARY KEY (`USUARIO_ID`,`ROL_ID`),
  KEY `FK_USUARIO_ROL_ROL` (`ROL_ID`),
  CONSTRAINT `FK_USUARIO_ROL_ROL` FOREIGN KEY (`ROL_ID`) REFERENCES `rol` (`ID`) ON DELETE CASCADE,
  CONSTRAINT `FK_USUARIO_ROL_USUARIO` FOREIGN KEY (`USUARIO_ID`) REFERENCES `usuario` (`ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario_rol`
--

LOCK TABLES `usuario_rol` WRITE;
/*!40000 ALTER TABLE `usuario_rol` DISABLE KEYS */;
INSERT INTO `usuario_rol` VALUES (1,2),(2,1),(3,1),(5,1);
/*!40000 ALTER TABLE `usuario_rol` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `vw_resumen`
--

DROP TABLE IF EXISTS `vw_resumen`;
/*!50001 DROP VIEW IF EXISTS `vw_resumen`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_resumen` AS SELECT 
 1 AS `ClientesActivos`,
 1 AS `ClientesInactivos`,
 1 AS `ProductosActivos`,
 1 AS `ProductosInactivos`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_top_clientes`
--

DROP TABLE IF EXISTS `vw_top_clientes`;
/*!50001 DROP VIEW IF EXISTS `vw_top_clientes`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_top_clientes` AS SELECT 
 1 AS `Identificacion`,
 1 AS `Nombre`,
 1 AS `Cantidad`,
 1 AS `Total`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_top_productos`
--

DROP TABLE IF EXISTS `vw_top_productos`;
/*!50001 DROP VIEW IF EXISTS `vw_top_productos`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_top_productos` AS SELECT 
 1 AS `IdProducto`,
 1 AS `Nombre`,
 1 AS `Precio`,
 1 AS `Total`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'farmaciabd'
--

--
-- Dumping routines for database 'farmaciabd'
--
/*!50003 DROP PROCEDURE IF EXISTS `ActualizarContrasenna` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ActualizarContrasenna`(
    IN pIdUsuario BIGINT(11),
    IN pContrasenna VARCHAR(100)
)
BEGIN
    UPDATE USUARIO
    SET CONTRASENA = pContrasenna
    WHERE ID = pIdUsuario;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `BuscarProductoPorCodigo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `BuscarProductoPorCodigo`(
    IN p_codigo VARCHAR(20),
    IN p_id_farmacia INT
)
BEGIN
    SELECT 
        P.CODIGO, 
        P.NOMBRE, 
        cat.NOMBRE AS CATEGORIA,
        U.NOMBRE AS UNIDAD, 
        I.CANTIDAD_DISPONIBLE,
        P.ID_ESTADO,
        e.DESCRIPCION AS ESTADO,
        L.FECHA_VENCIMIENTO,
        P.URL_IMAGEN
    FROM FIDE_PRODUCTO_TB P
    JOIN FIDE_UNIDAD_MEDIDA_TB U 
        ON P.ID_UNIDAD_MEDIDA = U.ID_UNIDAD_MEDIDA
    JOIN FIDE_INVENTARIO_TB I 
        ON P.CODIGO = I.CODIGO
    JOIN FIDE_CATEGORIA_PRODUCTO_TB cat
        ON cat.ID_CATEGORIA_PRODUCTO = P.ID_CATEGORIA_PRODUCTO
    JOIN FIDE_ESTADO_TB e
        ON e.ID_ESTADO = P.ID_ESTADO
	JOIN FIDE_LOTE_TB L 
    ON P.CODIGO = L.CODIGO
    WHERE P.CODIGO = p_codigo
      AND I.ID_FARMACIA = p_id_farmacia
    LIMIT 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CambiarEstadoUsuarioFarmacia` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CambiarEstadoUsuarioFarmacia`(IN pIdUsuario BIGINT)
BEGIN
    DECLARE estadoActual INT;

    SELECT ID_ESTADO INTO estadoActual
    FROM USUARIO
    WHERE ID = pIdUsuario;

    IF estadoActual = 1 THEN
        UPDATE USUARIO SET ID_ESTADO = 2 WHERE ID = pIdUsuario;
    ELSE
        UPDATE USUARIO SET ID_ESTADO = 1 WHERE ID = pIdUsuario;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ConsultarClientesTop` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultarClientesTop`(IN p_limit INT)
BEGIN
    SELECT * FROM VW_TOP_CLIENTES LIMIT p_limit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ConsultarInfoUsuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultarInfoUsuario`(IN pIdUsuario INT)
BEGIN
    SELECT ID, NOMBRE, CORREO, USUARIO, CONTRASENA
    FROM usuario
    WHERE ID = pIdUsuario;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ConsultarProductos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultarProductos`()
BEGIN
    SELECT 
        P.CODIGO,
        P.NOMBRE,
        P.PRECIO_UNITARIO,
        cat.NOMBRE AS CATEGORIA,
        um.NOMBRE AS UNIDAD_MEDIDA,
        e.DESCRIPCION AS ESTADO,
        P.ID_ESTADO, 
        P.URL_IMAGEN
    FROM FIDE_PRODUCTO_TB P
    JOIN FIDE_CATEGORIA_PRODUCTO_TB cat ON cat.ID_CATEGORIA_PRODUCTO = P.ID_CATEGORIA_PRODUCTO
    JOIN FIDE_UNIDAD_MEDIDA_TB um ON um.ID_UNIDAD_MEDIDA = P.ID_UNIDAD_MEDIDA
    JOIN FIDE_ESTADO_TB e ON e.ID_ESTADO = P.ID_ESTADO;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ConsultarProductosFiltrados` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultarProductosFiltrados`(
    IN P_NOMBRE VARCHAR(100),
    IN P_CATEGORIA VARCHAR(100)
)
BEGIN
   SELECT 
        P.CODIGO,
        P.NOMBRE,
        P.PRECIO_UNITARIO,
        C.NOMBRE AS CATEGORIA,
        P.URL_IMAGEN
    FROM 
        fide_producto_tb P
        INNER JOIN fide_categoria_producto_tb C ON P.ID_CATEGORIA_PRODUCTO = C.ID_CATEGORIA_PRODUCTO
    WHERE 
        (P_NOMBRE IS NULL OR P_NOMBRE = '' OR P.NOMBRE LIKE CONCAT('%', P_NOMBRE, '%'))
        AND (P_CATEGORIA IS NULL OR P_CATEGORIA = '' OR C.NOMBRE = P_CATEGORIA);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ConsultarProductosTop` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultarProductosTop`(IN p_limit INT)
BEGIN
    SELECT * FROM VW_TOP_PRODUCTOS LIMIT p_limit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ConsultarResumenTop` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultarResumenTop`()
BEGIN
    SELECT * FROM VW_RESUMEN;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ConsultarUsuariosFarmacia` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultarUsuariosFarmacia`()
BEGIN
    SELECT 
        U.ID AS IdUsuario,
        C.CEDULA AS Identificacion,
        U.NOMBRE AS Nombre,
        U.CORREO AS Correo,
        R.NOMBRE AS NombreRol,
        E.DESCRIPCION AS EstadoDescripcion,
        U.ID_ESTADO AS ID_ESTADO
    FROM USUARIO U
    INNER JOIN CLIENTE C ON U.ID = C.ID_USUARIO
    INNER JOIN USUARIO_ROL UR ON U.ID = UR.USUARIO_ID
    INNER JOIN ROL R ON UR.ROL_ID = R.ID
    INNER JOIN FIDE_ESTADO_TB E ON U.ID_ESTADO = E.ID_ESTADO;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `convertir_usuario_en_cliente` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `convertir_usuario_en_cliente`(
    IN p_usuario_id BIGINT,
    IN p_cedula VARCHAR(20),
    IN p_telefono VARCHAR(20),
    IN p_direccion VARCHAR(255),
    IN p_fecha_nacimiento_str VARCHAR(10),  -- formato 'DD-MM-YYYY'
    IN p_sexo VARCHAR(10),
    IN p_alergias TEXT
)
BEGIN
    DECLARE v_rol_cliente_id BIGINT DEFAULT 1;
    DECLARE v_rol_admin_id BIGINT DEFAULT 2;
    DECLARE v_existente INT;
    DECLARE v_fecha_nacimiento DATE;

    -- Validar si existe el usuario
    SELECT COUNT(*) INTO v_existente
    FROM USUARIO
    WHERE ID = p_usuario_id;

    IF v_existente = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El usuario no existe.';
    END IF;

    -- Convertir fecha de texto a DATE
    SET v_fecha_nacimiento = STR_TO_DATE(p_fecha_nacimiento_str, '%d-%m-%Y');

    -- Validar si el usuario tiene rol ADMIN
    SELECT COUNT(*) INTO v_existente
    FROM USUARIO_ROL
    WHERE USUARIO_ID = p_usuario_id AND ROL_ID = v_rol_admin_id;

    IF v_existente > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El usuario tiene rol ADMIN. No puede convertirse en CLIENTE.';
    END IF;

    -- Asignar rol CLIENTE si aún no lo tiene
    SELECT COUNT(*) INTO v_existente
    FROM USUARIO_ROL
    WHERE USUARIO_ID = p_usuario_id AND ROL_ID = v_rol_cliente_id;

    IF v_existente = 0 THEN
        INSERT INTO USUARIO_ROL (USUARIO_ID, ROL_ID)
        VALUES (p_usuario_id, v_rol_cliente_id);
    END IF;

    -- Insertar en la tabla CLIENTE si aún no existe
    SELECT COUNT(*) INTO v_existente
    FROM CLIENTE
    WHERE ID_USUARIO = p_usuario_id;

    IF v_existente = 0 THEN
        INSERT INTO CLIENTE (
            ID_USUARIO,
            CEDULA,
            TELEFONO,
            DIRECCION,
            FECHA_NACIMIENTO,
            SEXO,
            ALERGIAS
        ) VALUES (
            p_usuario_id,
            p_cedula,
            p_telefono,
            p_direccion,
            v_fecha_nacimiento,
            p_sexo,
            p_alergias
        );
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `FIDE_ACTUALIZAR_USUARIOS_SP` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `FIDE_ACTUALIZAR_USUARIOS_SP`(
    IN p_id INT,
    IN p_nombre VARCHAR(100),
    IN p_correo VARCHAR(100),
    IN p_usuario VARCHAR(100),
    IN p_estado INT
)
BEGIN
    UPDATE USUARIO
    SET
        NOMBRE = p_nombre,
        CORREO = p_correo,
        USUARIO = p_usuario,
        ID_ESTADO = p_estado
    WHERE ID = p_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `FIDE_OBTENER_CATEGORIAS_SP` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `FIDE_OBTENER_CATEGORIAS_SP`()
BEGIN
  SELECT ID_CATEGORIA_PRODUCTO, NOMBRE FROM CATEGORIA_PRODUCTO_ACTIVA_V;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `FIDE_OBTENER_PRODUCTOS_ACTIVOS_SP` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `FIDE_OBTENER_PRODUCTOS_ACTIVOS_SP`()
BEGIN
  SELECT CODIGO, NOMBRE
  FROM CODIGOS_ACTIVOS_V;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `FIDE_OBTENER_PRODUCTO_POR_CODIGO_SP` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `FIDE_OBTENER_PRODUCTO_POR_CODIGO_SP`(IN p_codigo VARCHAR(50))
BEGIN
  SELECT CODIGO, NOMBRE, PRECIO_UNITARIO
  FROM PRODUCTOS_ACTIVOS_V
  WHERE CODIGO = p_codigo;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `FIDE_OBTENER_UNIDAD_MEDIDA_ACTIVA_SP` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `FIDE_OBTENER_UNIDAD_MEDIDA_ACTIVA_SP`()
BEGIN
  SELECT ID_UNIDAD_MEDIDA, NOMBRE FROM  UNIDAD_MEDIDA_ACTIVA_V;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `FIDE_OBTENER_USUARIO_POR_ID_SP` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `FIDE_OBTENER_USUARIO_POR_ID_SP`(
    IN p_id INT
)
BEGIN
    SELECT 
        u.ID AS IdUsuario,
        u.NOMBRE,
        u.CORREO,
        u.USUARIO,
        u.ID_ESTADO
    FROM USUARIO u
    WHERE u.ID = p_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `FIDE_PRODUCTO_ELIMINAR_SP` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `FIDE_PRODUCTO_ELIMINAR_SP`(
    IN P_CODIGO VARCHAR(20)
)
BEGIN
    UPDATE fide_producto_tb
    SET ID_ESTADO = 2
    WHERE CODIGO = P_CODIGO;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `FIDE_PRODUCTO_INSERTAR_SP` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `FIDE_PRODUCTO_INSERTAR_SP`(
    IN p_NOMBRE VARCHAR(100),
    IN p_CODIGO VARCHAR(20),
    IN p_PRECIO_UNITARIO DECIMAL(10,2),
    IN p_ID_CATEGORIA_PRODUCTO INT,
    IN p_ID_UNIDAD_MEDIDA INT,
    IN p_ID_ESTADO INT,
    IN p_URL_IMAGEN VARCHAR(255)
)
BEGIN
    INSERT INTO FIDE_PRODUCTO_TB (
        NOMBRE, CODIGO, PRECIO_UNITARIO,
        ID_CATEGORIA_PRODUCTO, ID_UNIDAD_MEDIDA, ID_ESTADO, URL_IMAGEN
    )
    VALUES (
        p_NOMBRE, p_CODIGO, p_PRECIO_UNITARIO,
        p_ID_CATEGORIA_PRODUCTO, p_ID_UNIDAD_MEDIDA, p_ID_ESTADO, p_URL_IMAGEN
    );
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `FIDE_PRODUCTO_MODIFICAR_SP` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `FIDE_PRODUCTO_MODIFICAR_SP`(
    IN p_ID_PRODUCTO INT,               
    IN p_NOMBRE VARCHAR(100),
    IN p_CODIGO VARCHAR(20),
    IN p_PRECIO_UNITARIO DECIMAL(10,2),
    IN p_ID_CATEGORIA_PRODUCTO INT,     
    IN p_ID_UNIDAD_MEDIDA INT,
    IN p_ID_ESTADO INT,
    IN p_URL_IMAGEN VARCHAR (255)
)
BEGIN
    IF p_URL_IMAGEN IS NOT NULL THEN
        UPDATE FIDE_PRODUCTO_TB
        SET
            NOMBRE = p_NOMBRE,
            CODIGO = p_CODIGO,
            PRECIO_UNITARIO = p_PRECIO_UNITARIO,
            ID_CATEGORIA_PRODUCTO = p_ID_CATEGORIA_PRODUCTO,
            ID_UNIDAD_MEDIDA = p_ID_UNIDAD_MEDIDA,
            ID_ESTADO = p_ID_ESTADO,
            URL_IMAGEN = p_URL_IMAGEN
        WHERE
            ID_PRODUCTO = p_ID_PRODUCTO;
    ELSE
        UPDATE FIDE_PRODUCTO_TB
        SET
            NOMBRE = p_NOMBRE,
            CODIGO = p_CODIGO,
            PRECIO_UNITARIO = p_PRECIO_UNITARIO,
            ID_CATEGORIA_PRODUCTO = p_ID_CATEGORIA_PRODUCTO,
            ID_UNIDAD_MEDIDA = p_ID_UNIDAD_MEDIDA,
            ID_ESTADO = p_ID_ESTADO
        WHERE
            ID_PRODUCTO = p_ID_PRODUCTO;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `FIDE_PRODUCTO_MODIFICAR_SP_CODIGO` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `FIDE_PRODUCTO_MODIFICAR_SP_CODIGO`(
    IN p_CODIGO_ORIGINAL VARCHAR(20),
    IN p_NOMBRE VARCHAR(100),
    IN p_PRECIO_UNITARIO DECIMAL(10,2),
    IN p_ID_CATEGORIA_PRODUCTO INT,
    IN p_ID_UNIDAD_MEDIDA INT,
    IN p_ID_ESTADO INT
)
BEGIN
    UPDATE FIDE_PRODUCTO_TB
    SET
        NOMBRE = p_NOMBRE,
        PRECIO_UNITARIO = p_PRECIO_UNITARIO,
        ID_CATEGORIA_PRODUCTO = p_ID_CATEGORIA_PRODUCTO,
        ID_UNIDAD_MEDIDA = p_ID_UNIDAD_MEDIDA,
        ID_ESTADO = p_ID_ESTADO
    WHERE CODIGO = p_CODIGO_ORIGINAL;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `FIDE_USUARIO_CONSULTAR_SP` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `FIDE_USUARIO_CONSULTAR_SP`()
BEGIN
    SELECT 
        u.ID AS IdUsuario,
        u.USUARIO AS Identificacion,
        u.NOMBRE AS Nombre,
        u.CORREO AS Correo,
        r.NOMBRE AS NombreRol,
        e.DESCRIPCION AS EstadoDescripcion,
        u.ID_ESTADO
    FROM usuario u
    LEFT JOIN usuario_rol ur ON u.ID = ur.USUARIO_ID
    LEFT JOIN rol r ON ur.ROL_ID = r.ID
    LEFT JOIN fide_estado_tb e ON u.ID_ESTADO = e.ID_ESTADO;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GenerarSalidaPorLotes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GenerarSalidaPorLotes`(
    IN p_codigo_producto VARCHAR(20),
    IN p_id_farmacia INT,
    IN p_cantidad_total INT,
    IN p_fecha_movimiento DATE,
    IN p_descripcion VARCHAR(255),
    IN p_empresa VARCHAR(100)
)
BEGIN
    DECLARE v_cantidad_restante INT DEFAULT 0;
    DECLARE v_id_inventario INT;
    DECLARE v_id_lote INT;
    DECLARE v_numero_lote VARCHAR(100);
    DECLARE v_fecha_venc DATE;
    DECLARE v_cantidad_en_lote INT;
    DECLARE v_stock_fecha INT;
    DECLARE v_total_retirado INT DEFAULT 0; -- 👈 NUEVO

    -- Cursor y handler deben declararse ANTES de cualquier otra lógica
    DECLARE lote_cursor CURSOR FOR
        SELECT 
            L.ID_LOTE, L.NUMERO_LOTE, L.FECHA_VENCIMIENTO,
            SUM(CASE 
                WHEN M.TIPO_MOVIMIENTO = 'Entrada' THEN M.CANTIDAD
                WHEN M.TIPO_MOVIMIENTO = 'Salida' THEN -M.CANTIDAD
                ELSE 0
            END) AS CANTIDAD_EN_LOTE
        FROM FIDE_MOVIMIENTO_TB M
        JOIN FIDE_LOTE_TB L ON M.ID_LOTE = L.ID_LOTE
        WHERE L.CODIGO = p_codigo_producto AND M.ID_FARMACIA = p_id_farmacia
          AND M.FECHA_MOVIMIENTO <= p_fecha_movimiento
        GROUP BY L.ID_LOTE, L.NUMERO_LOTE, L.FECHA_VENCIMIENTO
        HAVING CANTIDAD_EN_LOTE > 0
        ORDER BY L.FECHA_VENCIMIENTO ASC;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_id_lote = NULL;

    SET v_cantidad_restante = p_cantidad_total;

    -- Validación previa
    SELECT 
        IFNULL(SUM(CASE 
            WHEN TIPO_MOVIMIENTO = 'Entrada' THEN CANTIDAD
            WHEN TIPO_MOVIMIENTO = 'Salida' THEN -CANTIDAD
            ELSE 0
        END), 0)
    INTO v_stock_fecha
    FROM FIDE_MOVIMIENTO_TB M
    JOIN FIDE_INVENTARIO_TB I ON M.ID_INVENTARIO = I.ID_INVENTARIO
    WHERE I.CODIGO = p_codigo_producto
      AND M.ID_FARMACIA = p_id_farmacia
      AND M.FECHA_MOVIMIENTO <= p_fecha_movimiento;

    IF v_stock_fecha < p_cantidad_total THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No hay suficiente stock acumulado hasta esa fecha para realizar la salida.';
    END IF;

    SELECT ID_INVENTARIO INTO v_id_inventario
    FROM FIDE_INVENTARIO_TB
    WHERE CODIGO = p_codigo_producto AND ID_FARMACIA = p_id_farmacia
    LIMIT 1;

    OPEN lote_cursor;

    lote_loop: LOOP
        FETCH lote_cursor INTO v_id_lote, v_numero_lote, v_fecha_venc, v_cantidad_en_lote;

        IF v_id_lote IS NULL OR v_cantidad_restante <= 0 THEN
            LEAVE lote_loop;
        END IF;

        IF v_cantidad_en_lote >= v_cantidad_restante THEN
            INSERT INTO FIDE_MOVIMIENTO_TB (
                ID_INVENTARIO, ID_LOTE, FECHA_MOVIMIENTO, FECHA_VENCIMIENTO,
                TIPO_MOVIMIENTO, CANTIDAD, DESCRIPCION, EMPRESA, ID_FARMACIA
            ) VALUES (
                v_id_inventario, v_id_lote, p_fecha_movimiento, v_fecha_venc,
                'Salida', v_cantidad_restante, p_descripcion, p_empresa, p_id_farmacia
            );

            SET v_total_retirado = v_total_retirado + v_cantidad_restante; -- 👈 NUEVO
            SET v_cantidad_restante = 0;
        ELSE
            INSERT INTO FIDE_MOVIMIENTO_TB (
                ID_INVENTARIO, ID_LOTE, FECHA_MOVIMIENTO, FECHA_VENCIMIENTO,
                TIPO_MOVIMIENTO, CANTIDAD, DESCRIPCION, EMPRESA, ID_FARMACIA
            ) VALUES (
                v_id_inventario, v_id_lote, p_fecha_movimiento, v_fecha_venc,
                'Salida', v_cantidad_en_lote, p_descripcion, p_empresa, p_id_farmacia
            );

            SET v_total_retirado = v_total_retirado + v_cantidad_en_lote; -- 👈 NUEVO
            SET v_cantidad_restante = v_cantidad_restante - v_cantidad_en_lote;
        END IF;
    END LOOP;

    CLOSE lote_cursor;

    -- 👇 NUEVO: actualizar solo una vez el saldo
    UPDATE FIDE_INVENTARIO_TB
    SET CANTIDAD_DISPONIBLE = CANTIDAD_DISPONIBLE - v_total_retirado
    WHERE ID_INVENTARIO = v_id_inventario;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertarMovimiento` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertarMovimiento`(
    IN p_codigo_producto VARCHAR(20),
    IN p_numero_lote VARCHAR(100),
    IN p_fecha_vencimiento DATE,
    IN p_fecha_movimiento DATE,
    IN p_tipo_movimiento VARCHAR(10),
    IN p_cantidad INT,
    IN p_descripcion VARCHAR(255),
    IN p_empresa VARCHAR(100),
    IN p_id_farmacia INT
)
BEGIN
    DECLARE v_id_lote INT;
    DECLARE v_id_inventario INT;
    DECLARE v_saldo_actual INT;

    -- Buscar lote por producto, número y vencimiento (clave compuesta)
    SELECT ID_LOTE INTO v_id_lote
    FROM FIDE_LOTE_TB
    WHERE CODIGO = p_codigo_producto
      AND NUMERO_LOTE = p_numero_lote
      AND FECHA_VENCIMIENTO = p_fecha_vencimiento
    LIMIT 1;

    -- Si no existe el lote exacto, se crea
    IF v_id_lote IS NULL THEN
        INSERT INTO FIDE_LOTE_TB (
            CODIGO, NUMERO_LOTE, FECHA_ELABORADO, FECHA_VENCIMIENTO, ID_ESTADO
        ) VALUES (
            p_codigo_producto, p_numero_lote, p_fecha_movimiento, p_fecha_vencimiento, 1
        );

        SET v_id_lote = LAST_INSERT_ID();
    END IF;

    -- Verificar si ya está en inventario de la farmacia
    SELECT ID_INVENTARIO, CANTIDAD_DISPONIBLE INTO v_id_inventario, v_saldo_actual
    FROM FIDE_INVENTARIO_TB
    WHERE CODIGO = p_codigo_producto AND ID_FARMACIA = p_id_farmacia
    LIMIT 1;

    -- Si no existe, se crea el inventario base
    IF v_id_inventario IS NULL THEN
        INSERT INTO FIDE_INVENTARIO_TB (
            CODIGO, CANTIDAD_DISPONIBLE, STOCK_MINIMO, STOCK_MAXIMO,
            ID_FARMACIA, ID_ESTADO
        ) VALUES (
            p_codigo_producto, 0, 0, 0,
            p_id_farmacia, 1
        );

        SET v_id_inventario = LAST_INSERT_ID();
        SET v_saldo_actual = 0;
    END IF;

    -- Actualizar inventario según tipo de movimiento
    IF p_tipo_movimiento = 'Entrada' THEN
        UPDATE FIDE_INVENTARIO_TB
        SET CANTIDAD_DISPONIBLE = v_saldo_actual + p_cantidad
        WHERE ID_INVENTARIO = v_id_inventario;
    ELSE
        UPDATE FIDE_INVENTARIO_TB
        SET CANTIDAD_DISPONIBLE = v_saldo_actual - p_cantidad
        WHERE ID_INVENTARIO = v_id_inventario;
    END IF;

    -- Insertar movimiento
    INSERT INTO FIDE_MOVIMIENTO_TB (
        ID_INVENTARIO, ID_LOTE, FECHA_MOVIMIENTO, FECHA_VENCIMIENTO,
        TIPO_MOVIMIENTO, CANTIDAD, DESCRIPCION, EMPRESA, ID_FARMACIA
    ) VALUES (
        v_id_inventario, v_id_lote, p_fecha_movimiento, p_fecha_vencimiento,
        p_tipo_movimiento, p_cantidad, p_descripcion, p_empresa, p_id_farmacia
    );

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `new_procedure` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `new_procedure`(IN p_id_usuario BIGINT)
BEGIN

    DECLARE estado_actual INT;

    -- Obtener el estado actual del usuario
    SELECT ID_ESTADO INTO estado_actual
    FROM usuario
    WHERE ID = p_id_usuario;

    -- Cambiar el estado: si es 1 (activo) se cambia a 2 (inactivo), y viceversa
    IF estado_actual = 1 THEN
        UPDATE usuario SET ID_ESTADO = 2 WHERE ID = p_id_usuario;
    ELSE
        UPDATE usuario SET ID_ESTADO = 1 WHERE ID = p_id_usuario;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ObtenerCategorias` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ObtenerCategorias`()
BEGIN
    SELECT DISTINCT NOMBRE FROM fide_categoria_producto_tb ORDER BY NOMBRE ASC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ObtenerHistorialKardex` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ObtenerHistorialKardex`(
    IN p_codigo VARCHAR(20),
    IN p_id_farmacia INT
)
BEGIN
    SELECT *
    FROM HISTORIAL_KARDEX_V
    WHERE CODIGO = p_codigo
      AND ID_FARMACIA = p_id_farmacia
    ORDER BY FECHA_MOVIMIENTO ASC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ObtenerHistorialMovimientos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ObtenerHistorialMovimientos`(
    IN p_codigo_producto VARCHAR(20),
    IN p_id_farmacia INT
)
BEGIN
    SET @saldo := 0;

    SELECT 
        Movs.FECHA_MOVIMIENTO,
        Movs.TIPO_MOVIMIENTO,
        CONCAT(
            IF(Movs.TIPO_MOVIMIENTO = 'Entrada', '+', '-'),
            Movs.CANTIDAD
        ) AS CANTIDAD,
        @saldo := @saldo + 
            (CASE 
                WHEN Movs.TIPO_MOVIMIENTO = 'Entrada' THEN Movs.CANTIDAD 
                ELSE -Movs.CANTIDAD 
            END) AS SALDO
    FROM (
        SELECT M.FECHA_MOVIMIENTO, M.TIPO_MOVIMIENTO, M.CANTIDAD
        FROM FIDE_MOVIMIENTO_TB M
        JOIN FIDE_INVENTARIO_TB I ON M.ID_INVENTARIO = I.ID_INVENTARIO
        WHERE I.CODIGO = p_codigo_producto AND M.ID_FARMACIA = p_id_farmacia
        ORDER BY M.FECHA_MOVIMIENTO ASC
    ) AS Movs;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ObtenerLotesDisponiblesPorProducto` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ObtenerLotesDisponiblesPorProducto`(
    IN p_codigo_producto VARCHAR(20),
    IN p_id_farmacia INT
)
BEGIN
    SELECT
        L.CODIGO,
        L.NUMERO_LOTE,
        L.FECHA_VENCIMIENTO,
        F.NOMBRE AS NOMBRE_FARMACIA,
        SUM(
            CASE
                WHEN M.TIPO_MOVIMIENTO = 'Entrada' THEN M.CANTIDAD
                WHEN M.TIPO_MOVIMIENTO = 'Salida' THEN -M.CANTIDAD
                ELSE 0
            END
        ) AS CANTIDAD_EN_LOTE
    FROM FIDE_MOVIMIENTO_TB M
    JOIN FIDE_LOTE_TB L ON M.ID_LOTE = L.ID_LOTE
    JOIN FIDE_FARMACIA_TB F ON M.ID_FARMACIA = F.ID_FARMACIA
    WHERE L.CODIGO = p_codigo_producto
      AND M.ID_FARMACIA = p_id_farmacia
    GROUP BY L.CODIGO, L.NUMERO_LOTE, L.FECHA_VENCIMIENTO, F.NOMBRE
    HAVING CANTIDAD_EN_LOTE > 0
    ORDER BY L.FECHA_VENCIMIENTO ASC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ObtenerStockDisponible` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ObtenerStockDisponible`(
    IN p_codigo_producto VARCHAR(20),
    IN p_id_farmacia INT
)
BEGIN
    SELECT CANTIDAD_DISPONIBLE
    FROM FIDE_INVENTARIO_TB
    WHERE CODIGO = p_codigo_producto AND ID_FARMACIA = p_id_farmacia
    LIMIT 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ObtenerStockTotalDisponible` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ObtenerStockTotalDisponible`(
    IN p_codigo_producto VARCHAR(20)
)
BEGIN
    SELECT 
        SUM(CANTIDAD_DISPONIBLE) AS STOCK_DISPONIBLE_TOTAL
    FROM 
        FIDE_INVENTARIO_TB
    WHERE 
        CODIGO = p_codigo_producto;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ObtenerStockTotalDisponibleDeTodasLasSedes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ObtenerStockTotalDisponibleDeTodasLasSedes`(
    IN p_codigo_producto VARCHAR(20)
)
BEGIN
    SELECT 
        SUM(CANTIDAD_DISPONIBLE) AS STOCK_DISPONIBLE_TOTAL
    FROM 
        FIDE_INVENTARIO_TB
    WHERE 
        CODIGO = p_codigo_producto;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RegistrarError` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RegistrarError`(
    IN pDescripcion VARCHAR(5000)
)
BEGIN
    INSERT INTO TERROR (DESCRIPCION, FECHAHORA)
    VALUES (pDescripcion, NOW());
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RegistrarUsuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RegistrarUsuario`(
    IN pnombre VARCHAR(255),
    IN pcorreo VARCHAR(100),
    IN pusuario VARCHAR(50),
    IN pcontrasena VARCHAR(100)
)
BEGIN
    INSERT INTO USUARIO (NOMBRE, CORREO, USUARIO, CONTRASENA)
    VALUES (pnombre, pcorreo, pusuario, pcontrasena);
    -- Asignar rol por defecto(CLIENTE con ID = 1)
    INSERT INTO USUARIO_ROL (USUARIO_ID, ROL_ID)
    VALUES (LAST_INSERT_ID(), 1);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ValidarCorreo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ValidarCorreo`(pcorreo VARCHAR(100))
BEGIN
    SELECT NOMBRE, ID
    FROM USUARIO
    WHERE CORREO = pcorreo;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ValidarInicioSesion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ValidarInicioSesion`(
    IN pcorreo VARCHAR(100),
    IN pcontrasena VARCHAR(100)
)
BEGIN
    SELECT 
        u.ID,
        u.NOMBRE,
        u.CORREO,
        u.USUARIO,
        u.CONTRASENA,
         r.ID     AS ROL_ID,
        r.NOMBRE AS ROL
    FROM USUARIO u
    JOIN USUARIO_ROL ur ON u.ID = ur.USUARIO_ID
    JOIN ROL r ON r.ID = ur.ROL_ID
    WHERE u.CORREO = pcorreo
      AND u.CONTRASENA = pcontrasena
      AND u.ID_ESTADO = 1; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `categoria_producto_activa_v`
--

/*!50001 DROP VIEW IF EXISTS `categoria_producto_activa_v`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `categoria_producto_activa_v` AS select `fide_categoria_producto_tb`.`ID_CATEGORIA_PRODUCTO` AS `ID_CATEGORIA_PRODUCTO`,`fide_categoria_producto_tb`.`NOMBRE` AS `NOMBRE` from `fide_categoria_producto_tb` where `fide_categoria_producto_tb`.`ID_ESTADO` = 1 */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `codigos_activos_v`
--

/*!50001 DROP VIEW IF EXISTS `codigos_activos_v`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `codigos_activos_v` AS select `fide_producto_tb`.`CODIGO` AS `CODIGO`,`fide_producto_tb`.`NOMBRE` AS `NOMBRE` from `fide_producto_tb` where `fide_producto_tb`.`ID_ESTADO` = 1 */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `farmacia_activa_v`
--

/*!50001 DROP VIEW IF EXISTS `farmacia_activa_v`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `farmacia_activa_v` AS select `fide_farmacia_tb`.`ID_FARMACIA` AS `ID_FARMACIA`,`fide_farmacia_tb`.`NOMBRE` AS `NOMBRE` from `fide_farmacia_tb` where `fide_farmacia_tb`.`ID_ESTADO` = 1 */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `farmacias_v`
--

/*!50001 DROP VIEW IF EXISTS `farmacias_v`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `farmacias_v` AS select `fide_farmacia_tb`.`ID_FARMACIA` AS `ID_FARMACIA`,`fide_farmacia_tb`.`NOMBRE` AS `NOMBRE` from `fide_farmacia_tb` where `fide_farmacia_tb`.`ID_ESTADO` = 1 */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `historial_kardex_v`
--

/*!50001 DROP VIEW IF EXISTS `historial_kardex_v`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `historial_kardex_v` AS select `m`.`FECHA_MOVIMIENTO` AS `FECHA_MOVIMIENTO`,`m`.`TIPO_MOVIMIENTO` AS `TIPO_MOVIMIENTO`,case when `m`.`TIPO_MOVIMIENTO` = 'Entrada' then concat('+',`m`.`CANTIDAD`) when `m`.`TIPO_MOVIMIENTO` = 'Salida' then concat('-',`m`.`CANTIDAD`) else concat('',`m`.`CANTIDAD`) end AS `CANTIDAD`,`l`.`NUMERO_LOTE` AS `LOTES_AFECTADOS`,(select ifnull(sum(case when `m2`.`TIPO_MOVIMIENTO` = 'Entrada' then `m2`.`CANTIDAD` when `m2`.`TIPO_MOVIMIENTO` = 'Salida' then -`m2`.`CANTIDAD` else 0 end),0) from `fide_movimiento_tb` `m2` where `m2`.`ID_INVENTARIO` = `m`.`ID_INVENTARIO` and `m2`.`ID_FARMACIA` = `m`.`ID_FARMACIA` and (`m2`.`FECHA_MOVIMIENTO` < `m`.`FECHA_MOVIMIENTO` or `m2`.`FECHA_MOVIMIENTO` = `m`.`FECHA_MOVIMIENTO` and `m2`.`ID_MOVIMIENTO` <= `m`.`ID_MOVIMIENTO`)) AS `SALDO`,`i`.`CODIGO` AS `CODIGO`,`m`.`ID_FARMACIA` AS `ID_FARMACIA`,`m`.`ID_INVENTARIO` AS `ID_INVENTARIO`,`u`.`NOMBRE` AS `UNIDAD_MEDIDA`,`l`.`FECHA_VENCIMIENTO` AS `FECHA_VENCIMIENTO` from ((((`fide_movimiento_tb` `m` join `fide_lote_tb` `l` on(`m`.`ID_LOTE` = `l`.`ID_LOTE`)) join `fide_inventario_tb` `i` on(`m`.`ID_INVENTARIO` = `i`.`ID_INVENTARIO`)) join `fide_producto_tb` `p` on(`i`.`CODIGO` = `p`.`CODIGO`)) join `fide_unidad_medida_tb` `u` on(`p`.`ID_UNIDAD_MEDIDA` = `u`.`ID_UNIDAD_MEDIDA`)) order by `m`.`FECHA_MOVIMIENTO`,`m`.`ID_MOVIMIENTO` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `productos_activos_v`
--

/*!50001 DROP VIEW IF EXISTS `productos_activos_v`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `productos_activos_v` AS select `fide_producto_tb`.`CODIGO` AS `CODIGO`,`fide_producto_tb`.`NOMBRE` AS `NOMBRE`,`fide_producto_tb`.`PRECIO_UNITARIO` AS `PRECIO_UNITARIO` from `fide_producto_tb` where `fide_producto_tb`.`ID_ESTADO` = 1 */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `unidad_medida_activa_v`
--

/*!50001 DROP VIEW IF EXISTS `unidad_medida_activa_v`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `unidad_medida_activa_v` AS select `fide_unidad_medida_tb`.`ID_UNIDAD_MEDIDA` AS `ID_UNIDAD_MEDIDA`,`fide_unidad_medida_tb`.`NOMBRE` AS `NOMBRE` from `fide_unidad_medida_tb` where `fide_unidad_medida_tb`.`ID_ESTADO` = 1 */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_resumen`
--

/*!50001 DROP VIEW IF EXISTS `vw_resumen`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_resumen` AS select (select count(0) from `usuario` `u` where coalesce(`u`.`ID_ESTADO`,0) = 1) AS `ClientesActivos`,(select count(0) from `usuario` `u` where coalesce(`u`.`ID_ESTADO`,0) <> 1) AS `ClientesInactivos`,(select count(0) from (`fide_producto_tb` `p` join `fide_estado_tb` `e` on(`e`.`ID_ESTADO` = `p`.`ID_ESTADO`)) where `e`.`DESCRIPCION` = 'Activo') AS `ProductosActivos`,(select count(0) from (`fide_producto_tb` `p` join `fide_estado_tb` `e` on(`e`.`ID_ESTADO` = `p`.`ID_ESTADO`)) where `e`.`DESCRIPCION` = 'Inactivo') AS `ProductosInactivos` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_top_clientes`
--

/*!50001 DROP VIEW IF EXISTS `vw_top_clientes`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_top_clientes` AS select `c`.`CEDULA` AS `Identificacion`,coalesce(`u`.`NOMBRE`,'(Sin nombre)') AS `Nombre`,count(distinct `s`.`ID_FACTURA`) AS `Cantidad`,coalesce(sum(`f`.`TOTAL`),0) AS `Total` from (((`cliente` `c` left join `usuario` `u` on(`u`.`ID` = `c`.`ID_USUARIO`)) left join `fide_solicitud_tb` `s` on(`s`.`ID_CLIENTE` = `c`.`ID_CLIENTE`)) left join `fide_factura_tb` `f` on(`f`.`ID_FACTURA` = `s`.`ID_FACTURA`)) group by `c`.`CEDULA`,`u`.`NOMBRE` order by coalesce(sum(`f`.`TOTAL`),0) desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_top_productos`
--

/*!50001 DROP VIEW IF EXISTS `vw_top_productos`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_top_productos` AS select `p`.`CODIGO` AS `IdProducto`,`p`.`NOMBRE` AS `Nombre`,avg(coalesce(`p`.`PRECIO_UNITARIO`,0)) AS `Precio`,sum(coalesce(`ds`.`CANTIDAD_ENTREGADA`,0) * coalesce(`p`.`PRECIO_UNITARIO`,0)) AS `Total` from (((`fide_detalle_solicitud_tb` `ds` join `fide_solicitud_tb` `s` on(`s`.`ID_SOLICITUD` = `ds`.`ID_SOLICITUD`)) left join `fide_inventario_tb` `i` on(`i`.`ID_INVENTARIO` = `ds`.`ID_INVENTARIO`)) left join `fide_producto_tb` `p` on(`p`.`CODIGO` = `i`.`CODIGO`)) group by `p`.`CODIGO`,`p`.`NOMBRE` order by sum(coalesce(`ds`.`CANTIDAD_ENTREGADA`,0) * coalesce(`p`.`PRECIO_UNITARIO`,0)) desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-08-16 14:52:05
