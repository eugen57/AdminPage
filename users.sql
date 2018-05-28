-- phpMyAdmin SQL Dump
-- version 3.5.1
-- http://www.phpmyadmin.net
--
-- Хост: 127.0.0.1
-- Время создания: Май 22 2018 г., 20:47
-- Версия сервера: 5.5.25
-- Версия PHP: 5.3.13

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- База данных: `users`
--

-- --------------------------------------------------------

--
-- Структура таблицы `privileges`
--

CREATE TABLE IF NOT EXISTS `privileges` (
  `id` int(6) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL DEFAULT 'noPriviledge',
  `description` varchar(50) NOT NULL DEFAULT 'noPriviledge',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Дамп данных таблицы `privileges`
--

INSERT INTO `privileges` (`id`, `name`, `description`) VALUES
(1, 'readMessages', 'User is allowed to read messages from other users'),
(2, 'sendMessages', 'User is allowed to send messages to other users'),
(3, 'readAndSend', 'User is allowed to read and send messages'),
(4, 'changeInfo', 'User is allowed to change personal information');

-- --------------------------------------------------------

--
-- Структура таблицы `userprivileges`
--

CREATE TABLE IF NOT EXISTS `userprivileges` (
  `id` int(6) NOT NULL AUTO_INCREMENT,
  `userId` int(6) NOT NULL,
  `privilegeId` int(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=34 ;

--
-- Дамп данных таблицы `userprivileges`
--

INSERT INTO `userprivileges` (`id`, `userId`, `privilegeId`) VALUES
(3, 2, 1),
(24, 17, 1),
(25, 17, 2),
(26, 17, 3),
(27, 1, 3),
(28, 21, 1),
(29, 21, 2),
(30, 21, 3),
(31, 21, 4),
(33, 20, 4);

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `firstName` varchar(25) NOT NULL DEFAULT 'noFirstName',
  `lastName` varchar(25) NOT NULL DEFAULT 'noLastName',
  `email` varchar(20) NOT NULL DEFAULT 'noEmail',
  `phone` varchar(15) NOT NULL DEFAULT 'noPhone',
  `password` varchar(20) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=23 ;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`id`, `firstName`, `lastName`, `email`, `phone`, `password`) VALUES
(1, 'Jack', 'Nicholson', 'jack@gmail.com', '834556', 'qwertqwer'),
(5, 'Evgenii', 'Benke', 'evgen@mail.ru', '37437834', 'qwert'),
(6, 'Tom', 'Thomas', 'tom@gmail.com', '24123', 'qwert'),
(12, 'Vasya', 'Vasinn', 'vasya@mail.ru', '787829', 'qwert'),
(13, 'Fedor', 'Fedorov', 'fedya@mail.ru', '9293239', 'qwertFedya'),
(22, 'Admin', '', 'admin@mail.ru', '', 'admin123');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
