-- phpMyAdmin SQL Dump
-- version 4.0.10deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jun 01, 2015 at 10:46 AM
-- Server version: 5.5.43-0ubuntu0.14.04.1
-- PHP Version: 5.5.9-1ubuntu4.9

SET FOREIGN_KEY_CHECKS=0;
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `audio_sampling`
--
CREATE DATABASE IF NOT EXISTS `audio_sampling` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `audio_sampling`;

-- --------------------------------------------------------

--
-- Table structure for table `base_audio_info`
--
-- Creation: Jun 01, 2015 at 07:33 AM
--

DROP TABLE IF EXISTS `base_audio_info`;
CREATE TABLE IF NOT EXISTS `base_audio_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_id` int(11) NOT NULL,
  `amplitude` double NOT NULL,
  `frequency` double NOT NULL,
  `rate` int(11) NOT NULL,
  `time` bigint(20) NOT NULL,
  `sample_points` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `patient_id` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- RELATIONS FOR TABLE `base_audio_info`:
--   `patient_id`
--       `patients` -> `id`
--

--
-- Truncate table before insert `base_audio_info`
--

TRUNCATE TABLE `base_audio_info`;
-- --------------------------------------------------------

--
-- Table structure for table `deseases`
--
-- Creation: Jun 01, 2015 at 07:34 AM
--

DROP TABLE IF EXISTS `deseases`;
CREATE TABLE IF NOT EXISTS `deseases` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(550) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- RELATIONS FOR TABLE `deseases`:
--   `id`
--       `patients_to_desease` -> `desease_id`
--

--
-- Truncate table before insert `deseases`
--

TRUNCATE TABLE `deseases`;
-- --------------------------------------------------------

--
-- Table structure for table `patients`
--
-- Creation: Jun 01, 2015 at 07:20 AM
--

DROP TABLE IF EXISTS `patients`;
CREATE TABLE IF NOT EXISTS `patients` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(32) NOT NULL,
  `name` varchar(150) NOT NULL,
  `gender` tinyint(1) NOT NULL,
  `age` int(11) NOT NULL,
  `habitat` varchar(250) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Truncate table before insert `patients`
--

TRUNCATE TABLE `patients`;
-- --------------------------------------------------------

--
-- Table structure for table `patients_to_desease`
--
-- Creation: Jun 01, 2015 at 07:34 AM
--

DROP TABLE IF EXISTS `patients_to_desease`;
CREATE TABLE IF NOT EXISTS `patients_to_desease` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_id` int(11) NOT NULL,
  `desease_id` int(11) NOT NULL,
  `severity` int(11) NOT NULL,
  `period` float NOT NULL,
  `cured` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `patient_id` (`patient_id`,`desease_id`,`severity`,`period`,`cured`),
  KEY `patient_id_2` (`patient_id`),
  KEY `desease_id` (`desease_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- RELATIONS FOR TABLE `patients_to_desease`:
--   `desease_id`
--       `deseases` -> `id`
--   `patient_id`
--       `patients` -> `id`
--

--
-- Truncate table before insert `patients_to_desease`
--

TRUNCATE TABLE `patients_to_desease`;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `base_audio_info`
--
ALTER TABLE `base_audio_info`
  ADD CONSTRAINT `base_audio_info_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `deseases`
--
ALTER TABLE `deseases`
  ADD CONSTRAINT `deseases_ibfk_1` FOREIGN KEY (`id`) REFERENCES `patients_to_desease` (`desease_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `patients_to_desease`
--
ALTER TABLE `patients_to_desease`
  ADD CONSTRAINT `patients_to_desease_ibfk_2` FOREIGN KEY (`desease_id`) REFERENCES `deseases` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `patients_to_desease_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
SET FOREIGN_KEY_CHECKS=1;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
