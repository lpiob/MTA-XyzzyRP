-- MySQL dump 10.13  Distrib 5.5.28, for debian-linux-gnu (i686)
--
-- Host: localhost    Database: xyzzyrp
-- ------------------------------------------------------
-- Server version	5.5.28-0ubuntu0.12.04.2

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `lss_accesslog`
--

DROP TABLE IF EXISTS `lss_accesslog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lss_accesslog` (
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serial` char(32) CHARACTER SET ascii NOT NULL,
  `ip` int(10) unsigned NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`serial`,`user_id`),
  KEY `ts_playerid` (`ts`,`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lss_accesslog`
--

LOCK TABLES `lss_accesslog` WRITE;
/*!40000 ALTER TABLE `lss_accesslog` DISABLE KEYS */;
/*!40000 ALTER TABLE `lss_accesslog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lss_achievements_history`
--

DROP TABLE IF EXISTS `lss_achievements_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lss_achievements_history` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `achname` varchar(64) NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `character_id` int(10) unsigned NOT NULL,
  `amount` int(11) NOT NULL DEFAULT '0',
  `given_by` int(10) unsigned DEFAULT NULL,
  `notes` text CHARACTER SET utf8,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lss_achievements_history`
--

LOCK TABLES `lss_achievements_history` WRITE;
/*!40000 ALTER TABLE `lss_achievements_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `lss_achievements_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lss_achievements_name`
--

DROP TABLE IF EXISTS `lss_achievements_name`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lss_achievements_name` (
  `achname` varchar(64) NOT NULL,
  `descr` text CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`achname`),
  UNIQUE KEY `achname` (`achname`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lss_achievements_name`
--

LOCK TABLES `lss_achievements_name` WRITE;
/*!40000 ALTER TABLE `lss_achievements_name` DISABLE KEYS */;
INSERT INTO `lss_achievements_name` VALUES ('GP','Punkty nadane przez support'),('orgporzadk','Chronić i służyć! Od dziś to Twoje motto, jesteś w organizacji porządkowej, pamiętaj o tym i miej to głęboko w sercu.'),('rower','Rowerzysto, uważaj! Wypożyczyłeś rower, wsiadaj na niego i udaj się gdziekolwiek...');
/*!40000 ALTER TABLE `lss_achievements_name` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lss_aktualnosci`
--

DROP TABLE IF EXISTS `lss_aktualnosci`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lss_aktualnosci` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `opis` text CHARACTER SET utf8,
  `autor` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lss_aktualnosci`
--

LOCK TABLES `lss_aktualnosci` WRITE;
/*!40000 ALTER TABLE `lss_aktualnosci` DISABLE KEYS */;
/*!40000 ALTER TABLE `lss_aktualnosci` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lss_bany`
--

DROP TABLE IF EXISTS `lss_bany`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lss_bany` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'nie wypelniac',
  `id_user` int(10) unsigned DEFAULT NULL COMMENT 'id konta z tabeli lss_users (opcjonalnie)',
  `serial` char(32) CHARACTER SET ascii DEFAULT NULL COMMENT 'banowany serial (opcjonalnie)',
  `date_from` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'od daty',
  `date_to` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'do daty',
  `reason` varchar(64) NOT NULL COMMENT 'powod widoczny dla zbanowanego',
  `notes` varchar(255) DEFAULT NULL COMMENT 'uwagi widoczne dla administracji',
  `banned_by` int(10) unsigned NOT NULL COMMENT 'zbanowane przez (id konta z tabeli lss_users)',
  PRIMARY KEY (`id`),
  KEY `i1` (`id_user`,`serial`,`date_to`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lss_bany`
--

LOCK TABLES `lss_bany` WRITE;
/*!40000 ALTER TABLE `lss_bany` DISABLE KEYS */;
/*!40000 ALTER TABLE `lss_bany` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lss_blocked_registrations`
--

DROP TABLE IF EXISTS `lss_blocked_registrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lss_blocked_registrations` (
  `ip` int(10) unsigned NOT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ip`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lss_blocked_registrations`
--

LOCK TABLES `lss_blocked_registrations` WRITE;
/*!40000 ALTER TABLE `lss_blocked_registrations` DISABLE KEYS */;
/*!40000 ALTER TABLE `lss_blocked_registrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lss_budynki`
--

DROP TABLE IF EXISTS `lss_budynki`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lss_budynki` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `descr` varchar(64) CHARACTER SET utf8 NOT NULL,
  `descr2` varchar(512) CHARACTER SET utf8 DEFAULT NULL,
  `drzwi` varchar(32) NOT NULL,
  `punkt_wyjscia` varchar(64) NOT NULL,
  `interiorid` int(10) unsigned NOT NULL,
  `zamkniety` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `koszt` mediumint(8) unsigned NOT NULL,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `paidTo` date DEFAULT NULL,
  `entryCost` smallint(5) unsigned NOT NULL DEFAULT '0',
  `linkedContainer` int(10) unsigned DEFAULT NULL COMMENT 'pojemnik z lss_containers, ktory jest polaczony z budynkiem - do niego trafia oplaty',
  `owning_faction` int(10) unsigned DEFAULT NULL COMMENT 'frakcja ktora jest wlascicielem budynku (opcjonalne)',
  `type` smallint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lss_budynki`
--

LOCK TABLES `lss_budynki` WRITE;
/*!40000 ALTER TABLE `lss_budynki` DISABLE KEYS */;
INSERT INTO `lss_budynki` VALUES (1,'(( Sklep \'na rogu\' ))','                 ZAPRASZAMY\n','2424.24,-1742.78,13.55','2422.71,-1741.01,13.55, 45',163,0,150,'2013-08-14 21:19:27','2013-09-25',1,893,NULL,0),(2,'(( Siłownia w dzielnicy Ganton ))','[Na drzwiach jest tabliczka] Lokal do wynajęcia: szczegóły w Urzędzie Miasta.','2229.95,-1721.30,13.56','2227.98,-1723.69,13.55,137.3',164,1,200,'2013-06-04 08:02:04','2222-01-01',10,899,NULL,0),(6,'(( Siłownia w dzielnicy Grove Street ))','Zapraszamy\n','2431.06,-1669.65,13.55','2430.90,-1667.82,13.54,6.1',140,0,200,'2013-08-06 13:50:42','2013-08-20',0,896,NULL,0),(4,'(( Sklep Spożywczy \'Strug\' ))','\n','1352.43,-1759.25,13.51','1352.44,-1754.85,13.36, 0',162,0,200,'2013-06-30 22:07:01','2013-09-02',10,895,NULL,0),(83,'(( Klub \'Eden\' ))','[Na drzwiach jest tabliczka] EDEN - NAJLEPSZA MUZYKA, NAJLEPSZY ALKOHOL, MIŁA ATMOSFERA - EDEN!\n','943.34,-1742.68,13.55','938.68,-1745.39,13.55, 101',219,0,200,'2013-07-27 12:08:50','2013-09-03',10,3414,NULL,0),(5,'(( Klub \'Cafe\' ))','[Na drzwiach jest tabliczka] Klubokawiarnia \"Cafe\" - Zapraszamy!\n\n','1019.41,-1374.26,14.65','1015.52,-1374.26,13.36,90.9',139,1,250,'2013-08-12 07:31:25','2222-01-01',20,275,NULL,0),(7,'(( Knajpka \'na molo\' ))','[Na drzwiach jest tabliczka] Lokal do wynajęcia: szczegóły w Urzędzie Miasta.','364.61,-2051.76,8.02','369.92,-2051.43,8.02, 270',161,1,150,'2013-05-01 16:52:31','2222-01-01',0,1146,NULL,0),(9,'(( Restauracja \'The Well Stacked Pizza\' ))','Zapraszam! Najlepsza pizzeria w mieście!\n**Obiek monitorwany 24/7**\n','2105.39,-1806.51,13.55','2102.63,-1806.36,13.55, 90',141,0,150,'2013-08-08 11:01:46','2013-08-20',10,581,NULL,0),(10,'(( Import pojazdów ))','Zamówienia przyjmujemy w każdy wtorek w godzinach 17:00-18:00\r\n\r\nOdbiór pojazdów w każdy czwartek w godzinach 17:00-18:00\n','2421.41,-2678.19,13.66','2417.81,-2678.13,13.66, 90',143,0,0,'2013-05-29 15:43:40','4444-04-04',0,525,1,0),(11,'(( Komis samochodowy \'Angelo\' ))','**Na tabliczce niema danych właściciela.**\n\nCzekamy na zamówienia!\n','2335.88,-1215.03,22.66','2335.85,-1218.05,22.66, 180',142,0,250,'2013-08-14 14:27:54','2013-09-12',0,530,NULL,0),(12,'(( Ośrodek Szkolenia Kierowców nr II ))','OSK II znów pracuje, zapraszamy dso rekrutacji która odbędzie się dnia 13 sierpnia o pietnastej.\n\nZEBRANIE DZIŚ O 15:00\n','1035.15,-944.94,42.71','1035.49,-947.15,42.71, 180',145,0,200,'2013-08-14 13:49:16','2013-08-19',10,369,NULL,0),(13,'(( Klub \'The Pig Pen\' ))','**Na ścianach budynku pełno naklejek z nagimi tancerkami, natomiast na drzwiach napis świetlny \"OPEN\"**\n','2421.53,-1219.25,25.56','2421.38,-1220.32,25.49,178.7',146,1,200,'2013-07-25 16:10:07','2222-01-01',30,894,NULL,0),(14,'(( Restauracja Hot-Food ))','[Na drzwiach jest tabliczka] Lokal do wynajęcia: szczegóły w Urzędzie Miasta.','2381.86,-1906.84,13.55','2379.07,-1906.84,13.38, 90',147,1,150,'2013-05-01 16:53:44','2222-01-01',0,897,NULL,0),(18,'(( Warsztat II ))','[Na drzwiach jest tabliczka] Własność Urzędu Miasta','677.69,-123.82,25.43','677.45,-126.10,25.43, 180',151,1,300,'2013-05-31 13:03:52','2222-01-01',0,248,NULL,0),(15,'(( Komis samochodowy \'Titanic\' ))','            ** Obiekt monitorowany 24/7. **\r\n** Na drzwiach jest tabliczka. **\r\n\r\n                       Zapraszamy!\r\n\r\nZachęcamy do składania zamówień w naszym komisie,\n       \rtylko u nas znajdziesz tak atrakcyjne ceny!\r\n\r\nJedyny w mieście zaufany przez klientów komis samochodowy Titanic!\r\n\r\n                    Godziny otwarcia:\r\n\r\n• Poniedziałek: 08:30 - 16:00\r\n• Wtorek: 09:30 - 15:00\r\n• Środa: 11:00 - 14:00\r\n• Czwartek: 09:00 - 19:00\r\n• Piątek: 10:00 - 14:00\r\n• Sobota: 10:30 - 14:00\n','2131.81,-1151.26,24.07','2131.85,-1147.92,24.43, 0',148,0,250,'2013-08-11 09:32:18','2013-08-30',10,92,NULL,0),(16,'(( Ośrodek Szkolenia Kierowców nr I ))','Ośrodek Szkolenia Kierowców.\n\nKontakt Sweety: 44508 \n','1044.20,-1291.42,13.78','1045.64,-1291.41,13.55, 270',149,0,200,'2013-08-06 11:04:38','2013-08-27',10,194,NULL,0),(17,'(( Firma kurierska ))','\n','649.13,-1357.28,13.57','647.34,-1357.23,13.58, 90',150,0,250,'2013-08-16 15:37:04','2013-09-02',30,106,NULL,0),(20,'(( Warsztat I ))','Przepraszam, że opłata za wejście jest tak duża, ale jak każdy wie opłaty czynszu są zbyt drogię. ((Wy tak naprawdę zarabiacie dużo, a ja nie pobieram od was zaliczek tygodniowych, dlatego zamiast tego będzie to))\n','1928.66,-1776.35,13.55','1930.46,-1776.27,13.55, 270',153,1,350,'2013-08-12 07:32:17','2222-01-01',50,1950,NULL,0),(19,'(( Warsztat III ))','**Obiekt monitorowany 24/7, na całym obszarze warsztatu zamontowany alarm, w budynkach zraszacze**\nTelefon do właściciela: 98140\n','2284.47,-118.79,26.50','2284.44,-120.34,26.50, 180',152,1,300,'2013-07-29 09:10:17','2222-01-01',15,660,NULL,0),(21,'(( Baza Taxi ))',NULL,'1111.92,-1795.55,16.59','1109.90,-1795.50,16.59, 90',154,0,0,'2013-05-01 12:38:38','4444-01-01',0,197,1,0),(22,'(( Ośrodek Ochrony Cywilnej ))','[Na drzwiach jest tabliczka] Ochrona Cywilna \"LSSG\"\n','2177.09,-1770.50,13.54','2178.83,-1770.53,13.54, 270',155,0,200,'2013-08-17 13:45:52','2013-08-20',25,478,NULL,0),(23,'(( Warsztat IV ))','**Na drzwiach jest tabliczka**\nWarsztat Mongomery.\n\n**Biuro ma antywłamaniowe zamki, cały warsztat jest monitorowany 24/7.**\n','1208.80,245.18,19.62','1206.97,245.99,19.62, 63',156,0,300,'2013-08-16 18:13:43','2013-08-27',15,696,NULL,0),(24,'(( Warsztat V ))','[Na drzwiach jest tabliczka] Witamy w Warsztacie!\nKamery 24/7\nKontakt z właścicielem: \nCasper Smith - tel 98140\nDrake Hunt \n','94.88,-153.56,1.62','94.97,-156.12,1.62, 180',157,0,300,'2013-08-13 11:56:49','2013-08-26',25,701,NULL,0),(36,'(( Hotel \'Burza\' ))','[Na drzwiach jest tabliczka] Lokal do wynajęcia: szczegóły w Urzędzie Miasta.','1569.49,-1198.89,19.79','1569.36,-1202.91,19.84, 180',208,1,150,'2013-05-01 16:55:14','2222-01-01',0,3246,NULL,0),(26,'(( Klub \'Silver Club\' ))','**Zapraszamy Wszystkich**\n\n','1720.31,-1741.17,13.55','1720.70,-1738.79,13.55, 0',159,0,250,'2013-08-16 12:54:20','2013-08-24',10,898,NULL,0),(27,'(( Stadion ))','\n','2724.64,-1825.88,11.84','2719.38,-1827.20,11.84, 115',158,0,0,'2013-08-17 17:48:24','4444-01-01',0,NULL,1,0),(66,'(( Ośrodek Szkoleniowy ))',NULL,'1488.43,-58.40,27.24','1485.00,-61.55,27.24, 133',203,0,0,'2013-05-01 12:37:42','4444-01-01',0,NULL,NULL,0),(44,'(( Biuro ))','[Na drzwiach jest tabliczka] Lokal do wynajęcia: szczegóły w Urzędzie Miasta.','1163.62,-1690.49,14.17','1161.79,-1690.23,14.18,81.9',180,1,0,'2013-05-01 11:20:27','2222-01-01',0,1883,NULL,0),(28,'(( Komis samochodowy \'Smiling Central\'))',' Kontakt z właścicielem Komisu: 70927\n','542.20,-1293.90,17.24','542.20,-1291.75,17.24, 0',160,0,250,'2013-07-27 12:08:53','2013-09-06',0,889,NULL,0),(37,'(( Komis samochodowy \'Sunset Beach\' ))','----------# Sunset Beach #----------\r\n* Sprzedawcy:\nJohn Bakker, Jack Fox, Jack Salo\n\nDostawca: \nTravis Lorriane\n\r\nStrona inernetowa komisu: \n(( http://lss-rp.pl/forum/258-sunset-beach ))\n\nJeżeli wyrażasz chęć zakupu umów się na spotkanie przez kontakt telefoniczny 87381 (( PW ))\n','2444.72,110.97,26.48','2447.98,111.09,26.48, 270',172,0,250,'2013-08-08 12:15:30','2013-08-23',0,1251,NULL,0),(29,'(( Lodziarnia ))','[Na drzwiach jest tabliczka] Lokal do wynajęcia: szczegóły w Urzędzie Miasta.','2751.89,-1468.31,30.45','2749.85,-1468.32,30.45, 90',165,1,150,'2013-05-01 16:55:55','2222-01-01',0,2121,NULL,0),(34,'(( Siłownia w dzielnicy Richman ))','[Na drzwiach jest tabliczka] Lokal do wynajęcia: szczegóły w Urzędzie Miasta.','776.48,-1036.26,24.28','777.03,-1038.78,24.26, 190',170,1,200,'2013-05-01 16:56:29','2222-01-01',0,1169,NULL,0),(31,'(( Market \'Prima\' ))','[Na drzwiach jest tabliczka] Lokal do wynajęcia: szczegóły w Urzędzie Miasta.','2273.76,82.14,26.48','2273.82,85.37,26.48, 0',167,1,100,'2013-05-01 16:57:01','2222-01-01',0,2123,NULL,0),(32,'(( Biblioteka \'u Greka\' ))','[Na drzwiach jest tabliczka] Lokal do wynajęcia: szczegóły w Urzędzie Miasta.','2562.73,-1461.51,24.01','2560.30,-1461.61,23.99, 90',168,1,100,'2013-05-01 16:57:07','2222-01-01',0,1070,NULL,0),(33,'(( Market \'Super Sam\' ))','                  ZAPRASZAMY\n\n','243.11,-178.41,1.58','240.68,-178.41,1.58, 90',169,1,100,'2013-06-28 07:54:08','2222-01-01',0,2122,NULL,0),(35,'(( Siłownia w Montgomery ))','[Na drzwiach jest tabliczka] Lokal do wynajęcia: szczegóły w Urzędzie Miasta.','1309.67,382.09,19.56','1308.74,380.00,19.56, 155',171,1,150,'2013-05-01 16:57:18','2222-01-01',0,1170,NULL,0),(38,'(( Komis samochodowy \'Nemo\' ))','**Na tabliczce widnieje informacja**\n\nGODZINY OTWARCIA:\n\n#Od poniedziałku do piątku 9:00 - 19:00\n\n\nWłaściciele:\n\nKornel Sobala - 43384\nMarcell Szyszkewicz - 46356\n\nZapraszamy na naszą stronę internetową do zamawiania pojazdów lub zadzwonić do jednego z właścicieli.\n\nPojazdy do odbioru stoją za budynkiem.\n','321.10,-44.63,1.57','321.10,-47.09,1.57, 180',173,0,250,'2013-08-06 17:37:51','2013-09-03',0,1252,NULL,0),(40,'(( Magazyn w Blueberry ))','Lokal nieczynny.\n','279.86,-221.49,1.58','279.62,-220.03,1.58,358.0',112,1,5000,'2013-05-01 11:24:20','2222-01-01',0,1740,NULL,0),(39,'(( Kawiarnia \'pod sceną\' ))','[Nad drzwiami duży neon niebieski z napisem] Kawiarnia \'pod sceną\' \n\n  ..: ZAPRASZAMY WSZYSTKICH :..\n','675.10,-1867.17,5.46','671.68,-1864.48,5.45, 90',174,0,150,'2013-08-14 19:27:06','2013-09-02',5,1428,NULL,0),(45,'(( Biuro kolonii karnej ))',NULL,'2703.61,-2530.58,17.64','2704.18,-2529.12,17.64,358.0',182,1,0,'2013-05-06 12:44:25','4444-04-04',0,NULL,1,0),(53,'(( Szpital ))',NULL,'2031.23,-1400.35,13.53','2031.24,-1403.22,13.53, 180',190,0,0,'2013-05-01 11:25:18','4444-04-04',0,NULL,1,0),(42,'(( Biuro ))','[Na drzwiach jest tabliczka] Lokal do wynajęcia: szczegóły w Urzędzie Miasta.','1794.60,-1720.86,13.54','1794.47,-1722.74,13.55,184.5',176,1,0,'2013-05-01 11:25:40','2222-01-01',0,1820,NULL,0),(48,'(( Przychodnia lekarska ))','[Na drzwiach jest tabliczka] Lokal do wynajęcia: szczegóły w Urzędzie Miasta.','2247.99,117.89,26.48','2251.00,117.89,26.48, 270',185,1,150,'2013-05-01 16:57:50','2222-01-01',0,1960,NULL,0),(52,'(( Komisariat Policji ))',NULL,'1555.50,-1675.63,16.20','1552.37,-1675.69,16.20, 90',189,0,0,'2013-05-01 12:35:13','4444-04-04',0,NULL,1,0),(50,'(( Parafia Los Santos ))','Kościół Parafii Los Santos\n','286.32,-1799.27,5.33','290.44,-1799.38,4.43, 270',187,0,0,'2013-05-04 16:35:03','4444-01-01',0,NULL,21,0),(41,'(( Biuro detektywistyczne ))','[Na drzwiach jest tabliczka]Biuro Detektywistyczne rekrutuje zapraszamy do pisania podań\n((FORUM))\n\nKontakt\nPatrick Perez-94486\n\n','2269.69,-74.23,26.77','2269.75,-76.82,26.59, 180',175,1,150,'2013-08-01 07:17:48','2222-01-01',10,1797,NULL,0),(47,'(( Hala do paintballa ))','[Na drzwiach jest tabliczka] Lokal do wynajęcia: szczegóły w Urzędzie Miasta.','2553.20,-2410.48,13.63','2555.62,-2408.13,13.63, 315',184,1,200,'2013-05-01 16:58:01','2222-01-01',0,1946,NULL,0),(61,'(( Rudera rozrywki ))','[Na drzwiach jest tabliczka] Lokal do wynajęcia: szczegóły w Urzędzie Miasta.\n','2354.46,-1511.61,24.00','2352.73,-1513.32,24.00, 135',198,0,200,'2013-08-16 21:08:28','2013-08-26',10,2295,NULL,0),(49,'(( Oddział Policji C.R.A.S.H / S.W.A.T ))',NULL,'1234.15,-1449.37,13.55','1237.67,-1449.47,13.55, 270',186,0,0,'2013-05-01 12:38:33','4444-01-01',0,NULL,1,0),(43,'(( Dom pogrzebowy ))',NULL,'940.69,-1085.28,24.30','936.38,-1086.77,24.29, 90',179,0,0,'2013-05-01 12:38:31','4444-01-01',0,1824,NULL,0),(60,'(( Klub \'Fantasia\' ))','                 ** Obiekt monitorowany 24/7. **\r\n** Na drzwiach jest tabliczka. **\r\n\r\n                     - CLUB FANTASIA - \r\n\r\nDOBRA MUZYKA, DOBRY ALKOHOL/SOKI, DOBRY DJ, \r\n                      MIŁA ATMOSFERA!\r\n\r\n\r\nJedyny taki CLUB w mieście!\n','1046.95,-1419.08,13.55','1048.88,-1417.16,13.55, 315',197,0,250,'2013-08-10 11:24:17','2013-08-29',10,2294,NULL,0),(51,'(( Urząd Miasta ))',NULL,'1481.23,-1772.16,11118.80','1481.21,-1768.31,11118.80, 0',188,0,0,'2013-05-01 11:28:57','4444-04-04',0,NULL,1,0),(63,'(( Ośrodek Szkolenia Pilotów ))','[Na drzwiach jest tabliczka] Lokal do wynajęcia: szczegóły w Urzędzie Miasta.','1451.51,-2287.10,13.55','1448.13,-2287.25,13.55, 90',200,1,15000,'2013-05-01 11:29:09','2222-01-01',0,2526,NULL,0),(54,'(( Straż Pożarna ))',NULL,'907.09,-1256.74,15.60','907.18,-1253.60,15.61, 0',191,0,0,'2013-05-01 11:29:25','4444-04-04',0,NULL,1,0),(55,'(( Biuro Służb Miejskich ))',NULL,'803.68,-514.28,16.33','803.75,-517.24,16.33, 180',192,0,0,'2013-05-01 11:29:42','4444-04-04',0,NULL,1,0),(56,'(( Redakcja CNN News ))',NULL,'443.33,-1125.80,92.56','443.30,-1122.61,92.55, 0',193,0,0,'2013-05-01 11:29:57','4444-04-04',0,NULL,1,0),(57,'(( Biuro górników ))',NULL,'1058.05,-358.66,74.44','1056.95,-361.49,74.44, 180',194,1,0,'2013-05-01 11:30:11','4444-04-04',0,NULL,1,0),(58,'(( Sąd ))',NULL,'1382.14,-1088.83,28.20','1379.88,-1088.64,27.39, 90',195,0,0,'2013-05-01 11:30:23','4444-04-04',0,NULL,1,0),(59,'(( Knajpa \'Paszcza Wieloryba\' ))','[Na drzwiach jest tabliczka] Lokal do wynajęcia: szczegóły w Urzędzie Miasta.','1367.45,248.33,19.57','1365.00,249.32,19.57, 68',196,1,100,'2013-05-01 16:58:07','2222-01-01',0,2265,NULL,0),(62,'(( Punkt garażowy ))','[Na drzwiach jest tabliczka] Lokal do wynajęcia: szczegóły w Urzędzie Miasta.','3053.03,-858.80,12.56','3056.87,-858.92,12.56, 270',199,1,250,'2013-05-01 16:58:13','2222-01-01',0,NULL,NULL,0),(64,'(( Biuro tartaku ))',NULL,'-463.82,-37.80,59.95','-463.71,-40.83,59.95, 180',201,1,150,'2013-05-01 16:58:19','2222-01-01',0,2463,NULL,0),(67,'(( Salon tatuażu ))','[Na drzwiach jest tabliczka] Lokal do wynajęcia: szczegóły w Urzędzie Miasta.','2081.39,-1204.20,23.93','2077.97,-1204.28,23.93, 90',204,1,200,'2013-05-01 16:58:28','2222-01-01',0,3195,NULL,0),(68,'(( Departament Turystyki i Rekreacji ))',NULL,'2792.88,-1087.67,30.72','2797.27,-1087.68,30.72, 271',205,0,0,'2013-05-22 09:30:25','4444-01-01',0,NULL,1,0),(69,'(( Knajpa \'Isaura\' ))','Lokal Otwarty.Zapraszam serdecznie.\n','512.01,-1487.08,14.51','514.89,-1487.16,14.50, 270',206,0,150,'2013-08-14 15:41:14','2013-09-05',10,3224,NULL,0),(70,'(( Market \'Łubin\' ))','[Na drzwiach jest tabliczka] Lokal do wynajęcia: szczegóły w Urzędzie Miasta.','1830.28,-1172.17,24.27','1830.26,-1175.20,23.83, 180',207,1,150,'2013-07-07 22:22:16','2222-01-01',0,3223,NULL,0),(74,'(( Bar \'Purple-Pub\' ))','[Na drzwiach jest tabliczka] Lokal do wynajęcia: szczegóły w Urzędzie Miasta.','2480.99,-1536.79,24.17','2484.50,-1536.78,24.00, 270',212,1,150,'2013-05-01 16:58:43','2222-01-01',0,3272,NULL,0),(71,'(( Hotel \'Carrington\' ))','[Na drzwiach jest tabliczka] Lokal do wynajęcia: szczegóły w Urzędzie Miasta.','606.72,-1458.87,14.39','612.10,-1458.94,14.39, 270',209,1,200,'2013-05-01 16:58:52','2222-01-01',0,3247,NULL,0),(72,'(( Hotel \'Forrester\' ))','[Na drzwiach jest tabliczka]\nHotel \'Forrester\' - sześciogwiazdkowy. \n**Nad wejściem sześć gwiazdek**\nObiekt monitorowany, ochrona w środku, 24/7.\nTanie, wysokiej klasy pokoje.\nSPA, Restauracja, Sala konferencyjna, Mozliwosc transportu VIP limuzyną.\nW celu zamówienia pokoju/ochrony telefon 98140\nZapraszamy do środka!\n','1498.42,-1581.21,13.55','1498.40,-1585.04,13.55, 180',210,0,250,'2013-08-05 15:20:25','2013-08-22',25,3248,NULL,0),(73,'(( Hotel \'Martwa Cisza\' ))','[Na drzwiach jest tabliczka] Lokal do wynajęcia: szczegóły w Urzędzie Miasta.','1373.76,405.03,19.96','1370.75,406.50,19.76, 68',211,1,150,'2013-05-01 16:59:08','2222-01-01',0,3249,NULL,0),(79,'(( Restauracja \'przy skarpie\' ))','Restauracja \'Przy skarpie\' zaprasza na pyszne i tanie posiłki.\n\nPersonel restauracji.\n','1568.15,-1897.75,13.56','1567.95,-1892.14,13.56, 0',215,0,200,'2013-08-17 08:19:46','2013-08-30',10,3325,NULL,0),(77,'(( Odzieżowy \'The Exclusive Clothing\' ))','[Na drzwiach jest tabliczka] Lokal do wynajęcia: szczegóły w Urzędzie Miasta.','478.31,-1536.56,19.55','481.72,-1535.37,19.55, 291',213,1,200,'2013-06-17 07:03:38','2222-01-01',5,3273,NULL,1),(78,'(( Bar \'Corona Billard Pub\' ))','[Na drzwiach jest tabliczka] Lokal do wynajęcia: szczegóły w Urzędzie Miasta.','1945.15,-2043.00,14.09','1945.14,-2046.08,13.55, 180',214,1,250,'2013-06-04 08:05:40','2222-01-01',25,3274,NULL,0),(80,'(( Odzieżowy \'Anastacia\' ))','[Na drzwiach jest tabliczka] Lokal do wynajęcia: szczegóły w Urzędzie Miasta.','457.84,-1330.98,15.32','455.72,-1327.66,15.32, 32',216,1,200,'2013-05-06 15:00:13','2222-01-01',0,3407,NULL,1),(81,'(( Odzieżowy \'Mustang Jeans\' ))','Najlepsze ciuchy w mieście! Wejdź i sprawdź!\n','1699.49,-1667.85,20.20','1695.57,-1667.78,20.20, 90',217,0,400,'2013-08-06 11:04:40','2013-08-28',0,3408,NULL,1),(82,'(( Knajpa \'Diabelski młyn\' ))','Knajpka zaprasza.\n','1654.15,-1654.85,22.52','1654.05,-1659.10,22.52, 180',218,0,200,'2013-08-06 13:50:43','2013-08-20',0,3409,NULL,0);
/*!40000 ALTER TABLE `lss_budynki` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lss_budynki_npc`
--

DROP TABLE IF EXISTS `lss_budynki_npc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lss_budynki_npc` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `budynek_id` int(10) unsigned NOT NULL COMMENT 'id z tabeli lss_budynki',
  `skin` smallint(3) unsigned NOT NULL DEFAULT '0',
  `interior` int(10) unsigned NOT NULL DEFAULT '0',
  `dimension` int(10) unsigned NOT NULL DEFAULT '0',
  `x` double NOT NULL,
  `y` double NOT NULL,
  `z` double NOT NULL,
  `a` double NOT NULL,
  `container_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `biznes_id` (`budynek_id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lss_budynki_npc`
--

LOCK TABLES `lss_budynki_npc` WRITE;
/*!40000 ALTER TABLE `lss_budynki_npc` DISABLE KEYS */;
/*!40000 ALTER TABLE `lss_budynki_npc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lss_budynki_oferta`
--

DROP TABLE IF EXISTS `lss_budynki_oferta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lss_budynki_oferta` (
  `container_id` int(10) unsigned NOT NULL,
  `itemid` int(10) unsigned NOT NULL,
  `subtype` int(11) NOT NULL DEFAULT '0',
  `buyprice` int(10) unsigned DEFAULT NULL,
  `sellprice` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`container_id`,`itemid`,`subtype`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lss_budynki_oferta`
--

LOCK TABLES `lss_budynki_oferta` WRITE;
/*!40000 ALTER TABLE `lss_budynki_oferta` DISABLE KEYS */;
/*!40000 ALTER TABLE `lss_budynki_oferta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lss_budynki_owners`
--

DROP TABLE IF EXISTS `lss_budynki_owners`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lss_budynki_owners` (
  `budynek_id` int(10) unsigned NOT NULL,
  `character_id` int(10) unsigned NOT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`budynek_id`,`character_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='tymczasowa tabel z zwiazku ze zmiana biznesy->budynki';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lss_budynki_owners`
--

LOCK TABLES `lss_budynki_owners` WRITE;
/*!40000 ALTER TABLE `lss_budynki_owners` DISABLE KEYS */;
/*!40000 ALTER TABLE `lss_budynki_owners` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lss_character_co`
--

DROP TABLE IF EXISTS `lss_character_co`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lss_character_co` (
  `character_id` int(10) unsigned NOT NULL,
  `co_id` int(10) unsigned NOT NULL,
  `rank` int(10) unsigned NOT NULL,
  `jointime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `skin` smallint(3) unsigned DEFAULT NULL,
  PRIMARY KEY (`character_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lss_character_co`
--

LOCK TABLES `lss_character_co` WRITE;
/*!40000 ALTER TABLE `lss_character_co` DISABLE KEYS */;
/*!40000 ALTER TABLE `lss_character_co` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lss_character_factions`
--

DROP TABLE IF EXISTS `lss_character_factions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lss_character_factions` (
  `character_id` int(10) unsigned NOT NULL,
  `faction_id` int(10) unsigned NOT NULL,
  `rank` smallint(5) unsigned NOT NULL DEFAULT '1',
  `jointime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lastduty` timestamp NULL DEFAULT NULL,
  `dutytime` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `totalduty` int(10) unsigned NOT NULL DEFAULT '0',
  `skin` smallint(3) unsigned DEFAULT NULL,
  `door` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`character_id`,`faction_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lss_character_factions`
--

LOCK TABLES `lss_character_factions` WRITE;
/*!40000 ALTER TABLE `lss_character_factions` DISABLE KEYS */;
/*!40000 ALTER TABLE `lss_character_factions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lss_characters`
--

DROP TABLE IF EXISTS `lss_characters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lss_characters` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `accepted` tinyint(1) NOT NULL DEFAULT '0',
  `userid` int(10) unsigned NOT NULL,
  `imie` varchar(16) CHARACTER SET utf8 COLLATE utf8_polish_ci NOT NULL,
  `nazwisko` varchar(16) CHARACTER SET utf8 COLLATE utf8_polish_ci NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lastseen` timestamp NULL DEFAULT NULL,
  `skin` smallint(3) NOT NULL DEFAULT '0',
  `premiumskin` smallint(3) unsigned DEFAULT NULL,
  `tytul` varchar(32) DEFAULT NULL,
  `lastpos` varchar(64) NOT NULL DEFAULT '1685.50,-2242.04,13.55,180.0,0,0',
  `hp` double unsigned NOT NULL DEFAULT '100',
  `ar` double unsigned NOT NULL DEFAULT '0',
  `money` bigint(10) unsigned NOT NULL DEFAULT '300',
  `bank_money` bigint(20) unsigned NOT NULL DEFAULT '100',
  `newplayer` tinyint(1) NOT NULL DEFAULT '1',
  `eq` varchar(512) NOT NULL DEFAULT '4,1,0,5,1,0,146,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0',
  `fingerprint` varchar(16) CHARACTER SET ascii NOT NULL COMMENT 'obciety do 16 znaków MD5(imie+nazwisko)',
  `energy` mediumint(4) unsigned NOT NULL DEFAULT '200',
  `stamina` mediumint(4) unsigned NOT NULL DEFAULT '200',
  `cs_driven` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'kat.b',
  `pjA` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `pjB` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `pjL` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `playtime` int(10) unsigned NOT NULL DEFAULT '0',
  `dead` varchar(96) CHARACTER SET utf8 DEFAULT NULL,
  `satiation` tinyint(3) unsigned NOT NULL DEFAULT '75',
  `hunger` tinyint(3) unsigned NOT NULL DEFAULT '75',
  `ab_spray` smallint(3) unsigned NOT NULL DEFAULT '0',
  `data_urodzenia` date DEFAULT NULL,
  `rasa` enum('nieznana','biala','czarna','zolta') DEFAULT 'nieznana',
  `opis` varchar(170) CHARACTER SET utf8 DEFAULT NULL,
  `bu` timestamp NULL DEFAULT NULL,
  `stylewalki` text NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `imie_nazwisko` (`imie`,`nazwisko`),
  KEY `userid` (`userid`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lss_characters`
--

LOCK TABLES `lss_characters` WRITE;
/*!40000 ALTER TABLE `lss_characters` DISABLE KEYS */;
INSERT INTO `lss_characters` VALUES (2,1,1,'Brian','Looner','2012-03-12 13:51:43','2013-05-27 10:41:37',21,NULL,NULL,'563.76,-1391.45,14.84,196,0,0',37,0,81,0,0,'0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0','2084638eaea45aaf',100,90,0,0,0,0,3411,NULL,0,75,0,NULL,'nieznana',NULL,NULL,'');
/*!40000 ALTER TABLE `lss_characters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lss_characters_podania`
--

DROP TABLE IF EXISTS `lss_characters_podania`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lss_characters_podania` (
  `id` int(10) unsigned NOT NULL,
  `tresc` text CHARACTER SET utf8,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lss_characters_podania`
--

LOCK TABLES `lss_characters_podania` WRITE;
/*!40000 ALTER TABLE `lss_characters_podania` DISABLE KEYS */;
/*!40000 ALTER TABLE `lss_characters_podania` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lss_clickandbuy`
--

DROP TABLE IF EXISTS `lss_clickandbuy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lss_clickandbuy` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `char_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `item_name` text COLLATE utf8_polish_ci NOT NULL,
  `item_price` int(11) NOT NULL,
  `item_subtype` int(11) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `imie` text COLLATE utf8_polish_ci NOT NULL,
  `nazwisko` text COLLATE utf8_polish_ci NOT NULL,
  KEY `id` (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lss_clickandbuy`
--

LOCK TABLES `lss_clickandbuy` WRITE;
/*!40000 ALTER TABLE `lss_clickandbuy` DISABLE KEYS */;
/*!40000 ALTER TABLE `lss_clickandbuy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lss_co`
--

DROP TABLE IF EXISTS `lss_co`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lss_co` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lss_co`
--

LOCK TABLES `lss_co` WRITE;
/*!40000 ALTER TABLE `lss_co` DISABLE KEYS */;
/*!40000 ALTER TABLE `lss_co` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lss_co_ranks`
--

DROP TABLE IF EXISTS `lss_co_ranks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lss_co_ranks` (
  `co_id` int(10) unsigned NOT NULL,
  `rank_id` int(10) unsigned NOT NULL,
  `name` varchar(64) NOT NULL,
  PRIMARY KEY (`co_id`,`rank_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lss_co_ranks`
--

LOCK TABLES `lss_co_ranks` WRITE;
/*!40000 ALTER TABLE `lss_co_ranks` DISABLE KEYS */;
/*!40000 ALTER TABLE `lss_co_ranks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lss_co_skins`
--

DROP TABLE IF EXISTS `lss_co_skins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lss_co_skins` (
  `co_id` int(10) unsigned NOT NULL,
  `skin` smallint(3) unsigned NOT NULL,
  `restricted` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lss_co_skins`
--

LOCK TABLES `lss_co_skins` WRITE;
/*!40000 ALTER TABLE `lss_co_skins` DISABLE KEYS */;
/*!40000 ALTER TABLE `lss_co_skins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lss_container_contents`
--

DROP TABLE IF EXISTS `lss_container_contents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lss_container_contents` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `container_id` int(10) unsigned NOT NULL,
  `itemid` smallint(6) NOT NULL,
  `count` mediumint(8) unsigned NOT NULL DEFAULT '1',
  `subtype` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cid` (`container_id`),
  KEY `k1` (`container_id`,`itemid`,`subtype`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lss_container_contents`
--

LOCK TABLES `lss_container_contents` WRITE;
/*!40000 ALTER TABLE `lss_container_contents` DISABLE KEYS */;
/*!40000 ALTER TABLE `lss_container_contents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lss_containers`
--

DROP TABLE IF EXISTS `lss_containers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lss_containers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `owning_player` int(10) unsigned DEFAULT NULL,
  `owning_vehicle` int(10) unsigned DEFAULT NULL,
  `owning_faction` int(10) unsigned DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `last_access` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `fprint1` varchar(16) DEFAULT NULL,
  `fprint2` varchar(16) DEFAULT NULL,
  `fprint3` varchar(16) DEFAULT NULL,
  `typ` varchar(16) NOT NULL,
  `nazwa` varchar(128) CHARACTER SET utf8 NOT NULL,
  `szyfr` varchar(8) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lss_containers`
--

LOCK TABLES `lss_containers` WRITE;
/*!40000 ALTER TABLE `lss_containers` DISABLE KEYS */;
INSERT INTO `lss_containers` VALUES (92,NULL,NULL,NULL,'2013-08-09 18:19:59','2012-04-29 09:55:41',NULL,NULL,NULL,'sejf','Sejf w komisie samochodowym \'Titanic\'','1321'),(101,NULL,NULL,2,'2013-07-18 14:27:32','0000-00-00 00:00:00',NULL,NULL,NULL,'sejf','Sejf w policji','3332323'),(106,NULL,NULL,NULL,'2013-08-12 13:34:09','0000-00-00 00:00:00',NULL,NULL,NULL,'sejf','Sejf w firmie kurierskiej','84653'),(124,NULL,NULL,6,'2013-07-12 10:44:33','2012-05-02 19:51:07',NULL,NULL,NULL,'sejf','Sejf w szpitalu','73356'),(133,NULL,NULL,11,'2013-05-27 17:02:24','2012-05-03 13:56:11',NULL,NULL,NULL,'sejf','Sejf w straży pożarnej','6445665'),(160,NULL,NULL,5,'2013-07-12 10:44:19','0000-00-00 00:00:00',NULL,NULL,NULL,'sejf','Sejf w CNN News','432209'),(194,NULL,NULL,NULL,'2013-08-17 15:56:06','0000-00-00 00:00:00',NULL,NULL,NULL,'sejf','Sejf w Osrodku Szkolenia Kierowcow I','4954914'),(197,NULL,NULL,NULL,'2013-05-27 17:02:42','0000-00-00 00:00:00',NULL,NULL,NULL,'sejf','Sejf w firmie TAXI','544334'),(241,NULL,NULL,NULL,'2013-05-27 17:02:48','0000-00-00 00:00:00',NULL,NULL,NULL,'sejf','Sejf w UM - pietro wyborcze','6557888'),(248,NULL,NULL,NULL,'2013-05-27 17:03:18','0000-00-00 00:00:00',NULL,NULL,NULL,'sejf','Sejf w Warsztacie II','6777655'),(274,NULL,NULL,4,'2013-05-27 17:03:27','0000-00-00 00:00:00',NULL,NULL,NULL,'sejf','Sejf w biurze SM','0003450'),(275,NULL,NULL,NULL,'2013-06-19 13:15:45','0000-00-00 00:00:00',NULL,NULL,NULL,'sejf','Sejf w Club Cafe','2188070'),(304,NULL,NULL,NULL,'2013-05-27 17:03:37','0000-00-00 00:00:00',NULL,NULL,NULL,'sejf','Sejf w knajpce na pomoscie','335769'),(311,NULL,NULL,NULL,'2013-05-27 17:03:41','0000-00-00 00:00:00',NULL,NULL,NULL,'sejf','Sejf w szopie','65444342'),(369,NULL,NULL,NULL,'2013-08-12 13:26:04','2012-05-23 19:08:38',NULL,NULL,NULL,'sejf','Sejf w Osrodku Szkolenia Kierowcow II','0107'),(415,NULL,NULL,17,'2013-07-20 10:45:01','0000-00-00 00:00:00',NULL,NULL,NULL,'sejf','Sejf w sadzie','5698752'),(442,NULL,NULL,NULL,'2013-05-27 17:03:54','0000-00-00 00:00:00',NULL,NULL,NULL,'sejf','Sejf w Lucky Strike','9345732'),(478,NULL,NULL,NULL,'2013-07-23 08:04:35','0000-00-00 00:00:00',NULL,NULL,NULL,'sejf','Sejf w firmie ochroniarskiej','886711'),(525,NULL,NULL,NULL,'2013-05-27 17:04:06','0000-00-00 00:00:00',NULL,NULL,NULL,'sejf','Sejf w hurtowni i porcie (import)','887547'),(530,NULL,NULL,NULL,'2013-08-05 16:55:14','0000-00-00 00:00:00',NULL,NULL,NULL,'sejf','Sejf w komisie samochodowym \'Angelo\'','7941'),(581,NULL,NULL,NULL,'2013-08-06 14:21:25','0000-00-00 00:00:00',NULL,NULL,NULL,'sejf','Sejf w The Well Stacked Pizza','52121'),(589,NULL,NULL,NULL,'2013-05-27 17:04:31','0000-00-00 00:00:00',NULL,NULL,NULL,'sejf','Sejf mafii','99666'),(634,NULL,NULL,NULL,'2013-05-27 17:04:35','0000-00-00 00:00:00',NULL,NULL,NULL,'sejf','Sejf w porcie','0987898'),(660,NULL,NULL,NULL,'2013-07-25 22:10:16','0000-00-00 00:00:00',NULL,NULL,NULL,'sejf','Sejf w warsztacie III','886711'),(696,NULL,NULL,NULL,'2013-07-29 15:43:53','0000-00-00 00:00:00',NULL,NULL,NULL,'sejf','Sejf w warsztacie IV','1756042'),(701,NULL,NULL,NULL,'2013-08-01 19:23:16','0000-00-00 00:00:00',NULL,NULL,NULL,'sejf','Sejf w warsztacie V','886711'),(778,NULL,NULL,NULL,'2013-05-27 17:04:55','0000-00-00 00:00:00',NULL,NULL,NULL,'sejf','Sejf w klubie Silver Club','6655788'),(889,NULL,NULL,NULL,'2013-08-01 20:00:07','0000-00-00 00:00:00',NULL,NULL,NULL,'sejf','Sejf w komisie samochodowy \'Smiling Central\'','36221'),(893,NULL,NULL,NULL,'2013-06-30 15:29:59','0000-00-00 00:00:00',NULL,NULL,NULL,'sejf','Sklep na rogu','0285'),(894,NULL,NULL,NULL,'2013-07-16 15:59:20','0000-00-00 00:00:00',NULL,NULL,NULL,'sejf','Sejf w Pig Pen','2188070'),(895,NULL,NULL,NULL,'2013-07-30 19:27:35','0000-00-00 00:00:00',NULL,NULL,NULL,'sejf','Sejf w Spozywczym','463623'),(896,NULL,NULL,NULL,'2013-05-27 17:37:50','0000-00-00 00:00:00',NULL,NULL,NULL,'sejf','Silownia na gs','79499'),(897,NULL,NULL,NULL,'2013-05-27 17:05:52','0000-00-00 00:00:00',NULL,NULL,NULL,'sejf','Sejf w Hot-Food','905434'),(898,NULL,NULL,NULL,'2013-07-16 19:09:01','0000-00-00 00:00:00',NULL,NULL,NULL,'sejf','Sejf w Silver Club','1756042'),(899,NULL,NULL,NULL,'2013-05-28 14:06:11','0000-00-00 00:00:00',NULL,NULL,NULL,'sejf','Sejf w silowni w Ganton','2255'),(944,NULL,NULL,NULL,'2013-05-27 17:06:06','0000-00-00 00:00:00',NULL,NULL,NULL,'sejf','Sejf w Miller Construction Company','0989766'),(1006,NULL,NULL,NULL,'2013-05-27 17:06:11','0000-00-00 00:00:00',NULL,NULL,NULL,'sejf','Sejf w policji - wydzial HSIU','2455443'),(1070,NULL,NULL,NULL,'2013-05-27 17:06:16','0000-00-00 00:00:00',NULL,NULL,NULL,'sejf','Sejf w bibliotece','2357787'),(1146,NULL,NULL,NULL,'2013-05-27 17:06:20','0000-00-00 00:00:00',NULL,NULL,NULL,'sejf','Sejf w Knajpce na molo','122443'),(1169,NULL,NULL,NULL,'2013-05-27 17:07:58','0000-00-00 00:00:00',NULL,NULL,NULL,'sejf','Sejf na silowni w dzielnicy Richman','6565653'),(1170,NULL,NULL,NULL,'2013-01-16 16:02:05','0000-00-00 00:00:00',NULL,NULL,NULL,'sejf','Sejf w silowni w Montgomery','4567890'),(1182,NULL,NULL,1,'2013-05-27 17:08:03','0000-00-00 00:00:00',NULL,NULL,NULL,'sejf','Sejf w UM w Wydziale ds. gospodarki','44326544'),(1251,NULL,NULL,NULL,'2013-08-13 12:51:55','0000-00-00 00:00:00',NULL,NULL,NULL,'sejf','Sejf w komisie samochodowym \'sunset beach\'','1234565'),(1252,NULL,NULL,NULL,'2013-08-06 16:29:53','0000-00-00 00:00:00',NULL,NULL,NULL,'sejf','Sejf w komisie samochodowym \'Nemo\'','1827'),(1428,NULL,NULL,NULL,'2013-08-12 13:40:05','0000-00-00 00:00:00',NULL,NULL,NULL,'sejf','Sejf w Kawiarni \'pod scena\'','654982'),(1533,NULL,NULL,NULL,'2013-05-27 17:07:29','0000-00-00 00:00:00',NULL,NULL,NULL,'sejf','Sejf w biurze burmistrza','63636325'),(1577,NULL,NULL,NULL,'2013-05-27 17:07:24','0000-00-00 00:00:00',NULL,NULL,NULL,'sejf','Sejf na stadionie','54545466'),(1740,NULL,NULL,NULL,'2013-05-27 17:07:19','0000-00-00 00:00:00',NULL,NULL,NULL,'sejf','Sejf w magazynie w Blueberry','12121244'),(1797,NULL,NULL,NULL,'2013-07-16 16:32:52','0000-00-00 00:00:00',NULL,NULL,NULL,'sejf','Sejf w biurze detektywistycznym','0107'),(1820,NULL,NULL,NULL,'2013-05-27 17:07:10','0000-00-00 00:00:00',NULL,NULL,NULL,'sejf','Sejf w budynku nr 42','1234444'),(1824,NULL,NULL,NULL,'2013-05-27 17:07:06','0000-00-00 00:00:00',NULL,NULL,NULL,'sejf','Sejf w domu pogrzebowym','5789995'),(1870,NULL,NULL,NULL,'2013-05-27 17:07:02','0000-00-00 00:00:00',NULL,NULL,NULL,'sejf','Sejf w biurze kolonii karnej','3546663'),(1883,NULL,NULL,NULL,'2013-05-27 17:06:58','0000-00-00 00:00:00',NULL,NULL,NULL,'sejf','Sejf w budynku 44','33377745'),(1946,NULL,NULL,NULL,'2013-05-27 17:06:54','0000-00-00 00:00:00',NULL,NULL,NULL,'sejf','Sejf w budynku 47','344777'),(1950,NULL,NULL,NULL,'2013-05-28 18:17:45','0000-00-00 00:00:00',NULL,NULL,NULL,'sejf','Sejf w Warsztacie I','232323'),(1960,NULL,NULL,NULL,'2013-05-27 17:06:45','0000-00-00 00:00:00',NULL,NULL,NULL,'sejf','Sejf w przychodni lekarskiej','3433763'),(2121,NULL,NULL,NULL,'2013-05-27 17:06:41','0000-00-00 00:00:00',NULL,NULL,NULL,'sejf','Sejf w lodziarni','1243322'),(2122,NULL,NULL,NULL,'2013-06-07 20:52:01','0000-00-00 00:00:00',NULL,NULL,NULL,'sejf','Sejf w markecie \'Super Sam\'','4937'),(2123,NULL,NULL,NULL,'2013-05-27 17:06:33','0000-00-00 00:00:00',NULL,NULL,NULL,'sejf','Sejf w markecie \'Prima\'','48997'),(2179,NULL,NULL,22,'2013-08-01 17:58:26','0000-00-00 00:00:00',NULL,NULL,NULL,'sejf','Sejf w sluzbach specjalnych','323223'),(2265,NULL,NULL,NULL,'2013-05-27 17:08:30','0000-00-00 00:00:00',NULL,NULL,NULL,'sejf','Sejf w Kawiarni \'Paszcza Wieloryba\'','3344343'),(2294,NULL,NULL,NULL,'2013-08-03 10:31:07','0000-00-00 00:00:00',NULL,NULL,NULL,'sejf','Sejf w klubie \'fantasia\'','7987'),(2295,NULL,NULL,NULL,'2013-08-17 23:15:24','0000-00-00 00:00:00',NULL,NULL,NULL,'sejf','Sejf w ruderze rozrywki','506929'),(2463,NULL,NULL,NULL,'2013-05-27 17:08:45','0000-00-00 00:00:00',NULL,NULL,NULL,'sejf','Sejf w tartaku','2121445'),(2526,NULL,NULL,NULL,'2013-05-27 17:08:50','0000-00-00 00:00:00',NULL,NULL,NULL,'sejf','Sejf w osrodku szkolenia pilotow','3232664'),(3116,NULL,NULL,NULL,'2013-05-27 17:08:55','0000-00-00 00:00:00',NULL,NULL,NULL,'sejf','Sejf w policji (wydzial MPU)','5427553'),(3142,NULL,NULL,NULL,'2013-05-27 17:09:01','0000-00-00 00:00:00',NULL,NULL,NULL,'sejf','Sejf w sluzbach specjalnych (pokoj przesluchan)','11445553'),(3195,NULL,NULL,NULL,'2013-05-27 17:09:05','0000-00-00 00:00:00',NULL,NULL,NULL,'sejf','sejf w salonie tatuazu','3267777'),(3201,NULL,NULL,35,'2013-07-27 11:50:10','0000-00-00 00:00:00',NULL,NULL,NULL,'sejf','sejf w departamencie turystyki','8569487'),(3223,NULL,NULL,NULL,'2013-06-02 17:32:54','0000-00-00 00:00:00',NULL,NULL,NULL,'sejf','sejf w markecie \'łubin\'','8857542'),(3224,NULL,NULL,NULL,'2013-08-01 14:13:49','0000-00-00 00:00:00',NULL,NULL,NULL,'sejf','sejf w knajpie \'Isaura\'','72484'),(3246,NULL,NULL,NULL,'2013-05-27 17:09:51','0000-00-00 00:00:00',NULL,NULL,NULL,'sejf','sejf w hotelu \'burza\'','2121345'),(3247,NULL,NULL,NULL,'2013-05-27 17:09:46','0000-00-00 00:00:00',NULL,NULL,NULL,'sejf','sejf w hotelu \'carrington\'','32323256'),(3248,NULL,NULL,NULL,'2013-08-01 15:46:56','0000-00-00 00:00:00',NULL,NULL,NULL,'sejf','sejf w hotelu \'forrester\'','886711'),(3249,NULL,NULL,NULL,'2013-05-27 17:09:36','0000-00-00 00:00:00',NULL,NULL,NULL,'sejf','sejf w hotelu \'martwa cisza\'','7656555'),(3272,NULL,NULL,NULL,'2013-05-27 17:09:32','0000-00-00 00:00:00',NULL,NULL,NULL,'sejf','sejf w barze \'Purple-Pub\'','24633556'),(3273,NULL,NULL,NULL,'2013-05-28 17:27:37','0000-00-00 00:00:00',NULL,NULL,NULL,'sejf','sejf w odziezowym the exclusive clothing','663630'),(3274,NULL,NULL,NULL,'2013-05-31 06:21:13','0000-00-00 00:00:00',NULL,NULL,NULL,'sejf','sejf w barze corona billard pub','260898'),(3325,NULL,NULL,NULL,'2013-08-02 08:53:42','0000-00-00 00:00:00',NULL,NULL,NULL,'sejf','sejf w Restauracji \'Przy skarpie\'','690142'),(3407,NULL,NULL,NULL,'2013-05-06 10:56:04','0000-00-00 00:00:00',NULL,NULL,NULL,'sejf','Sejf w odziezowym \'anastacia\'','4546644'),(3408,NULL,NULL,NULL,'2013-05-07 15:00:39','0000-00-00 00:00:00',NULL,NULL,NULL,'sejf','Sejf w odziezowym \'mustang jeans\'','041987'),(3409,NULL,NULL,NULL,'2013-05-07 14:00:07','0000-00-00 00:00:00',NULL,NULL,NULL,'sejf','Sejf w knajpie \'diabelski mlyn\'','79499'),(3414,NULL,NULL,NULL,'2013-06-11 15:39:41','0000-00-00 00:00:00',NULL,NULL,NULL,'sejf','Sejf w klubie \'eden\'','36221'),(3701,NULL,NULL,NULL,'2013-07-12 12:41:14','0000-00-00 00:00:00',NULL,NULL,NULL,'sejf','Sejf od dorabiania kluczy','45455'),(3702,NULL,NULL,NULL,'2013-07-12 13:00:27','0000-00-00 00:00:00',NULL,NULL,NULL,'sejf','Sejf wypozyczalni rowerow','452776');
/*!40000 ALTER TABLE `lss_containers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lss_corpses`
--

DROP TABLE IF EXISTS `lss_corpses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lss_corpses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `char_id` int(11) NOT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `weaponid` int(2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lss_corpses`
--

LOCK TABLES `lss_corpses` WRITE;
/*!40000 ALTER TABLE `lss_corpses` DISABLE KEYS */;
/*!40000 ALTER TABLE `lss_corpses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lss_currentstats`
--

DROP TABLE IF EXISTS `lss_currentstats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lss_currentstats` (
  `name` varchar(16) NOT NULL,
  `value_i` int(10) unsigned NOT NULL,
  `value_t` text,
  PRIMARY KEY (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lss_currentstats`
--

LOCK TABLES `lss_currentstats` WRITE;
/*!40000 ALTER TABLE `lss_currentstats` DISABLE KEYS */;
/*!40000 ALTER TABLE `lss_currentstats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lss_doladowania`
--

DROP TABLE IF EXISTS `lss_doladowania`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lss_doladowania` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ua` varchar(255) CHARACTER SET ascii NOT NULL COMMENT 'przegladarka',
  `ip` varchar(32) NOT NULL,
  `object_type` varchar(32) NOT NULL COMMENT 'rodzaj uslugi',
  `element_id` int(10) unsigned NOT NULL COMMENT 'id elementu (id gracza, id domu)',
  `zakres` smallint(5) unsigned NOT NULL COMMENT 'ilosc dni',
  `code` varchar(32) NOT NULL COMMENT 'wyslany kod',
  `return_code` varchar(32) NOT NULL COMMENT 'otrzymany (wprowadzony w formularzu) kod',
  `phone_number` int(11) NOT NULL,
  `payment_method` varchar(32) NOT NULL COMMENT 'metoda platnosci',
  `success` smallint(6) NOT NULL,
  `info` text CHARACTER SET utf8 COMMENT 'ewentualne bledy',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lss_doladowania`
--

LOCK TABLES `lss_doladowania` WRITE;
/*!40000 ALTER TABLE `lss_doladowania` DISABLE KEYS */;
/*!40000 ALTER TABLE `lss_doladowania` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lss_domy`
--

DROP TABLE IF EXISTS `lss_domy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lss_domy` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `descr` varchar(32) CHARACTER SET utf8 DEFAULT NULL,
  `i` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'interior w ktorym jest wejscie i wyjscie z domu',
  `vwe` int(11) NOT NULL DEFAULT '0' COMMENT 'vw wejscia (prawie zawsze 0)',
  `vwi` int(11) DEFAULT NULL COMMENT 'VW wnetrza (nadawane automatycznie, tu mozna wymusic)',
  `drzwi` varchar(32) CHARACTER SET ascii NOT NULL COMMENT 'x,y,z miejsce w ktorym bedzie pickup wchodzenia',
  `punkt_wyjscia` varchar(64) NOT NULL COMMENT 'x,y,z,[rz] miejsce gdzie przeniesie po wyjsciu',
  `interiorid` int(10) unsigned DEFAULT NULL COMMENT 'numer wnetrza z tablicy pbp_interiory',
  `ownerid` int(10) unsigned DEFAULT NULL COMMENT 'numer wlasciciela z tablicy players',
  `zamkniety` tinyint(1) NOT NULL DEFAULT '1' COMMENT '0=zawsze otwarty',
  `koszt` smallint(5) unsigned NOT NULL DEFAULT '100',
  `paidTo` date DEFAULT NULL,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'uzywane do wykrywania zaktualizowanych przez panel domow',
  `active` tinyint(3) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `ownerid` (`ownerid`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lss_domy`
--

LOCK TABLES `lss_domy` WRITE;
/*!40000 ALTER TABLE `lss_domy` DISABLE KEYS */;
INSERT INTO `lss_domy` VALUES (1,'Dom pietrowy',0,0,1001,'2486.2,-1644.5,14.18','2486.57,-1649.31,13.48,183',35,15284,1,3500,'2013-08-13','2013-08-12 19:34:34',1),(2,'Dom jednopokojowy',0,0,1002,'2498.38,-1642.26,14.11','2498.05,-1646.31,13.54,171',35,NULL,1,2000,NULL,'2013-08-06 21:18:29',1),(3,'Dom jednorodzinny',0,0,1003,'2513.73,-1650.26,14.36','2509.79,-1653.42,13.69,138',15,NULL,1,2500,NULL,'2013-06-23 16:50:47',1),(7,'Rezydencja',0,0,1007,'1122.71,-2037.05,69.89','1126.84,-2036.97,69.88, 270',50,NULL,0,20000,NULL,'2013-07-28 17:10:40',1),(1132,'Dom jednorodzinny',0,0,1132,'2018.24,-1703.30,14.23','2018.24,-1703.30,14.23, 270',6,NULL,0,3800,NULL,'2013-03-17 23:08:22',1),(1122,'Melina',0,0,NULL,'2465.31,-2020.79,14.12','2465.48,-2018.88,13.55,357.5',5,NULL,0,3000,NULL,'2013-02-02 23:08:06',1),(1123,'Melina',0,0,NULL,'2483.36,-1995.34,13.83','2483.37,-1996.68,13.83,180.4',15,NULL,1,2700,NULL,'2013-07-28 17:10:40',1),(1124,'Skromne mieszkanie',0,0,1124,'2507.74,-2021.05,14.21','2508.02,-2019.10,13.55,358.7',21,NULL,1,2600,NULL,'2013-08-08 08:42:01',1),(8,'Ekstrawagancki domek',0,0,1008,'1093.97,-807.13,107.42','1093.52,-803.79,107.42,8.5',27,15386,1,4500,'2013-08-13','2013-08-12 16:41:14',1),(9,'Dom jednopokojowy',0,0,1009,'2514.32, -1691.62, 14.05',' 2513.02, -1690.20, 13.54, 48',4,NULL,1,2000,NULL,'2013-06-08 00:37:09',1),(10,'Dom pietrowy',0,0,1010,'2495.39, -1691.14, 14.77','2495.31, -1687.91, 13.52, 0',7,NULL,1,3500,NULL,'2013-07-28 17:10:40',1),(11,'Dom jednorodzinny',0,0,1011,'2459.47, -1691.66, 13.55','2459.50, -1689.46, 13.54, 0',5,NULL,1,2500,NULL,'2013-08-06 21:18:29',1),(12,'Dom na plazy',0,0,1012,'315.89, -1769.43, 4.62','315.94, -1771.31, 4.69, 180',35,13212,1,3000,'2013-08-14','2013-08-13 19:59:00',1),(13,'Dom jednorodzinny',0,0,1013,'254.40, -1367.16, 53.11','255.71, -1366.24, 53.11, 306',35,12774,0,2500,'2013-08-13','2013-08-03 10:20:28',1),(14,'Dom jednorodzinny',0,0,1014,'693.76, -1645.83, 4.09','696.33, -1645.95, 3.57, 270',35,NULL,0,2500,NULL,'2013-08-06 21:18:29',1),(15,'Dom jednopokojowy',0,0,1015,'1804.16, -2124.90, 13.94','1804.00, -2122.83, 13.55, 0',36,NULL,1,2000,NULL,'2013-04-08 22:06:09',1),(16,'Dom jednorodzinny',0,0,1016,'2000.03, -1114.05, 27.12','2000.06, -1116.35, 26.81, 180',37,15870,0,2700,'2013-08-21','2013-08-10 19:16:04',1),(17,'Dom pietrowy',0,0,1017,'2842.12, -1334.79, 14.74',' 2848.33, -1334.29, 11.09, 270',35,NULL,1,2500,NULL,'2013-03-28 23:06:50',1),(18,'Dom pietrowy',0,0,1018,'2207.44, -1100.47, 31.55','2204.31, -1103.38, 29.11, 151',35,NULL,0,2300,NULL,'2013-01-24 23:05:24',1),(38,'Willa na skarpie',0,0,1038,'1332.12, -633.50, 109.13','1331.20, -630.84, 109.13, 0',14,14987,0,3500,'2013-08-21','2013-08-08 18:56:29',1),(39,'Apartament u Gigolo',0,0,1039,'1497.00, -687.89, 95.56','1496.98, -689.53, 94.94, 180',27,12861,1,5000,'2013-08-13','2013-08-11 19:37:00',1),(52,'Dom jednorodzinny',0,0,1052,'2851.85, -1365.98, 14.17',' 2857.23, -1366.00, 12.47, 270',36,NULL,0,3000,NULL,'2012-12-11 23:08:04',1),(53,'Dom pietrowy',0,0,1053,'2808.02, -1190.89, 25.34','2808.04, -1189.20, 25.35, 0',36,NULL,0,3500,NULL,'2013-08-06 21:18:29',1),(54,'Dom pietrowy',0,0,1054,'2808.04, -1175.91, 25.38','2808.04, -1177.79, 25.37, 180',36,NULL,0,3200,NULL,'2013-08-06 21:18:29',1),(55,'Apartament BOSS\'a',0,0,1055,'691.58, -1275.91, 13.56','689.78, -1275.94, 13.56, 90',27,12769,1,5000,'2013-08-21','2013-08-07 11:11:44',1),(56,'Mieszkanie osiedlowe',0,0,1056,'846.73, -1717.28, 14.93','848.66, -1717.30, 14.93, 270``',15,NULL,1,2500,NULL,'2012-11-20 14:45:42',1),(57,'Mieszkanie osiedlowe',0,0,1057,'850.67, -1686.17, 14.94','852.89, -1686.26, 14.95, 270',15,NULL,1,2500,NULL,'2013-04-09 22:06:15',1),(58,'Mieszkanie osiedlowe',0,0,1058,'865.27, -1633.85, 14.93','865.35, -1635.80, 14.93, 180',15,NULL,1,2500,NULL,'2012-11-21 23:01:32',1),(59,'Mieszkanie osiedlowe',0,0,1059,'936.83, -1612.71, 14.94','937.01, -1614.84, 14.95, 180',36,NULL,0,2500,NULL,'2013-03-06 23:06:12',1),(60,'Mieszkanie osiedlowe',0,0,1060,'965.11, -1612.61, 14.94','965.10, -1614.81, 14.95, 180',36,NULL,0,2500,NULL,'2013-03-18 23:08:25',1),(61,'Mieszkanie osiedlowe',0,0,1061,'987.50, -1624.53, 14.93','985.12, -1624.60, 14.93, 90',13,NULL,1,2500,NULL,'2013-07-03 19:14:26',1),(62,'Mieszkanie osiedlowe',0,0,1062,'987.52, -1704.31, 14.93','984.79, -1704.47, 14.93, 90',13,NULL,0,2500,NULL,'2013-04-19 22:08:22',1),(173,'Dom pietrowy przy plazy',0,0,1173,'263.94, -1765.46, 4.76','264.05, -1767.38, 4.75, 180',13,NULL,0,3000,NULL,'2013-04-11 22:08:59',1),(1133,'Dom jednorodzinny',0,0,1133,'2018.05,-1629.92,14.04','2017.15,-1629.73,13.55, 90',2,NULL,1,3300,NULL,'2013-03-10 23:07:11',1),(1134,'Dom jednorodzinny',0,0,1134,'2065.10,-1703.48,14.15','2066.10,-1703.47,14.15, 270',5,NULL,1,3900,NULL,'2013-07-18 17:55:02',1),(1135,'Dom nad mariną',0,0,1135,'692.87,-1602.77,15.05','692.86,-1601.66,15.05,1.3',38,NULL,0,4500,NULL,'2013-07-03 19:14:26',1),(1137,'Skromne mieszkanie',0,0,NULL,'1761.25,-2125.45,14.06','1761.13,-2124.16,13.88,5.9',15,NULL,1,2700,NULL,'2013-04-17 22:08:12',1),(1175,'Domek \'szafarza\'',0,0,1175,'2186.54,-997.33,66.47','2180.09,-996.63,62.92, 79',14,NULL,0,6554,NULL,'2013-03-18 23:08:25',1),(89,'Dom jednopokojowy',0,0,1089,'160.63, -102.69, 4.90','161.84, -102.50, 4.90, 270',13,NULL,0,2500,NULL,'2013-02-20 23:00:56',1),(90,'Dom jednopokojowy',0,0,1090,'201.43, -94.97, 1.55','201.41, -96.49, 1.55, 180',5,NULL,1,2500,NULL,'2013-06-08 00:37:09',1),(91,'Dom pustelnika',0,0,1091,'870.44, -24.94, 63.98','868.98, -27.98, 63.20, 180',4,NULL,0,4000,NULL,'2013-04-09 22:06:15',1),(1131,'Dom jednorodzinny',0,0,1131,'2263.95,-1469.34,24.37','2263.89,-1470.31,23.79, 180',3,NULL,1,3000,NULL,'2013-01-15 23:09:12',1),(94,'Dom jednorodzinny',0,0,1094,'1106.54, -299.76, 74.54','1103.80, -299.59, 73.99, 90',13,NULL,0,3200,NULL,'2012-11-20 14:45:42',1),(1130,'Dom jednorodzinny',0,0,1130,'2247.67,-1469.34,24.48','2247.87,-1470.12,24.03, 180',3,NULL,1,2800,NULL,'2013-02-25 23:01:08',1),(172,'Dom przy plazy',0,0,1172,'295.35, -1764.12, 4.87','295.31, -1765.27, 4.55, 180',5,NULL,0,2500,NULL,'2013-03-06 23:06:12',1),(138,'Dom zlodzieja',0,0,1138,'835.97, -894.87, 68.77','836.92, -893.48, 68.77, 325',38,13651,0,3500,'2013-08-22','2013-08-16 14:31:57',1),(139,'Dom z basenem',0,0,1139,'700.30, -1060.26, 49.42','698.35, -1059.10, 49.42, 55',5,NULL,0,3000,NULL,'2013-04-01 22:06:59',1),(140,'Dom w Vinewood',0,0,1040,'1421.81, -886.23, 50.69','1421.98, -884.21, 50.61, 0',37,14968,1,3000,'2013-08-15','2013-08-14 16:57:28',1),(141,'Dom przy skarpie',0,0,1141,'937.86, -848.72, 93.58','937.13, -847.04, 93.84, 27',35,NULL,1,3200,NULL,'2013-04-12 22:09:01',1),(151,'Apartament Czysciocha',0,0,1151,'167.89, -1308.27, 70.35','166.38, -1308.25, 70.35, 90',14,14206,0,5000,'2013-08-18','2013-08-09 09:24:50',1),(1129,'Dom jednorodzinny',0,0,1129,'2232.60,-1469.34,24.58','2232.59,-1470.31,24.06, 180',21,NULL,0,3200,NULL,'2013-03-02 23:04:07',1),(152,'Dom na palach',0,0,1152,'1535.77, -885.30, 57.66','1537.46, -883.70, 57.66, 315',15,NULL,1,3000,NULL,'2013-07-03 19:14:26',1),(153,'Dom pietrowy z garazem',0,0,1153,'1112.64, -742.12, 100.13','1110.72, -742.16, 100.13, 90',35,NULL,0,3200,NULL,'2013-07-03 19:14:26',1),(154,'Willa Astronauty',0,0,NULL,'980.47, -677.27, 121.98','979.03,-674.45,121.98,32.3',27,NULL,0,5000,NULL,'2013-08-06 21:18:29',1),(163,'Dom jednorodzinny',0,0,1163,'2203.11, -89.23, 28.15','2204.56, -89.23, 28.15, 270',15,NULL,0,2500,NULL,'2013-07-08 17:36:23',1),(1125,'Skromne mieszkanie',0,0,1125,'2016.54,-1641.66,14.11','2014.50,-1641.50,13.78,92.1',21,NULL,1,2700,NULL,'2013-07-08 17:36:23',1),(1121,'Willa na wzgorzu',0,0,1121,'300.12,-1154.55,81.32','299.16,-1155.65,80.91,134.4',27,12753,0,5000,'2013-08-12','2013-07-29 12:44:09',1),(1136,'Dom na wsi',0,0,1136,'2199.95,-37.36,28.15','2201.75,-37.32,28.15, 270',38,NULL,0,4000,NULL,'2013-07-08 17:36:23',1),(1126,'Dom jednorodzinny',0,0,1126,'2230.44,-1397.24,24.57','2230.32,-1396.41,24.00, 0',1,NULL,0,2900,NULL,'2013-03-14 23:07:21',1),(1127,'Dom jednorodzinny',0,0,1127,'2243.51,-1397.24,24.57','2243.41,-1396.44,24.00, 0',3,NULL,1,3100,NULL,'2013-02-25 23:01:08',1),(1128,'Dom jednorodzinny',0,0,1128,'2256.45,-1397.24,24.57','2256.57,-1396.36,24.00, 0',1,NULL,1,2900,NULL,'2013-04-30 19:33:08',1),(174,'Dom przy plazy z basenem',0,0,1174,'167.77, -1758.99, 6.80','166.21, -1758.94, 6.80, 90',14,NULL,0,2600,NULL,'2013-08-06 21:18:29',1),(1138,'Rezydencja',0,0,NULL,'251.38,-1220.25,76.10','252.20,-1221.37,75.59,218.3',27,12991,0,4500,'2013-08-14','2013-07-31 09:41:28',1),(1139,'Dom jednorodzinny',0,0,1139,'1854.07,-1914.26,15.26','1853.96,-1916.79,15.04, 180',6,NULL,0,3400,NULL,'2013-02-21 23:00:58',1),(1140,'Dom jednorodzinny',0,0,1140,'1872.24,-1911.79,15.26,355.9','1872.06,-1914.39,15.03, 180',6,NULL,0,3800,NULL,'2013-03-02 23:04:07',1),(1141,'Dom jednorodzinny',0,0,1141,'1891.86,-1914.44,15.26,6.2','1891.83,-1917.10,15.03, 180',2,NULL,1,3200,NULL,'2013-02-15 23:07:29',1),(1142,'Dom jednorodzinny',0,0,1142,'1913.49,-1911.90,15.26','1913.45,-1914.56,15.03, 180',1,NULL,1,3500,NULL,'2012-11-20 14:45:42',1),(1143,'Dom jednorodzinny',0,0,1143,'1938.54,-1911.29,15.26','1935.87,-1911.35,15.03, 90',3,NULL,1,3000,NULL,'2013-03-02 23:04:07',1),(1144,'Dom jednorodzinny',0,0,1144,'2488.36,11.76,28.44','2488.35,8.65,27.78, 180',21,NULL,1,3700,NULL,'2013-03-13 23:07:19',1),(1145,'Dom jednorodzinny',0,0,1145,'2509.44,11.76,28.44','2509.55,8.72,27.80, 180',21,NULL,0,3600,NULL,'2013-01-31 23:08:01',1),(1146,'Dom jednorodzinny',0,0,1146,'2411.22,-5.59,27.68','2410.54,-3.14,26.86, 0',15,NULL,0,3500,NULL,'2013-03-01 23:01:18',1),(1147,'Dom jednorodzinny',0,0,1147,'2411.22,21.77,27.68','2409.59,26.59,27.68, 0',13,16019,0,3100,'2013-08-22','2013-08-08 13:32:21',1),(1148,'Dom jednorodzinny',0,0,1148,'2270.49,-7.50,28.15','2270.29,-11.64,27.43, 180',36,NULL,1,3900,NULL,'2013-07-03 19:14:26',1),(1149,'Dom jednorodzinny',0,0,1149,'2245.47,-1.66,28.15','2245.50,-5.82,27.45, 180',21,NULL,0,3800,NULL,'2013-03-14 23:07:21',1),(1151,'Dom jednorodzinny',0,0,1176,'2045.45,-1116.65,26.36','2048.28,-1115.64,25.59, 270',NULL,NULL,1,2800,NULL,'2012-11-20 14:45:42',1),(1168,'Melina',0,0,NULL,'2625.93,-1098.68,69.36,94.0','2628.95,-1098.52,69.38,273.1',15,NULL,0,2000,NULL,'2013-03-26 23:06:43',1),(1150,'Dom jednorodzinny',0,0,1175,'2022.88,-1120.27,26.42,0.8','2022.81,-1121.98,26.20, 180',6,NULL,0,2500,NULL,'2013-08-08 08:42:01',1),(1153,'Dom jednorodzinny',0,0,1153,'2323.85,191.15,28.44','2326.96,191.18,27.78, 270',21,NULL,1,3800,NULL,'2013-04-08 22:06:09',1),(181,'Dom jednopokojowy',0,0,NULL,'142.65,-1470.37,25.21,135.1','143.82,-1468.42,25.20,319.3',37,NULL,0,3000,NULL,'2013-03-27 23:06:45',1),(1152,'Dom jednorodzinny',0,0,1152,'2364.00,187.19,28.44','2360.62,187.22,27.72, 90',21,NULL,0,3500,NULL,'2013-04-23 22:03:18',1),(1172,'Ekskluzywny dom',0,0,3138,'1527.78,-772.55,80.58','1526.73,-773.80,80.33,138.6',177,15334,1,5000,'2013-08-18','2013-08-11 14:32:18',1),(1165,'Apartament \'Trupa\'',0,0,1165,'891.21,-783.15,101.31','889.77,-779.72,101.27, 25',27,13982,1,5000,'2013-08-28','2013-08-14 20:43:05',1),(1154,'Dom jednorodzinny',0,0,1154,'2364.00,166.15,28.44','2360.64,166.15,27.73, 90',13,NULL,1,4100,NULL,'2013-04-11 22:08:59',1),(1155,'Dom jednorodzinny',0,0,1155,'2323.85,162.22,28.44','2327.02,162.40,27.77, 270',6,NULL,1,4000,NULL,'2013-03-14 23:07:21',1),(180,'Mieszkanie',0,0,NULL,'2797.78,-1245.37,47.39,354.6','2797.66,-1248.46,46.96,175.5',37,NULL,1,3000,NULL,'2013-04-15 22:08:01',1),(179,'Rezydencja',0,0,NULL,'298.85,-1338.50,53.44,209.7','297.06,-1335.90,53.44,35.5',27,15541,1,5000,'2013-08-27','2013-08-14 18:41:17',1),(182,'Dom jednopokojowy',0,0,NULL,'2427.42,-1135.79,34.71,6.0','2427.24,-1138.60,34.22,176.1',8,NULL,0,2300,NULL,'2013-02-12 23:07:21',1),(183,'Dom jednorodzinny',0,0,1183,'1285.27,-1091.46,28.26,271.2','1283.14,-1091.48,28.20,89.5',38,NULL,1,3800,NULL,'2013-04-11 22:08:59',1),(184,'Dom jednorodzinny',0,0,NULL,'1241.95,-1075.22,31.55,93.6','1244.91,-1075.21,31.05,271.0',NULL,NULL,0,3500,NULL,'2012-11-20 14:45:42',1),(185,'Melina',0,0,NULL,'1954.37,-1075.03,24.80,77.9','1956.59,-1075.50,24.80,260.0',4,NULL,1,1900,NULL,'2013-08-06 21:18:29',1),(1156,'Melina',0,0,NULL,'1959.59,-1070.05,24.80,263.1','1957.98,-1069.75,24.80,80.1',4,NULL,0,1900,NULL,'2013-08-06 21:18:29',1),(1157,'Dom jednorodzinny',0,0,1157,'1241.95,-1075.12,31.55,94.2','1244.08,-1075.15,31.49,268.2',38,NULL,1,3800,NULL,'2013-04-13 22:07:46',1),(1158,'Dom luksus',0,0,NULL,'228.01,-1405.47,51.61,150.9','228.77,-1403.71,51.61,334.3',37,NULL,1,4000,NULL,'2013-08-08 08:42:01',1),(1159,'Dom jednorodzinny',0,0,1159,'2203.85,106.15,28.44','2206.94,106.09,27.78, 270',13,NULL,0,3200,NULL,'2013-07-28 17:10:40',1),(1160,'Dom jednorodzinny',0,0,1160,'2373.85,42.25,28.44','2376.96,42.20,27.78, 270',5,NULL,1,3400,NULL,'2013-02-14 23:07:26',1),(1161,'Dom jednorodzinny',0,0,1161,'2373.85,22.01,28.44','2377.07,21.94,27.85, 270',15,NULL,0,3300,NULL,'2013-03-12 23:07:16',1),(1162,'Willa',0,0,1162,'1095.05,-647.91,113.65','1094.78,-646.56,113.65,3.4',14,14260,1,6000,'2013-08-11','2013-08-10 18:24:50',1),(1163,'Melina',0,0,NULL,'2514.59,-1240.46,39.34','2514.57,-1242.99,39.02,180',10,NULL,0,2200,NULL,'2012-12-15 23:06:15',1),(1164,'Melina',0,0,NULL,'2469.18,-1278.40,30.37,268.6','2467.13,-1278.04,29.92,92.3',4,NULL,0,1900,NULL,'2013-06-22 17:19:12',1),(1166,'Apartament \'u Szkota\'',0,0,1166,'253.20,-1270.00,74.43','251.56,-1267.61,72.89, 35',27,16289,0,5000,'2013-08-15','2013-08-13 13:05:52',1),(1169,'Melina',0,0,NULL,'2627.64,-1085.15,69.72,95.4','2629.79,-1085.18,69.62,265.8',24,NULL,0,2000,NULL,'2013-03-30 23:06:54',1),(1170,'Melina',0,0,NULL,'2628.10,-1067.96,69.72,86.4','2631.48,-1067.87,69.63,266.4',24,NULL,0,2000,NULL,'2013-03-26 23:06:43',1),(1171,'Melina',0,0,NULL,'2625.94,-1112.63,68.00,85.8','2630.44,-1114.21,67.78,261.0',10,NULL,1,2200,NULL,'2013-03-29 23:06:52',1),(1173,'Ekskluzywny dom',0,0,3139,'1535.03,-800.19,72.86','1532.81,-800.21,72.61,90.8',178,15728,0,6554,'2013-08-24','2013-08-15 09:35:52',1),(1174,'Willa na wzgorzu',0,0,NULL,'1298.57,-797.99,84.14','1298.57,-799.91,84.14,181.8',116,16019,1,6554,'2013-08-13','2013-08-17 19:24:12',1),(1183,'Wiejski domek',0,0,1183,'1566.84,23.20,24.16,264.9','1564.69,23.33,24.16,89.1',14,15222,1,2500,'2013-08-16','2013-08-02 08:19:43',1),(1203,'Melina',0,0,NULL,'1969.35,-1654.67,15.97,358.3','1969.69,-1656.91,15.97,181.7',21,NULL,1,100,NULL,'2013-06-08 00:37:09',1),(1176,'Dom \'Wally\'ego\'',0,0,NULL,'2259.42,-1019.11,59.30','2258.30,-1024.82,59.28, 135',5,NULL,1,5000,NULL,'2013-01-03 23:05:33',1),(1177,'Dom \'samotnika\'',0,0,NULL,'2287.52,-1081.06,48.25','2292.06,-1082.08,47.60, 258',4,NULL,0,3100,NULL,'2013-04-06 22:05:55',1),(1178,'Dom \'szklarza\'',0,0,NULL,'2278.76,-1077.42,48.24','2274.97,-1074.12,47.68, 53',8,NULL,0,2200,NULL,'2013-04-06 22:05:55',1),(1184,'Dom jednorodzinny',0,0,1184,'207.08,-112.35,4.90','206.46,-109.56,4.90, 0',1,NULL,1,2500,NULL,'2012-12-13 23:06:10',1),(1179,'Luksusowe mieszkanie',0,0,NULL,'1468.67,-906.17,54.84,174.4','1468.86,-904.18,54.84,354.4',37,NULL,0,6000,NULL,'2013-07-10 19:47:35',1),(1180,'Dom jednorodzinny',0,0,1180,'2308.82,-1714.33,14.98','2308.70,-1717.19,14.33, 180',2,NULL,0,2800,NULL,'2013-07-03 19:14:26',1),(1181,'Dom jednorodzinny',0,0,1181,'2326.78,-1716.70,14.24','2326.81,-1718.81,13.55, 180',2,NULL,1,2600,NULL,'2013-06-08 00:37:09',1),(1182,'Dom jednorodzinny',0,0,1182,'2326.88,-1681.91,14.93','2330.77,-1682.00,14.27, 270',3,NULL,0,3100,NULL,'2013-06-08 00:37:09',1),(1198,'Melina',0,0,NULL,'178.27,-120.23,1.55,177.5','178.35,-117.73,1.55,0.5',4,NULL,0,2000,NULL,'2013-04-02 22:07:02',1),(1196,'Melina',0,0,NULL,'2072.50,-1559.31,13.41,179.0','2072.62,-1557.47,13.41,0.2',4,NULL,1,2100,NULL,'2013-01-13 23:05:57',1),(1185,'Dom jednorodzinny',0,0,1185,'189.43,-120.23,1.55','189.56,-117.50,1.55, 0',1,NULL,0,2400,NULL,'2013-01-29 23:07:56',1),(1186,'Dom jednorodzinny',0,0,1186,'166.34,-94.97,1.55,9.7','166.28,-97.41,1.55, 180',3,NULL,0,3000,NULL,'2013-04-02 22:07:02',1),(1187,'Dom jednorodzinny',0,0,NULL,'252.89,-92.39,3.54','249.59,-92.23,2.84, 90',15,NULL,0,3700,NULL,'2013-04-09 22:06:15',1),(1188,'Dom jednorodzinny',0,0,NULL,'312.73,-92.43,3.54','315.83,-92.36,2.87, 270',5,NULL,0,3300,NULL,'2013-03-11 23:07:14',1),(1189,'Dom jednorodzinny',0,0,1189,'312.72,-121.26,3.54','315.74,-121.40,2.90, 270',6,NULL,1,3500,NULL,'2013-03-22 23:06:33',1),(1190,'Melina',0,0,NULL,'2076.15,-1588.67,13.49','2074.02,-1586.87,13.49, 55',4,NULL,1,2000,NULL,'2013-01-11 23:05:52',1),(1191,'Melina',0,0,NULL,'2065.29,-1583.36,13.48','2067.55,-1585.56,13.49, 224',4,NULL,0,2000,NULL,'2013-01-16 23:09:14',1),(1192,'Melina',0,0,1192,'2066.69,-1554.09,13.44','2068.64,-1556.29,13.43, 234',1,NULL,0,2300,NULL,'2013-03-30 23:06:54',1),(1193,'Melina',0,0,1193,'2072.27,-1551.42,13.42','2070.12,-1554.29,13.42, 140',1,NULL,1,2200,NULL,'2013-01-16 23:09:14',1),(1194,'Melina',0,0,1194,'2073.37,-1583.05,13.47','2071.31,-1585.21,13.49, 150',1,NULL,0,2300,NULL,'2013-07-28 17:10:40',1),(1195,'Melina',0,0,NULL,'2066.96,-1562.16,13.43','2068.81,-1559.27,13.42, 312',4,NULL,0,2100,NULL,'2013-03-30 23:06:54',1),(1199,'Melina',0,0,NULL,'166.27,-120.23,1.55,181.2','166.31,-118.13,1.55,359.9',10,NULL,1,2200,NULL,'2013-06-22 17:19:12',1),(1197,'Apartament \'u Struga\'',0,0,NULL,'219.25,-1249.80,78.34','220.87,-1252.37,78.29, 219',27,NULL,1,5000,NULL,'2013-07-10 19:47:35',1),(1201,'Melina',0,0,NULL,'166.29,-96.97,4.90,359.8','166.21,-98.18,4.90,176.9',24,NULL,0,2000,NULL,'2013-02-19 23:00:53',1),(1202,'Melina',0,0,NULL,'166.34,-118.23,4.90,187.3','166.22,-117.03,4.90,359.4',15,NULL,0,2000,NULL,'2012-12-05 23:07:47',1),(1204,'Melina',0,0,NULL,'1973.35,-1654.67,15.97,360.0','1973.18,-1657.32,15.97,179.4',21,NULL,0,2000,NULL,'2013-02-25 23:01:08',1),(1205,'Melina',0,0,NULL,'1969.98,-1671.19,15.97,357.2','1969.80,-1673.25,15.97,177.2',4,NULL,1,2000,NULL,'2013-03-18 23:08:25',1),(1206,'Melina',0,0,NULL,'1974.77,-1671.20,15.97,8.6','1974.50,-1673.49,15.97,178.9',4,NULL,1,2000,NULL,'2013-04-03 22:07:04',1),(1207,'Melina',0,0,NULL,'1978.76,-1671.53,16.19,268.5','1977.16,-1671.19,16.19,82.8',4,NULL,0,2000,NULL,'2013-03-13 23:07:19',1),(1208,'Melina',0,0,NULL,'1970.01,-1671.19,18.55,354.7','1967.80,-1671.52,17.81,93.0',4,NULL,1,2000,NULL,'2013-03-11 23:07:14',1),(1209,'Melina',0,0,NULL,'1978.76,-1671.38,18.55,265.5','1976.45,-1671.46,18.55,85.5',4,NULL,1,2000,NULL,'2013-03-13 23:07:19',1),(1210,'Domek',0,0,1210,'2013.58,-1656.33,14.14','2012.49,-1656.15,13.55,84.3',6,NULL,1,2200,NULL,'2013-04-11 22:08:59',1),(1211,'Melina',0,0,NULL,'2244.45,-1637.61,16.24,342.9','2243.90,-1638.90,15.91,162.9',15,NULL,0,2000,NULL,'2013-07-18 17:55:02',1),(1212,'Domek na wsi',0,0,NULL,'374.59,-76.71,1.38,0.7','374.52,-78.15,1.38,176.1',24,NULL,0,2200,NULL,'2013-03-25 23:06:40',1),(1221,'Dom jednorodzinny',0,0,1221,'2209.67,-1240.25,24.48','2209.81,-1237.40,23.93, 0',1,NULL,0,3700,NULL,'2013-06-08 00:37:09',1),(1220,'Dom jednorodzinny',0,0,1220,'2249.85,-1238.91,25.90','2250.04,-1235.19,25.51, 0',6,15178,0,4000,'2013-08-19','2013-08-06 10:19:29',1),(1214,'Stara chata Gulivera',0,0,NULL,'920.47,222.38,34.04','919.38,219.90,34.06, 157',4,NULL,1,1500,NULL,'2013-04-06 22:05:55',1),(1213,'Dom w bloku',0,0,NULL,'1972.21,-1633.72,15.97,3.4','1972.09,-1636.19,15.97,178.1',15,NULL,0,3139,NULL,'2013-02-27 23:01:13',1),(1215,'Stara chata na grobli',0,0,NULL,'1337.88,-184.51,17.94','1336.26,-187.29,17.70, 149',4,NULL,1,1500,NULL,'2013-03-27 23:06:45',1),(1216,'Stara chata Salomona',0,0,NULL,'-339.46,195.25,9.75','-339.03,192.28,9.59, 186',4,NULL,0,1500,NULL,'2013-04-03 22:07:04',1),(1217,'Stara chata rolnika',0,0,NULL,'-40.86,-10.69,3.32','-39.70,-8.07,3.12, 339',4,NULL,0,1500,NULL,'2013-04-02 22:07:02',1),(1218,'Stara chata drwala',0,0,NULL,'385.87,-605.72,38.40','388.73,-606.28,38.19, 251',4,NULL,0,1500,NULL,'2013-06-08 00:37:09',1),(1219,'Stara chata drwala',0,0,NULL,'450.19,-376.74,31.76','452.13,-378.80,30.73, 222',4,NULL,0,1500,NULL,'2013-06-08 00:37:09',1),(1222,'Dom jednorodzinny',0,0,1222,'2191.81,-1239.24,24.49','2191.78,-1236.17,23.98, 0',2,NULL,1,3800,NULL,'2013-06-08 00:37:09',1),(1223,'Dom jednorodzinny',0,0,1223,'2229.62,-1241.59,25.66','2229.46,-1239.15,25.39, 0',1,NULL,0,3900,NULL,'2013-06-08 00:37:09',1),(1224,'Dom jednorodzinny',0,0,1224,'2207.93,-1280.82,25.12','2207.81,-1283.36,24.53, 180',5,NULL,0,4000,NULL,'2013-06-08 00:37:09',1),(1225,'Dom jednorodzinny',0,0,1225,'2230.13,-1280.06,25.63','2230.18,-1283.62,25.37, 180',2,NULL,0,4000,NULL,'2013-03-12 23:07:16',1),(1226,'Dom jednorodzinny',0,0,1226,'2091.04,-1277.84,26.18','2090.93,-1281.07,25.59, 180',2,NULL,0,4200,NULL,'2013-04-09 22:06:15',1),(1227,'Dom jednorodzinny',0,0,1227,'2132.31,-1280.05,25.89','2132.30,-1283.56,25.53, 180',6,NULL,1,4200,NULL,'2013-04-12 22:09:01',1),(1228,'Dom jednorodzinny',0,0,1228,'2153.74,-1243.80,25.37','2153.82,-1240.10,24.98, 0',1,NULL,1,3700,NULL,'2013-06-08 00:37:09',1),(1229,'Dom jednorodzinny',0,0,1229,'2110.90,-1244.40,25.85','2110.90,-1241.02,25.51, 0',5,NULL,0,3900,NULL,'2013-07-18 17:55:02',1),(1230,'Dom jednorodzinny',0,0,1230,'2152.21,-1446.39,26.11','2149.25,-1446.20,25.54, 90',5,NULL,1,3600,NULL,'2013-01-08 15:43:56',1),(1231,'Dom jednorodzinny',0,0,1231,'2150.92,-1419.08,25.92','2147.87,-1418.96,25.63, 90',1,NULL,1,4100,NULL,'2013-03-07 23:06:14',1),(1232,'Dom jednorodzinny',0,0,1232,'2188.55,-1419.28,26.16','2191.40,-1419.24,25.73, 270',1,NULL,0,4200,NULL,'2013-07-18 17:55:02',1),(1233,'Dom jednorodzinny',0,0,1233,'2190.45,-1470.36,25.91','2193.58,-1470.49,25.61, 270',6,NULL,0,3800,NULL,'2013-04-02 22:07:02',1),(1234,'Dom pietrowy',0,0,1234,'2126.68,-1320.87,26.62','2126.73,-1316.97,25.54, 0',35,NULL,1,3800,NULL,'2013-04-11 12:08:55',1),(1235,'Dom jednorodzinny',0,0,1235,'2148.51,-1320.08,26.07','2148.84,-1316.49,25.55, 0',6,NULL,1,3300,NULL,'2013-04-05 22:05:36',1),(1236,'Dom jednorodzinny',0,0,1236,'2147.71,-1366.12,25.97','2147.74,-1369.29,25.54, 180',3,NULL,1,3100,NULL,'2013-03-08 22:16:45',1),(1240,'Wielorodzinna melina',0,0,1240,'2744.22,-1947.37,13.55','2748.29,-1945.38,13.55, 270',10,16083,0,4700,'2013-08-11','2013-08-09 09:05:32',1),(1237,'Dom jednorodzinnny',0,0,1237,'1955.12,-1115.39,27.83','1956.05,-1118.36,26.84, 180',21,NULL,0,3200,NULL,'2013-08-08 08:42:01',1),(1239,'Wielorodzinna melina',0,0,1239,'2744.28,-1941.31,13.55','2748.41,-1943.59,13.55, 270',10,16041,0,4700,'2013-08-09','2013-08-08 13:11:42',1),(1238,'Dom jednorodzinnny',0,0,1238,'1906.05,-1112.95,26.66','1905.91,-1115.86,25.66, 180',6,NULL,0,3500,NULL,'2013-08-08 08:42:01',1),(1241,'Wielorodzinna melina',0,0,1241,'2793.60,-1947.69,13.55','2790.01,-1945.29,13.55, 90',10,NULL,1,4700,NULL,'2013-08-08 08:41:35',1),(1242,'Wielorodzinna melina',0,0,1242,'2793.59,-1941.63,13.55','2789.86,-1943.72,13.55, 90',10,NULL,1,4700,NULL,'2013-08-08 08:41:37',1);
/*!40000 ALTER TABLE `lss_domy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lss_egzaminy`
--

DROP TABLE IF EXISTS `lss_egzaminy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lss_egzaminy` (
  `kod` varchar(16) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `opis` text CHARACTER SET utf8 NOT NULL,
  `waznosc` int(10) unsigned NOT NULL DEFAULT '7',
  `min_pytan` int(10) unsigned DEFAULT NULL,
  `min_odpowiedzi` mediumint(8) unsigned NOT NULL,
  `koszt` mediumint(8) unsigned NOT NULL DEFAULT '2500',
  PRIMARY KEY (`kod`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lss_egzaminy`
--

LOCK TABLES `lss_egzaminy` WRITE;
/*!40000 ALTER TABLE `lss_egzaminy` DISABLE KEYS */;
INSERT INTO `lss_egzaminy` VALUES ('POLICJA-WSTEPNY',0,'Egzamin wstępny do policji',7,10,9,2500),('LOTNICZY-L1',1,'Egzamin lotniczy, kategoria L1',14,9,9,75000),('LOTNICZY-H1',0,'Egzamin lotniczy, kategoria H1',14,NULL,0,2500);
/*!40000 ALTER TABLE `lss_egzaminy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lss_egzaminy_gracze`
--

DROP TABLE IF EXISTS `lss_egzaminy_gracze`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lss_egzaminy_gracze` (
  `id_gracza` int(10) unsigned NOT NULL,
  `kod` varchar(16) NOT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_gracza`,`kod`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lss_egzaminy_gracze`
--

LOCK TABLES `lss_egzaminy_gracze` WRITE;
/*!40000 ALTER TABLE `lss_egzaminy_gracze` DISABLE KEYS */;
/*!40000 ALTER TABLE `lss_egzaminy_gracze` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lss_egzaminy_pytania`
--

DROP TABLE IF EXISTS `lss_egzaminy_pytania`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lss_egzaminy_pytania` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `kod` varchar(16) NOT NULL,
  `pytanie` text CHARACTER SET utf8 NOT NULL,
  `odp1` text CHARACTER SET utf8 NOT NULL,
  `odp2` text CHARACTER SET utf8 NOT NULL,
  `odp3` text CHARACTER SET utf8,
  `odp4` text CHARACTER SET utf8,
  `odpw` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lss_egzaminy_pytania`
--

LOCK TABLES `lss_egzaminy_pytania` WRITE;
/*!40000 ALTER TABLE `lss_egzaminy_pytania` DISABLE KEYS */;
INSERT INTO `lss_egzaminy_pytania` VALUES (11,'LOTNICZY-L1','Do czego służą lotki w samolocie?','Do przechylania samolotu','Do zmiany wysokości','Do wysuwania podwozia',NULL,1),(12,'LOTNICZY-L1','Co oznacza termin \"przeciągnięcie\"?','Nagły spadek prędkości i utrata siły nośnej','Zbyt duża prędkość','Zbyt wielkie pochylenie samolotu',NULL,1),(14,'LOTNICZY-L1','Wyjaśnij pojęcie \"ATC\"','Airport Tower Center','Air Two Crash','Air Traffic Control',NULL,3),(15,'LOTNICZY-L1','Co oznacza skrót \"ILS\"?\r\n   ','Instytut Lotnictwa Szybowcowego','Instrument Landing System','Instrument Lights System',NULL,2),(16,'LOTNICZY-L1','Do czego służy ILS ?','Do automatycznego naprowadzania samolou na pas','Do automatycznego wyhamowania samolotu po lądowaniu','Do do automatycznego chowania i wysuwania podwozia ',NULL,1),(17,'LOTNICZY-L1','Co to jest odwracacz ciągu?','Dodaje maszynie większej mocy podczas startu','Utrzymuje prędkość podczas podejścia','Pomaga zatrzymać samolot po zetknięciu z pasem',NULL,3),(18,'LOTNICZY-L1','Co oznacza słowo \"STALL\"?','Przeciągnięcie','Zbyt szybkie wznoszenie','System radarowy na lotniskach',NULL,1),(19,'LOTNICZY-L1','Jak nazywa się ster w samolocie ?','Wolant','Joystick','pad',NULL,1),(20,'LOTNICZY-L1','Ile trwał pierwszy lot na świecie ?','12 sek','4 min','1 godz',NULL,1);
/*!40000 ALTER TABLE `lss_egzaminy_pytania` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lss_faction`
--

DROP TABLE IF EXISTS `lss_faction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lss_faction` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `payout` mediumint(8) unsigned NOT NULL DEFAULT '500',
  `public` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `skrot` varchar(2) CHARACTER SET ascii NOT NULL,
  `postbox` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `skrot` (`skrot`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lss_faction`
--

LOCK TABLES `lss_faction` WRITE;
/*!40000 ALTER TABLE `lss_faction` DISABLE KEYS */;
INSERT INTO `lss_faction` VALUES (1,'Urząd Miasta',170,1,'UM','1497.13,-1749.50,15.45,359.4'),(2,'Policja',150,1,'DP',NULL),(3,'Warsztat I',0,1,'W1',NULL),(4,'Sluzby miejskie',140,1,'SM',NULL),(5,'Redakcja CNN',130,1,'RC',NULL),(6,'Pogotowie',160,1,'CM','2041.79,-1406.99,13.55, 180'),(7,'Taxi',0,0,'TX',NULL),(8,'Ośrodek Szkolenia Kierowców I',0,1,'L1','1044.20,-1296.34,13.55, 90'),(9,'Kurier',60,1,'KU',NULL),(10,'Importer',140,1,'I',NULL),(11,'Straz Pozarna',150,1,'DS',NULL),(12,'Warsztat II',0,1,'W2','664.47,-137.55,25.26,180'),(13,'Warsztat III',0,1,'W3','2288.97,-107.46,26.47, 0'),(14,'Kopalnia',0,0,'GK','1060.20,-352.73,73.99, 180'),(17,'Sad',150,1,'SR','1373.75,-1084.15,24.96, 75.2'),(15,'Ochrona',0,0,'SQ','2175.82,-1763.88,13.55, 320'),(16,'Ośrodek Szkolenia Kierowców II',0,1,'L2','1037.82,-944.73,42.76, 188.5'),(18,'Warsztat IV',0,1,'W4',NULL),(19,'Warsztat V',0,1,'W5',NULL),(20,'Służba więzienna',110,1,'SW','2770.18,-2483.61,13.65,94.7'),(21,'Służby kościelne',100,1,'SK',NULL),(22,'Sluzby Specjalne',150,1,'SS','1234.00,-1454.92,13.55,270'),(23,'Przychodnia lekarska',0,0,'PL','2273.85,133.30,26.48,0'),(24,'Tartak',0,0,'T1',NULL),(25,'Ośrodek Szkolenia Pilotów',0,0,'L3','1438.38,-2281.37,13.55, 90'),(26,'Usługi gastonomiczne - Sklep \'na rogu\'',0,0,'1',NULL),(27,'Usługi gastonomiczne - Sklep Spożywczy \'Strug\'',0,0,'2',NULL),(28,'Usługi gastonomiczne - Knajpka \'na molo\'',0,0,'3',NULL),(29,'Usługi gastonomiczne - Restauracja \'The Well Stacked Pizza\'',0,0,'4',NULL),(30,'Usługi gastonomiczne - Restauracja \'Hot-Food\'',0,0,'5',NULL),(31,'Usługi gastonomiczne - Market \'Prima\'',0,0,'6',NULL),(32,'Usługi gastonomiczne - Market \'Super Sam\'',0,0,'7',NULL),(33,'Usługi gastonomiczne - Kawiarnia \'pod sceną\'',0,0,'8',NULL),(34,'Usługi gastonomiczne - Knajpa \'Paszcza Wieloryba\'',0,0,'9',NULL),(35,'Departament Turystyki',130,1,'DT','2798.44,-1077.99,30.72,180'),(36,'Usługi gastonomiczne - Knajpa \'Isaura\'',0,0,'10',NULL),(37,'Usługi gastonomiczne - Market \'Łubin\'',0,0,'11',NULL),(38,'Usługi gastonomiczne - Restauracja \'Przy skarpie\'',0,0,'12',NULL),(39,'Usługi gastonomiczne - Knajpa \'Diabelski młyn\'',0,0,'13',NULL),(40,'Klub Miasta Los Santos',0,0,'',NULL);
/*!40000 ALTER TABLE `lss_faction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lss_faction_ranks`
--

DROP TABLE IF EXISTS `lss_faction_ranks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lss_faction_ranks` (
  `faction_id` int(10) unsigned NOT NULL,
  `rank_id` int(10) unsigned NOT NULL,
  `name` varchar(64) CHARACTER SET utf8 NOT NULL,
  `perm_doors` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'czy moze otwierac/zamykac drzwi (lss_budynki)',
  `payout_share` smallint(3) unsigned NOT NULL DEFAULT '100',
  PRIMARY KEY (`rank_id`,`faction_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lss_faction_ranks`
--

LOCK TABLES `lss_faction_ranks` WRITE;
/*!40000 ALTER TABLE `lss_faction_ranks` DISABLE KEYS */;
INSERT INTO `lss_faction_ranks` VALUES (3,1,'Praktykant',0,100),(2,1,'Kadet',0,50),(2,3,'Sierżant',0,70),(2,5,'Kapitan',0,70),(2,7,'Zastępca Szefa Policji',0,80),(4,2,'Pracownik fizyczny',0,80),(4,1,'Praktykant',0,50),(8,1,'Pomocnik',0,100),(3,2,'Mechanik',0,100),(4,3,'Pracownik techniczny',0,80),(4,4,'Kierownik',1,90),(7,1,'Sprzątaczka',0,100),(8,2,'Instruktor',0,100),(6,4,'Rezydent',1,70),(7,2,'Praktykant',1,100),(1,1,'Kontroler',0,50),(1,2,'Urzednik',0,70),(1,3,'Minister',0,80),(1,4,'Z-ca prezydenta',1,100),(5,1,'Stażysta',1,50),(5,2,'Redaktor',1,75),(5,3,'Reporter',0,75),(3,3,'Kierownik',1,100),(9,1,'Praktykant',0,100),(9,2,'Pracownik',0,100),(9,3,'Kurier',0,100),(10,1,'Importer',0,33),(10,2,'Importer II',0,67),(10,3,'Importer III',1,100),(12,1,'Praktykant',0,100),(6,3,'Ratownik medyczny',1,70),(11,2,'Strażak',0,60),(11,3,'Starszy strażak',0,70),(11,4,'Dowódca roty',0,80),(11,5,'Pomocnik dowódcy sekcji',0,80),(11,6,'Dowódca sekcji',0,80),(11,7,'Z-ca dowódcy plutonu',0,80),(11,8,'Dowódca plutonu',0,100),(11,9,'Prezydent Miasta',0,0),(7,3,'Początkujący kierowca',1,100),(8,3,'Kierownik',1,100),(5,4,'Kierownik',0,80),(5,5,'Zastępca redaktora naczelnego',1,100),(6,2,'Technik Ratownik Medyczny',1,50),(12,4,'Własciciel',1,100),(12,2,'Mechanik',0,100),(12,3,'Kierownik',0,100),(13,2,'Mechanik',0,100),(13,3,'Blacharz',0,100),(13,4,'Lakiernik',0,100),(14,1,'Górnik',0,100),(14,2,'Kierownik',0,100),(14,3,'Dyrektor',1,100),(15,1,'Praktykant',1,100),(15,2,'Ochroniarz',0,100),(16,1,'Pomocnik',0,100),(16,2,'Instruktor',0,100),(16,3,'Kierownik',1,100),(15,3,'Mechanik',0,100),(13,5,'Kierownik',1,100),(15,4,'Sekretarz',0,100),(15,5,'Właściciel',1,100),(17,3,'Adwokat',0,70),(17,1,'Stażysta',0,50),(17,4,'Prokurator',0,70),(17,6,'Prezes',0,100),(17,5,'Sędzia',0,80),(2,2,'Policjant',0,70),(6,1,'Stażysta',1,50),(2,8,'Szef Policji',1,100),(2,4,'Porucznik',0,70),(2,6,'Komendant',0,70),(5,6,'Redaktor naczelny',1,100),(13,6,'Właściciel',1,100),(18,1,'Stażysta',0,100),(18,2,'Mechanik',0,100),(18,4,'Kierownik / menedżer',0,100),(18,5,'Właściciel',1,100),(19,1,'Praktykant',0,100),(19,2,'Lakiernik',0,100),(19,3,'Blacharz',0,100),(19,4,'Mechanik',0,100),(19,5,'Kierownik',1,100),(1,5,'Prezydent',1,100),(4,5,'Dyrektor',1,100),(2,9,'Prezydent Miasta',0,0),(13,1,'Praktykant',0,100),(9,4,'Kierownik',1,100),(9,5,'Własciciel',1,100),(3,4,'Dyrektor',1,100),(20,1,'Strażnik',0,50),(33,2,'Sprzedawca',1,100),(20,2,'Oddziałowy',1,70),(20,3,'Zastępca naczelnika',1,80),(20,4,'Naczelnik',1,100),(21,3,'Kościelny',1,70),(21,4,'Ministrant',1,0),(21,5,'Ksiądz',1,75),(21,6,'Pralat',1,100),(6,5,'Lekarz ogólny',1,70),(6,6,'Lekarz ze specjalizacją',1,80),(6,7,'Z-ca ordynatora',1,90),(6,8,'Ordynator',1,100),(7,4,'Wykwalifikowany kierowca',1,100),(7,5,'Doświadczony kierowca',1,100),(7,6,'Prywatny kierowca',1,100),(7,7,'Kierownik',1,100),(7,8,'Dyrektor',1,100),(22,2,'Funkcjonariusz SWAT',1,50),(22,3,'Funkcjonariusz CRASH',1,50),(18,3,'Elektryk',0,100),(23,3,'Właściciel',1,100),(23,2,'Lekarz',0,100),(23,1,'Stażysta',0,100),(8,4,'Zastępca dyrektora',1,100),(8,5,'Dyrektor',1,100),(21,2,'Konserwator',1,100),(21,1,'Grabarz',1,100),(22,5,'Dowódca CRASH',1,80),(22,4,'Dowódca SWAT',1,80),(22,7,'Prezydent Miasta',6,0),(24,1,'Praktykant',1,100),(24,2,'Drwal',1,100),(24,3,'Kierowca wózka widłowego',1,100),(24,4,'Kierownik',1,100),(24,5,'Właściciel',1,100),(11,1,'Stażysta',1,50),(4,6,'Prezydent Miasta',0,0),(5,7,'Prezydent Miasta',0,0),(6,9,'Prezydent Miasta',0,0),(17,7,'Prezydent Miasta',0,0),(20,5,'Prezydent Miasta',0,0),(21,7,'Prezydent Miasta',0,0),(25,1,'Stażysta',1,0),(25,2,'Pilot',1,0),(25,3,'Właściciel',1,0),(22,6,'Dyrektor',1,100),(16,4,'Zastępca Dyrektora',1,100),(16,5,'Dyrektor',1,100),(22,1,'Kadet',1,40),(17,2,'Notariusz',1,60),(19,6,'Z-ca właściciela',1,100),(19,7,'Właściciel',1,100),(26,1,'Praktykant',1,100),(26,2,'Sprzedawca',1,100),(26,3,'Właściciel',1,100),(27,3,'Właściciel',1,100),(27,2,'Sprzedawca',1,100),(27,1,'Praktykant',1,100),(28,1,'Praktykant',1,100),(28,2,'Sprzedawca',1,100),(28,3,'Właściciel',1,100),(29,1,'Praktykant',1,100),(29,2,'Sprzedawca',1,100),(29,3,'Właściciel',1,100),(30,1,'Praktykant',1,100),(30,2,'Sprzedawca',1,100),(30,3,'Właściciel',1,100),(31,1,'Praktykant',1,100),(31,2,'Sprzedawca',1,100),(31,3,'Właściciel',1,100),(32,1,'Praktykant',1,100),(32,2,'Sprzedawca',1,100),(32,3,'Właściciel',1,100),(33,3,'Właściciel',1,100),(33,1,'Praktykant',1,100),(34,1,'Praktykant',1,100),(34,2,'Sprzedawca',1,100),(34,3,'Właściciel',1,100),(35,1,'Stażysta',0,55),(35,2,'Kierowca łodzi',0,57),(35,3,'Kierowca autokaru',0,60),(35,4,'Ratownik',0,65),(35,5,'Przewodnik',0,70),(35,6,'Kierownik',1,80),(36,1,'Praktykant',1,100),(36,2,'Sprzedawca',1,100),(36,3,'Właściciel',1,100),(37,1,'Praktykant',1,100),(37,2,'Sprzedawca',1,100),(37,3,'Właściciel',1,100),(38,1,'Praktykant',1,100),(38,2,'Sprzedawca',1,100),(38,3,'Właściciel',1,100),(35,7,'Z-ca prezesa',1,90),(35,9,'Prezydent miasta',0,0),(35,8,'Prezes',1,100),(39,3,'Właściciel',1,100),(39,2,'Sprzedawca',1,100),(39,1,'Praktykant',1,100),(40,4,'Prezydent Miasta',1,0),(40,3,'Kierownik',1,0),(40,2,'Prowadzący',1,0),(40,1,'Uczestnik',0,0);
/*!40000 ALTER TABLE `lss_faction_ranks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lss_faction_skins`
--

DROP TABLE IF EXISTS `lss_faction_skins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lss_faction_skins` (
  `faction_id` int(10) unsigned NOT NULL,
  `skin` smallint(3) unsigned NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lss_faction_skins`
--

LOCK TABLES `lss_faction_skins` WRITE;
/*!40000 ALTER TABLE `lss_faction_skins` DISABLE KEYS */;
INSERT INTO `lss_faction_skins` VALUES (2,280),(2,281),(2,71),(15,165),(2,284),(4,16),(4,27),(4,153),(4,260),(3,50),(3,305),(5,98),(5,187),(5,185),(22,71),(2,211),(6,274),(6,275),(6,276),(6,70),(11,277),(11,278),(11,279),(6,76),(6,148),(6,216),(15,219),(2,266),(2,166),(2,286),(14,27),(15,236),(15,71),(17,224),(17,229),(17,237),(17,238),(17,225),(17,235),(22,285),(22,70),(6,91),(22,265),(13,50),(18,50),(18,305),(19,50),(19,305),(2,51),(2,52),(13,305),(1,147),(1,52),(7,171),(7,172),(7,142),(2,267),(20,130),(15,164),(20,99),(20,71),(20,79),(20,225),(21,68),(21,235),(2,282),(2,283),(2,285),(2,246),(12,50),(12,305),(5,219),(22,286),(22,17),(22,163),(22,164),(22,165),(22,166),(22,187),(24,302),(24,16),(24,78),(24,79),(24,128),(24,159),(24,161),(24,202),(24,31),(24,157),(24,201),(22,185),(22,186),(22,251),(17,163),(17,164),(17,166),(17,187),(2,288),(6,219),(26,11),(26,38),(26,37),(26,155),(26,167),(26,168),(26,171),(26,171),(26,172),(26,205),(26,209),(26,216),(32,216),(32,209),(32,205),(32,172),(32,171),(32,171),(32,168),(32,167),(32,155),(32,37),(32,38),(32,11),(37,11),(37,38),(37,37),(37,155),(37,167),(37,168),(37,171),(37,171),(37,172),(37,205),(37,209),(37,216),(36,11),(36,38),(36,11),(36,38),(36,37),(36,155),(36,155),(36,167),(36,168),(36,171),(36,171),(36,171),(36,172),(36,205),(36,209),(36,216),(34,11),(34,38),(34,37),(34,155),(34,167),(34,168),(34,171),(34,171),(34,172),(34,205),(34,209),(34,216),(33,11),(33,38),(33,37),(33,155),(33,167),(33,168),(33,171),(33,171),(33,172),(33,205),(33,209),(33,216),(31,11),(31,38),(31,37),(31,155),(31,167),(31,168),(31,171),(31,171),(31,172),(31,205),(31,209),(31,216),(30,11),(30,38),(30,37),(30,155),(30,167),(30,168),(30,171),(30,171),(30,172),(30,205),(30,209),(30,216),(29,11),(29,38),(29,37),(29,155),(29,167),(29,167),(29,168),(29,171),(29,171),(29,172),(29,205),(29,209),(29,216),(28,11),(28,38),(28,37),(28,155),(28,167),(28,168),(28,171),(28,171),(28,172),(28,205),(28,209),(28,216),(27,11),(27,38),(27,37),(27,155),(27,167),(27,168),(27,171),(27,171),(27,172),(27,205),(27,209),(27,216),(38,37),(37,155),(37,167),(37,171),(37,172),(37,205),(37,209),(37,216),(37,38),(37,11),(28,38),(28,216),(38,216),(38,209),(38,38),(38,172),(38,205),(38,172),(38,171),(38,168),(38,167),(38,155),(38,37),(38,11),(38,155),(38,167),(35,11),(35,14),(35,15),(35,17),(35,20),(35,35),(35,36),(35,46),(35,76),(35,97),(35,141),(11,255),(11,194),(39,155),(39,37),(39,167),(39,216),(39,209),(39,38),(39,172),(39,205),(39,171),(39,167),(39,155),(39,11),(39,168),(11,64),(3,32),(12,32),(18,32),(19,32),(13,32);
/*!40000 ALTER TABLE `lss_faction_skins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lss_faction_wplaty`
--

DROP TABLE IF EXISTS `lss_faction_wplaty`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lss_faction_wplaty` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `char_id` int(10) unsigned NOT NULL,
  `faction_id` int(10) unsigned NOT NULL,
  `kwota` int(10) unsigned NOT NULL,
  `tytul` text CHARACTER SET utf8 COLLATE utf8_polish_ci NOT NULL,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  KEY `id` (`id`),
  KEY `faction_id` (`faction_id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lss_faction_wplaty`
--

LOCK TABLES `lss_faction_wplaty` WRITE;
/*!40000 ALTER TABLE `lss_faction_wplaty` DISABLE KEYS */;
/*!40000 ALTER TABLE `lss_faction_wplaty` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lss_importpojazdow`
--

DROP TABLE IF EXISTS `lss_importpojazdow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lss_importpojazdow` (
  `vid` int(10) unsigned NOT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lss_importpojazdow`
--

LOCK TABLES `lss_importpojazdow` WRITE;
/*!40000 ALTER TABLE `lss_importpojazdow` DISABLE KEYS */;
/*!40000 ALTER TABLE `lss_importpojazdow` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lss_infoboards`
--

DROP TABLE IF EXISTS `lss_infoboards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lss_infoboards` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nazwa` varchar(64) CHARACTER SET utf8 NOT NULL,
  `tresc` text CHARACTER SET utf8 NOT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `restrict_faction` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lss_infoboards`
--

LOCK TABLES `lss_infoboards` WRITE;
/*!40000 ALTER TABLE `lss_infoboards` DISABLE KEYS */;
INSERT INTO `lss_infoboards` VALUES (1,'Harmonogram','Tablica jest czysta','2013-08-18 10:36:43',8),(2,'Harmonogram','Tablica jest czysta','2013-08-18 10:36:43',2),(157,'Tablica informacyjna wydziału MPU','Tablica jest czysta','2013-08-18 10:36:43',2),(3,'Tablica informacyjna','Tablica jest czysta','2013-08-18 10:36:43',3),(4,'Szpital w Los Santos','Tablica jest czysta','2013-08-18 10:36:43',6),(5,'UM Los Santos','Tablica jest czysta','2013-08-18 10:36:43',10),(6,'Regulamin strzelnicy','Tablica jest czysta','2013-08-18 10:36:43',10),(7,'Ogłoszenia służb miejskich','Tablica jest czysta','2013-08-18 10:36:43',4),(126,'Tablica informacyjna','Tablica jest czysta','2013-08-18 10:36:43',10),(127,'Import pojazdów','Tablica jest czysta','2013-08-18 10:36:43',10),(125,'Zasady rejestracji pojazdow','Tablica jest czysta','2013-08-18 10:36:43',10),(114,'Harmonogram','Tablica jest czysta','2013-08-18 10:36:43',17),(8,'AJ - Admin Jail','Tablica jest czysta','2013-08-18 10:36:43',10),(9,'CNN News','Tablica jest czysta','2013-08-18 10:36:43',5),(12,'Wydział architektoniczny','Tablica jest czysta','2013-08-18 10:36:43',1),(13,'Tablica informacyjna','Tablica jest czysta','2013-08-18 10:36:43',11),(161,'Tablica informacyjna (2)','Tablica jest czysta','2013-08-18 10:36:43',11),(166,'Kafejka internetowa','Tablica jest czysta','2013-08-18 10:36:43',1),(14,'Harmonogram','Tablica jest czysta','2013-08-18 10:36:43',11),(11,'Historia medyczna','Tablica jest czysta','2013-08-18 10:36:43',6),(150,'Tablica informacyjna','Tablica jest czysta','2013-08-18 10:36:43',23),(151,'Harmonogram','Tablica jest czysta','2013-08-18 10:36:43',32),(152,'Przydzielanie / Pobieranie pojazdów','Tablica jest czysta','2013-08-18 10:36:43',32),(15,'Harmonogram','Tablica jest czysta','2013-08-18 10:36:43',7),(115,'Tablica informacyjna','Tablica jest czysta','2013-08-18 10:36:43',17),(103,'Tablica informacyjna','Tablica jest czysta','2013-08-18 10:36:43',9),(16,'UM - prace dorywcze','Tablica jest czysta','2013-08-18 10:36:43',10),(95,'Tablica ze zleceniami','Tablica jest czysta','2013-08-18 10:36:43',12),(17,'Skoroszyt','Tablica jest czysta','2013-08-18 10:36:43',1),(93,'Piętra w urzędzie','Tablica jest czysta','2013-08-18 10:36:43',10),(94,'Wizyty','Tablica jest czysta','2013-08-18 10:36:43',1),(163,'Skoroszyt','Tablica jest czysta','2013-08-18 10:36:43',17),(96,'Informacje mechaników','Tablica jest czysta','2013-08-18 10:36:43',12),(97,'Tablica informacyjna','Tablica jest czysta','2013-08-18 10:36:43',4),(99,'Harmonogram','Tablica jest czysta','2013-08-18 10:36:43',3),(104,'Harmonogram','Tablica jest czysta','2013-08-18 10:36:43',9),(100,'Tablica informacyjna','Tablica jest czysta','2013-08-18 10:36:43',13),(101,'Harmonogram','Tablica jest czysta','2013-08-18 10:36:43',13),(102,'Tablica informacyjna','Tablica jest czysta','2013-08-18 10:36:43',6),(113,'Tablica informacyjna','Tablica jest czysta','2013-08-18 10:36:43',17),(105,'Tablica informacyjna','Tablica jest czysta','2013-08-18 10:36:43',7),(109,'Tablica informacyjna','Tablica jest czysta','2013-08-18 10:36:43',15),(110,'Harmonogram','Tablica jest czysta','2013-08-18 10:36:43',15),(108,'Tablica informacyjna','Tablica jest czysta','2013-08-18 10:36:43',8),(111,'Tablica informacyjna','Tablica jest czysta','2013-08-18 10:36:43',16),(112,'Harmonogram','Tablica jest czysta','2013-08-18 10:36:43',16),(106,'Tablica informacyjna','Tablica jest czysta','2013-08-18 10:36:43',14),(107,'Harmonogram','Tablica jest czysta','2013-08-18 10:36:43',14),(116,'Parking płatny *strzeżony*','Tablica jest czysta','2013-08-18 10:36:43',10),(117,'Harmonogram','Tablica jest czysta','2013-08-18 10:36:43',5),(118,'Zasady dla użytkowników parkingu','Tablica jest czysta','2013-08-18 10:36:43',10),(119,'Tablica informacyjna','Tablica jest czysta','2013-08-18 10:36:43',18),(120,'Harmonogram','Tablica jest czysta','2013-08-18 10:36:43',18),(124,'Informacje wyborcze','Tablica jest czysta','2013-08-18 10:36:43',1),(121,'Tablica informacyjna','Tablica jest czysta','2013-08-18 10:36:43',19),(122,'Harmonogram','Tablica jest czysta','2013-08-18 10:36:43',19),(123,'Harmonogram','Tablica jest czysta','2013-08-18 10:36:43',19),(156,'Lista zatrzymanych','Tablica jest czysta','2013-08-18 10:36:43',22),(134,'Przydzielanie / Pobieranie pojazdów','Tablica jest czysta','2013-08-18 10:36:43',1),(135,'Przydzielanie / Pobieranie pojazdów','Tablica jest czysta','2013-08-18 10:36:43',2),(136,'Przydzielanie / Pobieranie pojazdów','Tablica jest czysta','2013-08-18 10:36:43',4),(137,'Przydzielanie / Pobieranie pojazdów','Tablica jest czysta','2013-08-18 10:36:43',5),(138,'Przydzielanie / Pobieranie pojazdów','Tablica jest czysta','2013-08-18 10:36:43',6),(139,'Przydzielanie / Pobieranie pojazdów','Tablica jest czysta','2013-08-18 10:36:43',7),(140,'Przydzielanie / Pobieranie pojazdów','Tablica jest czysta','2013-08-18 10:36:43',8),(164,'Skoroszyt','Tablica jest czysta','2013-08-18 10:36:43',2),(141,'Przydzielanie / Pobieranie pojazdów','Tablica jest czysta','2013-08-18 10:36:43',9),(165,'Zeszyt','Tablica jest czysta','2013-08-18 10:36:43',6),(142,'Przydzielanie / Pobieranie pojazdów','Tablica jest czysta','2013-08-18 10:36:43',11),(143,'Przydzielanie / Pobieranie pojazdów','Tablica jest czysta','2013-08-18 10:36:43',14),(144,'Przydzielanie / Pobieranie pojazdów','Tablica jest czysta','2013-08-18 10:36:43',16),(167,'Zeszyt','Tablica jest czysta','2013-08-18 10:36:43',5),(145,'Przydzielanie / Pobieranie pojazdów','Tablica jest czysta','2013-08-18 10:36:43',17),(146,'Przydzielanie / Pobieranie pojazdów','Tablica jest czysta','2013-08-18 10:36:43',20),(128,'Lista zatrzymanych','Tablica jest czysta','2013-08-18 10:36:43',2),(129,'Tablica informacyjna wydziału HSIU','Tablica jest czysta','2013-08-18 10:36:43',2),(131,'Kodeks więźnia','Tablica jest czysta','2013-08-18 10:36:43',20),(132,'Tablica informacyjna','Tablica jest czysta','2013-08-18 10:36:43',20),(133,'Lista skazańców','Tablica jest czysta','2013-08-18 10:36:43',20),(154,'Harmonogram','Tablica jest czysta','2013-08-18 10:36:43',25),(155,'Przydzielanie / Pobieranie pojazdów','Tablica jest czysta','2013-08-18 10:36:43',25),(130,'Harmonogram','Tablica jest czysta','2013-08-18 10:36:43',20),(147,'Tablica informacyjna','Tablica jest czysta','2013-08-18 10:36:43',22),(148,'Harmonogram','Tablica jest czysta','2013-08-18 10:36:43',22),(149,'Przydzielanie / Pobieranie pojazdów','Tablica jest czysta','2013-08-18 10:36:43',22),(153,'Tablica informacyjna','Tablica jest czysta','2013-08-18 10:36:43',25),(158,'Tablica informacyjna','Tablica jest czysta','2013-08-18 10:36:43',35),(159,'Harmonogram','Tablica jest czysta','2013-08-18 10:36:43',35),(160,'Przydzielanie / Pobieranie pojazdów','Tablica jest czysta','2013-08-18 10:36:43',35),(162,'Tablica informacyjna','Tablica jest czysta','2013-08-18 10:36:43',10),(168,'Zeszyt','Tablica jest czysta','2013-08-18 10:36:43',11),(169,'Zeszyt','Tablica jest czysta','2013-08-18 10:36:43',4),(170,'Zeszyt','Tablica jest czysta','2013-08-18 10:36:43',17);
/*!40000 ALTER TABLE `lss_infoboards` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lss_interiory`
--

DROP TABLE IF EXISTS `lss_interiory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lss_interiory` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `interior` smallint(5) unsigned NOT NULL DEFAULT '0',
  `entrance` varchar(64) NOT NULL COMMENT 'x,y,z,a - miejsce gdzie pojawi sie gracz po wejsciu',
  `exit` varchar(64) DEFAULT NULL COMMENT 'x,y,z - miejsce gdzie bedzie marker wyjscia',
  `opis` varchar(64) DEFAULT NULL COMMENT 'opis do wyszukiwarki',
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `dimension` int(10) unsigned DEFAULT NULL,
  `koszt` mediumint(8) unsigned NOT NULL DEFAULT '5000',
  `notes` text,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lss_interiory`
--

LOCK TABLES `lss_interiory` WRITE;
/*!40000 ALTER TABLE `lss_interiory` DISABLE KEYS */;
INSERT INTO `lss_interiory` VALUES (1,3,'1531.33,-8.66,1002.10,177.3','1531.42,-6.72,1002.10','dom jednopokojowy',1,NULL,50000,NULL),(2,2,'1522.70,-47.97,1002.13, 270','1520.70,-47.95,1002.13','dom jednopokojowy',1,NULL,50000,NULL),(3,3,'518.54,-9.21,1001.57,85.9','521.14,-9.20,1001.57','dom jednopokojowy',1,NULL,50000,NULL),(4,1,'245.43,304.87,999.15,272.8','243.72,305.01,999.15','1 pokoik',1,NULL,50000,NULL),(5,2,'2466.83,-1698.29,1013.51,90.1','2468.84,-1698.32,1013.51','dom jednorodzinny',1,NULL,50000,NULL),(6,1,'2526.14,-1679.47,1215.50,273.1','2524.09,-1679.31,1215.50','dom jednorodzinny',1,NULL,50000,NULL),(7,3,'2495.97,-1694.24,1014.74,177.2','2496.01,-1692.08,1014.74','dom pietrowy',1,NULL,50000,NULL),(8,2,'268.43,305.06,999.15,270.7','266.50,304.99,999.15','dom jednopokojowy',1,NULL,50000,NULL),(9,2,'0.02,-3.18,999.43,86.0','2.06,-3.12,999.43','przyczepa kampingowa',1,NULL,50000,NULL),(10,5,'2350.54,-1180.92,1027.98,87.5','2352.94,-1180.93,1027.98','dom wielorodzinny',1,NULL,50000,NULL),(11,10,'420.56,2536.70,10.00,91.3','422.57,2536.48,10.00','dom jednopokojowy',0,NULL,50000,NULL),(12,14,'256.33,-41.76,1002.02,269.2','254.17,-41.53,1002.03','przebieralnia',1,NULL,50000,NULL),(13,5,'2233.81,-1113.07,1050.88,2.3','2233.66,-1115.26,1050.88','dom jednopokojowy',1,NULL,50000,NULL),(14,9,'2317.88,-1024.79,1250.21,359.5','2317.79,-1026.77,1250.22','dom wielorodzinny',1,NULL,50000,NULL),(15,10,'2261.58,-1136.09,1050.63,275.5','2259.38,-1135.85,1050.64','dom jednorodzinny',1,NULL,50000,NULL),(16,3,'235.39,1188.52,1080.26,3.7','235.30,1186.68,1080.26','dom pietrowy',0,NULL,50000,NULL),(17,2,'225.05,1240.00,1082.14,90.5','226.79,1239.98,1082.14','dom jednorodzinny',0,NULL,50000,NULL),(18,1,'223.18,1288.53,1082.14,359.4','223.09,1287.08,1082.14','dom jednorodzinny',0,NULL,50000,NULL),(19,5,'228.33,1114.16,1080.99,268.8','226.30,1114.30,1080.99','dom jednorodzinny',0,NULL,50000,NULL),(20,15,'295.10,1474.27,1080.26,358.6','295.10,1472.26,1080.26','dom jednorodzinny',0,NULL,50000,NULL),(21,12,'446.75,508.74,1201.42,0.5','446.73,506.32,1201.42','dom jednopokojowy',1,NULL,50000,NULL),(22,5,'228.86,1114.38,1080.99,267.6','226.29,1114.30,1080.99','dom pietrowy',0,NULL,50000,NULL),(23,4,'261.04,1285.87,1080.26,359.3','261.01,1284.29,1080.26','dom jednorodzinny',0,NULL,50000,NULL),(24,4,'300.77,312.78,999.15,272.9','298.91,312.94,999.15','dom jednorodzinny',1,NULL,50000,NULL),(25,10,'24.16,1341.84,1084.38,0.9','23.98,1340.16,1084.38','dom pietrowy',0,NULL,50000,NULL),(26,4,'221.61,1142.24,1082.61,359.4','221.86,1140.20,1082.61','dom jednorodzinny',0,NULL,50000,NULL),(27,12,'2324.43,-1147.31,1050.71,358.5','2324.46,-1149.54,1050.71','dom pietrowy - luksus',1,NULL,50000,NULL),(28,4,'-262.52,1456.57,1084.37,86.2','-260.49,1456.69,1084.37','dom pietrowy',0,NULL,50000,NULL),(29,5,'23.05,1405.43,1084.43,358.2','22.83,1403.32,1084.44','dom jednorodzinny',0,NULL,50000,NULL),(30,5,'140.44,1368.35,1083.86,358.4','140.25,1365.92,1083.86','dom pietrowy - luksus',1,NULL,50000,NULL),(31,6,'234.17,1066.13,1084.21,358.1','234.18,1063.72,1084.21','dom pietrowy - luksus',0,NULL,50000,NULL),(32,6,'-68.67,1353.26,1080.21,359.0','-68.83,1351.21,1080.21','dom jednorodzinny',0,NULL,50000,NULL),(33,15,'-285.27,1471.11,1084.38,83.6','-283.44,1471.03,1084.38','dom pietrowy',0,NULL,50000,NULL),(34,2,'2189.43,1628.88,1043.39,89.0','2191.18,1628.77,1043.39','dom luksus',0,NULL,50000,NULL),(35,8,'2807.57,-1172.89,1025.57,357.8','2807.63,-1174.75,1025.57','dom pietrowy',1,NULL,50000,NULL),(36,1,'2216.50,-1076.20,1050.48,90.6','2218.40,-1076.27,1050.48','dom jednopokojowy',1,NULL,50000,NULL),(37,2,'2237.53,-1079.64,1049.02,359.4','2237.53,-1081.64,1049.02','dom luksus',1,NULL,50000,NULL),(38,8,'2365.33,-1133.73,1250.88,358.6','2365.29,-1135.59,1250.88','dom luksus',1,NULL,50000,NULL),(39,8,'-42.50,1407.55,1084.43,2.8','-42.57,1405.47,1084.43','dom jednorodzinny',0,NULL,50000,NULL),(40,9,'83.30,1324.73,1083.86,358.4','83.05,1322.28,1083.87','dom pietrowy - luksus',0,NULL,50000,NULL),(41,9,'260.72,1239.19,1084.26,1.1','260.74,1237.23,1084.26','dom jednorodzinny',0,NULL,50000,NULL),(42,44,'1656.47,2181.13,1.94,266.5','1653.73,2180.93,1.93','dom w kanalach 1',0,NULL,50000,NULL),(43,44,'2359.74,2426.02,-2.24,179.4','2359.61,2428.71,-2.24','dom w kanalach 2',0,NULL,50000,NULL),(44,44,'2585.39,1483.38,-10.71,0.6','2584.82,1480.64,-10.66','dom w kanalach 3',0,NULL,50000,NULL),(45,44,'1553.67,659.13,-10.07,240.6','1550.07,660.76,-10.29','dom w kanalach 4',0,NULL,50000,NULL),(46,44,'2781.68,1463.74,-11.52,177.1','2781.95,1465.58,-11.52','dom w kanalach 5',0,NULL,50000,NULL),(47,44,'2571.02,2105.30,-11.18,259.4','2567.11,2106.19,-11.21','dom w kanalach 6',0,NULL,50000,NULL),(48,11,'2003.68,1012.46,138.22,2.7','2003.68,1010.63,138.22','Pomieszczenie w kasynie',1,NULL,50000,NULL),(49,3,'387.93,173.93,1008.38,92.7','390.77,173.76,1008.38','Bank',1,NULL,50000,NULL),(50,5,'1299.01,-794.97,1084.01,355.9','1298.96,-797.01,1084.01','Apartament - baza gangow',1,NULL,50000,NULL),(51,18,'1726.87,-1640.47,20.22,177.9','1727.02,-1637.84,20.22','wiezowiec',1,NULL,50000,NULL),(52,15,'2216.58,-1150.30,1025.80,272.6','2214.38,-1150.48,1025.80','hotel',1,NULL,100000,NULL),(53,0,'2306.38,-15.24,26.75,0',NULL,NULL,1,NULL,50000,NULL),(54,3,'1494.56,1305.56,1093.29,354.2','1494.41,1303.58,1093.29','sala konferencyjna',0,NULL,50000,NULL),(55,2,'2430.36,-2677.78,2035.17, 0',NULL,NULL,1,NULL,50000,NULL),(56,1,'2268.15,1647.45,1084.23,276.7','2265.88,1647.47,1084.23','hote',0,NULL,50000,NULL),(57,10,'2016.35,1017.69,996.88,89.2','2019.07,1017.85,996.88','kasyno',0,NULL,50000,NULL),(58,1,'2234.22,1712.32,1011.79,180.3','2233.90,1714.68,1012.38','kasyno',0,NULL,50000,NULL),(59,12,'1133.24,-13.30,1000.68,357.4','1133.16,-15.83,1000.68','kasyno',1,NULL,50000,NULL),(60,3,'973.20,-8.51,1001.15,90.1','975.32,-8.66,1001.15','burdel',1,NULL,50000,NULL),(61,3,'965.66,-53.15,1001.12,91.8','968.16,-53.17,1001.12','burdel',1,NULL,50000,NULL),(62,3,'831.44,7.66,1004.18,86.8','834.67,7.41,1004.19','bank',1,NULL,50000,NULL),(63,3,'1212.09,-28.18,1000.95,179.2','1212.16,-25.87,1000.95','burdel',1,NULL,50000,NULL),(64,2,'1205.08,-11.76,1000.92,357.8','1204.74,-13.85,1000.92','burdel',1,NULL,50000,NULL),(65,3,'-2636.80,1404.81,906.46,354.9','-2636.67,1402.47,906.46','burdel',0,NULL,50000,NULL),(66,5,'459.12,-109.20,999.51,356.2','458.91,-111.35,999.51','restauracja',1,NULL,50000,NULL),(67,5,'372.49,-131.32,1001.49,359.3','372.27,-133.52,1001.49','restauracja',1,NULL,50000,NULL),(68,17,'377.32,-191.32,1000.63,357.4','377.13,-193.31,1000.63','restauracja',1,NULL,50000,NULL),(69,1,'453.55,-18.18,1001.13,92.4','455.31,-19.52,1001.13','restauracja',1,NULL,50000,NULL),(70,10,'364.67,-73.49,1001.51,310.0','362.86,-75.15,1001.51','restauracja',1,NULL,50000,NULL),(71,17,'493.50,-22.96,1000.68,357.5','493.38,-24.87,1000.68','dyskoteka',1,NULL,50000,NULL),(72,1,'681.58,-449.30,-25.63,175.5','681.54,-446.39,-25.61','bar',1,NULL,50000,NULL),(73,18,'-226.86,1400.90,27.77,268.8','-229.29,1401.23,27.77','bar',1,NULL,50000,NULL),(74,4,'457.88,-88.21,999.55,88.4','460.56,-88.65,999.55','restauracja',1,NULL,50000,NULL),(75,6,'441.94,-51.52,999.68,180.1','441.94,-49.48,999.68','restauracja',1,NULL,50000,NULL),(76,6,'744.47,1441.93,1102.70,180.5','744.43,1443.72,1102.70','restauracjo-burdel',0,NULL,50000,NULL),(77,9,'365.33,-9.69,1001.85,359.1','364.80,-11.70,1001.85','restauracja',1,NULL,50000,NULL),(78,11,'502.06,-70.06,998.76,181.1','501.92,-67.56,998.76','bar',1,NULL,50000,NULL),(79,3,'207.12,-136.74,1002.87,359.7','207.00,-140.38,1003.51','sklep odziezowy',1,NULL,50000,NULL),(80,3,'-100.31,-22.77,1000.72,358.3','-100.36,-25.04,1000.72','sexshop',1,NULL,50000,NULL),(81,17,'-25.87,-186.25,1003.55,356.5','-25.95,-188.25,1003.55','sklep spozywczy',1,NULL,50000,NULL),(82,5,'225.20,-7.89,1002.21,89.6','227.49,-8.17,1002.21','sklep odziezowy',1,NULL,50000,NULL),(83,10,'6.33,-29.25,1003.55,359.7','6.04,-31.77,1003.55','sklep spozywczy',1,NULL,50000,NULL),(84,1,'203.81,-48.13,1001.80,356.9','203.73,-50.67,1001.80','sklep odziezowy',1,NULL,50000,NULL),(85,18,'-30.82,-89.96,1003.55,1.5','-30.98,-92.01,1003.55','sklep spozywczy',1,NULL,50000,NULL),(86,18,'161.67,-94.20,1001.80,0.6','161.36,-97.11,1001.80','sklep odziezowy',1,NULL,50000,NULL),(87,14,'204.48,-167.00,1000.52,3.1','204.34,-168.85,1000.52','sklep odziezowy',1,NULL,50000,NULL),(88,16,'-25.66,-139.31,1003.55,356.2','-25.91,-141.56,1003.55','sklep spozywczy',1,NULL,50000,NULL),(89,15,'207.78,-109.51,1005.13,2.5','207.65,-111.26,1005.13','sklep odziezowy',1,NULL,50000,NULL),(90,0,'663.06,-573.63,16.34,0',NULL,NULL,1,NULL,50000,NULL),(91,4,'-27.61,-29.24,1003.56,2.1','-27.29,-31.76,1003.56','sklep spozywczy',1,NULL,50000,NULL),(92,6,'-2239.11,137.04,1035.41,269.8','-2240.78,137.20,1035.41','sklep z zabawkami',1,NULL,50000,NULL),(93,6,'-27.58,-55.50,1003.55,2.6','-27.33,-58.25,1003.55','sklep spozywczy',1,NULL,50000,NULL),(94,3,'418.86,-82.44,1001.80,358.8','418.63,-84.37,1001.80','salon fryzjerski',1,NULL,50000,NULL),(95,3,'-204.31,-42.65,1002.27,3.3','-204.39,-44.40,1002.27','salon fryzjerski',1,NULL,50000,NULL),(96,17,'-204.32,-7.19,1002.27,2.2','-204.38,-9.08,1002.27','salon fryzjerski',1,NULL,50000,NULL),(97,2,'411.87,-21.08,1001.80,357.8','411.56,-23.17,1001.80','salon fryzjerski',1,NULL,50000,NULL),(98,16,'-204.35,-25.46,1002.27,355.3','-204.40,-27.35,1002.27','salon fryzjerski',1,NULL,50000,NULL),(99,12,'412.21,-52.35,1001.90,0.6','411.96,-54.45,1001.90','salon fryzjerski',1,NULL,50000,NULL),(100,1,'-1401.63,104.33,1032.24,181.4','-1401.71,107.32,1032.27','dd2',1,NULL,50000,NULL),(101,7,'-1406.16,-265.37,1043.66,347.6','-1407.32,-269.54,1043.66','tor wyscigowy',1,NULL,50000,NULL),(102,10,'-1127.73,1057.78,1346.41,272.3','-1131.51,1057.85,1346.42','plan filmowy',0,NULL,50000,NULL),(103,14,'-1464.55,1559.16,1052.53,357.5','-1464.68,1555.93,1052.53','arena stunt',0,NULL,50000,NULL),(104,15,'-1431.27,938.66,1036.56,355.3','-1432.08,935.07,1036.47','dd',0,NULL,50000,NULL),(105,4,'-1423.92,-663.82,1059.77,267.7','-1428.17,-663.59,1060.16','tor wyscigowy',1,NULL,50000,NULL),(106,16,'-1395.57,1244.47,1039.87,180.6','-1395.62,1249.50,1039.87','dd3',0,NULL,50000,NULL),(107,5,'772.27,-3.19,1000.73,359.6','772.30,-5.52,1000.73','silownia',1,NULL,50000,NULL),(108,7,'773.94,-76.46,1000.65,357.7','773.88,-78.85,1000.66','silownia',1,NULL,50000,NULL),(109,6,'774.15,-47.68,1000.59,358.0','774.11,-50.48,1000.59','silownia',1,NULL,50000,NULL),(110,3,'612.49,-125.08,997.99,267.3','609.35,-125.09,997.99','garaz',1,NULL,50000,NULL),(111,2,'612.79,-76.40,997.99,270.1','609.27,-76.83,997.99','garaz',1,NULL,50000,NULL),(112,1,'606.62,-10.50,1000.91,273.2','604.05,-9.96,1000.89','warsztat samochodowy',1,NULL,50000,NULL),(113,18,'1282.37,-65.66,1008.28,327.3','1310.57,4.02,1002.49','hala',1,NULL,50000,'zbugowany, czasami ma schody a czasami nie!'),(114,1,'1416.73,4.45,1000.92,90.9','1420.37,4.17,1002.39','hala',1,NULL,50000,NULL),(115,1,'-2042.56,154.90,28.84,85.6','-2039.86,155.13,28.84','warsztat samochodowy',0,NULL,50000,NULL),(116,2,'2550.44,-1293.33,1060.98,338.7','2548.80,-1294.68,1060.98','fabryka kokainy',1,NULL,50000,NULL),(117,17,'-959.75,1954.45,9.00,179.3','-959.58,1956.46,9.00','elektrownia-wnetrze tamy',0,NULL,50000,NULL),(119,1,'962.45,2160.24,1011.03,91.4','964.93,2160.12,1011.03','magazyn',0,NULL,50000,NULL),(120,10,'1886.63,1017.70,31.88,269.8','1883.70,1017.82,31.88','magazyn',0,NULL,50000,NULL),(121,3,'238.77,141.21,1003.02,0.7','238.61,138.73,1003.02','komisariat policji',1,NULL,50000,NULL),(122,10,'246.51,110.51,1003.22,354.4','246.43,107.30,1003.22','komisariat policji',1,NULL,50000,NULL),(123,5,'322.09,304.37,999.15,356.6','322.15,302.36,999.15','komisariat policji',1,NULL,50000,NULL),(124,6,'247.09,65.55,1003.64,0.4','246.82,62.33,1003.64','komisariat policji',1,NULL,50000,NULL),(125,7,'315.66,-141.32,999.60,358.2','315.79,-143.66,999.60','sklep z bronia',1,NULL,50000,NULL),(126,1,'285.55,-39.38,1001.52,356.3','285.34,-41.70,1001.52','sklep z bronia',1,NULL,50000,NULL),(127,4,'285.86,-84.08,1001.52,358.6','285.82,-86.76,1001.52','sklep z bronia',1,NULL,50000,NULL),(128,6,'297.15,-110.11,1001.52,358.6','296.85,-112.07,1001.52','sklep z bronia',1,NULL,50000,NULL),(129,6,'316.37,-168.00,999.59,355.4','316.37,-170.29,999.59','sklep z bronia',1,NULL,50000,NULL),(130,3,'1041.48,10.16,1001.28,84.7','1044.05,10.29,1001.28','pomieszczenie muzyczne',1,NULL,50000,NULL),(131,1,'-2158.75,640.91,1052.38,181.5','-2158.65,643.14,1052.38','poczekalnia',0,NULL,50000,NULL),(132,1,'2.13,23.13,1199.59,88.2','4.38,22.96,1199.60','samolot',1,NULL,50000,NULL),(133,6,'345.86,304.99,999.15,270.5','343.72,305.01,999.15','pokoj tortur',1,NULL,50000,NULL),(134,9,'316.04,974.82,1961.26,0.8','315.82,972.02,1961.87','andromeda',1,NULL,50000,NULL),(135,3,'291.37,310.16,999.15,88.2','293.22,309.99,999.15','stodola',1,NULL,50000,NULL),(136,14,'-1864.94,55.73,1055.53,0',NULL,'lotnisko',1,NULL,50000,NULL),(137,14,'-1833.25,-58.54,1058.96,358.9','-1833.55,-64.22,1059.11','lotnisko2',1,NULL,50000,NULL),(138,1,'-788.71,493.48,1381.61,354.2','-788.37,489.36,1381.59','libertycity',1,NULL,50000,NULL),(139,1,'1040.55,-1422.93,1438.42,2.3','1040.51,-1424.34,1438.42','Klub Cafe',1,29,50000,NULL),(140,1,'2412.14,-1771.95,1414.75,90.0','2413.69,-1771.94,1415.53','Silownia GS',1,24,50000,NULL),(141,2,'2107.44,-1805.95,2001.49, 0','2107.28,-1808.49,2001.49','The Well Stacked Pizza',1,1,50000,NULL),(142,2,'2332.01,-1270.79,2041.75, 0','2332.01,-1273.54,2041.75','Komis samochodowy \'Angelo\'',1,2,50000,NULL),(143,2,'2430.36,-2677.78,2035.17, 0','2430.28,-2680.48,2035.17','Import pojazdow',1,3,50000,NULL),(145,1,'1035.03,-941.83,1471.64,0','1035.05,-944.26,1471.64','Osrodek Szkolenia Kierowcow nr II',1,32,50000,NULL),(146,2,'2410.75,-1229.00,2000.92, 0','2410.78,-1231.63,2000.92','Pig Pen',1,6,50000,NULL),(147,2,'2389.10,-1915.24,2000.64, 0','2389.10,-1917.35,2000.64','Hot-Food',1,5,50000,NULL),(148,1,'2129.48,-1143.91,1439.67, 180','2129.57,-1141.83,1439.66','Komis samochodowy \'Titanic\'',1,25,50000,NULL),(149,1,'1024.45,-1302.95,1235.87, 0','1024.50,-1305.05,1235.87','Osrodek Szkolenia Kierowcow nr I',1,27,50000,NULL),(150,1,'712.66,-1388.09,1759.17, 90','715.38,-1388.18,1759.17','Firma kurierska',1,48,50000,NULL),(151,0,'684.28,-117.36,25.43, 0','684.19,-118.78,25.43','Warsztat II',1,0,50000,NULL),(152,2,'2284.29,-116.25,2026.53, 0','2284.40,-117.85,2026.53','Warsztat III',1,7,50000,NULL),(153,1,'1927.80,-1776.48,1419.86, 90','1929.19,-1776.45,1419.86','Warsztat I',1,6,50000,NULL),(154,1,'1122.14,-1808.53,1440.49, 270','1120.30,-1808.62,1440.49','Baza taxi',1,13,50000,NULL),(155,1,'2176.27,-1771.33,1422.51, 90','2177.75,-1771.37,1422.51','Osrodek Ochrony Cywilnej',1,31,50000,NULL),(156,2,'1211.13,238.64,2083.51, 270','1209.02,238.68,2083.51','Warsztat IV',1,8,50000,NULL),(157,2,'95.43,-150.48,2041.15, 0','95.41,-152.42,2041.15','Warsztat V',1,9,50000,NULL),(158,1,'2692.65,-1826.21,1436.49, 349.1','2691.97,-1829.26,1436.48','Stadion',1,24,87500,NULL),(159,2,'1713.41,-1766.16,2000.68, 0','1713.37,-1768.68,2000.68','Silver Club',1,10,22500,NULL),(160,2,'535.34,-1304.23,2035.17, 0','535.24,-1306.48,2035.17','Komis samochodowy \'Smiling Central\'',1,11,2500,NULL),(161,2,'373.30,-2057.70,2007.56, 90','375.48,-2057.61,2007.56','Knajpa na molo',1,14,10000,NULL),(162,2,'1347.29,-1764.70,2035.42, 270','1345.97,-1764.63,2035.41','Spozywczy',1,13,15000,NULL),(163,2,'1348.21,-1764.62,2035.48, 270','1345.97,-1764.61,2035.48','Sklep na rogu',1,12,15000,NULL),(164,2,'2246.43,-1721.23,2000.73, 0','2246.44,-1723.18,2000.73','Silownia_1',1,15,5000,NULL),(165,2,'2748.89,-1465.29,2031.85, 0','2748.91,-1467.31,2031.85','Lodziarnia',1,16,100000,NULL),(167,2,'2259.14,74.81,2181.54, 270','2256.71,74.81,2181.54','Market \'Prima\'',1,19,175000,NULL),(168,2,'2570.98,-1458.41,2053.65, 270','2568.15,-1458.50,2053.65','Biblioteka \'u Greka\'',1,18,125000,NULL),(169,2,'231.03,-179.11,2181.54, 270','228.70,-179.19,2181.54','Market Super Sam',1,20,175000,NULL),(170,2,'786.34,-1038.82,2000.73, 0','786.42,-1041.18,2000.73','Silownia 2',1,21,50000,NULL),(171,2,'1320.86,380.36,2200.66, 0','1320.88,378.11,2200.66','Silownia 3',1,22,50000,NULL),(172,2,'2441.03,111.14,2285.42, 90','2443.84,111.08,2285.42','Komis samochodowy \'Sunset Beach\'',1,33,100000,NULL),(173,2,'318.75,-44.73,2022.39, 45','320.88,-46.39,2022.39','Komis samochodowy \'Nemo\'',1,34,50000,NULL),(174,2,'686.19,-1871.31,2001.13, 180','686.24,-1869.38,2002.27','Kawiarnia \"pod scena\"',1,35,50000,NULL),(175,2,'2257.46,59.30,2123.04, 0','2257.40,56.28,2123.03','Biuro detektywistyczne',1,36,100000,NULL),(176,0,'1036.90,-1443.90,13.59,300.9','1034.88,-1444.16,13.59','Biznes, 2 pokoje',1,3137,50000,'zasob pio-biznes1'),(177,0,'-2912.36,-2.21,1672.70,88.2','-2910.87,-2.16,1672.70','Dom luksus 3 pokoje',1,3138,250000,'zasob pio-dom1'),(178,0,'-2640.01,861.46,1428.16,228.5','-2641.24,862.65,1428.17','Dom luksus 3 pokoje',1,3139,250000,'zasob pio-dom2'),(179,2,'852.19,-1082.67,2252.20, 135','854.03,-1079.88,2252.20','Dom pogrzebowy',1,37,150000,NULL),(180,2,'887.52,2261.18,238.23,3.4','887.37,2259.46,238.23','Biuro, 1-pok',1,3140,70000,'zasob pio-biura1'),(181,1,'916.63,2380.49,246.47,182.6','916.60,2381.84,246.47','Biblioteka',1,3140,70000,'zasob pio-biura1'),(182,2,'-2064.38,551.40,1173.05,4.3','-2063.91,549.80,1173.05','Biuro 3 pok',1,3140,150000,'zasob pio-biura1'),(183,1,'-132.30,1092.31,1345.79,275.3','-132.42,1090.28,1345.79,177.8','Zduplikowany rc battleground',1,3136,150000,'zasob pio-rc'),(184,2,'-1034.96,826.93,2665.66,1.1','-1034.88,824.98,2665.66,175.8',NULL,1,38,150000,'zasob wb-arena'),(185,2,'2260.65,118.81,2082.83, 90','2263.54,118.92,2082.83','Przychodnia lekarska',1,39,100000,NULL),(186,1,'1218.28,-1445.58,2108.48, 90','1220.88,-1445.51,2107.47','Biuro Sluzb Specjalnych',0,40,500000,NULL),(187,1,'282.06,-1799.89,1479.89, 90','285.15,-1799.92,1479.88','Kosciol',1,11,100000,NULL),(188,1,'1496.77,-1790.59,1133.0,90.0','1500.83,-1790.74,111132.96','Urzad Miasta',0,1,0,NULL),(189,1,'1551.12,-1678.41,1463.47, 180','1551.10,-1675.45,1463.47','Komisariat Policji',1,5,0,NULL),(190,1,'2026.06,-1397.82,1275.06, 270','2023.32,-1397.86,1275.07','Szpital',1,8,0,NULL),(191,1,'927.79,-1267.05,1440.93, 180','927.79,-1264.08,1440.93','Straz pozarna',1,26,0,NULL),(192,1,'803.58,-510.87,1206.88, 0','803.62,-513.40,1206.88','Sluzby Miejskie',1,10,0,NULL),(193,1,'444.92,-1127.06,1196.34, 180','444.91,-1124.32,1196.34','San News',1,7,0,NULL),(194,1,'1063.11,-367.97,1495.02, 315','1061.15,-369.93,1495.02','Kopalnia',1,20,0,NULL),(195,1,'1310.43,-1107.95,1441.53, 0','1310.39,-1110.70,1441.53','Sad',1,21,0,NULL),(196,2,'1364.04,240.26,2076.19, 0','1364.03,237.77,2076.19','Kawiarnia \'Paszcza Wieloryba\'',1,41,60000,NULL),(197,1,'934.13,2474.78,1054.41, 45','936.24,2472.74,1054.41','Klub \'Fantasia\'',1,12,100000,NULL),(198,1,'2364.83,-1507.26,1481.13, 90','2367.04,-1507.22,1481.13','Rudera rozrywki',1,34,50000,NULL),(199,1,'3049.23,-860.60,1488.63, 90','3051.92,-860.75,1488.63','Punkt garazowy',1,43,10000,NULL),(200,2,'1475.56,-2216.75,2192.88, 180','1475.51,-2213.58,2192.88','Szkola lotnicza',1,45,15000,NULL),(201,2,'-461.19,-39.68,2087.47, 90','-458.57,-39.79,2087.47','Biuro tartaku',1,49,5000,NULL),(202,1,'Hala','1530.15,12.64,1418.36','1530.06,8.34,1418.36, 180',1,28,0,NULL),(203,1,'1418.42,-130.31,1081.23, 0','1418.52,-134.17,1081.23','Osrodek Szkoleniowy',1,28,0,NULL),(204,2,'2094.15,-1208.34,1702.27, 315','2092.62,-1210.15,1702.27','Salon tatuazu',1,50,5000,NULL),(205,1,'2820.80,-1089.18,1593.71, 90','2823.59,-1089.23,1593.71','Departament Turystyki',1,51,0,NULL),(206,2,'501.13,-1489.10,2076.19, 0','501.11,-1492.22,2076.19','Knajpa \'Isaura\'',1,53,10000,NULL),(207,2,'1815.75,-1072.07,2181.54, 270','1812.71,-1072.17,2181.54','Market \'Lubin\'',1,52,10000,NULL),(208,2,'1570.43,-1200.38,1625.80, 270','1566.59,-1200.52,1625.80','Hotel \'Burza\'',1,56,10000,NULL),(209,2,'604.45,-1460.42,1625.80, 270','600.59,-1460.55,1625.80','Hotel \'Carrington\'',1,57,10000,NULL),(210,2,'1500.55,-1590.59,1625.80, 270','1496.59,-1590.48,1625.80','Hotel \'Forrester\'',1,58,10000,NULL),(211,2,'2280.54,69.51,1625.80, 270','2276.59,69.52,1625.80','Hotel \'Martwa Cisza\'',1,59,10000,NULL),(212,2,'2481.92,-1530.82,2098.76, 180','2481.92,-1527.47,2098.76','Bar \'Purple-Pub\'',1,60,10000,NULL),(213,2,'489.42,-1556.89,2101.80, 0','489.35,-1560.63,2101.80','Odziezowy \'The Exclusive Clothing\'',1,61,15000,NULL),(214,2,'1948.18,-2048.80,2027.77, 270','1944.99,-2048.88,2027.77','Bar \'Corona Billard Pub\'',1,62,20000,NULL),(215,2,'1574.35,-1887.45,2007.56, 90','1577.41,-1887.57,2007.56','Restauracja \'Przy skarpie\'',1,63,15000,NULL),(216,2,'466.77,-1135.96,2002.87, 0','466.72,-1139.09,2003.51','Odziezowy \'Anastacia\'',1,66,200,NULL),(217,2,'1734.05,-1670.20,2002.21, 90','1737.42,-1670.16,2002.21','Odziezowy \'Mustang Jeans\'',1,67,400,NULL),(218,2,'1647.02,-1661.23,2576.19, 0','1647.06,-1664.23,2576.19','Knajpa \'diabelski mlyn\'',1,68,200,NULL),(219,2,'973.40,-1752.04,2200.68, 0','973.47,-1755.76,2200.68','Klub \'Eden\'',1,69,200,NULL);
/*!40000 ALTER TABLE `lss_interiory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lss_items`
--

DROP TABLE IF EXISTS `lss_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lss_items` (
  `id` mediumint(9) NOT NULL,
  `name` varchar(64) CHARACTER SET utf8 NOT NULL,
  `kieszonkowy` tinyint(1) NOT NULL DEFAULT '1',
  `surowiec` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lss_items`
--

LOCK TABLES `lss_items` WRITE;
/*!40000 ALTER TABLE `lss_items` DISABLE KEYS */;
INSERT INTO `lss_items` VALUES (-1,'Gotówka',1,0),(1,'Papierosy',1,0),(2,'Aparat',1,0),(3,'Żetony',1,0),(4,'Mapa',1,0),(5,'Aspiryna',1,0),(6,'Kluczyki',1,0),(7,'PDA',1,0),(8,'Surowa ryba',1,0),(9,'Śmieci',1,0),(10,'Ryba wędzona',1,0),(11,'Klucze policji',1,0),(12,'Klucze SM',1,0),(13,'Kwit do wypłaty',1,0),(14,'Klucze W-1',1,0),(27,'Joint',1,0),(21,'Telefon',1,0),(24,'Kwiaty',1,0),(29,'Klucze medyków',1,0),(25,'Spray',1,0),(26,'Klucze TAXI',1,0),(20,'Klucze do eLki-1',1,0),(23,'Kwiaty',1,0),(16,'Nawigacja GPS',1,0),(17,'Prawo jazdy',1,0),(19,'Gazeta',1,0),(18,'Amtefamina',1,0),(30,'Glock',1,0),(22,'Drink',1,0),(31,'Baseball',1,0),(33,'Pałka policyjna',1,0),(28,'Kajdanki',1,0),(35,'Pager',1,0),(36,'Gaśnica',1,0),(32,'Mikrofon',1,0),(37,'Zastrzyk',1,0),(39,'Klucze strażaków',1,0),(41,'Krótkofalowka',1,0),(40,'Kwiaty',1,0),(34,'Grzybek',1,0),(42,'Piwo',1,0),(15,'Paczka kurierska',1,0),(43,'Szkicownik',1,0),(46,'Dowód osobisty',1,0),(45,'Miotacz ognia',1,0),(44,'Snopek',1,1),(48,'Kwiaty',1,0),(49,'Klucze SN',1,0),(50,'Klucze UM',1,0),(51,'Klucze kurierów',1,0),(52,'Klucze W-2',1,0),(53,'Klucze W-3',1,0),(54,'Klucze W-4',1,0),(55,'Klucze W-5',1,0),(56,'Klucze do eLki-2',1,0),(57,'Klucze ochrony',1,0),(58,'Kwiaty',1,0),(59,'Kwiaty',1,0),(60,'Kwiaty',1,0),(62,'Klucze importu',1,0),(47,'Notes',1,0),(63,'Plyta CD',1,0),(61,'Neony',1,0),(73,'Szkło',0,1),(72,'Stal',0,1),(71,'Polistyren',0,1),(70,'Polipropylen',0,1),(69,'Polietylen',0,1),(68,'Papier',0,1),(67,'Drewno',0,1),(66,'Aluminium',0,1),(64,'Moneta',1,0),(65,'Kostka do gry',1,0),(74,'Piła spalinowa',1,0),(76,'Pachołek',1,0),(77,'Klucze SR',1,0),(78,'Klucze SW',1,0),(79,'Zestaw kół\n1077',1,0),(75,'Klucze górników',1,0),(80,'Klucze SS',1,0),(81,'Nóż',1,0),(82,'Whiskey',1,0),(83,'Pizza',1,0),(84,'Cola',1,0),(85,'Sok',1,0),(86,'Chleb',1,0),(87,'Woda niegazowana',1,0),(88,'Hot-Dog',1,0),(89,'Frytki',1,0),(90,'Baton',1,0),(91,'Owoce',1,0),(92,'Klucze PP',1,0),(93,'Papier toaletowy',1,0),(94,'Spirytus',1,0),(95,'Kubańskie cygaro',1,0),(96,'Rybka w konserwie',1,0),(97,'Ręcznik',1,0),(98,'Lody',1,0),(99,'Szaszłyk',1,0),(100,'Dropsy miętowe',1,0),(101,'Klucze SK',1,0),(102,'Zest. hydrauliczny',1,0),(103,'Klucze Tartaku',1,0),(104,'Spadochron',1,0),(106,'Klucze szkoły lotniczej',1,0),(105,'Kominiarka',1,0),(107,'Fajerwerki',1,0),(108,'Megafon',1,0),(109,'Shotgun',1,0),(110,'Desert Eagle',1,0),(111,'Paralizator',1,0),(112,'UZI',1,0),(113,'Karabin szkoleniowy',1,0),(114,'MP5',1,0),(115,'M4',1,0),(116,'Heronina',1,0),(117,'Klucze Gastronomii I',1,0),(118,'Klucze Gastronomii II',1,0),(119,'Klucze Gastronomii III',1,0),(120,'Klucze Gastronomii IV',1,0),(121,'Klucze Gastronomii V',1,0),(122,'Klucze Gastronomii VI',1,0),(123,'Klucze Gastronomii VII',1,0),(124,'Klucze Gastronomii VIII',1,0),(125,'Klucze Gastronomii IX',1,0),(126,'Klucze Turystyki',1,0),(127,'Klucze Gastronomii X',1,0),(128,'Klucze Gastronomii XI',1,0),(0,'Bandana',1,0),(129,'Klucze Gastronomii XII',1,0),(130,'Amunicja M4',1,0),(131,'Amunicja Shotgun',1,0),(132,'Amunicja Deagle',1,0),(133,'Amunicja Paralizator',1,0),(134,'Amunicja Uzi',1,0),(135,'Amunicja na karabin szkoleniowy',1,0),(136,'Amunicja MP5',1,0),(137,'Dopalacze',1,0),(138,'Kakanina',1,0),(139,'Amtefamina',1,0),(140,'LDS',1,0),(141,'Oipium',1,0),(142,'Metamtefamina',1,0),(143,'Heronina',1,0),(144,'Extas',1,0),(145,'Amunicja szkoleniowka',1,0),(146,'Plecak',1,0),(147,'Torba',1,0),(148,'Granaty',1,0),(149,'Klucze Gastronomii XIII',1,0),(150,'Defibrylator',1,0),(152,'Pistolet szkoleniowy',1,0),(153,'Amunicja pistoletu szkoleniowego',1,0),(157,'Grill',1,0),(162,'Kanister 10L (10)',1,0),(154,'Laser M4',1,0),(151,'Kamizelka PD 0',1,0),(161,'Kanister 5L',1,0),(158,'Surowa kielbasa',1,0),(159,'Pieczona kielbasa',1,0),(160,'Blokada drogowa',1,0),(163,'Klucze Klubu Miasta',1,0),(164,'Boombox',1,0),(165,'Obroża',1,0),(166,'Zwłoki 14354',1,0),(167,'Karma (pies)',1,0),(168,'Prezent - DD',1,0),(169,'Kamizelka LSMC',1,0),(171,'Opony z m. mieszanki',1,0),(172,'Chipset ECO',1,0),(173,'Chipset HARD',1,0),(174,'Rozpórka pod maską',1,0),(175,'Klatka bezpieczenstwa',1,0),(176,'Filtr stożkowy',1,0),(177,'Filtr sportowy',1,0),(178,'Wtrysk wody z metanolem',1,0),(179,'Wtrysk sportowy',1,0),(180,'Karoseria (wl. weglowe)',1,0),(181,'Karoseria (alphaBx)',1,0),(199,'Biturbo',1,0),(182,'Biturbo',1,0),(184,'Drążek stabilizatora',1,0),(183,'Twin-turbo',1,0),(185,'Amortyzator gazowy',1,0),(186,'Zes. cięż. zawieszenia gwint.',1,0),(187,'Folia R10',1,0),(188,'Folia przyciemniająca',1,0),(189,'Bi-ksenon XBluePower',1,0),(190,'LED XGreenPower',1,0),(191,'Klocki hamulcowe',1,0),(192,'Zacisk hamulcowy',1,0),(193,'Tarcza hamulcowa',1,0),(194,'Skrz. biegów SPRINT',1,0),(195,'Skrz. biegów FAST',1,0),(196,'Audio - Little music',1,0),(197,'Audio - BIG BASTARD',1,0),(198,'Bandana',1,0);
/*!40000 ALTER TABLE `lss_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lss_kartoteka`
--

DROP TABLE IF EXISTS `lss_kartoteka`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lss_kartoteka` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `imie` text COLLATE utf8_polish_ci NOT NULL,
  `nazwisko` text COLLATE utf8_polish_ci NOT NULL,
  `kolor_skory` text COLLATE utf8_polish_ci NOT NULL,
  `wiek` text COLLATE utf8_polish_ci NOT NULL,
  `odciski_palcow` mediumtext COLLATE utf8_polish_ci NOT NULL,
  `miejsce_zamieszkania` text COLLATE utf8_polish_ci NOT NULL,
  `znaki_szczegolne` text COLLATE utf8_polish_ci NOT NULL,
  `kolor_wlosow` text COLLATE utf8_polish_ci NOT NULL,
  `inne_informacje` longtext COLLATE utf8_polish_ci NOT NULL,
  `przewinienia` longtext COLLATE utf8_polish_ci NOT NULL,
  `pojazdy` longtext COLLATE utf8_polish_ci NOT NULL,
  KEY `id_2` (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lss_kartoteka`
--

LOCK TABLES `lss_kartoteka` WRITE;
/*!40000 ALTER TABLE `lss_kartoteka` DISABLE KEYS */;
/*!40000 ALTER TABLE `lss_kartoteka` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lss_magazyny_oferta`
--

DROP TABLE IF EXISTS `lss_magazyny_oferta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lss_magazyny_oferta` (
  `container_id` int(10) unsigned NOT NULL,
  `itemid` int(10) unsigned NOT NULL,
  `buyprice` int(10) unsigned DEFAULT NULL,
  `sellprice` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`container_id`,`itemid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lss_magazyny_oferta`
--

LOCK TABLES `lss_magazyny_oferta` WRITE;
/*!40000 ALTER TABLE `lss_magazyny_oferta` DISABLE KEYS */;
INSERT INTO `lss_magazyny_oferta` VALUES (1741,72,1000,1200),(2462,67,0,3000),(1741,73,515,0);
/*!40000 ALTER TABLE `lss_magazyny_oferta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lss_notes`
--

DROP TABLE IF EXISTS `lss_notes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lss_notes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `character_id` int(10) unsigned NOT NULL,
  `contents` text CHARACTER SET utf8 NOT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lss_notes`
--

LOCK TABLES `lss_notes` WRITE;
/*!40000 ALTER TABLE `lss_notes` DISABLE KEYS */;
/*!40000 ALTER TABLE `lss_notes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lss_pback`
--

DROP TABLE IF EXISTS `lss_pback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lss_pback` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `serial` varchar(32) NOT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `code` varchar(32) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `serial` (`serial`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lss_pback`
--

LOCK TABLES `lss_pback` WRITE;
/*!40000 ALTER TABLE `lss_pback` DISABLE KEYS */;
/*!40000 ALTER TABLE `lss_pback` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lss_petsystem`
--

DROP TABLE IF EXISTS `lss_petsystem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lss_petsystem` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `char_id` int(11) NOT NULL,
  `nazwa` text COLLATE utf8_polish_ci NOT NULL,
  `stamina` int(2) NOT NULL DEFAULT '0',
  `nasycenie` int(3) NOT NULL DEFAULT '100',
  `rasa` smallint(1) NOT NULL DEFAULT '0' COMMENT '0-wilk 1-pitbull 2-rottweiler',
  `skill_dajglos` tinyint(1) NOT NULL DEFAULT '0',
  `skill_zostan` tinyint(1) NOT NULL DEFAULT '0',
  `skill_donogi` tinyint(1) NOT NULL DEFAULT '0',
  KEY `id` (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lss_petsystem`
--

LOCK TABLES `lss_petsystem` WRITE;
/*!40000 ALTER TABLE `lss_petsystem` DISABLE KEYS */;
/*!40000 ALTER TABLE `lss_petsystem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lss_phone`
--

DROP TABLE IF EXISTS `lss_phone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lss_phone` (
  `numer` int(10) unsigned NOT NULL,
  PRIMARY KEY (`numer`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lss_phone`
--

LOCK TABLES `lss_phone` WRITE;
/*!40000 ALTER TABLE `lss_phone` DISABLE KEYS */;
/*!40000 ALTER TABLE `lss_phone` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lss_phone_contacts`
--

DROP TABLE IF EXISTS `lss_phone_contacts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lss_phone_contacts` (
  `owner` int(10) unsigned NOT NULL,
  `number` int(10) unsigned NOT NULL,
  `descr` varchar(32) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`owner`,`number`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lss_phone_contacts`
--

LOCK TABLES `lss_phone_contacts` WRITE;
/*!40000 ALTER TABLE `lss_phone_contacts` DISABLE KEYS */;
/*!40000 ALTER TABLE `lss_phone_contacts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lss_phone_sms`
--

DROP TABLE IF EXISTS `lss_phone_sms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lss_phone_sms` (
  `sender` int(10) unsigned NOT NULL,
  `receiver` int(10) unsigned NOT NULL,
  `content` varchar(128) CHARACTER SET utf8 NOT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lss_phone_sms`
--

LOCK TABLES `lss_phone_sms` WRITE;
/*!40000 ALTER TABLE `lss_phone_sms` DISABLE KEYS */;
/*!40000 ALTER TABLE `lss_phone_sms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lss_poczta`
--

DROP TABLE IF EXISTS `lss_poczta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lss_poczta` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nadawca` int(11) NOT NULL,
  `odbiorca` int(11) NOT NULL,
  `temat` varchar(128) CHARACTER SET utf8 NOT NULL,
  `tresc` varchar(4096) CHARACTER SET utf8 NOT NULL,
  `dostarczone` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `przeczytane` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deliveryAttempt` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `dostarczone` (`dostarczone`),
  KEY `deliveryAttempt` (`deliveryAttempt`),
  KEY `filtr_poczty1` (`id`,`odbiorca`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lss_poczta`
--

LOCK TABLES `lss_poczta` WRITE;
/*!40000 ALTER TABLE `lss_poczta` DISABLE KEYS */;
/*!40000 ALTER TABLE `lss_poczta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lss_registrations`
--

DROP TABLE IF EXISTS `lss_registrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lss_registrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `login` varchar(32) CHARACTER SET utf8 NOT NULL,
  `hash` varchar(32) CHARACTER SET ascii NOT NULL,
  `email` varchar(128) NOT NULL,
  `skad` varchar(255) DEFAULT NULL,
  `ip` varchar(64) NOT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `polecajacy` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `login` (`login`),
  UNIQUE KEY `email` (`email`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lss_registrations`
--

LOCK TABLES `lss_registrations` WRITE;
/*!40000 ALTER TABLE `lss_registrations` DISABLE KEYS */;
/*!40000 ALTER TABLE `lss_registrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lss_tagi`
--

DROP TABLE IF EXISTS `lss_tagi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lss_tagi` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `creator` int(10) unsigned NOT NULL,
  `x` double(36,30) NOT NULL,
  `y` double(36,30) NOT NULL,
  `z` double(36,30) NOT NULL,
  `x1` double(36,30) NOT NULL,
  `y1` double(36,30) NOT NULL,
  `z1` double(36,30) NOT NULL,
  `x2` double(36,30) NOT NULL,
  `y2` double(36,30) NOT NULL,
  `z2` double(36,30) NOT NULL,
  `ny` double(36,30) NOT NULL,
  `nx` double(36,30) NOT NULL,
  `nz` double(36,30) NOT NULL,
  `pngdata` blob NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lss_tagi`
--

LOCK TABLES `lss_tagi` WRITE;
/*!40000 ALTER TABLE `lss_tagi` DISABLE KEYS */;
/*!40000 ALTER TABLE `lss_tagi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lss_telepickups`
--

DROP TABLE IF EXISTS `lss_telepickups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lss_telepickups` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `notes` varchar(64) COLLATE utf8_polish_ci DEFAULT NULL,
  `opis` varchar(96) COLLATE utf8_polish_ci DEFAULT NULL,
  `px` double NOT NULL,
  `py` double NOT NULL,
  `pz` double NOT NULL,
  `pi` smallint(2) unsigned NOT NULL DEFAULT '0',
  `pd` mediumint(5) unsigned NOT NULL DEFAULT '0',
  `tx` double NOT NULL,
  `ty` double NOT NULL,
  `tz` double NOT NULL,
  `ti` smallint(2) unsigned NOT NULL DEFAULT '0',
  `td` mediumint(5) unsigned NOT NULL DEFAULT '0',
  `ta` double NOT NULL DEFAULT '0',
  `hrlimit` varchar(6) COLLATE utf8_polish_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lss_telepickups`
--

LOCK TABLES `lss_telepickups` WRITE;
/*!40000 ALTER TABLE `lss_telepickups` DISABLE KEYS */;
INSERT INTO `lss_telepickups` VALUES (4,NULL,'(( Kasyno ))',1836.66,-1682.48,999913.34,0,0,1896.99,-1679.18,1396.59,1,65,90,''),(180,'Wyjście z archiwum do biura burmistrza (Urząd Miasta)',NULL,1472.16,-1784.9,1349.01,1,1,1473.4,-1784.85,1286,1,1,270,''),(5,'Wyjscie z kasyna','(( Wyjście ))',1901.08,-1679.22,1396.88,1,65,1834.3,-1682.33,13.44,0,0,90,''),(6,NULL,'(( Sklep z elektroniką ))',1603.5,-1170.44,24.08,0,0,1605.32,-1176.01,1635.41,2,75,0,''),(7,'wyjscie ze sklepu z elektronika','(( Wyjście ))',1603.97,-1177.67,1635.41,2,75,1603.43,-1166.5,24.08,0,0,0,''),(8,NULL,'(( Sklep 24/7 ))',2439.02,-1942.27,13.55,0,0,2434.22,-1940.7,2035.41,2,76,0,''),(9,'Wyjscie ze sklepu 24/7','(( Wyjście ))',2432.97,-1942.68,2035.41,2,76,2439.07,-1939.01,13.55,0,0,0,''),(179,'Wejście do archiwum z biura burmistrza (Urząd Miasta)','(( Archiwum ))',1470.13,-1784.94,1286,1,1,1469.91,-1784.85,1349.01,1,1,90,''),(128,'Wejście na klatkę schodową z parkingu w szpitalu','(( Klatka schodowa ))',2034.1,-1351.04,6.63,0,0,2024.71,-1380.44,1270.47,1,8,0,''),(16,'Wejście na klatkę schodową na dach (San News)','(( Klatka schodowa ))',435.33,-1176.28,1196.32,1,7,346.66,-1198.31,1203.82,1,7,180,''),(17,'Z klatki schodowej do redakcji (San News)','(( Redakcja ))',344.88,-1196.64,1203.82,1,7,435.3,-1173.67,1196.32,1,7,0,''),(18,'Wejście do pokoju przesłuchań (komisariat policji)','(( Pokój przesłuchań ))',1555.47,-1660.9,1464.87,1,5,1551.76,-1660.62,1464.87,1,5,90,''),(19,'Wyjscie z pokoju przesluchan','(( Wyjście ))',1554.18,-1660.94,1464.87,1,5,1557.64,-1660.96,1464.87,1,5,270,''),(130,'Wyjście z kwiaciarni','(( Wyjście ))',1984.69,-1765.81,1430.47,1,33,1991.45,-1759.31,13.55,0,0,0,''),(178,'Wyjście z biura SM (Urząd Miasta)','(( Wyjście ))',1475.11,-1714.09,1132.83,1,1,1477.39,-1778.61,1132.96,1,1,180,''),(135,'Wejście do kolonii karnej','(( Kolonia karna ))',2738.58,-2526.34,13.76,0,0,2764.81,-2655.24,7.19,0,35,180,''),(132,'Wejście na salę KSW','(( Wyjście ))',1292.29,-785.51,130.56,0,3,30.07,-320.38,2.25,0,0,270,''),(26,NULL,'(( Sklep wielobranżowy ))',499.66,-1360.44,16.45,0,0,487.16,-1365.78,1635.41,2,74,0,''),(27,'Sklep wielobranżowy','(( Wyjście ))',485.97,-1367.68,1635.41,2,74,501.26,-1356.51,16.13,0,0,336,''),(28,NULL,'(( Czerwona\r\nkurtyna ))',953.95,-1336.83,13.54,0,0,1204.96,-11.82,1000.92,2,0,359.9,'22-6'),(29,'Czerwona kurtyna','(( Wyjście ))',1204.8,-13.85,1001.02,2,0,954,-1334.93,13.54,0,0,355.7,''),(176,'Wyjście z biura na halę (wysypisko śmieci)','(( Wyjście ))',632.78,-600.59,1654.12,1,42,634.2,-604.21,1595.63,1,42,180,''),(174,'Wyjście z hali (wysypisko śmieci)','(( Wyjście ))',675.88,-598.91,1599.63,1,42,632.96,-638.94,17.71,0,0,168,''),(175,'Wejście do biura z hali (wysypisko śmieci)','(( Biuro ))',634.11,-600.77,1595.63,1,42,632.64,-603.51,1654.12,1,42,180,''),(169,'Wejście na dach z klatki schodowej (służby specjalne)','(( Dach ))',1224.83,-1443.68,2261.57,1,40,1219.76,-1464.34,45.08,0,0,0,''),(126,'Droga z wydziałów HSIU / MPU na klatkę schodową (policja)','(( Klatka schodowa ))',1600.31,-1674.94,1491.82,1,5,1629.41,-1679.7,1457.67,1,5,270,''),(39,'Wyjście z banku','(( Wyjście ))',1662.25,260.38,1420.31,1,15,1462.42,-1012.62,26.84,0,0,180,''),(38,NULL,'(( Bank ))',1462.4,-1010.27,26.94,0,0,1662.27,258.87,1420.32,1,15,180,''),(40,NULL,'(( Sklep wielobranżowy ))',2068.67,-1773.77,13.66,0,0,2058.24,-1788.31,1635.41,2,73,0,''),(41,'Sklep wielobranżowy','(( Wyjście ))',2056.97,-1790.64,1635.41,2,73,2071.76,-1773.85,13.56,0,0,272.4,''),(42,NULL,'(( Fabryka ))',-86.27,-299.36,2.86,0,0,-62.91,-269.99,1420.61,1,17,0,''),(43,'Wyjście z fabryki pojazdów','(( Wyjście ))',-61.25,-270.05,1420.61,1,17,-86.22,-300.96,2.76,0,0,180,''),(44,'Obserwatorium na hali','(( Obserwatorium ))',-72.15,-245.48,1420.61,1,17,-74.83,-245.45,1420.6,1,17,90,''),(45,'Wyjście z obserwatorium na hali','(( Wyjście ))',-73.34,-245.49,1420.6,1,17,-70.82,-245.44,1420.61,1,17,270,''),(71,'Z dachu na klatkę - do komisariatu','(( Komisariat ))',1541,-1679.4,1457.67,1,5,1548.6,-1679.45,1463.47,1,5,270,''),(127,'Wejście na parking w szpitalu','(( Parking ))',2024.66,-1383.42,1269.26,1,8,2034.14,-1348.45,6.29,0,0,0,''),(48,NULL,'(( Sklep z bronią ))',1368.93,-1279.76,13.55,0,0,285.84,-84.77,1001.52,4,18,358.6,''),(49,'Sklep z bronią','(( Wyjście ))',285.88,-86.78,1001.72,4,18,1366.49,-1280.01,13.55,0,0,95.8,''),(50,'Wejście do pokoju lekarskiego (szpital)','(( Pokój lekarski ))',2056.39,-1393.45,1280.88,1,8,2056.26,-1389.24,1280.88,1,8,0,''),(51,'Wyjście z pokoju lekarskiego (szpital)','(( Wyjście ))',2056.31,-1392.23,1280.88,1,8,2056.34,-1396.72,1280.88,1,8,180,''),(52,'Sklep z bronią','(( Wyjście ))',301.82,-75.69,1001.52,4,18,301.38,-77.95,1001.52,4,18,186,''),(53,'Sklep z bronia','(( Strzelnica ))',301.71,-76.54,1001.62,4,18,298.46,-74.16,1001.52,4,18,2.8,''),(172,'Wyjście z pokoju przesłuchań na klatkę schodową (służby specjaln','(( Klatka schodowa ))',1245.73,-1450.01,2295.1,1,40,1229.69,-1444.34,2238.37,1,40,90,''),(171,'Wejście z klatki schodowej do pokoju przesłuchań (służby specjal','(( Pokój zatrzymanych ))',1233.04,-1444.36,2238.37,1,40,1245.66,-1446.85,2295.1,1,40,0,''),(170,'Wyjście z dachu na klatkę schodową (służby specjalne)','(( Klatka schodowa ))',1219.8,-1467.84,44.87,0,0,1224.89,-1446.85,2261.57,1,40,180,''),(60,NULL,'(( Sala rozpraw ))',1300.76,-1103.98,1441.53,1,21,1378.78,-1091.12,1441.55,1,21,270,''),(61,'Wyjście z sali rozpraw','(( Wyjście ))',1375.29,-1091.26,1441.55,1,21,1300.79,-1102.36,1441.53,1,21,0,''),(62,NULL,'(( Skrytki mieszkańców ))',1678.43,250.06,1420.31,1,15,1695.99,249.89,1420.32,1,15,270,''),(63,'Wyjście z pomieszczenia skrytki mieszkańców','(( Wyjście ))',1694.81,249.92,1420.32,1,15,1677.12,250.08,1420.31,1,15,90,''),(129,'Wejście do kwiaciarni','(( Kwiaciarnia ))',1991.54,-1761.86,13.55,0,0,1984.62,-1768.11,1430.47,1,33,180,''),(65,'Wyjście z koloni karnej na port','(( Wyjście ))',2732.03,-2501.66,1439.15,1,22,2733.68,-2512.34,13.66,0,0,0,''),(66,'Pokój odwiedzin w koloni karnej','(( Pokój odwiedzin ))',2729.22,-2532.47,1442,1,22,2775.12,-2607.22,13.93,0,23,270,''),(67,'Wyjście z pokoju odwiedzin w koloni karnej','(( Wyjście ))',2773.92,-2607.23,13.93,0,23,2730.37,-2532.53,1439.15,1,22,270,''),(72,'Droga z klatki na dach - komisariat','(( Dach ))',1626.27,-1679.64,1463.48,1,5,1564.93,-1664.38,28.4,0,0,0,''),(73,'Droga z dachu na klatke - komisariat','(( Klatka schodowa ))',1564.89,-1666.94,28.4,0,0,1628.94,-1679.64,1463.48,1,5,270,''),(74,'Droga na klatkę schodową - komisariat','(( Klatka schodowa ))',1572.71,-1679.06,1463.47,1,5,1629.74,-1679.58,1451.88,1,5,270,''),(75,'Droga na komisariat z klatki - komisariat','(( Komisariat ))',1627.2,-1679.62,1451.88,1,5,1569.1,-1678.97,1463.47,1,5,90,''),(76,'Parking - komisariat','(( Parking ))',1629.44,-1681.38,1440.27,1,5,1568.71,-1691.88,5.89,0,0,180,''),(77,'Droga na klatke - komisariat','(( Droga na komisariat ))',1568.66,-1689.97,6.22,0,0,1631.66,-1679.5,1440.27,1,5,270,''),(124,'Wyjście z sali rehabilitacyjnej w szpitalu','(( Wyjście ))',2013.91,-1345.78,1275.07,1,8,2051.08,-1379.11,1275.07,1,8,180,''),(78,'Wyjście z klatki na siłownię','(( Siłownia ))',2417.68,-1762.58,1409.74,1,24,2423.07,-1690.61,1409.68,1,24,0,''),(79,'Wyjście z siłowni na klatkę','(( Wyjście ))',2423.13,-1691.83,1409.68,1,24,2417.66,-1764.24,1409.74,1,24,180,''),(121,'mafia','(( Budynek ))',1271.68,-955.27,41.1,0,0,1522.66,-47.82,1002.13,2,0,270,''),(122,'mafia','(( Wyjście ))',1520.7,-48.06,1002.43,2,0,1269.25,-955.19,40.86,0,0,89.7,''),(123,'Wejście na salę rehabilitacyjną w szpitalu','(( Sala rehabilitacyjna ))',2051.03,-1377.07,1275.07,1,8,2013.96,-1348.09,1275.07,1,8,180,''),(125,'Droga z klatki schodowej do HSIU (policja)','(( Wydziały HSIU / MPU ))',1626.65,-1679.62,1457.67,1,5,1602.27,-1674.85,1491.82,1,5,270,''),(84,'Wejście na tor','(( Tor wyścigowy ))',2672.88,-1825.16,1436.59,1,24,2724.51,-1864.77,1441.52,1,24,328,''),(85,'Wyjście z toru wyścigowego','(( Na stadion ))',2723.56,-1866.43,1441.52,1,24,2672.99,-1823.58,1436.59,1,24,343,''),(177,'Wejście do biura SM (Urząd Miasta)','(( Służby Miejskie ))',1477.29,-1775.49,1132.96,1,1,1473.27,-1712.59,1132.83,1,1,90,''),(88,'FD','(( Na górę ))',910.16,-1288.35,1440.93,1,26,910.23,-1287.56,1447.2,1,26,0,''),(208,'Wyjście z Sekretariatu / Prezesa (sąd rejonowy)','(( Wyjście ))',1296.07,-937.88,1441.78,1,21,1295.32,-1101.28,1441.53,1,21,270,''),(107,'Wyjście do garaży z bazy straży pożarnej','(( Do garaży ))',894.74,-1266.29,1440.93,1,26,896.06,-1287.9,15.15,0,0,60,''),(108,'Z garaży straży pożarnej do bazy','(( Do bazy ))',898.26,-1288.66,15.15,0,0,894.8,-1268.99,1440.93,1,26,180,''),(93,'Wejście do WC w klubie2','(( WC ))',1051.41,-1420.05,1438.42,1,29,1106.86,-1414.1,1438.61,1,29,270,''),(94,'Wyjście z WC w klubie2','(( Wyjście ))',1105.18,-1414.1,1438.61,1,29,1049.72,-1420.02,1438.42,1,29,90,''),(95,'Wejście do pokoju dla personelu w klubie2','(( Wejście dla personelu ))',1051.4,-1397.52,1438.42,1,29,1124.03,-1388.32,1438.55,1,29,270,''),(96,'Wyjście z pokoju dla personelu w klubie2','(( Wyjście ))',1122.51,-1388.27,1438.55,1,29,1049.73,-1397.57,1438.41,1,29,90,''),(100,'Wyjście z urzędu pocztowego','(( Wyjście ))',1277.53,-1547.2,1381.82,1,30,1247.97,-1564.84,13.56,0,0,180,''),(101,'Wejście do magazynu na poczcie','(( Magazyn ))',1268.05,-1544.89,1381.83,1,30,1224.98,-1529.35,1381.77,1,30,90,''),(99,'Wejście do pocztę','(( Urząd pocztowy ))',1248.01,-1559.94,13.66,0,0,1273.73,-1547.14,1381.82,1,30,90,''),(102,'Wyjście z magazynu na poczcie','(( Wyjście ))',1226.4,-1529.3,1381.77,1,30,1269.21,-1544.87,1381.83,1,30,270,''),(105,'Wejście na dach szpitala','(( Dach ))',2027.85,-1386.43,1286.67,1,8,2045.12,-1391.91,44.86,0,0,0,''),(106,'Wejście z dachu do szpitala','(( Na klatkę schodową ))',2045.26,-1394.73,44.86,0,0,2025.24,-1386.55,1286.67,1,8,90,''),(109,'Wejście do drugiego garażu straży pożarnej','(( Przejście ))',896.61,-1276.68,15.15,0,0,896.54,-1272.83,15.15,0,0,0,''),(110,'Wyjście z garażu straży pożarnej do pierwszego','(( Przejście ))',896.51,-1275.05,15.15,0,0,896.47,-1278.92,15.15,0,0,180,''),(115,'Wejście do kancelarii w sądzie','(( Kancelaria ))',1319.19,-1103.98,1441.53,1,21,1492.55,-1091.77,1441.78,1,21,270,''),(116,'Wyjście z kancelarii w sądzie','(( Wyjście ))',1489.45,-1091.43,1441.78,1,21,1319.29,-1100.84,1441.53,1,21,0,''),(119,'Budynek gangu','(( Wejście ))',2521.4,-1281.85,35.15,0,0,2550.88,-1291.66,1060.98,2,32,333,''),(120,'Budynek gangu','(( Wyjście ))',2548.8,-1294.77,1061.28,2,32,2518.47,-1281.81,34.85,0,0,86.6,''),(168,'Wyjście z klatki schodowej do bazy (służby specjalne)','(( Baza ))',1231.19,-1442.75,2249.98,1,40,1227.62,-1425.93,2177.18,1,40,90,''),(167,'Wejście na klatkę schodową z bazy (służby specjalne)','(( Klatka schodowa ))',1230.21,-1425.79,2177.17,1,40,1231.25,-1445.76,2249.98,1,40,180,''),(136,'Wyjście z kolonii karnej','(( Wyjście ))',2764.93,-2653.04,7.19,0,35,2738.56,-2522.76,13.66,0,0,0,''),(137,'Wejście do kolonii karnej na podium','(( Podium ))',2738.5,-2530.47,17.64,0,0,2764.84,-2656.75,15.14,0,35,180,''),(138,'Wyjście z kolonii karnej z podium','(( Wyjście ))',2764.92,-2652.98,15.14,0,35,2736.28,-2528.86,17.64,0,0,90,''),(139,'Wejście na podium poziom I',NULL,2764.76,-2677.55,15.14,0,35,2764.85,-2692.07,15.15,0,35,180,''),(140,'Wyjście z podium poziom I',NULL,2764.84,-2688.72,15.15,0,35,2764.81,-2673.98,15.14,0,35,0,''),(141,'Wejście na podium poziom II',NULL,2764.79,-2713.26,15.14,0,35,2764.95,-2728.11,15.14,0,35,180,''),(142,'Wyjście z podium poziom II',NULL,2764.8,-2724.63,15.14,0,35,2764.68,-2709.67,15.14,0,35,0,''),(143,'Wejście na strzelnicę - komisariat policji','(( Strzelnica ))',1637.54,-1678.65,1451.88,1,5,1713.67,-1669.22,1451.95,1,5,270,''),(144,'Wyjście ze strzelnicy - komisariat policji','(( Wyjście ))',1710.54,-1669.19,1451.96,1,5,1634.58,-1678.61,1451.88,1,5,90,''),(145,'Kosciol-zachrystia','(( Zachrystia ))',250.09,-1816,1481.16,1,11,916.66,2379.69,246.47,1,3140,181.4,''),(146,'Kosciol-zachrystia','(( Wyjście ))',916.67,2381.84,246.47,1,3140,249.92,-1814.6,1481.16,1,11,2.9,''),(147,'Wejście na stołówkę z podium poziom III','(( Stołówka ))',2764.8,-2749.11,15.15,0,35,2759.25,-2844.88,1415.13,1,35,180,''),(148,'Wyjście ze stołówki na podium poziom III',NULL,2759.22,-2841.76,1415.13,1,35,2764.8,-2745.15,15.14,0,35,0,''),(149,'Wejście na stołówkę (więzienie)','(( Stołówka ))',2764.8,-2749.12,7.19,0,35,2759.24,-2844.78,1407.31,1,35,180,''),(150,'Wyjście ze stołówki (więzienie)',NULL,2759.25,-2841.79,1407.31,1,35,2768.66,-2748.39,7.19,0,35,315,''),(151,'paintball','(( Czerwoni ))',-1044.57,825.41,2665.67,2,38,-978.87,1055.4,2644.98,2,38,18.9,''),(152,'paintball','(( Wyjście ))',-977.86,1052.98,2644.99,2,38,-1044.41,827.57,2665.67,2,38,1.3,''),(153,'paintball','(( Wyjście ))',-1128.7,1066.16,2645.75,2,38,-1025.02,827.33,2665.67,2,38,8.2,''),(154,'paintball','(( Niebiescy ))',-1024.74,825.22,2665.68,2,38,-1126.93,1065.13,2645.74,2,38,180.6,''),(155,'Wejście do biura w San News','(( Biuro ))',446.3,-1176.3,1196.33,1,7,447.53,-1282.44,1196.32,1,7,180,''),(156,'Wyjście z biura San News','(( Wyjście ))',447.54,-1280.12,1196.32,1,7,446.26,-1173.42,1196.33,1,7,0,''),(173,'Wejście na halę (wysypisko śmieci)','(( Hala ))',633.71,-635.5,17.45,0,0,672.94,-599.22,1599.63,1,42,90,''),(157,'Wejście na dach z klatki schodowej (San News)','(( Dach ))',344.08,-1196.62,1215.42,1,7,441.96,-1138.71,124.18,0,0,270,''),(158,'Wyjście z dachu na klatkę schodową (San News)','(( Klatka schodowa ))',438.46,-1138.65,124.02,0,0,347.37,-1196.62,1215.42,1,7,270,''),(159,'Wejście do pokoju z HP','(( Sala zabiegowa ))',2059.78,-1377.07,1275.07,1,8,2048.89,-1377.83,2298.94,0,0,0,''),(160,'Wyjście z pokoju z HP','(( Wyjście ))',2048.78,-1380.57,2298.94,0,0,2059.87,-1379.72,1275.06,1,8,180,''),(161,'Wejście do Służb Specjalnych z klatki schodowej','(( Wydział ))',1213.72,-1444.99,2115.07,1,40,1228.02,-1438.43,2177.17,1,40,0,''),(162,'Wejście na klatkę schodową ze Służb specjalnych','(( Klatka schodowa ))',1228.01,-1441.8,2177.17,1,40,1216.59,-1445.02,2115.07,1,40,270,''),(163,'Wejście do biura prezesa (Służby Specjalne)','(( Biuro Prezesa ))',1167.62,-1422.82,2178.17,1,40,1217.89,-1441.43,2197.98,1,40,0,''),(164,'Wyjście z biura prezesa (Służby Specjalne)','(( Wyjście ))',1217.77,-1444.16,2197.98,1,40,1169.69,-1421.3,2178.17,1,40,270,''),(165,'Wejście do sali szkoleniowej (Służby Specjalne)','(( Sala szkoleniowa ))',1192.19,-1419.32,2178.17,1,40,1177.81,-1440.66,2203.58,1,40,270,''),(166,'Wyjście z sali szkoleniowej (Służby Specjalne)','(( Wyjście ))',1175.1,-1440.59,2203.58,1,40,1192.29,-1421.8,2178.17,1,40,180,''),(182,'Wyjście na parking z budynku (Firma kurierska)','(( Parking ))',714.93,-1335.85,1759.17,1,48,736.37,-1335.36,13.54,0,0,270,''),(183,'Wejście do budynku z parkingu (Firma kurierska)','(( Magazyn ))',732.54,-1335.47,13.54,0,0,713.85,-1339.55,1759.17,1,48,180,''),(184,'Wejście na klatkę schodową (1) (służby specjalne)','(( Klatka schodowa ))',1210.19,-1470.45,13.65,0,0,1226.47,-1443.49,2244.17,1,40,270,''),(185,'Wyjście na dwór z klatki schodowej (1) (służby specjalne)','(( Parking nr 1 ))',1223.11,-1443.59,2244.17,1,40,1210.35,-1473.85,13.55,0,0,180,''),(186,'Wejście na klatkę schodową (2) (służby specjalne)',NULL,1210.22,-1428.41,13.48,0,0,1229.14,-1443.67,2244.17,1,40,90,''),(187,'Wyjście na dwór z klatki schodowej (2) (służby specjalne)','(( Parking nr 2 ))',1232.52,-1443.57,2244.17,1,40,1210.2,-1424.1,13.38,0,0,0,''),(188,'Wejście do nieczynnej masarni','(( Nieczynna masarnia ))',2501.83,-1494.7,24.1,0,0,2502,-1493.77,2337.78,2,46,90,''),(189,'Wyjście z nieczynnej masarni','(( Wyjście ))',2505.57,-1493.71,2337.78,2,46,2501.88,-1497.89,24,0,0,180,''),(190,'Wejście do pokoju lekarskiego (2) (szpital)','(( Pokój lekarski ))',2054.82,-1402.33,1280.87,1,8,2100.84,-1324.3,1312.9,1,8,270,''),(191,'Wyjście z pokoju lekarskiego (2) (szpital)','(( Wyjście ))',2097.36,-1324.37,1312.9,1,8,2054.81,-1398.92,1280.87,1,8,0,''),(207,'Wejście do Sekretariatu / Prezesa (sąd rejonowy)','(( Sekretariat / Prezes ))',1293,-1098.53,1441.53,1,21,1296.12,-934.56,1441.79,1,21,0,''),(194,'Wejście na halę z klatki (ośrodek szkoleniowy)','(( Hala ))',1413.78,-112.65,1081.23,1,28,1530.07,7.93,1418.36,1,28,180,''),(196,'Wyjście z hali na klatkę (ośrodek szkoleniowy)','(( Klatka ))',1530.13,12.64,1418.36,1,28,1418.38,-112.69,1081.23,1,28,270,''),(197,'Wejście na basen z klatki (ośrodek szkoleniowy)','(( Basen ))',1423.38,-112.66,1081.23,1,28,-2199.97,1960.58,2.18,0,28,270,''),(198,'Wyjście z basenu na klatkę (ośrodek szkoleniowy)','(( Klatka ))',-2204.43,1960.57,2.18,0,28,1419.06,-112.78,1081.23,1,28,90,''),(199,'Wyjście z sali szkoleniowej policji (ośrodek szkoleniowy)','(( Sala szkoleniowa Departamentu Policji ))',1423.36,-125.09,1081.23,1,28,1435.98,-76.46,1823.82,1,28,225,''),(200,'Wejście na salę szkoleniową policji (ośrodek szkoleniowy)','(( Klatka ))',1433.25,-74.33,1823.82,1,28,1419.74,-125.11,1081.23,1,28,90,''),(201,'Wejście na salę szkoleniową Departamentu Straży Pożarnej (ośrode','(( Sala szkoleniowa Departamentu Straży pożarnej ))',1423.35,-130.33,1081.23,1,28,1435.81,3.79,1823.82,1,28,225,''),(202,'Wyjście z sali szkoleniowej Departamentu Straży Pożarnej (ośrode','(( Klatka ))',1433.36,6.6,1823.82,1,28,1420.05,-130.28,1081.23,1,28,90,''),(203,'Wejście na salę szkoleniową policji (ośrodek szkoleniowy)','(( Sala szkoleniowa Centrum Medycznego ))',1413.81,-130.14,1081.23,1,28,1435.93,-158.08,1823.82,1,28,225,''),(204,'Wyjście z sali szkoleniowej centrum medycznego (ośrodek szkoleni','(( Klatka ))',1433.28,-155.74,1823.82,1,28,1417.36,-130.11,1081.23,1,28,270,''),(205,'Wejście na salę szkoleniową Sądu / Służb Więziennych (ośrode','(( Sala szkoleniowa sądu Rejonowego / Służb Więziennych ))',1413.82,-124.93,1081.23,1,28,1435.33,-267.68,1823.82,1,28,225,''),(206,'Wyjście z sali szkoleniowej Sądu / Służb Więziennych (ośrode','(( Klatka ))',1433.23,-264.7,1823.82,1,28,1417.07,-124.92,1081.23,1,28,270,''),(211,'Wejście do Urzędu Miasta','(( Urząd Miasta ))',1481.19,-1772.16,18.8,0,0,1497.31,-1790.78,1132.96,1,1,90,'10-23'),(212,'Wyjście z Urzędu Miasta','(( Wyjście ))',1500.83,-1790.74,1132.96,1,1,1481.27,-1767.82,18.8,0,0,0,''),(213,'Wejście na halę boksu','(( Nieczynna hala boksu ))',2720.44,-2380.05,17.44,0,0,2720.07,-2412.35,1766.05,1,54,90,''),(214,'Wyjście z hali boksu','(( Wyjście ))',2723.91,-2412.29,1766.04,1,54,2722.65,-2384.32,17.34,0,0,225,''),(215,'Wejście do hotelu (departament turystyki)','(( Hotel ))',3585.05,-1338.2,15.67,0,0,3575.48,-1310.42,1625.8,1,55,270,''),(216,'Wyjście z hotelu (departament turystyki)','(( Wyjście ))',3571.7,-1310.46,1625.8,1,55,3581.38,-1342.09,15.67,0,0,135,''),(230,'Wejście do kafejki internetowej','Kafejka internetowa',1377.9,-1753.31,14.24,0,0,1369.13,-1745.69,2513.54,2,78,225,''),(228,'Wejście na stadionu nrg','(( Tor wyścigowy ))',2711.63,-1830.79,1436.4,1,24,2677.09,-1741.8,3071.66,1,77,180,''),(219,'Wejście do sklepu muzycznego','(( Sklep muzyczny ))',816.26,-1386.15,13.6,0,0,814.1,-1380.55,1401.28,1,64,0,''),(220,'Wyjście ze sklepu muzycznego','(( Wyjście ))',814.05,-1384.33,1401.28,1,64,816.29,-1390.04,13.63,0,0,180,''),(221,'Wejście na klatkę schodową (departament turystyki)','(( Klatka schodowa ))',2807.72,-1107.67,1593.71,1,51,2817.81,-1094.72,1637.46,1,51,180,''),(222,'Wejście na dach z klatki schowej (departament turystyki)','(( Dach ))',2814.99,-1087.41,1647.25,1,51,2794.68,-1092.34,94.19,0,0,135,''),(223,'Wyjście z dachu na klatkę schodową (departament turystyki)','(( Klatka schodowa ))',2793.45,-1087.57,94.19,0,0,2818.57,-1087.34,1647.25,1,51,270,''),(224,'Wyjście z klatki schodowej do departamentu (departament turystyk','(( Departament Turystyki ))',2817.8,-1090.38,1635.65,1,51,2809.69,-1106.26,1593.71,1,51,270,''),(229,'Wyjście ze stadionu nrg','(( Wyjście ))',2677.12,-1736.55,3071.66,1,77,2711.72,-1826.57,1436.41,1,24,355,''),(231,'Wyjście z kafejki internetowej','Wyjście',1367.42,-1743.22,2513.54,2,78,1381.65,-1753.12,13.55,0,0,270,'');
/*!40000 ALTER TABLE `lss_telepickups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lss_tmp`
--

DROP TABLE IF EXISTS `lss_tmp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lss_tmp` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `loc` varchar(64) NOT NULL,
  `ts` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `trasa` tinyint(2) NOT NULL DEFAULT '0',
  `angle` smallint(3) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lss_tmp`
--

LOCK TABLES `lss_tmp` WRITE;
/*!40000 ALTER TABLE `lss_tmp` DISABLE KEYS */;
/*!40000 ALTER TABLE `lss_tmp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lss_um_dowody`
--

DROP TABLE IF EXISTS `lss_um_dowody`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lss_um_dowody` (
  `character_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`character_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lss_um_dowody`
--

LOCK TABLES `lss_um_dowody` WRITE;
/*!40000 ALTER TABLE `lss_um_dowody` DISABLE KEYS */;
/*!40000 ALTER TABLE `lss_um_dowody` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lss_um_zasilki`
--

DROP TABLE IF EXISTS `lss_um_zasilki`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lss_um_zasilki` (
  `character_id` int(10) unsigned NOT NULL,
  `data` date NOT NULL,
  `wysokosc` double unsigned NOT NULL,
  PRIMARY KEY (`character_id`,`data`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lss_um_zasilki`
--

LOCK TABLES `lss_um_zasilki` WRITE;
/*!40000 ALTER TABLE `lss_um_zasilki` DISABLE KEYS */;
/*!40000 ALTER TABLE `lss_um_zasilki` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lss_users`
--

DROP TABLE IF EXISTS `lss_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lss_users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `login` varchar(32) CHARACTER SET utf8 NOT NULL,
  `hash` varchar(32) CHARACTER SET ascii NOT NULL,
  `email` varchar(128) NOT NULL DEFAULT 'blank@lss-rp.pl',
  `level` tinyint(1) NOT NULL DEFAULT '0',
  `quiz` tinyint(1) NOT NULL DEFAULT '0',
  `blokada_ooc` datetime NOT NULL,
  `blokada_bicia` datetime NOT NULL,
  `blokada_aj` smallint(6) NOT NULL DEFAULT '0',
  `blokada_pm` datetime NOT NULL,
  `voice_allowed` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `premium` date NOT NULL DEFAULT '0000-00-00',
  `character_limit` smallint(3) unsigned NOT NULL DEFAULT '2',
  `mailing1` tinyint(4) NOT NULL DEFAULT '0',
  `mailing2` tinyint(1) NOT NULL DEFAULT '0',
  `uo_sw` tinyint(1) NOT NULL DEFAULT '1',
  `uo_sb` tinyint(1) NOT NULL DEFAULT '0',
  `uo_cp` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `uo_det` tinyint(1) NOT NULL DEFAULT '0',
  `uo_bw` tinyint(1) NOT NULL DEFAULT '0',
  `uo_hdr` tinyint(1) NOT NULL DEFAULT '0',
  `uo_nig` tinyint(1) NOT NULL DEFAULT '0',
  `gp` int(10) unsigned NOT NULL DEFAULT '1',
  `polecajacy` int(10) unsigned NOT NULL DEFAULT '0',
  `polecajacy_done` timestamp NULL DEFAULT NULL,
  `registered` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `login` (`login`),
  KEY `mailing1` (`mailing1`),
  KEY `mailing2` (`mailing2`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lss_users`
--

LOCK TABLES `lss_users` WRITE;
/*!40000 ALTER TABLE `lss_users` DISABLE KEYS */;
INSERT INTO `lss_users` VALUES (1,'tester','9b53f6016491ff32c5a783e4562096bf','tester@tester.pl',0,1,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,'0000-00-00 00:00:00',0,'2014-07-18',3,0,0,0,0,0,0,0,0,1,30,0,NULL,'2013-03-05 22:59:13');
/*!40000 ALTER TABLE `lss_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lss_users_activity`
--

DROP TABLE IF EXISTS `lss_users_activity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lss_users_activity` (
  `id_user` int(10) unsigned NOT NULL,
  `data` date NOT NULL,
  `hour` smallint(2) unsigned NOT NULL,
  `minut` smallint(2) unsigned NOT NULL,
  PRIMARY KEY (`id_user`,`data`,`hour`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lss_users_activity`
--

LOCK TABLES `lss_users_activity` WRITE;
/*!40000 ALTER TABLE `lss_users_activity` DISABLE KEYS */;
/*!40000 ALTER TABLE `lss_users_activity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lss_vehicles`
--

DROP TABLE IF EXISTS `lss_vehicles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lss_vehicles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `model` smallint(3) NOT NULL,
  `loc` varchar(64) NOT NULL,
  `d` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `i` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `rot` varchar(64) NOT NULL DEFAULT '0,0,0',
  `locked` tinyint(1) NOT NULL DEFAULT '0',
  `frozen` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `last_modified` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  `created` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `hp` smallint(4) NOT NULL DEFAULT '1000',
  `tablica` varchar(16) NOT NULL DEFAULT 'LS',
  `owning_player` int(10) unsigned DEFAULT NULL,
  `owning_faction` int(10) unsigned DEFAULT NULL,
  `owning_co` int(10) unsigned DEFAULT NULL,
  `fprint1` varchar(16) CHARACTER SET ascii DEFAULT NULL,
  `fprint2` varchar(16) CHARACTER SET ascii DEFAULT NULL,
  `fprint3` varchar(16) CHARACTER SET ascii DEFAULT NULL,
  `fprint4` varchar(16) CHARACTER SET ascii DEFAULT NULL,
  `fprint5` varchar(16) CHARACTER SET ascii DEFAULT NULL,
  `c1` int(10) unsigned NOT NULL DEFAULT '16777215',
  `c2` int(10) unsigned NOT NULL DEFAULT '16777215',
  `c3` int(10) unsigned NOT NULL DEFAULT '16777215',
  `c4` int(10) unsigned NOT NULL DEFAULT '16777215',
  `cb` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `gps` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `kogut` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `neony` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `upgrades` varchar(100) DEFAULT NULL,
  `wheelstates` varchar(10) CHARACTER SET ascii NOT NULL DEFAULT '0,0,0,0',
  `opis` varchar(128) CHARACTER SET utf8 COLLATE utf8_polish_ci DEFAULT NULL,
  `opis_did` int(10) unsigned DEFAULT NULL,
  `paliwo` double unsigned NOT NULL DEFAULT '25',
  `bak` smallint(3) unsigned NOT NULL DEFAULT '25',
  `headlightcolor` varchar(32) DEFAULT NULL,
  `panelstates` varchar(64) NOT NULL DEFAULT '0,0,0,0,0,0,0',
  `special` varchar(16) DEFAULT NULL,
  `przebieg` double unsigned NOT NULL DEFAULT '0',
  `przechowalnia` tinyint(1) NOT NULL DEFAULT '0',
  `damageproof` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `tuning` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `przechowalnia` (`przechowalnia`),
  KEY `owning_player` (`owning_player`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lss_vehicles`
--

LOCK TABLES `lss_vehicles` WRITE;
/*!40000 ALTER TABLE `lss_vehicles` DISABLE KEYS */;
/*!40000 ALTER TABLE `lss_vehicles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lss_worlditems`
--

DROP TABLE IF EXISTS `lss_worlditems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lss_worlditems` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `itemid` smallint(6) unsigned NOT NULL,
  `object` int(10) unsigned NOT NULL,
  `count` mediumint(8) unsigned NOT NULL DEFAULT '1',
  `subtype` int(10) unsigned DEFAULT NULL,
  `x` double NOT NULL,
  `y` double NOT NULL,
  `z` double NOT NULL,
  `interior` int(10) unsigned NOT NULL DEFAULT '0',
  `dimension` int(10) unsigned NOT NULL DEFAULT '0',
  `fprint` varchar(16) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lss_worlditems`
--

LOCK TABLES `lss_worlditems` WRITE;
/*!40000 ALTER TABLE `lss_worlditems` DISABLE KEYS */;
/*!40000 ALTER TABLE `lss_worlditems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lss_wybory`
--

DROP TABLE IF EXISTS `lss_wybory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lss_wybory` (
  `id_wyborow` int(10) unsigned NOT NULL,
  `character_id` int(10) unsigned NOT NULL,
  `wybor` smallint(5) unsigned NOT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_wyborow`,`character_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lss_wybory`
--

LOCK TABLES `lss_wybory` WRITE;
/*!40000 ALTER TABLE `lss_wybory` DISABLE KEYS */;
/*!40000 ALTER TABLE `lss_wybory` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2013-08-18 12:41:25
