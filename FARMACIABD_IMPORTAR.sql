CREATE DATABASE  IF NOT EXISTS `farmaciabd` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `farmaciabd`;
-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
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
  KEY `ID_USUARIO` (`ID_USUARIO`),
  CONSTRAINT `cliente_ibfk_1` FOREIGN KEY (`ID_USUARIO`) REFERENCES `usuario` (`ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;

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
  KEY `ID_TIPO_ALERTA` (`ID_TIPO_ALERTA`),
  KEY `ID_INVENTARIO` (`ID_INVENTARIO`),
  KEY `ID_ESTADO` (`ID_ESTADO`),
  CONSTRAINT `fide_alerta_tb_ibfk_1` FOREIGN KEY (`ID_TIPO_ALERTA`) REFERENCES `tipo_alerta` (`ID_TIPO_ALERTA`),
  CONSTRAINT `fide_alerta_tb_ibfk_2` FOREIGN KEY (`ID_INVENTARIO`) REFERENCES `fide_inventario_tb` (`ID_INVENTARIO`),
  CONSTRAINT `fide_alerta_tb_ibfk_3` FOREIGN KEY (`ID_ESTADO`) REFERENCES `fide_estado_tb` (`ID_ESTADO`)
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
  KEY `ID_ESTADO` (`ID_ESTADO`),
  CONSTRAINT `fide_categoria_producto_tb_ibfk_1` FOREIGN KEY (`ID_ESTADO`) REFERENCES `fide_estado_tb` (`ID_ESTADO`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fide_categoria_producto_tb`
--

LOCK TABLES `fide_categoria_producto_tb` WRITE;
/*!40000 ALTER TABLE `fide_categoria_producto_tb` DISABLE KEYS */;
INSERT INTO `fide_categoria_producto_tb` VALUES (1,'Analgésico',1),(2,'Antibiótico',1),(3,'Antiinflamatorio',1),(4,'Antialérgico',1),(5,'Antipirético',1),(6,'Antihipertensivo',1),(7,'Antidiabético',1),(8,'Anticonvulsivo',1),(9,'Antipsicótico',1),(10,'Ansiolítico',1),(11,'Antidepresivo',1),(12,'Gastrointestinal',1),(13,'Vitaminas y suplementos',1),(14,'Antimicótico',1),(15,'Antiviral',1),(16,'Hormonas',1),(17,'Cardiovascular',1),(18,'Anticoagulante',1),(19,'Antiparasitario',1),(20,'Cuidado dermatológico',1),(21,'Inmunológico',1),(22,'Pediátrico',1),(23,'Ginecológico',1),(24,'Respiratorio',1),(25,'Oftálmico',1),(26,'Odontológico',1),(27,'Otros',1);
/*!40000 ALTER TABLE `fide_categoria_producto_tb` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fide_estado_tb`
--

LOCK TABLES `fide_estado_tb` WRITE;
/*!40000 ALTER TABLE `fide_estado_tb` DISABLE KEYS */;
INSERT INTO `fide_estado_tb` VALUES (1,'Activo'),(2,'Inactivo'),(3,'Eliminado'),(4,'Pendiente'),(5,'Vencido'),(6,'En revisión'),(7,'Completado'),(8,'Cancelado');
/*!40000 ALTER TABLE `fide_estado_tb` ENABLE KEYS */;
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
  KEY `ID_ESTADO` (`ID_ESTADO`),
  CONSTRAINT `fide_farmacia_tb_ibfk_1` FOREIGN KEY (`ID_ESTADO`) REFERENCES `fide_estado_tb` (`ID_ESTADO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fide_farmacia_tb`
--

LOCK TABLES `fide_farmacia_tb` WRITE;
/*!40000 ALTER TABLE `fide_farmacia_tb` DISABLE KEYS */;
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
  `ID_PRODUCTO` int(11) DEFAULT NULL,
  `CANTIDAD_DISPONIBLE` int(11) NOT NULL,
  `STOCK_MINIMO` int(11) DEFAULT NULL,
  `STOCK_MAXIMO` int(11) DEFAULT NULL,
  `ID_FARMACIA` int(11) DEFAULT NULL,
  `ID_ESTADO` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID_INVENTARIO`),
  KEY `ID_PRODUCTO` (`ID_PRODUCTO`),
  KEY `ID_FARMACIA` (`ID_FARMACIA`),
  KEY `ID_ESTADO` (`ID_ESTADO`),
  CONSTRAINT `fide_inventario_tb_ibfk_1` FOREIGN KEY (`ID_PRODUCTO`) REFERENCES `fide_producto_tb` (`ID_PRODUCTO`),
  CONSTRAINT `fide_inventario_tb_ibfk_2` FOREIGN KEY (`ID_FARMACIA`) REFERENCES `fide_farmacia_tb` (`ID_FARMACIA`),
  CONSTRAINT `fide_inventario_tb_ibfk_3` FOREIGN KEY (`ID_ESTADO`) REFERENCES `fide_estado_tb` (`ID_ESTADO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fide_inventario_tb`
--

LOCK TABLES `fide_inventario_tb` WRITE;
/*!40000 ALTER TABLE `fide_inventario_tb` DISABLE KEYS */;
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
  `ID_PRODUCTO` int(11) DEFAULT NULL,
  `NUMERO_LOTE` varchar(100) DEFAULT NULL,
  `FECHA_ELABORADO` date DEFAULT NULL,
  `FECHA_VENCIMIENTO` date DEFAULT NULL,
  `ID_ESTADO` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID_LOTE`),
  KEY `ID_PRODUCTO` (`ID_PRODUCTO`),
  KEY `ID_ESTADO` (`ID_ESTADO`),
  CONSTRAINT `fide_lote_tb_ibfk_1` FOREIGN KEY (`ID_PRODUCTO`) REFERENCES `fide_producto_tb` (`ID_PRODUCTO`),
  CONSTRAINT `fide_lote_tb_ibfk_2` FOREIGN KEY (`ID_ESTADO`) REFERENCES `fide_estado_tb` (`ID_ESTADO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fide_lote_tb`
--

LOCK TABLES `fide_lote_tb` WRITE;
/*!40000 ALTER TABLE `fide_lote_tb` DISABLE KEYS */;
/*!40000 ALTER TABLE `fide_lote_tb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fide_producto_tb`
--

DROP TABLE IF EXISTS `fide_producto_tb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fide_producto_tb` (
  `ID_PRODUCTO` int(11) NOT NULL AUTO_INCREMENT,
  `NOMBRE` varchar(100) NOT NULL,
  `CODIGO` varchar(20) NOT NULL,
  `PRECIO_UNITARIO` decimal(10,2) DEFAULT NULL,
  `ID_CATEGORIA_PRODUCTO` int(11) DEFAULT NULL,
  `ID_UNIDAD_MEDIDA` int(11) DEFAULT NULL,
  `ID_ESTADO` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID_PRODUCTO`),
  UNIQUE KEY `CODIGO` (`CODIGO`),
  KEY `ID_CATEGORIA_PRODUCTO` (`ID_CATEGORIA_PRODUCTO`),
  KEY `ID_UNIDAD_MEDIDA` (`ID_UNIDAD_MEDIDA`),
  KEY `ID_ESTADO` (`ID_ESTADO`),
  CONSTRAINT `fide_producto_tb_ibfk_1` FOREIGN KEY (`ID_CATEGORIA_PRODUCTO`) REFERENCES `fide_categoria_producto_tb` (`ID_CATEGORIA_PRODUCTO`),
  CONSTRAINT `fide_producto_tb_ibfk_2` FOREIGN KEY (`ID_UNIDAD_MEDIDA`) REFERENCES `fide_unidad_medida_tb` (`ID_UNIDAD_MEDIDA`),
  CONSTRAINT `fide_producto_tb_ibfk_3` FOREIGN KEY (`ID_ESTADO`) REFERENCES `fide_estado_tb` (`ID_ESTADO`)
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fide_producto_tb`
--

LOCK TABLES `fide_producto_tb` WRITE;
/*!40000 ALTER TABLE `fide_producto_tb` DISABLE KEYS */;
INSERT INTO `fide_producto_tb` VALUES (1,'ATORVASTATINA 20 MG TABLETA','110010204',135.75,1,1,1),(2,'ENALAPRIL 10 MG TABLETA','110010205',52.30,1,1,1),(3,'FUROSEMIDA 40 MG TABLETA','110010206',25.00,1,1,1),(4,'PREDNISONA 5 MG TABLETA','110010207',33.00,10,1,1),(5,'CLORFENAMINA 4 MG TABLETA','110010208',19.50,6,1,1),(6,'DICLOFENACO 50 MG TABLETA','110010209',27.75,4,1,1),(7,'NAPROXENO 500 MG TABLETA','110010210',41.20,4,1,1),(8,'RANITIDINA 150 MG TABLETA','110010211',60.00,5,1,1),(9,'CIPROFLOXACINO 500 MG TABLETA','110010212',88.50,2,1,1),(10,'CEFALEXINA 500 MG CÁPSULA','110010213',92.30,2,1,1),(11,'ACICLOVIR 400 MG TABLETA','110010214',79.00,2,1,1),(12,'AZITROMICINA 500 MG TABLETA','110010215',160.00,2,1,1),(13,'CLARITROMICINA 500 MG TABLETA','110010216',175.00,2,1,1),(14,'DOXICICLINA 100 MG TABLETA','110010217',67.25,2,1,1),(15,'LEVOTIROXINA 50 MCG TABLETA','110010218',32.00,10,1,1),(16,'GLIBENCLAMIDA 5 MG TABLETA','110010219',29.00,10,1,1),(17,'INSULINA NPH 100 UI/ML FRASCO','110010220',4350.00,10,2,1),(18,'INSULINA REGULAR 100 UI/ML FRASCO','110010221',4200.00,10,2,1),(19,'ASPIRINA 100 MG TABLETA','110010222',23.00,3,1,1),(20,'WARFARINA 5 MG TABLETA','110010223',95.00,1,1,1),(21,'HEPARINA SÓDICA 5000 UI/ML','110010224',2250.00,1,3,1),(22,'METRONIDAZOL 250 MG TABLETA','110010225',55.00,2,1,1),(23,'NISTATINA 100000 UI TABLETA','110010226',61.00,2,1,1),(24,'FLUCONAZOL 150 MG CÁPSULA','110010227',135.00,2,1,1),(25,'KETOCONAZOL 200 MG TABLETA','110010228',115.00,2,1,1),(26,'CLONAZEPAM 0.5 MG TABLETA','110010261',65.00,9,1,1),(27,'DIAZEPAM 10 MG TABLETA','110010262',70.00,9,1,1),(28,'BISACODILO 5 MG TABLETA','110010263',30.00,5,1,1),(29,'LOPERAMIDA 2 MG CÁPSULA','110010264',40.00,5,1,1),(30,'DOMPERIDONA 10 MG TABLETA','110010265',48.00,5,1,1),(31,'ONDANSETRON 4 MG TABLETA','110010266',120.00,5,1,1),(32,'RIVAROXABAN 20 MG TABLETA','110010267',320.00,1,1,1),(33,'APIXABAN 5 MG TABLETA','110010268',290.00,1,1,1),(34,'ENOXAPARINA 40 MG/0.4ML JERINGA','110010269',3850.00,1,4,1),(35,'FENILEFRINA 10 MG TABLETA','110010270',35.00,6,1,1),(36,'PSEUDOEFEDRINA 30 MG TABLETA','110010271',44.00,6,1,1),(37,'OXIMETAZOLINA 0.05% GOTAS NASALES','110010272',120.00,6,5,1),(38,'DEXTROMETORFANO 15 MG/5ML JARABE','110010273',112.00,8,6,1),(39,'BROMEXINA 8 MG/5ML JARABE','110010274',105.00,8,6,1),(40,'AMBROXOL 30 MG/5ML JARABE','110010275',99.00,8,6,1),(41,'CLORURO DE SODIO 0.9% FRASCO','110010276',475.00,10,2,1),(42,'GLUCOSA 5% FRASCO','110010277',510.00,10,2,1),(43,'RINGER LACTATO FRASCO','110010278',490.00,10,2,1),(44,'KETOROLACO 30 MG/ML AMPOLLAS','110010279',185.00,3,3,1),(45,'TRAMADOL 100 MG/ML AMPOLLAS','110010280',220.00,3,3,1),(46,'MORFINA 10 MG/ML AMPOLLAS','110010281',285.00,3,3,1),(47,'FENTANILO 50 MCG/ML AMPOLLAS','110010282',300.00,3,3,1),(48,'NEOMICINA + BACITRACINA UNGÜENTO','110010283',290.00,7,7,1),(49,'HIDROCORTISONA 1% CREMA','110010284',210.00,7,7,1),(50,'BETAMETASONA 0.1% CREMA','110010285',250.00,7,7,1),(51,'CLOTRIMAZOL 1% CREMA','110010286',240.00,7,7,1),(52,'MICONAZOL 2% CREMA','110010287',230.00,7,7,1),(53,'NISTATINA 100,000 UI CREMA','110010288',225.00,7,7,1),(54,'KETOCONAZOL 2% CHAMPÚ','110010289',650.00,7,8,1),(55,'TRETINOÍNA 0.05% CREMA','110010290',800.00,7,7,1),(56,'BENZOIL PERÓXIDO 5% GEL','110010291',475.00,7,7,1),(57,'ACICLOVIR 5% CREMA','110010292',340.00,7,7,1),(58,'NAPROXENO SÓDICO 550 MG TABLETA','110010293',90.00,4,1,1),(59,'IBUPROFENO 400 MG TABLETA','110010306',85.00,3,1,1),(60,'AMOXICILINA 500 MG CÁPSULA','110010307',110.00,2,1,1),(61,'CLARITROMICINA 250 MG TABLETA','110010308',185.00,2,1,1),(62,'ENALAPRIL 5 MG TABLETA','110010309',46.00,4,1,1),(63,'LOSARTÁN 50 MG TABLETA','110010310',58.00,4,1,1),(64,'METFORMINA 850 MG TABLETA','110010311',60.00,5,1,1),(65,'GLICLAZIDA 30 MG TABLETA','110010312',72.00,5,1,1),(66,'LORATADINA 10 MG TABLETA','110010313',42.00,6,1,1),(67,'CETIRIZINA 10 MG TABLETA','110010314',49.00,6,1,1),(68,'OMEPRAZOL 20 MG CÁPSULA','110010315',98.00,7,1,1),(69,'FAMOTIDINA 40 MG TABLETA','110010316',88.00,7,1,1),(70,'SALBUTAMOL SPRAY 100 MCG','110010317',2750.00,8,9,1),(71,'BUDESONIDA 100 MCG INHALADOR','110010318',3600.00,8,17,1),(72,'BETAMETASONA CREMA 0.05%','110010319',270.00,9,8,1),(73,'KETOCONAZOL CREMA 2%','110010320',310.00,9,8,1);
/*!40000 ALTER TABLE `fide_producto_tb` ENABLE KEYS */;
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
  KEY `ID_ESTADO` (`ID_ESTADO`),
  CONSTRAINT `fide_unidad_medida_tb_ibfk_1` FOREIGN KEY (`ID_ESTADO`) REFERENCES `fide_estado_tb` (`ID_ESTADO`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fide_unidad_medida_tb`
--

LOCK TABLES `fide_unidad_medida_tb` WRITE;
/*!40000 ALTER TABLE `fide_unidad_medida_tb` DISABLE KEYS */;
INSERT INTO `fide_unidad_medida_tb` VALUES (1,'Unidad',1),(2,'Tableta',1),(3,'Cápsula',1),(4,'Frasco',1),(5,'Gotas',1),(6,'Ampolla',1),(7,'Sobre',1),(8,'Crema',1),(9,'Gel',1),(10,'Solución',1),(11,'Jarabe',1),(12,'Polvo',1),(13,'Spray',1),(14,'Parche',1),(15,'Supositorio',1),(16,'Enema',1),(17,'Inhalador',1),(18,'Colirio',1),(19,'Inyectable',1),(20,'Comprimido',1),(21,'Emulsión',1),(22,'Suspensión',1),(23,'Óvulo',1),(24,'Loción',1),(25,'Vial',1),(26,'Kit',1),(27,'Implante',1),(28,'Jeringa',1),(29,'Champú',1),(30,'Ungüento',1);
/*!40000 ALTER TABLE `fide_unidad_medida_tb` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `terror`
--

LOCK TABLES `terror` WRITE;
/*!40000 ALTER TABLE `terror` DISABLE KEYS */;
INSERT INTO `terror` VALUES (1,'Duplicate entry \'josue13398\' for key \'USUARIO\'','2025-07-06 13:22:27'),(2,'Duplicate entry \'abraham\' for key \'USUARIO\'','2025-07-06 13:22:53'),(3,'Duplicate entry \'abrahamprue\' for key \'USUARIO\'','2025-07-06 13:24:13'),(4,'Duplicate entry \'abrahamprue\' for key \'USUARIO\'','2025-07-06 13:30:58'),(5,'Duplicate entry \'abrahamprue\' for key \'USUARIO\'','2025-07-06 13:31:00'),(6,'Duplicate entry \'josue13398\' for key \'USUARIO\'','2025-07-06 13:41:33'),(7,'Duplicate entry \'josue13398\' for key \'USUARIO\'','2025-07-06 13:45:36'),(8,'Duplicate entry \'josue13398\' for key \'USUARIO\'','2025-07-06 13:45:52'),(9,'Duplicate entry \'josue13398\' for key \'USUARIO\'','2025-07-06 13:46:53'),(10,'Duplicate entry \'josue13398\' for key \'USUARIO\'','2025-07-06 13:48:25'),(11,'Duplicate entry \'josue13398\' for key \'USUARIO\'','2025-07-06 13:48:31');
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
  KEY `ID_ESTADO` (`ID_ESTADO`),
  CONSTRAINT `tipo_alerta_ibfk_1` FOREIGN KEY (`ID_ESTADO`) REFERENCES `fide_estado_tb` (`ID_ESTADO`)
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
  PRIMARY KEY (`ID`),
  UNIQUE KEY `USUARIO` (`USUARIO`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (1,'Josue','josue@email.com','josue','$2y$10$Is2EkNLcar14RX5pGv9pLOQ7awuLIM.J6me350nvgpZNEi78Eli9y'),(2,'Abraham','abraham@email.com','abraham','$2a$10$xaaReEFEh8.ulnY5QIKwFeTnaWcLmY7Zc128wdKq3jcOjcer1Sf92'),(3,'josue','josue13398@icloud.com','josue13398','123'),(6,'abraha','abraham@icloud.com','abrahamprue','123'),(10,'otro ','prueba@email.com','prueba','123'),(11,'otro ','cccc@email.com','cccccc','123'),(13,'yayaay','yayaya@icloud.com','yayaya','123'),(14,'','','','');
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
  KEY `ROL_ID` (`ROL_ID`),
  CONSTRAINT `usuario_rol_ibfk_1` FOREIGN KEY (`USUARIO_ID`) REFERENCES `usuario` (`ID`) ON DELETE CASCADE,
  CONSTRAINT `usuario_rol_ibfk_2` FOREIGN KEY (`ROL_ID`) REFERENCES `rol` (`ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario_rol`
--

LOCK TABLES `usuario_rol` WRITE;
/*!40000 ALTER TABLE `usuario_rol` DISABLE KEYS */;
INSERT INTO `usuario_rol` VALUES (1,2);
/*!40000 ALTER TABLE `usuario_rol` ENABLE KEYS */;
UNLOCK TABLES;

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
CREATE DEFINER=`root`@`localhost` PROCEDURE `ActualizarContrasenna`(pIdUsuario bigint(11),
     pContrasenna varchar(10))
BEGIN

	UPDATE 	USUARIO
	SET 	CONTRASENA = pContrasenna
    WHERE 	ID = pIdUsuario;

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
    IN p_usuario VARCHAR(50),
    IN p_cedula VARCHAR(20),
    IN p_telefono VARCHAR(20),
    IN p_direccion VARCHAR(255),
    IN p_fecha_nacimiento DATE,
    IN p_sexo VARCHAR(10),
    IN p_alergias TEXT
)
BEGIN
    DECLARE v_usuario_id BIGINT;
    DECLARE v_rol_cliente_id BIGINT DEFAULT 1;
    DECLARE v_rol_admin_id BIGINT DEFAULT 2;
    DECLARE v_existente INT;

    SELECT COUNT(*) INTO v_existente
    FROM USUARIO
    WHERE USUARIO = p_usuario;

    IF v_existente = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El usuario no existe.';
    END IF;

    SELECT ID INTO v_usuario_id
    FROM USUARIO
    WHERE USUARIO = p_usuario;

    SELECT COUNT(*) INTO v_existente
    FROM USUARIO_ROL
    WHERE USUARIO_ID = v_usuario_id AND ROL_ID = v_rol_admin_id;

    IF v_existente > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El usuario tiene rol ADMIN. No puede convertirse en CLIENTE.';
    END IF;

    SELECT COUNT(*) INTO v_existente
    FROM USUARIO_ROL
    WHERE USUARIO_ID = v_usuario_id AND ROL_ID = v_rol_cliente_id;

    IF v_existente = 0 THEN
        INSERT INTO USUARIO_ROL (USUARIO_ID, ROL_ID)
        VALUES (v_usuario_id, v_rol_cliente_id);
    END IF;

    SELECT COUNT(*) INTO v_existente
    FROM CLIENTE
    WHERE ID_USUARIO = v_usuario_id;

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
            v_usuario_id,
            p_cedula,
            p_telefono,
            p_direccion,
            p_fecha_nacimiento,
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
    SELECT NOMBRE
           ID
    FROM   USUARIO
    WHERE  CORREO = pcorreo;
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
        ID,
        NOMBRE,
        CORREO,
        USUARIO,
        CONTRASENA
    FROM USUARIO
    WHERE CORREO = pcorreo
      AND CONTRASENA = pcontrasena;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-07-06 13:52:03
