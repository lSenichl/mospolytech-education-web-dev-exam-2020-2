-- MySQL dump 10.13  Distrib 8.0.22, for Linux (x86_64)
--
-- Host: std-mysql    Database: std_1096_exam
-- ------------------------------------------------------
-- Server version	5.7.26-0ubuntu0.16.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `alembic_version`
--

DROP TABLE IF EXISTS `alembic_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alembic_version` (
  `version_num` varchar(32) NOT NULL,
  PRIMARY KEY (`version_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alembic_version`
--

LOCK TABLES `alembic_version` WRITE;
/*!40000 ALTER TABLE `alembic_version` DISABLE KEYS */;
INSERT INTO `alembic_version` VALUES ('5c1cc7c81f11');
/*!40000 ALTER TABLE `alembic_version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exam_genres`
--

DROP TABLE IF EXISTS `exam_genres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exam_genres` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_exam_genres_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exam_genres`
--

LOCK TABLES `exam_genres` WRITE;
/*!40000 ALTER TABLE `exam_genres` DISABLE KEYS */;
INSERT INTO `exam_genres` VALUES (2,'боевик'),(3,'драма'),(1,'триллер'),(4,'фантастика');
/*!40000 ALTER TABLE `exam_genres` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exam_movies`
--

DROP TABLE IF EXISTS `exam_movies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exam_movies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `description` text NOT NULL,
  `production_year` year(4) NOT NULL,
  `country` varchar(128) NOT NULL,
  `producer` varchar(128) NOT NULL,
  `screenwriter` varchar(128) NOT NULL,
  `actors` varchar(256) NOT NULL,
  `duration` int(11) NOT NULL,
  `rating_sum` int(11) DEFAULT NULL,
  `rating_num` int(11) DEFAULT NULL,
  `poster_id` varchar(36) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_exam_movies_poster_id_exam_posters` (`poster_id`),
  CONSTRAINT `fk_exam_movies_poster_id_exam_posters` FOREIGN KEY (`poster_id`) REFERENCES `exam_posters` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exam_movies`
--

LOCK TABLES `exam_movies` WRITE;
/*!40000 ALTER TABLE `exam_movies` DISABLE KEYS */;
INSERT INTO `exam_movies` VALUES (9,'Терминатор','**В центре сюжета — противостояние солдата и робота-терминатора, прибывших в 1984 год из постапокалиптического 2029 года. Цель терминатора: убить Сару Коннор — девушку, чей ещё нерождённый сын в возможном будущем выиграет войну человечества с машинами. Влюблённый в Сару солдат Кайл Риз пытается помешать терминатору. В фильме поднимаются проблемы путешествий во времени, судьбы, создания искусственного интеллекта, поведения людей в экстремальных ситуациях.**',1984,'США','Джеймс Кэмерон','Гэйл Энн Хёрд','Арнольд Шварценеггер, Майкл Бин, Линда Хэмилтон, Лэнс Хенриксен',107,0,0,'9c354bc5-0a72-46e3-bd92-63546fdf9c92'),(10,'Убить Билла','*Фильм режиссёра Квентина Тарантино, снятый по его же сценарию. Фильм рассказывает историю женщины по имени Беатрикс Киддо, в прошлом бывшей наёмным убийцей. Релиз первой части состоялся осенью 2003 года, второй — весной 2004 года. Главные роли в картине исполнили Ума Турман и Дэвид Керрадайн.*',2003,'США','Квентин Тарантино','Квентин Тарантино','Ума Турман, Дэвид Кэррадайн',247,5,1,'ac870216-c601-463a-9f5b-06c6bfb89b6e'),(11,'Криминальное чтиво','**Кинофильм режиссёра Квентина Тарантино. Сюжет фильма нелинеен, как и почти во всех остальных работах Тарантино. Этот приём стал чрезвычайно популярен, породив множество подражаний во второй половине 1990-х. В фильме рассказывается несколько историй, в которых показаны ограбление кафе, философские дискуссии двух гангстеров, спасение девушки от передозировки героином и боксёр, которого задели за живое. Название является отсылкой к популярным в середине XX века в США pulp-журналам. Именно в стиле таких журналов были оформлены афиши, а позднее саундтрек, видеокассеты и DVD с фильмом.**',1994,'США','Квентин Тарантино','Квентин Тарантино','Джон Траволта, Сэмюэл Л. Джексон, Брюс Уиллис, Ума Турман',154,0,0,'b5e0d0cc-8d2c-4c63-b0f8-d9ffea65f3c6'),(22,'Побег из Шоушенка','*Американский художественный фильм-драма 1994 года, снятый режиссёром Фрэнком Дарабонтом по его же сценарию, и рассказывающий историю Энди Дюфрейна, незаслуженно приговорённого к пожизненному заключению и пробывшего в заключении почти 20 лет. Основой сюжета послужила повесть Стивена Кинга «Рита Хейуорт и спасение из Шоушенка». Главные роли сыграли Тим Роббинс и Морган Фримен.*',1994,'США','Фрэнк Дарабонт','Фрэнк Дарабонт','Тим Роббинс, Морган Фриман, Боб Гантон, Клэнси Браун, Уильям Сэдлер',142,0,0,'491606bb-be50-477c-ac9f-b9e19477322e');
/*!40000 ALTER TABLE `exam_movies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exam_mtm_genre_movie`
--

DROP TABLE IF EXISTS `exam_mtm_genre_movie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exam_mtm_genre_movie` (
  `movie_id` int(11) NOT NULL,
  `genre_id` int(11) NOT NULL,
  PRIMARY KEY (`movie_id`,`genre_id`),
  KEY `fk_exam_mtm_genre_movie_genre_id_exam_genres` (`genre_id`),
  CONSTRAINT `fk_exam_mtm_genre_movie_genre_id_exam_genres` FOREIGN KEY (`genre_id`) REFERENCES `exam_genres` (`id`),
  CONSTRAINT `fk_exam_mtm_genre_movie_movie_id_exam_movies` FOREIGN KEY (`movie_id`) REFERENCES `exam_movies` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exam_mtm_genre_movie`
--

LOCK TABLES `exam_mtm_genre_movie` WRITE;
/*!40000 ALTER TABLE `exam_mtm_genre_movie` DISABLE KEYS */;
INSERT INTO `exam_mtm_genre_movie` VALUES (9,1),(22,1),(9,2),(10,2),(11,2),(10,3),(11,3),(22,3),(9,4);
/*!40000 ALTER TABLE `exam_mtm_genre_movie` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exam_posters`
--

DROP TABLE IF EXISTS `exam_posters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exam_posters` (
  `id` varchar(36) NOT NULL,
  `file_name` varchar(128) NOT NULL,
  `mime_type` varchar(128) NOT NULL,
  `md5_hash` varchar(128) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_exam_posters_md5_hash` (`md5_hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exam_posters`
--

LOCK TABLES `exam_posters` WRITE;
/*!40000 ALTER TABLE `exam_posters` DISABLE KEYS */;
INSERT INTO `exam_posters` VALUES ('491606bb-be50-477c-ac9f-b9e19477322e','Movie_poster_the_shawshank_redemption.jpg','image/jpeg','7317426804471d5378ff74bec2cd25e3'),('9c354bc5-0a72-46e3-bd92-63546fdf9c92','Terminator_poster.jpg','image/jpeg','8c93a7e72bc1c245c62e6bba2efaaa77'),('ac870216-c601-463a-9f5b-06c6bfb89b6e','Kill_bill_vol_one_ver.jpg','image/jpeg','b93bcfdc639b10a3962680d27bcb210a'),('b5e0d0cc-8d2c-4c63-b0f8-d9ffea65f3c6','Pulp_Fiction.jpg','image/jpeg','684bb9269183ef3660e25d4c815f9a24');
/*!40000 ALTER TABLE `exam_posters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exam_reviews`
--

DROP TABLE IF EXISTS `exam_reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exam_reviews` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `movie_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `rating` int(11) NOT NULL,
  `text` text NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `is_moderated` varchar(128) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_exam_reviews_movie_id_exam_movies` (`movie_id`),
  KEY `fk_exam_reviews_user_id_exam_users` (`user_id`),
  KEY `fk_exam_reviews_is_moderated_exam_statuses` (`is_moderated`),
  CONSTRAINT `fk_exam_reviews_is_moderated_exam_statuses` FOREIGN KEY (`is_moderated`) REFERENCES `exam_statuses` (`name`),
  CONSTRAINT `fk_exam_reviews_movie_id_exam_movies` FOREIGN KEY (`movie_id`) REFERENCES `exam_movies` (`id`),
  CONSTRAINT `fk_exam_reviews_user_id_exam_users` FOREIGN KEY (`user_id`) REFERENCES `exam_users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exam_reviews`
--

LOCK TABLES `exam_reviews` WRITE;
/*!40000 ALTER TABLE `exam_reviews` DISABLE KEYS */;
/*!40000 ALTER TABLE `exam_reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exam_roles`
--

DROP TABLE IF EXISTS `exam_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exam_roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `desc` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exam_roles`
--

LOCK TABLES `exam_roles` WRITE;
/*!40000 ALTER TABLE `exam_roles` DISABLE KEYS */;
INSERT INTO `exam_roles` VALUES (1,'Администратор','Суперпользователь, имеет полный доступ к системе, в том числе к созданию и удалению фильмов'),(2,'Модератор','Может редактировать фильмы и производить модерацию рецензий'),(3,'Пользователь','Может оставлять рецензии');
/*!40000 ALTER TABLE `exam_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exam_statuses`
--

DROP TABLE IF EXISTS `exam_statuses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exam_statuses` (
  `name` varchar(128) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exam_statuses`
--

LOCK TABLES `exam_statuses` WRITE;
/*!40000 ALTER TABLE `exam_statuses` DISABLE KEYS */;
INSERT INTO `exam_statuses` VALUES ('На рассмотрении'),('Одобрено'),('Отклонено');
/*!40000 ALTER TABLE `exam_statuses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exam_users`
--

DROP TABLE IF EXISTS `exam_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exam_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `login` varchar(128) NOT NULL,
  `password_hash` varchar(128) NOT NULL,
  `last_name` varchar(128) NOT NULL,
  `first_name` varchar(128) NOT NULL,
  `middle_name` varchar(128) DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_exam_users_login` (`login`),
  KEY `fk_exam_users_role_id_exam_roles` (`role_id`),
  CONSTRAINT `fk_exam_users_role_id_exam_roles` FOREIGN KEY (`role_id`) REFERENCES `exam_roles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exam_users`
--

LOCK TABLES `exam_users` WRITE;
/*!40000 ALTER TABLE `exam_users` DISABLE KEYS */;
INSERT INTO `exam_users` VALUES (1,'admin','pbkdf2:sha256:150000$MlDmYgri$57da6c0c315b1854ce913a8c962970b8d9ab7353c54b552f6fec596289526d3b','admin','admin','admin',1),(2,'moderator','pbkdf2:sha256:150000$MlDmYgri$57da6c0c315b1854ce913a8c962970b8d9ab7353c54b552f6fec596289526d3b','moderator','moderator','moderator',2),(3,'user','pbkdf2:sha256:150000$MlDmYgri$57da6c0c315b1854ce913a8c962970b8d9ab7353c54b552f6fec596289526d3b','user','user','user',3);
/*!40000 ALTER TABLE `exam_users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-01-26  0:01:32
