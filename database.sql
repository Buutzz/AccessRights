-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Aug 15, 2023 at 04:48 PM
-- Server version: 10.4.30-MariaDB-cll-lve
-- PHP Version: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


-- --------------------------------------------------------

--
-- Table structure for table `function_rights`
--

CREATE TABLE IF NOT EXISTS `function_rights` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `module_id` int(11) DEFAULT NULL,
  `function_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `group_id` (`group_id`),
  KEY `user_id` (`user_id`),
  KEY `module_id` (`module_id`),
  KEY `function_id` (`function_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `function_rights`
--

INSERT INTO `function_rights` (`id`, `group_id`, `user_id`, `module_id`, `function_id`) VALUES
(1, 1, NULL, 1, 1),
(2, 1, NULL, 1, 2),
(3, 2, NULL, 2, 3),
(4, NULL, 1, 1, 1),
(5, NULL, 2, 2, 3),
(6, NULL, 2, 1, 2),
(7, NULL, 3, NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `modules`
--

CREATE TABLE IF NOT EXISTS `modules` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `module_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `module_name` (`module_name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `modules`
--

INSERT INTO `modules` (`id`, `module_name`) VALUES
(1, 'module1'),
(2, 'module2');

-- --------------------------------------------------------

--
-- Table structure for table `module_functions`
--

CREATE TABLE IF NOT EXISTS `module_functions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `function_name` varchar(255) DEFAULT NULL,
  `module_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `module_id` (`module_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `module_functions`
--

INSERT INTO `module_functions` (`id`, `function_name`, `module_id`) VALUES
(1, 'function1', 1),
(2, 'function2', 1),
(3, 'function3', 2);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`) VALUES
(1, 'user1'),
(2, 'user2'),
(3, 'user3');

-- --------------------------------------------------------

--
-- Table structure for table `user_groups`
--

CREATE TABLE IF NOT EXISTS `user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `group_name` (`group_name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `user_groups`
--

INSERT INTO `user_groups` (`id`, `group_name`) VALUES
(1, 'group1'),
(2, 'group2');

-- --------------------------------------------------------

--
-- Table structure for table `user_group_relations`
--

CREATE TABLE IF NOT EXISTS `user_group_relations` (
  `user_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  KEY `user_id` (`user_id`),
  KEY `group_id` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `user_group_relations`
--

INSERT INTO `user_group_relations` (`user_id`, `group_id`) VALUES
(1, 1),
(2, 1),
(3, 2);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `function_rights`
--
ALTER TABLE `function_rights`
  ADD CONSTRAINT `function_rights_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `user_groups` (`id`),
  ADD CONSTRAINT `function_rights_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `function_rights_ibfk_3` FOREIGN KEY (`module_id`) REFERENCES `modules` (`id`),
  ADD CONSTRAINT `function_rights_ibfk_4` FOREIGN KEY (`function_id`) REFERENCES `module_functions` (`id`);

--
-- Constraints for table `module_functions`
--
ALTER TABLE `module_functions`
  ADD CONSTRAINT `module_functions_ibfk_1` FOREIGN KEY (`module_id`) REFERENCES `modules` (`id`);

--
-- Constraints for table `user_group_relations`
--
ALTER TABLE `user_group_relations`
  ADD CONSTRAINT `user_group_relations_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `user_group_relations_ibfk_2` FOREIGN KEY (`group_id`) REFERENCES `user_groups` (`id`);
COMMIT;