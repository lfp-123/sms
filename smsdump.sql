-- MySQL dump 10.13  Distrib 5.7.33, for Linux (x86_64)
--
-- Host: localhost    Database: supermarketmanagerdb
-- ------------------------------------------------------
-- Server version	5.7.33

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
-- Table structure for table `sm_dept`
--

DROP TABLE IF EXISTS `sm_dept`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_dept` (
  `dept_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '部门编号',
  `dept_name` varchar(30) DEFAULT NULL COMMENT '部门名称',
  PRIMARY KEY (`dept_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COMMENT='部门信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_dept`
--

LOCK TABLES `sm_dept` WRITE;
/*!40000 ALTER TABLE `sm_dept` DISABLE KEYS */;
INSERT INTO `sm_dept` VALUES (1,'计算机科学与技术'),(2,'通信工程'),(3,'信息管理');
/*!40000 ALTER TABLE `sm_dept` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_employees`
--

DROP TABLE IF EXISTS `sm_employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_employees` (
  `emp_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '员工编号',
  `emp_name` varchar(30) DEFAULT NULL COMMENT '员工姓名',
  `emp_native_place` varchar(200) DEFAULT NULL COMMENT '员工籍贯',
  `emp_addr` varchar(200) DEFAULT NULL COMMENT '员工地址',
  `emp_phone` varchar(20) DEFAULT NULL COMMENT '员工电话',
  `emp_identity` varchar(20) DEFAULT NULL COMMENT '员工身份证号',
  `emp_sex` int(4) DEFAULT NULL COMMENT '员工性别：0女1男2未知',
  `dept_id` int(11) DEFAULT NULL COMMENT '部门编号',
  `emp_describe` varchar(200) DEFAULT NULL COMMENT '员工描述',
  PRIMARY KEY (`emp_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COMMENT='员工信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_employees`
--

LOCK TABLES `sm_employees` WRITE;
/*!40000 ALTER TABLE `sm_employees` DISABLE KEYS */;
INSERT INTO `sm_employees` VALUES (4,'cs3','cs2','cs2','18046700981','350122199802236555',1,2,'222'),(8,'测试','测试','测试','18046700981','350122199802236555',1,2,'测试'),(9,'测试2','测试','测试','18046700981','350122199802236555',1,1,'测试');
/*!40000 ALTER TABLE `sm_employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_employees_check`
--

DROP TABLE IF EXISTS `sm_employees_check`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_employees_check` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `out_work_days` int(8) DEFAULT NULL COMMENT '加班天数',
  `work_days` int(8) DEFAULT NULL COMMENT '打卡天数',
  `leave_days` int(8) DEFAULT NULL COMMENT '请假天数',
  `emp_id` bigint(20) DEFAULT NULL COMMENT '员工id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COMMENT='员工考勤表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_employees_check`
--

LOCK TABLES `sm_employees_check` WRITE;
/*!40000 ALTER TABLE `sm_employees_check` DISABLE KEYS */;
INSERT INTO `sm_employees_check` VALUES (2,2,2,2,4),(3,3,42,3,8),(4,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `sm_employees_check` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_goods`
--

DROP TABLE IF EXISTS `sm_goods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `inventory_quantity` int(11) NOT NULL,
  `last_purchasing_price` float NOT NULL,
  `min_num` int(11) NOT NULL,
  `model` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `producer` varchar(200) DEFAULT NULL,
  `purchasing_price` float NOT NULL,
  `remarks` varchar(1000) DEFAULT NULL,
  `selling_price` float NOT NULL,
  `state` int(11) NOT NULL,
  `unit` varchar(10) DEFAULT NULL,
  `type_id` int(11) DEFAULT NULL,
  `number` int(11) DEFAULT NULL,
  `salenumber` int(11) DEFAULT NULL,
  `returnnumber` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_goods`
--

LOCK TABLES `sm_goods` WRITE;
/*!40000 ALTER TABLE `sm_goods` DISABLE KEYS */;
INSERT INTO `sm_goods` VALUES (1,171,8.5,1000,'红色装','陶华碧老干妈香辣脆油辣椒','贵州省贵阳南明老干妈风味食品有限公司',6.34,'好卖',8.5,2,'瓶',10,20,20,50),(2,140,2220,400,'Note8','华为荣耀Note8','华为计算机系统有限公司',1955.68,'热销',2200,2,'台',16,200,NULL,NULL),(11,2735,22,400,'500g装','野生东北黑木耳','辉南县博康土特产有限公司',23,'够黑2',38,2,'袋',11,200,NULL,NULL),(12,315,13,300,'2斤装','新疆红枣','沧州铭鑫食品有限公司',13,'好吃',25,2,'袋',10,200,NULL,NULL),(13,53,8,1000,'散装500克','麦片燕麦巧克力','福建省麦德好食品工业有限公司',8,'Goods',15,2,'袋',11,199,NULL,1),(14,17,4,1999,'300g装','冰糖金桔干','揭西县同心食品有限公司',4.95,'',13,2,'盒',11,200,NULL,NULL),(15,100650,4.5,400,'500g装','吉利人家牛肉味蛋糕','合肥吉利人家食品有限公司',4.5,'good',10,2,'袋',11,200,NULL,NULL),(16,197,2,500,'128g装','奕森奶油桃肉蜜饯果脯果干桃肉干休闲零食品','潮州市潮安区正大食品有限公司',2.99,'',10,2,'盒',11,200,NULL,NULL),(17,371,20,1000,'240g装','休闲零食坚果特产精品干果无漂白大个开心果','石家庄博群食品有限公司',20,'',33,2,'袋',11,200,NULL,NULL),(18,9,12,300,'250g装','劲仔小鱼干','湖南省华文食品有限公司',12,'',20,2,'袋',11,200,NULL,NULL),(19,12,3.2,300,'198g装','山楂条','临朐县七贤升利食品厂',3.2,'',10,0,'袋',11,200,NULL,NULL),(20,23,20,200,'500g装','大乌梅干','长春市鼎丰真食品有限责任公司',20,'',25,2,'袋',11,200,NULL,NULL),(21,400,3,100,'250g装','手工制作芝麻香酥麻通','桂林兰雨食品有限公司',3,'',8,2,'袋',11,200,NULL,NULL),(22,12,5,200,'250g装','美国青豆原味 蒜香','菲律宾',5,'',8,2,'袋',11,200,NULL,NULL),(24,47,8000,100,'X',' iPhone X','xx2',8000,'xxx2',9500,2,'台',16,200,NULL,NULL),(25,0,103,12,'X','21','32',103,'21',120,2,'盒',3,200,NULL,NULL),(26,-1,3000,100,'ILCE-A6000L','Sony/索尼 ILCE-A6000L WIFI微单数码相机高清单电','xxx',3000,'xxx',3650,2,'台',15,200,NULL,NULL),(27,-1,800,400,'IXUS 285 HS','Canon/佳能 IXUS 285 HS 数码相机 2020万像素高清拍摄','xx',800,'xxx',1299,2,'台',15,200,NULL,NULL),(28,0,60,300,'Q8','Golden Field/金河田 Q8电脑音响台式多媒体家用音箱低音炮重低音','xxxx',60,'',129,2,'台',17,200,NULL,NULL),(29,0,1000,50,'190WDPT','Haier/海尔冰箱BCD-190WDPT双门电冰箱大两门冷藏冷冻','cc',1000,'',1699,2,'台',14,200,NULL,NULL),(30,1000,721,320,'4A ','Xiaomi/小米 小米电视4A 32英寸 智能液晶平板电视机','cc',721,'',1199,2,'台',12,200,NULL,NULL),(31,0,400,40,'XQB55-36SP','TCL XQB55-36SP 5.5公斤全自动波轮迷你小型洗衣机家用单脱抗菌','cc',400,'',729,2,'台',13,200,NULL,NULL),(32,8,5,1000,'80g*2','台湾进口膨化零食品张君雅小妹妹日式串烧丸子80g*2','cc',4.25,'',15,2,'袋',9,200,NULL,NULL),(33,140,180,10,'A字裙','卓图女装立领针织格子印花拼接高腰A字裙2017秋冬新款碎花连衣裙','cc',172,'',298,2,'件',6,200,NULL,NULL),(34,0,189,10,'三件套秋','西服套装男三件套秋季新款商务修身职业正装男士西装新郎结婚礼服','cc',189,'',299,2,'件',7,200,NULL,NULL),(35,-1,60,10,'AFS JEEP','加绒加厚正品AFS JEEP/战地吉普男大码长裤植绒保暖男士牛仔裤子','c',60,'',89,2,'条',8,100,100,NULL),(44,0,0,31224,'32124','32124','31224',31224,'32124',32124,2,'个',4,200,NULL,NULL),(45,0,150,100,'测试','测试','上好',100,'',0,2,'个',12,200,NULL,NULL),(46,0,1641,1001,'测试2222','测试222','1111',1201,'asd1',0,2,'台1',10,200,NULL,NULL),(47,0,120,100,'00001','测试11','上海',100,'aaa',0,2,'个',10,200,NULL,NULL),(48,0,120,100,'0002','ces1111','上海',100,'',0,2,'个',11,200,NULL,NULL),(49,0,299,199,'个','再来一个','199',199,'',0,0,'个',7,200,NULL,NULL),(50,0,120,199,'个','再来','s',100,'',0,2,'个',7,190,10,NULL),(51,0,120,100,'001','来一个','1',100,'',0,2,'个',12,100,NULL,NULL),(52,0,300,500,'测','测','测试',200,'测试',0,0,'测试单位',8,200,0,0);
/*!40000 ALTER TABLE `sm_goods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_goodstype`
--

DROP TABLE IF EXISTS `sm_goodstype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_goodstype` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `icon` varchar(100) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `p_id` int(11) DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_goodstype`
--

LOCK TABLES `sm_goodstype` WRITE;
/*!40000 ALTER TABLE `sm_goodstype` DISABLE KEYS */;
INSERT INTO `sm_goodstype` VALUES (1,'icon-folderOpen','所有类别',-1,1),(2,'icon-folder','服饰',1,1),(3,'icon-folder','食品',1,1),(4,'icon-folder','家电',1,1),(5,'icon-folder','数码',1,1),(6,'icon-folder','连衣裙',2,1),(7,'icon-folder','男士西装',2,1),(8,'icon-folder','测试1',2,0),(9,'icon-folder','测试',3,1),(10,'icon-folder','地方特产',3,0),(11,'icon-folder','休闲食品',3,0),(12,'icon-folder','电视机',4,0),(13,'icon-folder','洗衣机',4,0),(14,'icon-folder','冰箱',4,0),(15,'icon-folder','相机',5,0),(16,'icon-folder','手机',5,0),(17,'icon-folder','音箱',5,0);
/*!40000 ALTER TABLE `sm_goodstype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_menu`
--

DROP TABLE IF EXISTS `sm_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `icon` varchar(500) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `p_id` int(11) DEFAULT NULL,
  `menuId` int(11) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `d_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_menu`
--

LOCK TABLES `sm_menu` WRITE;
/*!40000 ALTER TABLE `sm_menu` DISABLE KEYS */;
INSERT INTO `sm_menu` VALUES (1,'&#xe640;','人力资源部',10,0,NULL,1),(2,'&#xe62c;','财务部',20,0,NULL,1),(3,'&#xe62d;','商品采购部',30,0,'',1),(4,'&#xe60b;','商品销售部',40,0,NULL,1),(5,'&#xe625;','基础管理',50,0,'',1),(6,'&#xe62c;','商品删除',4040,1,'/goods/goodDel.jsp',40),(8,'&#xe669;','退货管理',4040,1,'/sale/return.jsp',40),(9,'&#xe626;','销售统计',2020,1,'/sale/saleList.jsp',20),(10,'&#xe602;','订单管理',3030,1,'/goods/goodOrder.jsp',30),(11,'&#xe61c;','添加商品',4040,1,'/goods/goodAdd.jsp',40),(12,'&#xe61c;','库存查询',4040,1,'/goods/goodStock.jsp',40),(13,'&#xe671;','考勤信息',1010,1,'/basic/attendance.jsp',10),(14,'&#xe607;','供应商管理',3030,1,'/basic/supplier.jsp',30),(15,'&#xe671;','用户管理',5050,1,'/basic/userInfo.jsp',50),(16,'&#xe640;','角色管理',5050,1,'/basic/roleInfo.jsp',50),(17,'&#xe671;','员工信息',1010,1,'/basic/employeeInformation.jsp',10);
/*!40000 ALTER TABLE `sm_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_order`
--

DROP TABLE IF EXISTS `sm_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(255) DEFAULT NULL,
  `supplier_id` int(11) NOT NULL,
  `state` int(11) DEFAULT NULL,
  `createdate` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `paydate` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `remark` varchar(255) DEFAULT NULL,
  `paymoney` float DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_order`
--

LOCK TABLES `sm_order` WRITE;
/*!40000 ALTER TABLE `sm_order` DISABLE KEYS */;
INSERT INTO `sm_order` VALUES (1,'JH201807040001',1,1,'2018-07-04 19:32:36','2018-07-04 19:32:36','xxxx',200),(2,'JH201807040002',2,1,'2018-07-04 19:32:40','2018-07-04 19:32:40','',100),(3,'JH201807040003',2,1,'2018-07-04 19:32:55','2018-07-04 00:00:00','',100),(4,'JH202104150001',2,1,'2021-04-15 02:32:33','2021-03-04 00:00:00','rest、',200),(5,'JH202104150002',2,1,'2021-04-15 03:01:17','2021-03-30 00:00:00','11',11),(6,'JH202104150003',-1,1,'2021-04-15 03:01:50','2021-03-30 00:00:00','',111),(7,'JH202104150004',2,1,'2021-04-15 03:02:08','2021-04-02 00:00:00','',111),(8,'JH202104150005',2,1,'2021-04-15 03:16:45','2021-04-06 00:00:00','测试',11.1),(9,'JH202104150006',5,1,'2021-04-15 03:17:03','2021-03-30 00:00:00','11',11),(10,'JH202104150007',17,1,'2021-04-15 03:18:44','2021-04-06 00:00:00','测试',343),(11,'JH202104150008',6,0,'2021-04-15 03:18:59','2021-04-30 00:00:00','测试',1111),(12,'JH202104150009',3,1,'2021-04-15 04:54:53','2021-03-30 00:00:00','',2548),(13,'JH202104150010',12,0,'2021-04-15 04:55:53','2021-04-14 00:00:00','',223),(14,'JH202104150011',12,1,'2021-04-15 04:56:37','2021-04-13 00:00:00','不错',55),(15,'JH202104150012',6,0,'2021-04-15 04:58:46','2021-04-16 00:00:00','好',66),(16,'JH202104150013',12,0,'2021-04-15 04:59:16','2021-04-13 00:00:00','机型',65),(17,'JH202104150014',19,0,'2021-04-15 05:02:07','2021-04-15 00:00:00','下周支付',668);
/*!40000 ALTER TABLE `sm_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_role`
--

DROP TABLE IF EXISTS `sm_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `roleName` varchar(50) DEFAULT NULL,
  `roleRemark` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_role`
--

LOCK TABLES `sm_role` WRITE;
/*!40000 ALTER TABLE `sm_role` DISABLE KEYS */;
INSERT INTO `sm_role` VALUES (1,'admin','全部权限'),(2,'hr','人力资源管理权限'),(3,'financial','财务管理权限'),(4,'buyer','采购权限'),(5,'salesman','销售权限'),(10,'staff','普通员工');
/*!40000 ALTER TABLE `sm_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_rolemenu`
--

DROP TABLE IF EXISTS `sm_rolemenu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_rolemenu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `roleId` int(11) DEFAULT NULL,
  `menuId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_rolemenu`
--

LOCK TABLES `sm_rolemenu` WRITE;
/*!40000 ALTER TABLE `sm_rolemenu` DISABLE KEYS */;
INSERT INTO `sm_rolemenu` VALUES (1,1,1),(2,1,2),(3,1,3),(4,1,4),(5,1,5),(6,1,6),(7,1,7),(8,1,8),(9,1,9),(10,1,10),(11,1,11),(12,1,12),(13,1,13),(14,1,14),(15,1,15),(16,1,16),(31,3,1),(32,3,2),(33,3,3),(34,3,4),(35,3,5),(36,3,6),(37,3,7),(38,3,8),(39,3,9),(40,3,10),(41,3,11),(44,6,1),(45,6,2),(46,6,3),(47,2,1),(48,2,4),(49,2,5),(50,2,6),(51,2,7),(52,2,8),(53,2,9),(54,2,10),(55,2,11),(56,2,12),(57,2,13),(58,2,14),(59,8,1),(60,8,3);
/*!40000 ALTER TABLE `sm_rolemenu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_roleuser`
--

DROP TABLE IF EXISTS `sm_roleuser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_roleuser` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `roleId` int(11) DEFAULT NULL,
  `userId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_roleuser`
--

LOCK TABLES `sm_roleuser` WRITE;
/*!40000 ALTER TABLE `sm_roleuser` DISABLE KEYS */;
INSERT INTO `sm_roleuser` VALUES (1,1,1),(3,3,3),(4,4,4),(5,5,5),(21,2,2),(23,10,23);
/*!40000 ALTER TABLE `sm_roleuser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_supplier`
--

DROP TABLE IF EXISTS `sm_supplier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_supplier` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `address` varchar(300) DEFAULT NULL,
  `contact` varchar(50) DEFAULT NULL,
  `name` varchar(200) DEFAULT NULL,
  `number` varchar(50) DEFAULT NULL,
  `remarks` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_supplier`
--

LOCK TABLES `sm_supplier` WRITE;
/*!40000 ALTER TABLE `sm_supplier` DISABLE KEYS */;
INSERT INTO `sm_supplier` VALUES (1,'上海市金山区张堰镇松金公路2072号6607室','小张','上海福桂食品有限公司','0773-721717','失信供应商'),(2,'安徽省合肥市肥西县桃花工业园合派路','小王','安徽麦堡食品工业有限公司','0773-7217275',NULL),(3,'晋江市罗山后林西区41号','小李','福建省晋江市罗山惠康食品有限公司','1273-1217175','优质供应商'),(4,'南京市江宁区科学园竹山路565号1幢','小丽','南京含羞草食品有限公司','2121-7217175',NULL),(5,'南京市高淳县阳江镇新桥村下桥278号','王大狗','南京禾乃美工贸有限公司','2133-7217125',NULL),(6,'开平市水口镇东埠路６号','小七','开平广合腐乳有限公司','3332-7217175','2'),(7,'汕头市跃进路２３号利鸿基中心大厦写字楼２座','刘钩子','汕头市金茂食品有限公司','0723-7232175',NULL),(8,'南京市溧水区经济开发区','七枷社','南京喜之郎食品有限公司','1773-7217175',NULL),(9,'深圳市罗湖区翠竹北路中深石化区厂房B栋6楼','小蔡','深圳昌信实业有限公司','1773-7217175',NULL),(10,'南京市下关区金陵小区6村27-2-203室','小路','南京市下关区红鹰调味品商行','2132-7217175',NULL),(11,'荔浦县荔塔路１６－３６号','亲亲','桂林阜康食品工业有限公司','2123-7217175',NULL),(12,'南京鼓楼区世纪大楼123号','王小二','南京大王科技','0112-1426789','123'),(13,'南京将军路800号','小吴','南京大陆食品公司','1243-2135487','cc'),(16,'aa1','aa1','aa1','aaa1','1'),(17,'测试','测试','测试','测试','测试'),(18,'测试','测试','测试测试','测试','测试'),(19,'江西省抚州市崇仁县巴山镇2号','方鹏','家禽家畜有限公司','18678842345','优质客户');
/*!40000 ALTER TABLE `sm_supplier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_user`
--

DROP TABLE IF EXISTS `sm_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userName` varchar(50) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `trueName` varchar(20) DEFAULT NULL,
  `number` varchar(20) DEFAULT NULL,
  `address` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_user`
--

LOCK TABLES `sm_user` WRITE;
/*!40000 ALTER TABLE `sm_user` DISABLE KEYS */;
INSERT INTO `sm_user` VALUES (1,'admin','123456','超级管理员','17788563304','福州'),(2,'hr','123','人力资源部','17757177496','测试'),(3,'financial','123','lin','12312312','1233123'),(4,'buyer','123','采购部','123','123'),(5,'salesman','123','销售部','123','qwe'),(23,'测试','1','测试','测试','测试');
/*!40000 ALTER TABLE `sm_user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-04-15  8:39:50
