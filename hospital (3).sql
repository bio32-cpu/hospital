-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 08, 2024 at 02:47 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hospital`
--

-- --------------------------------------------------------

--
-- Table structure for table `account`
--

CREATE TABLE `account` (
  `username` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `quit` bit(1) DEFAULT NULL,
  `role` enum('ADMIN','DOCTOR','NURSE','PATIENT','RECEPTION') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `account`
--

INSERT INTO `account` (`username`, `password`, `quit`, `role`) VALUES
('long12', '123', NULL, 'PATIENT');

-- --------------------------------------------------------

--
-- Table structure for table `doctor`
--

CREATE TABLE `doctor` (
  `idperson` varchar(255) NOT NULL,
  `age` int(11) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `phonenumber` varchar(255) DEFAULT NULL,
  `sex` enum('FEMALE','MALE') DEFAULT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `degree` varchar(255) DEFAULT NULL,
  `specialized` enum('DERMATOLOGY','INTERNAL_MEDICINE','OBSTETRICS_AND_GYNECOLOGY','PEDIATRICS','PSYCHIATRY','SURGERY') DEFAULT NULL,
  `yearsexperience` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `doctor`
--

INSERT INTO `doctor` (`idperson`, `age`, `email`, `name`, `phonenumber`, `sex`, `avatar`, `degree`, `specialized`, `yearsexperience`) VALUES
('', 15, 'long@gmail.com', 'long', '0945662345', 'MALE', 'https://png.pngtree.com/png-clipart/20211009/original/pngtree-cute-boy-doctor-avatar-logo-png-image_6848835.png', 'giỏi', 'INTERNAL_MEDICINE', 22),
('doc_672b666988ada', 33, 'huni@gmail.com', 'hung', '123456789', 'MALE', 'https://png.pngtree.com/png-clipart/20240212/original/pngtree-handsome-anime-doctor-png-image_14291660.png', 'nam', 'INTERNAL_MEDICINE', 22),
('doc_672b66922d991', 22, 'hung@gmail.com', 'hung', '123456789', 'MALE', 'https://png.pngtree.com/png-vector/20231223/ourlarge/pngtree-beautiful-anime-doctor-png-image_11380283.png', 'No', 'INTERNAL_MEDICINE', 11);

-- --------------------------------------------------------

--
-- Table structure for table `medicalrecord`
--

CREATE TABLE `medicalrecord` (
  `idmedicalrecord` int(11) NOT NULL,
  `conclusion` text DEFAULT NULL,
  `conjecture` text DEFAULT NULL,
  `examined` bit(1) DEFAULT NULL,
  `iddoctor` varchar(255) DEFAULT NULL,
  `idmedicine` int(11) DEFAULT NULL,
  `idnuser` varchar(255) DEFAULT NULL,
  `idpatient` int(11) DEFAULT NULL,
  `price` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `medicalrecord`
--

INSERT INTO `medicalrecord` (`idmedicalrecord`, `conclusion`, `conjecture`, `examined`, `iddoctor`, `idmedicine`, `idnuser`, `idpatient`, `price`) VALUES
(0, 'n', 'h', b'1', 'doc_672b666988ada', 0, 'nurse_672b8f59dc35d', 2, 55);

-- --------------------------------------------------------

--
-- Table structure for table `medicalrecord_medicine`
--

CREATE TABLE `medicalrecord_medicine` (
  `idmedicalmecord` int(11) NOT NULL,
  `idmedicine` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `medicine`
--

CREATE TABLE `medicine` (
  `idmedicine` int(11) NOT NULL,
  `expirationdate` datetime(6) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `price` varchar(255) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `medicine`
--

INSERT INTO `medicine` (`idmedicine`, `expirationdate`, `name`, `price`, `quantity`) VALUES
(1, '2002-02-02 00:00:00.000000', 'nam', '12', 12);

-- --------------------------------------------------------

--
-- Table structure for table `nuser`
--

CREATE TABLE `nuser` (
  `idperson` varchar(255) NOT NULL,
  `age` int(11) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `phonenumber` varchar(255) DEFAULT NULL,
  `sex` enum('FEMALE','MALE') DEFAULT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `degree` varchar(255) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `room` enum('BONE_DENSITOMETRY','CARDIAC_DIAGNOSTICS','ECHOCARDIOGRAPHY','ELECTROCARDIOGRAPHY','ELECTROENCEPHALOGRAPHY','ENDOSCOPY','LABORATORY','MEDICATION_MANAGEMENT','PATIENT_CARE','PULMONARY_FUNCTION_TEST','RADIOLOGY_DEPARTMENT') DEFAULT NULL,
  `yearsexperience` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `nuser`
--

INSERT INTO `nuser` (`idperson`, `age`, `email`, `name`, `phonenumber`, `sex`, `avatar`, `degree`, `price`, `room`, `yearsexperience`) VALUES
('nurse_672b8f59dc35d', 0, '', '', '', 'MALE', 'https://png.pngtree.com/png-vector/20241016/ourmid/pngtree-3d-cute-girl-docotr-png-image_14098552.png', '', 0, '', 0),
('nurse_672b8f5a2a6ab', 16, 'ly1@gmail.com', 'ly', '0833774532', 'FEMALE', 'https://png.pngtree.com/png-vector/20240625/ourmid/pngtree-young-lady-doctor-cartoon-character-png-image_12842426.png', 'Đại học', 900, '', 0),
('nurse_672b922e9147e', 22, 'lan22@gmail.com', 'lan', '0943252345', 'FEMALE', 'https://png.pngtree.com/element_our/png_detail/20181024/doctor-avatar-icon-medical-health-specialist-avatar-woman-doctor-avatar-png_217575.jpg', 'MEDICATION_MANAGEMENT', 200, '', 1);

-- --------------------------------------------------------

--
-- Table structure for table `onleave`
--

CREATE TABLE `onleave` (
  `id` int(11) NOT NULL,
  `enddate` datetime(6) DEFAULT NULL,
  `idperson` varchar(255) DEFAULT NULL,
  `startdate` datetime(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `patient`
--

CREATE TABLE `patient` (
  `idpatient` int(11) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `phonenumber` varchar(255) DEFAULT NULL,
  `sex` enum('FEMALE','MALE') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `patient`
--

INSERT INTO `patient` (`idpatient`, `address`, `age`, `name`, `phonenumber`, `sex`) VALUES
(2, 'ha niu', 12, 'long', '0999999999', 'FEMALE'),
(4, 'hcm', 22, 'hung', '0736475832', 'MALE'),
(5, '', 0, '', '', 'MALE'),
(6, 'hy', 12, 'hung', '0843524332', 'MALE');

-- --------------------------------------------------------

--
-- Table structure for table `person`
--

CREATE TABLE `person` (
  `idperson` varchar(255) NOT NULL,
  `age` int(11) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `phonenumber` varchar(255) DEFAULT NULL,
  `sex` enum('FEMALE','MALE') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `account`
--
ALTER TABLE `account`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `doctor`
--
ALTER TABLE `doctor`
  ADD PRIMARY KEY (`idperson`);

--
-- Indexes for table `medicalrecord`
--
ALTER TABLE `medicalrecord`
  ADD PRIMARY KEY (`idmedicalrecord`),
  ADD KEY `FK7cxbvtkdxtae1ql19rynmny38` (`iddoctor`),
  ADD KEY `FKf02fdmc0qfbgfj02r2imjjdkd` (`idnuser`),
  ADD KEY `FK5e3ht718ov0lebguwbqcexrxu` (`idpatient`);

--
-- Indexes for table `medicalrecord_medicine`
--
ALTER TABLE `medicalrecord_medicine`
  ADD KEY `FKcqqc1t440xobvllpklylc5qwy` (`idmedicalmecord`),
  ADD KEY `FK9a00cp4ohwxr8ro6c2fqokuks` (`idmedicine`);

--
-- Indexes for table `medicine`
--
ALTER TABLE `medicine`
  ADD PRIMARY KEY (`idmedicine`);

--
-- Indexes for table `nuser`
--
ALTER TABLE `nuser`
  ADD PRIMARY KEY (`idperson`);

--
-- Indexes for table `onleave`
--
ALTER TABLE `onleave`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKns253y9tw9kyqeymna4mofwe2` (`idperson`);

--
-- Indexes for table `patient`
--
ALTER TABLE `patient`
  ADD PRIMARY KEY (`idpatient`);

--
-- Indexes for table `person`
--
ALTER TABLE `person`
  ADD PRIMARY KEY (`idperson`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `medicine`
--
ALTER TABLE `medicine`
  MODIFY `idmedicine` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `patient`
--
ALTER TABLE `patient`
  MODIFY `idpatient` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `medicalrecord`
--
ALTER TABLE `medicalrecord`
  ADD CONSTRAINT `FK5e3ht718ov0lebguwbqcexrxu` FOREIGN KEY (`idpatient`) REFERENCES `patient` (`idpatient`),
  ADD CONSTRAINT `FK7cxbvtkdxtae1ql19rynmny38` FOREIGN KEY (`iddoctor`) REFERENCES `doctor` (`idperson`),
  ADD CONSTRAINT `FKf02fdmc0qfbgfj02r2imjjdkd` FOREIGN KEY (`idnuser`) REFERENCES `nuser` (`idperson`);

--
-- Constraints for table `medicalrecord_medicine`
--
ALTER TABLE `medicalrecord_medicine`
  ADD CONSTRAINT `FK9a00cp4ohwxr8ro6c2fqokuks` FOREIGN KEY (`idmedicine`) REFERENCES `medicine` (`idmedicine`),
  ADD CONSTRAINT `FKcqqc1t440xobvllpklylc5qwy` FOREIGN KEY (`idmedicalmecord`) REFERENCES `medicalrecord` (`idmedicalrecord`);

--
-- Constraints for table `onleave`
--
ALTER TABLE `onleave`
  ADD CONSTRAINT `FKns253y9tw9kyqeymna4mofwe2` FOREIGN KEY (`idperson`) REFERENCES `doctor` (`idperson`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
