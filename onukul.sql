-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 21, 2025 at 12:30 AM
-- Server version: 10.4.22-MariaDB
-- PHP Version: 8.1.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `onukul`
--

-- --------------------------------------------------------

--
-- Table structure for table `aid_item`
--

CREATE TABLE `aid_item` (
  `item_id` int(11) NOT NULL,
  `item_type` varchar(9) NOT NULL,
  `item_name` varchar(22) NOT NULL,
  `item_unit` int(11) NOT NULL,
  `last_updated` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `aid_request`
--

CREATE TABLE `aid_request` (
  `request_id` int(11) NOT NULL,
  `request_date` date NOT NULL,
  `request_status` varchar(9) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `aid_request`
--

INSERT INTO `aid_request` (`request_id`, `request_date`, `request_status`, `user_id`) VALUES
(1, '2024-04-02', 'pending', 1),
(2, '2024-04-05', 'approved', 2),
(3, '2024-04-06', 'rejected', 3),
(4, '2024-04-08', 'pending', 4),
(5, '2024-04-12', 'approved', 5),
(6, '2024-04-15', 'pending', 6),
(7, '2024-04-18', 'rejected', 7),
(8, '2024-04-19', 'approved', 8),
(9, '2024-04-22', 'pending', 9),
(10, '2024-04-25', 'approved', 10);

-- --------------------------------------------------------

--
-- Table structure for table `distributing_process`
--

CREATE TABLE `distributing_process` (
  `distribution_id` int(11) NOT NULL,
  `location_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `distribution`
--

CREATE TABLE `distribution` (
  `distribution_id` int(11) NOT NULL,
  `distribution_date` date NOT NULL,
  `distribution_type` varchar(9) NOT NULL,
  `request_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `donation`
--

CREATE TABLE `donation` (
  `donation_id` int(11) NOT NULL,
  `donation_type` varchar(9) NOT NULL,
  `donation_date` date NOT NULL,
  `amount_given` int(11) NOT NULL,
  `item_given` varchar(19) NOT NULL,
  `donated_by` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `donation`
--

INSERT INTO `donation` (`donation_id`, `donation_type`, `donation_date`, `amount_given`, `item_given`, `donated_by`) VALUES
(1, 'money', '2024-04-01', 5000, '', 1),
(2, 'goods', '2024-04-03', 0, 'Blankets', 2),
(3, 'money', '2024-04-05', 2500, '', 3),
(4, 'goods', '2024-04-07', 0, 'School Bags', 4),
(5, 'money', '2024-04-10', 10000, '', 5),
(6, 'goods', '2024-04-12', 0, 'Food Packs', 6),
(7, 'money', '2024-04-15', 1500, '', 7),
(8, 'goods', '2024-04-18', 0, 'Mosquito Nets', 8),
(9, 'money', '2024-04-20', 3500, '', 9),
(10, 'goods', '2024-04-25', 0, 'Medical Kits', 10);

-- --------------------------------------------------------

--
-- Table structure for table `location`
--

CREATE TABLE `location` (
  `location_id` int(11) NOT NULL,
  `vulnerability_level` int(11) NOT NULL,
  `division` varchar(9) NOT NULL,
  `district` varchar(9) NOT NULL,
  `area_name` varchar(19) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `requesting_process`
--

CREATE TABLE `requesting_process` (
  `request_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `story`
--

CREATE TABLE `story` (
  `story_id` int(11) NOT NULL,
  `before_visual` text NOT NULL,
  `after_visual` text NOT NULL,
  `story_date` date NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `story`
--

INSERT INTO `story` (`story_id`, `before_visual`, `after_visual`, `story_date`, `user_id`) VALUES
(1, 'Old broken hut', 'New shelter built', '2024-04-05', 1),
(2, 'Empty classroom with no books', 'Classroom filled with supplies', '2024-04-07', 2),
(3, 'Family without food', 'Food packages delivered', '2024-04-09', 3),
(4, 'Flooded village street', 'Repaired and cleaned area', '2024-04-11', 4),
(5, 'Sick child untreated', 'Child receiving medical care', '2024-04-13', 5),
(6, 'Cold night without blankets', 'Warm with donated blankets', '2024-04-15', 6),
(7, 'Homeless elder sleeping outside', 'Moved into safe housing', '2024-04-17', 7),
(8, 'Children without school bags', 'All students have new bags', '2024-04-19', 8),
(9, 'Disabled man struggling to move', 'Received wheelchair support', '2024-04-21', 9),
(10, 'Community with no clean water', 'New water filter installed', '2024-04-23', 10);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `user_id` int(11) NOT NULL,
  `nid` int(11) NOT NULL,
  `phone` int(11) NOT NULL,
  `registration_date` date NOT NULL,
  `email` varchar(33) NOT NULL,
  `password` varchar(19) NOT NULL,
  `first_name` varchar(9) NOT NULL,
  `last_name` varchar(9) NOT NULL,
  `age` int(11) NOT NULL,
  `type` varchar(9) NOT NULL,
  `credit_score` int(11) NOT NULL,
  `is_disabled` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`user_id`, `nid`, `phone`, `registration_date`, `email`, `password`, `first_name`, `last_name`, `age`, `type`, `credit_score`, `is_disabled`) VALUES
(1, 1234567890, 1711111111, '2024-01-10', 'ali.k@example.com', 'AliPass12', 'Ali', 'Khan', 28, 'donor', 720, 0),
(2, 1234567891, 1711111112, '2024-01-15', 'sara.b@example.com', 'SaraPwd9', 'Sara', 'Begum', 25, 'aid', 680, 0),
(3, 1234567892, 1711111113, '2024-01-20', 'rahim.u@example.com', 'RahimP@ss', 'Rahim', 'Uddin', 35, 'donor', 640, 0),
(4, 1234567893, 1711111114, '2024-02-01', 'fatema.a@example.com', 'Fatema12', 'Fatema', 'Akther', 31, 'aid', 710, 0),
(5, 1234567894, 1711111115, '2024-02-05', 'jamil.h@example.com', 'Jamil@45', 'Jamil', 'Hossain', 42, 'donor', 600, 1),
(6, 1234567895, 1711111116, '2024-02-15', 'maria.a@example.com', 'MariaPwd8', 'Maria', 'Akter', 22, 'aid', 750, 0),
(7, 1234567896, 1711111117, '2024-03-01', 'kamal.r@example.com', 'Kam@l321', 'Kamal', 'Rahman', 29, 'donor', 670, 0),
(8, 1234567897, 1711111118, '2024-03-10', 'sumaiya.j@example.com', 'Sumaiya77', 'Sumaiya', 'Jahan', 27, 'aid', 690, 0),
(9, 1234567898, 1711111119, '2024-03-20', 'abdul.k@example.com', 'Abdul1234', 'Abdul', 'Karim', 39, 'donor', 580, 1),
(10, 1234567899, 1711111120, '2024-03-25', 'ayesha.s@example.com', 'Ayesha22', 'Ayesha', 'Siddiqi', 33, 'aid', 730, 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `aid_item`
--
ALTER TABLE `aid_item`
  ADD PRIMARY KEY (`item_id`);

--
-- Indexes for table `aid_request`
--
ALTER TABLE `aid_request`
  ADD PRIMARY KEY (`request_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `distributing_process`
--
ALTER TABLE `distributing_process`
  ADD PRIMARY KEY (`distribution_id`,`location_id`,`user_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `distribution_id` (`distribution_id`,`location_id`,`user_id`),
  ADD KEY `location_id` (`location_id`);

--
-- Indexes for table `distribution`
--
ALTER TABLE `distribution`
  ADD PRIMARY KEY (`distribution_id`),
  ADD KEY `request_id` (`request_id`),
  ADD KEY `request_id_2` (`request_id`);

--
-- Indexes for table `donation`
--
ALTER TABLE `donation`
  ADD PRIMARY KEY (`donation_id`),
  ADD KEY `donated_by` (`donated_by`);

--
-- Indexes for table `location`
--
ALTER TABLE `location`
  ADD PRIMARY KEY (`location_id`);

--
-- Indexes for table `requesting_process`
--
ALTER TABLE `requesting_process`
  ADD PRIMARY KEY (`request_id`,`item_id`),
  ADD KEY `request_id` (`request_id`,`item_id`),
  ADD KEY `item_id` (`item_id`);

--
-- Indexes for table `story`
--
ALTER TABLE `story`
  ADD PRIMARY KEY (`story_id`),
  ADD KEY `story_id` (`story_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `nid` (`nid`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `aid_request`
--
ALTER TABLE `aid_request`
  ADD CONSTRAINT `aid_request_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`);

--
-- Constraints for table `distributing_process`
--
ALTER TABLE `distributing_process`
  ADD CONSTRAINT `distributing_process_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`),
  ADD CONSTRAINT `distributing_process_ibfk_2` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`),
  ADD CONSTRAINT `distributing_process_ibfk_3` FOREIGN KEY (`distribution_id`) REFERENCES `distribution` (`distribution_id`);

--
-- Constraints for table `distribution`
--
ALTER TABLE `distribution`
  ADD CONSTRAINT `distribution_ibfk_1` FOREIGN KEY (`request_id`) REFERENCES `aid_request` (`request_id`);

--
-- Constraints for table `donation`
--
ALTER TABLE `donation`
  ADD CONSTRAINT `donation_ibfk_1` FOREIGN KEY (`donated_by`) REFERENCES `user` (`user_id`);

--
-- Constraints for table `requesting_process`
--
ALTER TABLE `requesting_process`
  ADD CONSTRAINT `requesting_process_ibfk_1` FOREIGN KEY (`request_id`) REFERENCES `aid_request` (`request_id`),
  ADD CONSTRAINT `requesting_process_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `aid_item` (`item_id`);

--
-- Constraints for table `story`
--
ALTER TABLE `story`
  ADD CONSTRAINT `story_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
