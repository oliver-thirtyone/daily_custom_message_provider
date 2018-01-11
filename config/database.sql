SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

CREATE DATABASE IF NOT EXISTS `daily_custom_message` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
USE `daily_custom_message`;

DROP TABLE IF EXISTS `instance`;
CREATE TABLE IF NOT EXISTS `instance` (
`pk` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

DROP TABLE IF EXISTS `message`;
CREATE TABLE IF NOT EXISTS `message` (
`pk` int(11) NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `fk_instance` int(11) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

DROP TABLE IF EXISTS `message_entry`;
CREATE TABLE IF NOT EXISTS `message_entry` (
`pk` int(11) NOT NULL AUTO_INCREMENT,
  `entry` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `sorting` int(11) DEFAULT NULL,
  `comment` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_message_entry_type` int(11) NOT NULL,
  `fk_message` int(11) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

DROP TABLE IF EXISTS `message_entry_type`;
CREATE TABLE IF NOT EXISTS `message_entry_type` (
`pk` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(30) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


ALTER TABLE `instance`
 ADD PRIMARY KEY (`pk`), ADD UNIQUE KEY `name` (`name`);

ALTER TABLE `message`
 ADD PRIMARY KEY (`pk`), ADD KEY `fk_instance` (`fk_instance`);

ALTER TABLE `message_entry`
 ADD PRIMARY KEY (`pk`), ADD UNIQUE KEY `unique_sorting` (`sorting`,`fk_message`), ADD KEY `fk_message_entry_type` (`fk_message_entry_type`), ADD KEY `fk_message` (`fk_message`);

ALTER TABLE `message_entry_type`
 ADD PRIMARY KEY (`pk`), ADD UNIQUE KEY `name` (`type`);


ALTER TABLE `message`
ADD CONSTRAINT `message_fk_instance` FOREIGN KEY (`fk_instance`) REFERENCES `instance` (`pk`);

ALTER TABLE `message_entry`
ADD CONSTRAINT `message_entry_fk_message_entry_type` FOREIGN KEY (`fk_message_entry_type`) REFERENCES `message_entry_type` (`pk`),
ADD CONSTRAINT `message_entry_fk_message` FOREIGN KEY (`fk_message`) REFERENCES `message` (`pk`) ON DELETE CASCADE;
