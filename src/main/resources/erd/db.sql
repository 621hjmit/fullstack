-- --------------------------------------------------------
-- 호스트:                          13.125.252.153
-- 서버 버전:                        10.5.25-MariaDB - MariaDB Server
-- 서버 OS:                        Linux
-- HeidiSQL 버전:                  12.8.0.6908
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- 테이블 hermes.address_info 구조 내보내기
CREATE TABLE IF NOT EXISTS `address_info` (
  `AI_NUM` int(11) NOT NULL AUTO_INCREMENT,
  `AI_PLACE_NAME` varchar(100) NOT NULL,
  `AI_RECIPENT_NAME` varchar(30) NOT NULL COMMENT 'Recipient',
  `AI_COUNTRY_CODE` varchar(5) NOT NULL,
  `AI_PHONE` varchar(30) NOT NULL,
  `AI_ZIPCODE` varchar(500) NOT NULL,
  `AI_ADDRESS1` varchar(500) NOT NULL,
  `AI_ADDRESS2` varchar(500) NOT NULL,
  `AI_DEFAULT` char(1) DEFAULT '0',
  `UI_NUM` int(11) NOT NULL,
  PRIMARY KEY (`AI_NUM`),
  KEY `UI_NUM` (`UI_NUM`),
  CONSTRAINT `address_info_ibfk_1` FOREIGN KEY (`UI_NUM`) REFERENCES `user_info` (`UI_NUM`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `address_info_ibfk_2` FOREIGN KEY (`UI_NUM`) REFERENCES `user_info` (`UI_NUM`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 hermes.bank_com_info 구조 내보내기
CREATE TABLE IF NOT EXISTS `bank_com_info` (
  `BCI_NUM` int(11) NOT NULL AUTO_INCREMENT,
  `BCI_NAME` varchar(30) DEFAULT NULL,
  `BCI_ID` varchar(30) DEFAULT NULL,
  `BCI_CONTACT` varchar(30) DEFAULT NULL,
  `BCI_PHONE` char(13) DEFAULT NULL,
  `BCI_EMAIL` char(30) DEFAULT NULL,
  `BCI_STARTDATE` char(8) DEFAULT NULL,
  `BCI_ENDDATE` char(8) DEFAULT NULL,
  PRIMARY KEY (`BCI_NUM`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 hermes.cancle_order 구조 내보내기
CREATE TABLE IF NOT EXISTS `cancle_order` (
  `CO_NUM` int(11) NOT NULL AUTO_INCREMENT,
  `OR_NUM` int(11) DEFAULT NULL,
  `CO_STATUS` int(11) DEFAULT NULL,
  `CREDAT` char(8) DEFAULT date_format(current_timestamp(),'%Y%m%d'),
  `CRETIM` char(6) DEFAULT date_format(current_timestamp(),'%h%m%s'),
  `CLODAT` char(8) DEFAULT date_format(current_timestamp(),'%Y%m%d'),
  PRIMARY KEY (`CO_NUM`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 hermes.card_com_info 구조 내보내기
CREATE TABLE IF NOT EXISTS `card_com_info` (
  `CCI_NUM` int(11) NOT NULL AUTO_INCREMENT,
  `CCI_NAME` varchar(30) DEFAULT NULL,
  `CCI_ID` varchar(30) DEFAULT NULL,
  `CCI_CONTACT` varchar(30) DEFAULT NULL,
  `CCI_PHONE` char(13) DEFAULT NULL,
  `CCI_EMAIL` char(30) DEFAULT NULL,
  `CCI_STARTDATE` char(8) DEFAULT NULL,
  `CCI_ENDDATE` char(8) DEFAULT NULL,
  PRIMARY KEY (`CCI_NUM`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 hermes.cart_info 구조 내보내기
CREATE TABLE IF NOT EXISTS `cart_info` (
  `CI_NUM` int(11) NOT NULL AUTO_INCREMENT,
  `UI_NUM` int(11) DEFAULT NULL,
  `CI_STATUS` tinyint(1) NOT NULL DEFAULT 1,
  `CREDAT` char(8) DEFAULT date_format(current_timestamp(),'%Y%m%d'),
  `CRETIM` char(6) DEFAULT date_format(current_timestamp(),'%h%m%s'),
  PRIMARY KEY (`CI_NUM`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 hermes.delivery_com_info 구조 내보내기
CREATE TABLE IF NOT EXISTS `delivery_com_info` (
  `DCI_NUM` int(11) NOT NULL AUTO_INCREMENT,
  `DCI_NAME` varchar(30) DEFAULT NULL,
  `DCI_ID` varchar(30) DEFAULT NULL,
  `DCI_CONTACT` varchar(30) DEFAULT NULL,
  `DCI_PHONE` char(13) DEFAULT NULL,
  `DCI_EMAIL` char(30) DEFAULT NULL,
  `DCI_STARTDATE` char(8) DEFAULT NULL,
  `DCI_ENDDATE` char(8) DEFAULT NULL,
  PRIMARY KEY (`DCI_NUM`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 hermes.delivery_info 구조 내보내기
CREATE TABLE IF NOT EXISTS `delivery_info` (
  `DEI_NUM` int(11) NOT NULL AUTO_INCREMENT,
  `DCI_NUM` int(11) DEFAULT NULL,
  `DEI_INVOICE_NUM` varchar(30) DEFAULT NULL,
  `DEI_RECEIVE` varchar(30) DEFAULT NULL,
  `DEI_ADDRESS` varchar(50) DEFAULT NULL,
  `DEI_POSTAL_CODE` varchar(50) DEFAULT NULL,
  `DEI_PHONE` char(13) DEFAULT NULL,
  `DEI_STATUS` int(11) DEFAULT NULL,
  `DEI_INVOICE_DAT` char(8) DEFAULT date_format(current_timestamp(),'%Y%m%d'),
  `DEI_START_DAT` char(8) DEFAULT date_format(current_timestamp(),'%Y%m%d'),
  `DEI_END_DAT` char(8) DEFAULT date_format(current_timestamp(),'%Y%m%d'),
  PRIMARY KEY (`DEI_NUM`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 hermes.detailcategory 구조 내보내기
CREATE TABLE IF NOT EXISTS `detailcategory` (
  `DETAIL_CATEGORY_ID` int(11) NOT NULL AUTO_INCREMENT,
  `FOREIGN_SUB_CATEGORY_ID` int(11) DEFAULT NULL,
  `FOREIGN_MAIN_CATEGORY_ID` int(11) DEFAULT NULL,
  `DETAIL_CATEGORY_NAME` varchar(100) NOT NULL,
  PRIMARY KEY (`DETAIL_CATEGORY_ID`),
  KEY `FOREIGN_SUB_CATEGORY_ID` (`FOREIGN_SUB_CATEGORY_ID`),
  KEY `FOREIGN_MAIN_CATEGORY_ID` (`FOREIGN_MAIN_CATEGORY_ID`),
  CONSTRAINT `detailcategory_ibfk_1` FOREIGN KEY (`FOREIGN_SUB_CATEGORY_ID`) REFERENCES `subcategory` (`SUB_CATEGORY_ID`),
  CONSTRAINT `detailcategory_ibfk_2` FOREIGN KEY (`FOREIGN_MAIN_CATEGORY_ID`) REFERENCES `maincategory` (`MAIN_CATEGORY_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 hermes.exchange_order 구조 내보내기
CREATE TABLE IF NOT EXISTS `exchange_order` (
  `EO_NUM` int(11) NOT NULL AUTO_INCREMENT,
  `OR_NUM` int(11) DEFAULT NULL,
  `EO_STATUS` int(11) DEFAULT NULL,
  `CREDAT` char(8) DEFAULT date_format(current_timestamp(),'%Y%m%d'),
  `CRETIM` char(6) DEFAULT date_format(current_timestamp(),'%h%m%s'),
  `CLODAT` char(8) DEFAULT date_format(current_timestamp(),'%Y%m%d'),
  PRIMARY KEY (`EO_NUM`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 hermes.maincategory 구조 내보내기
CREATE TABLE IF NOT EXISTS `maincategory` (
  `MAIN_CATEGORY_ID` int(11) NOT NULL AUTO_INCREMENT,
  `MAIN_CATEGORY_NAME` varchar(100) NOT NULL,
  PRIMARY KEY (`MAIN_CATEGORY_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 hermes.orders 구조 내보내기
CREATE TABLE IF NOT EXISTS `orders` (
  `OR_NUM` int(11) NOT NULL AUTO_INCREMENT,
  `OR_ID` varchar(30) NOT NULL,
  `UI_NUM` int(11) NOT NULL,
  `UI_NAME` varchar(30) NOT NULL,
  `OR_ITEM_COUNT` int(11) DEFAULT NULL,
  `OR_STATUS` varchar(20) DEFAULT NULL,
  `CI_NUM` int(11) NOT NULL,
  `OR_MEMO` varchar(400) DEFAULT NULL,
  `CREDAT` char(8) DEFAULT date_format(current_timestamp(),'%Y%m%d'),
  `CRETIM` char(6) DEFAULT date_format(current_timestamp(),'%h%m%s'),
  `OR_CLOSED_DATE` char(8) DEFAULT NULL,
  `OR_AMOUNT` int(11) DEFAULT NULL,
  PRIMARY KEY (`OR_NUM`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 hermes.order_delivery 구조 내보내기
CREATE TABLE IF NOT EXISTS `order_delivery` (
  `ORD_NUM` int(11) NOT NULL AUTO_INCREMENT,
  `OR_NUM` int(11) DEFAULT NULL,
  `DEI_NUM` int(11) DEFAULT NULL,
  PRIMARY KEY (`ORD_NUM`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 hermes.order_item 구조 내보내기
CREATE TABLE IF NOT EXISTS `order_item` (
  `OI_NUM` int(11) NOT NULL AUTO_INCREMENT,
  `OI_ID` varchar(30) NOT NULL,
  `UI_NAME` varchar(30) NOT NULL,
  `PI_NAME` varchar(30) NOT NULL,
  `OI_PRICE` int(11) DEFAULT NULL,
  `OI_REAL_PRICE` int(11) DEFAULT NULL,
  `OI_COUNT` int(11) DEFAULT NULL,
  `OI_TOTAL` int(11) DEFAULT NULL,
  `PAI_NAME` varchar(30) DEFAULT NULL,
  `DEI_RECEIVER` varchar(30) DEFAULT NULL,
  `OI_STATUS` varchar(30) DEFAULT NULL,
  `OI_STATUS_PAY` varchar(20) DEFAULT NULL,
  `OI_STATUS_DELIVERY` varchar(20) DEFAULT NULL,
  `OI_CANCLE` varchar(20) DEFAULT NULL,
  `OI_EXCHANGE` varchar(20) DEFAULT NULL,
  `OI_RETURN` varchar(20) DEFAULT NULL,
  `OI_REFUND` varchar(20) DEFAULT NULL,
  `OI_MEMO` varchar(400) DEFAULT NULL,
  `OR_ID` varchar(30) NOT NULL,
  `CI_NUM` int(11) NOT NULL,
  `UI_NUM` int(11) NOT NULL,
  `PI_NUM` int(11) NOT NULL,
  `PAI_NUM` int(11) DEFAULT NULL,
  `DEI_NUM` int(11) DEFAULT NULL,
  `CREDAT` char(8) DEFAULT date_format(current_timestamp(),'%Y%m%d'),
  `CRETIM` char(6) DEFAULT date_format(current_timestamp(),'%h%m%s'),
  `OI_CLOSED_DATE` char(8) DEFAULT NULL,
  PRIMARY KEY (`OI_NUM`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 hermes.order_item_temp 구조 내보내기
CREATE TABLE IF NOT EXISTS `order_item_temp` (
  `OIT_NUM` int(11) NOT NULL AUTO_INCREMENT,
  `CI_NUM` int(11) NOT NULL,
  `PI_ID` int(11) NOT NULL,
  `PI_NAME` varchar(30) DEFAULT NULL,
  `PI_CODE` varchar(30) DEFAULT NULL,
  `PI_COLOR_TITLE` varchar(30) DEFAULT NULL,
  `PS_NAME` varchar(30) DEFAULT NULL,
  `PI_PRICE` int(11) DEFAULT NULL,
  `OIT_COUNT` int(11) DEFAULT NULL,
  `UI_NUM` int(11) DEFAULT NULL,
  `UI_NAME` varchar(30) DEFAULT NULL,
  `OIT_STATUS` varchar(30) DEFAULT NULL,
  `CREDAT` char(8) DEFAULT date_format(current_timestamp(),'%Y%m%d'),
  `OIT_CLOSED_DATE` char(8) DEFAULT NULL,
  PRIMARY KEY (`OIT_NUM`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 hermes.product 구조 내보내기
CREATE TABLE IF NOT EXISTS `product` (
  `PI_ID` int(11) NOT NULL AUTO_INCREMENT,
  `PI_CODE` varchar(20) NOT NULL,
  `PI_NAME` varchar(100) NOT NULL,
  `PI_PRICE` varchar(100) NOT NULL,
  `PI_COUNTRY_OF_ORIGIN` varchar(100) NOT NULL,
  `PI_MAIN_CATEGORY_ID` int(11) NOT NULL,
  `PI_SUB_CATEGORY_ID` int(11) NOT NULL,
  `PI_DETAIL_CATEGORY_ID` int(11) NOT NULL,
  `PI_STORY` varchar(500) DEFAULT NULL,
  `PI_COLOR_TITLE` varchar(50) NOT NULL,
  `PI_MATERIAL_TITLE` varchar(500) NOT NULL,
  PRIMARY KEY (`PI_ID`),
  KEY `PI_MAIN_CATEGORY_ID` (`PI_MAIN_CATEGORY_ID`),
  KEY `PI_SUB_CATEGORY_ID` (`PI_SUB_CATEGORY_ID`),
  KEY `PI_DETAIL_CATEGORY_ID` (`PI_DETAIL_CATEGORY_ID`),
  CONSTRAINT `product_ibfk_1` FOREIGN KEY (`PI_MAIN_CATEGORY_ID`) REFERENCES `maincategory` (`MAIN_CATEGORY_ID`),
  CONSTRAINT `product_ibfk_2` FOREIGN KEY (`PI_SUB_CATEGORY_ID`) REFERENCES `subcategory` (`SUB_CATEGORY_ID`),
  CONSTRAINT `product_ibfk_3` FOREIGN KEY (`PI_DETAIL_CATEGORY_ID`) REFERENCES `detailcategory` (`DETAIL_CATEGORY_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 hermes.product_add_info 구조 내보내기
CREATE TABLE IF NOT EXISTS `product_add_info` (
  `PAI_ID` int(11) NOT NULL AUTO_INCREMENT,
  `PAI_DESC` text DEFAULT NULL,
  PRIMARY KEY (`PAI_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 hermes.product_care_desc 구조 내보내기
CREATE TABLE IF NOT EXISTS `product_care_desc` (
  `PCD_ID` int(11) NOT NULL AUTO_INCREMENT,
  `PM_ID` int(11) DEFAULT NULL,
  `PCD_DESC` text NOT NULL,
  PRIMARY KEY (`PCD_ID`),
  KEY `PM_ID` (`PM_ID`),
  CONSTRAINT `product_care_desc_ibfk_1` FOREIGN KEY (`PM_ID`) REFERENCES `product_material` (`PM_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 hermes.product_color 구조 내보내기
CREATE TABLE IF NOT EXISTS `product_color` (
  `PC_ID` int(11) NOT NULL AUTO_INCREMENT,
  `PC_NAME` varchar(50) NOT NULL,
  `PC_CODE` varchar(50) NOT NULL,
  PRIMARY KEY (`PC_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 hermes.product_color_mapping 구조 내보내기
CREATE TABLE IF NOT EXISTS `product_color_mapping` (
  `PCM_ID` int(11) NOT NULL AUTO_INCREMENT,
  `PI_ID` int(11) NOT NULL,
  `PC_ID` int(11) NOT NULL,
  PRIMARY KEY (`PCM_ID`),
  UNIQUE KEY `PI_ID` (`PI_ID`,`PC_ID`),
  KEY `PC_ID` (`PC_ID`),
  CONSTRAINT `product_color_mapping_ibfk_1` FOREIGN KEY (`PI_ID`) REFERENCES `product` (`PI_ID`),
  CONSTRAINT `product_color_mapping_ibfk_2` FOREIGN KEY (`PC_ID`) REFERENCES `product_color` (`PC_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 hermes.product_delivery 구조 내보내기
CREATE TABLE IF NOT EXISTS `product_delivery` (
  `PD_ID` int(11) NOT NULL AUTO_INCREMENT,
  `PD_DESC` text NOT NULL,
  PRIMARY KEY (`PD_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 hermes.product_detail_info 구조 내보내기
CREATE TABLE IF NOT EXISTS `product_detail_info` (
  `PDI_ID` int(11) NOT NULL AUTO_INCREMENT,
  `PI_ID` int(11) DEFAULT NULL,
  `PDI_HEIGHT` int(11) NOT NULL,
  `PDI_SIZE` varchar(10) NOT NULL,
  PRIMARY KEY (`PDI_ID`),
  UNIQUE KEY `PI_ID` (`PI_ID`),
  CONSTRAINT `product_detail_info_ibfk_1` FOREIGN KEY (`PI_ID`) REFERENCES `product` (`PI_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 hermes.product_gift 구조 내보내기
CREATE TABLE IF NOT EXISTS `product_gift` (
  `PG_ID` int(11) NOT NULL AUTO_INCREMENT,
  `PG_TEXT` text NOT NULL,
  PRIMARY KEY (`PG_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 hermes.product_img 구조 내보내기
CREATE TABLE IF NOT EXISTS `product_img` (
  `PIMG_ID` int(11) NOT NULL AUTO_INCREMENT,
  `PI_ID` int(11) DEFAULT NULL,
  `PIMG_NAME` varchar(100) NOT NULL,
  `PIMG_URL` varchar(200) NOT NULL,
  `PIMG_CREDAT` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`PIMG_ID`),
  KEY `PI_ID` (`PI_ID`),
  CONSTRAINT `product_img_ibfk_1` FOREIGN KEY (`PI_ID`) REFERENCES `product` (`PI_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 hermes.product_main_info 구조 내보내기
CREATE TABLE IF NOT EXISTS `product_main_info` (
  `PMI_ID` int(11) NOT NULL AUTO_INCREMENT,
  `PI_ID` int(11) DEFAULT NULL,
  `PMI_DESC` varchar(500) NOT NULL,
  PRIMARY KEY (`PMI_ID`),
  KEY `PI_ID` (`PI_ID`),
  CONSTRAINT `product_main_info_ibfk_1` FOREIGN KEY (`PI_ID`) REFERENCES `product` (`PI_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 hermes.product_material 구조 내보내기
CREATE TABLE IF NOT EXISTS `product_material` (
  `PM_ID` int(11) NOT NULL AUTO_INCREMENT,
  `PM_NAME` varchar(50) NOT NULL,
  PRIMARY KEY (`PM_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 hermes.product_material_mapping 구조 내보내기
CREATE TABLE IF NOT EXISTS `product_material_mapping` (
  `PMM_ID` int(11) NOT NULL AUTO_INCREMENT,
  `PI_ID` int(11) NOT NULL,
  `PM_ID` int(11) NOT NULL,
  PRIMARY KEY (`PMM_ID`),
  UNIQUE KEY `PI_ID` (`PI_ID`,`PM_ID`),
  KEY `PM_ID` (`PM_ID`),
  CONSTRAINT `product_material_mapping_ibfk_1` FOREIGN KEY (`PI_ID`) REFERENCES `product` (`PI_ID`),
  CONSTRAINT `product_material_mapping_ibfk_2` FOREIGN KEY (`PM_ID`) REFERENCES `product_material` (`PM_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 hermes.product_online_mapping 구조 내보내기
CREATE TABLE IF NOT EXISTS `product_online_mapping` (
  `POM_ID` int(11) NOT NULL AUTO_INCREMENT,
  `PI_ID` int(11) NOT NULL,
  `IS_ONLINE` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`POM_ID`),
  KEY `PI_ID` (`PI_ID`),
  CONSTRAINT `product_online_mapping_ibfk_1` FOREIGN KEY (`PI_ID`) REFERENCES `product` (`PI_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 hermes.product_payment 구조 내보내기
CREATE TABLE IF NOT EXISTS `product_payment` (
  `PP_ID` int(11) NOT NULL AUTO_INCREMENT,
  `PP_DESC` varchar(50) NOT NULL,
  PRIMARY KEY (`PP_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 hermes.product_refund 구조 내보내기
CREATE TABLE IF NOT EXISTS `product_refund` (
  `PR_ID` int(11) NOT NULL AUTO_INCREMENT,
  `PR_DESC` text NOT NULL,
  PRIMARY KEY (`PR_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 hermes.product_size 구조 내보내기
CREATE TABLE IF NOT EXISTS `product_size` (
  `PS_ID` int(11) NOT NULL AUTO_INCREMENT,
  `PS_NAME` varchar(10) NOT NULL,
  PRIMARY KEY (`PS_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 hermes.product_size_mapping 구조 내보내기
CREATE TABLE IF NOT EXISTS `product_size_mapping` (
  `PSM_ID` int(11) NOT NULL AUTO_INCREMENT,
  `PI_ID` int(11) NOT NULL,
  `PS_ID` int(11) NOT NULL,
  PRIMARY KEY (`PSM_ID`),
  UNIQUE KEY `PI_ID` (`PI_ID`,`PS_ID`),
  KEY `PS_ID` (`PS_ID`),
  CONSTRAINT `product_size_mapping_ibfk_1` FOREIGN KEY (`PI_ID`) REFERENCES `product` (`PI_ID`),
  CONSTRAINT `product_size_mapping_ibfk_2` FOREIGN KEY (`PS_ID`) REFERENCES `product_size` (`PS_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 hermes.refund_order 구조 내보내기
CREATE TABLE IF NOT EXISTS `refund_order` (
  `RFO_NUM` int(11) NOT NULL AUTO_INCREMENT,
  `OR_NUM` int(11) DEFAULT NULL,
  `RFO_STATUS` int(11) DEFAULT NULL,
  `CREDAT` char(8) DEFAULT date_format(current_timestamp(),'%Y%m%d'),
  `CRETIM` char(6) DEFAULT date_format(current_timestamp(),'%h%m%s'),
  `CLODAT` char(8) DEFAULT date_format(current_timestamp(),'%Y%m%d'),
  PRIMARY KEY (`RFO_NUM`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 hermes.return_order 구조 내보내기
CREATE TABLE IF NOT EXISTS `return_order` (
  `RO_NUM` int(11) NOT NULL AUTO_INCREMENT,
  `OR_NUM` int(11) DEFAULT NULL,
  `RO_STATUS` int(11) DEFAULT NULL,
  `CREDAT` char(8) DEFAULT date_format(current_timestamp(),'%Y%m%d'),
  `CRETIM` char(6) DEFAULT date_format(current_timestamp(),'%h%m%s'),
  `CLODAT` char(8) DEFAULT date_format(current_timestamp(),'%Y%m%d'),
  PRIMARY KEY (`RO_NUM`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 hermes.subcategory 구조 내보내기
CREATE TABLE IF NOT EXISTS `subcategory` (
  `SUB_CATEGORY_ID` int(11) NOT NULL AUTO_INCREMENT,
  `FOREIGN_MAIN_CATEGORY_ID` int(11) DEFAULT NULL,
  `SUB_CATEGORY_NAME` varchar(100) NOT NULL,
  PRIMARY KEY (`SUB_CATEGORY_ID`),
  KEY `FOREIGN_MAIN_CATEGORY_ID` (`FOREIGN_MAIN_CATEGORY_ID`),
  CONSTRAINT `subcategory` FOREIGN KEY (`FOREIGN_MAIN_CATEGORY_ID`) REFERENCES `maincategory` (`MAIN_CATEGORY_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 hermes.user_grade_info 구조 내보내기
CREATE TABLE IF NOT EXISTS `user_grade_info` (
  `GI_NUM` int(11) NOT NULL AUTO_INCREMENT COMMENT '회원등급',
  `GI_NAME` char(10) NOT NULL,
  `GI_DESC` varchar(100) DEFAULT NULL,
  `GI_ORDER` int(11) DEFAULT NULL,
  PRIMARY KEY (`GI_NUM`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 hermes.user_info 구조 내보내기
CREATE TABLE IF NOT EXISTS `user_info` (
  `UI_NUM` int(11) NOT NULL AUTO_INCREMENT,
  `UI_FIRST_NAME` varchar(50) NOT NULL,
  `UI_LAST_NAME` varchar(50) NOT NULL,
  `UI_EMAIL` varchar(255) NOT NULL,
  `UI_PWD` varchar(200) NOT NULL,
  `UI_COUNTRY_CODE` varchar(3) NOT NULL,
  `UI_PHONE` varchar(50) NOT NULL,
  `UI_GENDER` char(1) NOT NULL,
  `UI_BIRTH` char(8) DEFAULT NULL,
  `UI_DORMANT` char(1) NOT NULL DEFAULT '0',
  `UI_OUT` char(1) NOT NULL DEFAULT '0',
  `UI_TYPE` char(1) NOT NULL DEFAULT '1',
  `UI_NEWS` char(1) DEFAULT '1',
  `CREDAT` char(8) NOT NULL DEFAULT date_format(current_timestamp(),'%Y%m%d'),
  `CRETIM` char(6) NOT NULL DEFAULT date_format(current_timestamp(),'%H%i%s'),
  `OUTDAT` char(8) DEFAULT date_format(current_timestamp(),'%Y%m%d'),
  `GI_NUM` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`UI_NUM`),
  UNIQUE KEY `UI_EMAIL` (`UI_EMAIL`),
  KEY `GI_NUM` (`GI_NUM`),
  CONSTRAINT `user_info_ibfk_1` FOREIGN KEY (`GI_NUM`) REFERENCES `user_grade_info` (`GI_NUM`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_info_ibfk_2` FOREIGN KEY (`GI_NUM`) REFERENCES `user_grade_info` (`GI_NUM`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 hermes.user_memo 구조 내보내기
CREATE TABLE IF NOT EXISTS `user_memo` (
  `UM_NUM` int(11) NOT NULL AUTO_INCREMENT,
  `UM_MEMO` varchar(800) DEFAULT NULL,
  `UI_NUM` int(11) DEFAULT NULL,
  PRIMARY KEY (`UM_NUM`),
  KEY `UI_NUM` (`UI_NUM`),
  CONSTRAINT `UI_NUM` FOREIGN KEY (`UI_NUM`) REFERENCES `user_info` (`UI_NUM`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 hermes.visit_info 구조 내보내기
CREATE TABLE IF NOT EXISTS `visit_info` (
  `VI_NUM` int(11) NOT NULL AUTO_INCREMENT,
  `VI_VISIT_DATE` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `UI_NUM` int(11) NOT NULL,
  PRIMARY KEY (`VI_NUM`),
  KEY `UI_NUM` (`UI_NUM`),
  CONSTRAINT `visit_info_ibfk_1` FOREIGN KEY (`UI_NUM`) REFERENCES `user_info` (`UI_NUM`)
) ENGINE=InnoDB AUTO_INCREMENT=92 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
