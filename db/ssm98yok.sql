-- MySQL dump 10.13  Distrib 5.7.31, for Linux (x86_64)
--
-- Host: localhost    Database: ssm98yok
-- ------------------------------------------------------
-- Server version	5.7.31

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `address` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `userid` bigint(20) NOT NULL COMMENT '用户id',
  `address` varchar(200) NOT NULL COMMENT '地址',
  `name` varchar(200) NOT NULL COMMENT '收货人',
  `phone` varchar(200) NOT NULL COMMENT '电话',
  `isdefault` varchar(200) NOT NULL COMMENT '是否默认地址[是/否]',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='地址';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address`
--

LOCK TABLES `address` WRITE;
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
INSERT INTO `address` VALUES (1,'2021-01-25 02:23:59',1,'宇宙银河系金星1号','金某','13823888881','是'),(2,'2021-01-25 02:23:59',2,'宇宙银河系木星1号','木某','13823888882','是'),(3,'2021-01-25 02:23:59',3,'宇宙银河系水星1号','水某','13823888883','是'),(4,'2021-01-25 02:23:59',4,'宇宙银河系火星1号','火某','13823888884','是'),(5,'2021-01-25 02:23:59',5,'宇宙银河系土星1号','土某','13823888885','是'),(6,'2021-01-25 02:23:59',6,'宇宙银河系月球1号','月某','13823888886','是');
/*!40000 ALTER TABLE `address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `caipinfenlei`
--

DROP TABLE IF EXISTS `caipinfenlei`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `caipinfenlei` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `caipinfenlei` varchar(200) NOT NULL COMMENT '菜品分类',
  PRIMARY KEY (`id`),
  UNIQUE KEY `caipinfenlei` (`caipinfenlei`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8 COMMENT='菜品分类';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `caipinfenlei`
--

LOCK TABLES `caipinfenlei` WRITE;
/*!40000 ALTER TABLE `caipinfenlei` DISABLE KEYS */;
INSERT INTO `caipinfenlei` VALUES (31,'2021-01-25 02:23:59','菜品分类1'),(32,'2021-01-25 02:23:59','菜品分类2'),(33,'2021-01-25 02:23:59','菜品分类3'),(34,'2021-01-25 02:23:59','菜品分类4'),(35,'2021-01-25 02:23:59','菜品分类5'),(36,'2021-01-25 02:23:59','菜品分类6');
/*!40000 ALTER TABLE `caipinfenlei` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `caipinxinxi`
--

DROP TABLE IF EXISTS `caipinxinxi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `caipinxinxi` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `caipinmingcheng` varchar(200) NOT NULL COMMENT '菜品名称',
  `caipinfenlei` varchar(200) NOT NULL COMMENT '菜品分类',
  `tupian` varchar(200) DEFAULT NULL COMMENT '图片',
  `cailiao` varchar(200) DEFAULT NULL COMMENT '材料',
  `fenliang` varchar(200) DEFAULT NULL COMMENT '份量',
  `caipinjieshao` longtext COMMENT '菜品介绍',
  `cantingmingcheng` varchar(200) DEFAULT NULL COMMENT '餐厅名称',
  `lianxidianhua` varchar(200) DEFAULT NULL COMMENT '联系电话',
  `clicktime` datetime DEFAULT NULL COMMENT '最近点击时间',
  `clicknum` int(11) DEFAULT '0' COMMENT '点击次数',
  `price` float NOT NULL COMMENT '价格',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8 COMMENT='菜品信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `caipinxinxi`
--

LOCK TABLES `caipinxinxi` WRITE;
/*!40000 ALTER TABLE `caipinxinxi` DISABLE KEYS */;
INSERT INTO `caipinxinxi` VALUES (41,'2021-01-25 02:23:59','菜品名称1','菜品分类1','http://localhost:8080/ssm98yok/upload/caipinxinxi_tupian1.jpg','材料1','份量1','菜品介绍1','餐厅名称1','联系电话1','2021-01-25 10:23:59',1,99.9),(42,'2021-01-25 02:23:59','菜品名称2','菜品分类2','http://localhost:8080/ssm98yok/upload/caipinxinxi_tupian2.jpg','材料2','份量2','菜品介绍2','餐厅名称2','联系电话2','2021-01-25 10:23:59',2,99.9),(43,'2021-01-25 02:23:59','菜品名称3','菜品分类3','http://localhost:8080/ssm98yok/upload/caipinxinxi_tupian3.jpg','材料3','份量3','菜品介绍3','餐厅名称3','联系电话3','2021-01-25 10:23:59',3,99.9),(44,'2021-01-25 02:23:59','菜品名称4','菜品分类4','http://localhost:8080/ssm98yok/upload/caipinxinxi_tupian4.jpg','材料4','份量4','菜品介绍4','餐厅名称4','联系电话4','2021-01-25 10:23:59',4,99.9),(45,'2021-01-25 02:23:59','菜品名称5','菜品分类5','http://localhost:8080/ssm98yok/upload/caipinxinxi_tupian5.jpg','材料5','份量5','菜品介绍5','餐厅名称5','联系电话5','2021-01-25 10:23:59',5,99.9),(46,'2021-01-25 02:23:59','菜品名称6','菜品分类6','http://localhost:8080/ssm98yok/upload/caipinxinxi_tupian6.jpg','材料6','份量6','菜品介绍6','餐厅名称6','联系电话6','2021-01-25 10:23:59',6,99.9);
/*!40000 ALTER TABLE `caipinxinxi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cantingxinxi`
--

DROP TABLE IF EXISTS `cantingxinxi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cantingxinxi` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `cantingmingcheng` varchar(200) NOT NULL COMMENT '餐厅名称',
  `cantingleixing` varchar(200) NOT NULL COMMENT '餐厅类型',
  `cantingtupian` varchar(200) DEFAULT NULL COMMENT '餐厅图片',
  `peisongshijian` varchar(200) DEFAULT NULL COMMENT '配送时间',
  `peisongfuwu` varchar(200) DEFAULT NULL COMMENT '配送服务',
  `lianxidianhua` varchar(200) DEFAULT NULL COMMENT '联系电话',
  `cantingdizhi` varchar(200) DEFAULT NULL COMMENT '餐厅地址',
  `cantingjieshao` longtext COMMENT '餐厅介绍',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8 COMMENT='餐厅信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cantingxinxi`
--

LOCK TABLES `cantingxinxi` WRITE;
/*!40000 ALTER TABLE `cantingxinxi` DISABLE KEYS */;
INSERT INTO `cantingxinxi` VALUES (21,'2021-01-25 02:23:59','餐厅名称1','餐厅类型1','http://localhost:8080/ssm98yok/upload/cantingxinxi_cantingtupian1.jpg','配送时间1','配送服务1','联系电话1','餐厅地址1','餐厅介绍1'),(22,'2021-01-25 02:23:59','餐厅名称2','餐厅类型2','http://localhost:8080/ssm98yok/upload/cantingxinxi_cantingtupian2.jpg','配送时间2','配送服务2','联系电话2','餐厅地址2','餐厅介绍2'),(23,'2021-01-25 02:23:59','餐厅名称3','餐厅类型3','http://localhost:8080/ssm98yok/upload/cantingxinxi_cantingtupian3.jpg','配送时间3','配送服务3','联系电话3','餐厅地址3','餐厅介绍3'),(24,'2021-01-25 02:23:59','餐厅名称4','餐厅类型4','http://localhost:8080/ssm98yok/upload/cantingxinxi_cantingtupian4.jpg','配送时间4','配送服务4','联系电话4','餐厅地址4','餐厅介绍4'),(25,'2021-01-25 02:23:59','餐厅名称5','餐厅类型5','http://localhost:8080/ssm98yok/upload/cantingxinxi_cantingtupian5.jpg','配送时间5','配送服务5','联系电话5','餐厅地址5','餐厅介绍5'),(26,'2021-01-25 02:23:59','餐厅名称6','餐厅类型6','http://localhost:8080/ssm98yok/upload/cantingxinxi_cantingtupian6.jpg','配送时间6','配送服务6','联系电话6','餐厅地址6','餐厅介绍6');
/*!40000 ALTER TABLE `cantingxinxi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cart` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `tablename` varchar(200) DEFAULT 'caipinxinxi' COMMENT '商品表名',
  `userid` bigint(20) NOT NULL COMMENT '用户id',
  `goodid` bigint(20) NOT NULL COMMENT '商品id',
  `goodname` varchar(200) DEFAULT NULL COMMENT '商品名称',
  `picture` varchar(200) DEFAULT NULL COMMENT '图片',
  `buynumber` int(11) NOT NULL COMMENT '购买数量',
  `price` float DEFAULT NULL COMMENT '单价',
  `discountprice` float DEFAULT NULL COMMENT '会员价',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='购物车表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chat`
--

DROP TABLE IF EXISTS `chat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `chat` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `userid` bigint(20) NOT NULL COMMENT '用户id',
  `adminid` bigint(20) DEFAULT NULL COMMENT '管理员id',
  `ask` longtext COMMENT '提问',
  `reply` longtext COMMENT '回复',
  `isreply` int(11) DEFAULT NULL COMMENT '是否回复',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8 COMMENT='客服聊天表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chat`
--

LOCK TABLES `chat` WRITE;
/*!40000 ALTER TABLE `chat` DISABLE KEYS */;
INSERT INTO `chat` VALUES (61,'2021-01-25 02:23:59',1,1,'提问1','回复1',1),(62,'2021-01-25 02:23:59',2,2,'提问2','回复2',2),(63,'2021-01-25 02:23:59',3,3,'提问3','回复3',3),(64,'2021-01-25 02:23:59',4,4,'提问4','回复4',4),(65,'2021-01-25 02:23:59',5,5,'提问5','回复5',5),(66,'2021-01-25 02:23:59',6,6,'提问6','回复6',6);
/*!40000 ALTER TABLE `chat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `config`
--

DROP TABLE IF EXISTS `config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `config` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(100) NOT NULL COMMENT '配置参数名称',
  `value` varchar(100) DEFAULT NULL COMMENT '配置参数值',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='配置文件';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `config`
--

LOCK TABLES `config` WRITE;
/*!40000 ALTER TABLE `config` DISABLE KEYS */;
INSERT INTO `config` VALUES (1,'picture1','http://localhost:8080/ssm98yok/upload/picture1.jpg'),(2,'picture2','http://localhost:8080/ssm98yok/upload/picture2.jpg'),(3,'picture3','http://localhost:8080/ssm98yok/upload/picture3.jpg'),(6,'homepage',NULL);
/*!40000 ALTER TABLE `config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dingdanpingjia`
--

DROP TABLE IF EXISTS `dingdanpingjia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dingdanpingjia` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `dingdanbianhao` varchar(200) NOT NULL COMMENT '订单编号',
  `caipinmingcheng` varchar(200) NOT NULL COMMENT '菜品名称',
  `caipinfenlei` varchar(200) DEFAULT NULL COMMENT '菜品分类',
  `pingfen` varchar(200) DEFAULT NULL COMMENT '评分',
  `pingjianeirong` longtext COMMENT '评价内容',
  `pingjiariqi` date DEFAULT NULL COMMENT '评价日期',
  `yonghuming` varchar(200) DEFAULT NULL COMMENT '用户名',
  `shouji` varchar(200) DEFAULT NULL COMMENT '手机',
  `sfsh` varchar(200) DEFAULT '否' COMMENT '是否审核',
  `shhf` longtext COMMENT '审核回复',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8 COMMENT='订单评价';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dingdanpingjia`
--

LOCK TABLES `dingdanpingjia` WRITE;
/*!40000 ALTER TABLE `dingdanpingjia` DISABLE KEYS */;
INSERT INTO `dingdanpingjia` VALUES (51,'2021-01-25 02:23:59','订单编号1','菜品名称1','菜品分类1','1','评价内容1','2021-01-25','用户名1','手机1','是',''),(52,'2021-01-25 02:23:59','订单编号2','菜品名称2','菜品分类2','1','评价内容2','2021-01-25','用户名2','手机2','是',''),(53,'2021-01-25 02:23:59','订单编号3','菜品名称3','菜品分类3','1','评价内容3','2021-01-25','用户名3','手机3','是',''),(54,'2021-01-25 02:23:59','订单编号4','菜品名称4','菜品分类4','1','评价内容4','2021-01-25','用户名4','手机4','是',''),(55,'2021-01-25 02:23:59','订单编号5','菜品名称5','菜品分类5','1','评价内容5','2021-01-25','用户名5','手机5','是',''),(56,'2021-01-25 02:23:59','订单编号6','菜品名称6','菜品分类6','1','评价内容6','2021-01-25','用户名6','手机6','是','');
/*!40000 ALTER TABLE `dingdanpingjia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `discusscaipinxinxi`
--

DROP TABLE IF EXISTS `discusscaipinxinxi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `discusscaipinxinxi` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `refid` bigint(20) NOT NULL COMMENT '关联表id',
  `userid` bigint(20) NOT NULL COMMENT '用户id',
  `content` longtext NOT NULL COMMENT '评论内容',
  `reply` longtext COMMENT '回复内容',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=137 DEFAULT CHARSET=utf8 COMMENT='菜品信息评论表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `discusscaipinxinxi`
--

LOCK TABLES `discusscaipinxinxi` WRITE;
/*!40000 ALTER TABLE `discusscaipinxinxi` DISABLE KEYS */;
INSERT INTO `discusscaipinxinxi` VALUES (131,'2021-01-25 02:23:59',1,1,'评论内容1','回复内容1'),(132,'2021-01-25 02:23:59',2,2,'评论内容2','回复内容2'),(133,'2021-01-25 02:23:59',3,3,'评论内容3','回复内容3'),(134,'2021-01-25 02:23:59',4,4,'评论内容4','回复内容4'),(135,'2021-01-25 02:23:59',5,5,'评论内容5','回复内容5'),(136,'2021-01-25 02:23:59',6,6,'评论内容6','回复内容6');
/*!40000 ALTER TABLE `discusscaipinxinxi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `discusscantingxinxi`
--

DROP TABLE IF EXISTS `discusscantingxinxi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `discusscantingxinxi` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `refid` bigint(20) NOT NULL COMMENT '关联表id',
  `userid` bigint(20) NOT NULL COMMENT '用户id',
  `content` longtext NOT NULL COMMENT '评论内容',
  `reply` longtext COMMENT '回复内容',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=127 DEFAULT CHARSET=utf8 COMMENT='餐厅信息评论表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `discusscantingxinxi`
--

LOCK TABLES `discusscantingxinxi` WRITE;
/*!40000 ALTER TABLE `discusscantingxinxi` DISABLE KEYS */;
INSERT INTO `discusscantingxinxi` VALUES (121,'2021-01-25 02:23:59',1,1,'评论内容1','回复内容1'),(122,'2021-01-25 02:23:59',2,2,'评论内容2','回复内容2'),(123,'2021-01-25 02:23:59',3,3,'评论内容3','回复内容3'),(124,'2021-01-25 02:23:59',4,4,'评论内容4','回复内容4'),(125,'2021-01-25 02:23:59',5,5,'评论内容5','回复内容5'),(126,'2021-01-25 02:23:59',6,6,'评论内容6','回复内容6');
/*!40000 ALTER TABLE `discusscantingxinxi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `news`
--

DROP TABLE IF EXISTS `news`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `news` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `title` varchar(200) NOT NULL COMMENT '标题',
  `introduction` longtext COMMENT '简介',
  `picture` varchar(200) NOT NULL COMMENT '图片',
  `content` longtext NOT NULL COMMENT '内容',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=117 DEFAULT CHARSET=utf8 COMMENT='公告信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `news`
--

LOCK TABLES `news` WRITE;
/*!40000 ALTER TABLE `news` DISABLE KEYS */;
INSERT INTO `news` VALUES (111,'2021-01-25 02:23:59','标题1','简介1','http://localhost:8080/ssm98yok/upload/news_picture1.jpg','内容1'),(112,'2021-01-25 02:23:59','标题2','简介2','http://localhost:8080/ssm98yok/upload/news_picture2.jpg','内容2'),(113,'2021-01-25 02:23:59','标题3','简介3','http://localhost:8080/ssm98yok/upload/news_picture3.jpg','内容3'),(114,'2021-01-25 02:23:59','标题4','简介4','http://localhost:8080/ssm98yok/upload/news_picture4.jpg','内容4'),(115,'2021-01-25 02:23:59','标题5','简介5','http://localhost:8080/ssm98yok/upload/news_picture5.jpg','内容5'),(116,'2021-01-25 02:23:59','标题6','简介6','http://localhost:8080/ssm98yok/upload/news_picture6.jpg','内容6');
/*!40000 ALTER TABLE `news` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `orderid` varchar(200) NOT NULL COMMENT '订单编号',
  `tablename` varchar(200) DEFAULT 'caipinxinxi' COMMENT '商品表名',
  `userid` bigint(20) NOT NULL COMMENT '用户id',
  `goodid` bigint(20) NOT NULL COMMENT '商品id',
  `goodname` varchar(200) DEFAULT NULL COMMENT '商品名称',
  `picture` varchar(200) DEFAULT NULL COMMENT '商品图片',
  `buynumber` int(11) NOT NULL COMMENT '购买数量',
  `price` float NOT NULL DEFAULT '0' COMMENT '价格/积分',
  `discountprice` float DEFAULT '0' COMMENT '折扣价格',
  `total` float NOT NULL DEFAULT '0' COMMENT '总价格/总积分',
  `discounttotal` float DEFAULT '0' COMMENT '折扣总价格',
  `type` int(11) DEFAULT '1' COMMENT '支付类型',
  `status` varchar(200) DEFAULT NULL COMMENT '状态',
  `address` varchar(200) DEFAULT NULL COMMENT '地址',
  PRIMARY KEY (`id`),
  UNIQUE KEY `orderid` (`orderid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='订单';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `storeup`
--

DROP TABLE IF EXISTS `storeup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `storeup` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `userid` bigint(20) NOT NULL COMMENT '用户id',
  `refid` bigint(20) DEFAULT NULL COMMENT '收藏id',
  `tablename` varchar(200) DEFAULT NULL COMMENT '表名',
  `name` varchar(200) NOT NULL COMMENT '收藏名称',
  `picture` varchar(200) NOT NULL COMMENT '收藏图片',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='收藏表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `storeup`
--

LOCK TABLES `storeup` WRITE;
/*!40000 ALTER TABLE `storeup` DISABLE KEYS */;
/*!40000 ALTER TABLE `storeup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `token`
--

DROP TABLE IF EXISTS `token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `token` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `userid` bigint(20) NOT NULL COMMENT '用户id',
  `username` varchar(100) NOT NULL COMMENT '用户名',
  `tablename` varchar(100) DEFAULT NULL COMMENT '表名',
  `role` varchar(100) DEFAULT NULL COMMENT '角色',
  `token` varchar(200) NOT NULL COMMENT '密码',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `expiratedtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '过期时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='token表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `token`
--

LOCK TABLES `token` WRITE;
/*!40000 ALTER TABLE `token` DISABLE KEYS */;
/*!40000 ALTER TABLE `token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `username` varchar(100) NOT NULL COMMENT '用户名',
  `password` varchar(100) NOT NULL COMMENT '密码',
  `role` varchar(100) DEFAULT '管理员' COMMENT '角色',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='用户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'abo','abo','管理员','2021-01-25 02:23:59');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `yonghu`
--

DROP TABLE IF EXISTS `yonghu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `yonghu` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `yonghuming` varchar(200) NOT NULL COMMENT '用户名',
  `mima` varchar(200) NOT NULL COMMENT '密码',
  `xingming` varchar(200) NOT NULL COMMENT '姓名',
  `xingbie` varchar(200) DEFAULT NULL COMMENT '性别',
  `touxiang` varchar(200) DEFAULT NULL COMMENT '头像',
  `shouji` varchar(200) DEFAULT NULL COMMENT '手机',
  `money` float DEFAULT '0' COMMENT '余额',
  PRIMARY KEY (`id`),
  UNIQUE KEY `yonghuming` (`yonghuming`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COMMENT='用户';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `yonghu`
--

LOCK TABLES `yonghu` WRITE;
/*!40000 ALTER TABLE `yonghu` DISABLE KEYS */;
INSERT INTO `yonghu` VALUES (11,'2021-01-25 02:23:59','用户1','123456','姓名1','男','http://localhost:8080/ssm98yok/upload/yonghu_touxiang1.jpg','13823888881',100),(12,'2021-01-25 02:23:59','用户2','123456','姓名2','男','http://localhost:8080/ssm98yok/upload/yonghu_touxiang2.jpg','13823888882',100),(13,'2021-01-25 02:23:59','用户3','123456','姓名3','男','http://localhost:8080/ssm98yok/upload/yonghu_touxiang3.jpg','13823888883',100),(14,'2021-01-25 02:23:59','用户4','123456','姓名4','男','http://localhost:8080/ssm98yok/upload/yonghu_touxiang4.jpg','13823888884',100),(15,'2021-01-25 02:23:59','用户5','123456','姓名5','男','http://localhost:8080/ssm98yok/upload/yonghu_touxiang5.jpg','13823888885',100),(16,'2021-01-25 02:23:59','用户6','123456','姓名6','男','http://localhost:8080/ssm98yok/upload/yonghu_touxiang6.jpg','13823888886',100);
/*!40000 ALTER TABLE `yonghu` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-01-25 21:08:58
