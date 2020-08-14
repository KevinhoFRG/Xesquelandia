-- --------------------------------------------------------
-- Servidor:                     127.0.0.1
-- Versão do servidor:           10.1.38-MariaDB - mariadb.org binary distribution
-- OS do Servidor:               Win64
-- HeidiSQL Versão:              10.1.0.5464
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Copiando estrutura do banco de dados para vrp
CREATE DATABASE IF NOT EXISTS `vrp` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `vrp`;

-- Copiando estrutura para tabela vrp.concessionaria
CREATE TABLE IF NOT EXISTS `concessionaria` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nomecarro` varchar(50) DEFAULT NULL,
  `estoquecarro` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=530 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela vrp.concessionaria: ~70 rows (aproximadamente)
/*!40000 ALTER TABLE `concessionaria` DISABLE KEYS */;
INSERT INTO `concessionaria` (`id`, `nomecarro`, `estoquecarro`) VALUES
	(1, 'ds4', 95),
	(2, 'punto', 96),
	(3, 'f150', 97),
	(4, 'fusion', 99),
	(5, 'fordka', 99),
	(6, 'vwgolf', 98),
	(7, 'civic', 98),
	(8, 'eletran17', 99),
	(9, 'sonata18', 99),
	(10, 'veloster', 99),
	(11, 'monza', 99),
	(12, 'p207', 99),
	(13, 'vwpolo', 98),
	(14, 'evoq', 99),
	(15, 'santafe', 99),
	(16, 'celta', 99),
	(17, 'amarok', 99),
	(18, 'civic2016', 99),
	(19, 'fiat', 99),
	(20, 'jetta2017', 99),
	(21, 'l200civil', 98),
	(22, 'saveiro', 99),
	(23, 'upzinho', 99),
	(24, 'voyage', 99),
	(25, 'golg7', 99),
	(26, 'fiattoro', 99),
	(27, 'palio', 99),
	(28, 'fiatuno', 99),
	(29, 'fiatstilo', 99),
	(30, 'surfer', 99),
	(31, 'panto', 99),
	(32, 'blista', 99),
	(33, 'sultan', 99),
	(34, 'bison', 99),
	(35, 'rhapsody', 99),
	(36, 'prairie', 99),
	(37, 'felon', 99),
	(38, 'jackal', 99),
	(39, 'oracle', 99),
	(40, 'brioso', 99),
	(500, 'biz25', 99),
	(501, '150', 99),
	(502, 'bros60', 99),
	(503, 'xt66', 99),
	(504, '450crf', 99),
	(505, 'xj', 99),
	(506, 'hornet', 99),
	(507, 'dm1200', 99),
	(508, 'z1000', 99),
	(509, 'r1250', 99),
	(510, 'faggio2', 98),
	(511, 'bati', 97),
	(512, 'hakuchou', 89),
	(513, 'manchez', 95),
	(514, 'sanchez2', 94),
	(515, 'double', 91),
	(516, 'diablous2', 94),
	(517, 'zombiea', 100),
	(518, 'akuma', 95),
	(519, 'bf400', 66),
	(520, 'carbonrs', 32),
	(521, 'daemon2', 42),
	(522, 'hexer', 63),
	(523, 'nightblade', 55),
	(524, 'sanchez', 5),
	(525, 'vader', 70),
	(526, 'vortex', 63),
	(527, 'wolfsbane', 63),
	(528, 'zombieb', 63),
	(529, 'blazer', 20);
/*!40000 ALTER TABLE `concessionaria` ENABLE KEYS */;

-- Copiando estrutura para tabela vrp.phone_app_chat
CREATE TABLE IF NOT EXISTS `phone_app_chat` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `channel` varchar(20) NOT NULL,
  `message` varchar(255) NOT NULL,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela vrp.phone_app_chat: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `phone_app_chat` DISABLE KEYS */;
/*!40000 ALTER TABLE `phone_app_chat` ENABLE KEYS */;

-- Copiando estrutura para tabela vrp.phone_calls
CREATE TABLE IF NOT EXISTS `phone_calls` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner` varchar(10) NOT NULL COMMENT 'Num tel proprio',
  `num` varchar(10) NOT NULL COMMENT 'Num reférence du contact',
  `incoming` int(11) NOT NULL COMMENT 'Défini si on est à l''origine de l''appels',
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `accepts` int(11) NOT NULL COMMENT 'Appels accepter ou pas',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela vrp.phone_calls: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `phone_calls` DISABLE KEYS */;
/*!40000 ALTER TABLE `phone_calls` ENABLE KEYS */;

-- Copiando estrutura para tabela vrp.phone_messages
CREATE TABLE IF NOT EXISTS `phone_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `transmitter` varchar(10) NOT NULL,
  `receiver` varchar(10) NOT NULL,
  `message` varchar(255) NOT NULL DEFAULT '0',
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `isRead` int(11) NOT NULL DEFAULT '0',
  `owner` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela vrp.phone_messages: 0 rows
/*!40000 ALTER TABLE `phone_messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `phone_messages` ENABLE KEYS */;

-- Copiando estrutura para tabela vrp.phone_users_contacts
CREATE TABLE IF NOT EXISTS `phone_users_contacts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(60) CHARACTER SET utf8mb4 DEFAULT NULL,
  `number` varchar(10) CHARACTER SET utf8mb4 DEFAULT NULL,
  `display` varchar(64) CHARACTER SET utf8mb4 NOT NULL DEFAULT '-1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela vrp.phone_users_contacts: 0 rows
/*!40000 ALTER TABLE `phone_users_contacts` DISABLE KEYS */;
/*!40000 ALTER TABLE `phone_users_contacts` ENABLE KEYS */;

-- Copiando estrutura para tabela vrp.policia
CREATE TABLE IF NOT EXISTS `policia` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `police_id` int(11) NOT NULL,
  `dkey` varchar(45) COLLATE utf8_bin NOT NULL,
  `dvalue` text COLLATE utf8_bin,
  `img` varchar(150) COLLATE utf8_bin DEFAULT NULL,
  `valor` decimal(10,2) DEFAULT NULL,
  `datahora` datetime DEFAULT NULL,
  `id_pai` int(11) DEFAULT '0',
  PRIMARY KEY (`id`,`dkey`,`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=287 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Copiando dados para a tabela vrp.policia: ~5 rows (aproximadamente)
/*!40000 ALTER TABLE `policia` DISABLE KEYS */;
INSERT INTO `policia` (`id`, `user_id`, `police_id`, `dkey`, `dvalue`, `img`, `valor`, `datahora`, `id_pai`) VALUES
	(282, 1, 1, 'multa', 'Multa', 'https://i.imgur.com/PTVt1un.png', 5000.00, '2019-10-23 18:59:18', 0),
	(283, 1, 1, 'prisao', 'Teste', NULL, 1.00, '2019-10-23 19:01:37', 0),
	(284, 1, 1, 'multa', 'Teste', NULL, 500.00, '2019-10-23 19:01:38', 0),
	(285, 1, 1, 'prisao', 'teste', NULL, 1.00, '2019-12-14 19:29:00', 0),
	(286, 1, 1, 'multa', 'teste', NULL, 123.00, '2019-12-14 19:29:01', 0);
/*!40000 ALTER TABLE `policia` ENABLE KEYS */;

-- Copiando estrutura para tabela vrp.twitter_accounts
CREATE TABLE IF NOT EXISTS `twitter_accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8 NOT NULL DEFAULT '0',
  `password` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT '0',
  `avatar_url` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Copiando dados para a tabela vrp.twitter_accounts: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `twitter_accounts` DISABLE KEYS */;
/*!40000 ALTER TABLE `twitter_accounts` ENABLE KEYS */;

-- Copiando estrutura para tabela vrp.twitter_likes
CREATE TABLE IF NOT EXISTS `twitter_likes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `authorId` int(11) DEFAULT NULL,
  `tweetId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_twitter_likes_twitter_accounts` (`authorId`),
  KEY `FK_twitter_likes_twitter_tweets` (`tweetId`),
  CONSTRAINT `FK_twitter_likes_twitter_accounts` FOREIGN KEY (`authorId`) REFERENCES `twitter_accounts` (`id`),
  CONSTRAINT `FK_twitter_likes_twitter_tweets` FOREIGN KEY (`tweetId`) REFERENCES `twitter_tweets` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Copiando dados para a tabela vrp.twitter_likes: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `twitter_likes` DISABLE KEYS */;
/*!40000 ALTER TABLE `twitter_likes` ENABLE KEYS */;

-- Copiando estrutura para tabela vrp.twitter_tweets
CREATE TABLE IF NOT EXISTS `twitter_tweets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `authorId` int(11) NOT NULL,
  `realUser` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `message` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `likes` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `FK_twitter_tweets_twitter_accounts` (`authorId`),
  CONSTRAINT `FK_twitter_tweets_twitter_accounts` FOREIGN KEY (`authorId`) REFERENCES `twitter_accounts` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Copiando dados para a tabela vrp.twitter_tweets: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `twitter_tweets` DISABLE KEYS */;
/*!40000 ALTER TABLE `twitter_tweets` ENABLE KEYS */;

-- Copiando estrutura para tabela vrp.vrp_banco
CREATE TABLE IF NOT EXISTS `vrp_banco` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `extrato` varchar(255) DEFAULT NULL,
  `data` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela vrp.vrp_banco: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `vrp_banco` DISABLE KEYS */;
INSERT INTO `vrp_banco` (`id`, `user_id`, `extrato`, `data`) VALUES
	(9, 35, 'Você fez um saque rapído de <strong>$1.000</strong>, e seu saldo ficou em <strong>$0</strong>', '12/02/2020');
/*!40000 ALTER TABLE `vrp_banco` ENABLE KEYS */;

-- Copiando estrutura para tabela vrp.vrp_business
CREATE TABLE IF NOT EXISTS `vrp_business` (
  `user_id` int(11) NOT NULL,
  `capital` int(11) DEFAULT NULL,
  `laundered` int(11) DEFAULT NULL,
  `reset_timestamp` int(11) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `fk_business_users` FOREIGN KEY (`user_id`) REFERENCES `vrp_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela vrp.vrp_business: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `vrp_business` DISABLE KEYS */;
/*!40000 ALTER TABLE `vrp_business` ENABLE KEYS */;

-- Copiando estrutura para tabela vrp.vrp_concessionaria
CREATE TABLE IF NOT EXISTS `vrp_concessionaria` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `modelo` varchar(255) DEFAULT NULL,
  `nome` varchar(255) DEFAULT NULL,
  `preco` int(11) DEFAULT NULL,
  `quantidade` int(11) DEFAULT NULL,
  `descricao` text,
  `img` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4;

-- Copiando dados para a tabela vrp.vrp_concessionaria: ~16 rows (aproximadamente)
/*!40000 ALTER TABLE `vrp_concessionaria` DISABLE KEYS */;
INSERT INTO `vrp_concessionaria` (`id`, `modelo`, `nome`, `preco`, `quantidade`, `descricao`, `img`) VALUES
	(1, 'audirs6', 'Audi RS6', 850000, 10, 'Carro Importado!', 'https://cdn.discordapp.com/attachments/639489848297783296/639489979344486420/unknown.png'),
	(2, 'bmwm3f80', 'BMW M3', 900000, 10, 'Carro Importado!', 'https://cdn.discordapp.com/attachments/639489848297783296/639491981298499594/unknown.png'),
	(3, 'bmwm4gts', 'BMW M4', 950000, 10, 'Carro Importado!', 'https://cdn.discordapp.com/attachments/639489848297783296/639491289577947136/unknown.png'),
	(4, 'dodgechargersrt', 'Dodge Charger SR', 1400000, 9, 'Carro Importado!', 'https://cdn.discordapp.com/attachments/639489848297783296/639492053524283412/unknown.png'),
	(5, 'ferrariitalia', 'Ferrari Italia', 1500000, 9, 'Carro Importado!', 'https://cdn.discordapp.com/attachments/639489848297783296/639491425117011969/unknown.png'),
	(6, 'fordmustang', 'Ford Mustang GT', 1000000, 10, 'Carro Importado!', 'https://cdn.discordapp.com/attachments/639489848297783296/639491503055437876/unknown.png'),
	(7, 'lamborghinihuracan', 'Lamborghini Huracan', 1300000, 10, 'Carro Importado!', 'https://cdn.discordapp.com/attachments/639489848297783296/639491541395570698/unknown.png'),
	(8, 'lancerevolutionx', 'Lancer Evolution', 850000, 10, 'Carro Importado!', 'https://cdn.discordapp.com/attachments/639489848297783296/639492129646706688/unknown.png'),
	(9, 'mazdarx7', 'Mazda RX7', 1000000, 10, 'Carro Importado!', 'https://cdn.discordapp.com/attachments/639489848297783296/639492200203419691/unknown.png'),
	(10, 'mercedesamgc63', 'Mercedes AMG', 850000, 9, 'Carro Importado!', 'https://cdn.discordapp.com/attachments/639489848297783296/639491607799922708/unknown.png'),
	(11, 'nissan370z', 'Nissan 370z', 550000, 10, 'Carro Importado!', 'https://cdn.discordapp.com/attachments/639489848297783296/639491679723716608/unknown.png'),
	(12, 'nissangtr', 'Nissan GTR', 1150000, 10, 'Carro Importado!', 'https://cdn.discordapp.com/attachments/639489848297783296/639491714276524032/unknown.png'),
	(13, 'nissanskyliner34', 'Nissan Skyline', 1100000, 10, 'Carro Importado!', 'https://cdn.discordapp.com/attachments/639489848297783296/639491773823057920/unknown.png'),
	(14, 'paganihuayra', 'Pagani Huayra', 1500000, 10, 'Carro Importado!', 'https://cdn.discordapp.com/attachments/639489848297783296/639491826201657384/unknown.png'),
	(15, 'teslaprior', 'Tesla', 700000, 10, 'Carro Importado!', 'https://cdn.discordapp.com/attachments/639489848297783296/639491852898140180/unknown.png'),
	(16, 'toyotasupra', 'Toyota Supra', 1050000, 7, 'Carro Importado!', 'https://cdn.discordapp.com/attachments/639489848297783296/639491880069103621/unknown.png');
/*!40000 ALTER TABLE `vrp_concessionaria` ENABLE KEYS */;

-- Copiando estrutura para tabela vrp.vrp_helpdesk_respostas
CREATE TABLE IF NOT EXISTS `vrp_helpdesk_respostas` (
  `user_id` int(11) NOT NULL,
  `message` text NOT NULL,
  `case_id` int(11) NOT NULL,
  `createdAt` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela vrp.vrp_helpdesk_respostas: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `vrp_helpdesk_respostas` DISABLE KEYS */;
/*!40000 ALTER TABLE `vrp_helpdesk_respostas` ENABLE KEYS */;

-- Copiando estrutura para tabela vrp.vrp_helpdesk_ticket
CREATE TABLE IF NOT EXISTS `vrp_helpdesk_ticket` (
  `user_id` int(11) NOT NULL,
  `title` varchar(50) NOT NULL DEFAULT '',
  `message` varchar(2000) NOT NULL,
  `createdAt` varchar(24) NOT NULL DEFAULT '0',
  `status` int(2) NOT NULL DEFAULT '1',
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `case_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`,`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=75 DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela vrp.vrp_helpdesk_ticket: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `vrp_helpdesk_ticket` DISABLE KEYS */;
/*!40000 ALTER TABLE `vrp_helpdesk_ticket` ENABLE KEYS */;

-- Copiando estrutura para tabela vrp.vrp_srv_data
CREATE TABLE IF NOT EXISTS `vrp_srv_data` (
  `dkey` varchar(100) NOT NULL,
  `dvalue` text,
  PRIMARY KEY (`dkey`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela vrp.vrp_srv_data: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `vrp_srv_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `vrp_srv_data` ENABLE KEYS */;

-- Copiando estrutura para tabela vrp.vrp_users
CREATE TABLE IF NOT EXISTS `vrp_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `last_login` varchar(255) NOT NULL,
  `ip` varchar(255) NOT NULL,
  `whitelisted` tinyint(1) DEFAULT NULL,
  `banned` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela vrp.vrp_users: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `vrp_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `vrp_users` ENABLE KEYS */;

-- Copiando estrutura para tabela vrp.vrp_user_data
CREATE TABLE IF NOT EXISTS `vrp_user_data` (
  `user_id` int(11) NOT NULL,
  `dkey` varchar(100) NOT NULL,
  `dvalue` text,
  PRIMARY KEY (`user_id`,`dkey`),
  CONSTRAINT `fk_user_data_users` FOREIGN KEY (`user_id`) REFERENCES `vrp_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela vrp.vrp_user_data: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `vrp_user_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `vrp_user_data` ENABLE KEYS */;

-- Copiando estrutura para tabela vrp.vrp_user_homes
CREATE TABLE IF NOT EXISTS `vrp_user_homes` (
  `user_id` int(11) NOT NULL,
  `home` varchar(255) NOT NULL,
  `number` int(11) DEFAULT NULL,
  PRIMARY KEY (`user_id`,`home`),
  CONSTRAINT `fk_user_homes_users` FOREIGN KEY (`user_id`) REFERENCES `vrp_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela vrp.vrp_user_homes: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `vrp_user_homes` DISABLE KEYS */;
/*!40000 ALTER TABLE `vrp_user_homes` ENABLE KEYS */;

-- Copiando estrutura para tabela vrp.vrp_user_identities
CREATE TABLE IF NOT EXISTS `vrp_user_identities` (
  `user_id` int(11) NOT NULL,
  `registration` varchar(20) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `firstname` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `foragido` int(11) NOT NULL,
  `foto` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  KEY `registration` (`registration`),
  KEY `phone` (`phone`),
  CONSTRAINT `fk_user_identities_users` FOREIGN KEY (`user_id`) REFERENCES `vrp_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela vrp.vrp_user_identities: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `vrp_user_identities` DISABLE KEYS */;
/*!40000 ALTER TABLE `vrp_user_identities` ENABLE KEYS */;

-- Copiando estrutura para tabela vrp.vrp_user_ids
CREATE TABLE IF NOT EXISTS `vrp_user_ids` (
  `identifier` varchar(100) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`identifier`),
  KEY `fk_user_ids_users` (`user_id`),
  CONSTRAINT `fk_user_ids_users` FOREIGN KEY (`user_id`) REFERENCES `vrp_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela vrp.vrp_user_ids: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `vrp_user_ids` DISABLE KEYS */;
/*!40000 ALTER TABLE `vrp_user_ids` ENABLE KEYS */;

-- Copiando estrutura para tabela vrp.vrp_user_moneys
CREATE TABLE IF NOT EXISTS `vrp_user_moneys` (
  `user_id` int(11) NOT NULL,
  `wallet` int(11) DEFAULT NULL,
  `bank` int(11) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `fk_user_moneys_users` FOREIGN KEY (`user_id`) REFERENCES `vrp_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela vrp.vrp_user_moneys: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `vrp_user_moneys` DISABLE KEYS */;
/*!40000 ALTER TABLE `vrp_user_moneys` ENABLE KEYS */;

-- Copiando estrutura para tabela vrp.vrp_user_vehicles
CREATE TABLE IF NOT EXISTS `vrp_user_vehicles` (
  `user_id` int(11) NOT NULL,
  `vehicle` varchar(100) NOT NULL,
  `detido` int(1) NOT NULL DEFAULT '0',
  `time` varchar(24) NOT NULL DEFAULT '0',
  `engine` int(4) NOT NULL DEFAULT '1000',
  `body` int(4) NOT NULL DEFAULT '1000',
  `fuel` int(3) NOT NULL DEFAULT '100',
  PRIMARY KEY (`user_id`,`vehicle`),
  CONSTRAINT `fk_user_vehicles_users` FOREIGN KEY (`user_id`) REFERENCES `vrp_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela vrp.vrp_user_vehicles: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `vrp_user_vehicles` DISABLE KEYS */;
/*!40000 ALTER TABLE `vrp_user_vehicles` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
