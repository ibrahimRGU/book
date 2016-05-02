-- Adminer 4.2.4 MySQL dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

DROP TABLE IF EXISTS `attachments`;
CREATE TABLE `attachments` (
  `attachmentID` int(11) NOT NULL AUTO_INCREMENT,
  `URL` varchar(64) NOT NULL,
  `userID` int(11) NOT NULL,
  `bugID` int(11) NOT NULL,
  PRIMARY KEY (`attachmentID`),
  KEY `userID` (`userID`),
  KEY `photoID` (`bugID`),
  CONSTRAINT `attachments_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `users` (`userID`) ON DELETE CASCADE,
  CONSTRAINT `attachments_ibfk_2` FOREIGN KEY (`bugID`) REFERENCES `bugs` (`bugID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `comments`;
CREATE TABLE `comments` (
  `commentID` int(11) NOT NULL AUTO_INCREMENT,
  `description` text NOT NULL,
  `postDate` datetime NOT NULL,
  `userID` int(11) NOT NULL,
  `photoID` int(11) NOT NULL,
  PRIMARY KEY (`commentID`),
  KEY `userID` (`userID`),
  KEY `photoID` (`photoID`),
  CONSTRAINT `comments_ibfk_3` FOREIGN KEY (`userID`) REFERENCES `users` (`userID`) ON DELETE CASCADE,
  CONSTRAINT `comments_ibfk_4` FOREIGN KEY (`photoID`) REFERENCES `photos` (`photoID`) ON DELETE CASCADE,
  CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `users` (`userID`) ON DELETE CASCADE,
  CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`photoID`) REFERENCES `photos` (`photoID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `photos`;
CREATE TABLE `photos` (
  `photoID` int(11) NOT NULL AUTO_INCREMENT,
  `title` text NOT NULL,
  `description` text,
  `postDate` datetime NOT NULL,
  `url` text NOT NULL,
  `userID` int(11) NOT NULL,
  PRIMARY KEY (`photoID`),
  KEY `userID` (`userID`),
  CONSTRAINT `photos_ibfk_3` FOREIGN KEY (`userID`) REFERENCES `users` (`userID`) ON DELETE CASCADE,
  CONSTRAINT `photos_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `users` (`userID`) ON DELETE CASCADE,
  CONSTRAINT `photos_ibfk_2` FOREIGN KEY (`userID`) REFERENCES `users` (`userID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=161 DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `userID` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(32) NOT NULL,
  `password` varchar(32) NOT NULL,
  `email` varchar(32) NOT NULL,
  `admin` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`userID`)
) ENGINE=InnoDB AUTO_INCREMENT=141 DEFAULT CHARSET=utf8;

INSERT INTO `users` (`userID`, `username`, `password`, `email`, `admin`) VALUES
(111,	'admin',	'admin',	'admin@admin.com',	1),
(121,	'testuser',	'testuser',	'testuser@test.com',	0),
(131,	'george',	'osborne',	'g.osborne@tory.com',	0);

-- 2016-04-12 23:24:48
