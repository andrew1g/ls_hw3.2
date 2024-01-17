-- --------------------------------------------------------
-- Хост:                         localhost
-- Версия сервера:               10.4.28-MariaDB - mariadb.org binary distribution
-- Операционная система:         Win64
-- HeidiSQL Версия:              11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Дамп структуры базы данных ls_ordersdb
DROP DATABASE IF EXISTS `ls_ordersdb`;
CREATE DATABASE IF NOT EXISTS `ls_ordersdb` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */;
USE `ls_ordersdb`;

-- Дамп структуры для таблица ls_ordersdb.clients
DROP TABLE IF EXISTS `clients`;
CREATE TABLE IF NOT EXISTS `clients` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `name` varchar(16) NOT NULL,
  `create_time` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_email` (`email`),
  KEY `search_email` (`email`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Клиенты';

-- Дамп данных таблицы ls_ordersdb.clients: ~3 rows (приблизительно)
DELETE FROM `clients`;
/*!40000 ALTER TABLE `clients` DISABLE KEYS */;
INSERT INTO `clients` (`id`, `email`, `name`, `create_time`) VALUES
	(9, 'ivan@jj.po', 'ivan@jj.po', '2024-01-17 19:20:46'),
	(10, 'andrey@ff.com', 'andrey@ff.com', '2024-01-17 19:21:35'),
	(11, 'sergey@ll.com', 'sergey@ll.com', '2024-01-17 19:22:13');
/*!40000 ALTER TABLE `clients` ENABLE KEYS */;

-- Дамп структуры для таблица ls_ordersdb.orders
DROP TABLE IF EXISTS `orders`;
CREATE TABLE IF NOT EXISTS `orders` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID заказа',
  `client_id` int(11) unsigned NOT NULL COMMENT 'id клиента',
  `date` date NOT NULL DEFAULT curdate() COMMENT 'Дата Заказа',
  `address` varchar(300) NOT NULL COMMENT 'Полный адрес клиента',
  `create_time` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `FK_orders_clients` (`client_id`) USING BTREE,
  CONSTRAINT `FK_orders_clients` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Заказы клиентов';

-- Дамп данных таблицы ls_ordersdb.orders: ~8 rows (приблизительно)
DELETE FROM `orders`;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` (`id`, `client_id`, `date`, `address`, `create_time`) VALUES
	(1, 9, '2024-01-17', 'Санкт-Петербург, улица Моголя, дом 234, корпус 3, квартира 2, этаж 5', '2024-01-17 19:20:46'),
	(2, 9, '2024-01-17', 'Санкт-Петербург, улица Моголя, дом 234, корпус 3, квартира 2, этаж 5', '2024-01-17 19:20:59'),
	(3, 9, '2024-01-17', 'Санкт-Петербург, улица Моголя, дом 234, корпус 3, квартира 2, этаж 5', '2024-01-17 19:21:02'),
	(4, 10, '2024-01-17', 'Санкт-Петербург, улица Ленина, дом 4, квартира 34, этаж 1', '2024-01-17 19:21:35'),
	(5, 10, '2024-01-17', 'Санкт-Петербург, улица Ленина, дом 4, квартира 34, этаж 1', '2024-01-17 19:21:40'),
	(6, 10, '2024-01-17', 'Санкт-Петербург, улица Ленина, дом 4, квартира 34, этаж 1', '2024-01-17 19:21:42'),
	(7, 10, '2024-01-17', 'Санкт-Петербург, улица Ленина, дом 4, квартира 34, этаж 1', '2024-01-17 19:21:45'),
	(8, 11, '2024-01-17', 'Санкт-Петербург, улица Малышева, дом 101, квартира 67, этаж 10', '2024-01-17 19:22:13');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
