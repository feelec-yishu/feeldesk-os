/*
 Navicat Premium Data Transfer

 Source Server         : FeelDesk-V3
 Source Server Type    : MySQL
 Source Server Version : 50726
 Source Host           : localhost:3306
 Source Schema         : feeldesk_base

 Target Server Type    : MySQL
 Target Server Version : 50726
 File Encoding         : 65001

 Date: 29/07/2022 16:41:17
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for feel_api_data
-- ----------------------------
DROP TABLE IF EXISTS `feel_api_data`;
CREATE TABLE `feel_api_data`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(11) NOT NULL DEFAULT 0,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `url` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `ticket` tinyint(1) NOT NULL DEFAULT 0 COMMENT '工单信息 10选中 20未选',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of feel_api_data
-- ----------------------------

-- ----------------------------
-- Table structure for feel_associate_ticket
-- ----------------------------
DROP TABLE IF EXISTS `feel_associate_ticket`;
CREATE TABLE `feel_associate_ticket`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(11) NOT NULL DEFAULT 0,
  `associate_ticket_id` int(11) NOT NULL DEFAULT 0 COMMENT '主动关联的工单ID',
  `associated_ticket_id` int(11) NOT NULL DEFAULT 0 COMMENT '被动关联的工单ID',
  `create_time` int(11) NOT NULL DEFAULT 0 COMMENT '关联时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = FIXED;

-- ----------------------------
-- Records of feel_associate_ticket
-- ----------------------------

-- ----------------------------
-- Table structure for feel_build_msg
-- ----------------------------
DROP TABLE IF EXISTS `feel_build_msg`;
CREATE TABLE `feel_build_msg`  (
  `msg_id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`msg_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = FIXED;

-- ----------------------------
-- Records of feel_build_msg
-- ----------------------------

-- ----------------------------
-- Table structure for feel_cc_ticket
-- ----------------------------
DROP TABLE IF EXISTS `feel_cc_ticket`;
CREATE TABLE `feel_cc_ticket`  (
  `cc_id` int(11) NOT NULL AUTO_INCREMENT,
  `ticket_id` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `company_id` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `member_id` int(11) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`cc_id`) USING BTREE,
  INDEX `cc_index`(`company_id`, `ticket_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = FIXED;

-- ----------------------------
-- Records of feel_cc_ticket
-- ----------------------------

-- ----------------------------
-- Table structure for feel_city
-- ----------------------------
DROP TABLE IF EXISTS `feel_city`;
CREATE TABLE `feel_city`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `country_code` char(3) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '所属国家编码',
  `province_code` char(3) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '所属省份编码',
  `code` char(3) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '城市编码',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '城市名',
  `name_en` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '英文名称',
  `name_jp` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '日文名称',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `code`(`country_code`, `province_code`, `code`) USING BTREE,
  INDEX `code_name`(`country_code`, `province_code`, `name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1150 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of feel_city
-- ----------------------------
INSERT INTO `feel_city` VALUES (1, '1', '11', '1', '东城', 'Dongcheng', '');
INSERT INTO `feel_city` VALUES (2, '1', '11', '2', '西城', 'Xicheng', '');
INSERT INTO `feel_city` VALUES (3, '1', '11', '5', '朝阳', 'Chaoyang', '');
INSERT INTO `feel_city` VALUES (4, '1', '11', '6', '丰台', 'Fengtai', '');
INSERT INTO `feel_city` VALUES (5, '1', '11', '7', '石景山', 'Shijingshan', '');
INSERT INTO `feel_city` VALUES (6, '1', '11', '8', '海淀', 'Haidian', '');
INSERT INTO `feel_city` VALUES (7, '1', '11', '9', '门头沟', 'Mentougou', '');
INSERT INTO `feel_city` VALUES (8, '1', '11', '11', '房山', 'Fangshan', '');
INSERT INTO `feel_city` VALUES (9, '1', '11', '12', '通州', 'Tongzhou', '');
INSERT INTO `feel_city` VALUES (10, '1', '11', '13', '顺义', 'Shunyi', '');
INSERT INTO `feel_city` VALUES (11, '1', '11', '21', '昌平', 'Changping', '');
INSERT INTO `feel_city` VALUES (12, '1', '11', '24', '大兴', 'Daxing', '');
INSERT INTO `feel_city` VALUES (13, '1', '11', '26', '平谷', 'Pinggu', '');
INSERT INTO `feel_city` VALUES (14, '1', '11', '27', '怀柔', 'Huairou', '');
INSERT INTO `feel_city` VALUES (15, '1', '11', '28', '密云', 'Miyun', '');
INSERT INTO `feel_city` VALUES (16, '1', '11', '29', '延庆', 'Yanqing', '');
INSERT INTO `feel_city` VALUES (17, '1', '12', '1', '和平', 'peace', '');
INSERT INTO `feel_city` VALUES (18, '1', '12', '2', '河东', 'Hedong', '');
INSERT INTO `feel_city` VALUES (19, '1', '12', '3', '河西', 'Hexi', '');
INSERT INTO `feel_city` VALUES (20, '1', '12', '4', '南开', 'Nankai', '');
INSERT INTO `feel_city` VALUES (21, '1', '12', '5', '河北', 'Hebei', '');
INSERT INTO `feel_city` VALUES (22, '1', '12', '6', '红桥', 'Red bridge', '');
INSERT INTO `feel_city` VALUES (23, '1', '12', '26', '滨海新区', 'Binhai New Area', '');
INSERT INTO `feel_city` VALUES (24, '1', '12', '10', '东丽', 'Toray', '');
INSERT INTO `feel_city` VALUES (25, '1', '12', '11', '西青', 'Xiqing', '');
INSERT INTO `feel_city` VALUES (26, '1', '12', '12', '津南', 'Jinnan', '');
INSERT INTO `feel_city` VALUES (27, '1', '12', '13', '北辰', 'Beichen', '');
INSERT INTO `feel_city` VALUES (28, '1', '12', '21', '宁河', 'Ninghe', '');
INSERT INTO `feel_city` VALUES (29, '1', '12', '22', '武清', 'Wu Qing', '');
INSERT INTO `feel_city` VALUES (30, '1', '12', '23', '静海', 'Jinghai', '');
INSERT INTO `feel_city` VALUES (31, '1', '12', '24', '宝坻', 'Breguet', '');
INSERT INTO `feel_city` VALUES (32, '1', '12', '25', '蓟县', 'Ji County', '');
INSERT INTO `feel_city` VALUES (33, '1', '13', '1', '石家庄', 'Shijiazhuang', '');
INSERT INTO `feel_city` VALUES (34, '1', '13', '2', '唐山', 'Tangshan', '');
INSERT INTO `feel_city` VALUES (35, '1', '13', '3', '秦皇岛', 'Qinhuangdao', '');
INSERT INTO `feel_city` VALUES (36, '1', '13', '4', '邯郸', '邯郸', '');
INSERT INTO `feel_city` VALUES (37, '1', '13', '5', '邢台', 'Xingtai', '');
INSERT INTO `feel_city` VALUES (38, '1', '13', '6', '保定', 'Baoding', '');
INSERT INTO `feel_city` VALUES (39, '1', '13', '7', '张家口', 'Zhangjiakou', '');
INSERT INTO `feel_city` VALUES (40, '1', '13', '8', '承德', 'Chengde', '');
INSERT INTO `feel_city` VALUES (41, '1', '13', '9', '沧州', 'Zhangzhou', '');
INSERT INTO `feel_city` VALUES (42, '1', '13', '10', '廊坊', 'Langfang', '');
INSERT INTO `feel_city` VALUES (43, '1', '13', '11', '衡水', 'Hengshui', '');
INSERT INTO `feel_city` VALUES (44, '1', '14', '1', '太原', 'Taiyuan', '');
INSERT INTO `feel_city` VALUES (45, '1', '14', '2', '大同', 'Datong', '');
INSERT INTO `feel_city` VALUES (46, '1', '14', '3', '阳泉', 'Yangquan', '');
INSERT INTO `feel_city` VALUES (47, '1', '14', '4', '长治', 'Changzhi', '');
INSERT INTO `feel_city` VALUES (48, '1', '14', '5', '晋城', 'Jincheng', '');
INSERT INTO `feel_city` VALUES (49, '1', '14', '6', '朔州', 'Zhangzhou', '');
INSERT INTO `feel_city` VALUES (50, '1', '14', '7', '晋中', 'Jinzhong', '');
INSERT INTO `feel_city` VALUES (51, '1', '14', '8', '运城', 'Yuncheng', '');
INSERT INTO `feel_city` VALUES (52, '1', '14', '9', '忻州', 'Zhangzhou', '');
INSERT INTO `feel_city` VALUES (53, '1', '14', '10', '临汾', 'Linyi', '');
INSERT INTO `feel_city` VALUES (54, '1', '14', '11', '吕梁', 'Lu Liang', '');
INSERT INTO `feel_city` VALUES (55, '1', '15', '1', '呼和浩特', 'Hohhot', '');
INSERT INTO `feel_city` VALUES (56, '1', '15', '2', '包头', 'Baotou', '');
INSERT INTO `feel_city` VALUES (57, '1', '15', '3', '乌海', 'Wuhai', '');
INSERT INTO `feel_city` VALUES (58, '1', '15', '4', '赤峰', 'Chifeng', '');
INSERT INTO `feel_city` VALUES (59, '1', '15', '5', '通辽', 'Tongliao', '');
INSERT INTO `feel_city` VALUES (60, '1', '15', '6', '鄂尔多斯', 'Ordos', '');
INSERT INTO `feel_city` VALUES (61, '1', '15', '7', '呼伦贝尔', 'Hulunbeier', '');
INSERT INTO `feel_city` VALUES (62, '1', '15', '8', '巴彦淖尔', 'Bayannaoer', '');
INSERT INTO `feel_city` VALUES (63, '1', '15', '9', '乌兰察布', 'Ulanchabu', '');
INSERT INTO `feel_city` VALUES (64, '1', '15', '22', '兴安', 'Xing\'an', '');
INSERT INTO `feel_city` VALUES (65, '1', '15', '25', '锡林郭勒', 'Xilin Gol', '');
INSERT INTO `feel_city` VALUES (66, '1', '15', '29', '阿拉善', 'Alashan', '');
INSERT INTO `feel_city` VALUES (67, '1', '21', '1', '沈阳', 'Shenyang', '');
INSERT INTO `feel_city` VALUES (68, '1', '21', '2', '大连', 'Dalian', '');
INSERT INTO `feel_city` VALUES (69, '1', '21', '3', '鞍山', 'Anshan', '');
INSERT INTO `feel_city` VALUES (70, '1', '21', '4', '抚顺', 'Fushun', '');
INSERT INTO `feel_city` VALUES (71, '1', '21', '5', '本溪', 'Benxi', '');
INSERT INTO `feel_city` VALUES (72, '1', '21', '6', '丹东', 'Dandong', '');
INSERT INTO `feel_city` VALUES (73, '1', '21', '7', '锦州', 'Jinzhou', '');
INSERT INTO `feel_city` VALUES (74, '1', '21', '8', '营口', 'Yingkou', '');
INSERT INTO `feel_city` VALUES (75, '1', '21', '9', '阜新', 'Fuxin', '');
INSERT INTO `feel_city` VALUES (76, '1', '21', '10', '辽阳', 'Liaoyang', '');
INSERT INTO `feel_city` VALUES (77, '1', '21', '11', '盘锦', 'Panjin', '');
INSERT INTO `feel_city` VALUES (78, '1', '21', '12', '铁岭', 'Tieling', '');
INSERT INTO `feel_city` VALUES (79, '1', '21', '13', '朝阳', 'Chaoyang', '');
INSERT INTO `feel_city` VALUES (80, '1', '21', '14', '葫芦岛', 'Huludao', '');
INSERT INTO `feel_city` VALUES (81, '1', '22', '1', '长春', 'Changchun', '');
INSERT INTO `feel_city` VALUES (82, '1', '22', '2', '吉林', 'Jilin', '');
INSERT INTO `feel_city` VALUES (83, '1', '22', '3', '四平', 'Siping', '');
INSERT INTO `feel_city` VALUES (84, '1', '22', '4', '辽源', 'Liaoyuan', '');
INSERT INTO `feel_city` VALUES (85, '1', '22', '5', '通化', 'Tonghua', '');
INSERT INTO `feel_city` VALUES (86, '1', '22', '6', '白山', 'White Mountain', '');
INSERT INTO `feel_city` VALUES (87, '1', '22', '7', '松原', 'Matsubara', '');
INSERT INTO `feel_city` VALUES (88, '1', '22', '8', '白城', 'Baicheng', '');
INSERT INTO `feel_city` VALUES (89, '1', '22', '24', '延边', 'Yanbian', '');
INSERT INTO `feel_city` VALUES (90, '1', '23', '1', '哈尔滨', 'Harbin', '');
INSERT INTO `feel_city` VALUES (91, '1', '23', '2', '齐齐哈尔', 'Qiqihar', '');
INSERT INTO `feel_city` VALUES (92, '1', '23', '3', '鸡西', 'Jixi', '');
INSERT INTO `feel_city` VALUES (93, '1', '23', '4', '鹤岗', 'Hegang', '');
INSERT INTO `feel_city` VALUES (94, '1', '23', '5', '双鸭山', 'Shuangyashan', '');
INSERT INTO `feel_city` VALUES (95, '1', '23', '6', '大庆', 'Daqing', '');
INSERT INTO `feel_city` VALUES (96, '1', '23', '7', '伊春', 'Yichun', '');
INSERT INTO `feel_city` VALUES (97, '1', '23', '8', '佳木斯', 'Jiamusi', '');
INSERT INTO `feel_city` VALUES (98, '1', '23', '9', '七台河', 'Qitaihe', '');
INSERT INTO `feel_city` VALUES (99, '1', '23', '10', '牡丹江', 'Mudanjiang', '');
INSERT INTO `feel_city` VALUES (100, '1', '23', '11', '黑河', 'Heihe', '');
INSERT INTO `feel_city` VALUES (101, '1', '23', '12', '绥化', 'Suihua', '');
INSERT INTO `feel_city` VALUES (102, '1', '23', '27', '大兴安岭', 'Daxinganling', '');
INSERT INTO `feel_city` VALUES (103, '1', '31', '1', '黄浦', 'Huangpu', '');
INSERT INTO `feel_city` VALUES (104, '1', '31', '3', '卢湾', 'Luwan', '');
INSERT INTO `feel_city` VALUES (105, '1', '31', '4', '徐汇', 'Xuhui', '');
INSERT INTO `feel_city` VALUES (106, '1', '31', '5', '长宁', 'Changning', '');
INSERT INTO `feel_city` VALUES (107, '1', '31', '6', '静安', 'Jingan', '');
INSERT INTO `feel_city` VALUES (108, '1', '31', '7', '普陀', 'Putuo', '');
INSERT INTO `feel_city` VALUES (109, '1', '31', '8', '闸北', 'Zhabei', '');
INSERT INTO `feel_city` VALUES (110, '1', '31', '9', '虹口', 'Hongkou', '');
INSERT INTO `feel_city` VALUES (111, '1', '31', '11', '杨浦', 'Yangpu', '');
INSERT INTO `feel_city` VALUES (112, '1', '31', '12', '闵行', 'Minhang', '');
INSERT INTO `feel_city` VALUES (113, '1', '31', '13', '宝山', 'Baoshan', '');
INSERT INTO `feel_city` VALUES (114, '1', '31', '14', '嘉定', 'Jiading', '');
INSERT INTO `feel_city` VALUES (115, '1', '31', '15', '浦东新区', 'Pudong New Area', '');
INSERT INTO `feel_city` VALUES (116, '1', '31', '16', '金山', 'Jinshan', '');
INSERT INTO `feel_city` VALUES (117, '1', '31', '17', '松江', 'Songjiang', '');
INSERT INTO `feel_city` VALUES (118, '1', '31', '26', '奉贤', 'Fengxian', '');
INSERT INTO `feel_city` VALUES (119, '1', '31', '29', '青浦', 'Qingpu', '');
INSERT INTO `feel_city` VALUES (120, '1', '31', '30', '崇明', 'Chongming', '');
INSERT INTO `feel_city` VALUES (121, '1', '32', '1', '南京', 'Nanjing', '');
INSERT INTO `feel_city` VALUES (122, '1', '32', '2', '无锡', 'Wuxi', '');
INSERT INTO `feel_city` VALUES (123, '1', '32', '3', '徐州', 'Xuzhou', '');
INSERT INTO `feel_city` VALUES (124, '1', '32', '4', '常州', 'Changzhou', '');
INSERT INTO `feel_city` VALUES (125, '1', '32', '5', '苏州', 'Suzhou', '');
INSERT INTO `feel_city` VALUES (126, '1', '32', '6', '南通', 'Nantong', '');
INSERT INTO `feel_city` VALUES (127, '1', '32', '7', '连云港', 'Lianyungang', '');
INSERT INTO `feel_city` VALUES (128, '1', '32', '8', '淮安', 'Huai\'an', '');
INSERT INTO `feel_city` VALUES (129, '1', '32', '9', '盐城', 'Yancheng', '');
INSERT INTO `feel_city` VALUES (130, '1', '32', '10', '扬州', 'Yangzhou', '');
INSERT INTO `feel_city` VALUES (131, '1', '32', '11', '镇江', 'Zhenjiang', '');
INSERT INTO `feel_city` VALUES (132, '1', '32', '12', '泰州', 'Taizhou', '');
INSERT INTO `feel_city` VALUES (133, '1', '32', '13', '宿迁', 'Suqian', '');
INSERT INTO `feel_city` VALUES (134, '1', '33', '1', '杭州', 'Hangzhou', '');
INSERT INTO `feel_city` VALUES (135, '1', '33', '2', '宁波', 'Ningbo', '');
INSERT INTO `feel_city` VALUES (136, '1', '33', '3', '温州', 'Wenzhou', '');
INSERT INTO `feel_city` VALUES (137, '1', '33', '4', '嘉兴', 'Jiaxing', '');
INSERT INTO `feel_city` VALUES (138, '1', '33', '5', '湖州', 'Huzhou', '');
INSERT INTO `feel_city` VALUES (139, '1', '33', '6', '绍兴', 'Shaoxing', '');
INSERT INTO `feel_city` VALUES (140, '1', '33', '7', '金华', 'Jinhua', '');
INSERT INTO `feel_city` VALUES (141, '1', '33', '8', '衢州', 'Zhangzhou', '');
INSERT INTO `feel_city` VALUES (142, '1', '33', '9', '舟山', 'Zhoushan', '');
INSERT INTO `feel_city` VALUES (143, '1', '33', '10', '台州', 'Taizhou', '');
INSERT INTO `feel_city` VALUES (144, '1', '33', '11', '丽水', 'Lishui', '');
INSERT INTO `feel_city` VALUES (145, '1', '34', '1', '合肥', 'Hefei', '');
INSERT INTO `feel_city` VALUES (146, '1', '34', '2', '芜湖', 'Wuhu', '');
INSERT INTO `feel_city` VALUES (147, '1', '34', '3', '蚌埠', 'Bengbu', '');
INSERT INTO `feel_city` VALUES (148, '1', '34', '4', '淮南', 'Huainan', '');
INSERT INTO `feel_city` VALUES (149, '1', '34', '5', '马鞍山', 'Ma An Shan', '');
INSERT INTO `feel_city` VALUES (150, '1', '34', '6', '淮北', 'Huaibei', '');
INSERT INTO `feel_city` VALUES (151, '1', '34', '7', '铜陵', 'Tongling', '');
INSERT INTO `feel_city` VALUES (152, '1', '34', '8', '安庆', 'Anqing', '');
INSERT INTO `feel_city` VALUES (153, '1', '34', '10', '黄山', 'Huangshan', '');
INSERT INTO `feel_city` VALUES (154, '1', '34', '11', '滁州', 'Zhangzhou', '');
INSERT INTO `feel_city` VALUES (155, '1', '34', '12', '阜阳', 'Fuyang', '');
INSERT INTO `feel_city` VALUES (156, '1', '34', '13', '宿州', 'Suzhou', '');
INSERT INTO `feel_city` VALUES (157, '1', '34', '15', '六安', 'Lu\'an', '');
INSERT INTO `feel_city` VALUES (158, '1', '34', '16', '亳州', 'Zhangzhou', '');
INSERT INTO `feel_city` VALUES (159, '1', '34', '17', '池州', 'Chizhou', '');
INSERT INTO `feel_city` VALUES (160, '1', '34', '18', '宣城', 'Xuancheng', '');
INSERT INTO `feel_city` VALUES (161, '1', '35', '1', '福州', 'Fuzhou', '');
INSERT INTO `feel_city` VALUES (162, '1', '35', '2', '厦门', 'Xiamen', '');
INSERT INTO `feel_city` VALUES (163, '1', '35', '3', '莆田', 'Putian', '');
INSERT INTO `feel_city` VALUES (164, '1', '35', '4', '三明', 'Sanming', '');
INSERT INTO `feel_city` VALUES (165, '1', '35', '5', '泉州', 'Quanzhou', '');
INSERT INTO `feel_city` VALUES (166, '1', '35', '6', '漳州', 'Zhangzhou', '');
INSERT INTO `feel_city` VALUES (167, '1', '35', '7', '南平', 'Nanping', '');
INSERT INTO `feel_city` VALUES (168, '1', '35', '8', '龙岩', 'Longyan', '');
INSERT INTO `feel_city` VALUES (169, '1', '35', '9', '宁德', 'Ningde', '');
INSERT INTO `feel_city` VALUES (170, '1', '36', '1', '南昌', 'Nanchang', '');
INSERT INTO `feel_city` VALUES (171, '1', '36', '2', '景德镇', 'Jingdezhen', '');
INSERT INTO `feel_city` VALUES (172, '1', '36', '3', '萍乡', 'Pingxiang', '');
INSERT INTO `feel_city` VALUES (173, '1', '36', '4', '九江', 'Jiujiang', '');
INSERT INTO `feel_city` VALUES (174, '1', '36', '5', '新余', 'Xinyu', '');
INSERT INTO `feel_city` VALUES (175, '1', '36', '6', '鹰潭', 'Yingtan', '');
INSERT INTO `feel_city` VALUES (176, '1', '36', '7', '赣州', 'Ganzhou', '');
INSERT INTO `feel_city` VALUES (177, '1', '36', '8', '吉安', 'Ji\'an', '');
INSERT INTO `feel_city` VALUES (178, '1', '36', '9', '宜春', 'Yichun', '');
INSERT INTO `feel_city` VALUES (179, '1', '36', '10', '抚州', 'Fuzhou', '');
INSERT INTO `feel_city` VALUES (180, '1', '36', '11', '上饶', 'Shangrao', '');
INSERT INTO `feel_city` VALUES (181, '1', '37', '1', '济南', 'Jinan', '');
INSERT INTO `feel_city` VALUES (182, '1', '37', '2', '青岛', 'Qingdao', '');
INSERT INTO `feel_city` VALUES (183, '1', '37', '3', '淄博', 'Zibo', '');
INSERT INTO `feel_city` VALUES (184, '1', '37', '4', '枣庄', 'Zaozhuang', '');
INSERT INTO `feel_city` VALUES (185, '1', '37', '5', '东营', 'Dongying', '');
INSERT INTO `feel_city` VALUES (186, '1', '37', '6', '烟台', 'Yantai', '');
INSERT INTO `feel_city` VALUES (187, '1', '37', '7', '潍坊', 'Weifang', '');
INSERT INTO `feel_city` VALUES (188, '1', '37', '8', '济宁', 'Jining', '');
INSERT INTO `feel_city` VALUES (189, '1', '37', '9', '泰安', 'Taian', '');
INSERT INTO `feel_city` VALUES (190, '1', '37', '10', '威海', 'Weihai', '');
INSERT INTO `feel_city` VALUES (191, '1', '37', '11', '日照', 'sunshine', '');
INSERT INTO `feel_city` VALUES (192, '1', '37', '12', '莱芜', 'Laiwu', '');
INSERT INTO `feel_city` VALUES (193, '1', '37', '13', '临沂', 'Linyi', '');
INSERT INTO `feel_city` VALUES (194, '1', '37', '14', '德州', 'Texas', '');
INSERT INTO `feel_city` VALUES (195, '1', '37', '15', '聊城', 'Liaocheng', '');
INSERT INTO `feel_city` VALUES (196, '1', '37', '16', '滨州', 'Binzhou', '');
INSERT INTO `feel_city` VALUES (197, '1', '37', '17', '菏泽', 'Heze', '');
INSERT INTO `feel_city` VALUES (198, '1', '41', '1', '郑州', 'Zhengzhou', '');
INSERT INTO `feel_city` VALUES (199, '1', '41', '2', '开封', 'Kaifeng', '');
INSERT INTO `feel_city` VALUES (200, '1', '41', '3', '洛阳', 'Luoyang', '');
INSERT INTO `feel_city` VALUES (201, '1', '41', '4', '平顶山', 'Pingdingshan', '');
INSERT INTO `feel_city` VALUES (202, '1', '41', '5', '安阳', 'Anyang', '');
INSERT INTO `feel_city` VALUES (203, '1', '41', '6', '鹤壁', 'Hebi', '');
INSERT INTO `feel_city` VALUES (204, '1', '41', '7', '新乡', 'Xinxiang', '');
INSERT INTO `feel_city` VALUES (205, '1', '41', '8', '焦作', 'Jiaozuo', '');
INSERT INTO `feel_city` VALUES (206, '1', '41', '9', '濮阳', 'Fuyang', '');
INSERT INTO `feel_city` VALUES (207, '1', '41', '10', '许昌', 'Xu Chang', '');
INSERT INTO `feel_city` VALUES (208, '1', '41', '11', '漯河', 'Luohe', '');
INSERT INTO `feel_city` VALUES (209, '1', '41', '12', '三门峡', 'Sanmenxia', '');
INSERT INTO `feel_city` VALUES (210, '1', '41', '13', '南阳', 'Nanyang', '');
INSERT INTO `feel_city` VALUES (211, '1', '41', '14', '商丘', 'Shangqiu', '');
INSERT INTO `feel_city` VALUES (212, '1', '41', '15', '信阳', 'Xinyang', '');
INSERT INTO `feel_city` VALUES (213, '1', '41', '16', '周口', 'Zhoukou', '');
INSERT INTO `feel_city` VALUES (214, '1', '41', '17', '驻马店', 'Zhumadian', '');
INSERT INTO `feel_city` VALUES (215, '1', '41', '18', '济源', 'Jiyuan', '');
INSERT INTO `feel_city` VALUES (216, '1', '42', '1', '武汉', 'Wuhan', '');
INSERT INTO `feel_city` VALUES (217, '1', '42', '2', '黄石', 'Yellowstone', '');
INSERT INTO `feel_city` VALUES (218, '1', '42', '3', '十堰', 'Shiyan', '');
INSERT INTO `feel_city` VALUES (219, '1', '42', '5', '宜昌', 'Yichang', '');
INSERT INTO `feel_city` VALUES (220, '1', '42', '6', '襄阳', 'Fuyang', '');
INSERT INTO `feel_city` VALUES (221, '1', '42', '7', '鄂州', 'Ezhou', '');
INSERT INTO `feel_city` VALUES (222, '1', '42', '8', '荆门', 'Jingmen', '');
INSERT INTO `feel_city` VALUES (223, '1', '42', '9', '孝感', 'Xiaogan', '');
INSERT INTO `feel_city` VALUES (224, '1', '42', '10', '荆州', 'Jingzhou', '');
INSERT INTO `feel_city` VALUES (225, '1', '42', '11', '黄冈', 'Huanggang', '');
INSERT INTO `feel_city` VALUES (226, '1', '42', '12', '咸宁', 'Xianning', '');
INSERT INTO `feel_city` VALUES (227, '1', '42', '13', '随州', 'Suizhou', '');
INSERT INTO `feel_city` VALUES (228, '1', '42', '28', '恩施', 'Enshi', '');
INSERT INTO `feel_city` VALUES (229, '1', '42', '94', '仙桃', 'Xiantao', '');
INSERT INTO `feel_city` VALUES (230, '1', '42', '95', '潜江', 'Qianjiang', '');
INSERT INTO `feel_city` VALUES (231, '1', '42', '96', '天门', 'Tianmen', '');
INSERT INTO `feel_city` VALUES (232, '1', '42', 'A21', '神农架', 'Shennongjia', '');
INSERT INTO `feel_city` VALUES (233, '1', '43', '1', '长沙', 'Changsha', '');
INSERT INTO `feel_city` VALUES (234, '1', '43', '2', '株洲', 'Zhuzhou', '');
INSERT INTO `feel_city` VALUES (235, '1', '43', '3', '湘潭', 'Xiangtan', '');
INSERT INTO `feel_city` VALUES (236, '1', '43', '4', '衡阳', 'Hengyang', '');
INSERT INTO `feel_city` VALUES (237, '1', '43', '5', '邵阳', 'Shaoyang', '');
INSERT INTO `feel_city` VALUES (238, '1', '43', '6', '岳阳', 'Yue Yang', '');
INSERT INTO `feel_city` VALUES (239, '1', '43', '7', '常德', 'Changde', '');
INSERT INTO `feel_city` VALUES (240, '1', '43', '8', '张家界', 'Zhangjiajie', '');
INSERT INTO `feel_city` VALUES (241, '1', '43', '9', '益阳', 'Yiyang', '');
INSERT INTO `feel_city` VALUES (242, '1', '43', '10', '郴州', 'Zhangzhou', '');
INSERT INTO `feel_city` VALUES (243, '1', '43', '11', '永州', 'Yongzhou', '');
INSERT INTO `feel_city` VALUES (244, '1', '43', '12', '怀化', 'Huaihua', '');
INSERT INTO `feel_city` VALUES (245, '1', '43', '13', '娄底', 'Bottom', '');
INSERT INTO `feel_city` VALUES (246, '1', '43', '31', '湘西', 'Xiangxi', '');
INSERT INTO `feel_city` VALUES (247, '1', '44', '1', '广州', 'Guangzhou', '');
INSERT INTO `feel_city` VALUES (248, '1', '44', '2', '韶关', 'Shaoguan', '');
INSERT INTO `feel_city` VALUES (249, '1', '44', '3', '深圳', 'Shenzhen', '');
INSERT INTO `feel_city` VALUES (250, '1', '44', '4', '珠海', 'Zhuhai', '');
INSERT INTO `feel_city` VALUES (251, '1', '44', '5', '汕头', 'Shantou', '');
INSERT INTO `feel_city` VALUES (252, '1', '44', '6', '佛山', 'Foshan', '');
INSERT INTO `feel_city` VALUES (253, '1', '44', '7', '江门', 'Jiangmen', '');
INSERT INTO `feel_city` VALUES (254, '1', '44', '8', '湛江', 'Zhanjiang', '');
INSERT INTO `feel_city` VALUES (255, '1', '44', '9', '茂名', 'Maoming', '');
INSERT INTO `feel_city` VALUES (256, '1', '44', '12', '肇庆', 'Zhaoqing', '');
INSERT INTO `feel_city` VALUES (257, '1', '44', '13', '惠州', 'Huizhou', '');
INSERT INTO `feel_city` VALUES (258, '1', '44', '14', '梅州', 'Meizhou', '');
INSERT INTO `feel_city` VALUES (259, '1', '44', '15', '汕尾', 'Iris', '');
INSERT INTO `feel_city` VALUES (260, '1', '44', '16', '河源', 'Heyuan', '');
INSERT INTO `feel_city` VALUES (261, '1', '44', '17', '阳江', 'Yangjiang', '');
INSERT INTO `feel_city` VALUES (262, '1', '44', '18', '清远', 'Qingyuan', '');
INSERT INTO `feel_city` VALUES (263, '1', '44', '19', '东莞', 'Dongguan', '');
INSERT INTO `feel_city` VALUES (264, '1', '44', '20', '中山', 'Zhongshan', '');
INSERT INTO `feel_city` VALUES (265, '1', '44', '51', '潮州', 'Chaozhou', '');
INSERT INTO `feel_city` VALUES (266, '1', '44', '52', '揭阳', 'Jieyang', '');
INSERT INTO `feel_city` VALUES (267, '1', '44', '53', '云浮', 'Yunfu', '');
INSERT INTO `feel_city` VALUES (268, '1', '45', '1', '南宁', 'Nanning', '');
INSERT INTO `feel_city` VALUES (269, '1', '45', '2', '柳州', 'Liuzhou', '');
INSERT INTO `feel_city` VALUES (270, '1', '45', '3', '桂林', 'Guilin', '');
INSERT INTO `feel_city` VALUES (271, '1', '45', '4', '梧州', 'Zhangzhou', '');
INSERT INTO `feel_city` VALUES (272, '1', '45', '5', '北海', 'North Sea', '');
INSERT INTO `feel_city` VALUES (273, '1', '45', '6', '防城港', 'Fangchenggang', '');
INSERT INTO `feel_city` VALUES (274, '1', '45', '7', '钦州', 'Qinzhou', '');
INSERT INTO `feel_city` VALUES (275, '1', '45', '8', '贵港', 'Guigang', '');
INSERT INTO `feel_city` VALUES (276, '1', '45', '9', '玉林', 'Yulin', '');
INSERT INTO `feel_city` VALUES (277, '1', '45', '10', '百色', 'Baise', '');
INSERT INTO `feel_city` VALUES (278, '1', '45', '11', '贺州', 'Hezhou', '');
INSERT INTO `feel_city` VALUES (279, '1', '45', '12', '河池', 'Hechi', '');
INSERT INTO `feel_city` VALUES (280, '1', '45', '13', '来宾', 'guest', '');
INSERT INTO `feel_city` VALUES (281, '1', '45', '14', '崇左', 'Chongzuo', '');
INSERT INTO `feel_city` VALUES (282, '1', '46', '1', '海口', 'Haikou', '');
INSERT INTO `feel_city` VALUES (283, '1', '46', '2', '三亚', 'Sanya', '');
INSERT INTO `feel_city` VALUES (284, '1', '46', '3', '三沙', 'Sansha', '');
INSERT INTO `feel_city` VALUES (285, '1', '46', '91', '五指山', 'Wuzhishan', '');
INSERT INTO `feel_city` VALUES (286, '1', '46', '92', '琼海', 'Qiong Hai', '');
INSERT INTO `feel_city` VALUES (287, '1', '46', '93', '儋州', 'Zhangzhou', '');
INSERT INTO `feel_city` VALUES (288, '1', '46', '95', '文昌', 'Wenchang', '');
INSERT INTO `feel_city` VALUES (289, '1', '46', '96', '万宁', 'Wanning', '');
INSERT INTO `feel_city` VALUES (290, '1', '46', '97', '东方', 'East', '');
INSERT INTO `feel_city` VALUES (291, '1', '46', 'A25', '定安', 'Ding\'an', '');
INSERT INTO `feel_city` VALUES (292, '1', '46', 'A26', '屯昌', 'Suichang', '');
INSERT INTO `feel_city` VALUES (293, '1', '46', 'A27', '澄迈', 'Chengmai', '');
INSERT INTO `feel_city` VALUES (294, '1', '46', 'A28', '临高', 'Lingao', '');
INSERT INTO `feel_city` VALUES (295, '1', '46', 'A30', '白沙', 'White sand', '');
INSERT INTO `feel_city` VALUES (296, '1', '46', 'A31', '昌江', 'Changjiang', '');
INSERT INTO `feel_city` VALUES (297, '1', '46', 'A33', '乐东', 'Ledong', '');
INSERT INTO `feel_city` VALUES (298, '1', '46', 'A34', '陵水', 'Lingshui', '');
INSERT INTO `feel_city` VALUES (299, '1', '46', 'A35', '保亭', 'Baoting', '');
INSERT INTO `feel_city` VALUES (300, '1', '46', 'A36', '琼中', 'Qiongzhong', '');
INSERT INTO `feel_city` VALUES (301, '1', '50', '1', '万州', 'Wanzhou', '');
INSERT INTO `feel_city` VALUES (302, '1', '50', '2', '涪陵', 'Fuling', '');
INSERT INTO `feel_city` VALUES (303, '1', '50', '3', '渝中', 'Yuzhong', '');
INSERT INTO `feel_city` VALUES (304, '1', '50', '4', '大渡口', 'Dadukou', '');
INSERT INTO `feel_city` VALUES (305, '1', '50', '5', '江北', 'Jiangbei', '');
INSERT INTO `feel_city` VALUES (306, '1', '50', '6', '沙坪坝', 'Shapingba', '');
INSERT INTO `feel_city` VALUES (307, '1', '50', '7', '九龙坡', 'Jiulongpo', '');
INSERT INTO `feel_city` VALUES (308, '1', '50', '8', '南岸', 'South bank', '');
INSERT INTO `feel_city` VALUES (309, '1', '50', '9', '北碚', 'Beibei', '');
INSERT INTO `feel_city` VALUES (310, '1', '50', '85', '两江新区', 'Liangjiang New District', '');
INSERT INTO `feel_city` VALUES (311, '1', '50', '10', '万盛', 'Wansheng', '');
INSERT INTO `feel_city` VALUES (312, '1', '50', '11', '双桥', 'Double bridge', '');
INSERT INTO `feel_city` VALUES (313, '1', '50', '12', '渝北', 'Yubei', '');
INSERT INTO `feel_city` VALUES (314, '1', '50', '13', '巴南', 'Banan', '');
INSERT INTO `feel_city` VALUES (315, '1', '50', '21', '长寿', 'longevity', '');
INSERT INTO `feel_city` VALUES (316, '1', '50', '22', '綦江', 'Lijiang', '');
INSERT INTO `feel_city` VALUES (317, '1', '50', '23', '潼南', 'Weinan', '');
INSERT INTO `feel_city` VALUES (318, '1', '50', '24', '铜梁', 'Copper beam', '');
INSERT INTO `feel_city` VALUES (319, '1', '50', '25', '大足', 'Bigfoot', '');
INSERT INTO `feel_city` VALUES (320, '1', '50', '26', '荣昌', 'Rongchang', '');
INSERT INTO `feel_city` VALUES (321, '1', '50', '27', '璧山', 'Lushan', '');
INSERT INTO `feel_city` VALUES (322, '1', '50', '28', '梁平', 'Liang Ping', '');
INSERT INTO `feel_city` VALUES (323, '1', '50', '29', '城口', 'Chengkou', '');
INSERT INTO `feel_city` VALUES (324, '1', '50', '30', '丰都', 'Fengdu', '');
INSERT INTO `feel_city` VALUES (325, '1', '50', '31', '垫江', 'Dianjiang', '');
INSERT INTO `feel_city` VALUES (326, '1', '50', '32', '武隆', 'Wulong', '');
INSERT INTO `feel_city` VALUES (327, '1', '50', '33', '忠县', 'Zhongxian County', '');
INSERT INTO `feel_city` VALUES (328, '1', '50', '34', '开县', 'Kai County', '');
INSERT INTO `feel_city` VALUES (329, '1', '50', '35', '云阳', 'Yunyang', '');
INSERT INTO `feel_city` VALUES (330, '1', '50', '36', '奉节', 'Fengjie', '');
INSERT INTO `feel_city` VALUES (331, '1', '50', '37', '巫山', 'Wushan', '');
INSERT INTO `feel_city` VALUES (332, '1', '50', '38', '巫溪', 'Wuxi', '');
INSERT INTO `feel_city` VALUES (333, '1', '50', '39', '黔江', 'Lijiang', '');
INSERT INTO `feel_city` VALUES (334, '1', '50', '40', '石柱', 'Stone pillar', '');
INSERT INTO `feel_city` VALUES (335, '1', '50', '41', '秀山', 'Xiushan', '');
INSERT INTO `feel_city` VALUES (336, '1', '50', '42', '酉阳', 'Fuyang', '');
INSERT INTO `feel_city` VALUES (337, '1', '50', '43', '彭水', 'Peng Shui', '');
INSERT INTO `feel_city` VALUES (338, '1', '50', '81', '江津', 'Jiangjin', '');
INSERT INTO `feel_city` VALUES (339, '1', '50', '82', '合川', 'Hechuan', '');
INSERT INTO `feel_city` VALUES (340, '1', '50', '83', '永川', 'Yongchuan', '');
INSERT INTO `feel_city` VALUES (341, '1', '50', '84', '南川', 'Nanchuan', '');
INSERT INTO `feel_city` VALUES (342, '1', '51', '1', '成都', 'Chengdu', '');
INSERT INTO `feel_city` VALUES (343, '1', '51', '3', '自贡', 'Zigong', '');
INSERT INTO `feel_city` VALUES (344, '1', '51', '4', '攀枝花', 'Panzhihua', '');
INSERT INTO `feel_city` VALUES (345, '1', '51', '5', '泸州', 'Luzhou', '');
INSERT INTO `feel_city` VALUES (346, '1', '51', '6', '德阳', 'Deyang', '');
INSERT INTO `feel_city` VALUES (347, '1', '51', '7', '绵阳', 'Mianyang', '');
INSERT INTO `feel_city` VALUES (348, '1', '51', '8', '广元', 'Guangyuan', '');
INSERT INTO `feel_city` VALUES (349, '1', '51', '9', '遂宁', 'Suining', '');
INSERT INTO `feel_city` VALUES (350, '1', '51', '10', '内江', 'Neijiang', '');
INSERT INTO `feel_city` VALUES (351, '1', '51', '11', '乐山', 'Leshan', '');
INSERT INTO `feel_city` VALUES (352, '1', '51', '13', '南充', 'Nanchong', '');
INSERT INTO `feel_city` VALUES (353, '1', '51', '14', '眉山', 'Meishan', '');
INSERT INTO `feel_city` VALUES (354, '1', '51', '15', '宜宾', 'Yibin', '');
INSERT INTO `feel_city` VALUES (355, '1', '51', '16', '广安', 'Guang\'an', '');
INSERT INTO `feel_city` VALUES (356, '1', '51', '17', '达州', 'Dazhou', '');
INSERT INTO `feel_city` VALUES (357, '1', '51', '18', '雅安', 'Yaan', '');
INSERT INTO `feel_city` VALUES (358, '1', '51', '19', '巴中', 'Bazhong', '');
INSERT INTO `feel_city` VALUES (359, '1', '51', '20', '资阳', 'Ziyang', '');
INSERT INTO `feel_city` VALUES (360, '1', '51', '32', '阿坝', 'Aba', '');
INSERT INTO `feel_city` VALUES (361, '1', '51', '33', '甘孜', 'Ganzi', '');
INSERT INTO `feel_city` VALUES (362, '1', '51', '34', '凉山', 'Liangshan', '');
INSERT INTO `feel_city` VALUES (363, '1', '52', '1', '贵阳', 'Guiyang', '');
INSERT INTO `feel_city` VALUES (364, '1', '52', '2', '六盘水', 'Liupanshui', '');
INSERT INTO `feel_city` VALUES (365, '1', '52', '3', '遵义', 'Zunyi', '');
INSERT INTO `feel_city` VALUES (366, '1', '52', '4', '安顺', 'Anshun', '');
INSERT INTO `feel_city` VALUES (367, '1', '52', '22', '铜仁', 'Tongren', '');
INSERT INTO `feel_city` VALUES (368, '1', '52', '23', '黔西南', 'Southwestern Guizhou', '');
INSERT INTO `feel_city` VALUES (369, '1', '52', '24', '毕节', 'Bijie', '');
INSERT INTO `feel_city` VALUES (370, '1', '52', '26', '黔东南', 'Southeastern Guizhou', '');
INSERT INTO `feel_city` VALUES (371, '1', '52', '27', '黔南', 'Weinan', '');
INSERT INTO `feel_city` VALUES (372, '1', '53', '1', '昆明', 'Kunming', '');
INSERT INTO `feel_city` VALUES (373, '1', '53', '3', '曲靖', 'Qujing', '');
INSERT INTO `feel_city` VALUES (374, '1', '53', '4', '玉溪', 'Yuxi', '');
INSERT INTO `feel_city` VALUES (375, '1', '53', '5', '保山', 'Baoshan', '');
INSERT INTO `feel_city` VALUES (376, '1', '53', '6', '昭通', 'Zhaotong', '');
INSERT INTO `feel_city` VALUES (377, '1', '53', '7', '丽江', 'Lijiang', '');
INSERT INTO `feel_city` VALUES (378, '1', '53', '8', '普洱', 'Pu\'er', '');
INSERT INTO `feel_city` VALUES (379, '1', '53', '9', '临沧', 'Linyi', '');
INSERT INTO `feel_city` VALUES (380, '1', '53', '23', '楚雄', 'Chuxiong', '');
INSERT INTO `feel_city` VALUES (381, '1', '53', '25', '红河', 'Red river', '');
INSERT INTO `feel_city` VALUES (382, '1', '53', '26', '文山', 'Wenshan', '');
INSERT INTO `feel_city` VALUES (383, '1', '53', '28', '西双版纳', 'Xishuangbanna', '');
INSERT INTO `feel_city` VALUES (384, '1', '53', '29', '大理', 'Dali', '');
INSERT INTO `feel_city` VALUES (385, '1', '53', '31', '德宏', 'Dehong', '');
INSERT INTO `feel_city` VALUES (386, '1', '53', '33', '怒江', 'Nujiang', '');
INSERT INTO `feel_city` VALUES (387, '1', '53', '34', '迪庆', 'Diqing', '');
INSERT INTO `feel_city` VALUES (388, '1', '54', '1', '拉萨', 'Lhasa', '');
INSERT INTO `feel_city` VALUES (389, '1', '54', '21', '昌都', 'Changdu', '');
INSERT INTO `feel_city` VALUES (390, '1', '54', '22', '山南', 'Shannan', '');
INSERT INTO `feel_city` VALUES (391, '1', '54', '23', '日喀则', 'Shigatse', '');
INSERT INTO `feel_city` VALUES (392, '1', '54', '24', '那曲', 'Nagqu', '');
INSERT INTO `feel_city` VALUES (393, '1', '54', '25', '阿里', 'Ali', '');
INSERT INTO `feel_city` VALUES (394, '1', '54', '26', '林芝', 'Lin Zhi', '');
INSERT INTO `feel_city` VALUES (395, '1', '61', '1', '西安', 'Xi\'an', '');
INSERT INTO `feel_city` VALUES (396, '1', '61', '2', '铜川', 'Tongchuan', '');
INSERT INTO `feel_city` VALUES (397, '1', '61', '3', '宝鸡', 'Baoji', '');
INSERT INTO `feel_city` VALUES (398, '1', '61', '4', '咸阳', 'Xianyang', '');
INSERT INTO `feel_city` VALUES (399, '1', '61', '5', '渭南', 'Weinan', '');
INSERT INTO `feel_city` VALUES (400, '1', '61', '6', '延安', 'Yan\'an', '');
INSERT INTO `feel_city` VALUES (401, '1', '61', '7', '汉中', 'Hanzhong', '');
INSERT INTO `feel_city` VALUES (402, '1', '61', '8', '榆林', 'Yulin', '');
INSERT INTO `feel_city` VALUES (403, '1', '61', '9', '安康', 'Ankang', '');
INSERT INTO `feel_city` VALUES (404, '1', '61', '10', '商洛', 'Shangluo', '');
INSERT INTO `feel_city` VALUES (405, '1', '62', '1', '兰州市', 'Lan\'Zhou City', '');
INSERT INTO `feel_city` VALUES (406, '1', '62', '2', '嘉峪关', 'Jiayuguan', '');
INSERT INTO `feel_city` VALUES (407, '1', '62', '3', '金昌', 'Jinchang', '');
INSERT INTO `feel_city` VALUES (408, '1', '62', '4', '白银', 'silver', '');
INSERT INTO `feel_city` VALUES (409, '1', '62', '5', '天水', 'Tianshui', '');
INSERT INTO `feel_city` VALUES (410, '1', '62', '6', '武威', 'Wuwei', '');
INSERT INTO `feel_city` VALUES (411, '1', '62', '7', '张掖', 'Zhang Wei', '');
INSERT INTO `feel_city` VALUES (412, '1', '62', '8', '平凉', 'Pingliang', '');
INSERT INTO `feel_city` VALUES (413, '1', '62', '9', '酒泉', 'Jiuquan', '');
INSERT INTO `feel_city` VALUES (414, '1', '62', '10', '庆阳', 'Qingyang', '');
INSERT INTO `feel_city` VALUES (415, '1', '62', '11', '定西', 'Dingxi', '');
INSERT INTO `feel_city` VALUES (416, '1', '62', '12', '陇南', 'Weinan', '');
INSERT INTO `feel_city` VALUES (417, '1', '62', '29', '临夏', 'Linxia', '');
INSERT INTO `feel_city` VALUES (418, '1', '62', '30', '甘南', 'Gannan', '');
INSERT INTO `feel_city` VALUES (419, '1', '63', '1', '西宁', 'Xining', '');
INSERT INTO `feel_city` VALUES (420, '1', '63', '21', '海东', 'Haidong', '');
INSERT INTO `feel_city` VALUES (421, '1', '63', '22', '海北', 'Haibei', '');
INSERT INTO `feel_city` VALUES (422, '1', '63', '23', '黄南', 'Huang Nan', '');
INSERT INTO `feel_city` VALUES (423, '1', '63', '25', '海南', 'Hainan', '');
INSERT INTO `feel_city` VALUES (424, '1', '63', '26', '果洛', 'Guoluo', '');
INSERT INTO `feel_city` VALUES (425, '1', '63', '27', '玉树', 'Yushu', '');
INSERT INTO `feel_city` VALUES (426, '1', '63', '28', '海西', 'Haixi', '');
INSERT INTO `feel_city` VALUES (427, '1', '64', '1', '银川', 'Yinchuan', '');
INSERT INTO `feel_city` VALUES (428, '1', '64', '2', '石嘴山', 'Shizuishan', '');
INSERT INTO `feel_city` VALUES (429, '1', '64', '3', '吴忠', 'Wu Zhong', '');
INSERT INTO `feel_city` VALUES (430, '1', '64', '4', '固原', 'Guyuan', '');
INSERT INTO `feel_city` VALUES (431, '1', '64', '5', '中卫', 'Zhongwei', '');
INSERT INTO `feel_city` VALUES (432, '1', '65', '1', '乌鲁木齐', 'Urumqi', '');
INSERT INTO `feel_city` VALUES (433, '1', '65', '2', '克拉玛依', 'Karamay', '');
INSERT INTO `feel_city` VALUES (434, '1', '65', '21', '吐鲁番', 'Turpan', '');
INSERT INTO `feel_city` VALUES (435, '1', '65', '22', '哈密', 'Hami', '');
INSERT INTO `feel_city` VALUES (436, '1', '65', '23', '昌吉', 'Changji', '');
INSERT INTO `feel_city` VALUES (437, '1', '65', '27', '博尔塔拉', 'Bortala', '');
INSERT INTO `feel_city` VALUES (438, '1', '65', '28', '巴音郭楞', 'Bayin Guoyu', '');
INSERT INTO `feel_city` VALUES (439, '1', '65', '29', '阿克苏', 'Aksu', '');
INSERT INTO `feel_city` VALUES (440, '1', '65', '30', '克孜勒苏', 'Kyzler', '');
INSERT INTO `feel_city` VALUES (441, '1', '65', '31', '喀什', 'Kashgar', '');
INSERT INTO `feel_city` VALUES (442, '1', '65', '32', '和田', 'Hetian', '');
INSERT INTO `feel_city` VALUES (443, '1', '65', '40', '伊犁', 'Yili', '');
INSERT INTO `feel_city` VALUES (444, '1', '65', '42', '塔城', 'Tacheng', '');
INSERT INTO `feel_city` VALUES (445, '1', '65', '43', '阿勒泰', 'Altay', '');
INSERT INTO `feel_city` VALUES (446, '1', '65', '91', '石河子', 'Shihezi', '');
INSERT INTO `feel_city` VALUES (447, '1', '65', '92', '阿拉尔', 'Alar', '');
INSERT INTO `feel_city` VALUES (448, '1', '65', '93', '图木舒克', 'Tumushuk', '');
INSERT INTO `feel_city` VALUES (449, '1', '65', '94', '五家渠', 'Wujiaqu', '');
INSERT INTO `feel_city` VALUES (450, '1', '65', '95', '北屯', 'Beibei', '');
INSERT INTO `feel_city` VALUES (451, '1', '71', '1', '台北市', 'Taipei City', '');
INSERT INTO `feel_city` VALUES (452, '1', '71', '2', '高雄市', 'Kaohsiung City', '');
INSERT INTO `feel_city` VALUES (453, '1', '71', '3', '基隆市', 'Keelung City', '');
INSERT INTO `feel_city` VALUES (454, '1', '71', '4', '台中市', 'Taichung City', '');
INSERT INTO `feel_city` VALUES (455, '1', '71', '5', '台南市', 'Tainan City', '');
INSERT INTO `feel_city` VALUES (456, '1', '71', '6', '新竹市', 'Hsinchu City', '');
INSERT INTO `feel_city` VALUES (457, '1', '71', '7', '嘉义市', 'Chiayi City', '');
INSERT INTO `feel_city` VALUES (458, '1', '71', '8', '台北县', 'Taipei County', '');
INSERT INTO `feel_city` VALUES (459, '1', '71', '9', '宜兰县', 'Yilan County', '');
INSERT INTO `feel_city` VALUES (460, '1', '71', '10', '桃园县', 'Taoyuan County', '');
INSERT INTO `feel_city` VALUES (461, '1', '71', '11', '新竹县', 'Hsinchu County', '');
INSERT INTO `feel_city` VALUES (462, '1', '71', '12', '苗栗县', 'Miaoli County', '');
INSERT INTO `feel_city` VALUES (463, '1', '71', '13', '台中县', 'Taichung County', '');
INSERT INTO `feel_city` VALUES (464, '1', '71', '14', '彰化县', 'Changhua County', '');
INSERT INTO `feel_city` VALUES (465, '1', '71', '15', '南投县', 'Nantou County', '');
INSERT INTO `feel_city` VALUES (466, '1', '71', '16', '云林县', 'Yunlin County', '');
INSERT INTO `feel_city` VALUES (467, '1', '71', '17', '嘉义县', 'Chiayi County', '');
INSERT INTO `feel_city` VALUES (468, '1', '71', '18', '台南县', 'Tainan County', '');
INSERT INTO `feel_city` VALUES (469, '1', '71', '19', '高雄县', 'Kaohsiung County', '');
INSERT INTO `feel_city` VALUES (470, '1', '71', '20', '屏东县', 'Pingtung County', '');
INSERT INTO `feel_city` VALUES (471, '1', '71', '22', '台东县', 'Taitung County', '');
INSERT INTO `feel_city` VALUES (472, '1', '71', '23', '花莲县', 'Hualien County', '');
INSERT INTO `feel_city` VALUES (473, '1', '71', '21', '澎湖县', 'Wuhu County', '');
INSERT INTO `feel_city` VALUES (474, '1', '81', 'HCW', '中西区', 'Central and Western District', '');
INSERT INTO `feel_city` VALUES (475, '1', '81', 'HEA', '东区', 'Eastern District', '');
INSERT INTO `feel_city` VALUES (476, '1', '81', 'KKC', '九龙城区', 'Kowloon City District', '');
INSERT INTO `feel_city` VALUES (477, '1', '81', 'KKT', '观塘区', 'Kwun Tong District', '');
INSERT INTO `feel_city` VALUES (478, '1', '81', 'HSO', '南区', 'South area', '');
INSERT INTO `feel_city` VALUES (479, '1', '81', 'KSS', '深水埗区', 'Sham Shui Po District', '');
INSERT INTO `feel_city` VALUES (480, '1', '81', 'KWT', '黄大仙区', 'Wong Tai Sin District', '');
INSERT INTO `feel_city` VALUES (481, '1', '81', 'HWC', '湾仔区', 'Wan Chai District', '');
INSERT INTO `feel_city` VALUES (482, '1', '81', 'KYT', '油尖旺区', 'Yau Tsim Mong District', '');
INSERT INTO `feel_city` VALUES (483, '1', '81', 'NIS', '离岛区', 'Islands District', '');
INSERT INTO `feel_city` VALUES (484, '1', '81', 'NKT', '葵青区', 'Kwai Tsing District', '');
INSERT INTO `feel_city` VALUES (485, '1', '81', 'NNO', '北区', 'North District', '');
INSERT INTO `feel_city` VALUES (486, '1', '81', 'NSK', '西贡区', 'Sai Kung District', '');
INSERT INTO `feel_city` VALUES (487, '1', '81', 'NST', '沙田区', 'Sha Tin District', '');
INSERT INTO `feel_city` VALUES (488, '1', '81', 'NTM', '屯门区', 'Tuen Mun District', '');
INSERT INTO `feel_city` VALUES (489, '1', '81', 'NTP', '大埔区', 'Tai Po District', '');
INSERT INTO `feel_city` VALUES (490, '1', '81', 'NTW', '荃湾区', 'Liwan District', '');
INSERT INTO `feel_city` VALUES (491, '1', '81', 'NYL', '元朗区', 'Yuen Long District', '');
INSERT INTO `feel_city` VALUES (492, '1', '82', 'OLF', '花地玛堂区', 'Huadi Matang District', '');
INSERT INTO `feel_city` VALUES (493, '1', '82', 'ANT', '圣安多尼堂区', 'St. Anthony\'s Church', '');
INSERT INTO `feel_city` VALUES (494, '1', '82', 'CAT', '大堂区', 'Lobby area', '');
INSERT INTO `feel_city` VALUES (495, '1', '82', 'LAW', '望德堂区', 'Wangdetang District', '');
INSERT INTO `feel_city` VALUES (496, '1', '82', 'LAZ', '风顺堂区', 'Fengshuntang District', '');
INSERT INTO `feel_city` VALUES (497, '1', '82', 'TPA', '氹仔', 'Taipa', '');
INSERT INTO `feel_city` VALUES (498, '1', '82', 'CLN', '路环', 'Road ring', '');
INSERT INTO `feel_city` VALUES (499, 'AUS', 'NT', 'PAL', '北帕默斯顿', 'Palmerston North', '');
INSERT INTO `feel_city` VALUES (500, 'AUS', 'NT', 'DRW', '达尔文', 'Darwin', '');
INSERT INTO `feel_city` VALUES (501, 'AUS', 'ACT', 'CBR', '堪培拉', 'Canberra', '');
INSERT INTO `feel_city` VALUES (502, 'AUS', 'QLD', 'BNE', '布里斯班', 'Brisbane', '');
INSERT INTO `feel_city` VALUES (503, 'AUS', 'QLD', 'OOL', '黄金海岸', 'Gold Coast', '');
INSERT INTO `feel_city` VALUES (504, 'AUS', 'QLD', 'CNS', '凯恩斯', 'Cairns', '');
INSERT INTO `feel_city` VALUES (505, 'AUS', 'QLD', 'CUD', '日光海岸', 'Sun Coast', '');
INSERT INTO `feel_city` VALUES (506, 'AUS', 'QLD', 'TSV', '汤斯维尔', 'Townsville', '');
INSERT INTO `feel_city` VALUES (507, 'AUS', 'QLD', 'TWB', '图文巴', 'Toowoomba', '');
INSERT INTO `feel_city` VALUES (508, 'AUS', 'SA', 'ADL', '阿德莱德', 'Adelaide', '');
INSERT INTO `feel_city` VALUES (509, 'AUS', 'SA', 'PUG', '奥古斯塔港', 'Port Augusta', '');
INSERT INTO `feel_city` VALUES (510, 'AUS', 'SA', 'MGB', '甘比亚山', 'Mount Gambia', '');
INSERT INTO `feel_city` VALUES (511, 'AUS', 'SA', 'WAY', '怀阿拉', 'Huaila', '');
INSERT INTO `feel_city` VALUES (512, 'AUS', 'SA', 'PLO', '林肯港', 'Port Lincoln', '');
INSERT INTO `feel_city` VALUES (513, 'AUS', 'SA', 'MYB', '默里布里奇', 'Murray Bridge', '');
INSERT INTO `feel_city` VALUES (514, 'AUS', 'SA', 'PPI', '皮里港', 'Port of Piri', '');
INSERT INTO `feel_city` VALUES (515, 'AUS', 'SA', 'VHA', '维克托港', 'Port of Victor', '');
INSERT INTO `feel_city` VALUES (516, 'AUS', 'TAS', 'BWT', '伯尼港', 'Port of Berne', '');
INSERT INTO `feel_city` VALUES (517, 'AUS', 'TAS', 'DPO', '德文波特', 'Devonport', '');
INSERT INTO `feel_city` VALUES (518, 'AUS', 'TAS', 'HBA', '霍巴特', 'Hobart', '');
INSERT INTO `feel_city` VALUES (519, 'AUS', 'TAS', 'LST', '朗塞斯顿', 'Launceston', '');
INSERT INTO `feel_city` VALUES (520, 'AUS', 'VIC', 'GEX', '吉朗', 'Geelong', '');
INSERT INTO `feel_city` VALUES (521, 'AUS', 'VIC', 'MEL', '墨尔本', 'Melbourne', '');
INSERT INTO `feel_city` VALUES (522, 'AUS', 'WA', 'ALH', '奥尔巴尼', 'Albany', '');
INSERT INTO `feel_city` VALUES (523, 'AUS', 'WA', 'BUY', '班伯里', 'Banbury', '');
INSERT INTO `feel_city` VALUES (524, 'AUS', 'WA', 'FRE', '弗里曼特尔港', 'Port of Fremantle', '');
INSERT INTO `feel_city` VALUES (525, 'AUS', 'WA', 'GET', '杰拉尔顿', 'Geraldton', '');
INSERT INTO `feel_city` VALUES (526, 'AUS', 'WA', 'KGI', '卡尔古利', 'Kalgoli', '');
INSERT INTO `feel_city` VALUES (527, 'AUS', 'WA', 'MDU', '曼哲拉', 'Manzella', '');
INSERT INTO `feel_city` VALUES (528, 'AUS', 'WA', 'PER', '珀斯', 'Perth', '');
INSERT INTO `feel_city` VALUES (529, 'AUS', 'NSW', 'NTL', '纽卡斯尔', 'Newcastle', '');
INSERT INTO `feel_city` VALUES (530, 'AUS', 'NSW', 'WOL', '伍伦贡', 'Wollongong', '');
INSERT INTO `feel_city` VALUES (531, 'AUS', 'NSW', 'HBS', '悉尼', 'Sydney', '');
INSERT INTO `feel_city` VALUES (532, 'KOR', '27', 'DSG', '达城郡', 'Dacheng County', '');
INSERT INTO `feel_city` VALUES (533, 'KOR', '27', 'TAE', '大邱', 'Daegu', '');
INSERT INTO `feel_city` VALUES (534, 'KOR', '27', 'SUS', '寿城区', 'Shoucheng District', '');
INSERT INTO `feel_city` VALUES (535, 'KOR', '42', 'CHC', '春川市', 'Chuncheon City', '');
INSERT INTO `feel_city` VALUES (536, 'KOR', '42', 'TGH', '东海市', 'Donghae City', '');
INSERT INTO `feel_city` VALUES (537, 'KOR', '42', 'GSG', '高城郡', 'Takagi-gun', '');
INSERT INTO `feel_city` VALUES (538, 'KOR', '42', 'HSG', '横城郡', 'Hengcheng County', '');
INSERT INTO `feel_city` VALUES (539, 'KOR', '42', 'HCN', '洪川郡', 'Hongchuan County', '');
INSERT INTO `feel_city` VALUES (540, 'KOR', '42', 'HCH', '华川郡', 'Huachuan County', '');
INSERT INTO `feel_city` VALUES (541, 'KOR', '42', 'KAG', '江陵市', 'Gangneung City', '');
INSERT INTO `feel_city` VALUES (542, 'KOR', '42', 'JSE', '旌善郡', 'Shanshan County', '');
INSERT INTO `feel_city` VALUES (543, 'KOR', '42', 'IJE', '麟蹄郡', 'Junho County', '');
INSERT INTO `feel_city` VALUES (544, 'KOR', '42', 'YWL', '宁越郡', 'Ning Yue County', '');
INSERT INTO `feel_city` VALUES (545, 'KOR', '42', 'POG', '平昌郡', 'Pyeongchang County', '');
INSERT INTO `feel_city` VALUES (546, 'KOR', '42', 'SUK', '三陟市', 'San Francisco', '');
INSERT INTO `feel_city` VALUES (547, 'KOR', '42', 'SHO', '束草市', 'Sokcho', '');
INSERT INTO `feel_city` VALUES (548, 'KOR', '42', 'TBK', '太白市', 'Taibai City', '');
INSERT INTO `feel_city` VALUES (549, 'KOR', '42', 'CWN', '铁原郡', 'Tiehara County', '');
INSERT INTO `feel_city` VALUES (550, 'KOR', '42', 'YNY', '襄阳郡', 'Yangyang County', '');
INSERT INTO `feel_city` VALUES (551, 'KOR', '42', 'YGU', '杨口郡', 'Yangkou County', '');
INSERT INTO `feel_city` VALUES (552, 'KOR', '42', 'WJU', '原州市', 'Wonju', '');
INSERT INTO `feel_city` VALUES (553, 'KOR', '49', 'ASG', '安城市', 'Anjo', '');
INSERT INTO `feel_city` VALUES (554, 'KOR', '49', 'ASN', '安山市', 'Ansan City', '');
INSERT INTO `feel_city` VALUES (555, 'KOR', '49', 'ANY', '安养市', 'Anyang City', '');
INSERT INTO `feel_city` VALUES (556, 'KOR', '49', 'POC', '抱川市', 'Yukawa', '');
INSERT INTO `feel_city` VALUES (557, 'KOR', '49', 'SEO', '城南市', 'Seongnam City', '');
INSERT INTO `feel_city` VALUES (558, 'KOR', '49', 'DDC', '东豆川市', 'Dongducheon City', '');
INSERT INTO `feel_city` VALUES (559, 'KOR', '49', 'BCN', '富川市', 'Bucheon City', '');
INSERT INTO `feel_city` VALUES (560, 'KOR', '49', 'GYG', '高阳市', 'Goyang City', '');
INSERT INTO `feel_city` VALUES (561, 'KOR', '49', 'GMG', '光明市', 'Guangming City', '');
INSERT INTO `feel_city` VALUES (562, 'KOR', '49', 'KWU', '广州市', 'Guangzhou City', '');
INSERT INTO `feel_city` VALUES (563, 'KOR', '49', 'GCN', '果川市', 'Gwacheon City', '');
INSERT INTO `feel_city` VALUES (564, 'KOR', '49', 'HNM', '河南市', 'Henan', '');
INSERT INTO `feel_city` VALUES (565, 'KOR', '49', 'HCH', '华城市', 'Huacheng', '');
INSERT INTO `feel_city` VALUES (566, 'KOR', '49', 'GPG', '加平郡', 'Gapyeong-gun', '');
INSERT INTO `feel_city` VALUES (567, 'KOR', '49', 'GMP', '金浦市', 'Gimpo City', '');
INSERT INTO `feel_city` VALUES (568, 'KOR', '49', 'GRI', '九里市', 'Jiuli City', '');
INSERT INTO `feel_city` VALUES (569, 'KOR', '49', 'GUN', '军浦市', 'Gunpo City', '');
INSERT INTO `feel_city` VALUES (570, 'KOR', '49', 'YJU', '骊州郡', 'Zhangzhou County', '');
INSERT INTO `feel_city` VALUES (571, 'KOR', '49', 'ICE', '利川市', 'Icheon City', '');
INSERT INTO `feel_city` VALUES (572, 'KOR', '49', 'YCN', '涟川郡', 'Luanchuan County', '');
INSERT INTO `feel_city` VALUES (573, 'KOR', '49', 'YNG', '龙仁市', 'Yongin City', '');
INSERT INTO `feel_city` VALUES (574, 'KOR', '49', 'NYU', '南杨州市', 'Nanyang City', '');
INSERT INTO `feel_city` VALUES (575, 'KOR', '49', 'PTK', '平泽市', 'Pyeongtaek City', '');
INSERT INTO `feel_city` VALUES (576, 'KOR', '49', 'PJU', '坡州市', 'Paju City', '');
INSERT INTO `feel_city` VALUES (577, 'KOR', '49', 'SHE', '始兴市', 'Shixing City', '');
INSERT INTO `feel_city` VALUES (578, 'KOR', '49', 'SUO', '水原市', 'Suwon City', '');
INSERT INTO `feel_city` VALUES (579, 'KOR', '49', 'OSN', '乌山市', 'Wushan City', '');
INSERT INTO `feel_city` VALUES (580, 'KOR', '49', 'YPG', '扬平郡', 'Yangpyeong-gun', '');
INSERT INTO `feel_city` VALUES (581, 'KOR', '49', 'YYU', '杨州市', 'Yangzhou City', '');
INSERT INTO `feel_city` VALUES (582, 'KOR', '49', 'UWN', '仪旺市', 'Yiwang City', '');
INSERT INTO `feel_city` VALUES (583, 'KOR', '49', 'UIJ', '议政府市', 'Government city', '');
INSERT INTO `feel_city` VALUES (584, 'KOR', '43', 'ADG', '安东市', 'Anton City', '');
INSERT INTO `feel_city` VALUES (585, 'KOR', '43', 'BHA', '奉化郡', 'Fenghua County', '');
INSERT INTO `feel_city` VALUES (586, 'KOR', '43', 'GRG', '高灵郡', 'Gaoling County', '');
INSERT INTO `feel_city` VALUES (587, 'KOR', '43', 'KUM', '龟尾市', 'Gumi City', '');
INSERT INTO `feel_city` VALUES (588, 'KOR', '43', 'KMC', '金泉市', 'Jinquan City', '');
INSERT INTO `feel_city` VALUES (589, 'KOR', '43', 'GWI', '军威郡', 'Junwei County', '');
INSERT INTO `feel_city` VALUES (590, 'KOR', '43', 'YEC', '醴泉郡', 'Yuquan County', '');
INSERT INTO `feel_city` VALUES (591, 'KOR', '43', 'KPO', '浦项市', 'Pohang City', '');
INSERT INTO `feel_city` VALUES (592, 'KOR', '43', 'CGK', '漆谷郡', 'Paint Valley County', '');
INSERT INTO `feel_city` VALUES (593, 'KOR', '43', 'CDO', '清道郡', 'Qingdao County', '');
INSERT INTO `feel_city` VALUES (594, 'KOR', '43', 'CSG', '青松郡', 'Qingsong County', '');
INSERT INTO `feel_city` VALUES (595, 'KOR', '43', 'GYS', '庆山市', 'Qingshan City', '');
INSERT INTO `feel_city` VALUES (596, 'KOR', '43', 'GJU', '庆州市', 'Gyeongju City', '');
INSERT INTO `feel_city` VALUES (597, 'KOR', '43', 'YEJ', '荣州市', 'Rongzhou City', '');
INSERT INTO `feel_city` VALUES (598, 'KOR', '43', 'SJU', '尙州市', 'Shangzhou', '');
INSERT INTO `feel_city` VALUES (599, 'KOR', '43', 'UJN', '蔚珍郡', 'Uljin County', '');
INSERT INTO `feel_city` VALUES (600, 'KOR', '43', 'MGG', '闻庆市', 'Mungyeong City', '');
INSERT INTO `feel_city` VALUES (601, 'KOR', '43', 'SEJ', '星州郡', 'Star County', '');
INSERT INTO `feel_city` VALUES (602, 'KOR', '43', 'USG', '义城郡', 'Yicheng County', '');
INSERT INTO `feel_city` VALUES (603, 'KOR', '43', 'YYG', '英阳郡', 'Yingyang County', '');
INSERT INTO `feel_city` VALUES (604, 'KOR', '43', 'YDK', '盈德郡', 'Yingde County', '');
INSERT INTO `feel_city` VALUES (605, 'KOR', '43', 'YCH', '永川市', 'Yongchuan City', '');
INSERT INTO `feel_city` VALUES (606, 'KOR', '43', 'ULG', '郁陵郡', 'Yuling County', '');
INSERT INTO `feel_city` VALUES (607, 'KOR', '44', 'CNG', '昌宁郡', 'Changning County', '');
INSERT INTO `feel_city` VALUES (608, 'KOR', '44', 'CHW', '昌原市', 'Changwon', '');
INSERT INTO `feel_city` VALUES (609, 'KOR', '44', 'GSO', '固城郡', 'Gucheng County', '');
INSERT INTO `feel_city` VALUES (610, 'KOR', '44', 'HDG', '河东郡', 'Hedong County', '');
INSERT INTO `feel_city` VALUES (611, 'KOR', '44', 'KMH', '金海市', 'Gimhae', '');
INSERT INTO `feel_city` VALUES (612, 'KOR', '44', 'HIN', '晋州市', 'Jinzhou City', '');
INSERT INTO `feel_city` VALUES (613, 'KOR', '44', 'GCH', '居昌郡', 'Guchang County', '');
INSERT INTO `feel_city` VALUES (614, 'KOR', '44', 'KJE', '巨济市', 'Geoje City', '');
INSERT INTO `feel_city` VALUES (615, 'KOR', '44', 'YSN', '梁山市', 'Liangshan City', '');
INSERT INTO `feel_city` VALUES (616, 'KOR', '44', 'MAS', '马山市', 'Mashan City', '');
INSERT INTO `feel_city` VALUES (617, 'KOR', '44', 'MIR', '密阳市', 'Miyang City', '');
INSERT INTO `feel_city` VALUES (618, 'KOR', '44', 'NHE', '南海郡', 'Nanhai County', '');
INSERT INTO `feel_city` VALUES (619, 'KOR', '44', 'SCH', '山淸郡', 'Shanqing County', '');
INSERT INTO `feel_city` VALUES (620, 'KOR', '44', 'SAH', '泗川市', 'Shibukawa City', '');
INSERT INTO `feel_city` VALUES (621, 'KOR', '44', 'TYG', '统营市', 'Tongyeong City', '');
INSERT INTO `feel_city` VALUES (622, 'KOR', '44', 'HCE', '陜川郡', 'Yodogawa-gun', '');
INSERT INTO `feel_city` VALUES (623, 'KOR', '44', 'HAN', '咸安郡', 'Xian\'an County', '');
INSERT INTO `feel_city` VALUES (624, 'KOR', '44', 'HYG', '咸阳郡', 'Xianyang County', '');
INSERT INTO `feel_city` VALUES (625, 'KOR', '44', 'URG', '宜宁郡', 'Yining County', '');
INSERT INTO `feel_city` VALUES (626, 'KOR', '44', 'CHF', '鎭海市', 'Bohai City', '');
INSERT INTO `feel_city` VALUES (627, 'KOR', '47', 'SCG', '淳昌郡', 'Suichang County', '');
INSERT INTO `feel_city` VALUES (628, 'KOR', '47', 'PUS', '扶安郡', 'Buan County', '');
INSERT INTO `feel_city` VALUES (629, 'KOR', '47', 'GCG', '高敞郡', 'Gochang County', '');
INSERT INTO `feel_city` VALUES (630, 'KOR', '47', 'GJE', '金堤市', 'Gimje City', '');
INSERT INTO `feel_city` VALUES (631, 'KOR', '47', 'JEO', '井邑市', 'Jingxing City', '');
INSERT INTO `feel_city` VALUES (632, 'KOR', '47', 'MJU', '茂朱郡', 'Maju County', '');
INSERT INTO `feel_city` VALUES (633, 'KOR', '47', 'NWN', '南原市', 'Minamihara', '');
INSERT INTO `feel_city` VALUES (634, 'KOR', '47', 'JNJ', '全州市', 'Jeonju', '');
INSERT INTO `feel_city` VALUES (635, 'KOR', '47', 'KUV', '群山市', 'Gunsan City', '');
INSERT INTO `feel_city` VALUES (636, 'KOR', '47', 'ISL', '任实郡', 'Renshi County', '');
INSERT INTO `feel_city` VALUES (637, 'KOR', '47', 'WAJ', '完州郡', 'Wonju County', '');
INSERT INTO `feel_city` VALUES (638, 'KOR', '47', 'IKS', '益山市', 'Iksan City', '');
INSERT INTO `feel_city` VALUES (639, 'KOR', '47', 'JSU', '长水郡', 'Changshui County', '');
INSERT INTO `feel_city` VALUES (640, 'KOR', '47', 'JAN', '鎭安郡', 'Chun\'an County', '');
INSERT INTO `feel_city` VALUES (641, 'KOR', '48', 'BSG', '宝城郡', 'Baocheng County', '');
INSERT INTO `feel_city` VALUES (642, 'KOR', '48', 'GHG', '高兴郡', 'Happy county', '');
INSERT INTO `feel_city` VALUES (643, 'KOR', '48', 'GSE', '谷城郡', 'Gucheng County', '');
INSERT INTO `feel_city` VALUES (644, 'KOR', '48', 'WND', '莞岛郡', 'Wando County', '');
INSERT INTO `feel_city` VALUES (645, 'KOR', '48', 'KAN', '光阳市', 'Gwangyang City', '');
INSERT INTO `feel_city` VALUES (646, 'KOR', '48', 'HAE', '海南郡', 'Hainan County', '');
INSERT INTO `feel_city` VALUES (647, 'KOR', '48', 'HSN', '和顺郡', 'Heshun County', '');
INSERT INTO `feel_city` VALUES (648, 'KOR', '48', 'GJN', '康津郡', 'Kangjin County', '');
INSERT INTO `feel_city` VALUES (649, 'KOR', '48', 'YOS', '丽水市', 'Lishui City', '');
INSERT INTO `feel_city` VALUES (650, 'KOR', '48', 'YGG', '灵光郡', 'Lingguang County', '');
INSERT INTO `feel_city` VALUES (651, 'KOR', '48', 'YAM', '灵岩郡', 'Lingyan County', '');
INSERT INTO `feel_city` VALUES (652, 'KOR', '48', 'NJU', '罗州市', 'Luozhou City', '');
INSERT INTO `feel_city` VALUES (653, 'KOR', '48', 'MOK', '木浦市', 'Mokpo City', '');
INSERT INTO `feel_city` VALUES (654, 'KOR', '48', 'GRE', '求礼郡', 'Courtesy county', '');
INSERT INTO `feel_city` VALUES (655, 'KOR', '48', 'SYS', '顺天市', 'Suncheon City', '');
INSERT INTO `feel_city` VALUES (656, 'KOR', '48', 'DYA', '潭阳郡', 'Tanyang County', '');
INSERT INTO `feel_city` VALUES (657, 'KOR', '48', 'MAN', '务安郡', 'Muan County', '');
INSERT INTO `feel_city` VALUES (658, 'KOR', '48', 'HPG', '咸平郡', 'Hampyeong County', '');
INSERT INTO `feel_city` VALUES (659, 'KOR', '48', 'SAN', '新安郡', 'Xin\'an County', '');
INSERT INTO `feel_city` VALUES (660, 'KOR', '48', 'JSN', '长城郡', 'Great Wall County', '');
INSERT INTO `feel_city` VALUES (661, 'KOR', '48', 'JHG', '长兴郡', 'Changxing County', '');
INSERT INTO `feel_city` VALUES (662, 'KOR', '48', 'JDO', '珍岛郡', 'Jindo County', '');
INSERT INTO `feel_city` VALUES (663, 'KOR', '45', 'BEN', '报恩郡', 'Hoon County', '');
INSERT INTO `feel_city` VALUES (664, 'KOR', '45', 'JYG', '曾坪郡', 'Zengping County', '');
INSERT INTO `feel_city` VALUES (665, 'KOR', '45', 'DYG', '丹阳郡', 'Danyang County', '');
INSERT INTO `feel_city` VALUES (666, 'KOR', '45', 'JCH', '堤川市', 'Jecheon City', '');
INSERT INTO `feel_city` VALUES (667, 'KOR', '45', 'GSN', '槐山郡', 'Lushan County', '');
INSERT INTO `feel_city` VALUES (668, 'KOR', '45', 'CWO', '淸原郡', 'Kasahara-gun', '');
INSERT INTO `feel_city` VALUES (669, 'KOR', '45', 'CJJ', '淸州市', 'Quzhou City', '');
INSERT INTO `feel_city` VALUES (670, 'KOR', '45', 'OCN', '沃川郡', 'Okcheon County', '');
INSERT INTO `feel_city` VALUES (671, 'KOR', '45', 'ESG', '阴城郡', 'Yincheng County', '');
INSERT INTO `feel_city` VALUES (672, 'KOR', '45', 'YDG', '永同郡', 'Yongtong County', '');
INSERT INTO `feel_city` VALUES (673, 'KOR', '45', 'JCN', '鎭川郡', 'Luanchuan County', '');
INSERT INTO `feel_city` VALUES (674, 'KOR', '45', 'CHU', '忠州市', 'Chungju City', '');
INSERT INTO `feel_city` VALUES (675, 'KOR', '46', 'BOR', '保宁市', 'Baoning City', '');
INSERT INTO `feel_city` VALUES (676, 'KOR', '46', 'BYO', '扶余郡', 'Fuyu County', '');
INSERT INTO `feel_city` VALUES (677, 'KOR', '46', 'GOJ', '公州市', 'Gongju City', '');
INSERT INTO `feel_city` VALUES (678, 'KOR', '46', 'HSE', '洪城郡', 'Hongcheng County', '');
INSERT INTO `feel_city` VALUES (679, 'KOR', '46', 'GYE', '鸡龙市', 'Jilong City', '');
INSERT INTO `feel_city` VALUES (680, 'KOR', '46', 'GSA', '锦山郡', 'Jinshan County', '');
INSERT INTO `feel_city` VALUES (681, 'KOR', '46', 'YOS', '礼山郡', 'Lishan County', '');
INSERT INTO `feel_city` VALUES (682, 'KOR', '46', 'NSN', '论山市', 'On the mountain city', '');
INSERT INTO `feel_city` VALUES (683, 'KOR', '46', 'CYG', '青阳郡', 'Qingyang County', '');
INSERT INTO `feel_city` VALUES (684, 'KOR', '46', 'SSA', '瑞山市', 'Emeishan', '');
INSERT INTO `feel_city` VALUES (685, 'KOR', '46', 'SCE', '舒川郡', 'Shuchuan County', '');
INSERT INTO `feel_city` VALUES (686, 'KOR', '46', 'TAN', '泰安郡', 'Tai\'an County', '');
INSERT INTO `feel_city` VALUES (687, 'KOR', '46', 'TJI', '唐津郡', 'Karatsu-gun', '');
INSERT INTO `feel_city` VALUES (688, 'KOR', '46', 'CHO', '天安市', 'Cheonan', '');
INSERT INTO `feel_city` VALUES (689, 'KOR', '46', 'ASA', '牙山市', 'Asan City', '');
INSERT INTO `feel_city` VALUES (690, 'KOR', '46', 'YGI', '燕岐郡', 'Yanzi County', '');
INSERT INTO `feel_city` VALUES (691, 'MYS', 'PH', 'BWH', '北海', 'North Sea', '');
INSERT INTO `feel_city` VALUES (692, 'MYS', 'PH', 'PEN', '槟城', 'Penang', '');
INSERT INTO `feel_city` VALUES (693, 'MYS', 'PH', 'BMJ', '大山脚', 'Big mountain foot', '');
INSERT INTO `feel_city` VALUES (694, 'MYS', 'PH', 'NTE', '高渊', 'Gao Yuan', '');
INSERT INTO `feel_city` VALUES (695, 'MYS', 'PS', 'KGR', '玻璃市', 'Glass city', '');
INSERT INTO `feel_city` VALUES (696, 'MYS', 'TR', 'KEM', '甘马挽', 'Ganma', '');
INSERT INTO `feel_city` VALUES (697, 'MYS', 'TR', 'TGG', '瓜拉丁加奴', 'Kuala Terengganu', '');
INSERT INTO `feel_city` VALUES (698, 'MYS', 'TR', 'DGN', '龙运', 'Longyun', '');
INSERT INTO `feel_city` VALUES (699, 'MYS', 'TR', 'MAR', '马江', 'Ma Jiang', '');
INSERT INTO `feel_city` VALUES (700, 'MYS', 'TR', 'SET', '实兆', 'Real sign', '');
INSERT INTO `feel_city` VALUES (701, 'MYS', 'TR', 'HUL', '乌鲁', 'Ulu', '');
INSERT INTO `feel_city` VALUES (702, 'MYS', 'TR', 'BES', '勿述', 'Do not say', '');
INSERT INTO `feel_city` VALUES (703, 'MYS', 'KD', 'PGT', '巴东得腊', 'Padang Dewa', '');
INSERT INTO `feel_city` VALUES (704, 'MYS', 'KD', 'PEN', '笨筒', 'Stupid', '');
INSERT INTO `feel_city` VALUES (705, 'MYS', 'KD', 'LGK', '浮罗交怡', 'Langkawi', '');
INSERT INTO `feel_city` VALUES (706, 'MYS', 'KD', 'KOR', '哥打士打', 'Kotas', '');
INSERT INTO `feel_city` VALUES (707, 'MYS', 'KD', 'KPA', '古邦巴素', 'Gubamba', '');
INSERT INTO `feel_city` VALUES (708, 'MYS', 'KD', 'KMU', '瓜拉姆达', 'Gualamda', '');
INSERT INTO `feel_city` VALUES (709, 'MYS', 'KD', 'BLZ', '华玲', 'Hua Ling', '');
INSERT INTO `feel_city` VALUES (710, 'MYS', 'KD', 'KLM', '居林', 'Kulim', '');
INSERT INTO `feel_city` VALUES (711, 'MYS', 'KD', 'BMA', '万拉峇鲁', 'Van Laru', '');
INSERT INTO `feel_city` VALUES (712, 'MYS', 'KN', 'PPU', '巴西富地', 'Brazilian rich land', '');
INSERT INTO `feel_city` VALUES (713, 'MYS', 'KN', 'PMA', '巴西马', 'Brazilian horse', '');
INSERT INTO `feel_city` VALUES (714, 'MYS', 'KN', 'TMR', '丹那美拉', 'Tanah Merah', '');
INSERT INTO `feel_city` VALUES (715, 'MYS', 'KN', 'TUM', '道北', 'Dohoku', '');
INSERT INTO `feel_city` VALUES (716, 'MYS', 'KN', 'BAC', '登卓', 'Deng Zhuo', '');
INSERT INTO `feel_city` VALUES (717, 'MYS', 'KN', 'KBR', '哥打巴鲁', 'Kota Bharu', '');
INSERT INTO `feel_city` VALUES (718, 'MYS', 'KN', 'KUG', '瓜拉吉赖', 'Guarajirai', '');
INSERT INTO `feel_city` VALUES (719, 'MYS', 'KN', 'GMU', '话望生', 'Hope', '');
INSERT INTO `feel_city` VALUES (720, 'MYS', 'KN', 'MAC', '马樟', 'Ma Wei', '');
INSERT INTO `feel_city` VALUES (721, 'MYS', 'KN', 'JEL', '日里', 'Ri Li', '');
INSERT INTO `feel_city` VALUES (722, 'MYS', 'KL', 'KUL', '吉隆坡', 'Kuala Lumpur', '');
INSERT INTO `feel_city` VALUES (723, 'MYS', 'ML', 'MEL', '马六甲市', 'Malacca City', '');
INSERT INTO `feel_city` VALUES (724, 'MYS', 'ML', 'AOG', '亚罗牙也', 'Alor Gajah', '');
INSERT INTO `feel_city` VALUES (725, 'MYS', 'ML', 'JAS', '野新', 'Wild new', '');
INSERT INTO `feel_city` VALUES (726, 'MYS', 'LB', 'LBU', '纳闽', 'Labuan', '');
INSERT INTO `feel_city` VALUES (727, 'MYS', 'LB', 'VIC', '维多利亚', 'Victoria', '');
INSERT INTO `feel_city` VALUES (728, 'MYS', 'PG', 'BER', '百乐', 'Baile', '');
INSERT INTO `feel_city` VALUES (729, 'MYS', 'PG', 'PEK', '北根', 'North root', '');
INSERT INTO `feel_city` VALUES (730, 'MYS', 'PG', 'TEM', '淡马鲁', 'Temeru', '');
INSERT INTO `feel_city` VALUES (731, 'MYS', 'PG', 'JER', '而连突', 'Even', '');
INSERT INTO `feel_city` VALUES (732, 'MYS', 'PG', 'KUA', '关丹', 'Kuantan', '');
INSERT INTO `feel_city` VALUES (733, 'MYS', 'PG', 'CAH', '金马仑高原', 'Cameron Highlands', '');
INSERT INTO `feel_city` VALUES (734, 'MYS', 'PG', 'RAU', '劳勿', 'Raub', '');
INSERT INTO `feel_city` VALUES (735, 'MYS', 'PG', 'KUL', '立卑', 'Lie', '');
INSERT INTO `feel_city` VALUES (736, 'MYS', 'PG', 'MAR', '马兰', 'Malan', '');
INSERT INTO `feel_city` VALUES (737, 'MYS', 'PG', 'BEN', '文冬', 'Wen Dong', '');
INSERT INTO `feel_city` VALUES (738, 'MYS', 'PG', 'TOM', '云冰', 'Cloud ice', '');
INSERT INTO `feel_city` VALUES (739, 'MYS', 'PK', 'TAS', '安顺', 'Anshun', '');
INSERT INTO `feel_city` VALUES (740, 'MYS', 'PK', 'TAM', '丹绒马', 'Tanjung horse', '');
INSERT INTO `feel_city` VALUES (741, 'MYS', 'PK', 'SSP', '和丰', 'Hefeng', '');
INSERT INTO `feel_city` VALUES (742, 'MYS', 'PK', 'LUM', '紅土坎', 'Red ridge', '');
INSERT INTO `feel_city` VALUES (743, 'MYS', 'PK', 'BGA', '华都牙也', 'Huaduya', '');
INSERT INTO `feel_city` VALUES (744, 'MYS', 'PK', 'KAR', '江沙', 'Jiangsha', '');
INSERT INTO `feel_city` VALUES (745, 'MYS', 'PK', 'TPG', '太平', 'Taiping', '');
INSERT INTO `feel_city` VALUES (746, 'MYS', 'PK', 'IPH', '怡保', 'Ipoh', '');
INSERT INTO `feel_city` VALUES (747, 'MYS', 'JH', 'POW', '笨珍', 'Pontian', '');
INSERT INTO `feel_city` VALUES (748, 'MYS', 'JH', 'MEP', '丰盛港', 'Mersing', '');
INSERT INTO `feel_city` VALUES (749, 'MYS', 'JH', 'KTI', '哥打丁宜', 'Kota Tinggi', '');
INSERT INTO `feel_city` VALUES (750, 'MYS', 'JH', 'KLA', '居銮', 'Kluang', '');
INSERT INTO `feel_city` VALUES (751, 'MYS', 'JH', 'BAT', '峇株巴辖', 'Batu Pahat', '');
INSERT INTO `feel_city` VALUES (752, 'MYS', 'JH', 'MUA', '麻坡', 'Muar', '');
INSERT INTO `feel_city` VALUES (753, 'MYS', 'JH', 'SGM', '昔加末', 'Segamat', '');
INSERT INTO `feel_city` VALUES (754, 'MYS', 'JH', 'JHB', '新山', 'Niiyama', '');
INSERT INTO `feel_city` VALUES (755, 'MYS', 'NS', 'PDI', '波德申', 'Port Dickson', '');
INSERT INTO `feel_city` VALUES (756, 'MYS', 'NS', 'TAI', '淡边', 'Light side', '');
INSERT INTO `feel_city` VALUES (757, 'MYS', 'NS', 'SRB', '芙蓉', 'Hibiscus', '');
INSERT INTO `feel_city` VALUES (758, 'MYS', 'NS', 'KPI', '瓜拉庇劳', 'Guara Pelau', '');
INSERT INTO `feel_city` VALUES (759, 'MYS', 'NS', 'REM', '林茂', 'Lin Mao', '');
INSERT INTO `feel_city` VALUES (760, 'MYS', 'NS', 'JEP', '仁保', 'Ninpo', '');
INSERT INTO `feel_city` VALUES (761, 'MYS', 'NS', 'JEL', '日叻务', 'Daily service', '');
INSERT INTO `feel_city` VALUES (762, 'MYS', 'SB', 'PAP', '吧巴', 'Bar', '');
INSERT INTO `feel_city` VALUES (763, 'MYS', 'SB', 'BEF', '保佛', 'Baofo', '');
INSERT INTO `feel_city` VALUES (764, 'MYS', 'SB', 'BEL', '比鲁兰', 'Biruland', '');
INSERT INTO `feel_city` VALUES (765, 'MYS', 'SB', 'PIT', '必达士', 'Bidas', '');
INSERT INTO `feel_city` VALUES (766, 'MYS', 'SB', 'PMP', '兵南邦', 'Bingnan', '');
INSERT INTO `feel_city` VALUES (767, 'MYS', 'SB', 'TAB', '担布南', 'Bunannan', '');
INSERT INTO `feel_city` VALUES (768, 'MYS', 'SB', 'TEN', '丹南', 'Dannan', '');
INSERT INTO `feel_city` VALUES (769, 'MYS', 'SB', 'TAW', '斗湖', 'Tawau', '');
INSERT INTO `feel_city` VALUES (770, 'MYS', 'SB', 'TUR', '斗亚兰', 'Tualan', '');
INSERT INTO `feel_city` VALUES (771, 'MYS', 'SB', 'BKI', '哥打基纳巴鲁', 'Kota Kinabalu', '');
INSERT INTO `feel_city` VALUES (772, 'MYS', 'SB', 'KMU', '哥打马鲁都', 'Kota Marudu', '');
INSERT INTO `feel_city` VALUES (773, 'MYS', 'SB', 'KEG', '根地咬', 'Root bite', '');
INSERT INTO `feel_city` VALUES (774, 'MYS', 'SB', 'KUD', '古达', 'Guda', '');
INSERT INTO `feel_city` VALUES (775, 'MYS', 'SB', 'KBD', '古打毛律', 'Ancient hair', '');
INSERT INTO `feel_city` VALUES (776, 'MYS', 'SB', 'KUN', '古纳', 'Guna', '');
INSERT INTO `feel_city` VALUES (777, 'MYS', 'SB', 'KPU', '瓜拉班尤', 'Guabanban', '');
INSERT INTO `feel_city` VALUES (778, 'MYS', 'SB', 'KBT', '京那巴登岸', 'Mount Kinaba', '');
INSERT INTO `feel_city` VALUES (779, 'MYS', 'SB', 'RNU', '兰脑', 'Blue brain', '');
INSERT INTO `feel_city` VALUES (780, 'MYS', 'SB', 'LDU', '拿笃', 'Take', '');
INSERT INTO `feel_city` VALUES (781, 'MYS', 'SB', 'NAB', '纳巴湾', 'Nabba Bay', '');
INSERT INTO `feel_city` VALUES (782, 'MYS', 'SB', 'SDK', '山打根', 'Sandakan', '');
INSERT INTO `feel_city` VALUES (783, 'MYS', 'SB', 'SPT', '西比陶', 'Sibi Tao', '');
INSERT INTO `feel_city` VALUES (784, 'MYS', 'SB', 'SMM', '仙本那', 'Semporna', '');
INSERT INTO `feel_city` VALUES (785, 'MYS', 'SR', 'KCH', '古晋', 'Kuching', '');
INSERT INTO `feel_city` VALUES (786, 'MYS', 'SR', 'KPI', '加帛', 'Coronation', '');
INSERT INTO `feel_city` VALUES (787, 'MYS', 'SR', 'LMN', '林梦', 'Lin Meng', '');
INSERT INTO `feel_city` VALUES (788, 'MYS', 'SR', 'MYY', '美里', 'Misato', '');
INSERT INTO `feel_city` VALUES (789, 'MYS', 'SR', 'BTU', '民都鲁', 'Bintulu', '');
INSERT INTO `feel_city` VALUES (790, 'MYS', 'SR', 'MKM', '木胶', 'Wood glue', '');
INSERT INTO `feel_city` VALUES (791, 'MYS', 'SR', 'BTG', '木中', 'Wood', '');
INSERT INTO `feel_city` VALUES (792, 'MYS', 'SR', 'SMH', '三马拉汉', 'Samarahan', '');
INSERT INTO `feel_city` VALUES (793, 'MYS', 'SR', 'SAM', '斯里阿曼', 'Sri Aman', '');
INSERT INTO `feel_city` VALUES (794, 'MYS', 'SR', 'SAR', '泗里街', 'Bali Street', '');
INSERT INTO `feel_city` VALUES (795, 'MYS', 'SR', 'SBW', '泗务', 'Service', '');
INSERT INTO `feel_city` VALUES (796, 'MYS', 'SL', 'PJA', '八打灵', 'Petaling', '');
INSERT INTO `feel_city` VALUES (797, 'MYS', 'SL', 'GOM', '鹅麦', 'Goose', '');
INSERT INTO `feel_city` VALUES (798, 'MYS', 'SL', 'KLG', '瓜拉冷岳', 'Guara Lengyue', '');
INSERT INTO `feel_city` VALUES (799, 'MYS', 'SL', 'KSL', '瓜拉雪兰莪', 'Kuala Selangor', '');
INSERT INTO `feel_city` VALUES (800, 'MYS', 'SL', 'SBM', '沙白安南', 'Sha Bai Annan', '');
INSERT INTO `feel_city` VALUES (801, 'MYS', 'SL', 'HUL', '乌鲁冷岳', 'Ulu Lengyue', '');
INSERT INTO `feel_city` VALUES (802, 'MYS', 'SL', 'HUS', '乌鲁雪兰莪', 'Ulu Selangor', '');
INSERT INTO `feel_city` VALUES (803, 'MYS', 'SL', 'SEP', '雪邦', 'Sepang', '');
INSERT INTO `feel_city` VALUES (804, 'USA', 'AR', 'FYV', '费耶特维尔', 'Fayetteville', '');
INSERT INTO `feel_city` VALUES (805, 'USA', 'AR', 'FSM', '史密斯堡', 'Fort Smith', '');
INSERT INTO `feel_city` VALUES (806, 'USA', 'AR', 'LIT', '小石城', 'Little Rock', '');
INSERT INTO `feel_city` VALUES (807, 'USA', 'AL', 'BHM', '伯明罕', 'Birmingham', '');
INSERT INTO `feel_city` VALUES (808, 'USA', 'AL', 'MGM', '蒙哥马利', 'Montgomery', '');
INSERT INTO `feel_city` VALUES (809, 'USA', 'AL', 'MOB', '莫比尔', 'Mobile', '');
INSERT INTO `feel_city` VALUES (810, 'USA', 'AK', 'ANC', '安克雷奇', 'Anchorage', '');
INSERT INTO `feel_city` VALUES (811, 'USA', 'AK', 'FAI', '费尔班克斯', 'Fairbanks', '');
INSERT INTO `feel_city` VALUES (812, 'USA', 'AK', 'JNU', '朱诺', 'Juno', '');
INSERT INTO `feel_city` VALUES (813, 'USA', 'ID', 'IDA', '爱达荷福尔斯', 'Idaho Falls', '');
INSERT INTO `feel_city` VALUES (814, 'USA', 'ID', 'PIH', '波卡特洛', 'Pocatello', '');
INSERT INTO `feel_city` VALUES (815, 'USA', 'ID', 'BOI', '博伊西', 'Boise', '');
INSERT INTO `feel_city` VALUES (816, 'USA', 'ID', 'BLK', '布莱克富特', 'Blackfoot', '');
INSERT INTO `feel_city` VALUES (817, 'USA', 'ID', 'COE', '科达伦', 'Codaran', '');
INSERT INTO `feel_city` VALUES (818, 'USA', 'ID', 'LWS', '刘易斯顿', 'Lewiston', '');
INSERT INTO `feel_city` VALUES (819, 'USA', 'ID', 'MJL', '莫斯科', 'Moscow', '');
INSERT INTO `feel_city` VALUES (820, 'USA', 'ID', 'ZMU', '墨菲', 'Murphy', '');
INSERT INTO `feel_city` VALUES (821, 'USA', 'ID', 'NPA', '楠帕', 'Nanpa', '');
INSERT INTO `feel_city` VALUES (822, 'USA', 'ID', 'QKM', '岂彻姆', '岂chum', '');
INSERT INTO `feel_city` VALUES (823, 'USA', 'ID', 'SVY', '森瓦利', 'Senvalli', '');
INSERT INTO `feel_city` VALUES (824, 'USA', 'ID', 'YAF', '亚美利加瀑布城', 'Amerika Falls', '');
INSERT INTO `feel_city` VALUES (825, 'USA', 'IA', 'DVN', '达文波特', 'Davenport', '');
INSERT INTO `feel_city` VALUES (826, 'USA', 'IA', 'DSM', '得梅因', 'Des Moines', '');
INSERT INTO `feel_city` VALUES (827, 'USA', 'IA', 'CID', '锡达拉皮兹', 'Cedar Rapids', '');
INSERT INTO `feel_city` VALUES (828, 'USA', 'ND', 'BIS', '俾斯麦', 'Bismarck', '');
INSERT INTO `feel_city` VALUES (829, 'USA', 'ND', 'GFK', '大福克斯', 'Grand Forks', '');
INSERT INTO `feel_city` VALUES (830, 'USA', 'ND', 'FAR', '法戈', 'Fargo', '');
INSERT INTO `feel_city` VALUES (831, 'USA', 'ND', 'MOT', '迈诺特', 'Minot', '');
INSERT INTO `feel_city` VALUES (832, 'USA', 'NC', 'AEV', '艾许维尔', 'Ashville', '');
INSERT INTO `feel_city` VALUES (833, 'USA', 'NC', 'DHH', '杜罕', 'Duhan', '');
INSERT INTO `feel_city` VALUES (834, 'USA', 'NC', 'GBO', '格林斯伯勒', 'Greensboro', '');
INSERT INTO `feel_city` VALUES (835, 'USA', 'NC', 'CHE', '教堂山', 'Chapel Hill', '');
INSERT INTO `feel_city` VALUES (836, 'USA', 'NC', 'RAG', '罗利', 'Raleigh', '');
INSERT INTO `feel_city` VALUES (837, 'USA', 'NC', 'RDU', '洛利杜罕都会区', 'Lorraine Metropolitan Area', '');
INSERT INTO `feel_city` VALUES (838, 'USA', 'NC', 'CRQ', '夏洛特', 'Charlotte', '');
INSERT INTO `feel_city` VALUES (839, 'USA', 'PA', 'AEW', '阿伦敦', 'Allentown', '');
INSERT INTO `feel_city` VALUES (840, 'USA', 'PA', 'PHL', '费城', 'Philadelphia', '');
INSERT INTO `feel_city` VALUES (841, 'USA', 'PA', 'PIT', '匹兹堡', 'Pittsburgh', '');
INSERT INTO `feel_city` VALUES (842, 'USA', 'TX', 'ELP', '埃尔帕索', 'El paso', '');
INSERT INTO `feel_city` VALUES (843, 'USA', 'TX', 'AUS', '奥斯汀', 'Austin', '');
INSERT INTO `feel_city` VALUES (844, 'USA', 'TX', 'DAL', '达拉斯', 'Dallas', '');
INSERT INTO `feel_city` VALUES (845, 'USA', 'TX', 'CRP', '哥帕斯基斯蒂', 'Gopaskisti', '');
INSERT INTO `feel_city` VALUES (846, 'USA', 'TX', 'GLS', '交维斯顿', 'Weston', '');
INSERT INTO `feel_city` VALUES (847, 'USA', 'TX', 'LRD', '拉雷多', 'Laredo', '');
INSERT INTO `feel_city` VALUES (848, 'USA', 'TX', 'TXC', '麦亚伦', 'Mai Yalun', '');
INSERT INTO `feel_city` VALUES (849, 'USA', 'TX', 'SAT', '圣安东尼奥', 'San Antonio', '');
INSERT INTO `feel_city` VALUES (850, 'USA', 'TX', 'HOU', '休斯敦', 'Houston', '');
INSERT INTO `feel_city` VALUES (851, 'USA', 'OH', 'DYT', '代顿', 'Dayton', '');
INSERT INTO `feel_city` VALUES (852, 'USA', 'OH', 'CZX', '哥伦布', 'Columbus', '');
INSERT INTO `feel_city` VALUES (853, 'USA', 'OH', 'CLE', '克利夫兰', 'Cleveland', '');
INSERT INTO `feel_city` VALUES (854, 'USA', 'OH', 'TOL', '托莱多', 'Toledo', '');
INSERT INTO `feel_city` VALUES (855, 'USA', 'OH', 'CVG', '辛辛那提', 'Cincinnati', '');
INSERT INTO `feel_city` VALUES (856, 'USA', 'OK', 'OKC', '俄克拉荷马城', 'Oklahoma City', '');
INSERT INTO `feel_city` VALUES (857, 'USA', 'OK', 'OUN', '诺曼', 'Norman', '');
INSERT INTO `feel_city` VALUES (858, 'USA', 'OK', 'TUL', '塔尔萨', 'Tulsa', '');
INSERT INTO `feel_city` VALUES (859, 'USA', 'OR', 'BZO', '本德', 'Bend', '');
INSERT INTO `feel_city` VALUES (860, 'USA', 'OR', 'PDX', '波特兰', 'Portland', '');
INSERT INTO `feel_city` VALUES (861, 'USA', 'OR', 'DLS', '达尔斯', 'Dars', '');
INSERT INTO `feel_city` VALUES (862, 'USA', 'OR', 'DAC', '达拉斯', 'Dallas', '');
INSERT INTO `feel_city` VALUES (863, 'USA', 'OR', 'TLM', '蒂拉穆克', 'Tillamuk', '');
INSERT INTO `feel_city` VALUES (864, 'USA', 'OR', 'XFX', '格兰茨帕斯', 'Grants Pass', '');
INSERT INTO `feel_city` VALUES (865, 'USA', 'OR', 'HDX', '胡德里弗', 'Hood River', '');
INSERT INTO `feel_city` VALUES (866, 'USA', 'OR', 'CTR', '火山口湖', 'Crater Lake', '');
INSERT INTO `feel_city` VALUES (867, 'USA', 'OR', 'YCV', '科瓦利斯', 'Corvallis', '');
INSERT INTO `feel_city` VALUES (868, 'USA', 'OR', 'COB', '库斯贝', 'Coos Bay', '');
INSERT INTO `feel_city` VALUES (869, 'USA', 'OR', 'MFR', '梅德福', 'Medford', '');
INSERT INTO `feel_city` VALUES (870, 'USA', 'OR', 'SLE', '塞勒姆', 'Salem', '');
INSERT INTO `feel_city` VALUES (871, 'USA', 'OR', 'STH', '圣海伦斯', 'St Helens', '');
INSERT INTO `feel_city` VALUES (872, 'USA', 'OR', 'SPY', '斯普林菲尔德', 'Springfield', '');
INSERT INTO `feel_city` VALUES (873, 'USA', 'OR', 'EUG', '尤金', 'Eugene', '');
INSERT INTO `feel_city` VALUES (874, 'USA', 'FL', 'ORL', '奥兰多', 'Orlando', '');
INSERT INTO `feel_city` VALUES (875, 'USA', 'FL', 'EYW', '基韦斯特', 'Key West', '');
INSERT INTO `feel_city` VALUES (876, 'USA', 'FL', 'JAX', '杰克逊维尔', 'Jacksonville', '');
INSERT INTO `feel_city` VALUES (877, 'USA', 'FL', 'CPV', '卡纳维尔角', 'Cape Canaveral', '');
INSERT INTO `feel_city` VALUES (878, 'USA', 'FL', 'FLL', '罗德岱堡', 'Fort Lauderdale', '');
INSERT INTO `feel_city` VALUES (879, 'USA', 'FL', 'MIA', '迈阿密', 'Miami', '');
INSERT INTO `feel_city` VALUES (880, 'USA', 'FL', 'PIE', '圣彼德斯堡市', 'St. Petersburg', '');
INSERT INTO `feel_city` VALUES (881, 'USA', 'FL', 'TLH', '塔拉哈西', 'Tallahassee', '');
INSERT INTO `feel_city` VALUES (882, 'USA', 'FL', 'TPA', '坦帕', 'Tampa', '');
INSERT INTO `feel_city` VALUES (883, 'USA', 'VT', 'BTV', '伯灵顿', 'Burlington', '');
INSERT INTO `feel_city` VALUES (884, 'USA', 'VT', 'RUT', '拉特兰', 'Rutland', '');
INSERT INTO `feel_city` VALUES (885, 'USA', 'VT', 'ZBR', '南伯灵顿', 'South Burlington', '');
INSERT INTO `feel_city` VALUES (886, 'USA', 'DC', 'WAS', '华盛顿哥伦比亚特区', 'Washington, D.C', '');
INSERT INTO `feel_city` VALUES (887, 'USA', 'WA', 'GEG', '斯波坎', 'Spokane', '');
INSERT INTO `feel_city` VALUES (888, 'USA', 'WA', 'TTW', '塔科马', 'Tacoma', '');
INSERT INTO `feel_city` VALUES (889, 'USA', 'WA', 'SEA', '西雅图', 'Seattle', '');
INSERT INTO `feel_city` VALUES (890, 'USA', 'WY', 'EVD', '埃文斯顿', 'Evanston', '');
INSERT INTO `feel_city` VALUES (891, 'USA', 'WY', 'CPR', '卡斯珀', 'Casper', '');
INSERT INTO `feel_city` VALUES (892, 'USA', 'WY', 'LAR', '拉勒米', 'Laramie', '');
INSERT INTO `feel_city` VALUES (893, 'USA', 'WY', 'RKS', '罗克斯普林斯', 'Rock Springs', '');
INSERT INTO `feel_city` VALUES (894, 'USA', 'WY', 'CYS', '夏延', 'Cheyenne', '');
INSERT INTO `feel_city` VALUES (895, 'USA', 'WY', 'SHR', '谢里登', 'Sheridan', '');
INSERT INTO `feel_city` VALUES (896, 'USA', 'CA', 'SFO', '旧金山', 'San Francisco', '');
INSERT INTO `feel_city` VALUES (897, 'USA', 'CA', 'LAX', '洛杉矶', 'Los Angeles', '');
INSERT INTO `feel_city` VALUES (898, 'USA', 'CA', 'SAN', '圣迭戈', 'San Diego', '');
INSERT INTO `feel_city` VALUES (899, 'USA', 'CA', 'SJC', '圣何塞', 'San Jose', '');
INSERT INTO `feel_city` VALUES (900, 'USA', 'KS', 'ABZ', '阿比林', 'Abilene', '');
INSERT INTO `feel_city` VALUES (901, 'USA', 'KS', 'OVL', '奥弗兰公园', 'Overland Park', '');
INSERT INTO `feel_city` VALUES (902, 'USA', 'KS', 'HCH', '哈钦森', 'Hutchinson', '');
INSERT INTO `feel_city` VALUES (903, 'USA', 'KS', 'KCK', '堪萨斯城', 'Kansas City', '');
INSERT INTO `feel_city` VALUES (904, 'USA', 'KS', 'XIA', '莱文沃思', 'Leavenworth', '');
INSERT INTO `feel_city` VALUES (905, 'USA', 'KS', 'LWC', '劳伦斯', 'Lawrence', '');
INSERT INTO `feel_city` VALUES (906, 'USA', 'KS', 'MHK', '曼哈顿', 'Manhattan', '');
INSERT INTO `feel_city` VALUES (907, 'USA', 'KS', 'TOP', '托皮卡', 'Topeka', '');
INSERT INTO `feel_city` VALUES (908, 'USA', 'KS', 'ICT', '威奇托', 'Wichita', '');
INSERT INTO `feel_city` VALUES (909, 'USA', 'CT', 'BDR', '布里奇波特', 'Bridgeport', '');
INSERT INTO `feel_city` VALUES (910, 'USA', 'CT', 'DAQ', '达里恩', 'Darien', '');
INSERT INTO `feel_city` VALUES (911, 'USA', 'CT', 'GRH', '格林尼治', 'Greenich', '');
INSERT INTO `feel_city` VALUES (912, 'USA', 'CT', 'HFD', '哈特福德', 'Hartford', '');
INSERT INTO `feel_city` VALUES (913, 'USA', 'CT', 'XIN', '米德尔顿', 'Middleton', '');
INSERT INTO `feel_city` VALUES (914, 'USA', 'CT', 'HVN', '纽黑文', 'New Haven', '');
INSERT INTO `feel_city` VALUES (915, 'USA', 'CT', 'WPT', '韦斯特波特', 'Westport', '');
INSERT INTO `feel_city` VALUES (916, 'USA', 'CT', 'WAT', '沃特伯里', 'Waterbury', '');
INSERT INTO `feel_city` VALUES (917, 'USA', 'CT', 'NWT', '新不列颠', 'New britain', '');
INSERT INTO `feel_city` VALUES (918, 'USA', 'CO', 'ASE', '阿斯彭', 'Aspen', '');
INSERT INTO `feel_city` VALUES (919, 'USA', 'CO', 'AUX', '奥罗拉', 'Aurora', '');
INSERT INTO `feel_city` VALUES (920, 'USA', 'CO', 'WBU', '博尔德', 'Boulder', '');
INSERT INTO `feel_city` VALUES (921, 'USA', 'CO', 'GJT', '大章克申', 'Grand Junction', '');
INSERT INTO `feel_city` VALUES (922, 'USA', 'CO', 'DEN', '丹佛', 'Denver', '');
INSERT INTO `feel_city` VALUES (923, 'USA', 'CO', 'FNL', '柯林斯堡', 'Fort Collins', '');
INSERT INTO `feel_city` VALUES (924, 'USA', 'CO', 'COS', '科罗拉多斯普林斯', 'Colorado Springs', '');
INSERT INTO `feel_city` VALUES (925, 'USA', 'CO', 'VAC', '韦尔', 'Vail', '');
INSERT INTO `feel_city` VALUES (926, 'USA', 'KY', 'LEX', '列克星敦', 'Lexington', '');
INSERT INTO `feel_city` VALUES (927, 'USA', 'KY', 'LUI', '路易斯维尔', 'Louisville', '');
INSERT INTO `feel_city` VALUES (928, 'USA', 'KY', 'OWB', '欧文斯伯勒', 'Owensboro', '');
INSERT INTO `feel_city` VALUES (929, 'USA', 'LA', 'BTR', '巴吞鲁日', 'Baton Rouge', '');
INSERT INTO `feel_city` VALUES (930, 'USA', 'LA', 'SHV', '什里夫波特', 'Shreveport', '');
INSERT INTO `feel_city` VALUES (931, 'USA', 'LA', 'MSY', '新奥尔良', 'New orleans', '');
INSERT INTO `feel_city` VALUES (932, 'USA', 'RI', 'PAW', '波塔基特', 'Portakit', '');
INSERT INTO `feel_city` VALUES (933, 'USA', 'RI', 'CQH', '克兰斯顿', 'Cranston', '');
INSERT INTO `feel_city` VALUES (934, 'USA', 'RI', 'NPO', '纽波特', 'Newport', '');
INSERT INTO `feel_city` VALUES (935, 'USA', 'RI', 'PVD', '普罗维登斯', 'Providence', '');
INSERT INTO `feel_city` VALUES (936, 'USA', 'RI', 'WST', '韦斯特利', 'Westley', '');
INSERT INTO `feel_city` VALUES (937, 'USA', 'RI', 'SFN', '文索基特', 'Wensokite', '');
INSERT INTO `feel_city` VALUES (938, 'USA', 'RI', 'UZO', '沃威克', 'Warwick', '');
INSERT INTO `feel_city` VALUES (939, 'USA', 'MD', 'BAL', '巴尔的摩', 'Baltimore', '');
INSERT INTO `feel_city` VALUES (940, 'USA', 'MD', 'GAI', '盖瑟斯堡', 'Gaithersburg', '');
INSERT INTO `feel_city` VALUES (941, 'USA', 'MD', 'RKV', '罗克维尔', 'Rockville', '');
INSERT INTO `feel_city` VALUES (942, 'USA', 'MA', 'BZD', '波士顿', 'Boston', '');
INSERT INTO `feel_city` VALUES (943, 'USA', 'MA', 'SFY', '斯普林菲尔德', 'Springfield', '');
INSERT INTO `feel_city` VALUES (944, 'USA', 'MA', 'ORH', '伍斯特', 'Worcester', '');
INSERT INTO `feel_city` VALUES (945, 'USA', 'MT', 'BGS', '比灵斯', 'Billings', '');
INSERT INTO `feel_city` VALUES (946, 'USA', 'MT', 'GTF', '大瀑布村', 'Great Falls Village', '');
INSERT INTO `feel_city` VALUES (947, 'USA', 'MT', 'MSO', '米苏拉', 'Missura', '');
INSERT INTO `feel_city` VALUES (948, 'USA', 'MO', 'COV', '哥伦比亚', 'Colombia', '');
INSERT INTO `feel_city` VALUES (949, 'USA', 'MO', 'JEF', '杰佛逊市', 'Jefferson City', '');
INSERT INTO `feel_city` VALUES (950, 'USA', 'MO', 'MKC', '堪萨斯城', 'Kansas City', '');
INSERT INTO `feel_city` VALUES (951, 'USA', 'MO', 'STL', '圣路易斯', 'St. Louis', '');
INSERT INTO `feel_city` VALUES (952, 'USA', 'MO', 'SGF', '斯普林菲尔德', 'Springfield', '');
INSERT INTO `feel_city` VALUES (953, 'USA', 'MS', 'BIX', '比洛克西', 'Biloxi', '');
INSERT INTO `feel_city` VALUES (954, 'USA', 'MS', 'GPT', '格尔夫波特', 'Gulfport', '');
INSERT INTO `feel_city` VALUES (955, 'USA', 'MS', 'GLH', '格林维尔', 'Greenville', '');
INSERT INTO `feel_city` VALUES (956, 'USA', 'MS', 'HBG', '哈蒂斯堡', 'Hattiesburg', '');
INSERT INTO `feel_city` VALUES (957, 'USA', 'MS', 'JAN', '杰克逊', 'Jackson', '');
INSERT INTO `feel_city` VALUES (958, 'USA', 'MS', 'MEI', '默里迪恩', 'Meridian', '');
INSERT INTO `feel_city` VALUES (959, 'USA', 'MS', 'VKS', '维克斯堡', 'Vicksburg', '');
INSERT INTO `feel_city` VALUES (960, 'USA', 'MI', 'ARB', '安娜堡', 'Ann Arbor', '');
INSERT INTO `feel_city` VALUES (961, 'USA', 'MI', 'BTL', '巴特尔克里克', 'Battle Creek', '');
INSERT INTO `feel_city` VALUES (962, 'USA', 'MI', 'BCY', '贝城', 'Bay City', '');
INSERT INTO `feel_city` VALUES (963, 'USA', 'MI', 'GRR', '大急流城', 'Grand Rapids', '');
INSERT INTO `feel_city` VALUES (964, 'USA', 'MI', 'DEO', '迪尔伯恩', 'Dearborn', '');
INSERT INTO `feel_city` VALUES (965, 'USA', 'MI', 'DET', '底特律', 'Detroit', '');
INSERT INTO `feel_city` VALUES (966, 'USA', 'MI', 'FNT', '弗林特', 'Flint', '');
INSERT INTO `feel_city` VALUES (967, 'USA', 'MI', 'WYD', '怀恩多特', 'Wyandotte', '');
INSERT INTO `feel_city` VALUES (968, 'USA', 'MI', 'AZO', '卡拉马袓', 'Karama', '');
INSERT INTO `feel_city` VALUES (969, 'USA', 'MI', 'LAN', '兰辛', 'Lansing', '');
INSERT INTO `feel_city` VALUES (970, 'USA', 'MI', 'MKG', '马斯基根', 'Muskegon', '');
INSERT INTO `feel_city` VALUES (971, 'USA', 'MI', 'PTK', '庞菷亚克', 'Pang Yake', '');
INSERT INTO `feel_city` VALUES (972, 'USA', 'MI', 'SGM', '萨吉诺', 'Sagino', '');
INSERT INTO `feel_city` VALUES (973, 'USA', 'MI', 'SSM', '苏圣玛丽', 'Sault Saint Mary', '');
INSERT INTO `feel_city` VALUES (974, 'USA', 'MI', 'WAM', '沃伦', 'Warren', '');
INSERT INTO `feel_city` VALUES (975, 'USA', 'MI', 'PHN', '休伦港', 'Port Huron', '');
INSERT INTO `feel_city` VALUES (976, 'USA', 'ME', 'BNQ', '班戈', 'Bangor', '');
INSERT INTO `feel_city` VALUES (977, 'USA', 'ME', 'POL', '波特兰', 'Portland', '');
INSERT INTO `feel_city` VALUES (978, 'USA', 'ME', 'QLW', '刘易斯顿', 'Lewiston', '');
INSERT INTO `feel_city` VALUES (979, 'USA', 'MN', 'RST', '罗切斯特', 'Rochester', '');
INSERT INTO `feel_city` VALUES (980, 'USA', 'MN', 'MES', '明尼阿波利斯', 'Minneapolis', '');
INSERT INTO `feel_city` VALUES (981, 'USA', 'MN', 'STP', '圣保罗', 'Sao paulo', '');
INSERT INTO `feel_city` VALUES (982, 'USA', 'SD', 'ABK', '阿伯丁', 'Aberdeen', '');
INSERT INTO `feel_city` VALUES (983, 'USA', 'SD', 'RAP', '拉皮德城', 'Rapid City', '');
INSERT INTO `feel_city` VALUES (984, 'USA', 'SD', 'FSD', '苏福尔斯', 'Sioux Falls', '');
INSERT INTO `feel_city` VALUES (985, 'USA', 'SC', 'NTS', '北查尔斯顿', 'North charleston', '');
INSERT INTO `feel_city` VALUES (986, 'USA', 'SC', 'CHS', '查尔斯顿', 'Charleston', '');
INSERT INTO `feel_city` VALUES (987, 'USA', 'SC', 'COV', '哥伦比亚', 'Colombia', '');
INSERT INTO `feel_city` VALUES (988, 'USA', 'NE', 'OMA', '奥马哈', 'Omaha', '');
INSERT INTO `feel_city` VALUES (989, 'USA', 'NE', 'XDE', '贝尔维尤', 'Bellevue', '');
INSERT INTO `feel_city` VALUES (990, 'USA', 'NE', 'LNK', '林肯', 'Lincoln', '');
INSERT INTO `feel_city` VALUES (991, 'USA', 'NV', 'EKO', '埃尔科', 'Elko', '');
INSERT INTO `feel_city` VALUES (992, 'USA', 'NV', 'NVS', '北拉斯维加斯', 'North Las Vegas', '');
INSERT INTO `feel_city` VALUES (993, 'USA', 'NV', 'VGI', '弗吉尼亚城', 'Virginia City', '');
INSERT INTO `feel_city` VALUES (994, 'USA', 'NV', 'HNZ', '亨德森', 'Henderson', '');
INSERT INTO `feel_city` VALUES (995, 'USA', 'NV', 'CSN', '卡森城', 'Carson City', '');
INSERT INTO `feel_city` VALUES (996, 'USA', 'NV', 'LAS', '拉斯维加斯', 'Las Vegas', '');
INSERT INTO `feel_city` VALUES (997, 'USA', 'NV', 'RNO', '里诺', 'Reno', '');
INSERT INTO `feel_city` VALUES (998, 'USA', 'NV', 'SPK', '斯帕克斯', 'Sparks', '');
INSERT INTO `feel_city` VALUES (999, 'USA', 'NY', 'FFO', '布法罗', 'Buffalo', '');
INSERT INTO `feel_city` VALUES (1000, 'USA', 'NY', 'ROC', '罗切斯特', 'Rochester', '');
INSERT INTO `feel_city` VALUES (1001, 'USA', 'NY', 'QEE', '纽约市', 'New York City', '');
INSERT INTO `feel_city` VALUES (1002, 'USA', 'DE', 'DOR', '多佛', 'Dover', '');
INSERT INTO `feel_city` VALUES (1003, 'USA', 'DE', 'NWK', '纽瓦克', 'Newark', '');
INSERT INTO `feel_city` VALUES (1004, 'USA', 'DE', 'ILG', '威明顿', 'Wilmington', '');
INSERT INTO `feel_city` VALUES (1005, 'USA', 'TN', 'BSJ', '布利斯托', 'Bristo', '');
INSERT INTO `feel_city` VALUES (1006, 'USA', 'TN', 'CHA', '查塔努加', 'Chattanooga', '');
INSERT INTO `feel_city` VALUES (1007, 'USA', 'TN', 'TRI', '金斯波特', 'Kingsport', '');
INSERT INTO `feel_city` VALUES (1008, 'USA', 'TN', 'MEM', '孟菲斯', 'Memphis', '');
INSERT INTO `feel_city` VALUES (1009, 'USA', 'TN', 'BNA', '纳什维尔', 'Nashville', '');
INSERT INTO `feel_city` VALUES (1010, 'USA', 'TN', 'TYS', '诺克斯维尔', 'Knoxville', '');
INSERT INTO `feel_city` VALUES (1011, 'USA', 'TN', 'YTC', '三城区', 'Sancheng District', '');
INSERT INTO `feel_city` VALUES (1012, 'USA', 'TN', 'MQY', '士麦那', 'Smyrna', '');
INSERT INTO `feel_city` VALUES (1013, 'USA', 'TN', 'RGI', '斯普林希尔', 'Spring Hill', '');
INSERT INTO `feel_city` VALUES (1014, 'USA', 'TN', 'JCY', '约翰逊城', 'Johnson City', '');
INSERT INTO `feel_city` VALUES (1015, 'USA', 'WI', 'ATW', '阿普尓顿', 'Appleton', '');
INSERT INTO `feel_city` VALUES (1016, 'USA', 'WI', 'OSH', '奥什科什', 'Oshkosh', '');
INSERT INTO `feel_city` VALUES (1017, 'USA', 'WI', 'GBK', '格林贝', 'Green Bay', '');
INSERT INTO `feel_city` VALUES (1018, 'USA', 'WI', 'ENW', '基诺沙', 'Kenosha', '');
INSERT INTO `feel_city` VALUES (1019, 'USA', 'WI', 'LSE', '拉克罗斯', 'La Crosse', '');
INSERT INTO `feel_city` VALUES (1020, 'USA', 'WI', 'RAC', '拉辛', 'Racine', '');
INSERT INTO `feel_city` VALUES (1021, 'USA', 'WI', 'MTW', '马尼托沃克', 'Manitowoc', '');
INSERT INTO `feel_city` VALUES (1022, 'USA', 'WI', 'QMD', '迈迪逊', 'Madison', '');
INSERT INTO `feel_city` VALUES (1023, 'USA', 'WI', 'MKE', '密尔沃基', 'Milwaukee', '');
INSERT INTO `feel_city` VALUES (1024, 'USA', 'WI', 'EAU', '欧克莱尓', 'Oakley', '');
INSERT INTO `feel_city` VALUES (1025, 'USA', 'WI', 'AUW', '沃索', 'Wausau', '');
INSERT INTO `feel_city` VALUES (1026, 'USA', 'WI', 'SBM', '希博伊根', 'Sheboygan', '');
INSERT INTO `feel_city` VALUES (1027, 'USA', 'VA', 'VAB', '弗吉尼亚比奇', 'Virginia Beach', '');
INSERT INTO `feel_city` VALUES (1028, 'USA', 'VA', 'ORF', '诺福克', 'Norfolk', '');
INSERT INTO `feel_city` VALUES (1029, 'USA', 'VA', 'HTW', '切萨皮克', 'Chesapeake', '');
INSERT INTO `feel_city` VALUES (1030, 'USA', 'WV', 'CRW', '查尔斯顿', 'Charleston', '');
INSERT INTO `feel_city` VALUES (1031, 'USA', 'WV', 'HNU', '亨廷顿', 'Huntington', '');
INSERT INTO `feel_city` VALUES (1032, 'USA', 'WV', 'PKB', '帕克斯堡', 'Parksburg', '');
INSERT INTO `feel_city` VALUES (1033, 'USA', 'HI', 'KHH', '凯卢阿', 'Kailua', '');
INSERT INTO `feel_city` VALUES (1034, 'USA', 'HI', 'HNL', '檀香山', 'Honolulu', '');
INSERT INTO `feel_city` VALUES (1035, 'USA', 'HI', 'ITO', '希洛', 'Hilo', '');
INSERT INTO `feel_city` VALUES (1036, 'USA', 'NH', 'CON', '康科德', 'Concord', '');
INSERT INTO `feel_city` VALUES (1037, 'USA', 'NH', 'MHT', '曼彻斯特', 'Manchester', '');
INSERT INTO `feel_city` VALUES (1038, 'USA', 'NH', 'ASH', '纳舒厄', 'Nashua', '');
INSERT INTO `feel_city` VALUES (1039, 'USA', 'NM', 'ABQ', '阿尔伯克基', 'Albuquerque', '');
INSERT INTO `feel_city` VALUES (1040, 'USA', 'NM', 'LRU', '拉斯克鲁塞斯', 'Las Cruces', '');
INSERT INTO `feel_city` VALUES (1041, 'USA', 'NM', 'ROW', '罗斯韦尔', 'Roswell', '');
INSERT INTO `feel_city` VALUES (1042, 'USA', 'NM', 'SAF', '圣菲', 'Santa Fe', '');
INSERT INTO `feel_city` VALUES (1043, 'USA', 'NJ', 'NRK', '纽瓦克', 'Newark', '');
INSERT INTO `feel_city` VALUES (1044, 'USA', 'NJ', 'PAT', '帕特森', 'Patterson', '');
INSERT INTO `feel_city` VALUES (1045, 'USA', 'NJ', 'JEC', '泽西城', 'Jersey City', '');
INSERT INTO `feel_city` VALUES (1046, 'USA', 'AZ', 'PHX', '凤凰城', 'Phoenix city', '');
INSERT INTO `feel_city` VALUES (1047, 'USA', 'AZ', 'GDA', '格兰代尔', 'Granddale', '');
INSERT INTO `feel_city` VALUES (1048, 'USA', 'AZ', 'MQA', '梅萨', 'Mesa', '');
INSERT INTO `feel_city` VALUES (1049, 'USA', 'AZ', 'STZ', '史卡兹代尔', 'Skazdale', '');
INSERT INTO `feel_city` VALUES (1050, 'USA', 'AZ', 'TPE', '坦普', 'Temple', '');
INSERT INTO `feel_city` VALUES (1051, 'USA', 'AZ', 'TUC', '图森', 'Tucson', '');
INSERT INTO `feel_city` VALUES (1052, 'USA', 'AZ', 'YUM', '优玛', 'Yuma', '');
INSERT INTO `feel_city` VALUES (1053, 'USA', 'IL', 'ALN', '奥尔顿', 'Alton', '');
INSERT INTO `feel_city` VALUES (1054, 'USA', 'IL', 'AUZ', '奥罗拉', 'Aurora', '');
INSERT INTO `feel_city` VALUES (1055, 'USA', 'IL', 'BLO', '布卢明顿', 'Bloomington', '');
INSERT INTO `feel_city` VALUES (1056, 'USA', 'IL', 'DVI', '丹维尓', 'Dan Wei', '');
INSERT INTO `feel_city` VALUES (1057, 'USA', 'IL', 'DEK', '迪卡尔布', 'DeKalb', '');
INSERT INTO `feel_city` VALUES (1058, 'USA', 'IL', 'DEC', '迪凯持', 'Dikai', '');
INSERT INTO `feel_city` VALUES (1059, 'USA', 'IL', 'ESL', '东圣路易斯', 'East St. Louis', '');
INSERT INTO `feel_city` VALUES (1060, 'USA', 'IL', 'CMI', '厄巴纳香槟', 'Urbana Champagne', '');
INSERT INTO `feel_city` VALUES (1061, 'USA', 'IL', 'GSU', '盖尔斯堡', 'Galesburg', '');
INSERT INTO `feel_city` VALUES (1062, 'USA', 'IL', 'MDH', '卡本代尔', 'Carbondale', '');
INSERT INTO `feel_city` VALUES (1063, 'USA', 'IL', 'RKI', '罗克艾兰', 'Rock Island', '');
INSERT INTO `feel_city` VALUES (1064, 'USA', 'IL', 'RFD', '罗克福德', 'Rockford', '');
INSERT INTO `feel_city` VALUES (1065, 'USA', 'IL', 'NOM', '诺黙尔', 'Noel', '');
INSERT INTO `feel_city` VALUES (1066, 'USA', 'IL', 'PLA', '皮奥里亚', 'Peoria', '');
INSERT INTO `feel_city` VALUES (1067, 'USA', 'IL', 'CRA', '森特勒利亚', 'Centralia', '');
INSERT INTO `feel_city` VALUES (1068, 'USA', 'IL', 'SPI', '斯普林菲尔德', 'Springfield', '');
INSERT INTO `feel_city` VALUES (1069, 'USA', 'IL', 'UGN', '沃其根', 'Woqigen', '');
INSERT INTO `feel_city` VALUES (1070, 'USA', 'IL', 'CHI', '芝加哥', 'Chicago', '');
INSERT INTO `feel_city` VALUES (1071, 'USA', 'IN', 'EVV', '埃文斯维尔', 'Evansville', '');
INSERT INTO `feel_city` VALUES (1072, 'USA', 'IN', 'FWA', '韦恩堡', 'Fort Wayne', '');
INSERT INTO `feel_city` VALUES (1073, 'USA', 'IN', 'IND', '印第安纳波利斯', 'Indianapolis', '');
INSERT INTO `feel_city` VALUES (1074, 'USA', 'UT', 'OGD', '奥格登', 'Ogden', '');
INSERT INTO `feel_city` VALUES (1075, 'USA', 'UT', 'LTJ', '雷登', 'Ryden', '');
INSERT INTO `feel_city` VALUES (1076, 'USA', 'UT', 'OEU', '欧仁', 'Eugene', '');
INSERT INTO `feel_city` VALUES (1077, 'USA', 'UT', 'PAC', '帕克城', 'Park City', '');
INSERT INTO `feel_city` VALUES (1078, 'USA', 'UT', 'PVU', '普罗沃', 'Provo', '');
INSERT INTO `feel_city` VALUES (1079, 'USA', 'UT', 'SGU', '圣乔治', 'St. George', '');
INSERT INTO `feel_city` VALUES (1080, 'USA', 'UT', 'WVC', '西瓦利城', 'West Valley City', '');
INSERT INTO `feel_city` VALUES (1081, 'USA', 'UT', 'SLC', '盐湖城', 'Salt Lake City', '');
INSERT INTO `feel_city` VALUES (1082, 'USA', 'GA', 'AUT', '奥古斯塔', 'Augusta', '');
INSERT INTO `feel_city` VALUES (1083, 'USA', 'GA', 'CZX', '哥伦布', 'Columbus', '');
INSERT INTO `feel_city` VALUES (1084, 'USA', 'GA', 'MCN', '梅肯', 'Macon', '');
INSERT INTO `feel_city` VALUES (1085, 'USA', 'GA', 'SAV', '沙瓦纳', 'Shawana', '');
INSERT INTO `feel_city` VALUES (1086, 'USA', 'GA', 'TAT', '亚特兰大', 'Atlanta', '');
INSERT INTO `feel_city` VALUES (1087, 'GBR', 'NIR', 'BFS', '贝尔法斯特', 'Belfast', '');
INSERT INTO `feel_city` VALUES (1088, 'GBR', 'NIR', 'DRY', '德里', 'Delhi', '');
INSERT INTO `feel_city` VALUES (1089, 'GBR', 'NIR', 'LSB', '利斯本', 'Lisburn', '');
INSERT INTO `feel_city` VALUES (1090, 'GBR', 'NIR', 'NYM', '纽里', 'Newry', '');
INSERT INTO `feel_city` VALUES (1091, 'GBR', 'SCT', 'ABD', '阿伯丁', 'Aberdeen', '');
INSERT INTO `feel_city` VALUES (1092, 'GBR', 'SCT', 'EDH', '爱丁堡', 'Edinburgh', '');
INSERT INTO `feel_city` VALUES (1093, 'GBR', 'SCT', 'DND', '丹迪', 'Dandy', '');
INSERT INTO `feel_city` VALUES (1094, 'GBR', 'SCT', 'GLG', '格拉斯哥', 'Glasgow', '');
INSERT INTO `feel_city` VALUES (1095, 'GBR', 'SCT', 'STG', '斯特灵', 'Sterling', '');
INSERT INTO `feel_city` VALUES (1096, 'GBR', 'SCT', 'INV', '因弗内斯', 'Inverness', '');
INSERT INTO `feel_city` VALUES (1097, 'GBR', 'WLS', 'BAN', '班戈', 'Bangor', '');
INSERT INTO `feel_city` VALUES (1098, 'GBR', 'WLS', 'CDF', '卡迪夫', 'Cardiff', '');
INSERT INTO `feel_city` VALUES (1099, 'GBR', 'WLS', 'NWP', '纽波特', 'Newport', '');
INSERT INTO `feel_city` VALUES (1100, 'GBR', 'WLS', 'SWA', '斯旺西', 'Swansea', '');
INSERT INTO `feel_city` VALUES (1101, 'GBR', 'ENG', 'EXE', '埃克塞特', 'Exeter', '');
INSERT INTO `feel_city` VALUES (1102, 'GBR', 'ENG', 'BAS', '巴斯', 'Bath', '');
INSERT INTO `feel_city` VALUES (1103, 'GBR', 'ENG', 'PTE', '彼得伯勒', 'Peterborough', '');
INSERT INTO `feel_city` VALUES (1104, 'GBR', 'ENG', 'BIR', '伯明翰', 'Birmingham', '');
INSERT INTO `feel_city` VALUES (1105, 'GBR', 'ENG', 'BRD', '布拉德福德', 'Bradford', '');
INSERT INTO `feel_city` VALUES (1106, 'GBR', 'ENG', 'BNH', '布莱顿与赫福', 'Brighton and Herford', '');
INSERT INTO `feel_city` VALUES (1107, 'GBR', 'ENG', 'BST', '布里斯托尔', 'Bristol', '');
INSERT INTO `feel_city` VALUES (1108, 'GBR', 'ENG', 'DER', '德比', 'Derby', '');
INSERT INTO `feel_city` VALUES (1109, 'GBR', 'ENG', 'DUR', '德罕', 'Dehan', '');
INSERT INTO `feel_city` VALUES (1110, 'GBR', 'ENG', 'GLO', '格洛斯特', 'Gloucester', '');
INSERT INTO `feel_city` VALUES (1111, 'GBR', 'ENG', 'KUH', '赫尔河畔京斯敦', 'Kingston upon Hull', '');
INSERT INTO `feel_city` VALUES (1112, 'GBR', 'ENG', 'HAF', '赫里福德', 'Hereford', '');
INSERT INTO `feel_city` VALUES (1113, 'GBR', 'ENG', 'CAM', '剑桥', 'Cambridge', '');
INSERT INTO `feel_city` VALUES (1114, 'GBR', 'ENG', 'CAX', '卡莱尔', 'Carlisle', '');
INSERT INTO `feel_city` VALUES (1115, 'GBR', 'ENG', 'CNG', '坎特伯雷', 'Canterbury', '');
INSERT INTO `feel_city` VALUES (1116, 'GBR', 'ENG', 'COV', '考文垂', 'Coventry', '');
INSERT INTO `feel_city` VALUES (1117, 'GBR', 'ENG', 'LAN', '兰开斯特', 'Lancaster', '');
INSERT INTO `feel_city` VALUES (1118, 'GBR', 'ENG', 'RIP', '里彭', 'Ripon', '');
INSERT INTO `feel_city` VALUES (1119, 'GBR', 'ENG', 'LHF', '利奇菲尔德', 'Lichfield', '');
INSERT INTO `feel_city` VALUES (1120, 'GBR', 'ENG', 'LIV', '利物浦', 'Liverpool', '');
INSERT INTO `feel_city` VALUES (1121, 'GBR', 'ENG', 'LDS', '利茲', 'Leeds', '');
INSERT INTO `feel_city` VALUES (1122, 'GBR', 'ENG', 'LCE', '列斯特', 'Lester', '');
INSERT INTO `feel_city` VALUES (1123, 'GBR', 'ENG', 'LCN', '林肯', 'Lincoln', '');
INSERT INTO `feel_city` VALUES (1124, 'GBR', 'ENG', 'LND', '伦敦', 'London', '');
INSERT INTO `feel_city` VALUES (1125, 'GBR', 'ENG', 'MAN', '曼彻斯特', 'Manchester', '');
INSERT INTO `feel_city` VALUES (1126, 'GBR', 'ENG', 'STH', '南安普敦', 'Southampton', '');
INSERT INTO `feel_city` VALUES (1127, 'GBR', 'ENG', 'OXF', '牛津', 'Oxford', '');
INSERT INTO `feel_city` VALUES (1128, 'GBR', 'ENG', 'NCL', '纽卡斯尔', 'Newcastle', '');
INSERT INTO `feel_city` VALUES (1129, 'GBR', 'ENG', 'NGM', '诺丁汉', 'Nottingham', '');
INSERT INTO `feel_city` VALUES (1130, 'GBR', 'ENG', 'NRW', '诺里奇', 'Norwich', '');
INSERT INTO `feel_city` VALUES (1131, 'GBR', 'ENG', 'POR', '朴茨茅斯', 'Portsmouth', '');
INSERT INTO `feel_city` VALUES (1132, 'GBR', 'ENG', 'PRE', '普雷斯顿', 'Preston', '');
INSERT INTO `feel_city` VALUES (1133, 'GBR', 'ENG', 'PLY', '普利茅斯', 'Plymouth', '');
INSERT INTO `feel_city` VALUES (1134, 'GBR', 'ENG', 'CST', '奇切斯特', 'Chichester', '');
INSERT INTO `feel_city` VALUES (1135, 'GBR', 'ENG', 'CEG', '切斯特', 'Chester', '');
INSERT INTO `feel_city` VALUES (1136, 'GBR', 'ENG', 'SUN', '桑德兰', 'Sunderland', '');
INSERT INTO `feel_city` VALUES (1137, 'GBR', 'ENG', 'TBL', '圣阿本斯', 'Saint abens', '');
INSERT INTO `feel_city` VALUES (1138, 'GBR', 'ENG', 'SLS', '索尔斯堡', 'Solsberg', '');
INSERT INTO `feel_city` VALUES (1139, 'GBR', 'ENG', 'SLF', '索福特', 'Soufford', '');
INSERT INTO `feel_city` VALUES (1140, 'GBR', 'ENG', 'TRU', '特鲁罗', 'Truro', '');
INSERT INTO `feel_city` VALUES (1141, 'GBR', 'ENG', 'SOT', '特伦特河畔斯多克', 'Stoke-on-Trent', '');
INSERT INTO `feel_city` VALUES (1142, 'GBR', 'ENG', 'WLS', '威尔斯', 'Wells', '');
INSERT INTO `feel_city` VALUES (1143, 'GBR', 'ENG', 'WKF', '韦克菲尔德', 'Wakefield', '');
INSERT INTO `feel_city` VALUES (1144, 'GBR', 'ENG', 'WNE', '温彻斯特', 'Winchester', '');
INSERT INTO `feel_city` VALUES (1145, 'GBR', 'ENG', 'WOV', '伍尔弗汉普顿', 'Wolverhampton', '');
INSERT INTO `feel_city` VALUES (1146, 'GBR', 'ENG', 'WOR', '伍斯特', 'Worcester', '');
INSERT INTO `feel_city` VALUES (1147, 'GBR', 'ENG', 'SHE', '谢菲尔德', 'Sheffield', '');
INSERT INTO `feel_city` VALUES (1148, 'GBR', 'ENG', 'ELY', '伊利', 'Erie', '');
INSERT INTO `feel_city` VALUES (1149, 'GBR', 'ENG', 'YOR', '约克', 'York', '');

-- ----------------------------
-- Table structure for feel_company
-- ----------------------------
DROP TABLE IF EXISTS `feel_company`;
CREATE TABLE `feel_company`  (
  `company_id` int(11) NOT NULL AUTO_INCREMENT,
  `seller_id` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT 'FeelChat商户ID',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `login_token` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `address` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `logo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `logo_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `tel` varchar(13) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '联系人电话',
  `mobile` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `link` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `max_upload_size` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `en_auth` tinyint(2) NOT NULL DEFAULT 20 COMMENT '英文版权限 10 有 20 无',
  `jp_auth` tinyint(2) NOT NULL DEFAULT 20 COMMENT '日文版权限 10 有 20 无',
  `ticket_auth` tinyint(2) NOT NULL DEFAULT 20 COMMENT '工单系统 10 有 20 无',
  `banner` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `allow_num` int(11) NOT NULL DEFAULT 0 COMMENT '坐席数量',
  `create_time` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`company_id`) USING BTREE,
  INDEX `company_index`(`company_id`, `login_token`) USING BTREE,
  INDEX `company_id`(`company_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of feel_company
-- ----------------------------
INSERT INTO `feel_company` VALUES (1, '', '成都菲莱克斯科技有限公司', 'aace595drTvcjTAXN8fTZ3fDtMFk4JAgdUBFMIAVEHTxYc', '', '', '', '', '', '', '104857600', 20, 20, 10, '', 0, 1623987441);

-- ----------------------------
-- Table structure for feel_company_audit
-- ----------------------------
DROP TABLE IF EXISTS `feel_company_audit`;
CREATE TABLE `feel_company_audit`  (
  `audit_id` int(11) NOT NULL AUTO_INCREMENT,
  `company_id` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `open_time` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '开通时间',
  `due_time` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '到期时间',
  `open_type` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '1试用 2正式',
  `activity` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否可用 1禁用 2可用',
  PRIMARY KEY (`audit_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = FIXED;

-- ----------------------------
-- Records of feel_company_audit
-- ----------------------------
INSERT INTO `feel_company_audit` VALUES (1, 1, 1623987464, 1655523464, 2, 2);

-- ----------------------------
-- Table structure for feel_company_ticketview
-- ----------------------------
DROP TABLE IF EXISTS `feel_company_ticketview`;
CREATE TABLE `feel_company_ticketview`  (
  `company_id` int(11) NOT NULL,
  `view_id` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `is_show` tinyint(2) UNSIGNED NULL DEFAULT 10 COMMENT '是否显示 10 显示 20 不显示'
) ENGINE = MyISAM CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = FIXED;

-- ----------------------------
-- Records of feel_company_ticketview
-- ----------------------------
INSERT INTO `feel_company_ticketview` VALUES (1, 1, 10);
INSERT INTO `feel_company_ticketview` VALUES (1, 2, 10);
INSERT INTO `feel_company_ticketview` VALUES (1, 3, 10);
INSERT INTO `feel_company_ticketview` VALUES (1, 4, 10);
INSERT INTO `feel_company_ticketview` VALUES (1, 5, 10);
INSERT INTO `feel_company_ticketview` VALUES (1, 6, 10);
INSERT INTO `feel_company_ticketview` VALUES (1, 7, 10);
INSERT INTO `feel_company_ticketview` VALUES (1, 8, 10);
INSERT INTO `feel_company_ticketview` VALUES (1, 9, 10);
INSERT INTO `feel_company_ticketview` VALUES (1, 10, 10);
INSERT INTO `feel_company_ticketview` VALUES (1, 11, 10);
INSERT INTO `feel_company_ticketview` VALUES (1, 14, 10);

-- ----------------------------
-- Table structure for feel_company_version
-- ----------------------------
DROP TABLE IF EXISTS `feel_company_version`;
CREATE TABLE `feel_company_version`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `version_id` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `update_time` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `create_time` int(11) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = FIXED;

-- ----------------------------
-- Records of feel_company_version
-- ----------------------------
INSERT INTO `feel_company_version` VALUES (1, 1, 1, 0, 1623987458);

-- ----------------------------
-- Table structure for feel_country
-- ----------------------------
DROP TABLE IF EXISTS `feel_country`;
CREATE TABLE `feel_country`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `code` char(3) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '编码',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '国家名称',
  `name_en` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '英文名称',
  `name_jp` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '日文名称',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `code`(`code`) USING BTREE,
  INDEX `name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 253 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of feel_country
-- ----------------------------
INSERT INTO `feel_country` VALUES (1, '1', '中国', 'China', '');
INSERT INTO `feel_country` VALUES (2, 'ALB', '阿尔巴尼亚', 'Albania', '');
INSERT INTO `feel_country` VALUES (3, 'DZA', '阿尔及利亚', 'Algeria', '');
INSERT INTO `feel_country` VALUES (4, 'AFG', '阿富汗', 'Afghanistan', '');
INSERT INTO `feel_country` VALUES (5, 'ARG', '阿根廷', 'Argentina', '');
INSERT INTO `feel_country` VALUES (6, 'ARE', '阿拉伯联合酋长国', 'United Arab Emirates', '');
INSERT INTO `feel_country` VALUES (7, 'ABW', '阿鲁巴', 'Aruba', '');
INSERT INTO `feel_country` VALUES (8, 'OMN', '阿曼', 'Oman', '');
INSERT INTO `feel_country` VALUES (9, 'AZE', '阿塞拜疆', 'Azerbaijan', '');
INSERT INTO `feel_country` VALUES (10, 'ASC', '阿森松岛', 'Ascension Island', '');
INSERT INTO `feel_country` VALUES (11, 'EGY', '埃及', 'Egypt', '');
INSERT INTO `feel_country` VALUES (12, 'ETH', '埃塞俄比亚', 'Ethiopia', '');
INSERT INTO `feel_country` VALUES (13, 'IRL', '爱尔兰', 'Ireland', '');
INSERT INTO `feel_country` VALUES (14, 'EST', '爱沙尼亚', 'Estonia', '');
INSERT INTO `feel_country` VALUES (15, 'AND', '安道尔', 'Andorra', '');
INSERT INTO `feel_country` VALUES (16, 'AGO', '安哥拉', 'Angola', '');
INSERT INTO `feel_country` VALUES (17, 'AIA', '安圭拉', 'Anguilla', '');
INSERT INTO `feel_country` VALUES (18, 'ATG', '安提瓜和巴布达', 'Antigua and Barbuda', '');
INSERT INTO `feel_country` VALUES (19, 'AUS', '澳大利亚', 'Australia', '');
INSERT INTO `feel_country` VALUES (20, 'AUT', '奥地利', 'Austria', '');
INSERT INTO `feel_country` VALUES (21, 'ALA', '奥兰群岛', 'Aland Islands', '');
INSERT INTO `feel_country` VALUES (22, 'BRB', '巴巴多斯岛', 'Barbados', '');
INSERT INTO `feel_country` VALUES (23, 'PNG', '巴布亚新几内亚', 'Papua New Guinea', '');
INSERT INTO `feel_country` VALUES (24, 'BHS', '巴哈马', 'Bahamas', '');
INSERT INTO `feel_country` VALUES (25, 'PAK', '巴基斯坦', 'Pakistan', '');
INSERT INTO `feel_country` VALUES (26, 'PRY', '巴拉圭', 'Paraguay', '');
INSERT INTO `feel_country` VALUES (27, 'PSE', '巴勒斯坦', 'Palestine', '');
INSERT INTO `feel_country` VALUES (28, 'BHR', '巴林', 'Bahrain', '');
INSERT INTO `feel_country` VALUES (29, 'PAN', '巴拿马', 'Panama', '');
INSERT INTO `feel_country` VALUES (30, 'BRA', '巴西', 'Brazil', '');
INSERT INTO `feel_country` VALUES (31, 'BLR', '白俄罗斯', 'Belarus', '');
INSERT INTO `feel_country` VALUES (32, 'BMU', '百慕大', 'Bermuda', '');
INSERT INTO `feel_country` VALUES (33, 'BGR', '保加利亚', 'Bulgaria', '');
INSERT INTO `feel_country` VALUES (34, 'MNP', '北马里亚纳群岛', 'Northern Mariana Islands', '');
INSERT INTO `feel_country` VALUES (35, 'BEN', '贝宁', 'Benin', '');
INSERT INTO `feel_country` VALUES (36, 'BEL', '比利时', 'Belgium', '');
INSERT INTO `feel_country` VALUES (37, 'ISL', '冰岛', 'Iceland', '');
INSERT INTO `feel_country` VALUES (38, 'PRI', '波多黎各', 'Puerto Rico', '');
INSERT INTO `feel_country` VALUES (39, 'POL', '波兰', 'Poland', '');
INSERT INTO `feel_country` VALUES (40, 'BOL', '玻利维亚', 'Bolivia', '');
INSERT INTO `feel_country` VALUES (41, 'BIH', '波斯尼亚和黑塞哥维那', 'Bosnia and Herzegovina', '');
INSERT INTO `feel_country` VALUES (42, 'BWA', '博茨瓦纳', 'Botswana', '');
INSERT INTO `feel_country` VALUES (43, 'BLZ', '伯利兹', 'Belize', '');
INSERT INTO `feel_country` VALUES (44, 'BTN', '不丹', 'Bhutan', '');
INSERT INTO `feel_country` VALUES (45, 'BFA', '布基纳法索', 'Burkina Faso', '');
INSERT INTO `feel_country` VALUES (46, 'BDI', '布隆迪', 'Burundi', '');
INSERT INTO `feel_country` VALUES (47, 'BVT', '布韦岛', 'Bouvet Island', '');
INSERT INTO `feel_country` VALUES (48, 'PRK', '朝鲜', 'Korea', '');
INSERT INTO `feel_country` VALUES (49, 'DNK', '丹麦', 'Denmark', '');
INSERT INTO `feel_country` VALUES (50, 'DEU', '德国', 'Germany', '');
INSERT INTO `feel_country` VALUES (51, 'TLS', '东帝汶', 'East Timor', '');
INSERT INTO `feel_country` VALUES (52, 'TGO', '多哥', 'Togo', '');
INSERT INTO `feel_country` VALUES (53, 'DMA', '多米尼克', 'Dominica', '');
INSERT INTO `feel_country` VALUES (54, 'DOM', '多米尼加共和国', 'Dominican Republic', '');
INSERT INTO `feel_country` VALUES (55, 'RUS', '俄罗斯', 'Russia', '');
INSERT INTO `feel_country` VALUES (56, 'ECU', '厄瓜多尔', 'Ecuador', '');
INSERT INTO `feel_country` VALUES (57, 'ERI', '厄立特里亚', 'Eritrea', '');
INSERT INTO `feel_country` VALUES (58, 'FRA', '法国', 'France', '');
INSERT INTO `feel_country` VALUES (59, 'FRO', '法罗群岛', 'Faroe Islands', '');
INSERT INTO `feel_country` VALUES (60, 'PYF', '法属波利尼西亚', 'French Polynesia', '');
INSERT INTO `feel_country` VALUES (61, 'GUF', '法属圭亚那', 'French Guiana', '');
INSERT INTO `feel_country` VALUES (62, 'ATF', '法属南部领地', 'French Southern Territories', '');
INSERT INTO `feel_country` VALUES (63, 'VAT', '梵蒂冈', 'Vatican', '');
INSERT INTO `feel_country` VALUES (64, 'PHL', '菲律宾', 'Philippines', '');
INSERT INTO `feel_country` VALUES (65, 'FJI', '斐济', 'Fiji', '');
INSERT INTO `feel_country` VALUES (66, 'FIN', '芬兰', 'Finland', '');
INSERT INTO `feel_country` VALUES (67, 'CPV', '佛得角', 'Cape Verde', '');
INSERT INTO `feel_country` VALUES (68, 'FLK', '弗兰克群岛', 'Frank Islands', '');
INSERT INTO `feel_country` VALUES (69, 'GMB', '冈比亚', 'Gambia', '');
INSERT INTO `feel_country` VALUES (70, 'COG', '刚果', 'Congo', '');
INSERT INTO `feel_country` VALUES (71, 'COD', '刚果民主共和国', 'Democratic Republic of the Congo', '');
INSERT INTO `feel_country` VALUES (72, 'COL', '哥伦比亚', 'Colombia', '');
INSERT INTO `feel_country` VALUES (73, 'CRI', '哥斯达黎加', 'Costa Rica', '');
INSERT INTO `feel_country` VALUES (74, 'GGY', '格恩西岛', 'Guernsey', '');
INSERT INTO `feel_country` VALUES (75, 'GRD', '格林纳达', 'Grenada', '');
INSERT INTO `feel_country` VALUES (76, 'GRL', '格陵兰', 'Greenland', '');
INSERT INTO `feel_country` VALUES (77, 'CUB', '古巴', 'Cuba', '');
INSERT INTO `feel_country` VALUES (78, 'GLP', '瓜德罗普', 'Guadeloupe', '');
INSERT INTO `feel_country` VALUES (79, 'GUM', '关岛', 'Guam', '');
INSERT INTO `feel_country` VALUES (80, 'GUY', '圭亚那', 'Guyana', '');
INSERT INTO `feel_country` VALUES (81, 'KAZ', '哈萨克斯坦', 'Kazakhstan', '');
INSERT INTO `feel_country` VALUES (82, 'HTI', '海地', 'Haiti', '');
INSERT INTO `feel_country` VALUES (83, 'KOR', '韩国', 'Korea', '');
INSERT INTO `feel_country` VALUES (84, 'NLD', '荷兰', 'Netherlands', '');
INSERT INTO `feel_country` VALUES (85, 'ANT', '荷属安地列斯', 'Netherlands Antilles', '');
INSERT INTO `feel_country` VALUES (86, 'HMD', '赫德和麦克唐纳群岛', 'Hurd and McDonald Islands', '');
INSERT INTO `feel_country` VALUES (87, 'HND', '洪都拉斯', 'Honduras', '');
INSERT INTO `feel_country` VALUES (88, 'KIR', '基里巴斯', 'Kiribati', '');
INSERT INTO `feel_country` VALUES (89, 'DJI', '吉布提', 'Djibouti', '');
INSERT INTO `feel_country` VALUES (90, 'KGZ', '吉尔吉斯斯坦', 'Kyrgyzstan', '');
INSERT INTO `feel_country` VALUES (91, 'GIN', '几内亚', 'Guinea', '');
INSERT INTO `feel_country` VALUES (92, 'GNB', '几内亚比绍', 'Guinea-Bissau', '');
INSERT INTO `feel_country` VALUES (93, 'CAN', '加拿大', 'Canada', '');
INSERT INTO `feel_country` VALUES (94, 'GHA', '加纳', 'Ghana', '');
INSERT INTO `feel_country` VALUES (95, 'GAB', '加蓬', 'Gabon', '');
INSERT INTO `feel_country` VALUES (96, 'KHM', '柬埔寨', 'Cambodia', '');
INSERT INTO `feel_country` VALUES (97, 'CZE', '捷克共和国', 'Czech Republic', '');
INSERT INTO `feel_country` VALUES (98, 'ZWE', '津巴布韦', 'Zimbabwe', '');
INSERT INTO `feel_country` VALUES (99, 'CMR', '喀麦隆', 'Cameroon', '');
INSERT INTO `feel_country` VALUES (100, 'QAT', '卡塔尔', 'Qatar', '');
INSERT INTO `feel_country` VALUES (101, 'CYM', '开曼群岛', 'Cayman Islands', '');
INSERT INTO `feel_country` VALUES (102, 'CCK', '科科斯群岛', 'Cocos Islands', '');
INSERT INTO `feel_country` VALUES (103, 'COM', '科摩罗', 'Comoros', '');
INSERT INTO `feel_country` VALUES (104, 'CIV', '科特迪瓦', 'Cote d\'Ivoire', '');
INSERT INTO `feel_country` VALUES (105, 'KWT', '科威特', 'Kuwait', '');
INSERT INTO `feel_country` VALUES (106, 'HRV', '克罗地亚', 'Croatia', '');
INSERT INTO `feel_country` VALUES (107, 'KEN', '肯尼亚', 'Kenya', '');
INSERT INTO `feel_country` VALUES (108, 'COK', '库克群岛', 'Island', '');
INSERT INTO `feel_country` VALUES (109, 'LVA', '拉脱维亚', 'Latvia', '');
INSERT INTO `feel_country` VALUES (110, 'LSO', '莱索托', 'Lesotho', '');
INSERT INTO `feel_country` VALUES (111, 'LAO', '老挝', 'Laos', '');
INSERT INTO `feel_country` VALUES (112, 'LBN', '黎巴嫩', 'Lebanon', '');
INSERT INTO `feel_country` VALUES (113, 'LBR', '利比里亚', 'Liberia', '');
INSERT INTO `feel_country` VALUES (114, 'LBY', '利比亚', 'Libya', '');
INSERT INTO `feel_country` VALUES (115, 'LTU', '立陶宛', 'Lithuania', '');
INSERT INTO `feel_country` VALUES (116, 'LIE', '列支敦士登', 'Liechtenstein', '');
INSERT INTO `feel_country` VALUES (117, 'REU', '留尼汪岛', 'Reunion', '');
INSERT INTO `feel_country` VALUES (118, 'LUX', '卢森堡', 'Luxembourg', '');
INSERT INTO `feel_country` VALUES (119, 'RWA', '卢旺达', 'Rwanda', '');
INSERT INTO `feel_country` VALUES (120, 'ROU', '罗马尼亚', 'Romania', '');
INSERT INTO `feel_country` VALUES (121, 'MDG', '马达加斯加', 'Madagascar', '');
INSERT INTO `feel_country` VALUES (122, 'MDV', '马尔代夫', 'Maldives', '');
INSERT INTO `feel_country` VALUES (123, 'MLT', '马耳他', 'Malta', '');
INSERT INTO `feel_country` VALUES (124, 'MWI', '马拉维', 'Malawi', '');
INSERT INTO `feel_country` VALUES (125, 'MYS', '马来西亚', 'Malaysia', '');
INSERT INTO `feel_country` VALUES (126, 'MLI', '马里', 'Mali', '');
INSERT INTO `feel_country` VALUES (127, 'MKD', '北马其顿', 'Macedonia', '');
INSERT INTO `feel_country` VALUES (128, 'MHL', '马绍尔群岛', 'Marshall Islands', '');
INSERT INTO `feel_country` VALUES (129, 'MTQ', '马提尼克', 'Martinique', '');
INSERT INTO `feel_country` VALUES (130, 'MYT', '马约特岛', 'Mayotte', '');
INSERT INTO `feel_country` VALUES (131, 'IMN', '曼岛', 'Isle of Man', '');
INSERT INTO `feel_country` VALUES (132, 'MUS', '毛里求斯', 'Mauritius', '');
INSERT INTO `feel_country` VALUES (133, 'MRT', '毛里塔尼亚', 'Mauritania', '');
INSERT INTO `feel_country` VALUES (134, 'USA', '美国', 'United States', '');
INSERT INTO `feel_country` VALUES (135, 'ASM', '美属萨摩亚', 'American Samoa', '');
INSERT INTO `feel_country` VALUES (136, 'UMI', '美属外岛', 'US outer island', '');
INSERT INTO `feel_country` VALUES (137, 'MNG', '蒙古', 'Mongolia', '');
INSERT INTO `feel_country` VALUES (138, 'MSR', '蒙特塞拉特', 'Montserrat', '');
INSERT INTO `feel_country` VALUES (139, 'BGD', '孟加拉', 'Bengal', '');
INSERT INTO `feel_country` VALUES (140, 'FSM', '密克罗尼西亚', 'Micronesia', '');
INSERT INTO `feel_country` VALUES (141, 'PER', '秘鲁', 'Peru', '');
INSERT INTO `feel_country` VALUES (142, 'MMR', '缅甸', 'Myanmar', '');
INSERT INTO `feel_country` VALUES (143, 'MDA', '摩尔多瓦', 'Moldova', '');
INSERT INTO `feel_country` VALUES (144, 'MAR', '摩洛哥', 'Morocco', '');
INSERT INTO `feel_country` VALUES (145, 'MCO', '摩纳哥', 'Monaco', '');
INSERT INTO `feel_country` VALUES (146, 'MOZ', '莫桑比克', 'Mozambique', '');
INSERT INTO `feel_country` VALUES (147, 'MEX', '墨西哥', 'Mexico', '');
INSERT INTO `feel_country` VALUES (148, 'NAM', '纳米比亚', 'Namibia', '');
INSERT INTO `feel_country` VALUES (149, 'ZAF', '南非', 'South Africa', '');
INSERT INTO `feel_country` VALUES (150, 'ATA', '南极洲', 'Antarctica', '');
INSERT INTO `feel_country` VALUES (151, 'SGS', '南乔治亚和南桑德威奇群岛', 'South Georgia and South Sandwich Islands', '');
INSERT INTO `feel_country` VALUES (152, 'NRU', '瑙鲁', 'Nauru', '');
INSERT INTO `feel_country` VALUES (153, 'NPL', '尼泊尔', 'Nepal', '');
INSERT INTO `feel_country` VALUES (154, 'NIC', '尼加拉瓜', 'Nicaragua', '');
INSERT INTO `feel_country` VALUES (155, 'NER', '尼日尔', 'Niger', '');
INSERT INTO `feel_country` VALUES (156, 'NGA', '尼日利亚', 'Nigeria', '');
INSERT INTO `feel_country` VALUES (157, 'NIU', '纽埃', 'Niue', '');
INSERT INTO `feel_country` VALUES (158, 'NOR', '挪威', 'Norway', '');
INSERT INTO `feel_country` VALUES (159, 'NFK', '诺福克', 'Norfolk', '');
INSERT INTO `feel_country` VALUES (160, 'PLW', '帕劳', 'Palau', '');
INSERT INTO `feel_country` VALUES (161, 'PCN', '皮特凯恩', 'Pitcairn', '');
INSERT INTO `feel_country` VALUES (162, 'PRT', '葡萄牙', 'Portugal', '');
INSERT INTO `feel_country` VALUES (163, 'GEO', '格鲁吉亚', 'Georgia', '');
INSERT INTO `feel_country` VALUES (164, 'JPN', '日本', 'Japan', '');
INSERT INTO `feel_country` VALUES (165, 'SWE', '瑞典', 'Sweden', '');
INSERT INTO `feel_country` VALUES (166, 'CHE', '瑞士', 'Switzerland', '');
INSERT INTO `feel_country` VALUES (167, 'SLV', '萨尔瓦多', 'Salvador', '');
INSERT INTO `feel_country` VALUES (168, 'WSM', '萨摩亚', 'Samoa', '');
INSERT INTO `feel_country` VALUES (169, 'SCG', '塞尔维亚', 'Serbia, Montenegro', '');
INSERT INTO `feel_country` VALUES (170, 'SLE', '塞拉利昂', 'Sierra Leone', '');
INSERT INTO `feel_country` VALUES (171, 'SEN', '塞内加尔', 'Senegal', '');
INSERT INTO `feel_country` VALUES (172, 'CYP', '塞浦路斯', 'Cyprus', '');
INSERT INTO `feel_country` VALUES (173, 'SYC', '塞舌尔', 'Seychelles', '');
INSERT INTO `feel_country` VALUES (174, 'SAU', '沙特阿拉伯', 'Saudi Arabia', '');
INSERT INTO `feel_country` VALUES (175, 'CXR', '圣诞岛', 'Christmas Island', '');
INSERT INTO `feel_country` VALUES (176, 'STP', '圣多美和普林西比', 'Sao Tome and Principe', '');
INSERT INTO `feel_country` VALUES (177, 'SHN', '圣赫勒拿', 'St. Helena', '');
INSERT INTO `feel_country` VALUES (178, 'KNA', '圣基茨和尼维斯', 'Saint Kitts and Nevis', '');
INSERT INTO `feel_country` VALUES (179, 'LCA', '圣卢西亚', 'Saint Lucia', '');
INSERT INTO `feel_country` VALUES (180, 'SMR', '圣马力诺', 'San Marino', '');
INSERT INTO `feel_country` VALUES (181, 'SPM', '圣皮埃尔和密克隆群岛', 'Saint Pierre and Miquelon', '');
INSERT INTO `feel_country` VALUES (182, 'VCT', '圣文森特和格林纳丁斯', 'Saint Vincent and the Grenadines', '');
INSERT INTO `feel_country` VALUES (183, 'LKA', '斯里兰卡', 'Sri Lanka', '');
INSERT INTO `feel_country` VALUES (184, 'SVK', '斯洛伐克', 'Slovakia', '');
INSERT INTO `feel_country` VALUES (185, 'SVN', '斯洛文尼亚', 'Slovenia', '');
INSERT INTO `feel_country` VALUES (186, 'SJM', '斯瓦尔巴和扬马廷', 'Svalbard and Jan Martin', '');
INSERT INTO `feel_country` VALUES (187, 'SWZ', '斯威士兰', 'Swaziland', '');
INSERT INTO `feel_country` VALUES (188, 'SDN', '苏丹', 'Sudan', '');
INSERT INTO `feel_country` VALUES (189, 'SUR', '苏里南', 'Suriname', '');
INSERT INTO `feel_country` VALUES (190, 'SLB', '所罗门群岛', 'Solomon Islands', '');
INSERT INTO `feel_country` VALUES (191, 'SOM', '索马里', 'Somalia', '');
INSERT INTO `feel_country` VALUES (192, 'TJK', '塔吉克斯坦', 'Tajikistan', '');
INSERT INTO `feel_country` VALUES (193, 'THA', '泰国', 'Thailand', '');
INSERT INTO `feel_country` VALUES (194, 'TZA', '坦桑尼亚', 'Tanzania', '');
INSERT INTO `feel_country` VALUES (195, 'TON', '汤加', 'Tonga', '');
INSERT INTO `feel_country` VALUES (196, 'TCA', '特克斯和凯科斯群岛', 'Turks and Cactus', '');
INSERT INTO `feel_country` VALUES (197, 'TAA', '特里斯坦达昆哈', 'Tristanda Kunha', '');
INSERT INTO `feel_country` VALUES (198, 'TTO', '特立尼达和多巴哥', 'Trinidad and Tobago', '');
INSERT INTO `feel_country` VALUES (199, 'TUN', '突尼斯', 'Tunisia', '');
INSERT INTO `feel_country` VALUES (200, 'TUV', '图瓦卢', 'Tuvalu', '');
INSERT INTO `feel_country` VALUES (201, 'TUR', '土耳其', 'Turkey', '');
INSERT INTO `feel_country` VALUES (202, 'TKM', '土库曼斯坦', 'Turkmenistan', '');
INSERT INTO `feel_country` VALUES (203, 'TKL', '托克劳', 'Tokelau', '');
INSERT INTO `feel_country` VALUES (204, 'WLF', '瓦利斯和富图纳', 'Wallis and Futuna', '');
INSERT INTO `feel_country` VALUES (205, 'VUT', '瓦努阿图', 'Vanuatu', '');
INSERT INTO `feel_country` VALUES (206, 'GTM', '危地马拉', 'Guatemala', '');
INSERT INTO `feel_country` VALUES (207, 'VIR', '维尔京群岛，美属', 'Virgin Islands, US', '');
INSERT INTO `feel_country` VALUES (208, 'VGB', '维尔京群岛，英属', 'Virgin Islands, British', '');
INSERT INTO `feel_country` VALUES (209, 'VEN', '委内瑞拉', 'Venezuela', '');
INSERT INTO `feel_country` VALUES (210, 'BRN', '文莱', 'Brunei', '');
INSERT INTO `feel_country` VALUES (211, 'UGA', '乌干达', 'Uganda', '');
INSERT INTO `feel_country` VALUES (212, 'UKR', '乌克兰', 'Ukraine', '');
INSERT INTO `feel_country` VALUES (213, 'URY', '乌拉圭', 'Uruguay', '');
INSERT INTO `feel_country` VALUES (214, 'UZB', '乌兹别克斯坦', 'Uzbekistan', '');
INSERT INTO `feel_country` VALUES (215, 'ESP', '西班牙', 'Spain', '');
INSERT INTO `feel_country` VALUES (216, 'GRC', '希腊', 'Greece', '');
INSERT INTO `feel_country` VALUES (217, 'SGP', '新加坡', 'Singapore', '');
INSERT INTO `feel_country` VALUES (218, 'NCL', '新喀里多尼亚', 'New Caledonia', '');
INSERT INTO `feel_country` VALUES (219, 'NZL', '新西兰', 'new Zealand', '');
INSERT INTO `feel_country` VALUES (220, 'HUN', '匈牙利', 'Hungary', '');
INSERT INTO `feel_country` VALUES (221, 'SYR', '叙利亚', 'Syria', '');
INSERT INTO `feel_country` VALUES (222, 'JAM', '牙买加', 'Jamaica', '');
INSERT INTO `feel_country` VALUES (223, 'ARM', '亚美尼亚', 'Armenia', '');
INSERT INTO `feel_country` VALUES (224, 'YEM', '也门', 'Yemen', '');
INSERT INTO `feel_country` VALUES (225, 'IRQ', '伊拉克', 'Iraq', '');
INSERT INTO `feel_country` VALUES (226, 'IRN', '伊朗', 'Iran', '');
INSERT INTO `feel_country` VALUES (227, 'ISR', '以色列', 'Israel', '');
INSERT INTO `feel_country` VALUES (228, 'ITA', '意大利', 'Italy', '');
INSERT INTO `feel_country` VALUES (229, 'IND', '印度', 'India', '');
INSERT INTO `feel_country` VALUES (230, 'IDN', '印度尼西亚', 'Indonesia', '');
INSERT INTO `feel_country` VALUES (231, 'GBR', '英国', 'United Kingdom', '');
INSERT INTO `feel_country` VALUES (232, 'IOT', '英属印度洋领地', 'British Indian Ocean Territory', '');
INSERT INTO `feel_country` VALUES (233, 'JOR', '约旦', 'Jordan', '');
INSERT INTO `feel_country` VALUES (234, 'VNM', '越南', 'Vietnam', '');
INSERT INTO `feel_country` VALUES (235, 'ZMB', '赞比亚', 'Zambia', '');
INSERT INTO `feel_country` VALUES (236, 'JEY', '泽西岛', 'Jersey', '');
INSERT INTO `feel_country` VALUES (237, 'TCD', '乍得', 'Chad', '');
INSERT INTO `feel_country` VALUES (238, 'GIB', '直布罗陀', 'Gibraltar', '');
INSERT INTO `feel_country` VALUES (239, 'CHL', '智利', 'Chile', '');
INSERT INTO `feel_country` VALUES (240, 'CAF', '中非共和国', 'Central African Republic', '');
INSERT INTO `feel_country` VALUES (241, 'MNE', '黑山', '', '');
INSERT INTO `feel_country` VALUES (242, 'SSD', '南苏丹', '', '');
INSERT INTO `feel_country` VALUES (243, 'GNQ', '赤道几内亚', '', '');
INSERT INTO `feel_country` VALUES (244, 'EH', '西撒哈拉', '', '');
INSERT INTO `feel_country` VALUES (245, 'EMT', '荷属圣马丁', '', '');
INSERT INTO `feel_country` VALUES (246, 'SMT', '法属圣马丁', '', '');
INSERT INTO `feel_country` VALUES (247, 'KLS', '库拉索', '', '');
INSERT INTO `feel_country` VALUES (248, 'SBT', '圣巴泰勒米岛', '', '');
INSERT INTO `feel_country` VALUES (249, 'MRW', '马尔维纳斯群岛', '', '');
INSERT INTO `feel_country` VALUES (250, 'YSE', '亚速尔群岛', '', '');
INSERT INTO `feel_country` VALUES (251, 'MDL', '马德拉群岛', '', '');
INSERT INTO `feel_country` VALUES (252, 'JNL', '加那利群岛', '', '');

-- ----------------------------
-- Table structure for feel_error_log
-- ----------------------------
DROP TABLE IF EXISTS `feel_error_log`;
CREATE TABLE `feel_error_log`  (
  `log_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `error_type` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '错误类型\r\ninsert 增加数据；\r\ndelete 删除数据；\r\nupdate 修改数据;\r\nselect 查询数据',
  `error_title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '错误名称',
  `error_content` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '错误内容',
  `create_time` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '创建时间',
  PRIMARY KEY (`log_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统错误日志' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of feel_error_log
-- ----------------------------

-- ----------------------------
-- Table structure for feel_fastreply
-- ----------------------------
DROP TABLE IF EXISTS `feel_fastreply`;
CREATE TABLE `feel_fastreply`  (
  `fast_id` int(11) NOT NULL AUTO_INCREMENT,
  `company_id` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `fast_type_id` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `fast_title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `fast_content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `activity` tinyint(1) UNSIGNED NOT NULL DEFAULT 2 COMMENT '是否启用 1 禁用 2启用',
  `create_time` int(11) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`fast_id`) USING BTREE,
  INDEX `fast_index`(`fast_id`, `company_id`, `fast_type_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of feel_fastreply
-- ----------------------------

-- ----------------------------
-- Table structure for feel_fastreply_type
-- ----------------------------
DROP TABLE IF EXISTS `feel_fastreply_type`;
CREATE TABLE `feel_fastreply_type`  (
  `fast_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `company_id` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `type_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `create_time` int(11) UNSIGNED NULL DEFAULT 0,
  PRIMARY KEY (`fast_type_id`) USING BTREE,
  INDEX `fast_type_index`(`fast_type_id`, `company_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of feel_fastreply_type
-- ----------------------------

-- ----------------------------
-- Table structure for feel_group
-- ----------------------------
DROP TABLE IF EXISTS `feel_group`;
CREATE TABLE `feel_group`  (
  `group_id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '管理员ID',
  `company_id` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `department_id` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '加密的部门ID',
  `original_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '第三方系统中的部门ID\r\ndingtalk_ 钉钉\r\nwx_ 企业微信',
  `parent_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '父级部门ID',
  `level` tinyint(2) UNSIGNED NOT NULL DEFAULT 2 COMMENT '部门层级',
  `is_default` tinyint(2) UNSIGNED NOT NULL DEFAULT 10 COMMENT '是否为默认处理部门，10 不是  20 是',
  `ticket_auth` tinyint(2) UNSIGNED NOT NULL DEFAULT 10 COMMENT '工单系统权限 10 有 20 无',
  `group_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '部门名称',
  `manager_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '部门管理员',
  `is_task` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '是否为客服部门，1 不是 2 是',
  `orderby` int(11) UNSIGNED NOT NULL DEFAULT 100,
  `closed` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  `create_ip` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `create_time` int(11) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`group_id`) USING BTREE,
  INDEX `group_index1`(`group_id`, `company_id`, `group_name`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of feel_group
-- ----------------------------
INSERT INTO `feel_group` VALUES (1, 1, 'Ff35c4c86f9dad798fb4eba261d8063b', '', 0, 1, 20, 10, '默认用户组', 1, 1, 1, 0, '127.0.0.1', 1623987441);

-- ----------------------------
-- Table structure for feel_interface
-- ----------------------------
DROP TABLE IF EXISTS `feel_interface`;
CREATE TABLE `feel_interface`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '公司id',
  `appid` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `app_secret` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `create_time` int(11) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of feel_interface
-- ----------------------------
INSERT INTO `feel_interface` VALUES (1, 1, '5TPTOKOIGYKLKJDSAN93LMKVRJ9M5RFO', 'f9fiN9AdxdlkwrMdJU4LhEKViFHhpMXFG3IA9fMjJONaa', 1623987441);

-- ----------------------------
-- Table structure for feel_language
-- ----------------------------
DROP TABLE IF EXISTS `feel_language`;
CREATE TABLE `feel_language`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `lang` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `text` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `cn` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `en` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `jx` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of feel_language
-- ----------------------------
INSERT INTO `feel_language` VALUES (1, 'zh-cn', '简体中文', '中文版', 'Chinese', 'CN');
INSERT INTO `feel_language` VALUES (2, 'en-us', 'English', '英文版', 'English', 'EN');
INSERT INTO `feel_language` VALUES (3, 'ja-jp', '日本語版', '日文版', 'Japanese', 'JP');

-- ----------------------------
-- Table structure for feel_member
-- ----------------------------
DROP TABLE IF EXISTS `feel_member`;
CREATE TABLE `feel_member`  (
  `member_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '客户ID',
  `company_id` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `employee_id` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '加密员工ID',
  `original_id` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '第三方系统中的用户ID',
  `type` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '1 用户，2 客户，3 CRM用户，4 在线客服，5 游客',
  `member_type` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '会员类型 1 正式会员，2 非正式会员',
  `dingtalk_id` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '钉钉内部成员ID',
  `app_client_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT 'APP端的用户clientId',
  `crm_id` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT 'CRM内部成员ID',
  `webchat_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `firm_id` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `account` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '账号 手机或者邮箱格式',
  `password` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '密码',
  `identity` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '唯一标识',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '姓名',
  `email` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '邮箱',
  `mobile` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '手机',
  `group_id` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '所属部门',
  `role_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户角色ID',
  `open_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '微信open_id',
  `work_user_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '企业微信userId',
  `face` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `face_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `nickname` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '昵称',
  `is_first` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '是否为第一个账号，1 不是，2 是',
  `company_auth` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '用户公司信息修改 1关闭  2开启',
  `release_num` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '发布的工单数',
  `receive_num` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '收到的工单数',
  `closed` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '1 禁用',
  `create_ip` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `update_time` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '更新时间',
  `create_time` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `login_status` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '0 挂起，1 在线',
  `login_time` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '登录时间',
  `last_login_time` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '最后一次登录时间',
  `last_active_time` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '最后活动时间',
  `offline_time` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '离线时间',
  `login_ip` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '登录IP',
  `del_time` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `level_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '会员级别',
  `is_first_customer` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '是否为客户公司首账号 1 不是 2 是',
  `accountsecret` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '工作手机账号的账号密钥',
  `wechat` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`member_id`) USING BTREE,
  INDEX `member_index_1`(`account`, `mobile`, `email`, `name`, `type`) USING BTREE,
  INDEX `member_index_2`(`company_id`, `member_id`, `type`, `closed`) USING BTREE,
  INDEX `member_index_3`(`company_id`, `employee_id`, `type`, `closed`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of feel_member
-- ----------------------------
INSERT INTO `feel_member` VALUES (1, 1, 'Fea5371448801aa7d06b048e50e43904', '', 1, 1, '', '', '', '', 0, '18288880000', 'e10adc3949ba59abbe56e057f20f883e', '', '管理员', '', '18288880000', '1', 1, '', '', '', '', '', 2, 1, 0, 0, 0, '127.0.0.1', 0, 1623987441, 1, 1659076287, 1659076287, 1659084031, 1659076277, '127.0.0.1', 0, 0, 1, '', '');

-- ----------------------------
-- Table structure for feel_menu
-- ----------------------------
DROP TABLE IF EXISTS `feel_menu`;
CREATE TABLE `feel_menu`  (
  `menu_id` smallint(5) NOT NULL AUTO_INCREMENT,
  `menu_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `name_en` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `name_jp` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `menu_action` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `parent_id` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `orderby` tinyint(3) UNSIGNED NOT NULL DEFAULT 100 COMMENT '1排序第一',
  `is_show` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '0代表不显示',
  `apply` tinyint(1) UNSIGNED NOT NULL DEFAULT 10 COMMENT '10 用户 20 客户 30 同时应用',
  `is_common` tinyint(1) UNSIGNED NOT NULL DEFAULT 20 COMMENT '公共菜单，10 是 20否',
  `menu_level` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '4 跳转作用',
  `menu_icon` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`menu_id`) USING BTREE,
  INDEX `menu_id`(`menu_id`) USING BTREE,
  INDEX `menu_action`(`menu_action`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 245 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of feel_menu
-- ----------------------------
INSERT INTO `feel_menu` VALUES (1, '设置', 'Setting', '設定', 'Setting/index', 0, 2, 1, 10, 10, 1, 'icon-system');
INSERT INTO `feel_menu` VALUES (2, '个人中心', 'Personal Center', '個人センター', 'Setting/userinfo', 1, 1, 1, 10, 10, 2, '');
INSERT INTO `feel_menu` VALUES (3, '公司设置', 'Company settings', '会社設定', 'Setting/update_company', 1, 2, 1, 10, 10, 2, '');
INSERT INTO `feel_menu` VALUES (4, '修改密码', 'Modify password', 'パスワード変更', 'Setting/update_password', 2, 1, 0, 10, 10, 3, '');
INSERT INTO `feel_menu` VALUES (5, '组织架构', 'Organization', '組織構成', 'organize/index', 0, 1, 1, 10, 10, 1, 'icon-zuzhi');
INSERT INTO `feel_menu` VALUES (6, '部门管理', 'Department', '部署管理', '', 5, 1, 1, 10, 10, 2, 'icon-bumen');
INSERT INTO `feel_menu` VALUES (7, '角色管理', 'Role', '権限管理', '', 5, 2, 1, 10, 10, 2, 'icon-jiaoseguanli');
INSERT INTO `feel_menu` VALUES (8, '用户管理', 'User', 'ユーザ管理', '', 5, 3, 1, 10, 10, 2, 'icon-yonghu1');
INSERT INTO `feel_menu` VALUES (9, '部门列表', 'Sector list', '部門リスト', 'group/index', 6, 1, 1, 10, 10, 3, '');
INSERT INTO `feel_menu` VALUES (10, '创建部门', 'Build sector', '部門追加', 'group/create', 6, 2, 0, 10, 10, 3, '');
INSERT INTO `feel_menu` VALUES (11, '编辑部门', 'Editor sector', '部門変更', 'group/editor', 6, 3, 0, 10, 10, 3, '');
INSERT INTO `feel_menu` VALUES (12, '删除部门', 'Delete sector', '部門削除', 'group/delete', 6, 4, 0, 10, 10, 3, '');
INSERT INTO `feel_menu` VALUES (13, '角色列表', 'Role list', 'ロールリスト', 'role/index', 7, 1, 1, 10, 10, 3, '');
INSERT INTO `feel_menu` VALUES (14, '新增角色', 'New role', '新しい役割', 'role/create', 7, 2, 0, 10, 10, 3, '');
INSERT INTO `feel_menu` VALUES (15, '编辑角色', 'Editor role', '役割の編集', 'role/editor', 7, 3, 0, 10, 10, 3, '');
INSERT INTO `feel_menu` VALUES (16, '删除角色', 'Delete role', '役割を削除する', 'role/delete', 7, 4, 0, 10, 10, 3, '');
INSERT INTO `feel_menu` VALUES (17, '角色授权', 'Role auth', 'ロール認証', 'role/auth', 7, 5, 0, 10, 10, 3, '');
INSERT INTO `feel_menu` VALUES (18, '用户列表', 'User list', 'ユーザーリスト', 'member/index', 8, 1, 1, 10, 10, 3, '');
INSERT INTO `feel_menu` VALUES (19, '添加用户', 'Add user', 'ユーザ追加', 'member/create', 8, 2, 0, 10, 10, 3, '');
INSERT INTO `feel_menu` VALUES (20, '编辑用户', 'Editor user', 'ユーザ変更', 'member/editor', 8, 3, 0, 10, 10, 3, '');
INSERT INTO `feel_menu` VALUES (21, '删除用户', 'Delete user', 'ユーザ削除', 'member/delete', 8, 4, 0, 10, 10, 3, '');
INSERT INTO `feel_menu` VALUES (22, '恢复用户', 'Recovery user', 'ユーザ回復', 'member/recovery', 8, 5, 0, 10, 10, 3, '');
INSERT INTO `feel_menu` VALUES (23, '重置密码', 'Reset password', 'パスワードリセット', 'member/reset', 8, 6, 0, 10, 10, 3, '');
INSERT INTO `feel_menu` VALUES (50, '工单管理', 'Ticket manager', 'タスク管理', '', 0, 1, 1, 10, 20, 1, 'icon-ticket');
INSERT INTO `feel_menu` VALUES (51, '发布工单', 'Release ticket ', 'タスク登録', 'Ticket/template', 50, 1, 1, 10, 20, 2, '');
INSERT INTO `feel_menu` VALUES (52, '所有工单', 'All ticket ', 'すべてのタスク', 'Ticket/allTicket', 50, 2, 1, 10, 20, 2, '');
INSERT INTO `feel_menu` VALUES (53, '待回复的', 'Pending reply ticket ', '回答待ちタスク', 'Ticket/waitReplyTicket', 50, 3, 1, 10, 20, 2, '');
INSERT INTO `feel_menu` VALUES (54, '我发布的', 'My ticket', '登録したタスク', 'Ticket/myTicket', 50, 4, 1, 10, 20, 2, '');
INSERT INTO `feel_menu` VALUES (55, '我处理的', 'My handle', '処理中のタスク', 'Ticket/disposeTicket', 50, 5, 1, 10, 20, 2, '');
INSERT INTO `feel_menu` VALUES (56, '所在组的', 'My group', '所属グループのタスク', 'Ticket/groupTicket', 50, 7, 1, 10, 20, 2, '');
INSERT INTO `feel_menu` VALUES (57, '抄送的', 'Copy to me', 'CCのタスク', 'Ticket/ccTicket', 50, 8, 1, 10, 20, 2, '');
INSERT INTO `feel_menu` VALUES (58, '查看用户工单', 'Look member ticket', 'ユーザタスク', 'Ticket/memberTicket', 50, 10, 0, 10, 20, 2, '');
INSERT INTO `feel_menu` VALUES (59, '创建工单', 'Create ticket', 'タスク作成', 'Ticket/create', 50, 11, 0, 10, 20, 2, '');
INSERT INTO `feel_menu` VALUES (60, '工单详情', 'Ticket detail', 'タスク詳細', 'ticket/detail', 50, 13, 0, 10, 20, 2, '');
INSERT INTO `feel_menu` VALUES (61, '回复工单', 'Reply ticket', 'タスク回答', 'ticket/reply', 50, 14, 0, 10, 20, 2, '');
INSERT INTO `feel_menu` VALUES (62, '回复内部协作', 'Team response', 'チームの返信', 'ticket/teamReply', 50, 15, 0, 10, 20, 2, '');
INSERT INTO `feel_menu` VALUES (63, '删除工单', 'Delete ticket', 'タスク削除', 'ticket/delete', 50, 16, 0, 10, 20, 2, '');
INSERT INTO `feel_menu` VALUES (64, '导出工单', 'Export ticket', 'タスクのエクスポート', 'ticket/export', 50, 19, 0, 10, 20, 2, '');
INSERT INTO `feel_menu` VALUES (65, '满意度评价', 'Satisfaction', '満足度評価', 'ticket/satisfy', 50, 18, 0, 10, 20, 2, '');
INSERT INTO `feel_menu` VALUES (87, '工单设置', 'Ticket settings', 'タスク設定', '', 0, 6, 1, 10, 20, 1, 'icon-seting');
INSERT INTO `feel_menu` VALUES (88, '模板类型', 'Template type', 'テンプレートタイプ', 'templateType/index', 87, 1, 1, 10, 20, 2, '');
INSERT INTO `feel_menu` VALUES (89, '工单模板', 'Ticket template', 'タスクテンプレート', 'ticketModel/index', 87, 2, 1, 10, 20, 2, '');
INSERT INTO `feel_menu` VALUES (90, '模板表单', 'Ticket form', 'テンプレートフォーム', 'ticketForm/index', 87, 3, 0, 10, 20, 2, '');
INSERT INTO `feel_menu` VALUES (91, '工单状态', 'Ticket status', 'タスク状態', 'ticketStatus/index', 87, 4, 1, 10, 20, 2, '');
INSERT INTO `feel_menu` VALUES (93, '路由配置', 'Routing', 'ルート配置', 'Route/index', 87, 6, 1, 10, 20, 2, '');
INSERT INTO `feel_menu` VALUES (95, '工单配置', 'Ticket config', 'ワークシートの配置', 'ticket/config', 87, 8, 1, 10, 20, 2, '');
INSERT INTO `feel_menu` VALUES (98, '快捷分组', 'Quick grouping', '定型文グループ', 'fastReplyType/index', 87, 11, 1, 10, 20, 2, '');
INSERT INTO `feel_menu` VALUES (99, '快捷回复', 'Quick reply', '定型文', 'fastReply/index', 87, 12, 1, 10, 20, 2, '');
INSERT INTO `feel_menu` VALUES (100, '自定义显示字段', 'Custom display fields', 'カスタマイズ項目', 'ticketView/index', 87, 14, 1, 10, 20, 2, '');
INSERT INTO `feel_menu` VALUES (101, '添加模板类型', 'Add template type', 'テンプレートタイプ追加', 'templateType/create', 88, 1, 0, 10, 20, 3, '');
INSERT INTO `feel_menu` VALUES (102, '编辑模板类型', 'Editor template type', 'テンプレートタイプ変更', 'templateType/editor', 88, 2, 0, 10, 20, 3, '');
INSERT INTO `feel_menu` VALUES (103, '删除模板类型', 'Delete template type', 'テンプレートタイプ削除', 'templateType/delete', 88, 3, 0, 10, 20, 3, '');
INSERT INTO `feel_menu` VALUES (104, '添加工单模板', 'Add template', 'タスクテンプレート追加', 'ticketModel/create', 89, 1, 0, 10, 20, 3, '');
INSERT INTO `feel_menu` VALUES (105, '编辑工单模板', 'Editor template', 'タスクテンプレート変更', 'ticketModel/editor', 89, 2, 0, 10, 20, 3, '');
INSERT INTO `feel_menu` VALUES (106, '删除工单模板', 'Delete template', 'タスクテンプレート削除', 'ticketModel/delete', 89, 3, 0, 10, 20, 3, '');
INSERT INTO `feel_menu` VALUES (107, '新增模板表单', 'New template form', '新規フォームテンプレート', 'ticketForm/create', 90, 1, 0, 10, 20, 3, '');
INSERT INTO `feel_menu` VALUES (108, '编辑模板表单', 'Editor template form', 'フォームテンプレート変更', 'ticketForm/edit', 90, 2, 0, 10, 20, 3, '');
INSERT INTO `feel_menu` VALUES (109, '删除模板表单', 'Delete template form', 'フォームテンプレート削除', 'ticketForm/delete', 90, 3, 0, 10, 20, 3, '');
INSERT INTO `feel_menu` VALUES (110, '添加状态', 'Add status', '状態追加', 'ticketStatus/create', 91, 1, 0, 10, 20, 3, '');
INSERT INTO `feel_menu` VALUES (111, '编辑状态', 'Editor status', '状態変更', 'ticketStatus/editor', 91, 2, 0, 10, 20, 3, '');
INSERT INTO `feel_menu` VALUES (112, '删除状态', 'Delete status', '状態削除', 'ticketStatus/delete', 91, 3, 0, 10, 20, 3, '');
INSERT INTO `feel_menu` VALUES (116, '添加路由', 'Create route', '追加ルート', 'Route/create', 93, 1, 0, 10, 20, 3, '');
INSERT INTO `feel_menu` VALUES (117, '编辑路由', 'Editor route', '変更ルート', 'Route/editor', 93, 2, 0, 10, 20, 3, '');
INSERT INTO `feel_menu` VALUES (118, '删除路由', 'Delete route', '削除ルート', 'Route/delete', 93, 3, 0, 10, 20, 3, '');
INSERT INTO `feel_menu` VALUES (128, '添加快捷分组', 'New group', '定型文グループ追加', 'fastReplyType/create', 98, 1, 0, 10, 20, 3, '');
INSERT INTO `feel_menu` VALUES (129, '编辑快捷分组', 'Editor group', '定型文グループ変更', 'fastReplyType/editor', 98, 2, 0, 10, 20, 3, '');
INSERT INTO `feel_menu` VALUES (130, '删除快捷分组', 'Delete group', '定型文グループ削除', 'fastReplyType/delete', 98, 3, 0, 10, 20, 3, '');
INSERT INTO `feel_menu` VALUES (131, '添加快捷回复语', 'New quick reply', '新規定型文', 'fastReply/create', 99, 1, 0, 10, 20, 3, '');
INSERT INTO `feel_menu` VALUES (132, '编辑快捷回复语', 'Editor quick reply', '定型文編集', 'fastReply/editor', 99, 2, 0, 10, 20, 3, '');
INSERT INTO `feel_menu` VALUES (133, '删除快捷回复语', 'Delete quick reply', '定型文削除', 'fastReply/delete', 99, 3, 0, 10, 20, 3, '');
INSERT INTO `feel_menu` VALUES (134, '更新显示字段', 'Update display field', '表示項目変更', 'ticketView/edit', 100, 1, 0, 10, 20, 3, '');
INSERT INTO `feel_menu` VALUES (156, '通知配置', 'Notify config', '通知設定', 'notify/config', 1, 9, 1, 10, 20, 2, '');
INSERT INTO `feel_menu` VALUES (158, '修改工单', 'Editor ticket', '作業順序を変更する', 'ticket/edit', 50, 12, 0, 10, 20, 2, '');
INSERT INTO `feel_menu` VALUES (159, '回复评论', 'Reply comment', 'タスク回答', 'ticket/commentReply', 50, 17, 0, 10, 20, 2, '');
INSERT INTO `feel_menu` VALUES (160, '超时的工单', 'Timeout ticket', 'タイムアウト作業オーダー', 'Ticket/timeoutTicket', 50, 9, 1, 10, 20, 2, '');
INSERT INTO `feel_menu` VALUES (161, '概述', 'Overview', '概要', 'census/overviewData', 79, 1, 1, 10, 20, 2, '');
INSERT INTO `feel_menu` VALUES (162, '催促工单', 'Urge ticket', 'リマインダ', 'ticket/urgeTicket', 50, 20, 0, 10, 20, 2, '');
INSERT INTO `feel_menu` VALUES (185, '克隆工单', 'Cloning ticket ', '克隆工单', 'ticket/cloning', 50, 21, 0, 10, 20, 2, '');
INSERT INTO `feel_menu` VALUES (188, '关联工单', 'Associate ticket ', '关联工单', 'ticket/associate', 50, 22, 0, 10, 20, 2, '');
INSERT INTO `feel_menu` VALUES (189, '回收站', 'Recycle bin', '回収ステーション', '', 50, 10, 1, 10, 20, 2, '');
INSERT INTO `feel_menu` VALUES (190, '完全删除', 'Complete delete', '完全に削除されました', 'Ticket/complete_delete', 227, 1, 0, 10, 20, 3, '');
INSERT INTO `feel_menu` VALUES (191, '恢复工单', 'Recover ticket', 'リカバリー作業指示', 'Ticket/recover', 227, 1, 0, 10, 20, 3, '');
INSERT INTO `feel_menu` VALUES (200, '满意度配置', 'Satisfaction Allocation', '満足度の配置', 'satisfaction/index', 87, 13, 1, 10, 20, 2, '');
INSERT INTO `feel_menu` VALUES (201, '修改满意项', 'Editor satisfaction', '満足項目を修正する', 'satisfaction/editor_satisfy', 200, 1, 0, 10, 20, 3, '');
INSERT INTO `feel_menu` VALUES (202, '标签配置', 'Label configuration', 'ラベルの配置', 'satisfaction/label_list', 200, 1, 0, 10, 20, 3, '');
INSERT INTO `feel_menu` VALUES (203, '新增标签', 'Create label', '追加ラベル', 'satisfaction/create_label', 202, 1, 0, 10, 20, 4, '');
INSERT INTO `feel_menu` VALUES (204, '修改标签', 'Editor label', 'ラベルを修正する', 'satisfaction/editor_label', 202, 1, 0, 10, 20, 4, '');
INSERT INTO `feel_menu` VALUES (205, '删除标签', 'Delete label', 'ラベルを削除', 'satisfaction/delete_label', 202, 1, 0, 10, 20, 4, '');
INSERT INTO `feel_menu` VALUES (206, '工单操作权限', 'Operation auth', '操作権限', 'ticket/operation_auth', 50, 23, 0, 10, 20, 2, '');
INSERT INTO `feel_menu` VALUES (207, '我参与的', 'Partake ticket', '参加しました', 'Ticket/partakeTicket', 50, 6, 1, 10, 20, 2, '');
INSERT INTO `feel_menu` VALUES (208, '子工单', 'Sub Ticket', '子工单', '', 50, 24, 0, 10, 20, 2, '');
INSERT INTO `feel_menu` VALUES (209, '创建子工单', 'Create sub ticket', '创建子工单', 'subTicket/create', 208, 1, 0, 10, 20, 3, '');
INSERT INTO `feel_menu` VALUES (210, '修改子工单', 'Editor sub ticket', '修改子工单', 'subTicket/editor', 208, 2, 0, 10, 20, 3, '');
INSERT INTO `feel_menu` VALUES (211, '删除子工单', 'Delete sub ticket', '删除子工单', 'subTicket/delete', 208, 3, 0, 10, 20, 3, '');
INSERT INTO `feel_menu` VALUES (212, '子工单详情', 'Sub ticket detail', '子工单详情', 'subTicket/detail', 208, 4, 1, 10, 20, 3, '');
INSERT INTO `feel_menu` VALUES (213, '回复子工单', 'Reply sub ticket', '回复子工单', 'subTicket/reply', 208, 4, 1, 10, 20, 3, '');
INSERT INTO `feel_menu` VALUES (223, '工单', 'Parent ticket', '登録したタスク', 'Ticket/myTicket', 54, 1, 1, 10, 20, 3, '');
INSERT INTO `feel_menu` VALUES (224, '子工单', 'Sub ticket', '登録したタスク', 'subTicket/myTicket', 54, 2, 1, 10, 20, 3, '');
INSERT INTO `feel_menu` VALUES (225, '工单', 'Parent ticket', '処理中のタスク', 'Ticket/disposeTicket', 55, 1, 1, 10, 20, 3, '');
INSERT INTO `feel_menu` VALUES (226, '子工单', 'Sub ticket', '処理中のタスク', 'subTicket/processTicket', 55, 2, 1, 10, 20, 3, '');
INSERT INTO `feel_menu` VALUES (227, '工单', 'Parent ticket', '処理中のタスク', 'Ticket/recycle', 189, 1, 1, 10, 20, 3, '');
INSERT INTO `feel_menu` VALUES (228, '子工单', 'Sub ticket', '処理中のタスク', 'subTicket/recycle', 189, 2, 1, 10, 20, 3, '');
INSERT INTO `feel_menu` VALUES (229, '完全删除', 'Complete delete', '完全删除', 'subTicket/complete_delete', 228, 4, 1, 10, 20, 3, '');
INSERT INTO `feel_menu` VALUES (230, '恢复子工单', 'Recover sub ticket', '恢复子工单', 'subTicket/recover', 228, 4, 1, 10, 20, 3, '');
INSERT INTO `feel_menu` VALUES (233, '我发布的', 'My ticket wait', '我发布的', 'Ticket/waitAuditMyTicket', 231, 2, 1, 10, 20, 3, '');
INSERT INTO `feel_menu` VALUES (237, '导入工单', 'Import ticket', '导入工单', 'ticket/import', 50, 20, 0, 10, 20, 2, '');
INSERT INTO `feel_menu` VALUES (238, '关注工单', 'Follow ticket', '关注工单', 'ticket/follow', 50, 20, 0, 10, 20, 2, '');

-- ----------------------------
-- Table structure for feel_modify_record
-- ----------------------------
DROP TABLE IF EXISTS `feel_modify_record`;
CREATE TABLE `feel_modify_record`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `ticket_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `member_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '修改人ID',
  `modify_data` json NULL COMMENT '修改前后数据内容',
  `modify_time` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '工单修改记录表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of feel_modify_record
-- ----------------------------

-- ----------------------------
-- Table structure for feel_notify_config
-- ----------------------------
DROP TABLE IF EXISTS `feel_notify_config`;
CREATE TABLE `feel_notify_config`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `create_notify_publish` tinyint(2) UNSIGNED NOT NULL DEFAULT 20 COMMENT '发布成功通知发布人 10 开启，20 关闭',
  `end_notify_publish` tinyint(2) UNSIGNED NOT NULL DEFAULT 20 COMMENT '工单结束通知发布人 10 开启，20 关闭',
  `editor_notify_publish` tinyint(2) UNSIGNED NOT NULL DEFAULT 20 COMMENT '修改成功通知发布人 10 开启，20 关闭',
  `assign_notify_handle` tinyint(2) UNSIGNED NOT NULL DEFAULT 10 COMMENT '分配处理人通知 10 开启 20关闭',
  `ticket_cc_notify` tinyint(2) UNSIGNED NOT NULL DEFAULT 10 COMMENT '工单抄送通知 10 开启 20 关闭',
  `reply_notify_publish` tinyint(2) UNSIGNED NOT NULL DEFAULT 10 COMMENT '新回复通知发布人 10 开启 20 关闭',
  `reply_notify_handler` tinyint(2) UNSIGNED NOT NULL DEFAULT 10 COMMENT '新回复通知处理人 10 开启 20 关闭',
  `reply_notify_cc` tinyint(2) UNSIGNED NOT NULL DEFAULT 10 COMMENT '新回复通知抄送人 10 开启 20 关闭',
  `internal_notify_handle` tinyint(2) UNSIGNED NOT NULL DEFAULT 10 COMMENT '内部协作回复通知处理人 10 开启 20 关闭',
  `internal_notify_cc` tinyint(2) UNSIGNED NOT NULL DEFAULT 10 COMMENT '内部协作回复通知抄送 10 开启 20 关闭',
  `status_notify_publish` tinyint(2) UNSIGNED NOT NULL DEFAULT 20 COMMENT '状态改变通知发布人 10 开启 20 关闭',
  `restart_ticket_notify` tinyint(2) UNSIGNED NOT NULL DEFAULT 20 COMMENT '工单重启通知处理人 10 开启 20 关闭',
  `comment_reply_notify` tinyint(2) UNSIGNED NOT NULL DEFAULT 20 COMMENT '回复评论通知 10 开启 20 关闭',
  `ticket_timeout_notify` tinyint(2) UNSIGNED NOT NULL DEFAULT 20 COMMENT '工单超时通知 10 开启 20 关闭',
  `end_notify_follow` tinyint(2) UNSIGNED NOT NULL DEFAULT 20 COMMENT '工单结束通知关注人 10 开启，20 关闭',
  `reply_notify_follow` tinyint(2) UNSIGNED NOT NULL DEFAULT 10 COMMENT '新回复通知关注人 10 开启 20 关闭',
  `internal_notify_follow` tinyint(2) UNSIGNED NOT NULL DEFAULT 10 COMMENT '内部协作回复通知关注人 10 开启 20 关闭',
  `status_notify_follow` tinyint(2) UNSIGNED NOT NULL DEFAULT 20 COMMENT '状态改变通知发布人 10 开启 20 关闭',
  `restart_notify_follow` tinyint(2) UNSIGNED NOT NULL DEFAULT 20 COMMENT '工单重启通知关注人 10 开启 20 关闭',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = FIXED;

-- ----------------------------
-- Records of feel_notify_config
-- ----------------------------
INSERT INTO `feel_notify_config` VALUES (1, 1, 20, 20, 20, 10, 10, 10, 10, 10, 10, 10, 20, 20, 20, 20, 20, 10, 10, 20, 20);
-- ----------------------------
-- Table structure for feel_province
-- ----------------------------
DROP TABLE IF EXISTS `feel_province`;
CREATE TABLE `feel_province`  (
    `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
    `code` char(3) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
    `country_code` char(3) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
    `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '省份/城市名称',
    `name_en` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '英文名称',
    `name_jp` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '日文名称',
    PRIMARY KEY (`id`) USING BTREE,
    INDEX `code`(`country_code`, `code`) USING BTREE,
    INDEX `code_name`(`country_code`, `name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2775 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of feel_province
-- ----------------------------
INSERT INTO `feel_province` VALUES (1, '11', '1', '北京', 'Beijing', '');
INSERT INTO `feel_province` VALUES (2, '12', '1', '天津', 'Tianjin', '');
INSERT INTO `feel_province` VALUES (3, '13', '1', '河北', 'Hebei', '');
INSERT INTO `feel_province` VALUES (4, '14', '1', '山西', 'Shanxi', '');
INSERT INTO `feel_province` VALUES (5, '15', '1', '内蒙古', 'Inner Mongolia', '');
INSERT INTO `feel_province` VALUES (6, '21', '1', '辽宁', 'Liaoning', '');
INSERT INTO `feel_province` VALUES (7, '22', '1', '吉林', 'Jilin', '');
INSERT INTO `feel_province` VALUES (8, '23', '1', '黑龙江', 'Heilongjiang', '');
INSERT INTO `feel_province` VALUES (9, '31', '1', '上海', 'Shanghai', '');
INSERT INTO `feel_province` VALUES (10, '32', '1', '江苏', 'Jiangsu', '');
INSERT INTO `feel_province` VALUES (11, '33', '1', '浙江', 'Zhejiang', '');
INSERT INTO `feel_province` VALUES (12, '34', '1', '安徽', 'Anhui', '');
INSERT INTO `feel_province` VALUES (13, '35', '1', '福建', 'Fujian', '');
INSERT INTO `feel_province` VALUES (14, '36', '1', '江西', 'Jiangxi', '');
INSERT INTO `feel_province` VALUES (15, '37', '1', '山东', 'Shandong', '');
INSERT INTO `feel_province` VALUES (16, '41', '1', '河南', 'Henan', '');
INSERT INTO `feel_province` VALUES (17, '42', '1', '湖北', 'Hubei', '');
INSERT INTO `feel_province` VALUES (18, '43', '1', '湖南', 'Hunan', '');
INSERT INTO `feel_province` VALUES (19, '44', '1', '广东', 'Guangdong', '');
INSERT INTO `feel_province` VALUES (20, '45', '1', '广西', 'Guangxi', '');
INSERT INTO `feel_province` VALUES (21, '46', '1', '海南', 'Hainan', '');
INSERT INTO `feel_province` VALUES (22, '50', '1', '重庆', 'Chongqing', '');
INSERT INTO `feel_province` VALUES (23, '51', '1', '四川', 'Sichuan', '');
INSERT INTO `feel_province` VALUES (24, '52', '1', '贵州', 'Guizhou', '');
INSERT INTO `feel_province` VALUES (25, '53', '1', '云南', 'Yunnan', '');
INSERT INTO `feel_province` VALUES (26, '54', '1', '西藏', 'Tibet', '');
INSERT INTO `feel_province` VALUES (27, '61', '1', '陕西', 'Shaanxi', '');
INSERT INTO `feel_province` VALUES (28, '62', '1', '甘肃', 'Gansu', '');
INSERT INTO `feel_province` VALUES (29, '63', '1', '青海', 'Qinghai', '');
INSERT INTO `feel_province` VALUES (30, '64', '1', '宁夏', 'Ningxia', '');
INSERT INTO `feel_province` VALUES (31, '65', '1', '新疆', 'Xinjiang', '');
INSERT INTO `feel_province` VALUES (32, '71', '1', '台湾', 'Taiwan', '');
INSERT INTO `feel_province` VALUES (33, '81', '1', '香港', 'Hong Kong', '');
INSERT INTO `feel_province` VALUES (34, '82', '1', '澳门', 'Macao', '');
INSERT INTO `feel_province` VALUES (35, 'EL', 'ALB', '爱尔巴桑', 'Elbasan', '');
INSERT INTO `feel_province` VALUES (36, 'DI', 'ALB', '迪勃拉', 'Dibra', '');
INSERT INTO `feel_province` VALUES (37, 'TR', 'ALB', '地拉那', 'Tirana', '');
INSERT INTO `feel_province` VALUES (38, 'DR', 'ALB', '都拉斯', 'Durres', '');
INSERT INTO `feel_province` VALUES (39, 'VL', 'ALB', '发罗拉', 'Vlora', '');
INSERT INTO `feel_province` VALUES (40, 'FR', 'ALB', '费里', 'Ferry', '');
INSERT INTO `feel_province` VALUES (41, 'GJ', 'ALB', '吉诺卡斯特', 'Ginocaster', '');
INSERT INTO `feel_province` VALUES (42, 'KO', 'ALB', '科尔察', 'Korcha', '');
INSERT INTO `feel_province` VALUES (43, 'KU', 'ALB', '库克斯', 'Cux', '');
INSERT INTO `feel_province` VALUES (44, 'LE', 'ALB', '莱什', 'Lash', '');
INSERT INTO `feel_province` VALUES (45, 'BR', 'ALB', '培拉特', 'Berat', '');
INSERT INTO `feel_province` VALUES (46, 'SH', 'ALB', '斯库台', 'Skudai', '');
INSERT INTO `feel_province` VALUES (47, 'ADR', 'DZA', '阿德拉尔', 'Adrar', '');
INSERT INTO `feel_province` VALUES (48, 'ALG', 'DZA', '阿尔及尔', 'Algiers', '');
INSERT INTO `feel_province` VALUES (49, 'ADE', 'DZA', '艾因·德夫拉', 'Ain Devra', '');
INSERT INTO `feel_province` VALUES (50, 'ATE', 'DZA', '艾因·蒂姆尚特', 'Ain Timchant', '');
INSERT INTO `feel_province` VALUES (51, 'AAE', 'DZA', '安纳巴', 'Annaba', '');
INSERT INTO `feel_province` VALUES (52, 'ORA', 'DZA', '奥兰', 'Oran', '');
INSERT INTO `feel_province` VALUES (53, 'BAT', 'DZA', '巴特纳', 'Batna', '');
INSERT INTO `feel_province` VALUES (54, 'BJA', 'DZA', '贝贾亚', 'Bejaia', '');
INSERT INTO `feel_province` VALUES (55, 'BEC', 'DZA', '贝沙尔', 'Bechar', '');
INSERT INTO `feel_province` VALUES (56, 'EBA', 'DZA', '贝伊德', 'Bayd', '');
INSERT INTO `feel_province` VALUES (57, 'BIS', 'DZA', '比斯克拉', 'Biskra', '');
INSERT INTO `feel_province` VALUES (58, 'BOR', 'DZA', '布尔吉·布阿雷里吉', 'Bourgui Buarerig', '');
INSERT INTO `feel_province` VALUES (59, 'BLI', 'DZA', '布利达', 'Blida', '');
INSERT INTO `feel_province` VALUES (60, 'BOU', 'DZA', '布迈德斯', 'Bumedes', '');
INSERT INTO `feel_province` VALUES (61, 'BOA', 'DZA', '布依拉', 'Buyla', '');
INSERT INTO `feel_province` VALUES (62, 'TIP', 'DZA', '蒂巴扎', 'Tibazar', '');
INSERT INTO `feel_province` VALUES (63, 'TIS', 'DZA', '蒂斯姆西勒特', 'Tism Sillet', '');
INSERT INTO `feel_province` VALUES (64, 'GHA', 'DZA', '盖尔达耶', 'Gaildaye', '');
INSERT INTO `feel_province` VALUES (65, 'GUE', 'DZA', '盖尔马', 'Gherma', '');
INSERT INTO `feel_province` VALUES (66, 'KHE', 'DZA', '罕西拉', 'Hansila', '');
INSERT INTO `feel_province` VALUES (67, 'REL', 'DZA', '赫利赞', 'Helizan', '');
INSERT INTO `feel_province` VALUES (68, 'JIJ', 'DZA', '吉杰尔', 'Jijer', '');
INSERT INTO `feel_province` VALUES (69, 'DJE', 'DZA', '杰勒法', 'Jelefa', '');
INSERT INTO `feel_province` VALUES (70, 'CZL', 'DZA', '君士坦丁', 'Constantine', '');
INSERT INTO `feel_province` VALUES (71, 'LAG', 'DZA', '拉格瓦特', 'Lagwart', '');
INSERT INTO `feel_province` VALUES (72, 'MUA', 'DZA', '马斯卡拉', 'Mascara', '');
INSERT INTO `feel_province` VALUES (73, 'MED', 'DZA', '麦迪亚', 'Mcdia', '');
INSERT INTO `feel_province` VALUES (74, 'MIL', 'DZA', '密拉', 'Milla', '');
INSERT INTO `feel_province` VALUES (75, 'MOS', 'DZA', '莫斯塔加纳姆', 'Mostaganam', '');
INSERT INTO `feel_province` VALUES (76, 'MSI', 'DZA', '姆西拉', 'Msira', '');
INSERT INTO `feel_province` VALUES (77, 'NAA', 'DZA', '纳阿马', 'Naama', '');
INSERT INTO `feel_province` VALUES (78, 'SET', 'DZA', '塞蒂夫', 'Setif', '');
INSERT INTO `feel_province` VALUES (79, 'SAI', 'DZA', '赛伊达', 'Sayida', '');
INSERT INTO `feel_province` VALUES (80, 'SKI', 'DZA', '斯基克达', 'Skikda', '');
INSERT INTO `feel_province` VALUES (81, 'SAH', 'DZA', '苏克·阿赫拉斯', 'Souk Ahras', '');
INSERT INTO `feel_province` VALUES (82, 'ETA', 'DZA', '塔里夫', 'Tarif', '');
INSERT INTO `feel_province` VALUES (83, 'TAM', 'DZA', '塔曼拉塞特', 'Taman Lasset', '');
INSERT INTO `feel_province` VALUES (84, 'TEB', 'DZA', '特贝萨', 'Tebesa', '');
INSERT INTO `feel_province` VALUES (85, 'TLE', 'DZA', '特莱姆森', 'Tlemson', '');
INSERT INTO `feel_province` VALUES (86, 'IOU', 'DZA', '提济乌祖', 'Tiziwuzu', '');
INSERT INTO `feel_province` VALUES (87, 'TIA', 'DZA', '提亚雷特', 'Tiaret', '');
INSERT INTO `feel_province` VALUES (88, 'TIN', 'DZA', '廷杜夫', 'Tindouf', '');
INSERT INTO `feel_province` VALUES (89, 'EOU', 'DZA', '瓦德', 'Wade', '');
INSERT INTO `feel_province` VALUES (90, 'OUA', 'DZA', '瓦尔格拉', 'Valgra', '');
INSERT INTO `feel_province` VALUES (91, 'OEB', 'DZA', '乌姆布阿基', 'Umbuaki', '');
INSERT INTO `feel_province` VALUES (92, 'SBA', 'DZA', '西迪贝勒阿贝斯', 'Sidi Belle Abbes', '');
INSERT INTO `feel_province` VALUES (93, 'CHL', 'DZA', '谢里夫', 'Sharif', '');
INSERT INTO `feel_province` VALUES (94, 'ILL', 'DZA', '伊利齐', 'Ilizi', '');
INSERT INTO `feel_province` VALUES (95, 'HEA', 'AFG', '赫拉特', 'Herat', '');
INSERT INTO `feel_province` VALUES (96, 'KBL', 'AFG', '喀布尔', 'Kabul', '');
INSERT INTO `feel_province` VALUES (97, 'KDH', 'AFG', '坎大哈', 'Kandahar', '');
INSERT INTO `feel_province` VALUES (98, 'MZR', 'AFG', '马扎里沙里夫', 'Mazari Sharif', '');
INSERT INTO `feel_province` VALUES (99, 'PRA', 'ARG', '巴拉那', 'Parana', '');
INSERT INTO `feel_province` VALUES (100, 'VDM', 'ARG', '别德马', 'Bidema', '');
INSERT INTO `feel_province` VALUES (101, 'PSS', 'ARG', '波萨达斯', 'Posadas', '');
INSERT INTO `feel_province` VALUES (102, 'BHI', 'ARG', '布兰卡港', 'Port of Blanca', '');
INSERT INTO `feel_province` VALUES (103, 'BUE', 'ARG', '布宜诺斯艾利斯', 'Buenos Aires', '');
INSERT INTO `feel_province` VALUES (104, 'FMA', 'ARG', '福莫萨', 'Formosa', '');
INSERT INTO `feel_province` VALUES (105, 'JUJ', 'ARG', '胡胡伊', 'Juhuy', '');
INSERT INTO `feel_province` VALUES (106, 'CTC', 'ARG', '卡塔马卡', 'Catamarca', '');
INSERT INTO `feel_province` VALUES (107, 'COR', 'ARG', '科尔多瓦', 'Cordova', '');
INSERT INTO `feel_province` VALUES (108, 'CNQ', 'ARG', '科连特斯', 'Corrientes', '');
INSERT INTO `feel_province` VALUES (109, 'VLK', 'ARG', '克劳斯城', 'Claus City', '');
INSERT INTO `feel_province` VALUES (110, 'COC', 'ARG', '肯考迪娅', 'Ken Kadiya', '');
INSERT INTO `feel_province` VALUES (111, 'IRJ', 'ARG', '拉里奥哈', 'La Rioja', '');
INSERT INTO `feel_province` VALUES (112, 'LPG', 'ARG', '拉普拉塔', 'La Plata', '');
INSERT INTO `feel_province` VALUES (113, 'RES', 'ARG', '雷西斯滕匹亚', 'Resistenpia', '');
INSERT INTO `feel_province` VALUES (114, 'RGL', 'ARG', '里奥加耶戈斯', 'Riogaegos', '');
INSERT INTO `feel_province` VALUES (115, 'RCU', 'ARG', '里奥夸尔托', 'Rio Quarto', '');
INSERT INTO `feel_province` VALUES (116, 'CRD', 'ARG', '里瓦达维亚海军准将城', 'Brigadier General Rivadavia', '');
INSERT INTO `feel_province` VALUES (117, 'ROS', 'ARG', '罗萨里奥', 'Rosario', '');
INSERT INTO `feel_province` VALUES (118, 'RWO', 'ARG', '罗森', 'Rosen', '');
INSERT INTO `feel_province` VALUES (119, 'MDQ', 'ARG', '马德普拉塔', 'Mar del Plata', '');
INSERT INTO `feel_province` VALUES (120, 'MDZ', 'ARG', '门多萨', 'Mendoza', '');
INSERT INTO `feel_province` VALUES (121, 'NQN', 'ARG', '内乌肯', 'Neuquen', '');
INSERT INTO `feel_province` VALUES (122, 'SLA', 'ARG', '萨尔塔', 'Salta', '');
INSERT INTO `feel_province` VALUES (123, 'SDE', 'ARG', '圣地亚哥德尔埃斯特罗', 'Santiago del Estero', '');
INSERT INTO `feel_province` VALUES (124, 'SFN', 'ARG', '圣菲', 'Santa Fe', '');
INSERT INTO `feel_province` VALUES (125, 'UAQ', 'ARG', '圣胡安', 'San juan', '');
INSERT INTO `feel_province` VALUES (126, 'AFA', 'ARG', '圣拉斐尔', 'San Rafael', '');
INSERT INTO `feel_province` VALUES (127, 'LUQ', 'ARG', '圣路易斯', 'St. Louis', '');
INSERT INTO `feel_province` VALUES (128, 'RSA', 'ARG', '圣罗莎', 'Santa Rosa', '');
INSERT INTO `feel_province` VALUES (129, 'SMC', 'ARG', '圣米格尔德图库曼', 'San Miguel de Tucumán', '');
INSERT INTO `feel_province` VALUES (130, 'SNS', 'ARG', '圣尼古拉斯', 'St. Nicholas', '');
INSERT INTO `feel_province` VALUES (131, 'REL', 'ARG', '特雷利乌', 'Trelew', '');
INSERT INTO `feel_province` VALUES (132, 'USH', 'ARG', '乌斯怀亚', 'Ushuaia', '');
INSERT INTO `feel_province` VALUES (133, 'AZ', 'ARE', '阿布扎比', 'Abu Dhabi', '');
INSERT INTO `feel_province` VALUES (134, 'AL', 'ARE', '艾因', 'Ain', '');
INSERT INTO `feel_province` VALUES (135, 'DU', 'ARE', '迪拜', 'Dubai', '');
INSERT INTO `feel_province` VALUES (136, 'SH', 'ARE', '沙迦', 'Sharjah', '');
INSERT INTO `feel_province` VALUES (137, 'BA', 'OMN', '巴提奈地区', 'Batinah area', '');
INSERT INTO `feel_province` VALUES (138, 'ZA', 'OMN', '达希莱地区', 'Dahile area', '');
INSERT INTO `feel_province` VALUES (139, 'SH', 'OMN', '东部地区', 'East area', '');
INSERT INTO `feel_province` VALUES (140, 'MA', 'OMN', '马斯喀特省', 'Muscat Governorate', '');
INSERT INTO `feel_province` VALUES (141, 'MU', 'OMN', '穆桑达姆省', 'Musandam', '');
INSERT INTO `feel_province` VALUES (142, 'DA', 'OMN', '内地地区', 'Mainland area', '');
INSERT INTO `feel_province` VALUES (143, 'WU', 'OMN', '中部地区', 'Central Region', '');
INSERT INTO `feel_province` VALUES (144, 'ZU', 'OMN', '佐法尔省', 'Dhofar', '');
INSERT INTO `feel_province` VALUES (145, 'ABS', 'AZE', '阿布歇隆', 'Absheron', '');
INSERT INTO `feel_province` VALUES (146, 'XAC', 'AZE', '哈奇马斯', 'Hachmas', '');
INSERT INTO `feel_province` VALUES (147, 'KAL', 'AZE', '卡尔巴卡尔', 'Kalbakar', '');
INSERT INTO `feel_province` VALUES (148, 'QAZ', 'AZE', '卡扎赫', 'Kazakh', '');
INSERT INTO `feel_province` VALUES (149, 'LAN', 'AZE', '连科兰', 'Lian Kelan', '');
INSERT INTO `feel_province` VALUES (150, 'MQA', 'AZE', '密尔卡拉巴赫', 'Milkarabakh', '');
INSERT INTO `feel_province` VALUES (151, 'MSA', 'AZE', '穆甘萨连', 'Mugansa', '');
INSERT INTO `feel_province` VALUES (152, 'NQA', 'AZE', '纳戈尔诺－卡拉巴赫', 'Nagorno-Karabakh', '');
INSERT INTO `feel_province` VALUES (153, 'NX', 'AZE', '纳希切万', 'Nakhichevan', '');
INSERT INTO `feel_province` VALUES (154, 'PRI', 'AZE', '普利亚拉克斯', 'Pugliax', '');
INSERT INTO `feel_province` VALUES (155, 'SA', 'AZE', '舍基', 'Sheki', '');
INSERT INTO `feel_province` VALUES (156, 'SMC', 'AZE', '苏姆盖特', 'Sumgate', '');
INSERT INTO `feel_province` VALUES (157, 'SIR', 'AZE', '锡尔万', 'Sylvan', '');
INSERT INTO `feel_province` VALUES (158, 'GA', 'AZE', '占贾', 'Zhan Jia', '');
INSERT INTO `feel_province` VALUES (159, 'ASW', 'EGY', '阿斯旺', 'Aswan', '');
INSERT INTO `feel_province` VALUES (160, 'GBY', 'EGY', '古尔代盖', 'Guldegay', '');
INSERT INTO `feel_province` VALUES (161, 'CAI', 'EGY', '开罗', 'Cairo', '');
INSERT INTO `feel_province` VALUES (162, 'SKH', 'EGY', '苏布拉开马', 'Subra', '');
INSERT INTO `feel_province` VALUES (163, 'ALY', 'EGY', '亚历山大', 'Alexander', '');
INSERT INTO `feel_province` VALUES (164, 'AF', 'ETH', '阿法尔', 'Afar', '');
INSERT INTO `feel_province` VALUES (165, 'AH', 'ETH', '阿姆哈拉', 'Amhara', '');
INSERT INTO `feel_province` VALUES (166, 'OR', 'ETH', '奥罗米亚', 'Oromia', '');
INSERT INTO `feel_province` VALUES (167, 'BG', 'ETH', '宾香古尔', 'Bin Xianggul', '');
INSERT INTO `feel_province` VALUES (168, 'DD', 'ETH', '德雷达瓦', 'Dreida', '');
INSERT INTO `feel_province` VALUES (169, 'GB', 'ETH', '甘贝拉各族', 'Gambella', '');
INSERT INTO `feel_province` VALUES (170, 'HR', 'ETH', '哈勒里民族', 'Halle ethnic', '');
INSERT INTO `feel_province` VALUES (171, 'SN', 'ETH', '南方各族', 'Southern tribes', '');
INSERT INTO `feel_province` VALUES (172, 'SM', 'ETH', '索马里', 'Somalia', '');
INSERT INTO `feel_province` VALUES (173, 'TG', 'ETH', '提格雷', 'Tigray', '');
INSERT INTO `feel_province` VALUES (174, 'AA', 'ETH', '亚的斯亚贝巴', 'Addis Ababa', '');
INSERT INTO `feel_province` VALUES (175, 'OF', 'IRL', '奥法利', 'O\'Falley', '');
INSERT INTO `feel_province` VALUES (176, 'TP', 'IRL', '蒂珀雷里', 'Tipperary', '');
INSERT INTO `feel_province` VALUES (177, 'DB', 'IRL', '都柏林', 'Dublin', '');
INSERT INTO `feel_province` VALUES (178, 'DG', 'IRL', '多内加尔', 'Donegal', '');
INSERT INTO `feel_province` VALUES (179, 'GW', 'IRL', '戈尔韦', 'Galway', '');
INSERT INTO `feel_province` VALUES (180, 'KD', 'IRL', '基尔代尔', 'Kildare', '');
INSERT INTO `feel_province` VALUES (181, 'KK', 'IRL', '基尔肯尼', 'Kilkenny', '');
INSERT INTO `feel_province` VALUES (182, 'CV', 'IRL', '卡范', 'Kafan', '');
INSERT INTO `feel_province` VALUES (183, 'CW', 'IRL', '卡洛', 'Carlo', '');
INSERT INTO `feel_province` VALUES (184, 'KR', 'IRL', '凯里', 'Carey', '');
INSERT INTO `feel_province` VALUES (185, 'CK', 'IRL', '科克', 'Cork', '');
INSERT INTO `feel_province` VALUES (186, 'CL', 'IRL', '克莱尔', 'Claire', '');
INSERT INTO `feel_province` VALUES (187, 'LF', 'IRL', '朗福德', 'Longford', '');
INSERT INTO `feel_province` VALUES (188, 'LT', 'IRL', '劳斯', 'Rolls', '');
INSERT INTO `feel_province` VALUES (189, 'LA', 'IRL', '崂斯', 'Muse', '');
INSERT INTO `feel_province` VALUES (190, 'LM', 'IRL', '利默里克', 'Limerick', '');
INSERT INTO `feel_province` VALUES (191, 'LR', 'IRL', '利特里姆', 'Leitrim', '');
INSERT INTO `feel_province` VALUES (192, 'RC', 'IRL', '罗斯康芒', 'Roscommon', '');
INSERT INTO `feel_province` VALUES (193, 'MY', 'IRL', '梅奥', 'Mayo', '');
INSERT INTO `feel_province` VALUES (194, 'MT', 'IRL', '米斯', 'Mises', '');
INSERT INTO `feel_province` VALUES (195, 'MG', 'IRL', '莫内根', 'Monegan', '');
INSERT INTO `feel_province` VALUES (196, 'SL', 'IRL', '斯莱戈', 'Sligo', '');
INSERT INTO `feel_province` VALUES (197, 'WK', 'IRL', '威克洛', 'Wicklow', '');
INSERT INTO `feel_province` VALUES (198, 'WX', 'IRL', '韦克斯福德', 'Wexford', '');
INSERT INTO `feel_province` VALUES (199, 'WF', 'IRL', '沃特福德', 'Waterford', '');
INSERT INTO `feel_province` VALUES (200, 'WM', 'IRL', '西米斯', 'Simis', '');
INSERT INTO `feel_province` VALUES (201, '65', 'EST', '贝尔瓦', 'Belva', '');
INSERT INTO `feel_province` VALUES (202, '37', 'EST', '哈留', 'Haru', '');
INSERT INTO `feel_province` VALUES (203, '70', 'EST', '拉普拉', 'La Pula', '');
INSERT INTO `feel_province` VALUES (204, '57', 'EST', '里亚内', 'Rania', '');
INSERT INTO `feel_province` VALUES (205, '67', 'EST', '帕尔努', 'Parnu', '');
INSERT INTO `feel_province` VALUES (206, '74', 'EST', '萨雷', 'Saray', '');
INSERT INTO `feel_province` VALUES (207, '78', 'EST', '塔尔图', 'Tartu', '');
INSERT INTO `feel_province` VALUES (208, '82', 'EST', '瓦尔加', 'Varga', '');
INSERT INTO `feel_province` VALUES (209, '84', 'EST', '维良地', 'Weiliangdi', '');
INSERT INTO `feel_province` VALUES (210, '59', 'EST', '维鲁', 'Viru', '');
INSERT INTO `feel_province` VALUES (211, '86', 'EST', '沃鲁', 'Waru', '');
INSERT INTO `feel_province` VALUES (212, '39', 'EST', '希尤', 'Chiu', '');
INSERT INTO `feel_province` VALUES (213, '51', 'EST', '耶尔韦', 'Yerway', '');
INSERT INTO `feel_province` VALUES (214, '49', 'EST', '耶盖瓦', 'Jegeva', '');
INSERT INTO `feel_province` VALUES (215, '44', 'EST', '依达－维鲁', 'Ida-Viru', '');
INSERT INTO `feel_province` VALUES (216, '7', 'AND', '安道尔城', 'Andorra la Vella', '');
INSERT INTO `feel_province` VALUES (217, '5', 'AND', '奥尔迪诺', 'Ordino', '');
INSERT INTO `feel_province` VALUES (218, '3', 'AND', '恩坎普', 'Encamp', '');
INSERT INTO `feel_province` VALUES (219, '2', 'AND', '卡尼略', 'Canillo', '');
INSERT INTO `feel_province` VALUES (220, '8', 'AND', '莱塞斯卡尔德－恩戈尔达', 'Les Escaldes-Engorda', '');
INSERT INTO `feel_province` VALUES (221, '4', 'AND', '马萨纳', 'Masana', '');
INSERT INTO `feel_province` VALUES (222, '6', 'AND', '圣胡利娅－德洛里亚', 'Santa julia de loria', '');
INSERT INTO `feel_province` VALUES (223, 'CNO', 'AGO', '北宽扎', 'North Kwanza', '');
INSERT INTO `feel_province` VALUES (224, 'LNO', 'AGO', '北隆达', 'Northern Ronda', '');
INSERT INTO `feel_province` VALUES (225, 'BGO', 'AGO', '本戈', 'Bengo', '');
INSERT INTO `feel_province` VALUES (226, 'BGU', 'AGO', '本格拉', 'Benguela', '');
INSERT INTO `feel_province` VALUES (227, 'BIE', 'AGO', '比耶', 'Biye', '');
INSERT INTO `feel_province` VALUES (228, 'CAB', 'AGO', '卡宾达', 'Cabinda', '');
INSERT INTO `feel_province` VALUES (229, 'CNN', 'AGO', '库内内', 'Kunene', '');
INSERT INTO `feel_province` VALUES (230, 'CCU', 'AGO', '宽多库邦戈', 'Kuando Kubango', '');
INSERT INTO `feel_province` VALUES (231, 'LUA', 'AGO', '罗安达', 'Luanda', '');
INSERT INTO `feel_province` VALUES (232, 'MAL', 'AGO', '马兰热', 'Malanje', '');
INSERT INTO `feel_province` VALUES (233, 'MOX', 'AGO', '莫希科', 'Moxico', '');
INSERT INTO `feel_province` VALUES (234, 'NAM', 'AGO', '纳米贝', 'Namibe', '');
INSERT INTO `feel_province` VALUES (235, 'CUS', 'AGO', '南宽扎', 'South Kwanza', '');
INSERT INTO `feel_province` VALUES (236, 'LSU', 'AGO', '南隆达', 'South 隆达', '');
INSERT INTO `feel_province` VALUES (237, 'HUA', 'AGO', '万博', 'Wanbo', '');
INSERT INTO `feel_province` VALUES (238, 'HUI', 'AGO', '威拉', 'Willa', '');
INSERT INTO `feel_province` VALUES (239, 'UIG', 'AGO', '威热', 'Uige', '');
INSERT INTO `feel_province` VALUES (240, 'ZAI', 'AGO', '扎伊尔', 'Zaire', '');
INSERT INTO `feel_province` VALUES (241, 'NT', 'AUS', '北部地区', 'Northern region', '');
INSERT INTO `feel_province` VALUES (242, 'ACT', 'AUS', '堪培拉', 'Canberra', '');
INSERT INTO `feel_province` VALUES (243, 'QLD', 'AUS', '昆士兰', 'Queensland', '');
INSERT INTO `feel_province` VALUES (244, 'SA', 'AUS', '南澳大利亚', 'South Australia', '');
INSERT INTO `feel_province` VALUES (245, 'TAS', 'AUS', '塔斯马尼亚', 'Tasmania', '');
INSERT INTO `feel_province` VALUES (246, 'VIC', 'AUS', '维多利亚', 'Victoria', '');
INSERT INTO `feel_province` VALUES (247, 'WA', 'AUS', '西澳大利亚', 'Western Australia', '');
INSERT INTO `feel_province` VALUES (248, 'NSW', 'AUS', '新南威尔士', 'New South Wales', '');
INSERT INTO `feel_province` VALUES (249, 'BUR', 'AUT', '布尔根兰', 'Burgenland', '');
INSERT INTO `feel_province` VALUES (250, 'TYR', 'AUT', '蒂罗尔', 'Tyrol', '');
INSERT INTO `feel_province` VALUES (251, 'VOR', 'AUT', '福拉尔贝格', 'Vorarlberg', '');
INSERT INTO `feel_province` VALUES (252, 'CAT', 'AUT', '克恩顿', 'Kernton', '');
INSERT INTO `feel_province` VALUES (253, 'SZG', 'AUT', '萨尔茨堡', 'Salzburg', '');
INSERT INTO `feel_province` VALUES (254, 'UAU', 'AUT', '上奥地利', 'Upper Austria', '');
INSERT INTO `feel_province` VALUES (255, 'STY', 'AUT', '施蒂利亚', 'Styria', '');
INSERT INTO `feel_province` VALUES (256, 'VDD', 'AUT', '维也纳', 'Vienna', '');
INSERT INTO `feel_province` VALUES (257, 'LAU', 'AUT', '下奥地利', 'Lower Austria', '');
INSERT INTO `feel_province` VALUES (258, 'NO', 'PNG', '北部', 'North', '');
INSERT INTO `feel_province` VALUES (259, 'BV', 'PNG', '布干维尔', 'Bougainville', '');
INSERT INTO `feel_province` VALUES (260, 'EH', 'PNG', '东部高地', 'Eastern Highlands', '');
INSERT INTO `feel_province` VALUES (261, 'ES', 'PNG', '东塞皮克', 'East sepik', '');
INSERT INTO `feel_province` VALUES (262, 'EB', 'PNG', '东新不列颠', 'East New Britain', '');
INSERT INTO `feel_province` VALUES (263, 'EN', 'PNG', '恩加', 'Enga', '');
INSERT INTO `feel_province` VALUES (264, 'GU', 'PNG', '海湾', 'bay', '');
INSERT INTO `feel_province` VALUES (265, 'MD', 'PNG', '马当', 'Madang', '');
INSERT INTO `feel_province` VALUES (266, 'MN', 'PNG', '马努斯', 'Manus', '');
INSERT INTO `feel_province` VALUES (267, 'MB', 'PNG', '米尔恩湾', 'Milne Bay', '');
INSERT INTO `feel_province` VALUES (268, 'NC', 'PNG', '莫尔兹比港', 'Port Moresby', '');
INSERT INTO `feel_province` VALUES (269, 'MR', 'PNG', '莫罗贝', 'Morobe', '');
INSERT INTO `feel_province` VALUES (270, 'SH', 'PNG', '南部高地', 'Southern highlands', '');
INSERT INTO `feel_province` VALUES (271, 'SI', 'PNG', '钦布', 'Chinbu', '');
INSERT INTO `feel_province` VALUES (272, 'SA', 'PNG', '桑道恩', 'Sandauen', '');
INSERT INTO `feel_province` VALUES (273, 'WE', 'PNG', '西部', 'west', '');
INSERT INTO `feel_province` VALUES (274, 'WH', 'PNG', '西部高地', 'Western Highlands', '');
INSERT INTO `feel_province` VALUES (275, 'WB', 'PNG', '西新不列颠', 'West New Britain', '');
INSERT INTO `feel_province` VALUES (276, 'NI', 'PNG', '新爱尔兰', 'New ireland', '');
INSERT INTO `feel_province` VALUES (277, 'PEW', 'PAK', '白沙瓦', 'Peshawar', '');
INSERT INTO `feel_province` VALUES (278, 'LYP', 'PAK', '费萨拉巴德', 'Faisalabad', '');
INSERT INTO `feel_province` VALUES (279, 'GUJ', 'PAK', '故吉软瓦拉', 'Kyrgyzstan', '');
INSERT INTO `feel_province` VALUES (280, 'HDD', 'PAK', '海德拉巴', 'Hyderabad', '');
INSERT INTO `feel_province` VALUES (281, 'KCT', 'PAK', '卡拉奇', 'Karachi', '');
INSERT INTO `feel_province` VALUES (282, 'LHE', 'PAK', '拉合尔', 'Lahore', '');
INSERT INTO `feel_province` VALUES (283, 'RWP', 'PAK', '拉瓦尔品第', 'Rawalpindi', '');
INSERT INTO `feel_province` VALUES (284, 'MUX', 'PAK', '木尔坦', 'Multan', '');
INSERT INTO `feel_province` VALUES (285, 'ISB', 'PAK', '伊斯兰堡', 'Islamabad', '');
INSERT INTO `feel_province` VALUES (286, 'AM', 'PRY', '阿曼拜', 'Amanbai', '');
INSERT INTO `feel_province` VALUES (287, 'PH', 'PRY', '阿耶斯总统省', 'President Ayers Province', '');
INSERT INTO `feel_province` VALUES (288, 'PA', 'PRY', '巴拉瓜里', 'Baraguari', '');
INSERT INTO `feel_province` VALUES (289, 'BO', 'PRY', '博克龙', 'Bokron', '');
INSERT INTO `feel_province` VALUES (290, 'GU', 'PRY', '瓜伊拉', 'Guaira', '');
INSERT INTO `feel_province` VALUES (291, 'CG', 'PRY', '卡瓜苏', 'Caguasu', '');
INSERT INTO `feel_province` VALUES (292, 'CN', 'PRY', '卡嫩迪尤', 'Canndidiu', '');
INSERT INTO `feel_province` VALUES (293, 'CZ', 'PRY', '卡萨帕', 'Casapa', '');
INSERT INTO `feel_province` VALUES (294, 'CC', 'PRY', '康塞普西翁', 'Concepcion', '');
INSERT INTO `feel_province` VALUES (295, 'CD', 'PRY', '科迪勒拉', 'Cordillera', '');
INSERT INTO `feel_province` VALUES (296, 'MI', 'PRY', '米西奥内斯', 'Misiones', '');
INSERT INTO `feel_province` VALUES (297, 'NE', 'PRY', '涅恩布库', 'Nienbuku', '');
INSERT INTO `feel_province` VALUES (298, 'AG', 'PRY', '上巴拉圭', 'Upper Paraguay', '');
INSERT INTO `feel_province` VALUES (299, 'AN', 'PRY', '上巴拉那', 'Upper Parana', '');
INSERT INTO `feel_province` VALUES (300, 'SP', 'PRY', '圣佩德罗', 'San Pedro', '');
INSERT INTO `feel_province` VALUES (301, 'AS', 'PRY', '亚松森特别区', 'Asuncion Special District', '');
INSERT INTO `feel_province` VALUES (302, 'IT', 'PRY', '伊塔普亚', 'Itapua', '');
INSERT INTO `feel_province` VALUES (303, 'CE', 'PRY', '中央', 'central', '');
INSERT INTO `feel_province` VALUES (304, 'GZ', 'PSE', '加沙地带', 'Gaza Strip', '');
INSERT INTO `feel_province` VALUES (305, 'WE', 'PSE', '西岸', 'West Bank', '');
INSERT INTO `feel_province` VALUES (306, '5', 'BHR', '北部', 'North', '');
INSERT INTO `feel_province` VALUES (307, '1', 'BHR', '哈德', 'Hard', '');
INSERT INTO `feel_province` VALUES (308, '12', 'BHR', '哈马德', 'Hamad', '');
INSERT INTO `feel_province` VALUES (309, '9', 'BHR', '里法', 'Lifa', '');
INSERT INTO `feel_province` VALUES (310, '3', 'BHR', '麦纳麦', 'Manama', '');
INSERT INTO `feel_province` VALUES (311, '2', 'BHR', '穆哈拉格', 'Muharraq', '');
INSERT INTO `feel_province` VALUES (312, '10', 'BHR', '西部', 'west', '');
INSERT INTO `feel_province` VALUES (313, '8', 'BHR', '伊萨城', 'Isa City', '');
INSERT INTO `feel_province` VALUES (314, '7', 'BHR', '中部', 'Central', '');
INSERT INTO `feel_province` VALUES (315, 'AC', 'BRA', '阿克里', 'Acre', '');
INSERT INTO `feel_province` VALUES (316, 'AL', 'BRA', '阿拉戈斯', 'Alagos', '');
INSERT INTO `feel_province` VALUES (317, 'AP', 'BRA', '阿马帕', 'Amapa', '');
INSERT INTO `feel_province` VALUES (318, 'PR', 'BRA', '巴拉那', 'Parana', '');
INSERT INTO `feel_province` VALUES (319, 'BSB', 'BRA', '巴西利亚', 'Brasilia', '');
INSERT INTO `feel_province` VALUES (320, 'BA', 'BRA', '巴伊亚', 'Bahia', '');
INSERT INTO `feel_province` VALUES (321, 'RN', 'BRA', '北里奥格兰德', 'Rio Grande', '');
INSERT INTO `feel_province` VALUES (322, 'PE', 'BRA', '伯南布哥', 'Pernambuco', '');
INSERT INTO `feel_province` VALUES (323, 'GO', 'BRA', '戈亚斯', 'Goias', '');
INSERT INTO `feel_province` VALUES (324, 'RO', 'BRA', '朗多尼亚', 'Rondonia', '');
INSERT INTO `feel_province` VALUES (325, 'RJ', 'BRA', '里约热内卢', 'Rio de Janeiro', '');
INSERT INTO `feel_province` VALUES (326, 'RR', 'BRA', '罗赖马', 'Roraima', '');
INSERT INTO `feel_province` VALUES (327, 'MA', 'BRA', '马拉尼昂', 'Maranhão', '');
INSERT INTO `feel_province` VALUES (328, 'MT', 'BRA', '马托格罗索', 'Mato Grosso', '');
INSERT INTO `feel_province` VALUES (329, 'MG', 'BRA', '米纳斯吉拉斯', 'Minas Gerais', '');
INSERT INTO `feel_province` VALUES (330, 'RS', 'BRA', '南里奥格兰德', 'Rio Grande', '');
INSERT INTO `feel_province` VALUES (331, 'MS', 'BRA', '南马托格罗索', 'South Mato Grosso', '');
INSERT INTO `feel_province` VALUES (332, 'PA', 'BRA', '帕拉', 'Para', '');
INSERT INTO `feel_province` VALUES (333, 'PB', 'BRA', '帕拉伊巴', 'Paraiba', '');
INSERT INTO `feel_province` VALUES (334, 'PI', 'BRA', '皮奥伊', 'Pioy', '');
INSERT INTO `feel_province` VALUES (335, 'CE', 'BRA', '塞阿拉', 'Ceara', '');
INSERT INTO `feel_province` VALUES (336, 'SE', 'BRA', '塞尔希培', 'Sergipe', '');
INSERT INTO `feel_province` VALUES (337, 'ES', 'BRA', '圣埃斯皮里图', 'Saint Espirito', '');
INSERT INTO `feel_province` VALUES (338, 'SP', 'BRA', '圣保罗', 'Sao paulo', '');
INSERT INTO `feel_province` VALUES (339, 'SC', 'BRA', '圣卡塔琳娜', 'Santa Catarina', '');
INSERT INTO `feel_province` VALUES (340, 'TO', 'BRA', '托坎廷斯', 'Tocantins', '');
INSERT INTO `feel_province` VALUES (341, 'AM', 'BRA', '亚马孙', 'Amazon', '');
INSERT INTO `feel_province` VALUES (342, 'BR', 'BLR', '布列斯特', 'Brest', '');
INSERT INTO `feel_province` VALUES (343, 'HO', 'BLR', '戈梅利', 'Gomel', '');
INSERT INTO `feel_province` VALUES (344, 'HR', 'BLR', '格罗德诺', 'Grodno', '');
INSERT INTO `feel_province` VALUES (345, 'MI', 'BLR', '明斯克市', 'Minsk', '');
INSERT INTO `feel_province` VALUES (346, 'MA', 'BLR', '莫吉廖夫', 'Mogilev', '');
INSERT INTO `feel_province` VALUES (347, 'VI', 'BLR', '维捷布斯克', 'Vitebsk', '');
INSERT INTO `feel_province` VALUES (348, 'BOJ', 'BGR', '布尔加斯', 'Burgas', '');
INSERT INTO `feel_province` VALUES (349, 'KHO', 'BGR', '卡斯科伏', 'Cascovo', '');
INSERT INTO `feel_province` VALUES (350, 'ROU', 'BGR', '鲁塞', 'Ruse', '');
INSERT INTO `feel_province` VALUES (351, 'LVP', 'BGR', '洛维奇', 'Lovech', '');
INSERT INTO `feel_province` VALUES (352, 'OZA', 'BGR', '蒙塔纳', 'Montana', '');
INSERT INTO `feel_province` VALUES (353, 'PDV', 'BGR', '普罗夫迪夫', 'Plovdiv', '');
INSERT INTO `feel_province` VALUES (354, 'SOF', 'BGR', '索非亚', 'Sofia', '');
INSERT INTO `feel_province` VALUES (355, 'GSO', 'BGR', '索非亚市', 'Sofia', '');
INSERT INTO `feel_province` VALUES (356, 'VAR', 'BGR', '瓦尔纳', 'Varna', '');
INSERT INTO `feel_province` VALUES (357, 'AL', 'BEN', '阿黎博里', 'Alibori', '');
INSERT INTO `feel_province` VALUES (358, 'AK', 'BEN', '阿塔科拉', 'Atakola', '');
INSERT INTO `feel_province` VALUES (359, 'LI', 'BEN', '滨海', 'Coast', '');
INSERT INTO `feel_province` VALUES (360, 'BOH', 'BEN', '波希康市', 'Hakiyasu City', '');
INSERT INTO `feel_province` VALUES (361, 'BO', 'BEN', '博尔古', 'Borgu', '');
INSERT INTO `feel_province` VALUES (362, 'AQ', 'BEN', '大西洋', 'Atlantic', '');
INSERT INTO `feel_province` VALUES (363, 'PL', 'BEN', '高原', 'plateau', '');
INSERT INTO `feel_province` VALUES (364, 'KO', 'BEN', '库福', 'Kufu', '');
INSERT INTO `feel_province` VALUES (365, 'MO', 'BEN', '莫诺', 'Mono', '');
INSERT INTO `feel_province` VALUES (366, 'CO', 'BEN', '丘陵', 'hills', '');
INSERT INTO `feel_province` VALUES (367, 'OU', 'BEN', '韦梅', 'Weimei', '');
INSERT INTO `feel_province` VALUES (368, 'DO', 'BEN', '峡谷', 'canyon', '');
INSERT INTO `feel_province` VALUES (369, 'ZO', 'BEN', '祖', 'Ancestral', '');
INSERT INTO `feel_province` VALUES (370, 'WHT', 'BEL', '埃诺', 'Eno', '');
INSERT INTO `feel_province` VALUES (371, 'VAN', 'BEL', '安特卫普', 'Antwerp', '');
INSERT INTO `feel_province` VALUES (372, 'WBR', 'BEL', '布拉班特瓦隆', 'Brabant Wallon', '');
INSERT INTO `feel_province` VALUES (373, 'BRU', 'BEL', '布鲁塞尔', 'Brussels', '');
INSERT INTO `feel_province` VALUES (374, 'VOV', 'BEL', '东佛兰德', 'East Flanders', '');
INSERT INTO `feel_province` VALUES (375, 'VBR', 'BEL', '佛兰芒布拉班特', 'Flemish Brabant', '');
INSERT INTO `feel_province` VALUES (376, 'WLG', 'BEL', '列日', 'Liege', '');
INSERT INTO `feel_province` VALUES (377, 'VLI', 'BEL', '林堡', 'Limburg', '');
INSERT INTO `feel_province` VALUES (378, 'WLX', 'BEL', '卢森堡', 'Luxembourg', '');
INSERT INTO `feel_province` VALUES (379, 'WNA', 'BEL', '那慕尔', 'Namur', '');
INSERT INTO `feel_province` VALUES (380, 'VWV', 'BEL', '西佛兰德', 'West Flanders', '');
INSERT INTO `feel_province` VALUES (381, 'ELB', 'POL', '埃尔布隆格', 'Elblag', '');
INSERT INTO `feel_province` VALUES (382, 'OLS', 'POL', '奥尔什丁', 'Olsztyn', '');
INSERT INTO `feel_province` VALUES (383, 'OSS', 'POL', '奥斯特罗文卡', 'Ostrovinka', '');
INSERT INTO `feel_province` VALUES (384, 'BZG', 'POL', '比得哥什', 'Bydgoszcz', '');
INSERT INTO `feel_province` VALUES (385, 'PIO', 'POL', '彼得库夫', 'Peter Kuf', '');
INSERT INTO `feel_province` VALUES (386, 'BYT', 'POL', '比托姆', 'Bytom', '');
INSERT INTO `feel_province` VALUES (387, 'BAP', 'POL', '比亚瓦波德拉斯卡', 'Biała Podlaska', '');
INSERT INTO `feel_province` VALUES (388, 'BIA', 'POL', '比亚维斯托克', 'Bialystok', '');
INSERT INTO `feel_province` VALUES (389, 'OPO', 'POL', '波莱', 'Pole', '');
INSERT INTO `feel_province` VALUES (390, 'POZ', 'POL', '波兹南', 'Poznan', '');
INSERT INTO `feel_province` VALUES (391, 'DAB', 'POL', '达布罗瓦戈尼察', 'Dabrovagnica', '');
INSERT INTO `feel_province` VALUES (392, 'GOW', 'POL', '大波兰地区戈茹夫', 'Gorzow, Greater Poland', '');
INSERT INTO `feel_province` VALUES (393, 'WRO', 'POL', '弗罗茨瓦夫', 'Wroclaw', '');
INSERT INTO `feel_province` VALUES (394, 'WLO', 'POL', '弗沃茨瓦韦克', 'Wroclawek', '');
INSERT INTO `feel_province` VALUES (395, 'GDN', 'POL', '格但斯克', 'Gdansk', '');
INSERT INTO `feel_province` VALUES (396, 'GDY', 'POL', '格丁尼亚', 'Gdynia', '');
INSERT INTO `feel_province` VALUES (397, 'GWC', 'POL', '格利维采', 'Gliwice', '');
INSERT INTO `feel_province` VALUES (398, 'GRU', 'POL', '格鲁琼兹', 'Grujonz', '');
INSERT INTO `feel_province` VALUES (399, 'CHO', 'POL', '海乌姆', 'Heum', '');
INSERT INTO `feel_province` VALUES (400, 'WAW', 'POL', '华沙', 'Warsaw', '');
INSERT INTO `feel_province` VALUES (401, 'CHZ', 'POL', '霍茹夫', 'Chorzow', '');
INSERT INTO `feel_province` VALUES (402, 'KAL', 'POL', '卡利什', 'Kalisz', '');
INSERT INTO `feel_province` VALUES (403, 'KTW', 'POL', '卡托维兹', 'Katowice', '');
INSERT INTO `feel_province` VALUES (404, 'KLC', 'POL', '凯尔采', 'Kielce', '');
INSERT INTO `feel_province` VALUES (405, 'KON', 'POL', '科宁', 'Corning', '');
INSERT INTO `feel_province` VALUES (406, 'OSZ', 'POL', '科沙林', 'Kosalin', '');
INSERT INTO `feel_province` VALUES (407, 'KRK', 'POL', '克拉科夫', 'Krakow', '');
INSERT INTO `feel_province` VALUES (408, 'KRO', 'POL', '克罗斯诺', 'Krosno', '');
INSERT INTO `feel_province` VALUES (409, 'RDM', 'POL', '拉多姆', 'Radom', '');
INSERT INTO `feel_province` VALUES (410, 'LEG', 'POL', '莱格尼察', 'Legnica', '');
INSERT INTO `feel_province` VALUES (411, 'LEZ', 'POL', '莱什诺', 'Leszno', '');
INSERT INTO `feel_province` VALUES (412, 'LUL', 'POL', '卢布林', 'Lublin', '');
INSERT INTO `feel_province` VALUES (413, 'RDS', 'POL', '鲁达', 'Ruda', '');
INSERT INTO `feel_province` VALUES (414, 'LOD', 'POL', '罗兹', 'Rhodes', '');
INSERT INTO `feel_province` VALUES (415, 'IEG', 'POL', '绿山城', 'Green Mountain City', '');
INSERT INTO `feel_province` VALUES (416, 'MYL', 'POL', '米什洛维采', 'Mishlovice', '');
INSERT INTO `feel_province` VALUES (417, 'PIL', 'POL', '皮瓦', 'Piva', '');
INSERT INTO `feel_province` VALUES (418, 'PRZ', 'POL', '普热梅希尔', 'Przemy hill', '');
INSERT INTO `feel_province` VALUES (419, 'PLO', 'POL', '普沃茨克', 'Płock', '');
INSERT INTO `feel_province` VALUES (420, 'CIE', 'POL', '切哈努夫', 'Chehanov', '');
INSERT INTO `feel_province` VALUES (421, 'RZE', 'POL', '热舒夫', 'Rzeszow', '');
INSERT INTO `feel_province` VALUES (422, 'SZZ', 'POL', '什切青', 'Szczecin', '');
INSERT INTO `feel_province` VALUES (423, 'SKI', 'POL', '斯凯尔涅维采', 'Skernevice', '');
INSERT INTO `feel_province` VALUES (424, 'SLP', 'POL', '斯武普斯克', 'Svpsk', '');
INSERT INTO `feel_province` VALUES (425, 'SWL', 'POL', '苏瓦乌基', 'Suwałki', '');
INSERT INTO `feel_province` VALUES (426, 'SOP', 'POL', '索波特', 'Sopot', '');
INSERT INTO `feel_province` VALUES (427, 'SWC', 'POL', '索斯诺维茨', 'Sosnowiec', '');
INSERT INTO `feel_province` VALUES (428, 'TAR', 'POL', '塔尔努夫', 'Tarnow', '');
INSERT INTO `feel_province` VALUES (429, 'QEP', 'POL', '塔尔诺布热格', 'Tarnobrzeg', '');
INSERT INTO `feel_province` VALUES (430, 'TYY', 'POL', '特切', 'Special cut', '');
INSERT INTO `feel_province` VALUES (431, 'TOR', 'POL', '托伦', 'Torun', '');
INSERT INTO `feel_province` VALUES (432, 'WZH', 'POL', '瓦乌布日赫', 'Waubzhzh', '');
INSERT INTO `feel_province` VALUES (433, 'QOY', 'POL', '沃姆扎', 'Womza', '');
INSERT INTO `feel_province` VALUES (434, 'SOW', 'POL', '希米亚诺维采', 'Himianovice', '');
INSERT INTO `feel_province` VALUES (435, 'SWI', 'POL', '希维诺乌伊希切', 'Swinoujic', '');
INSERT INTO `feel_province` VALUES (436, 'SWT', 'POL', '希维托赫洛维采', 'Svitto Hlovice', '');
INSERT INTO `feel_province` VALUES (437, 'SDC', 'POL', '谢德尔采', 'Sheddell', '');
INSERT INTO `feel_province` VALUES (438, 'SIR', 'POL', '谢拉兹', 'Sheraz', '');
INSERT INTO `feel_province` VALUES (439, 'NOW', 'POL', '新松奇', 'New song', '');
INSERT INTO `feel_province` VALUES (440, 'JAW', 'POL', '雅沃兹诺', 'Yavozno', '');
INSERT INTO `feel_province` VALUES (441, 'JEG', 'POL', '耶莱尼亚古拉', 'Jelenia Gula', '');
INSERT INTO `feel_province` VALUES (442, 'ZAB', 'POL', '扎布热', 'Zabrze', '');
INSERT INTO `feel_province` VALUES (443, 'ZAM', 'POL', '扎莫希奇', 'Zamošic', '');
INSERT INTO `feel_province` VALUES (444, 'ALT', 'BOL', '奥尔托', 'Orto', '');
INSERT INTO `feel_province` VALUES (445, 'ORU', 'BOL', '奥鲁罗', 'Oruro', '');
INSERT INTO `feel_province` VALUES (446, 'BEN', 'BOL', '贝尼', 'Beni', '');
INSERT INTO `feel_province` VALUES (447, 'POI', 'BOL', '波多西', 'Podosi', '');
INSERT INTO `feel_province` VALUES (448, 'QUI', 'BOL', '基拉科洛', 'Kirakolo', '');
INSERT INTO `feel_province` VALUES (449, 'CBB', 'BOL', '科恰班巴', 'Cochabamba', '');
INSERT INTO `feel_province` VALUES (450, 'LPB', 'BOL', '拉巴斯', 'La Paz', '');
INSERT INTO `feel_province` VALUES (451, 'PAN', 'BOL', '潘多', 'Pando', '');
INSERT INTO `feel_province` VALUES (452, 'CHU', 'BOL', '丘基萨卡', 'Chuquisaca', '');
INSERT INTO `feel_province` VALUES (453, 'SAC', 'BOL', '萨卡巴', 'Saqaba', '');
INSERT INTO `feel_province` VALUES (454, 'SRZ', 'BOL', '圣克鲁斯', 'Santa cruz', '');
INSERT INTO `feel_province` VALUES (455, 'TJA', 'BOL', '塔里哈', 'Tariha', '');
INSERT INTO `feel_province` VALUES (456, 'FPO', 'BIH', '波萨维纳', 'Posavina', '');
INSERT INTO `feel_province` VALUES (457, 'FBP', 'BIH', '波斯尼亚－波德里涅', 'Bosnia-Bodrinje', '');
INSERT INTO `feel_province` VALUES (458, 'FTO', 'BIH', '多米斯拉夫格勒', 'Domislavgrad', '');
INSERT INTO `feel_province` VALUES (459, 'FHN', 'BIH', '黑塞哥维那－涅雷特瓦', 'Herzegovina-Neretva', '');
INSERT INTO `feel_province` VALUES (460, 'FSA', 'BIH', '萨拉热窝', 'Sarajevo', '');
INSERT INTO `feel_province` VALUES (461, 'FTU', 'BIH', '图兹拉－波德里涅', 'Tuzla-Podrine', '');
INSERT INTO `feel_province` VALUES (462, 'FUS', 'BIH', '乌纳－萨纳', 'Una-Sana', '');
INSERT INTO `feel_province` VALUES (463, 'FHB', 'BIH', '西波斯尼亚', 'West bosnia', '');
INSERT INTO `feel_province` VALUES (464, 'FZH', 'BIH', '西黑塞哥维那', 'West Herzegovina', '');
INSERT INTO `feel_province` VALUES (465, 'FZE', 'BIH', '泽尼察－多博伊', 'Zenica-Doboj', '');
INSERT INTO `feel_province` VALUES (466, 'FSB', 'BIH', '中波斯尼亚', 'Central Bosnia', '');
INSERT INTO `feel_province` VALUES (467, 'BZ', 'BLZ', '伯利兹', 'Belize', '');
INSERT INTO `feel_province` VALUES (468, 'OW', 'BLZ', '橘园', 'Orangery', '');
INSERT INTO `feel_province` VALUES (469, 'CY', 'BLZ', '卡约', 'Kayo', '');
INSERT INTO `feel_province` VALUES (470, 'CR', 'BLZ', '科罗萨尔', 'Corozal', '');
INSERT INTO `feel_province` VALUES (471, 'SC', 'BLZ', '斯坦港', 'Stan Harbor', '');
INSERT INTO `feel_province` VALUES (472, 'TO', 'BLZ', '托莱多', 'Toledo', '');
INSERT INTO `feel_province` VALUES (473, 'BAL', 'BFA', '巴雷', 'Barre', '');
INSERT INTO `feel_province` VALUES (474, 'BAM', 'BFA', '巴姆', 'Bam', '');
INSERT INTO `feel_province` VALUES (475, 'BAN', 'BFA', '巴瓦', 'Bawa', '');
INSERT INTO `feel_province` VALUES (476, 'BAZ', 'BFA', '巴泽加', 'Bazega', '');
INSERT INTO `feel_province` VALUES (477, 'PON', 'BFA', '波尼', 'Poni', '');
INSERT INTO `feel_province` VALUES (478, 'BLG', 'BFA', '布尔古', 'Burgu', '');
INSERT INTO `feel_province` VALUES (479, 'BOK', 'BFA', '布尔基恩德', 'Burkind', '');
INSERT INTO `feel_province` VALUES (480, 'BOR', 'BFA', '布古里巴', 'Buguriba', '');
INSERT INTO `feel_province` VALUES (481, 'GAN', 'BFA', '冈祖尔古', 'Gangzulgu', '');
INSERT INTO `feel_province` VALUES (482, 'GOU', 'BFA', '古尔马', 'Gulma', '');
INSERT INTO `feel_province` VALUES (483, 'ZIR', 'BFA', '济罗', 'Ziro', '');
INSERT INTO `feel_province` VALUES (484, 'KAD', 'BFA', '卡焦戈', 'Kagiogo', '');
INSERT INTO `feel_province` VALUES (485, 'KEN', 'BFA', '凯内杜古', 'Kenedogu', '');
INSERT INTO `feel_province` VALUES (486, 'KOO', 'BFA', '科蒙加里', 'Comongary', '');
INSERT INTO `feel_province` VALUES (487, 'COM', 'BFA', '科莫埃', 'Comoie', '');
INSERT INTO `feel_province` VALUES (488, 'KOP', 'BFA', '孔皮恩加', 'Conpinga', '');
INSERT INTO `feel_province` VALUES (489, 'KOS', 'BFA', '孔西', 'Kongxi', '');
INSERT INTO `feel_province` VALUES (490, 'KOL', 'BFA', '库尔佩罗戈', 'Culperogo', '');
INSERT INTO `feel_province` VALUES (491, 'KOW', 'BFA', '库尔维奥戈', 'Culviogo', '');
INSERT INTO `feel_province` VALUES (492, 'KOT', 'BFA', '库里滕加', 'Curritenga', '');
INSERT INTO `feel_province` VALUES (493, 'LER', 'BFA', '雷拉巴', 'Lelaba', '');
INSERT INTO `feel_province` VALUES (494, 'LOR', 'BFA', '罗卢姆', 'Lolum', '');
INSERT INTO `feel_province` VALUES (495, 'MOU', 'BFA', '穆翁', 'Muon', '');
INSERT INTO `feel_province` VALUES (496, 'NAM', 'BFA', '纳门滕加', 'Narmentenga', '');
INSERT INTO `feel_province` VALUES (497, 'NAH', 'BFA', '纳乌里', 'Nauri', '');
INSERT INTO `feel_province` VALUES (498, 'NAY', 'BFA', '纳亚拉', 'Nayala', '');
INSERT INTO `feel_province` VALUES (499, 'GNA', 'BFA', '尼亚尼亚', 'Nynia', '');
INSERT INTO `feel_province` VALUES (500, 'NOU', 'BFA', '努姆比埃尔', 'Numbier', '');
INSERT INTO `feel_province` VALUES (501, 'PAS', 'BFA', '帕索雷', 'Pasole', '');
INSERT INTO `feel_province` VALUES (502, 'SEN', 'BFA', '塞诺', 'Seno', '');
INSERT INTO `feel_province` VALUES (503, 'SAG', 'BFA', '桑吉', 'Sanji', '');
INSERT INTO `feel_province` VALUES (504, 'SAM', 'BFA', '桑马滕加', 'Sanmatenga', '');
INSERT INTO `feel_province` VALUES (505, 'SOR', 'BFA', '苏鲁', 'Sulu', '');
INSERT INTO `feel_province` VALUES (506, 'SOM', 'BFA', '苏姆', 'Sum', '');
INSERT INTO `feel_province` VALUES (507, 'TAP', 'BFA', '塔波阿', 'Tapoa', '');
INSERT INTO `feel_province` VALUES (508, 'TUY', 'BFA', '图伊', 'Tui', '');
INSERT INTO `feel_province` VALUES (509, 'HOU', 'BFA', '乌埃', 'Ue', '');
INSERT INTO `feel_province` VALUES (510, 'OUB', 'BFA', '乌布里滕加', 'Ubritenga', '');
INSERT INTO `feel_province` VALUES (511, 'OUD', 'BFA', '乌达兰', 'Udalan', '');
INSERT INTO `feel_province` VALUES (512, 'SIS', 'BFA', '锡西里', 'Sicily', '');
INSERT INTO `feel_province` VALUES (513, 'YAG', 'BFA', '亚加', 'Yajia', '');
INSERT INTO `feel_province` VALUES (514, 'YAT', 'BFA', '亚滕加', 'Yatenga', '');
INSERT INTO `feel_province` VALUES (515, 'IOA', 'BFA', '伊奥巴', 'Ioba', '');
INSERT INTO `feel_province` VALUES (516, 'ZOW', 'BFA', '宗德韦奥戈', 'Zongdeweiogo', '');
INSERT INTO `feel_province` VALUES (517, 'ZOD', 'BFA', '宗多马', 'Zongdoma', '');
INSERT INTO `feel_province` VALUES (518, 'BB', 'BDI', '布班扎', 'Bubanza', '');
INSERT INTO `feel_province` VALUES (519, 'BR', 'BDI', '布鲁里', 'Buruli', '');
INSERT INTO `feel_province` VALUES (520, 'BM', 'BDI', '布琼布拉城市', 'Building city', '');
INSERT INTO `feel_province` VALUES (521, 'BU', 'BDI', '布琼布拉乡村', 'Building village', '');
INSERT INTO `feel_province` VALUES (522, 'NG', 'BDI', '恩戈齐', 'Ngozi', '');
INSERT INTO `feel_province` VALUES (523, 'KI', 'BDI', '基龙多', 'Kirundo', '');
INSERT INTO `feel_province` VALUES (524, 'GI', 'BDI', '基特加', 'Kitega', '');
INSERT INTO `feel_province` VALUES (525, 'KR', 'BDI', '卡鲁济', 'Caruzzi', '');
INSERT INTO `feel_province` VALUES (526, 'KY', 'BDI', '卡扬扎', 'Kayanza', '');
INSERT INTO `feel_province` VALUES (527, 'CA', 'BDI', '坎库佐', 'Cankuzo', '');
INSERT INTO `feel_province` VALUES (528, 'RT', 'BDI', '鲁塔纳', 'Rutana', '');
INSERT INTO `feel_province` VALUES (529, 'RY', 'BDI', '鲁伊吉', 'Ikichi Tsuji', '');
INSERT INTO `feel_province` VALUES (530, 'MA', 'BDI', '马坎巴', 'Makamba', '');
INSERT INTO `feel_province` VALUES (531, 'MU', 'BDI', '穆拉姆维亚', 'Muramvia', '');
INSERT INTO `feel_province` VALUES (532, 'MW', 'BDI', '穆瓦洛', 'Muvalo', '');
INSERT INTO `feel_province` VALUES (533, 'MY', 'BDI', '穆因加', 'Muyinga', '');
INSERT INTO `feel_province` VALUES (534, 'CI', 'BDI', '锡比托凯', 'Sibitoka', '');
INSERT INTO `feel_province` VALUES (535, 'HAE', 'PRK', '海州', 'Haizhou', '');
INSERT INTO `feel_province` VALUES (536, 'HYE', 'PRK', '惠山', 'Huishan', '');
INSERT INTO `feel_province` VALUES (537, 'KAN', 'PRK', '江界', 'Jiangjie', '');
INSERT INTO `feel_province` VALUES (538, 'KSN', 'PRK', '开城', 'Kaicheng', '');
INSERT INTO `feel_province` VALUES (539, 'NAS', 'PRK', '罗先', 'Luo Xian', '');
INSERT INTO `feel_province` VALUES (540, 'NAM', 'PRK', '南浦', 'Nanpu', '');
INSERT INTO `feel_province` VALUES (541, 'FNJ', 'PRK', '平壤', 'Pyongyang', '');
INSERT INTO `feel_province` VALUES (542, 'CHO', 'PRK', '清津', 'Kiyotsu', '');
INSERT INTO `feel_province` VALUES (543, 'SAR', 'PRK', '沙里院', 'Shaliyuan', '');
INSERT INTO `feel_province` VALUES (544, 'HAM', 'PRK', '咸兴', 'Xianxing', '');
INSERT INTO `feel_province` VALUES (545, 'SII', 'PRK', '新义州', 'Sinuiju', '');
INSERT INTO `feel_province` VALUES (546, 'WON', 'PRK', '元山', 'Yuanshan', '');
INSERT INTO `feel_province` VALUES (547, 'AR', 'DNK', '奥胡斯', 'Aarhus', '');
INSERT INTO `feel_province` VALUES (548, 'VSV', 'DNK', '北日德兰', 'North Jutland', '');
INSERT INTO `feel_province` VALUES (549, 'BO', 'DNK', '博恩霍尔姆', 'Bornholm', '');
INSERT INTO `feel_province` VALUES (550, 'FRE', 'DNK', '菲特烈堡', 'Frederiksborg', '');
INSERT INTO `feel_province` VALUES (551, 'FY', 'DNK', '菲茵', 'Fei Yin', '');
INSERT INTO `feel_province` VALUES (552, 'CPH', 'DNK', '哥本哈根', 'Copenhagen', '');
INSERT INTO `feel_province` VALUES (553, 'RIB', 'DNK', '里伯', 'Ribe', '');
INSERT INTO `feel_province` VALUES (554, 'RKG', 'DNK', '灵克宾', 'Ling Kebin', '');
INSERT INTO `feel_province` VALUES (555, 'RKE', 'DNK', '罗斯基勒', 'Roskilde', '');
INSERT INTO `feel_province` VALUES (556, 'VBI', 'DNK', '南日德兰', 'South Jutland', '');
INSERT INTO `feel_province` VALUES (557, 'ST', 'DNK', '斯多斯特姆', 'Stostrom', '');
INSERT INTO `feel_province` VALUES (558, 'VIB', 'DNK', '维堡', 'Vyborg', '');
INSERT INTO `feel_province` VALUES (559, 'VEJ', 'DNK', '维厄勒', 'Viel', '');
INSERT INTO `feel_province` VALUES (560, 'VS', 'DNK', '西希兰', 'Sihilan', '');
INSERT INTO `feel_province` VALUES (561, 'ARN', 'DEU', '阿恩斯贝格', 'Arnsberg', '');
INSERT INTO `feel_province` VALUES (562, 'ERF', 'DEU', '爱尔福特', 'Erfurt', '');
INSERT INTO `feel_province` VALUES (563, 'ANS', 'DEU', '安斯巴格', 'Ansbag', '');
INSERT INTO `feel_province` VALUES (564, 'AGB', 'DEU', '奥格斯堡', 'Augsburg', '');
INSERT INTO `feel_province` VALUES (565, 'BE', 'DEU', '柏林', 'Berlin', '');
INSERT INTO `feel_province` VALUES (566, 'BYU', 'DEU', '拜伊罗特', 'Bayirot', '');
INSERT INTO `feel_province` VALUES (567, 'BFE', 'DEU', '比勒费尔德', 'Bielefeld', '');
INSERT INTO `feel_province` VALUES (568, 'POT', 'DEU', '波茨坦', 'Potsdam', '');
INSERT INTO `feel_province` VALUES (569, 'BOM', 'DEU', '波鸿', 'Bochum', '');
INSERT INTO `feel_province` VALUES (570, 'HB', 'DEU', '不来梅', 'Bremen', '');
INSERT INTO `feel_province` VALUES (571, 'BRW', 'DEU', '不伦瑞克', 'Brunswick', '');
INSERT INTO `feel_province` VALUES (572, 'DAR', 'DEU', '达姆施塔特', 'Darmstadt', '');
INSERT INTO `feel_province` VALUES (573, 'DET', 'DEU', '代特莫尔特', 'Det Molt', '');
INSERT INTO `feel_province` VALUES (574, 'DRS', 'DEU', '德累斯顿', 'Dresden', '');
INSERT INTO `feel_province` VALUES (575, 'DES', 'DEU', '德绍', 'Dessau', '');
INSERT INTO `feel_province` VALUES (576, 'DUS', 'DEU', '杜塞尔多夫', 'Dusseldorf', '');
INSERT INTO `feel_province` VALUES (577, 'FFO', 'DEU', '法兰克福', 'Frankfurt', '');
INSERT INTO `feel_province` VALUES (578, 'FBG', 'DEU', '弗赖堡', 'Freiburg', '');
INSERT INTO `feel_province` VALUES (579, 'HAE', 'DEU', '哈雷', 'Halle', '');
INSERT INTO `feel_province` VALUES (580, 'HH', 'DEU', '汉堡', 'Burger', '');
INSERT INTO `feel_province` VALUES (581, 'HAJ', 'DEU', '汉诺威', 'Hannover', '');
INSERT INTO `feel_province` VALUES (582, 'KEL', 'DEU', '基尔', 'Kiel', '');
INSERT INTO `feel_province` VALUES (583, 'GBN', 'DEU', '吉森', 'Giessen', '');
INSERT INTO `feel_province` VALUES (584, 'KAE', 'DEU', '卡尔斯鲁厄', 'Karlsruhe', '');
INSERT INTO `feel_province` VALUES (585, 'KAS', 'DEU', '卡塞尔', 'Kassel', '');
INSERT INTO `feel_province` VALUES (586, 'CHE', 'DEU', '开姆尼斯', 'Chemnitz', '');
INSERT INTO `feel_province` VALUES (587, 'KOB', 'DEU', '科布伦次', 'Kobrun', '');
INSERT INTO `feel_province` VALUES (588, 'CGN', 'DEU', '科隆', 'Cologne', '');
INSERT INTO `feel_province` VALUES (589, 'LEJ', 'DEU', '莱比锡', 'Leipzig', '');
INSERT INTO `feel_province` VALUES (590, 'LDH', 'DEU', '兰茨胡特', 'Landshut', '');
INSERT INTO `feel_province` VALUES (591, 'LBG', 'DEU', '吕讷堡', 'Luneburg', '');
INSERT INTO `feel_province` VALUES (592, 'MAG', 'DEU', '马格德堡', 'Magdeburg', '');
INSERT INTO `feel_province` VALUES (593, 'MHG', 'DEU', '曼海姆', 'Mannheim', '');
INSERT INTO `feel_province` VALUES (594, 'MAI', 'DEU', '美因兹', 'Mainz', '');
INSERT INTO `feel_province` VALUES (595, 'MUN', 'DEU', '明斯特', 'Münster', '');
INSERT INTO `feel_province` VALUES (596, 'MUC', 'DEU', '慕尼黑', 'Munich', '');
INSERT INTO `feel_province` VALUES (597, 'NUE', 'DEU', '纽伦堡', 'Nuremberg', '');
INSERT INTO `feel_province` VALUES (598, 'SWH', 'DEU', '什未林', 'Schwerin', '');
INSERT INTO `feel_province` VALUES (599, 'STR', 'DEU', '斯图加特', 'Stuttgart', '');
INSERT INTO `feel_province` VALUES (600, 'TRI', 'DEU', '特里尔', 'Trier', '');
INSERT INTO `feel_province` VALUES (601, 'WIB', 'DEU', '威斯巴登', 'Wiesbaden', '');
INSERT INTO `feel_province` VALUES (602, 'WUG', 'DEU', '维尔茨堡', 'Wuerzburg', '');
INSERT INTO `feel_province` VALUES (603, 'AL', 'TLS', '阿伊莱乌', 'Aileu', '');
INSERT INTO `feel_province` VALUES (604, 'AN', 'TLS', '阿伊纳罗', 'Ainaro', '');
INSERT INTO `feel_province` VALUES (605, 'ER', 'TLS', '埃尔梅拉', 'Ermera', '');
INSERT INTO `feel_province` VALUES (606, 'AM', 'TLS', '安贝诺', 'Ambeno', '');
INSERT INTO `feel_province` VALUES (607, 'BA', 'TLS', '包考', 'Package test', '');
INSERT INTO `feel_province` VALUES (608, 'BO', 'TLS', '博博纳罗', 'Bobonaro', '');
INSERT INTO `feel_province` VALUES (609, 'DI', 'TLS', '帝力', 'Dili', '');
INSERT INTO `feel_province` VALUES (610, 'KO', 'TLS', '科瓦利马', 'Kovalima', '');
INSERT INTO `feel_province` VALUES (611, 'LA', 'TLS', '劳滕', 'Lauten', '');
INSERT INTO `feel_province` VALUES (612, 'LI', 'TLS', '利基卡', 'Likika', '');
INSERT INTO `feel_province` VALUES (613, 'MT', 'TLS', '马纳图托', 'Manatuto', '');
INSERT INTO `feel_province` VALUES (614, 'MF', 'TLS', '马努法伊', 'Manufay', '');
INSERT INTO `feel_province` VALUES (615, 'VI', 'TLS', '维克克', 'Vick', '');
INSERT INTO `feel_province` VALUES (616, 'M', 'TGO', '滨海区', 'Coastal area', '');
INSERT INTO `feel_province` VALUES (617, 'S', 'TGO', '草原区', 'Grassland area', '');
INSERT INTO `feel_province` VALUES (618, 'P', 'TGO', '高原区', 'Plateau', '');
INSERT INTO `feel_province` VALUES (619, 'K', 'TGO', '卡拉区', 'Kara District', '');
INSERT INTO `feel_province` VALUES (620, 'C', 'TGO', '中部区', 'Central District', '');
INSERT INTO `feel_province` VALUES (621, 'ABA', 'RUS', '阿巴坎', 'Abakan', '');
INSERT INTO `feel_province` VALUES (622, 'ARK', 'RUS', '阿尔汉格尔斯克', 'Arkhangelsk', '');
INSERT INTO `feel_province` VALUES (623, 'AGI', 'RUS', '阿金斯科耶', 'Akinskoye', '');
INSERT INTO `feel_province` VALUES (624, 'DYR', 'RUS', '阿纳德尔', 'Anadyr', '');
INSERT INTO `feel_province` VALUES (625, 'AST', 'RUS', '阿斯特拉罕', 'Astrakhan', '');
INSERT INTO `feel_province` VALUES (626, 'ESL', 'RUS', '埃利斯塔', 'Elista', '');
INSERT INTO `feel_province` VALUES (627, 'ORL', 'RUS', '奥廖尔', 'Orel', '');
INSERT INTO `feel_province` VALUES (628, 'ORE', 'RUS', '奥伦堡', 'Orenburg', '');
INSERT INTO `feel_province` VALUES (629, 'BAX', 'RUS', '巴尔瑙尔', 'Barnaul', '');
INSERT INTO `feel_province` VALUES (630, 'PNZ', 'RUS', '奔萨', 'Penza', '');
INSERT INTO `feel_province` VALUES (631, 'PKC', 'RUS', '彼得罗巴甫洛夫斯克', 'Petropavlovsk', '');
INSERT INTO `feel_province` VALUES (632, 'PES', 'RUS', '彼得罗扎沃茨克', 'Petrozavodsk', '');
INSERT INTO `feel_province` VALUES (633, 'PER', 'RUS', '彼尔姆', 'Perm', '');
INSERT INTO `feel_province` VALUES (634, 'BBZ', 'RUS', '比罗比詹', 'Birobidzhan', '');
INSERT INTO `feel_province` VALUES (635, 'BEL', 'RUS', '别尔哥罗德', 'Belgorod', '');
INSERT INTO `feel_province` VALUES (636, 'COK', 'RUS', '伯力', 'Bo Li', '');
INSERT INTO `feel_province` VALUES (637, 'BQS', 'RUS', '布拉戈维申斯克', 'Blagoveshchensk', '');
INSERT INTO `feel_province` VALUES (638, 'BRY', 'RUS', '布良斯克', 'Bryansk', '');
INSERT INTO `feel_province` VALUES (639, 'CHE', 'RUS', '车里雅宾斯克', 'Chelyabinsk', '');
INSERT INTO `feel_province` VALUES (640, 'CHI', 'RUS', '赤塔', 'Chita', '');
INSERT INTO `feel_province` VALUES (641, 'ROS', 'RUS', '顿河畔罗斯托夫', 'Rostov-on-Don', '');
INSERT INTO `feel_province` VALUES (642, 'OMS', 'RUS', '鄂木斯克', 'Omsk', '');
INSERT INTO `feel_province` VALUES (643, 'VOG', 'RUS', '伏尔加格勒', 'Volgograd', '');
INSERT INTO `feel_province` VALUES (644, 'VMR', 'RUS', '弗拉基米尔', 'Vladimir', '');
INSERT INTO `feel_province` VALUES (645, 'VLA', 'RUS', '弗拉季高加索', 'Vladimir Caucasus', '');
INSERT INTO `feel_province` VALUES (646, 'GOA', 'RUS', '戈尔诺－阿尔泰斯克', 'Gorno-Altaysk', '');
INSERT INTO `feel_province` VALUES (647, 'GRV', 'RUS', '格罗兹尼', 'Grozny', '');
INSERT INTO `feel_province` VALUES (648, 'VVO', 'RUS', '海参崴', 'Vladivostok', '');
INSERT INTO `feel_province` VALUES (649, 'KHM', 'RUS', '汉特－曼西斯克', 'Hunter-Mansisk', '');
INSERT INTO `feel_province` VALUES (650, 'KIR', 'RUS', '基洛夫', 'Kirov', '');
INSERT INTO `feel_province` VALUES (651, 'KGD', 'RUS', '加里宁格勒', 'Kaliningrad', '');
INSERT INTO `feel_province` VALUES (652, 'KZN', 'RUS', '喀山', 'Kazan', '');
INSERT INTO `feel_province` VALUES (653, 'KLF', 'RUS', '卡卢加', 'Kaluga', '');
INSERT INTO `feel_province` VALUES (654, 'KOS', 'RUS', '科斯特罗马', 'Kostroma', '');
INSERT INTO `feel_province` VALUES (655, 'KRR', 'RUS', '克拉斯诺达尔', 'Krasnodar', '');
INSERT INTO `feel_province` VALUES (656, 'KYA', 'RUS', '克拉斯诺亚尔斯克', 'Krasnoyarsk', '');
INSERT INTO `feel_province` VALUES (657, 'KEM', 'RUS', '克麦罗沃', 'Kemerovo', '');
INSERT INTO `feel_province` VALUES (658, 'KYZ', 'RUS', '克孜勒', 'Kyzyl', '');
INSERT INTO `feel_province` VALUES (659, 'KUD', 'RUS', '库德姆卡尔', 'Kudmkar', '');
INSERT INTO `feel_province` VALUES (660, 'KRO', 'RUS', '库尔干', 'Kurgan', '');
INSERT INTO `feel_province` VALUES (661, 'URS', 'RUS', '库尔斯克', 'Kursk', '');
INSERT INTO `feel_province` VALUES (662, 'LIP', 'RUS', '利佩茨克', 'Lipetsk', '');
INSERT INTO `feel_province` VALUES (663, 'RYA', 'RUS', '梁赞', 'Ryazan', '');
INSERT INTO `feel_province` VALUES (664, 'MCX', 'RUS', '马哈奇卡拉', 'Makhickara', '');
INSERT INTO `feel_province` VALUES (665, 'MAG', 'RUS', '马加丹', 'Magadan', '');
INSERT INTO `feel_province` VALUES (666, 'IN', 'RUS', '马加斯', 'Magas', '');
INSERT INTO `feel_province` VALUES (667, 'MAY', 'RUS', '迈科普', 'Maikop', '');
INSERT INTO `feel_province` VALUES (668, 'MMK', 'RUS', '摩尔曼斯克', 'Murmansk', '');
INSERT INTO `feel_province` VALUES (669, 'MOW', 'RUS', '莫斯科', 'Moscow', '');
INSERT INTO `feel_province` VALUES (670, 'NAL', 'RUS', '纳尔奇克', 'Nalchik', '');
INSERT INTO `feel_province` VALUES (671, 'NNM', 'RUS', '纳里扬马尔', 'Naryan Mar', '');
INSERT INTO `feel_province` VALUES (672, 'JSA', 'RUS', '南萨哈林斯克', 'South Sakhalinsk', '');
INSERT INTO `feel_province` VALUES (673, 'VUS', 'RUS', '诺夫哥罗德', 'Novgorod', '');
INSERT INTO `feel_province` VALUES (674, 'PAL', 'RUS', '帕拉纳', 'Parana', '');
INSERT INTO `feel_province` VALUES (675, 'PSK', 'RUS', '普斯科夫', 'Pskov', '');
INSERT INTO `feel_province` VALUES (676, 'CSY', 'RUS', '切博克萨雷', 'Cheboksary', '');
INSERT INTO `feel_province` VALUES (677, 'CKS', 'RUS', '切尔克斯克', 'Cherkeske', '');
INSERT INTO `feel_province` VALUES (678, 'TYU', 'RUS', '秋明', 'Tyumen', '');
INSERT INTO `feel_province` VALUES (679, 'SAR', 'RUS', '萨拉托夫', 'Saratov', '');
INSERT INTO `feel_province` VALUES (680, 'SKX', 'RUS', '萨兰斯克', 'Saransk', '');
INSERT INTO `feel_province` VALUES (681, 'SLY', 'RUS', '萨列哈尔德', 'Salehhard', '');
INSERT INTO `feel_province` VALUES (682, 'SAM', 'RUS', '萨马拉', 'Samara', '');
INSERT INTO `feel_province` VALUES (683, 'SCW', 'RUS', '瑟克特夫卡尔', 'Syktyvkar', '');
INSERT INTO `feel_province` VALUES (684, 'SPE', 'RUS', '圣彼得堡', 'St. Petersburg', '');
INSERT INTO `feel_province` VALUES (685, 'LNX', 'RUS', '斯摩棱斯克', 'Smolensk', '');
INSERT INTO `feel_province` VALUES (686, 'STA', 'RUS', '斯塔夫罗波尔', 'Stavropol', '');
INSERT INTO `feel_province` VALUES (687, 'TAM', 'RUS', '坦波夫', 'Tambov', '');
INSERT INTO `feel_province` VALUES (688, 'TVE', 'RUS', '特维尔', 'Tver', '');
INSERT INTO `feel_province` VALUES (689, 'TUL', 'RUS', '图拉', 'Tula', '');
INSERT INTO `feel_province` VALUES (690, 'TOM', 'RUS', '托木斯克', 'Tomsk', '');
INSERT INTO `feel_province` VALUES (691, 'VOR', 'RUS', '沃罗涅什', 'Voronezh', '');
INSERT INTO `feel_province` VALUES (692, 'VLG', 'RUS', '沃洛格达', 'Vologda', '');
INSERT INTO `feel_province` VALUES (693, 'UFA', 'RUS', '乌法', 'Ufa', '');
INSERT INTO `feel_province` VALUES (694, 'UUD', 'RUS', '乌兰乌德', 'Ulan-Ude', '');
INSERT INTO `feel_province` VALUES (695, 'ULY', 'RUS', '乌里扬诺夫斯克', 'Ulyanovsk', '');
INSERT INTO `feel_province` VALUES (696, 'UOB', 'RUS', '乌斯季奥尔登斯基', 'Usti Aldensky', '');
INSERT INTO `feel_province` VALUES (697, 'GOJ', 'RUS', '下诺夫哥罗德', 'Nizhny Novgorod', '');
INSERT INTO `feel_province` VALUES (698, 'NVS', 'RUS', '新西伯利亚', 'Novosibirsk', '');
INSERT INTO `feel_province` VALUES (699, 'JAK', 'RUS', '雅库茨克', 'Yakutsk', '');
INSERT INTO `feel_province` VALUES (700, 'JAR', 'RUS', '雅罗斯拉夫尔', 'Yaroslavl', '');
INSERT INTO `feel_province` VALUES (701, 'JEK', 'RUS', '叶卡捷林堡', 'Yekaterinburg', '');
INSERT INTO `feel_province` VALUES (702, 'IKT', 'RUS', '伊尔库茨克', 'Irkutsk', '');
INSERT INTO `feel_province` VALUES (703, 'IJK', 'RUS', '伊热夫斯克', 'Izhevsk', '');
INSERT INTO `feel_province` VALUES (704, 'IVO', 'RUS', '伊万诺沃', 'Ivanovo', '');
INSERT INTO `feel_province` VALUES (705, 'YOL', 'RUS', '约什卡尔奥拉', 'Yoshkar-Ola', '');
INSERT INTO `feel_province` VALUES (706, 'A', 'ECU', '阿苏艾', 'Azuai', '');
INSERT INTO `feel_province` VALUES (707, 'O', 'ECU', '埃尔奥罗', 'El Oro', '');
INSERT INTO `feel_province` VALUES (708, 'E', 'ECU', '埃斯梅拉尔达斯', 'Esmeraldas', '');
INSERT INTO `feel_province` VALUES (709, 'B', 'ECU', '玻利瓦尔', 'Bolivar', '');
INSERT INTO `feel_province` VALUES (710, 'G', 'ECU', '瓜亚斯', 'Guayas', '');
INSERT INTO `feel_province` VALUES (711, 'W', 'ECU', '加拉帕戈斯', 'Galapagos', '');
INSERT INTO `feel_province` VALUES (712, 'C', 'ECU', '卡尔奇', 'Calci', '');
INSERT INTO `feel_province` VALUES (713, 'F', 'ECU', '卡尼亚尔', 'Cañar', '');
INSERT INTO `feel_province` VALUES (714, 'X', 'ECU', '科托帕希', 'Cotopahi', '');
INSERT INTO `feel_province` VALUES (715, 'L', 'ECU', '洛哈', 'Loja', '');
INSERT INTO `feel_province` VALUES (716, 'R', 'ECU', '洛斯里奥斯', 'Los Rios', '');
INSERT INTO `feel_province` VALUES (717, 'M', 'ECU', '马纳比', 'Manabi', '');
INSERT INTO `feel_province` VALUES (718, 'S', 'ECU', '莫罗纳－圣地亚哥', 'Morona-San Diego', '');
INSERT INTO `feel_province` VALUES (719, 'D', 'ECU', '纳波，奥雷利亚纳', 'Napo, Orellana', '');
INSERT INTO `feel_province` VALUES (720, 'Y', 'ECU', '帕斯塔萨', 'Pastaza', '');
INSERT INTO `feel_province` VALUES (721, 'P', 'ECU', '皮钦查', 'Pichincha', '');
INSERT INTO `feel_province` VALUES (722, 'H', 'ECU', '钦博拉索', 'Chimborazo', '');
INSERT INTO `feel_province` VALUES (723, 'Z', 'ECU', '萨莫拉－钦奇佩', 'Zamora-chinchpe', '');
INSERT INTO `feel_province` VALUES (724, 'U', 'ECU', '苏昆毕奥斯', 'Su Kunbes', '');
INSERT INTO `feel_province` VALUES (725, 'T', 'ECU', '通古拉瓦', 'Tungurava', '');
INSERT INTO `feel_province` VALUES (726, 'I', 'ECU', '因巴布拉', 'Inbabra', '');
INSERT INTO `feel_province` VALUES (727, 'KE', 'ERI', '安塞巴', 'Anseba', '');
INSERT INTO `feel_province` VALUES (728, 'SK', 'ERI', '北红海', 'Northern Red Sea', '');
INSERT INTO `feel_province` VALUES (729, 'BR', 'ERI', '加什·巴尔卡', 'Gash Barka', '');
INSERT INTO `feel_province` VALUES (730, 'DE', 'ERI', '南部', 'Southern', '');
INSERT INTO `feel_province` VALUES (731, 'DK', 'ERI', '南红海', 'South Red Sea', '');
INSERT INTO `feel_province` VALUES (732, 'MA', 'ERI', '中部', 'Central', '');
INSERT INTO `feel_province` VALUES (733, 'ARL', 'FRA', '阿尔勒', 'Arles', '');
INSERT INTO `feel_province` VALUES (734, 'AJA', 'FRA', '阿雅克修', 'Ajaccio', '');
INSERT INTO `feel_province` VALUES (735, 'QXB', 'FRA', '艾克斯', 'Aix', '');
INSERT INTO `feel_province` VALUES (736, 'ORR', 'FRA', '奥尔良', 'Orleans', '');
INSERT INTO `feel_province` VALUES (737, 'PAR', 'FRA', '巴黎', 'Paris', '');
INSERT INTO `feel_province` VALUES (738, 'BSN', 'FRA', '贝桑松', 'Besancon', '');
INSERT INTO `feel_province` VALUES (739, 'DIJ', 'FRA', '第戎', 'Dijon', '');
INSERT INTO `feel_province` VALUES (740, 'FRJ', 'FRA', '弗雷瑞斯', 'Frejus', '');
INSERT INTO `feel_province` VALUES (741, 'CFR', 'FRA', '卡昂', 'Caen', '');
INSERT INTO `feel_province` VALUES (742, 'RNS', 'FRA', '雷恩', 'Rennes', '');
INSERT INTO `feel_province` VALUES (743, 'LIO', 'FRA', '里昂', 'Lyon', '');
INSERT INTO `feel_province` VALUES (744, 'LLE', 'FRA', '里尔', 'Lille', '');
INSERT INTO `feel_province` VALUES (745, 'LIG', 'FRA', '利摩日', 'Limoges', '');
INSERT INTO `feel_province` VALUES (746, 'URO', 'FRA', '鲁昂', 'Rouen', '');
INSERT INTO `feel_province` VALUES (747, 'MRS', 'FRA', '马赛', 'Marseille', '');
INSERT INTO `feel_province` VALUES (748, 'MZM', 'FRA', '梅斯', 'Metz', '');
INSERT INTO `feel_province` VALUES (749, 'MPL', 'FRA', '蒙彼利埃', 'Montpellier', '');
INSERT INTO `feel_province` VALUES (750, 'NTE', 'FRA', '南特', 'Nantes', '');
INSERT INTO `feel_province` VALUES (751, 'NCE', 'FRA', '尼斯', 'Nice', '');
INSERT INTO `feel_province` VALUES (752, 'CSM', 'FRA', '沙隆', 'Sharon', '');
INSERT INTO `feel_province` VALUES (753, 'TLS', 'FRA', '图卢兹', 'Toulouse', '');
INSERT INTO `feel_province` VALUES (754, 'VAA', 'FRA', '瓦朗斯', 'Valence', '');
INSERT INTO `feel_province` VALUES (755, 'AMI', 'FRA', '亚眠', 'Amiens', '');
INSERT INTO `feel_province` VALUES (756, 'DOR', 'PHL', '达沃', 'Davao', '');
INSERT INTO `feel_province` VALUES (757, 'CAO', 'PHL', '卡卢坎', 'Kalukan', '');
INSERT INTO `feel_province` VALUES (758, 'MNL', 'PHL', '马尼拉', 'Manila', '');
INSERT INTO `feel_province` VALUES (759, 'CEB', 'PHL', '宿务', 'Cebu', '');
INSERT INTO `feel_province` VALUES (760, 'ESP', 'FIN', '埃斯波', 'Espoo', '');
INSERT INTO `feel_province` VALUES (761, 'OLU', 'FIN', '奥卢', 'Oulu', '');
INSERT INTO `feel_province` VALUES (762, 'POR', 'FIN', '波里', 'Pori', '');
INSERT INTO `feel_province` VALUES (763, 'PRV', 'FIN', '博尔沃', 'Bolwo', '');
INSERT INTO `feel_province` VALUES (764, 'HMY', 'FIN', '海门林纳', 'Haimenlinna', '');
INSERT INTO `feel_province` VALUES (765, 'HEL', 'FIN', '赫尔辛基', 'Helsinki', '');
INSERT INTO `feel_province` VALUES (766, 'KAJ', 'FIN', '卡亚尼', 'Kayani', '');
INSERT INTO `feel_province` VALUES (767, 'KOK', 'FIN', '科科拉', 'Kokkola', '');
INSERT INTO `feel_province` VALUES (768, 'KTK', 'FIN', '科特卡', 'Kotka', '');
INSERT INTO `feel_province` VALUES (769, 'KUO', 'FIN', '库奥皮奥', 'Kuopio', '');
INSERT INTO `feel_province` VALUES (770, 'LHI', 'FIN', '拉赫蒂', 'Lahti', '');
INSERT INTO `feel_province` VALUES (771, 'LPP', 'FIN', '拉彭兰塔', 'Lappeenranta', '');
INSERT INTO `feel_province` VALUES (772, 'RVN', 'FIN', '罗瓦涅米', 'Rovaniemi', '');
INSERT INTO `feel_province` VALUES (773, 'MHQ', 'FIN', '玛丽港', 'Mariehamn', '');
INSERT INTO `feel_province` VALUES (774, 'MIK', 'FIN', '米凯利', 'Mikkeli', '');
INSERT INTO `feel_province` VALUES (775, 'TMP', 'FIN', '坦佩雷', 'Tampere', '');
INSERT INTO `feel_province` VALUES (776, 'TKU', 'FIN', '图尔库', 'Turku', '');
INSERT INTO `feel_province` VALUES (777, 'VAA', 'FIN', '瓦萨', 'Vaasa', '');
INSERT INTO `feel_province` VALUES (778, 'VAT', 'FIN', '万塔', 'Vanta', '');
INSERT INTO `feel_province` VALUES (779, 'JOE', 'FIN', '约恩苏', 'Joensu', '');
INSERT INTO `feel_province` VALUES (780, 'PA', 'CPV', '保尔', 'Paul', '');
INSERT INTO `feel_province` VALUES (781, 'PN', 'CPV', '波多诺伏', 'Portonovo', '');
INSERT INTO `feel_province` VALUES (782, 'BV', 'CPV', '博阿维斯塔岛', 'Boa Vista Island', '');
INSERT INTO `feel_province` VALUES (783, 'BR', 'CPV', '布拉瓦岛', 'Brava', '');
INSERT INTO `feel_province` VALUES (784, 'RG', 'CPV', '大里贝拉', 'Ribeira', '');
INSERT INTO `feel_province` VALUES (785, 'FO', 'CPV', '福古岛', 'Fugu Island', '');
INSERT INTO `feel_province` VALUES (786, 'MA', 'CPV', '马尤岛', 'Mayo Island', '');
INSERT INTO `feel_province` VALUES (787, 'MO', 'CPV', '莫斯特罗', 'Mostero', '');
INSERT INTO `feel_province` VALUES (788, 'PR', 'CPV', '普拉亚', 'Praia', '');
INSERT INTO `feel_province` VALUES (789, 'SL', 'CPV', '萨尔岛', 'Sal Island', '');
INSERT INTO `feel_province` VALUES (790, 'SA', 'CPV', '圣安唐岛', 'St. Antoll', '');
INSERT INTO `feel_province` VALUES (791, 'IA', 'CPV', '圣地亚哥岛', 'Santiago Island', '');
INSERT INTO `feel_province` VALUES (792, 'SD', 'CPV', '圣多明戈', 'Santo Domingo', '');
INSERT INTO `feel_province` VALUES (793, 'SF', 'CPV', '圣菲利普', 'Saint philip', '');
INSERT INTO `feel_province` VALUES (794, 'CA', 'CPV', '圣卡塔琳娜', 'Santa Catarina', '');
INSERT INTO `feel_province` VALUES (795, 'CR', 'CPV', '圣克鲁斯', 'Santa cruz', '');
INSERT INTO `feel_province` VALUES (796, 'SM', 'CPV', '圣米戈尔', 'San Miguel', '');
INSERT INTO `feel_province` VALUES (797, 'SN', 'CPV', '圣尼古拉岛', 'Saint Nicholas', '');
INSERT INTO `feel_province` VALUES (798, 'SV', 'CPV', '圣维森特岛', 'San Vicente', '');
INSERT INTO `feel_province` VALUES (799, 'TA', 'CPV', '塔拉法尔', 'Tarrafal', '');
INSERT INTO `feel_province` VALUES (800, 'ARA', 'COL', '阿劳卡', 'Arauca', '');
INSERT INTO `feel_province` VALUES (801, 'ANT', 'COL', '安提奥基亚', 'Antioquia', '');
INSERT INTO `feel_province` VALUES (802, 'NDS', 'COL', '北桑坦德', 'North Santander', '');
INSERT INTO `feel_province` VALUES (803, 'BDC', 'COL', '波哥大首都区', 'Bogota Capital Region', '');
INSERT INTO `feel_province` VALUES (804, 'BOL', 'COL', '博利瓦尔', 'Bolivar', '');
INSERT INTO `feel_province` VALUES (805, 'BOY', 'COL', '博亚卡', 'Boyaca', '');
INSERT INTO `feel_province` VALUES (806, 'ATL', 'COL', '大西洋', 'Atlantic', '');
INSERT INTO `feel_province` VALUES (807, 'GVR', 'COL', '瓜维亚雷', 'Guaviare', '');
INSERT INTO `feel_province` VALUES (808, 'GJR', 'COL', '瓜希拉', 'Guajira', '');
INSERT INTO `feel_province` VALUES (809, 'GNA', 'COL', '瓜伊尼亚', 'Guainha', '');
INSERT INTO `feel_province` VALUES (810, 'QUI', 'COL', '金迪奥', 'Jin Dio', '');
INSERT INTO `feel_province` VALUES (811, 'CAL', 'COL', '卡尔达斯', 'Caldas', '');
INSERT INTO `feel_province` VALUES (812, 'CAQ', 'COL', '卡克塔', 'Kakta', '');
INSERT INTO `feel_province` VALUES (813, 'CAS', 'COL', '卡萨纳雷', 'Casanare', '');
INSERT INTO `feel_province` VALUES (814, 'CAU', 'COL', '考卡', 'Cauca', '');
INSERT INTO `feel_province` VALUES (815, 'VDC', 'COL', '考卡山谷', 'Cauca Valley', '');
INSERT INTO `feel_province` VALUES (816, 'COR', 'COL', '科尔多巴', 'Cordoba', '');
INSERT INTO `feel_province` VALUES (817, 'CAM', 'COL', '昆迪纳马卡', 'Cundinamarca', '');
INSERT INTO `feel_province` VALUES (818, 'RIS', 'COL', '利萨拉尔达', 'Lisalalda', '');
INSERT INTO `feel_province` VALUES (819, 'MAG', 'COL', '马格达雷那', 'Magdalena', '');
INSERT INTO `feel_province` VALUES (820, 'MET', 'COL', '梅塔', 'Meta', '');
INSERT INTO `feel_province` VALUES (821, 'NAR', 'COL', '纳里尼奥', 'Nariño', '');
INSERT INTO `feel_province` VALUES (822, 'PUT', 'COL', '普图马约', 'Putumayo', '');
INSERT INTO `feel_province` VALUES (823, 'CHO', 'COL', '乔科', 'Choco', '');
INSERT INTO `feel_province` VALUES (824, 'CES', 'COL', '塞萨尔', 'Cesar', '');
INSERT INTO `feel_province` VALUES (825, 'SAN', 'COL', '桑坦德', 'Santander', '');
INSERT INTO `feel_province` VALUES (826, 'SAP', 'COL', '圣安德烈斯普罗维登西亚', 'San Andres Providencia', '');
INSERT INTO `feel_province` VALUES (827, 'SUC', 'COL', '苏克雷', 'Sucre', '');
INSERT INTO `feel_province` VALUES (828, 'TOL', 'COL', '托利马', 'Tolima', '');
INSERT INTO `feel_province` VALUES (829, 'VIC', 'COL', '维查达', 'Vichadar', '');
INSERT INTO `feel_province` VALUES (830, 'VAU', 'COL', '沃佩斯', 'Vopes', '');
INSERT INTO `feel_province` VALUES (831, 'HUI', 'COL', '乌伊拉', 'Uila', '');
INSERT INTO `feel_province` VALUES (832, 'AMZ', 'COL', '亚马孙', 'Amazon', '');
INSERT INTO `feel_province` VALUES (833, 'A', 'CRI', '阿拉胡埃拉', 'Alajuela', '');
INSERT INTO `feel_province` VALUES (834, 'H', 'CRI', '埃雷迪亚', 'Heredia', '');
INSERT INTO `feel_province` VALUES (835, 'G', 'CRI', '瓜纳卡斯特', 'Guanacaste', '');
INSERT INTO `feel_province` VALUES (836, 'C', 'CRI', '卡塔戈', 'Cartago', '');
INSERT INTO `feel_province` VALUES (837, 'L', 'CRI', '利蒙', 'Limon', '');
INSERT INTO `feel_province` VALUES (838, 'P', 'CRI', '蓬塔雷纳斯', 'Puntarenas', '');
INSERT INTO `feel_province` VALUES (839, 'SJ', 'CRI', '圣何塞', 'San Jose', '');
INSERT INTO `feel_province` VALUES (840, '11', 'CUB', '奥尔金', 'Holkin', '');
INSERT INTO `feel_province` VALUES (841, '1', 'CUB', '比那尔德里奥', 'Pinar del Rio', '');
INSERT INTO `feel_province` VALUES (842, '5', 'CUB', '比亚克拉拉', 'Biklala', '');
INSERT INTO `feel_province` VALUES (843, '12', 'CUB', '格拉玛', 'Grama', '');
INSERT INTO `feel_province` VALUES (844, '14', 'CUB', '关塔那摩', 'Guantanamo', '');
INSERT INTO `feel_province` VALUES (845, '2', 'CUB', '哈瓦那', 'Havana', '');
INSERT INTO `feel_province` VALUES (846, '3', 'CUB', '哈瓦那城', 'Havana City', '');
INSERT INTO `feel_province` VALUES (847, '9', 'CUB', '卡马圭', 'Camaguey', '');
INSERT INTO `feel_province` VALUES (848, '10', 'CUB', '拉斯图纳斯', 'Las Tunas', '');
INSERT INTO `feel_province` VALUES (849, '4', 'CUB', '马坦萨斯', 'Matanzas', '');
INSERT INTO `feel_province` VALUES (850, 'MAY', 'CUB', '马亚里', 'Maari', '');
INSERT INTO `feel_province` VALUES (851, 'MZO', 'CUB', '曼萨尼罗', 'Manzanillo', '');
INSERT INTO `feel_province` VALUES (852, '99', 'CUB', '青年岛特区', 'Youth Island Special Zone', '');
INSERT INTO `feel_province` VALUES (853, '13', 'CUB', '圣地亚哥', 'San Diego', '');
INSERT INTO `feel_province` VALUES (854, '7', 'CUB', '圣斯皮里图斯', 'Saint spiritus', '');
INSERT INTO `feel_province` VALUES (855, '6', 'CUB', '西恩富戈斯', 'Cienfuegos', '');
INSERT INTO `feel_province` VALUES (856, '8', 'CUB', '谢戈德阿维拉', 'Shegod Avila', '');
INSERT INTO `feel_province` VALUES (857, 'EW', 'GUY', '埃塞奎博群岛西德梅拉拉', 'Essequibo Islands West Demerara', '');
INSERT INTO `feel_province` VALUES (858, 'BW', 'GUY', '巴里马瓦伊尼', 'Bari Mavaini', '');
INSERT INTO `feel_province` VALUES (859, 'PM', 'GUY', '波默伦苏佩纳姆', 'Pomeron Supenam', '');
INSERT INTO `feel_province` VALUES (860, 'PI', 'GUY', '波塔罗锡帕鲁尼', 'Portaro Siparoni', '');
INSERT INTO `feel_province` VALUES (861, 'DM', 'GUY', '德梅拉拉马海卡', 'Demerara Mahaica', '');
INSERT INTO `feel_province` VALUES (862, 'EC', 'GUY', '东伯比斯科兰太因', 'East Berbisco', '');
INSERT INTO `feel_province` VALUES (863, 'CM', 'GUY', '库尤尼马扎鲁尼', 'Kuyuni Mazzaroni', '');
INSERT INTO `feel_province` VALUES (864, 'MB', 'GUY', '马海卡伯比斯', 'Mahaikaberbis', '');
INSERT INTO `feel_province` VALUES (865, 'UD', 'GUY', '上德梅拉拉伯比斯', 'Upper Demera Berbes', '');
INSERT INTO `feel_province` VALUES (866, 'UT', 'GUY', '上塔库图上埃塞奎博', 'Upper Takutu on Essequibo', '');
INSERT INTO `feel_province` VALUES (867, 'AYK', 'KAZ', '阿尔卡累克', 'Alcalek', '');
INSERT INTO `feel_province` VALUES (868, 'AKM', 'KAZ', '阿克莫拉', 'Akrama', '');
INSERT INTO `feel_province` VALUES (869, 'AKS', 'KAZ', '阿克苏', 'Aksu', '');
INSERT INTO `feel_province` VALUES (870, 'AKT', 'KAZ', '阿克托别', 'Aktobe', '');
INSERT INTO `feel_province` VALUES (871, 'ALA', 'KAZ', '阿拉木图', 'Almaty', '');
INSERT INTO `feel_province` VALUES (872, 'ARY', 'KAZ', '阿雷斯', 'Ales', '');
INSERT INTO `feel_province` VALUES (873, 'AST', 'KAZ', '阿斯塔纳市', 'Astana', '');
INSERT INTO `feel_province` VALUES (874, 'ATY', 'KAZ', '阿特劳', 'Atyrau', '');
INSERT INTO `feel_province` VALUES (875, 'EKB', 'KAZ', '埃基巴斯图兹', 'Ekibastus', '');
INSERT INTO `feel_province` VALUES (876, 'BXH', 'KAZ', '巴尔喀什', 'Balkhash', '');
INSERT INTO `feel_province` VALUES (877, 'PAV', 'KAZ', '巴甫洛达尔', 'Pavlodar', '');
INSERT INTO `feel_province` VALUES (878, 'SEV', 'KAZ', '北哈萨克斯坦', 'Northern Kazakhstan', '');
INSERT INTO `feel_province` VALUES (879, 'VOS', 'KAZ', '东哈萨克斯坦', 'East Kazakhstan', '');
INSERT INTO `feel_province` VALUES (880, 'ZYR', 'KAZ', '济良诺夫斯克', 'Zylanovsk', '');
INSERT INTO `feel_province` VALUES (881, 'DMB', 'KAZ', '江布尔', 'Jiangbul', '');
INSERT INTO `feel_province` VALUES (882, 'DZH', 'KAZ', '杰兹卡兹甘', 'Jez Kazgan', '');
INSERT INTO `feel_province` VALUES (883, 'KAR', 'KAZ', '卡拉干达', 'Karaganda', '');
INSERT INTO `feel_province` VALUES (884, 'KZO', 'KAZ', '卡拉扎尔', 'Karazhar', '');
INSERT INTO `feel_province` VALUES (885, 'KAP', 'KAZ', '卡普恰盖', 'Capucha', '');
INSERT INTO `feel_province` VALUES (886, 'KST', 'KAZ', '科斯塔奈', 'Costanay', '');
INSERT INTO `feel_province` VALUES (887, 'KZY', 'KAZ', '克孜勒奥尔达', 'Kyzyl Orda', '');
INSERT INTO `feel_province` VALUES (888, 'KEN', 'KAZ', '肯套', 'Ken set', '');
INSERT INTO `feel_province` VALUES (889, 'KUR', 'KAZ', '库尔恰托夫', 'Kurchatov', '');
INSERT INTO `feel_province` VALUES (890, 'LKK', 'KAZ', '利萨科夫斯克', 'Lisakovskaya', '');
INSERT INTO `feel_province` VALUES (891, 'LEN', 'KAZ', '列宁诺戈尔斯克', 'Leninogorsk', '');
INSERT INTO `feel_province` VALUES (892, 'RUD', 'KAZ', '鲁德内', 'Rudne', '');
INSERT INTO `feel_province` VALUES (893, 'MAN', 'KAZ', '曼格斯套', 'Manggs set', '');
INSERT INTO `feel_province` VALUES (894, 'KGT', 'KAZ', '南哈萨克斯坦', 'South Kazakhstan', '');
INSERT INTO `feel_province` VALUES (895, 'SAR', 'KAZ', '萨兰', 'Saran', '');
INSERT INTO `feel_province` VALUES (896, 'SEM', 'KAZ', '塞梅伊', 'Semei', '');
INSERT INTO `feel_province` VALUES (897, 'SAK', 'KAZ', '沙赫京斯克', 'Shakhtinsk', '');
INSERT INTO `feel_province` VALUES (898, 'STE', 'KAZ', '斯捷普诺戈尔斯克', 'Stepnogorsk', '');
INSERT INTO `feel_province` VALUES (899, 'TEK', 'KAZ', '铁克利', 'Tekley', '');
INSERT INTO `feel_province` VALUES (900, 'TEM', 'KAZ', '铁米尔套', 'Iron mill set', '');
INSERT INTO `feel_province` VALUES (901, 'TUR', 'KAZ', '突厥斯坦', 'Turkistan', '');
INSERT INTO `feel_province` VALUES (902, 'ZAP', 'KAZ', '西哈萨克斯坦', 'West Kazakhstan', '');
INSERT INTO `feel_province` VALUES (903, 'ZHA', 'KAZ', '扎纳奥津', 'Zana Ozin', '');
INSERT INTO `feel_province` VALUES (904, '27', 'KOR', '大邱', 'Daegu', '');
INSERT INTO `feel_province` VALUES (905, '30', 'KOR', '大田', 'Daejeon', '');
INSERT INTO `feel_province` VALUES (906, '26', 'KOR', '釜山', 'Busan', '');
INSERT INTO `feel_province` VALUES (907, '29', 'KOR', '光州', 'Gwangju', '');
INSERT INTO `feel_province` VALUES (908, '41', 'KOR', '济州特别自治道', 'Jeju Special Self-Governing Province', '');
INSERT INTO `feel_province` VALUES (909, '42', 'KOR', '江原道', 'Gangwon-do', '');
INSERT INTO `feel_province` VALUES (910, '49', 'KOR', '京畿道', 'Gyeonggi Province', '');
INSERT INTO `feel_province` VALUES (911, '43', 'KOR', '庆尚北道', 'North Road', '');
INSERT INTO `feel_province` VALUES (912, '44', 'KOR', '庆尚南道', 'South Road', '');
INSERT INTO `feel_province` VALUES (913, '47', 'KOR', '全罗北道', 'Jeonbuk North Road', '');
INSERT INTO `feel_province` VALUES (914, '48', 'KOR', '全罗南道', 'Jeollanam-do', '');
INSERT INTO `feel_province` VALUES (915, '28', 'KOR', '仁川', 'Incheon', '');
INSERT INTO `feel_province` VALUES (916, '11', 'KOR', '首尔', 'Seoul', '');
INSERT INTO `feel_province` VALUES (917, '31', 'KOR', '蔚山', 'Ulsan', '');
INSERT INTO `feel_province` VALUES (918, '45', 'KOR', '忠清北道', 'Chungqing North Road', '');
INSERT INTO `feel_province` VALUES (919, '46', 'KOR', '忠清南道', 'Chungcheongnam-do', '');
INSERT INTO `feel_province` VALUES (920, 'AER', 'NLD', '阿尔梅勒', 'Almere', '');
INSERT INTO `feel_province` VALUES (921, 'AME', 'NLD', '阿默斯福特', 'Amersfoort', '');
INSERT INTO `feel_province` VALUES (922, 'AMS', 'NLD', '阿姆斯特丹', 'Amsterdam', '');
INSERT INTO `feel_province` VALUES (923, 'ARN', 'NLD', '阿纳姆', 'Arnhem', '');
INSERT INTO `feel_province` VALUES (924, 'APE', 'NLD', '阿珀尔多伦', 'Apeldoorn', '');
INSERT INTO `feel_province` VALUES (925, 'ASS', 'NLD', '阿森', 'Assen', '');
INSERT INTO `feel_province` VALUES (926, 'EDE', 'NLD', '埃德', 'Ed', '');
INSERT INTO `feel_province` VALUES (927, 'EMM', 'NLD', '埃门', 'Emmen', '');
INSERT INTO `feel_province` VALUES (928, 'EIN', 'NLD', '埃因霍芬', 'Eindhoven', '');
INSERT INTO `feel_province` VALUES (929, 'BRD', 'NLD', '布雷达', 'Breda', '');
INSERT INTO `feel_province` VALUES (930, 'TLB', 'NLD', '蒂尔堡', 'Tilburg', '');
INSERT INTO `feel_province` VALUES (931, 'DOR', 'NLD', '多德雷赫特', 'Dordrecht', '');
INSERT INTO `feel_province` VALUES (932, 'ENS', 'NLD', '恩斯赫德', 'Enschede', '');
INSERT INTO `feel_province` VALUES (933, 'GRQ', 'NLD', '格罗宁根', 'Groningen', '');
INSERT INTO `feel_province` VALUES (934, 'HRA', 'NLD', '哈勒姆', 'Haarlem', '');
INSERT INTO `feel_province` VALUES (935, 'HAG', 'NLD', '海牙', 'The Hague', '');
INSERT INTO `feel_province` VALUES (936, 'HFD', 'NLD', '霍夫多尔普', 'Hofdolp', '');
INSERT INTO `feel_province` VALUES (937, 'LID', 'NLD', '莱顿', 'Leiden', '');
INSERT INTO `feel_province` VALUES (938, 'LEY', 'NLD', '莱利斯塔德', 'Lelystad', '');
INSERT INTO `feel_province` VALUES (939, 'RTM', 'NLD', '鹿特丹', 'Rotterdam', '');
INSERT INTO `feel_province` VALUES (940, 'LWR', 'NLD', '吕伐登', 'Leeuwarden', '');
INSERT INTO `feel_province` VALUES (941, 'MST', 'NLD', '马斯特里赫特', 'Maastricht', '');
INSERT INTO `feel_province` VALUES (942, 'MDL', 'NLD', '米德尔堡', 'Middelburg', '');
INSERT INTO `feel_province` VALUES (943, 'NIJ', 'NLD', '奈梅亨', 'Nijmegen', '');
INSERT INTO `feel_province` VALUES (944, 'HTB', 'NLD', '斯海尔托亨博思', 'Scherto Hengbos', '');
INSERT INTO `feel_province` VALUES (945, 'UTC', 'NLD', '乌得勒支', 'Utrecht', '');
INSERT INTO `feel_province` VALUES (946, 'ZWO', 'NLD', '兹沃勒', 'Zwolle', '');
INSERT INTO `feel_province` VALUES (947, 'ZTM', 'NLD', '佐特尔梅', 'Zotelme', '');
INSERT INTO `feel_province` VALUES (948, 'AT', 'HND', '阿特兰蒂达', 'Atlantida', '');
INSERT INTO `feel_province` VALUES (949, 'PA', 'HND', '埃尔帕拉伊索', 'El paraiso', '');
INSERT INTO `feel_province` VALUES (950, 'OC', 'HND', '奥科特佩克', 'Ocotpec', '');
INSERT INTO `feel_province` VALUES (951, 'OL', 'HND', '奥兰乔', 'Olancho', '');
INSERT INTO `feel_province` VALUES (952, 'FM', 'HND', '弗朗西斯科莫拉桑', 'Francisco Morazan', '');
INSERT INTO `feel_province` VALUES (953, 'GD', 'HND', '格拉西亚斯阿迪奥斯', 'Gracias Adios', '');
INSERT INTO `feel_province` VALUES (954, 'IB', 'HND', '海湾群岛', 'Gulf Islands', '');
INSERT INTO `feel_province` VALUES (955, 'CR', 'HND', '科尔特斯', 'Cortes', '');
INSERT INTO `feel_province` VALUES (956, 'CL', 'HND', '科隆', 'Cologne', '');
INSERT INTO `feel_province` VALUES (957, 'CM', 'HND', '科马亚瓜', 'Comayagua', '');
INSERT INTO `feel_province` VALUES (958, 'CP', 'HND', '科潘', 'Copan', '');
INSERT INTO `feel_province` VALUES (959, 'PZ', 'HND', '拉巴斯', 'La Paz', '');
INSERT INTO `feel_province` VALUES (960, 'LE', 'HND', '伦皮拉', 'Lempira', '');
INSERT INTO `feel_province` VALUES (961, 'CH', 'HND', '乔卢特卡', 'Cholutka', '');
INSERT INTO `feel_province` VALUES (962, 'CHO', 'HND', '乔罗马', 'Joe Rome', '');
INSERT INTO `feel_province` VALUES (963, 'VA', 'HND', '山谷', 'valley', '');
INSERT INTO `feel_province` VALUES (964, 'SB', 'HND', '圣巴巴拉', 'Santa Barbara', '');
INSERT INTO `feel_province` VALUES (965, 'IN', 'HND', '因蒂布卡', 'Intibuca', '');
INSERT INTO `feel_province` VALUES (966, 'YO', 'HND', '约罗', 'Yoro', '');
INSERT INTO `feel_province` VALUES (967, 'PHO', 'KIR', '菲尼克斯群岛', 'Phoenix Islands', '');
INSERT INTO `feel_province` VALUES (968, 'GIL', 'KIR', '吉尔伯特群岛', 'Gilbert Islands', '');
INSERT INTO `feel_province` VALUES (969, 'LIN', 'KIR', '莱恩群岛', 'Lane Islands', '');
INSERT INTO `feel_province` VALUES (970, 'S', 'DJI', '阿里萨比赫区', 'Ali Sabih District', '');
INSERT INTO `feel_province` VALUES (971, 'O', 'DJI', '奥博克区', 'Obock District', '');
INSERT INTO `feel_province` VALUES (972, 'K', 'DJI', '迪基勒区', 'Dikile District', '');
INSERT INTO `feel_province` VALUES (973, 'T', 'DJI', '塔朱拉区', 'Tajura District', '');
INSERT INTO `feel_province` VALUES (974, 'O', 'KGZ', '奥什', 'Osh', '');
INSERT INTO `feel_province` VALUES (975, 'B', 'KGZ', '巴特肯', 'Batken', '');
INSERT INTO `feel_province` VALUES (976, 'GB', 'KGZ', '比什凯克市', 'Bishkek city', '');
INSERT INTO `feel_province` VALUES (977, 'C', 'KGZ', '楚河', 'Chuhe', '');
INSERT INTO `feel_province` VALUES (978, 'J', 'KGZ', '贾拉拉巴德', 'Jalalabad', '');
INSERT INTO `feel_province` VALUES (979, 'KBA', 'KGZ', '卡拉巴尔塔', 'Calabarta', '');
INSERT INTO `feel_province` VALUES (980, 'KKO', 'KGZ', '卡拉库尔', 'Karakul', '');
INSERT INTO `feel_province` VALUES (981, 'KAN', 'KGZ', '坎特', 'Kanter', '');
INSERT INTO `feel_province` VALUES (982, 'KJ', 'KGZ', '科克扬加克', 'Kokyangark', '');
INSERT INTO `feel_province` VALUES (983, 'MS', 'KGZ', '迈利赛', 'Meilis', '');
INSERT INTO `feel_province` VALUES (984, 'N', 'KGZ', '纳伦', 'Naren', '');
INSERT INTO `feel_province` VALUES (985, 'SU', 'KGZ', '苏卢克图', 'Suluktu', '');
INSERT INTO `feel_province` VALUES (986, 'T', 'KGZ', '塔拉斯', 'Taras', '');
INSERT INTO `feel_province` VALUES (987, 'TK', 'KGZ', '塔什库梅尔', 'Tashkumel', '');
INSERT INTO `feel_province` VALUES (988, 'UG', 'KGZ', '乌兹根', 'Uzgen', '');
INSERT INTO `feel_province` VALUES (989, 'Y', 'KGZ', '伊塞克湖', 'Lake Issyk', '');
INSERT INTO `feel_province` VALUES (990, 'BOK', 'GIN', '博凯', 'Bokai', '');
INSERT INTO `feel_province` VALUES (991, 'NZR', 'GIN', '恩泽雷科雷', 'Enzerecore', '');
INSERT INTO `feel_province` VALUES (992, 'FRN', 'GIN', '法拉纳', 'Farana', '');
INSERT INTO `feel_province` VALUES (993, 'KND', 'GIN', '金迪亚', 'Jindia', '');
INSERT INTO `feel_province` VALUES (994, 'KNK', 'GIN', '康康', 'Kang Kang', '');
INSERT INTO `feel_province` VALUES (995, 'CNK', 'GIN', '科纳克里', 'Conakry', '');
INSERT INTO `feel_province` VALUES (996, 'LAB', 'GIN', '拉贝', 'Rabe', '');
INSERT INTO `feel_province` VALUES (997, 'MAM', 'GIN', '玛木', 'Mamu', '');
INSERT INTO `feel_province` VALUES (998, 'ABB', 'CAN', '阿伯茨福', 'Abbotsford', '');
INSERT INTO `feel_province` VALUES (999, 'EDM', 'CAN', '埃德蒙顿', 'Edmonton', '');
INSERT INTO `feel_province` VALUES (1000, 'OSH', 'CAN', '奥沙瓦', 'Oshawa', '');
INSERT INTO `feel_province` VALUES (1001, 'BAR', 'CAN', '巴里', 'Barry', '');
INSERT INTO `feel_province` VALUES (1002, 'CBR', 'CAN', '布列塔尼角', 'Brittany', '');
INSERT INTO `feel_province` VALUES (1003, 'TOR', 'CAN', '多伦多', 'Toronto', '');
INSERT INTO `feel_province` VALUES (1004, 'FRE', 'CAN', '弗雷德里顿', 'Fredericton', '');
INSERT INTO `feel_province` VALUES (1005, 'GLP', 'CAN', '圭尔夫', 'Guelph', '');
INSERT INTO `feel_province` VALUES (1006, 'HAL', 'CAN', '哈利法克斯', 'Halifax', '');
INSERT INTO `feel_province` VALUES (1007, 'HAM', 'CAN', '哈密尔顿', 'Hamilton', '');
INSERT INTO `feel_province` VALUES (1008, 'YXY', 'CAN', '怀特霍斯', 'Whitehorse', '');
INSERT INTO `feel_province` VALUES (1009, 'KWL', 'CAN', '基劳纳', 'Kiruna', '');
INSERT INTO `feel_province` VALUES (1010, 'BRP', 'CAN', '基奇纳', 'Kitchener', '');
INSERT INTO `feel_province` VALUES (1011, 'KGN', 'CAN', '金斯敦', 'Kingston', '');
INSERT INTO `feel_province` VALUES (1012, 'CAL', 'CAN', '卡里加里', 'Caligari', '');
INSERT INTO `feel_province` VALUES (1013, 'QUE', 'CAN', '魁北克', 'Quebec', '');
INSERT INTO `feel_province` VALUES (1014, 'REG', 'CAN', '里贾纳', 'Regina', '');
INSERT INTO `feel_province` VALUES (1015, 'LOD', 'CAN', '伦敦', 'London', '');
INSERT INTO `feel_province` VALUES (1016, 'MTR', 'CAN', '蒙特利尔', 'Montreal', '');
INSERT INTO `feel_province` VALUES (1017, 'SUD', 'CAN', '萨德伯里', 'Sudbury', '');
INSERT INTO `feel_province` VALUES (1018, 'SAK', 'CAN', '萨斯卡通', 'Saskatoon', '');
INSERT INTO `feel_province` VALUES (1019, 'TRR', 'CAN', '三河城', 'Mikawa Castle', '');
INSERT INTO `feel_province` VALUES (1020, 'THU', 'CAN', '桑德贝', 'Thunder Bay', '');
INSERT INTO `feel_province` VALUES (1021, 'SBE', 'CAN', '舍布鲁克', 'Sherbrooke', '');
INSERT INTO `feel_province` VALUES (1022, 'SCA', 'CAN', '圣卡塔琳娜', 'Santa Catarina', '');
INSERT INTO `feel_province` VALUES (1023, 'SJB', 'CAN', '圣约翰斯', 'St. Johns', '');
INSERT INTO `feel_province` VALUES (1024, 'VIC', 'CAN', '维多利亚', 'Victoria', '');
INSERT INTO `feel_province` VALUES (1025, 'VAN', 'CAN', '温哥华', 'Vancouver', '');
INSERT INTO `feel_province` VALUES (1026, 'WNP', 'CAN', '温尼伯', 'Winnipeg', '');
INSERT INTO `feel_province` VALUES (1027, 'WDR', 'CAN', '温莎', 'Windsor', '');
INSERT INTO `feel_province` VALUES (1028, 'OTT', 'CAN', '渥太华', 'Ottawa', '');
INSERT INTO `feel_province` VALUES (1029, 'CHA', 'CAN', '夏洛特敦', 'Charlottetown', '');
INSERT INTO `feel_province` VALUES (1030, 'YZF', 'CAN', '耶洛奈夫', 'Kanao', '');
INSERT INTO `feel_province` VALUES (1031, 'IQL', 'CAN', '伊魁特', 'Iqalte', '');
INSERT INTO `feel_province` VALUES (1032, 'AS', 'GHA', '阿散蒂', 'Ashanti', '');
INSERT INTO `feel_province` VALUES (1033, 'OBU', 'GHA', '奥布阿西', 'Obuasi', '');
INSERT INTO `feel_province` VALUES (1034, 'NO', 'GHA', '北部', 'North', '');
INSERT INTO `feel_province` VALUES (1035, 'BA', 'GHA', '布朗阿哈福', 'Brown Ahafo', '');
INSERT INTO `feel_province` VALUES (1036, 'GA', 'GHA', '大阿克拉', 'Grand Accra', '');
INSERT INTO `feel_province` VALUES (1037, 'EA', 'GHA', '东部', 'east', '');
INSERT INTO `feel_province` VALUES (1038, 'UE', 'GHA', '上东部', 'Upper east', '');
INSERT INTO `feel_province` VALUES (1039, 'UW', 'GHA', '上西部', 'Upper west', '');
INSERT INTO `feel_province` VALUES (1040, 'VO', 'GHA', '沃尔特', 'Walter', '');
INSERT INTO `feel_province` VALUES (1041, 'WE', 'GHA', '西部', 'west', '');
INSERT INTO `feel_province` VALUES (1042, 'CE', 'GHA', '中部', 'Central', '');
INSERT INTO `feel_province` VALUES (1043, 'OL', 'GAB', '奥果韦洛洛', 'Ogo Velolo', '');
INSERT INTO `feel_province` VALUES (1044, 'OI', 'GAB', '奥果韦伊温多', 'Ogowe Ivando', '');
INSERT INTO `feel_province` VALUES (1045, 'OM', 'GAB', '滨海奥果韦', 'Ogowe', '');
INSERT INTO `feel_province` VALUES (1046, 'NG', 'GAB', '恩古涅', 'Ngne', '');
INSERT INTO `feel_province` VALUES (1047, 'ES', 'GAB', '河口', 'estuary', '');
INSERT INTO `feel_province` VALUES (1048, 'NY', 'GAB', '尼扬加', 'Nyanga', '');
INSERT INTO `feel_province` VALUES (1049, 'HO', 'GAB', '上奥果韦', 'Upper Ogowe', '');
INSERT INTO `feel_province` VALUES (1050, 'WN', 'GAB', '沃勒恩特姆', 'Wallertem', '');
INSERT INTO `feel_province` VALUES (1051, 'MO', 'GAB', '中奥果韦', 'Central Ogo', '');
INSERT INTO `feel_province` VALUES (1052, 'OC', 'KHM', '奥多棉吉', 'Otto Mianji', '');
INSERT INTO `feel_province` VALUES (1053, 'KB', 'KHM', '白马市', 'White Horse City', '');
INSERT INTO `feel_province` VALUES (1054, 'PR', 'KHM', '柏威夏', 'Preah Vihear', '');
INSERT INTO `feel_province` VALUES (1055, 'PL', 'KHM', '拜林市', 'Bailin City', '');
INSERT INTO `feel_province` VALUES (1056, 'BM', 'KHM', '班迭棉吉', 'Banteay Mianji', '');
INSERT INTO `feel_province` VALUES (1057, 'KZC', 'KHM', '磅清扬', 'Pound Qing Yang', '');
INSERT INTO `feel_province` VALUES (1058, 'KO', 'KHM', '磅士卑', 'Kompong', '');
INSERT INTO `feel_province` VALUES (1059, 'KZK', 'KHM', '磅同', 'Pound', '');
INSERT INTO `feel_province` VALUES (1060, 'KM', 'KHM', '磅湛', 'Kampong Cham', '');
INSERT INTO `feel_province` VALUES (1061, 'PG', 'KHM', '波罗勉', 'Boro', '');
INSERT INTO `feel_province` VALUES (1062, 'TK', 'KHM', '茶胶', 'Tea glue', '');
INSERT INTO `feel_province` VALUES (1063, 'SVR', 'KHM', '柴桢', 'Chai', '');
INSERT INTO `feel_province` VALUES (1064, 'KL', 'KHM', '干丹', 'Gandan', '');
INSERT INTO `feel_province` VALUES (1065, 'KKZ', 'KHM', '戈公', 'Gogong', '');
INSERT INTO `feel_province` VALUES (1066, 'KMT', 'KHM', '贡布', 'Kampot', '');
INSERT INTO `feel_province` VALUES (1067, 'PNH', 'KHM', '金边市', 'Phnom Penh City', '');
INSERT INTO `feel_province` VALUES (1068, 'KH', 'KHM', '桔井', 'Kratie', '');
INSERT INTO `feel_province` VALUES (1069, 'RBE', 'KHM', '腊塔纳基里', 'Ratanakiri', '');
INSERT INTO `feel_province` VALUES (1070, 'BA', 'KHM', '马德望', 'Battambang', '');
INSERT INTO `feel_province` VALUES (1071, 'MWV', 'KHM', '蒙多基里', 'Mondokiri', '');
INSERT INTO `feel_province` VALUES (1072, 'PO', 'KHM', '菩萨', 'Buddha', '');
INSERT INTO `feel_province` VALUES (1073, 'TNX', 'KHM', '上丁', 'Shangding', '');
INSERT INTO `feel_province` VALUES (1074, 'KA', 'KHM', '西哈努克市', 'Sihanoukville', '');
INSERT INTO `feel_province` VALUES (1075, 'REP', 'KHM', '暹粒', 'Siem Reap', '');
INSERT INTO `feel_province` VALUES (1076, 'OL', 'CZE', '奥洛穆茨', 'Olomouc', '');
INSERT INTO `feel_province` VALUES (1077, 'PL', 'CZE', '比尔森', 'Plzen', '');
INSERT INTO `feel_province` VALUES (1078, 'PR', 'CZE', '布拉格直辖市', 'Prague municipality', '');
INSERT INTO `feel_province` VALUES (1079, 'KR', 'CZE', '赫拉德茨克拉洛韦', 'Hradec Kralove', '');
INSERT INTO `feel_province` VALUES (1080, 'KA', 'CZE', '卡罗维发利', 'Karlovy Vary', '');
INSERT INTO `feel_province` VALUES (1081, 'LI', 'CZE', '利贝雷克', 'Liberek', '');
INSERT INTO `feel_province` VALUES (1082, 'MO', 'CZE', '摩拉维亚西里西亚', 'Moravia Silesia', '');
INSERT INTO `feel_province` VALUES (1083, 'JC', 'CZE', '南摩拉维亚', 'South Moravia', '');
INSERT INTO `feel_province` VALUES (1084, 'PA', 'CZE', '帕尔杜比采', 'Pardubice', '');
INSERT INTO `feel_province` VALUES (1085, 'VY', 'CZE', '维索基纳', 'Vysokina', '');
INSERT INTO `feel_province` VALUES (1086, 'US', 'CZE', '乌斯季', 'Usti', '');
INSERT INTO `feel_province` VALUES (1087, 'ST', 'CZE', '中捷克', 'Central Czech Republic', '');
INSERT INTO `feel_province` VALUES (1088, 'ZL', 'CZE', '兹林', 'Zlin', '');
INSERT INTO `feel_province` VALUES (1089, 'MN', 'ZWE', '北马塔贝莱兰', 'North Mata Belleland', '');
INSERT INTO `feel_province` VALUES (1090, 'BU', 'ZWE', '布拉瓦约', 'Bulawayo', '');
INSERT INTO `feel_province` VALUES (1091, 'ME', 'ZWE', '东马绍纳兰', 'East Mashonaland', '');
INSERT INTO `feel_province` VALUES (1092, 'HA', 'ZWE', '哈拉雷', 'Harare', '');
INSERT INTO `feel_province` VALUES (1093, 'ML', 'ZWE', '马尼卡兰', 'Manikaran', '');
INSERT INTO `feel_province` VALUES (1094, 'MV', 'ZWE', '马斯温戈', 'Masvingo', '');
INSERT INTO `feel_province` VALUES (1095, 'MS', 'ZWE', '南马塔贝莱兰', 'South Mata Belleland', '');
INSERT INTO `feel_province` VALUES (1096, 'MW', 'ZWE', '西马绍纳兰', 'West Marconaran', '');
INSERT INTO `feel_province` VALUES (1097, 'MD', 'ZWE', '中部', 'Central', '');
INSERT INTO `feel_province` VALUES (1098, 'MC', 'ZWE', '中马绍纳兰', 'Mashonaland', '');
INSERT INTO `feel_province` VALUES (1099, 'ADA', 'CMR', '阿达马瓦', 'Adamawa', '');
INSERT INTO `feel_province` VALUES (1100, 'NOR', 'CMR', '北部', 'North', '');
INSERT INTO `feel_province` VALUES (1101, 'EXN', 'CMR', '北端', 'North end', '');
INSERT INTO `feel_province` VALUES (1102, 'LIT', 'CMR', '滨海', 'Coast', '');
INSERT INTO `feel_province` VALUES (1103, 'EST', 'CMR', '东部', 'east', '');
INSERT INTO `feel_province` VALUES (1104, 'SUD', 'CMR', '南部', 'Southern', '');
INSERT INTO `feel_province` VALUES (1105, 'NOT', 'CMR', '西北', 'northwest', '');
INSERT INTO `feel_province` VALUES (1106, 'OUE', 'CMR', '西部', 'west', '');
INSERT INTO `feel_province` VALUES (1107, 'SOU', 'CMR', '西南', 'southwest', '');
INSERT INTO `feel_province` VALUES (1108, 'CEN', 'CMR', '中央', 'central', '');
INSERT INTO `feel_province` VALUES (1109, 'MS', 'QAT', '北部', 'North', '');
INSERT INTO `feel_province` VALUES (1110, 'DW', 'QAT', '多哈', 'Doha', '');
INSERT INTO `feel_province` VALUES (1111, 'GW', 'QAT', '古韦里耶', 'Guwerlier', '');
INSERT INTO `feel_province` VALUES (1112, 'KR', 'QAT', '豪尔', 'Hall', '');
INSERT INTO `feel_province` VALUES (1113, 'JB', 'QAT', '杰里扬拜特奈', 'Jeriyan Beitnay', '');
INSERT INTO `feel_province` VALUES (1114, 'RN', 'QAT', '赖扬', 'Lai Yang', '');
INSERT INTO `feel_province` VALUES (1115, 'WK', 'QAT', '沃克拉', 'Wokla', '');
INSERT INTO `feel_province` VALUES (1116, 'UL', 'QAT', '乌姆锡拉勒', 'Umm Silal', '');
INSERT INTO `feel_province` VALUES (1117, 'JM', 'QAT', '朱迈利耶', 'Jumeilier', '');
INSERT INTO `feel_province` VALUES (1118, 'AG', 'CIV', '阿涅比', 'Aniebi', '');
INSERT INTO `feel_province` VALUES (1119, 'BF', 'CIV', '巴芬', 'Baffin', '');
INSERT INTO `feel_province` VALUES (1120, 'VB', 'CIV', '邦达马河谷', 'Bondama Valley', '');
INSERT INTO `feel_province` VALUES (1121, 'DE', 'CIV', '登盖莱', 'Climb', '');
INSERT INTO `feel_province` VALUES (1122, 'NC', 'CIV', '恩济－科莫埃', 'Enzi-Comoe', '');
INSERT INTO `feel_province` VALUES (1123, 'FR', 'CIV', '弗罗马格尔', 'Fromagel', '');
INSERT INTO `feel_province` VALUES (1124, 'LC', 'CIV', '湖泊', 'lake', '');
INSERT INTO `feel_province` VALUES (1125, 'MR', 'CIV', '马拉韦', 'Malawi', '');
INSERT INTO `feel_province` VALUES (1126, 'SB', 'CIV', '南邦达马', 'Lampang Dama', '');
INSERT INTO `feel_province` VALUES (1127, 'SC', 'CIV', '南科莫埃', 'South Comoie', '');
INSERT INTO `feel_province` VALUES (1128, 'HT', 'CIV', '萨桑德拉', 'Sasandra', '');
INSERT INTO `feel_province` VALUES (1129, 'SV', 'CIV', '萨瓦纳', 'Savannah', '');
INSERT INTO `feel_province` VALUES (1130, 'DH', 'CIV', '山地', 'Mountain', '');
INSERT INTO `feel_province` VALUES (1131, 'WR', 'CIV', '沃罗杜古', 'Vorodougou', '');
INSERT INTO `feel_province` VALUES (1132, 'BS', 'CIV', '下萨桑德拉', 'Lower Sasandra', '');
INSERT INTO `feel_province` VALUES (1133, 'LG', 'CIV', '泻湖', 'lagoon', '');
INSERT INTO `feel_province` VALUES (1134, 'ZA', 'CIV', '赞赞', 'Like Like', '');
INSERT INTO `feel_province` VALUES (1135, 'MV', 'CIV', '中卡瓦利', 'Middle Cavalli', '');
INSERT INTO `feel_province` VALUES (1136, 'MC', 'CIV', '中科莫埃', 'Central Comoe', '');
INSERT INTO `feel_province` VALUES (1137, '14', 'HRV', '奥西耶克巴拉尼亚', 'Osijek Baranja', '');
INSERT INTO `feel_province` VALUES (1138, '7', 'HRV', '别洛瓦尔比洛戈拉', 'Belovar Bilogola', '');
INSERT INTO `feel_province` VALUES (1139, '8', 'HRV', '滨海和山区', 'Coastal and mountainous areas', '');
INSERT INTO `feel_province` VALUES (1140, '11', 'HRV', '波热加斯拉沃尼亚', 'Pozegas Lavonia', '');
INSERT INTO `feel_province` VALUES (1141, '12', 'HRV', '布罗德波萨维纳', 'Brod Posavina', '');
INSERT INTO `feel_province` VALUES (1142, '19', 'HRV', '杜布罗夫斯克内雷特瓦', 'Dubrovnik Neretva', '');
INSERT INTO `feel_province` VALUES (1143, '4', 'HRV', '卡尔洛瓦茨', 'Karlovac', '');
INSERT INTO `feel_province` VALUES (1144, '6', 'HRV', '科普里夫尼察克里热夫齐', 'Koprivnica Krizhevzi', '');
INSERT INTO `feel_province` VALUES (1145, '2', 'HRV', '克拉皮纳扎戈列', 'Krapina Zagore', '');
INSERT INTO `feel_province` VALUES (1146, '9', 'HRV', '利卡塞尼', 'Likaseni', '');
INSERT INTO `feel_province` VALUES (1147, '20', 'HRV', '梅吉穆列', 'Megumi', '');
INSERT INTO `feel_province` VALUES (1148, '1', 'HRV', '萨格勒布', 'Zagreb', '');
INSERT INTO `feel_province` VALUES (1149, '21', 'HRV', '萨格勒布市', 'Zagreb City', '');
INSERT INTO `feel_province` VALUES (1150, '17', 'HRV', '斯普利特达尔马提亚', 'Split Dalmatia', '');
INSERT INTO `feel_province` VALUES (1151, '5', 'HRV', '瓦拉日丁', 'Varaždin', '');
INSERT INTO `feel_province` VALUES (1152, '10', 'HRV', '维罗维蒂察波德拉维纳', 'Virovica Podravina', '');
INSERT INTO `feel_province` VALUES (1153, '16', 'HRV', '武科瓦尔斯里耶姆', 'Vukovisriyem', '');
INSERT INTO `feel_province` VALUES (1154, '15', 'HRV', '希贝尼克克宁', 'Sibenik Knin', '');
INSERT INTO `feel_province` VALUES (1155, '3', 'HRV', '锡萨克莫斯拉维纳', 'Sisak Moss Lavina', '');
INSERT INTO `feel_province` VALUES (1156, '18', 'HRV', '伊斯特拉', 'Istria', '');
INSERT INTO `feel_province` VALUES (1157, '13', 'HRV', '扎达尔', 'Zadar', '');
INSERT INTO `feel_province` VALUES (1158, 'EMA', 'KEN', '埃尔格约马拉奎特', 'El gyo maracquet', '');
INSERT INTO `feel_province` VALUES (1159, 'BAR', 'KEN', '巴林戈', 'Baringo', '');
INSERT INTO `feel_province` VALUES (1160, 'BUN', 'KEN', '邦戈马', 'Bangoma', '');
INSERT INTO `feel_province` VALUES (1161, 'BOM', 'KEN', '博美特', 'Bomet', '');
INSERT INTO `feel_province` VALUES (1162, 'BUS', 'KEN', '布希亚', 'Busia', '');
INSERT INTO `feel_province` VALUES (1163, 'EMB', 'KEN', '恩布', 'Embu', '');
INSERT INTO `feel_province` VALUES (1164, 'HOB', 'KEN', '霍马湾', 'Homa Bay', '');
INSERT INTO `feel_province` VALUES (1165, 'KIA', 'KEN', '基安布', 'Kiambu', '');
INSERT INTO `feel_province` VALUES (1166, 'KIL', 'KEN', '基里菲', 'Kirifi', '');
INSERT INTO `feel_province` VALUES (1167, 'KIR', 'KEN', '基里尼亚加', 'Kiriniga', '');
INSERT INTO `feel_province` VALUES (1168, 'KIS', 'KEN', '基苏木', 'Kisumu', '');
INSERT INTO `feel_province` VALUES (1169, 'KIT', 'KEN', '基图伊', 'Kitui', '');
INSERT INTO `feel_province` VALUES (1170, 'KII', 'KEN', '基西', 'Kissey', '');
INSERT INTO `feel_province` VALUES (1171, 'GAS', 'KEN', '加里萨', 'Garissa', '');
INSERT INTO `feel_province` VALUES (1172, 'KAK', 'KEN', '卡卡梅加', 'Kakamega', '');
INSERT INTO `feel_province` VALUES (1173, 'KAJ', 'KEN', '卡耶亚多', 'Cayeado', '');
INSERT INTO `feel_province` VALUES (1174, 'KEY', 'KEN', '凯里乔', 'Kerry Joe', '');
INSERT INTO `feel_province` VALUES (1175, 'KWA', 'KEN', '夸勒', 'Kwale', '');
INSERT INTO `feel_province` VALUES (1176, 'LAU', 'KEN', '拉木', 'Pull wood', '');
INSERT INTO `feel_province` VALUES (1177, 'LAI', 'KEN', '莱基皮亚', 'Lekipia', '');
INSERT INTO `feel_province` VALUES (1178, 'MAC', 'KEN', '马查科斯', 'Machakos', '');
INSERT INTO `feel_province` VALUES (1179, 'MAK', 'KEN', '马瓜尼', 'Maguani', '');
INSERT INTO `feel_province` VALUES (1180, 'RBT', 'KEN', '马萨布布', 'Masabub', '');
INSERT INTO `feel_province` VALUES (1181, 'MAN', 'KEN', '曼德拉', 'Mandela', '');
INSERT INTO `feel_province` VALUES (1182, 'MER', 'KEN', '梅鲁', 'Meru', '');
INSERT INTO `feel_province` VALUES (1183, 'MOM', 'KEN', '蒙巴萨', 'Mombasa', '');
INSERT INTO `feel_province` VALUES (1184, 'MIG', 'KEN', '米戈利', 'Migoli', '');
INSERT INTO `feel_province` VALUES (1185, 'MUR', 'KEN', '穆兰卡', 'Mulanka', '');
INSERT INTO `feel_province` VALUES (1186, 'NUU', 'KEN', '纳库鲁', 'Nakuru', '');
INSERT INTO `feel_province` VALUES (1187, 'NAR', 'KEN', '纳罗克', 'Narok', '');
INSERT INTO `feel_province` VALUES (1188, 'NAN', 'KEN', '南迪', 'Nandi', '');
INSERT INTO `feel_province` VALUES (1189, 'NA', 'KEN', '内罗毕', 'Nairobi', '');
INSERT INTO `feel_province` VALUES (1190, 'NIT', 'KEN', '尼蒂', 'Nitti', '');
INSERT INTO `feel_province` VALUES (1191, 'NYM', 'KEN', '尼亚米拉', 'Niamela', '');
INSERT INTO `feel_province` VALUES (1192, 'NYN', 'KEN', '年达鲁阿', 'Darua', '');
INSERT INTO `feel_province` VALUES (1193, 'NYE', 'KEN', '涅里', 'Puli', '');
INSERT INTO `feel_province` VALUES (1194, 'UAS', 'KEN', '桑布卢', 'Samburu', '');
INSERT INTO `feel_province` VALUES (1195, 'TRI', 'KEN', '塔纳河', 'Tana', '');
INSERT INTO `feel_province` VALUES (1196, 'TTA', 'KEN', '泰塔塔维塔', 'Tata Tavita', '');
INSERT INTO `feel_province` VALUES (1197, 'TNZ', 'KEN', '特兰斯恩佐亚', 'Transsenza', '');
INSERT INTO `feel_province` VALUES (1198, 'TUR', 'KEN', '图尔卡纳', 'Turkana', '');
INSERT INTO `feel_province` VALUES (1199, 'WJR', 'KEN', '瓦吉尔', 'Wajir', '');
INSERT INTO `feel_province` VALUES (1200, 'UGI', 'KEN', '瓦辛基苏', 'Vasinkisu', '');
INSERT INTO `feel_province` VALUES (1201, 'VIH', 'KEN', '韦希加', 'Wehiga', '');
INSERT INTO `feel_province` VALUES (1202, 'WPO', 'KEN', '西波克特', 'West Pock', '');
INSERT INTO `feel_province` VALUES (1203, 'SIA', 'KEN', '夏亚', 'Xia', '');
INSERT INTO `feel_province` VALUES (1204, 'ISI', 'KEN', '伊希约洛', 'Ihijolo', '');
INSERT INTO `feel_province` VALUES (1205, 'CE', 'KEN', '中央', 'central', '');
INSERT INTO `feel_province` VALUES (1206, 'ALU', 'LVA', '阿卢克斯内', 'Aluksne', '');
INSERT INTO `feel_province` VALUES (1207, 'AIZ', 'LVA', '爱兹克劳克雷', 'Az Croakley', '');
INSERT INTO `feel_province` VALUES (1208, 'OGR', 'LVA', '奥格雷', 'Ogre', '');
INSERT INTO `feel_province` VALUES (1209, 'BAL', 'LVA', '巴尔维', 'Barvi', '');
INSERT INTO `feel_province` VALUES (1210, 'BAU', 'LVA', '包斯卡', 'Bauska', '');
INSERT INTO `feel_province` VALUES (1211, 'CES', 'LVA', '采西斯', 'Cesis', '');
INSERT INTO `feel_province` VALUES (1212, 'DOB', 'LVA', '多贝莱', 'Dobelle', '');
INSERT INTO `feel_province` VALUES (1213, 'GUL', 'LVA', '古尔贝内', 'Gulbene', '');
INSERT INTO `feel_province` VALUES (1214, 'JEK', 'LVA', '杰卡布皮尔斯', 'Jakabpils', '');
INSERT INTO `feel_province` VALUES (1215, 'KRA', 'LVA', '克拉斯拉瓦', 'Kraslava', '');
INSERT INTO `feel_province` VALUES (1216, 'KUL', 'LVA', '库尔迪加', 'Kurdiga', '');
INSERT INTO `feel_province` VALUES (1217, 'RZR', 'LVA', '雷泽克内', 'Rezekne', '');
INSERT INTO `feel_province` VALUES (1218, 'RGA', 'LVA', '里加', 'Riga', '');
INSERT INTO `feel_province` VALUES (1219, 'LPK', 'LVA', '利耶帕亚', 'Liepaja', '');
INSERT INTO `feel_province` VALUES (1220, 'LIM', 'LVA', '林巴济', 'Limbazi', '');
INSERT INTO `feel_province` VALUES (1221, 'LUD', 'LVA', '卢扎', 'Luza', '');
INSERT INTO `feel_province` VALUES (1222, 'MAD', 'LVA', '马多纳', 'Madona', '');
INSERT INTO `feel_province` VALUES (1223, 'PRE', 'LVA', '普雷利', 'Preli', '');
INSERT INTO `feel_province` VALUES (1224, 'SAL', 'LVA', '萨尔杜斯', 'Saldus', '');
INSERT INTO `feel_province` VALUES (1225, 'TAL', 'LVA', '塔尔西', 'Talsi', '');
INSERT INTO `feel_province` VALUES (1226, 'DGR', 'LVA', '陶格夫皮尔斯', 'Daugav Pierce', '');
INSERT INTO `feel_province` VALUES (1227, 'TUK', 'LVA', '图库马', 'Gallery horse', '');
INSERT INTO `feel_province` VALUES (1228, 'VLK', 'LVA', '瓦尔加', 'Varga', '');
INSERT INTO `feel_province` VALUES (1229, 'VLM', 'LVA', '瓦尔米耶拉', 'Valmiera', '');
INSERT INTO `feel_province` VALUES (1230, 'VSL', 'LVA', '文茨皮尔斯', 'Ventspils', '');
INSERT INTO `feel_province` VALUES (1231, 'JGR', 'LVA', '叶尔加瓦', 'Yelgava', '');
INSERT INTO `feel_province` VALUES (1232, 'D', 'LSO', '伯里亚', 'Berea', '');
INSERT INTO `feel_province` VALUES (1233, 'B', 'LSO', '布塔布泰', 'Butabutai', '');
INSERT INTO `feel_province` VALUES (1234, 'G', 'LSO', '古廷', 'Gutin', '');
INSERT INTO `feel_province` VALUES (1235, 'H', 'LSO', '加查斯内克', 'Gachasneck', '');
INSERT INTO `feel_province` VALUES (1236, 'C', 'LSO', '莱里贝', 'Leribe', '');
INSERT INTO `feel_province` VALUES (1237, 'E', 'LSO', '马费滕', 'Maften', '');
INSERT INTO `feel_province` VALUES (1238, 'A', 'LSO', '马塞卢', 'Maseru', '');
INSERT INTO `feel_province` VALUES (1239, 'F', 'LSO', '莫哈莱斯胡克', 'Mohales Hook', '');
INSERT INTO `feel_province` VALUES (1240, 'J', 'LSO', '莫霍特隆', 'Mohotlon', '');
INSERT INTO `feel_province` VALUES (1241, 'K', 'LSO', '塔巴采卡', 'Tabazica', '');
INSERT INTO `feel_province` VALUES (1242, 'AT', 'LAO', '阿速坡', 'Azov', '');
INSERT INTO `feel_province` VALUES (1243, 'BL', 'LAO', '波里坎赛', 'Porikansai', '');
INSERT INTO `feel_province` VALUES (1244, 'BK', 'LAO', '博乔', 'Bocho', '');
INSERT INTO `feel_province` VALUES (1245, 'XI', 'LAO', '川圹', 'Chuanxiong', '');
INSERT INTO `feel_province` VALUES (1246, 'PH', 'LAO', '丰沙里', 'Fengshali', '');
INSERT INTO `feel_province` VALUES (1247, 'KH', 'LAO', '甘蒙', 'Gan Meng', '');
INSERT INTO `feel_province` VALUES (1248, 'HO', 'LAO', '华潘', 'Huapan', '');
INSERT INTO `feel_province` VALUES (1249, 'LP', 'LAO', '琅勃拉邦', 'Luang Prabang', '');
INSERT INTO `feel_province` VALUES (1250, 'LM', 'LAO', '琅南塔', '琅南塔', '');
INSERT INTO `feel_province` VALUES (1251, 'XN', 'LAO', '赛宋本行政特区', 'Sai Songben Special Administrative Region', '');
INSERT INTO `feel_province` VALUES (1252, 'XE', 'LAO', '色贡', 'Segun', '');
INSERT INTO `feel_province` VALUES (1253, 'SL', 'LAO', '沙拉湾', 'Salad Bay', '');
INSERT INTO `feel_province` VALUES (1254, 'SV', 'LAO', '沙湾拿吉', 'Savannakhet', '');
INSERT INTO `feel_province` VALUES (1255, 'XA', 'LAO', '沙耶武里', 'Sayaburi', '');
INSERT INTO `feel_province` VALUES (1256, 'VI', 'LAO', '万象', 'Vientiane', '');
INSERT INTO `feel_province` VALUES (1257, 'OU', 'LAO', '乌多姆赛', 'Udom', '');
INSERT INTO `feel_province` VALUES (1258, 'CH', 'LAO', '占巴塞', 'Champas', '');
INSERT INTO `feel_province` VALUES (1259, 'AS', 'LBN', '北部', 'North', '');
INSERT INTO `feel_province` VALUES (1260, 'BI', 'LBN', '贝卡', 'Beka', '');
INSERT INTO `feel_province` VALUES (1261, 'BA', 'LBN', '贝鲁特', 'Beirut', '');
INSERT INTO `feel_province` VALUES (1262, 'JL', 'LBN', '黎巴嫩山', 'Mount Lebanon', '');
INSERT INTO `feel_province` VALUES (1263, 'NA', 'LBN', '奈拜提耶市', 'Nabatiyah', '');
INSERT INTO `feel_province` VALUES (1264, 'JA', 'LBN', '南部', 'Southern', '');
INSERT INTO `feel_province` VALUES (1265, 'GBA', 'LBR', '巴波卢', 'Bapolo', '');
INSERT INTO `feel_province` VALUES (1266, 'BG', 'LBR', '邦', 'state', '');
INSERT INTO `feel_province` VALUES (1267, 'BOP', 'LBR', '博波卢', 'Bopolu', '');
INSERT INTO `feel_province` VALUES (1268, 'BM', 'LBR', '博米', 'Bomi', '');
INSERT INTO `feel_province` VALUES (1269, 'GB', 'LBR', '大巴萨', 'Grand Barca', '');
INSERT INTO `feel_province` VALUES (1270, 'GG', 'LBR', '大吉德', 'Grand Ged', '');
INSERT INTO `feel_province` VALUES (1271, 'CM', 'LBR', '大角山', 'Dajiaoshan', '');
INSERT INTO `feel_province` VALUES (1272, 'GK', 'LBR', '大克鲁', 'Big kru', '');
INSERT INTO `feel_province` VALUES (1273, 'FT', 'LBR', '菲什敦', 'Fishtown', '');
INSERT INTO `feel_province` VALUES (1274, 'RG', 'LBR', '吉河', 'Yoshikawa', '');
INSERT INTO `feel_province` VALUES (1275, 'RI', 'LBR', '里弗塞斯', 'Rivers', '');
INSERT INTO `feel_province` VALUES (1276, 'LO', 'LBR', '洛法', 'Lofa', '');
INSERT INTO `feel_province` VALUES (1277, 'MG', 'LBR', '马吉比', 'Magibi', '');
INSERT INTO `feel_province` VALUES (1278, 'MY', 'LBR', '马里兰', 'Maryland', '');
INSERT INTO `feel_province` VALUES (1279, 'MO', 'LBR', '蒙特塞拉多', 'Montserado', '');
INSERT INTO `feel_province` VALUES (1280, 'NI', 'LBR', '宁巴', 'Ningba', '');
INSERT INTO `feel_province` VALUES (1281, 'SI', 'LBR', '锡诺', 'Tino', '');
INSERT INTO `feel_province` VALUES (1282, 'AL', 'LTU', '阿利图斯', 'Alytus', '');
INSERT INTO `feel_province` VALUES (1283, 'KA', 'LTU', '考纳斯', 'Kaunas', '');
INSERT INTO `feel_province` VALUES (1284, 'KL', 'LTU', '克莱佩达', 'Klaipeda', '');
INSERT INTO `feel_province` VALUES (1285, 'MA', 'LTU', '马里扬泊列', 'Marilyn', '');
INSERT INTO `feel_province` VALUES (1286, 'PA', 'LTU', '帕涅韦日斯', 'Panevezys', '');
INSERT INTO `feel_province` VALUES (1287, 'TA', 'LTU', '陶拉格', 'Taurag', '');
INSERT INTO `feel_province` VALUES (1288, 'TE', 'LTU', '特尔希艾', 'Telhiai', '');
INSERT INTO `feel_province` VALUES (1289, 'VI', 'LTU', '维尔纽斯', 'Vilnius', '');
INSERT INTO `feel_province` VALUES (1290, 'UT', 'LTU', '乌田纳', 'Utena', '');
INSERT INTO `feel_province` VALUES (1291, 'SI', 'LTU', '希奥利艾', 'Siauliai', '');
INSERT INTO `feel_province` VALUES (1292, 'AKM', 'LTU', '亚克曼', 'Ackerman', '');
INSERT INTO `feel_province` VALUES (1293, 'DD', 'LUX', '迪基希', 'Dickhi', '');
INSERT INTO `feel_province` VALUES (1294, 'GG', 'LUX', '格雷文马赫', 'Grevenmacher', '');
INSERT INTO `feel_province` VALUES (1295, 'LL', 'LUX', '卢森堡', 'Luxembourg', '');
INSERT INTO `feel_province` VALUES (1296, 'BY', 'RWA', '比温巴', 'Biwamba', '');
INSERT INTO `feel_province` VALUES (1297, 'BU', 'RWA', '布塔雷', 'Butare', '');
INSERT INTO `feel_province` VALUES (1298, 'NY', 'RWA', '恩延扎', 'Nendza', '');
INSERT INTO `feel_province` VALUES (1299, 'KG', 'RWA', '基本古', 'Basic ancient', '');
INSERT INTO `feel_province` VALUES (1300, 'KY', 'RWA', '基布耶', 'Kibuye', '');
INSERT INTO `feel_province` VALUES (1301, 'KR', 'RWA', '基加利恩加利', 'Kigaliengali', '');
INSERT INTO `feel_province` VALUES (1302, 'KV', 'RWA', '基加利市', 'Kigali', '');
INSERT INTO `feel_province` VALUES (1303, 'GK', 'RWA', '吉孔戈罗', 'Gikongoro', '');
INSERT INTO `feel_province` VALUES (1304, 'GS', 'RWA', '吉塞尼', 'Giseni', '');
INSERT INTO `feel_province` VALUES (1305, 'GT', 'RWA', '吉塔拉马', 'Gitarama', '');
INSERT INTO `feel_province` VALUES (1306, 'KA', 'RWA', '卡布加', 'Kabuga', '');
INSERT INTO `feel_province` VALUES (1307, 'RW', 'RWA', '卢瓦马加纳', 'Luvamagana', '');
INSERT INTO `feel_province` VALUES (1308, 'RH', 'RWA', '鲁汉戈', 'Luhango', '');
INSERT INTO `feel_province` VALUES (1309, 'RU', 'RWA', '鲁亨盖里', 'Ruhengeri', '');
INSERT INTO `feel_province` VALUES (1310, 'CY', 'RWA', '尚古古', 'Shanggugu', '');
INSERT INTO `feel_province` VALUES (1311, 'UM', 'RWA', '乌姆塔拉', 'Umtala', '');
INSERT INTO `feel_province` VALUES (1312, 'AL', 'ROU', '阿尔巴尤利亚', 'Alba Iulia', '');
INSERT INTO `feel_province` VALUES (1313, 'AR', 'ROU', '阿拉德', 'Arad', '');
INSERT INTO `feel_province` VALUES (1314, 'OR', 'ROU', '奥拉迪亚', 'Oradea', '');
INSERT INTO `feel_province` VALUES (1315, 'BA', 'ROU', '巴克乌', 'Bacau', '');
INSERT INTO `feel_province` VALUES (1316, 'BM', 'ROU', '巴亚马雷', 'Baya Mare', '');
INSERT INTO `feel_province` VALUES (1317, 'BN', 'ROU', '比斯特里察', 'Bistrica', '');
INSERT INTO `feel_province` VALUES (1318, 'BO', 'ROU', '博托沙尼', 'Botosani', '');
INSERT INTO `feel_province` VALUES (1319, 'BC', 'ROU', '布加勒斯特', 'Bucharest', '');
INSERT INTO `feel_province` VALUES (1320, 'BS', 'ROU', '布拉索夫', 'Brasov', '');
INSERT INTO `feel_province` VALUES (1321, 'BL', 'ROU', '布勒伊拉', 'Breila', '');
INSERT INTO `feel_province` VALUES (1322, 'BZ', 'ROU', '布泽乌', 'Buzau', '');
INSERT INTO `feel_province` VALUES (1323, 'DT', 'ROU', '德罗贝塔塞维林堡', 'Drobeta Severinburg', '');
INSERT INTO `feel_province` VALUES (1324, 'DE', 'ROU', '德瓦', 'Deva', '');
INSERT INTO `feel_province` VALUES (1325, 'TI', 'ROU', '蒂米什瓦拉', 'Timisoara', '');
INSERT INTO `feel_province` VALUES (1326, 'FO', 'ROU', '福克沙尼', 'Foksani', '');
INSERT INTO `feel_province` VALUES (1327, 'GL', 'ROU', '加拉茨', 'Galati', '');
INSERT INTO `feel_province` VALUES (1328, 'GG', 'ROU', '久尔久', 'Jiurjiu', '');
INSERT INTO `feel_province` VALUES (1329, 'CT', 'ROU', '康斯坦察', 'Constanta', '');
INSERT INTO `feel_province` VALUES (1330, 'DO', 'ROU', '克拉约瓦', 'Craiova', '');
INSERT INTO `feel_province` VALUES (1331, 'CR', 'ROU', '克勒拉希', 'Klerachi', '');
INSERT INTO `feel_province` VALUES (1332, 'CN', 'ROU', '克卢日纳波卡', 'Clujna Poca', '');
INSERT INTO `feel_province` VALUES (1333, 'VI', 'ROU', '勒姆尼库沃尔恰', 'Ramnicu vulcia', '');
INSERT INTO `feel_province` VALUES (1334, 'RE', 'ROU', '雷希察', 'Rechica', '');
INSERT INTO `feel_province` VALUES (1335, 'MC', 'ROU', '梅尔库里亚丘克', 'Merkuriachuk', '');
INSERT INTO `feel_province` VALUES (1336, 'PI', 'ROU', '皮特什蒂', 'Pitesti', '');
INSERT INTO `feel_province` VALUES (1337, 'PN', 'ROU', '皮亚特拉尼亚姆茨', 'Piatraniam', '');
INSERT INTO `feel_province` VALUES (1338, 'PL', 'ROU', '普洛耶什蒂', 'Ploiesti', '');
INSERT INTO `feel_province` VALUES (1339, 'SM', 'ROU', '萨图·马雷', 'Sato Mare', '');
INSERT INTO `feel_province` VALUES (1340, 'SG', 'ROU', '圣格奥尔基', 'San Gheorghe', '');
INSERT INTO `feel_province` VALUES (1341, 'ST', 'ROU', '斯拉蒂纳', 'Slatina', '');
INSERT INTO `feel_province` VALUES (1342, 'SB', 'ROU', '斯洛博齐亚', 'Slobozia', '');
INSERT INTO `feel_province` VALUES (1343, 'SU', 'ROU', '苏恰瓦', 'Suceava', '');
INSERT INTO `feel_province` VALUES (1344, 'TA', 'ROU', '特尔戈维什泰', 'Targoviste', '');
INSERT INTO `feel_province` VALUES (1345, 'TM', 'ROU', '特尔古穆列什', 'Tirgu Mures', '');
INSERT INTO `feel_province` VALUES (1346, 'TJ', 'ROU', '特尔古日乌', 'Tirguj', '');
INSERT INTO `feel_province` VALUES (1347, 'TU', 'ROU', '图尔恰', 'Tulcea', '');
INSERT INTO `feel_province` VALUES (1348, 'VA', 'ROU', '瓦斯卢伊', 'Vaslui', '');
INSERT INTO `feel_province` VALUES (1349, 'SO', 'ROU', '锡比乌', 'Sibiu', '');
INSERT INTO `feel_province` VALUES (1350, 'IS', 'ROU', '雅西', 'Iasi', '');
INSERT INTO `feel_province` VALUES (1351, 'AD', 'ROU', '亚厉山德里亚', 'Alexandria', '');
INSERT INTO `feel_province` VALUES (1352, 'ZA', 'ROU', '扎勒乌', 'Zaleu', '');
INSERT INTO `feel_province` VALUES (1353, 'AS', 'MDG', '安齐拉纳纳', 'Anzilanana', '');
INSERT INTO `feel_province` VALUES (1354, 'FN', 'MDG', '菲亚纳兰楚阿', 'Fiana Lanchua', '');
INSERT INTO `feel_province` VALUES (1355, 'MJ', 'MDG', '马哈赞加', 'Mahajanga', '');
INSERT INTO `feel_province` VALUES (1356, 'AN', 'MDG', '塔那那利佛', 'Antananarivo', '');
INSERT INTO `feel_province` VALUES (1357, 'TM', 'MDG', '图阿马西拉', 'Tuamasila', '');
INSERT INTO `feel_province` VALUES (1358, 'TL', 'MDG', '图利亚拉', 'Turiala', '');
INSERT INTO `feel_province` VALUES (1359, 'ADD', 'MDV', '阿杜', 'Adu', '');
INSERT INTO `feel_province` VALUES (1360, 'AAD', 'MDV', '北阿里', 'Northern ali', '');
INSERT INTO `feel_province` VALUES (1361, 'THD', 'MDV', '北蒂拉杜马蒂', 'North Tila Dumaty', '');
INSERT INTO `feel_province` VALUES (1362, 'MAD', 'MDV', '北马洛斯马杜卢', 'North Maros Maduro', '');
INSERT INTO `feel_province` VALUES (1363, 'MLD', 'MDV', '北米拉杜马杜卢', 'North Mila Duma Dulu', '');
INSERT INTO `feel_province` VALUES (1364, 'NAD', 'MDV', '北尼兰杜', 'North Nylandu', '');
INSERT INTO `feel_province` VALUES (1365, 'HAD', 'MDV', '北苏瓦迪瓦', 'North Suvadiva', '');
INSERT INTO `feel_province` VALUES (1366, 'FAA', 'MDV', '法迪福卢', 'Fadifolu', '');
INSERT INTO `feel_province` VALUES (1367, 'FEA', 'MDV', '费利杜', 'Felidou', '');
INSERT INTO `feel_province` VALUES (1368, 'FMU', 'MDV', '福阿穆拉库', 'Foamulacu', '');
INSERT INTO `feel_province` VALUES (1369, 'HDH', 'MDV', '哈杜马蒂', 'Hadumati', '');
INSERT INTO `feel_province` VALUES (1370, 'KLH', 'MDV', '科卢马杜卢', 'Koluma dulu', '');
INSERT INTO `feel_province` VALUES (1371, 'MAL', 'MDV', '马累', 'Male', '');
INSERT INTO `feel_province` VALUES (1372, 'MAA', 'MDV', '马累岛', 'Male Island', '');
INSERT INTO `feel_province` VALUES (1373, 'MUA', 'MDV', '穆拉库', 'Muraku', '');
INSERT INTO `feel_province` VALUES (1374, 'AAU', 'MDV', '南阿里', 'South ali', '');
INSERT INTO `feel_province` VALUES (1375, 'THU', 'MDV', '南蒂拉杜马蒂', 'South tila dumaty', '');
INSERT INTO `feel_province` VALUES (1376, 'MAU', 'MDV', '南马洛斯马杜卢', 'South maros madulu', '');
INSERT INTO `feel_province` VALUES (1377, 'MLU', 'MDV', '南米拉杜马杜卢', 'South mila duma dulu', '');
INSERT INTO `feel_province` VALUES (1378, 'NAU', 'MDV', '南尼兰杜', 'Nylandandu', '');
INSERT INTO `feel_province` VALUES (1379, 'HAU', 'MDV', '南苏瓦迪瓦', 'South suvadiva', '');
INSERT INTO `feel_province` VALUES (1380, 'N', 'MWI', '北部区', 'Northern district', '');
INSERT INTO `feel_province` VALUES (1381, 'S', 'MWI', '南部区', 'Southern District', '');
INSERT INTO `feel_province` VALUES (1382, 'C', 'MWI', '中央区', 'Central District', '');
INSERT INTO `feel_province` VALUES (1383, 'PH', 'MYS', '槟榔屿', 'Penang', '');
INSERT INTO `feel_province` VALUES (1384, 'PS', 'MYS', '玻璃市', 'Glass city', '');
INSERT INTO `feel_province` VALUES (1385, 'TR', 'MYS', '丁加奴', 'Terengganu', '');
INSERT INTO `feel_province` VALUES (1386, 'KD', 'MYS', '吉打', 'Hit', '');
INSERT INTO `feel_province` VALUES (1387, 'KN', 'MYS', '吉兰丹', 'Kelantan', '');
INSERT INTO `feel_province` VALUES (1388, 'KL', 'MYS', '吉隆坡', 'Kuala Lumpur', '');
INSERT INTO `feel_province` VALUES (1389, 'ML', 'MYS', '马六甲', 'Malacca', '');
INSERT INTO `feel_province` VALUES (1390, 'LB', 'MYS', '纳闽', 'Labuan', '');
INSERT INTO `feel_province` VALUES (1391, 'PG', 'MYS', '彭亨', 'Pahang', '');
INSERT INTO `feel_province` VALUES (1392, 'PK', 'MYS', '霹雳', 'thunderbolt', '');
INSERT INTO `feel_province` VALUES (1393, 'JH', 'MYS', '柔佛', 'Johor', '');
INSERT INTO `feel_province` VALUES (1394, 'NS', 'MYS', '森美兰', 'Sen Meilan', '');
INSERT INTO `feel_province` VALUES (1395, 'SB', 'MYS', '沙巴', 'Sabah', '');
INSERT INTO `feel_province` VALUES (1396, 'SR', 'MYS', '沙捞越', 'Sarawak', '');
INSERT INTO `feel_province` VALUES (1397, 'SL', 'MYS', '雪兰莪', 'Selangor', '');
INSERT INTO `feel_province` VALUES (1398, 'CD', 'MLI', '巴马科首都区', 'Bamako Capital Region', '');
INSERT INTO `feel_province` VALUES (1399, 'KD', 'MLI', '基达尔', 'Kidal', '');
INSERT INTO `feel_province` VALUES (1400, 'GA', 'MLI', '加奥', 'Gao', '');
INSERT INTO `feel_province` VALUES (1401, 'KY', 'MLI', '卡伊', 'Kay', '');
INSERT INTO `feel_province` VALUES (1402, 'KL', 'MLI', '库利科罗', 'Kulikoro', '');
INSERT INTO `feel_province` VALUES (1403, 'MP', 'MLI', '莫普提', 'Mopti', '');
INSERT INTO `feel_province` VALUES (1404, 'SG', 'MLI', '塞古', 'Segu', '');
INSERT INTO `feel_province` VALUES (1405, 'TB', 'MLI', '通布图', 'Uniform map', '');
INSERT INTO `feel_province` VALUES (1406, 'SK', 'MLI', '锡卡索', 'Sikaso', '');
INSERT INTO `feel_province` VALUES (1407, 'AD', 'MRT', '阿德拉尔', 'Adrar', '');
INSERT INTO `feel_province` VALUES (1408, 'AS', 'MRT', '阿萨巴', 'Asaba', '');
INSERT INTO `feel_province` VALUES (1409, 'BR', 'MRT', '卜拉克纳', 'Brakner', '');
INSERT INTO `feel_province` VALUES (1410, 'HG', 'MRT', '东胡德', 'East Hood', '');
INSERT INTO `feel_province` VALUES (1411, 'GO', 'MRT', '戈尔戈勒', 'Gorgor', '');
INSERT INTO `feel_province` VALUES (1412, 'GM', 'MRT', '吉迪马卡', 'Gidimaca', '');
INSERT INTO `feel_province` VALUES (1413, 'DN', 'MRT', '努瓦迪布湾', 'Nouadhi Bay', '');
INSERT INTO `feel_province` VALUES (1414, 'NO', 'MRT', '努瓦克肖特特区', 'Nouakchott', '');
INSERT INTO `feel_province` VALUES (1415, 'TA', 'MRT', '塔甘特', 'Tagant', '');
INSERT INTO `feel_province` VALUES (1416, 'TR', 'MRT', '特拉扎', 'Traza', '');
INSERT INTO `feel_province` VALUES (1417, 'TZ', 'MRT', '提里斯宰穆尔', 'Tiris Zimmer', '');
INSERT INTO `feel_province` VALUES (1418, 'HC', 'MRT', '西胡德', 'West Hood', '');
INSERT INTO `feel_province` VALUES (1419, 'IN', 'MRT', '因希里', 'Inshiri', '');
INSERT INTO `feel_province` VALUES (1420, 'AR', 'USA', '阿肯色', 'Arkansas', '');
INSERT INTO `feel_province` VALUES (1421, 'AL', 'USA', '阿拉巴马', 'Alabama', '');
INSERT INTO `feel_province` VALUES (1422, 'AK', 'USA', '阿拉斯加', 'Alaska', '');
INSERT INTO `feel_province` VALUES (1423, 'ID', 'USA', '爱达荷', 'Idaho', '');
INSERT INTO `feel_province` VALUES (1424, 'IA', 'USA', '爱荷华', 'Iowa', '');
INSERT INTO `feel_province` VALUES (1425, 'ND', 'USA', '北达科他', 'North Dakota', '');
INSERT INTO `feel_province` VALUES (1426, 'NC', 'USA', '北卡罗来纳', 'North Carolina', '');
INSERT INTO `feel_province` VALUES (1427, 'PA', 'USA', '宾夕法尼亚', 'Pennsylvania', '');
INSERT INTO `feel_province` VALUES (1428, 'TX', 'USA', '德克萨斯', 'Texas', '');
INSERT INTO `feel_province` VALUES (1429, 'OH', 'USA', '俄亥俄', 'Ohio', '');
INSERT INTO `feel_province` VALUES (1430, 'OK', 'USA', '俄克拉荷马', 'Oklahoma', '');
INSERT INTO `feel_province` VALUES (1431, 'OR', 'USA', '俄勒冈', 'Oregon', '');
INSERT INTO `feel_province` VALUES (1432, 'FL', 'USA', '佛罗里达', 'Florida', '');
INSERT INTO `feel_province` VALUES (1433, 'VT', 'USA', '佛蒙特', 'Vermont', '');
INSERT INTO `feel_province` VALUES (1434, 'DC', 'USA', '哥伦比亚特区', 'District of Columbia', '');
INSERT INTO `feel_province` VALUES (1435, 'WA', 'USA', '华盛顿', 'Washington', '');
INSERT INTO `feel_province` VALUES (1436, 'WY', 'USA', '怀俄明', 'Wyoming', '');
INSERT INTO `feel_province` VALUES (1437, 'CA', 'USA', '加利福尼亚', 'California', '');
INSERT INTO `feel_province` VALUES (1438, 'KS', 'USA', '堪萨斯', 'Kansas', '');
INSERT INTO `feel_province` VALUES (1439, 'CT', 'USA', '康涅狄格', 'Connecticut', '');
INSERT INTO `feel_province` VALUES (1440, 'CO', 'USA', '科罗拉多', 'Colorado', '');
INSERT INTO `feel_province` VALUES (1441, 'KY', 'USA', '肯塔基', 'Kentucky', '');
INSERT INTO `feel_province` VALUES (1442, 'LA', 'USA', '路易斯安那', 'Louisiana', '');
INSERT INTO `feel_province` VALUES (1443, 'RI', 'USA', '罗德岛', 'Rhode Island', '');
INSERT INTO `feel_province` VALUES (1444, 'MD', 'USA', '马里兰', 'Maryland', '');
INSERT INTO `feel_province` VALUES (1445, 'MA', 'USA', '马萨诸塞', 'Massachusetts', '');
INSERT INTO `feel_province` VALUES (1446, 'MT', 'USA', '蒙大拿', 'Montana', '');
INSERT INTO `feel_province` VALUES (1447, 'MO', 'USA', '密苏里', 'Missouri', '');
INSERT INTO `feel_province` VALUES (1448, 'MS', 'USA', '密西西比', 'Mississippi', '');
INSERT INTO `feel_province` VALUES (1449, 'MI', 'USA', '密歇根', 'Michigan', '');
INSERT INTO `feel_province` VALUES (1450, 'ME', 'USA', '缅因', 'Maine', '');
INSERT INTO `feel_province` VALUES (1451, 'MN', 'USA', '明尼苏达', 'Minnesota', '');
INSERT INTO `feel_province` VALUES (1452, 'SD', 'USA', '南达科他', 'South Dakota', '');
INSERT INTO `feel_province` VALUES (1453, 'SC', 'USA', '南卡罗来纳', 'South Carolina', '');
INSERT INTO `feel_province` VALUES (1454, 'NE', 'USA', '内布拉斯加', 'Nebraska', '');
INSERT INTO `feel_province` VALUES (1455, 'NV', 'USA', '内华达', 'Nevada', '');
INSERT INTO `feel_province` VALUES (1456, 'NY', 'USA', '纽约', 'new York', '');
INSERT INTO `feel_province` VALUES (1457, 'DE', 'USA', '特拉华', 'Delaware', '');
INSERT INTO `feel_province` VALUES (1458, 'TN', 'USA', '田纳西', 'Tennessee', '');
INSERT INTO `feel_province` VALUES (1459, 'WI', 'USA', '威斯康星', 'Wisconsin', '');
INSERT INTO `feel_province` VALUES (1460, 'VA', 'USA', '维吉尼亚', 'Virginia', '');
INSERT INTO `feel_province` VALUES (1461, 'WV', 'USA', '西佛吉尼亚', 'West Virginia', '');
INSERT INTO `feel_province` VALUES (1462, 'HI', 'USA', '夏威夷', 'Hawaii', '');
INSERT INTO `feel_province` VALUES (1463, 'NH', 'USA', '新罕布什尔', 'New hampshire', '');
INSERT INTO `feel_province` VALUES (1464, 'NM', 'USA', '新墨西哥', 'New Mexico', '');
INSERT INTO `feel_province` VALUES (1465, 'NJ', 'USA', '新泽西', 'New Jersey', '');
INSERT INTO `feel_province` VALUES (1466, 'AZ', 'USA', '亚利桑那', 'Arizona', '');
INSERT INTO `feel_province` VALUES (1467, 'IL', 'USA', '伊利诺斯', 'Illinois', '');
INSERT INTO `feel_province` VALUES (1468, 'IN', 'USA', '印第安那', 'Indiana', '');
INSERT INTO `feel_province` VALUES (1469, 'UT', 'USA', '犹他', 'Utah', '');
INSERT INTO `feel_province` VALUES (1470, 'GA', 'USA', '佐治亚', 'Georgia', '');
INSERT INTO `feel_province` VALUES (1471, 'AAN', 'ASM', '阿纳', 'Ana', '');
INSERT INTO `feel_province` VALUES (1472, 'ATU', 'ASM', '阿图阿', 'Atua', '');
INSERT INTO `feel_province` VALUES (1473, 'AIT', 'ASM', '艾加伊勒泰', 'Aga Iltay', '');
INSERT INTO `feel_province` VALUES (1474, 'FAA', 'ASM', '法塞莱莱阿加', 'Faselele Aga', '');
INSERT INTO `feel_province` VALUES (1475, 'GFG', 'ASM', '加盖福毛加', 'Gambling', '');
INSERT INTO `feel_province` VALUES (1476, 'GMG', 'ASM', '加加埃毛加', 'Gajama', '');
INSERT INTO `feel_province` VALUES (1477, 'PAL', 'ASM', '帕劳利', 'Palau', '');
INSERT INTO `feel_province` VALUES (1478, 'SAT', 'ASM', '萨图帕伊泰阿', 'Satu Paitaya', '');
INSERT INTO `feel_province` VALUES (1479, 'SAV', 'ASM', '萨瓦伊岛', 'Savai Island', '');
INSERT INTO `feel_province` VALUES (1480, 'TUA', 'ASM', '图阿马萨加', 'Tua Masaga', '');
INSERT INTO `feel_province` VALUES (1481, 'VAF', 'ASM', '瓦奥福诺蒂', 'Vafonotti', '');
INSERT INTO `feel_province` VALUES (1482, 'VAI', 'ASM', '韦西加诺', 'Vesicano', '');
INSERT INTO `feel_province` VALUES (1483, 'UPO', 'ASM', '乌波卢岛', 'Upolu Island', '');
INSERT INTO `feel_province` VALUES (1484, '69', 'MNG', '巴彦洪格尔', 'Bayan Hunger', '');
INSERT INTO `feel_province` VALUES (1485, '71', 'MNG', '巴彦乌勒盖', 'Bayan Ullgue', '');
INSERT INTO `feel_province` VALUES (1486, '67', 'MNG', '布尔干', 'Bourges', '');
INSERT INTO `feel_province` VALUES (1487, '37', 'MNG', '达尔汗乌勒', 'Darhan Ull', '');
INSERT INTO `feel_province` VALUES (1488, '61', 'MNG', '东方', 'East', '');
INSERT INTO `feel_province` VALUES (1489, '63', 'MNG', '东戈壁', 'East Gobi', '');
INSERT INTO `feel_province` VALUES (1490, '35', 'MNG', '鄂尔浑', 'Orkhon', '');
INSERT INTO `feel_province` VALUES (1491, '65', 'MNG', '戈壁阿尔泰', 'Gobi Altai', '');
INSERT INTO `feel_province` VALUES (1492, '64', 'MNG', '戈壁苏木贝尔', 'Gobi Sumubel', '');
INSERT INTO `feel_province` VALUES (1493, '73', 'MNG', '后杭爱', 'Houhangai', '');
INSERT INTO `feel_province` VALUES (1494, '43', 'MNG', '科布多', 'Cobdo', '');
INSERT INTO `feel_province` VALUES (1495, '39', 'MNG', '肯特', 'Kent', '');
INSERT INTO `feel_province` VALUES (1496, '41', 'MNG', '库苏古尔', 'Kusugul', '');
INSERT INTO `feel_province` VALUES (1497, 'UMN', 'MNG', '南戈壁', 'South Gobi', '');
INSERT INTO `feel_province` VALUES (1498, 'UVO', 'MNG', '前杭爱', 'Qian Hangai', '');
INSERT INTO `feel_province` VALUES (1499, '49', 'MNG', '色楞格', 'Color grid', '');
INSERT INTO `feel_province` VALUES (1500, '51', 'MNG', '苏赫巴托尔', 'Sukhbator', '');
INSERT INTO `feel_province` VALUES (1501, '46', 'MNG', '乌布苏', 'Ubud', '');
INSERT INTO `feel_province` VALUES (1502, '1', 'MNG', '乌兰巴托市', 'Ulaanbaatar City', '');
INSERT INTO `feel_province` VALUES (1503, '57', 'MNG', '扎布汗', 'Zabhan', '');
INSERT INTO `feel_province` VALUES (1504, '59', 'MNG', '中戈壁', 'Middle Gobi', '');
INSERT INTO `feel_province` VALUES (1505, '47', 'MNG', '中央', 'central', '');
INSERT INTO `feel_province` VALUES (1506, 'DAC', 'BGD', '达卡', 'Dhaka', '');
INSERT INTO `feel_province` VALUES (1507, 'CGP', 'BGD', '吉大港', 'Chittagong', '');
INSERT INTO `feel_province` VALUES (1508, 'KHL', 'BGD', '库尔纳', 'Kurna', '');
INSERT INTO `feel_province` VALUES (1509, 'AR', 'PER', '阿雷基帕', 'Arequipa', '');
INSERT INTO `feel_province` VALUES (1510, 'AP', 'PER', '阿普里马克', 'Aprik', '');
INSERT INTO `feel_province` VALUES (1511, 'AY', 'PER', '阿亚库乔', 'Ayacucho', '');
INSERT INTO `feel_province` VALUES (1512, 'AN', 'PER', '安卡什', 'Ankas', '');
INSERT INTO `feel_province` VALUES (1513, 'JUL', 'PER', '胡利亚卡', 'Juliaca', '');
INSERT INTO `feel_province` VALUES (1514, 'JU', 'PER', '胡宁', 'Hu Ning', '');
INSERT INTO `feel_province` VALUES (1515, 'CJ', 'PER', '卡哈马卡', 'Cajamarca', '');
INSERT INTO `feel_province` VALUES (1516, 'CL', 'PER', '卡亚俄', 'Callao', '');
INSERT INTO `feel_province` VALUES (1517, 'CU', 'PER', '库斯科', 'Cusco', '');
INSERT INTO `feel_province` VALUES (1518, 'LD', 'PER', '拉利伯塔德', 'La Libertad', '');
INSERT INTO `feel_province` VALUES (1519, 'LY', 'PER', '兰巴耶克', 'Lambayek', '');
INSERT INTO `feel_province` VALUES (1520, 'LI', 'PER', '利马', 'Lima', '');
INSERT INTO `feel_province` VALUES (1521, 'LO', 'PER', '洛雷托', 'Loreto', '');
INSERT INTO `feel_province` VALUES (1522, 'MD', 'PER', '马德雷德迪奥斯', 'Madre de Dios', '');
INSERT INTO `feel_province` VALUES (1523, 'MO', 'PER', '莫克瓜', 'Mokgua', '');
INSERT INTO `feel_province` VALUES (1524, 'PA', 'PER', '帕斯科', 'Pasco', '');
INSERT INTO `feel_province` VALUES (1525, 'PI', 'PER', '皮乌拉', 'Piura', '');
INSERT INTO `feel_province` VALUES (1526, 'PU', 'PER', '普诺', 'Puno', '');
INSERT INTO `feel_province` VALUES (1527, 'CHM', 'PER', '钦博特', 'Chimbote', '');
INSERT INTO `feel_province` VALUES (1528, 'CHI', 'PER', '钦查阿尔塔', 'Chincha Alta', '');
INSERT INTO `feel_province` VALUES (1529, 'SM', 'PER', '圣马丁', 'Saint martin', '');
INSERT INTO `feel_province` VALUES (1530, 'SUL', 'PER', '苏拉纳', 'Surana', '');
INSERT INTO `feel_province` VALUES (1531, 'TA', 'PER', '塔克纳', 'Tacna', '');
INSERT INTO `feel_province` VALUES (1532, 'TU', 'PER', '通贝斯', 'Tongbes', '');
INSERT INTO `feel_province` VALUES (1533, 'HO', 'PER', '瓦努科', 'Vanuco', '');
INSERT INTO `feel_province` VALUES (1534, 'HV', 'PER', '万卡维利卡', 'Wankavilika', '');
INSERT INTO `feel_province` VALUES (1535, 'UC', 'PER', '乌卡亚利', 'Ucayali', '');
INSERT INTO `feel_province` VALUES (1536, 'AM', 'PER', '亚马孙', 'Amazon', '');
INSERT INTO `feel_province` VALUES (1537, 'IC', 'PER', '伊卡', 'Ica', '');
INSERT INTO `feel_province` VALUES (1538, 'BG', 'MMR', '勃固省', 'Bago Province', '');
INSERT INTO `feel_province` VALUES (1539, 'SH', 'MMR', '掸邦', 'Shan State', '');
INSERT INTO `feel_province` VALUES (1540, 'TN', 'MMR', '德林达依省', 'Delinday', '');
INSERT INTO `feel_province` VALUES (1541, 'KN', 'MMR', '克伦邦', 'Karen', '');
INSERT INTO `feel_province` VALUES (1542, 'KC', 'MMR', '克钦邦', 'Kachin State', '');
INSERT INTO `feel_province` VALUES (1543, 'KH', 'MMR', '克耶邦', 'Kayabang', '');
INSERT INTO `feel_province` VALUES (1544, 'MG', 'MMR', '马圭省', 'Magway', '');
INSERT INTO `feel_province` VALUES (1545, 'MD', 'MMR', '曼德勒省', 'Mandalay', '');
INSERT INTO `feel_province` VALUES (1546, 'MN', 'MMR', '孟邦', 'Mon State', '');
INSERT INTO `feel_province` VALUES (1547, 'CH', 'MMR', '钦邦', 'Chin State', '');
INSERT INTO `feel_province` VALUES (1548, 'RK', 'MMR', '若开邦', 'Rakhine State', '');
INSERT INTO `feel_province` VALUES (1549, 'SG', 'MMR', '实皆省', 'Sagaing Province', '');
INSERT INTO `feel_province` VALUES (1550, 'YG', 'MMR', '仰光省', 'Yangon Province', '');
INSERT INTO `feel_province` VALUES (1551, 'AY', 'MMR', '伊洛瓦底省', 'Irrawaddy', '');
INSERT INTO `feel_province` VALUES (1552, 'TGR', 'MAR', '丹吉尔', 'Tangier', '');
INSERT INTO `feel_province` VALUES (1553, 'TET', 'MAR', '得土安', 'Tetouan', '');
INSERT INTO `feel_province` VALUES (1554, 'FES', 'MAR', '非斯', 'Fes', '');
INSERT INTO `feel_province` VALUES (1555, 'CBL', 'MAR', '卡萨布兰卡', 'Casablanca', '');
INSERT INTO `feel_province` VALUES (1556, 'RSA', 'MAR', '拉巴特', 'Rabat', '');
INSERT INTO `feel_province` VALUES (1557, 'MRK', 'MAR', '马拉喀什', 'Marrakech', '');
INSERT INTO `feel_province` VALUES (1558, 'MKN', 'MAR', '梅克内斯', 'Meknes', '');
INSERT INTO `feel_province` VALUES (1559, 'OUJ', 'MAR', '乌季达', 'Ujda', '');
INSERT INTO `feel_province` VALUES (1560, 'WSH', 'MAR', '西撒哈拉', 'Western Sahara', '');
INSERT INTO `feel_province` VALUES (1561, 'AGU', 'MEX', '阿瓜斯卡连斯特', 'Aguascalist', '');
INSERT INTO `feel_province` VALUES (1562, 'ACA', 'MEX', '阿卡普尔科', 'Acapulco', '');
INSERT INTO `feel_province` VALUES (1563, 'HMO', 'MEX', '埃莫西约', 'Hermosillo', '');
INSERT INTO `feel_province` VALUES (1564, 'CAM', 'MEX', '埃佩切', 'Epeche', '');
INSERT INTO `feel_province` VALUES (1565, 'OBR', 'MEX', '奥夫雷贡城', 'Ovregun City', '');
INSERT INTO `feel_province` VALUES (1566, 'ORI', 'MEX', '奥里萨巴', 'Orissa', '');
INSERT INTO `feel_province` VALUES (1567, 'VHM', 'MEX', '巴利城', 'Bally City', '');
INSERT INTO `feel_province` VALUES (1568, 'PVR', 'MEX', '巴亚尔塔港', 'Puerto Vallarta', '');
INSERT INTO `feel_province` VALUES (1569, 'VSA', 'MEX', '比利亚埃尔莫萨', 'Villahermosa', '');
INSERT INTO `feel_province` VALUES (1570, 'PRH', 'MEX', '波萨里卡', 'Posarika', '');
INSERT INTO `feel_province` VALUES (1571, 'TIJ', 'MEX', '蒂华纳', 'Tijuana', '');
INSERT INTO `feel_province` VALUES (1572, 'DUR', 'MEX', '杜兰戈', 'Durango', '');
INSERT INTO `feel_province` VALUES (1573, 'ESE', 'MEX', '恩塞纳达', 'Ensenada', '');
INSERT INTO `feel_province` VALUES (1574, 'GDL', 'MEX', '瓜达拉哈拉', 'Guadalajara', '');
INSERT INTO `feel_province` VALUES (1575, 'GUA', 'MEX', '瓜纳华托', 'Guanajuato', '');
INSERT INTO `feel_province` VALUES (1576, 'JAL', 'MEX', '哈拉帕', 'Harapa', '');
INSERT INTO `feel_province` VALUES (1577, 'JUZ', 'MEX', '华雷斯', 'Juarez', '');
INSERT INTO `feel_province` VALUES (1578, 'BJU', 'MEX', '华雷斯港', 'Puerto Juarez', '');
INSERT INTO `feel_province` VALUES (1579, 'CAR', 'MEX', '卡门', 'Carmen', '');
INSERT INTO `feel_province` VALUES (1580, 'COL', 'MEX', '科利马', 'Colima', '');
INSERT INTO `feel_province` VALUES (1581, 'QUE', 'MEX', '克雷塔罗', 'Queretaro', '');
INSERT INTO `feel_province` VALUES (1582, 'CVC', 'MEX', '库埃纳瓦卡', 'Cuernavaca', '');
INSERT INTO `feel_province` VALUES (1583, 'CUL', 'MEX', '库利阿坎', 'Culiacan', '');
INSERT INTO `feel_province` VALUES (1584, 'COA', 'MEX', '夸察夸拉克斯', 'Kwachaurax', '');
INSERT INTO `feel_province` VALUES (1585, 'LAP', 'MEX', '拉巴斯', 'La Paz', '');
INSERT INTO `feel_province` VALUES (1586, 'LEN', 'MEX', '莱昂', 'Leon', '');
INSERT INTO `feel_province` VALUES (1587, 'REX', 'MEX', '雷诺萨', 'Reynosa', '');
INSERT INTO `feel_province` VALUES (1588, 'LMM', 'MEX', '洛斯莫奇斯', 'Los mochis', '');
INSERT INTO `feel_province` VALUES (1589, 'MZT', 'MEX', '马萨特兰', 'Mazatlan', '');
INSERT INTO `feel_province` VALUES (1590, 'MAM', 'MEX', '马塔莫罗斯', 'Matamoros', '');
INSERT INTO `feel_province` VALUES (1591, 'MID', 'MEX', '梅里达', 'Merida', '');
INSERT INTO `feel_province` VALUES (1592, 'LOV', 'MEX', '蒙克洛瓦', 'Monclova', '');
INSERT INTO `feel_province` VALUES (1593, 'MTY', 'MEX', '蒙特雷', 'Monterrey', '');
INSERT INTO `feel_province` VALUES (1594, 'MLM', 'MEX', '莫雷利亚', 'Morelia', '');
INSERT INTO `feel_province` VALUES (1595, 'MEX', 'MEX', '墨西哥城', 'Mexico City', '');
INSERT INTO `feel_province` VALUES (1596, 'MXL', 'MEX', '墨西卡利', 'Mexicali', '');
INSERT INTO `feel_province` VALUES (1597, 'NOG', 'MEX', '诺加莱斯', 'Nogales', '');
INSERT INTO `feel_province` VALUES (1598, 'PAC', 'MEX', '帕丘卡', 'Pachuca', '');
INSERT INTO `feel_province` VALUES (1599, 'PUE', 'MEX', '普埃布拉', 'Puebla', '');
INSERT INTO `feel_province` VALUES (1600, 'CHI', 'MEX', '奇尔潘辛戈', 'Chilpingingo', '');
INSERT INTO `feel_province` VALUES (1601, 'CHH', 'MEX', '奇瓦瓦', 'Chihuahua', '');
INSERT INTO `feel_province` VALUES (1602, 'CTM', 'MEX', '切图马尔', 'Chetumal', '');
INSERT INTO `feel_province` VALUES (1603, 'SLW', 'MEX', '萨尔蒂约', 'Saltillo', '');
INSERT INTO `feel_province` VALUES (1604, 'ZAC', 'MEX', '萨卡特卡斯', 'Zacatecas', '');
INSERT INTO `feel_province` VALUES (1605, 'CLY', 'MEX', '塞拉亚', 'Zelaya', '');
INSERT INTO `feel_province` VALUES (1606, 'SLP', 'MEX', '圣路易斯波托亚', 'San louis potoia', '');
INSERT INTO `feel_province` VALUES (1607, 'TAP', 'MEX', '塔帕丘拉', 'Tapachula', '');
INSERT INTO `feel_province` VALUES (1608, 'TAM', 'MEX', '坦皮科', 'Tampico', '');
INSERT INTO `feel_province` VALUES (1609, 'TLA', 'MEX', '特拉斯卡拉', 'Tlaxcala', '');
INSERT INTO `feel_province` VALUES (1610, 'TPQ', 'MEX', '特皮克', 'Tepic', '');
INSERT INTO `feel_province` VALUES (1611, 'TCN', 'MEX', '特瓦坎', 'Tehuacan', '');
INSERT INTO `feel_province` VALUES (1612, 'TGZ', 'MEX', '图斯特拉古铁雷斯', 'Tuxtla Gutierrez', '');
INSERT INTO `feel_province` VALUES (1613, 'TRC', 'MEX', '托雷翁', 'Torreon', '');
INSERT INTO `feel_province` VALUES (1614, 'TLC', 'MEX', '托卢卡', 'Toluca', '');
INSERT INTO `feel_province` VALUES (1615, 'OAX', 'MEX', '瓦哈卡', 'Oaxaca', '');
INSERT INTO `feel_province` VALUES (1616, 'VIC', 'MEX', '维多利亚城', 'Victoria City', '');
INSERT INTO `feel_province` VALUES (1617, 'VER', 'MEX', '韦拉克鲁斯', 'Veracruz', '');
INSERT INTO `feel_province` VALUES (1618, 'UPN', 'MEX', '乌鲁阿潘', 'Uruapan', '');
INSERT INTO `feel_province` VALUES (1619, 'NLE', 'MEX', '新拉雷多', 'New laredo', '');
INSERT INTO `feel_province` VALUES (1620, 'IRP', 'MEX', '伊拉普阿托', 'Irapuato', '');
INSERT INTO `feel_province` VALUES (1621, 'ER', 'NAM', '埃龙戈', 'Erongo', '');
INSERT INTO `feel_province` VALUES (1622, 'OW', 'NAM', '奥汉圭纳', 'Ohanguina', '');
INSERT INTO `feel_province` VALUES (1623, 'KV', 'NAM', '奥卡万戈', 'Okavango', '');
INSERT INTO `feel_province` VALUES (1624, 'OK', 'NAM', '奥马赫科', 'Omahko', '');
INSERT INTO `feel_province` VALUES (1625, 'OT', 'NAM', '奥姆沙蒂', 'Omsati', '');
INSERT INTO `feel_province` VALUES (1626, 'OJ', 'NAM', '奥乔宗蒂约巴', 'Ochozontijoba', '');
INSERT INTO `feel_province` VALUES (1627, 'ON', 'NAM', '奥沙纳', 'Osana', '');
INSERT INTO `feel_province` VALUES (1628, 'OO', 'NAM', '奥希科托', 'Oshikoto', '');
INSERT INTO `feel_province` VALUES (1629, 'HA', 'NAM', '哈达普', 'Hadap', '');
INSERT INTO `feel_province` VALUES (1630, 'KH', 'NAM', '霍马斯', 'Homas', '');
INSERT INTO `feel_province` VALUES (1631, 'KR', 'NAM', '卡拉斯', 'Callas', '');
INSERT INTO `feel_province` VALUES (1632, 'CA', 'NAM', '卡普里维', 'Caprivi', '');
INSERT INTO `feel_province` VALUES (1633, 'KU', 'NAM', '库内内', 'Kunene', '');
INSERT INTO `feel_province` VALUES (1634, 'UTN', 'ZAF', '阿平顿', 'Upington', '');
INSERT INTO `feel_province` VALUES (1635, 'MAY', 'ZAF', '艾利弗山', 'Mount Elif', '');
INSERT INTO `feel_province` VALUES (1636, 'PZB', 'ZAF', '彼德马里茨堡', 'Peter Maritzburg', '');
INSERT INTO `feel_province` VALUES (1637, 'PTG', 'ZAF', '彼德斯堡', 'Petersburg', '');
INSERT INTO `feel_province` VALUES (1638, 'PRY', 'ZAF', '比勒陀利亚', 'Pretoria', '');
INSERT INTO `feel_province` VALUES (1639, 'BIY', 'ZAF', '比索', 'peso', '');
INSERT INTO `feel_province` VALUES (1640, 'BDD', 'ZAF', '布雷达斯多普', 'Bredasdorp', '');
INSERT INTO `feel_province` VALUES (1641, 'BFN', 'ZAF', '布隆方丹', 'Bloemfontein', '');
INSERT INTO `feel_province` VALUES (1642, 'BHT', 'ZAF', '布隆克斯特斯普利特', 'Bronxster Split', '');
INSERT INTO `feel_province` VALUES (1643, 'DAA', 'ZAF', '德阿尔', 'Dear', '');
INSERT INTO `feel_province` VALUES (1644, 'DUR', 'ZAF', '德班', 'Durban', '');
INSERT INTO `feel_province` VALUES (1645, 'DUN', 'ZAF', '邓迪', 'Dundee', '');
INSERT INTO `feel_province` VALUES (1646, 'BAE', 'ZAF', '东巴克利', 'East Barkley', '');
INSERT INTO `feel_province` VALUES (1647, 'ELS', 'ZAF', '东伦敦', 'East london', '');
INSERT INTO `feel_province` VALUES (1648, 'VRU', 'ZAF', '弗雷堡', 'Freiburg', '');
INSERT INTO `feel_province` VALUES (1649, 'VGG', 'ZAF', '弗里尼欣', 'Frinisin', '');
INSERT INTO `feel_province` VALUES (1650, 'GBD', 'ZAF', '格罗布莱斯达尔', 'Grobresdal', '');
INSERT INTO `feel_province` VALUES (1651, 'GIY', 'ZAF', '基雅尼', 'Chijani', '');
INSERT INTO `feel_province` VALUES (1652, 'KIM', 'ZAF', '金伯利', 'Kimberley', '');
INSERT INTO `feel_province` VALUES (1653, 'CPT', 'ZAF', '开普敦', 'Cape Town', '');
INSERT INTO `feel_province` VALUES (1654, 'KXE', 'ZAF', '克莱克斯多普', 'Klerksdorp', '');
INSERT INTO `feel_province` VALUES (1655, 'KMH', 'ZAF', '库鲁曼', 'Kuruman', '');
INSERT INTO `feel_province` VALUES (1656, 'UTW', 'ZAF', '昆士敦', 'Queenstown', '');
INSERT INTO `feel_province` VALUES (1657, 'LAY', 'ZAF', '莱迪史密斯', 'Lady Smith', '');
INSERT INTO `feel_province` VALUES (1658, 'RFT', 'ZAF', '兰德方丹', 'Randfontein', '');
INSERT INTO `feel_province` VALUES (1659, 'RCB', 'ZAF', '理查兹湾', 'Richards Bay', '');
INSERT INTO `feel_province` VALUES (1660, 'RSB', 'ZAF', '利斯滕堡', 'Listenburg', '');
INSERT INTO `feel_province` VALUES (1661, 'MDB', 'ZAF', '米德尔堡', 'Middelburg', '');
INSERT INTO `feel_province` VALUES (1662, 'MZQ', 'ZAF', '姆库泽', 'Mkuze', '');
INSERT INTO `feel_province` VALUES (1663, 'MOO', 'ZAF', '穆里斯堡', 'Murisburg', '');
INSERT INTO `feel_province` VALUES (1664, 'NLP', 'ZAF', '内尔斯普雷特', 'Nelspruit', '');
INSERT INTO `feel_province` VALUES (1665, 'NYL', 'ZAF', '尼尔斯特隆', 'Neilstrom', '');
INSERT INTO `feel_province` VALUES (1666, 'NCS', 'ZAF', '纽卡斯尔', 'Newcastle', '');
INSERT INTO `feel_province` VALUES (1667, 'GRJ', 'ZAF', '乔治', 'George', '');
INSERT INTO `feel_province` VALUES (1668, 'SAS', 'ZAF', '萨索尔堡', 'Fort Sasol', '');
INSERT INTO `feel_province` VALUES (1669, 'ZEC', 'ZAF', '瑟孔达', 'Seconda', '');
INSERT INTO `feel_province` VALUES (1670, 'IXO', 'ZAF', '特克索波', 'Texopo', '');
INSERT INTO `feel_province` VALUES (1671, 'TPB', 'ZAF', '特隆普斯堡', 'Trompsburg', '');
INSERT INTO `feel_province` VALUES (1672, 'SBU', 'ZAF', '跳羚', 'Springbok', '');
INSERT INTO `feel_province` VALUES (1673, 'TLH', 'ZAF', '图拉马哈谢', 'Tula Maha', '');
INSERT INTO `feel_province` VALUES (1674, 'THY', 'ZAF', '托霍延杜', 'Tohoyandu', '');
INSERT INTO `feel_province` VALUES (1675, 'WSH', 'ZAF', '韦茨肖克', 'Wetzschock', '');
INSERT INTO `feel_province` VALUES (1676, 'WEL', 'ZAF', '韦尔科姆', 'Welkom', '');
INSERT INTO `feel_province` VALUES (1677, 'ULD', 'ZAF', '乌伦迪', 'Ulundi', '');
INSERT INTO `feel_province` VALUES (1678, 'UTT', 'ZAF', '乌姆塔塔', 'Umtata', '');
INSERT INTO `feel_province` VALUES (1679, 'WOR', 'ZAF', '伍斯特', 'Worcester', '');
INSERT INTO `feel_province` VALUES (1680, 'BEW', 'ZAF', '西博福特', 'West Beaufort', '');
INSERT INTO `feel_province` VALUES (1681, 'PSS', 'ZAF', '谢普斯通港', 'Port Shepstone', '');
INSERT INTO `feel_province` VALUES (1682, 'PLZ', 'ZAF', '伊丽莎白港', 'Port Elizabeth', '');
INSERT INTO `feel_province` VALUES (1683, 'JNB', 'ZAF', '约翰内斯堡', 'Johannesburg', '');
INSERT INTO `feel_province` VALUES (1684, 'BA', 'NPL', '巴格马蒂', 'Bagmati', '');
INSERT INTO `feel_province` VALUES (1685, 'DH', 'NPL', '道拉吉里', 'Dola Giri', '');
INSERT INTO `feel_province` VALUES (1686, 'GA', 'NPL', '甘达基', 'Gandaki', '');
INSERT INTO `feel_province` VALUES (1687, 'KO', 'NPL', '戈西', 'Gosi', '');
INSERT INTO `feel_province` VALUES (1688, 'KA', 'NPL', '格尔纳利', 'Gernali', '');
INSERT INTO `feel_province` VALUES (1689, 'JA', 'NPL', '贾纳克布尔', 'Janakpur', '');
INSERT INTO `feel_province` VALUES (1690, 'RA', 'NPL', '拉布蒂', 'Labuti', '');
INSERT INTO `feel_province` VALUES (1691, 'LU', 'NPL', '蓝毗尼', 'Lumbini', '');
INSERT INTO `feel_province` VALUES (1692, 'MA', 'NPL', '马哈卡利', 'Mahakari', '');
INSERT INTO `feel_province` VALUES (1693, 'ME', 'NPL', '梅吉', 'Meggie', '');
INSERT INTO `feel_province` VALUES (1694, 'NA', 'NPL', '纳拉亚尼', 'Narayani', '');
INSERT INTO `feel_province` VALUES (1695, 'BH', 'NPL', '佩里', 'Perry', '');
INSERT INTO `feel_province` VALUES (1696, 'SA', 'NPL', '萨加玛塔', 'Sagarmatha', '');
INSERT INTO `feel_province` VALUES (1697, 'SE', 'NPL', '塞蒂', 'Seti', '');
INSERT INTO `feel_province` VALUES (1698, 'ES', 'NIC', '埃斯特利', 'Esteli', '');
INSERT INTO `feel_province` VALUES (1699, 'AN', 'NIC', '北大西洋', 'North Atlantic', '');
INSERT INTO `feel_province` VALUES (1700, 'BO', 'NIC', '博阿科', '{\"timestamp\":\"2019-07-30T04:09:16.203+0000\",\"status\":500,\"error\":\"Internal Server Error\",\"message\":\"', '');
INSERT INTO `feel_province` VALUES (1701, 'GR', 'NIC', '格拉纳达', 'Granada', '');
INSERT INTO `feel_province` VALUES (1702, 'CA', 'NIC', '卡拉索', 'Carraso', '');
INSERT INTO `feel_province` VALUES (1703, 'LE', 'NIC', '莱昂', 'Leon', '');
INSERT INTO `feel_province` VALUES (1704, 'RV', 'NIC', '里瓦斯', 'Rivas', '');
INSERT INTO `feel_province` VALUES (1705, 'MD', 'NIC', '马德里斯', 'Madrid', '');
INSERT INTO `feel_province` VALUES (1706, 'MN', 'NIC', '马那瓜', 'Managua', '');
INSERT INTO `feel_province` VALUES (1707, 'MS', 'NIC', '马萨亚', 'Masaya', '');
INSERT INTO `feel_province` VALUES (1708, 'MT', 'NIC', '马塔加尔帕', 'Matagarpa', '');
INSERT INTO `feel_province` VALUES (1709, 'AS', 'NIC', '南大西洋', 'South Atlantic', '');
INSERT INTO `feel_province` VALUES (1710, 'CD', 'NIC', '奇南德加', 'Chinandaga', '');
INSERT INTO `feel_province` VALUES (1711, 'CT', 'NIC', '琼塔莱斯', 'Joan Tales', '');
INSERT INTO `feel_province` VALUES (1712, 'SJ', 'NIC', '圣胡安河', 'San Juan River', '');
INSERT INTO `feel_province` VALUES (1713, 'JI', 'NIC', '希诺特加', 'Sinotga', '');
INSERT INTO `feel_province` VALUES (1714, 'NS', 'NIC', '新塞哥维亚', 'New segovia', '');
INSERT INTO `feel_province` VALUES (1715, 'AJY', 'NER', '阿加德兹', 'Agadez', '');
INSERT INTO `feel_province` VALUES (1716, 'DIF', 'NER', '迪法', 'Difa', '');
INSERT INTO `feel_province` VALUES (1717, 'TIL', 'NER', '蒂拉贝里', 'Tillabelli', '');
INSERT INTO `feel_province` VALUES (1718, 'DSS', 'NER', '多索', 'Dosso', '');
INSERT INTO `feel_province` VALUES (1719, 'ZND', 'NER', '津德尔', 'Zinder', '');
INSERT INTO `feel_province` VALUES (1720, 'MFQ', 'NER', '马拉迪', 'Maradi', '');
INSERT INTO `feel_province` VALUES (1721, 'NIM', 'NER', '尼亚美市', 'Niamey', '');
INSERT INTO `feel_province` VALUES (1722, 'THZ', 'NER', '塔瓦', 'Tawa', '');
INSERT INTO `feel_province` VALUES (1723, 'ABV', 'NGA', '阿比亚', 'Abia', '');
INSERT INTO `feel_province` VALUES (1724, 'OGB', 'NGA', '奥博莫绍', 'Obomosau', '');
INSERT INTO `feel_province` VALUES (1725, 'KAN', 'NGA', '卡诺', 'Kano', '');
INSERT INTO `feel_province` VALUES (1726, 'LOS', 'NGA', '拉各斯', 'Lagos', '');
INSERT INTO `feel_province` VALUES (1727, 'IBA', 'NGA', '伊巴丹', 'Ibadan', '');
INSERT INTO `feel_province` VALUES (1728, '2', 'NOR', '阿克什胡斯', 'Akershus', '');
INSERT INTO `feel_province` VALUES (1729, '5', 'NOR', '奥普兰', 'Oppland', '');
INSERT INTO `feel_province` VALUES (1730, '3', 'NOR', '奥斯陆市', 'Oslo City', '');
INSERT INTO `feel_province` VALUES (1731, '17', 'NOR', '北特伦德拉格', 'North trundrag', '');
INSERT INTO `feel_province` VALUES (1732, '6', 'NOR', '布斯克吕', 'Busker', '');
INSERT INTO `feel_province` VALUES (1733, '9', 'NOR', '东阿格德尔', 'East Agder', '');
INSERT INTO `feel_province` VALUES (1734, '1', 'NOR', '东福尔', 'East Fore', '');
INSERT INTO `feel_province` VALUES (1735, '20', 'NOR', '芬马克', 'Finnmark', '');
INSERT INTO `feel_province` VALUES (1736, '4', 'NOR', '海德马克', 'Hedmark', '');
INSERT INTO `feel_province` VALUES (1737, '12', 'NOR', '霍达兰', 'Hordaland', '');
INSERT INTO `feel_province` VALUES (1738, '11', 'NOR', '罗加兰', 'Rogaran', '');
INSERT INTO `feel_province` VALUES (1739, '15', 'NOR', '默勒－鲁姆斯达尔', 'Moller-Romsdal', '');
INSERT INTO `feel_province` VALUES (1740, '16', 'NOR', '南特伦德拉格', 'South trundrag', '');
INSERT INTO `feel_province` VALUES (1741, '18', 'NOR', '诺尔兰', 'Nordland', '');
INSERT INTO `feel_province` VALUES (1742, '14', 'NOR', '松恩－菲尤拉讷', 'Sogn-Fyurane', '');
INSERT INTO `feel_province` VALUES (1743, '8', 'NOR', '泰勒马克', 'Telemark', '');
INSERT INTO `feel_province` VALUES (1744, '19', 'NOR', '特罗姆斯', 'Troms', '');
INSERT INTO `feel_province` VALUES (1745, '10', 'NOR', '西阿格德尔', 'West Agder', '');
INSERT INTO `feel_province` VALUES (1746, '7', 'NOR', '西福尔', 'West Fore', '');
INSERT INTO `feel_province` VALUES (1747, 'ALL', 'PRT', '滨海阿连特茹', 'Alentejo', '');
INSERT INTO `feel_province` VALUES (1748, 'PLT', 'PRT', '滨海皮尼亚尔', 'Pyal-sur-Mer', '');
INSERT INTO `feel_province` VALUES (1749, 'VDP', 'PRT', '波尔图', 'Porto', '');
INSERT INTO `feel_province` VALUES (1750, 'MDR', 'PRT', '杜罗', 'Douro', '');
INSERT INTO `feel_province` VALUES (1751, 'EDV', 'PRT', '恩特拉杜罗伏日', 'Entraduro', '');
INSERT INTO `feel_province` VALUES (1752, 'FAO', 'PRT', '法鲁', 'Faro', '');
INSERT INTO `feel_province` VALUES (1753, 'FUN', 'PRT', '丰沙尔', 'Funchal', '');
INSERT INTO `feel_province` VALUES (1754, 'CAV', 'PRT', '卡瓦多', 'Cavado', '');
INSERT INTO `feel_province` VALUES (1755, 'CLB', 'PRT', '科瓦贝拉', 'Kovabella', '');
INSERT INTO `feel_province` VALUES (1756, 'LIS', 'PRT', '里斯本', 'Lisbon', '');
INSERT INTO `feel_province` VALUES (1757, 'LTE', 'PRT', '利巴特茹', 'Libatru', '');
INSERT INTO `feel_province` VALUES (1758, 'MTE', 'PRT', '梅地奥特茹', 'Mediterrane', '');
INSERT INTO `feel_province` VALUES (1759, 'MLI', 'PRT', '米尼奥利马', 'Minio Lima', '');
INSERT INTO `feel_province` VALUES (1760, 'BIN', 'PRT', '内贝拉北', 'Nebel North', '');
INSERT INTO `feel_province` VALUES (1761, 'BIS', 'PRT', '内贝拉南', 'Nebelan', '');
INSERT INTO `feel_province` VALUES (1762, 'PIN', 'PRT', '内皮尼亚尔北', 'Endianal North', '');
INSERT INTO `feel_province` VALUES (1763, 'PIS', 'PRT', '内皮尼亚尔南', 'Neyananan', '');
INSERT INTO `feel_province` VALUES (1764, 'PDL', 'PRT', '蓬塔德尔加达', 'Ponta del Garda', '');
INSERT INTO `feel_province` VALUES (1765, 'PSE', 'PRT', '塞图巴尔半岛', 'Setubal Peninsula', '');
INSERT INTO `feel_province` VALUES (1766, 'SES', 'PRT', '山后', 'After the mountain', '');
INSERT INTO `feel_province` VALUES (1767, 'AAT', 'PRT', '上阿连特茹', 'Upper Alentejo', '');
INSERT INTO `feel_province` VALUES (1768, 'ATM', 'PRT', '上特拉斯山', 'Upper Tras', '');
INSERT INTO `feel_province` VALUES (1769, 'TAM', 'PRT', '塔梅加', 'Tamega', '');
INSERT INTO `feel_province` VALUES (1770, 'AES', 'PRT', '万福', 'Wanfu', '');
INSERT INTO `feel_province` VALUES (1771, 'OES', 'PRT', '西部', 'west', '');
INSERT INTO `feel_province` VALUES (1772, 'BAL', 'PRT', '下阿连特茹', 'Lower Alentejo', '');
INSERT INTO `feel_province` VALUES (1773, 'BVO', 'PRT', '下伏日', 'Under the sun', '');
INSERT INTO `feel_province` VALUES (1774, 'BMO', 'PRT', '下蒙德古', 'Lower Mondugu', '');
INSERT INTO `feel_province` VALUES (1775, 'ALC', 'PRT', '中阿连特茹', 'Alentejo', '');
INSERT INTO `feel_province` VALUES (1776, '38', 'JPN', '爱媛', 'Ehime', '');
INSERT INTO `feel_province` VALUES (1777, '23', 'JPN', '爱知', 'Aichi', '');
INSERT INTO `feel_province` VALUES (1778, '1', 'JPN', '北海道', 'Hokkaido', '');
INSERT INTO `feel_province` VALUES (1779, '28', 'JPN', '兵库', 'Hyogo', '');
INSERT INTO `feel_province` VALUES (1780, '47', 'JPN', '冲绳', 'Okinawa', '');
INSERT INTO `feel_province` VALUES (1781, '8', 'JPN', '茨城', 'Ibaraki', '');
INSERT INTO `feel_province` VALUES (1782, '27', 'JPN', '大阪', 'Osaka', '');
INSERT INTO `feel_province` VALUES (1783, '44', 'JPN', '大分', 'Oita', '');
INSERT INTO `feel_province` VALUES (1784, '32', 'JPN', '岛根', 'Shimane', '');
INSERT INTO `feel_province` VALUES (1785, '36', 'JPN', '徳岛', 'Tokuan', '');
INSERT INTO `feel_province` VALUES (1786, '13', 'JPN', '东京', 'Tokyo', '');
INSERT INTO `feel_province` VALUES (1787, '7', 'JPN', '福岛', 'Fukushima', '');
INSERT INTO `feel_province` VALUES (1788, '40', 'JPN', '福冈', 'Fukuoka', '');
INSERT INTO `feel_province` VALUES (1789, '18', 'JPN', '福井', 'Fukui', '');
INSERT INTO `feel_province` VALUES (1790, '16', 'JPN', '富山', 'Toyama', '');
INSERT INTO `feel_province` VALUES (1791, '33', 'JPN', '冈山', 'Okayama', '');
INSERT INTO `feel_province` VALUES (1792, '39', 'JPN', '高知', 'Kochi', '');
INSERT INTO `feel_province` VALUES (1793, '4', 'JPN', '宮城', 'Miyagi', '');
INSERT INTO `feel_province` VALUES (1794, '45', 'JPN', '宫崎', 'Shinozaki', '');
INSERT INTO `feel_province` VALUES (1795, '34', 'JPN', '广岛', 'Hiroshima', '');
INSERT INTO `feel_province` VALUES (1796, '30', 'JPN', '和歌山', 'Wakayama', '');
INSERT INTO `feel_province` VALUES (1797, '26', 'JPN', '京都', 'Kyoto', '');
INSERT INTO `feel_province` VALUES (1798, '22', 'JPN', '静冈', 'Shizuoka', '');
INSERT INTO `feel_province` VALUES (1799, '9', 'JPN', '枥木', 'Elm', '');
INSERT INTO `feel_province` VALUES (1800, '46', 'JPN', '鹿儿岛', 'Kagoshima', '');
INSERT INTO `feel_province` VALUES (1801, '29', 'JPN', '奈良', 'Nara', '');
INSERT INTO `feel_province` VALUES (1802, '31', 'JPN', '鸟取', 'Tottori', '');
INSERT INTO `feel_province` VALUES (1803, '21', 'JPN', '岐阜', '岐阜', '');
INSERT INTO `feel_province` VALUES (1804, '11', 'JPN', '埼玉', 'Saitama', '');
INSERT INTO `feel_province` VALUES (1805, '12', 'JPN', '千叶', 'Chiba', '');
INSERT INTO `feel_province` VALUES (1806, '2', 'JPN', '青森', 'Aomori', '');
INSERT INTO `feel_province` VALUES (1807, '5', 'JPN', '秋田', 'Akita', '');
INSERT INTO `feel_province` VALUES (1808, '10', 'JPN', '群马', 'Gunma', '');
INSERT INTO `feel_province` VALUES (1809, '24', 'JPN', '三重', 'triple', '');
INSERT INTO `feel_province` VALUES (1810, '35', 'JPN', '山口', 'Yamaguchi', '');
INSERT INTO `feel_province` VALUES (1811, '19', 'JPN', '山梨', 'Yamanashi', '');
INSERT INTO `feel_province` VALUES (1812, '6', 'JPN', '山形', 'Yamagata', '');
INSERT INTO `feel_province` VALUES (1813, '14', 'JPN', '神奈川', 'Kanagawa', '');
INSERT INTO `feel_province` VALUES (1814, '17', 'JPN', '石川', 'Ishikawa', '');
INSERT INTO `feel_province` VALUES (1815, '37', 'JPN', '香川', 'Kagawa', '');
INSERT INTO `feel_province` VALUES (1816, '15', 'JPN', '新潟', '{\"timestamp\":\"2019-07-30T04:23:04.844+0000\",\"status\":500,\"error\":\"Internal Server Error\",\"message\":\"', '');
INSERT INTO `feel_province` VALUES (1817, '43', 'JPN', '熊本', 'Kumamoto', '');
INSERT INTO `feel_province` VALUES (1818, '3', 'JPN', '岩手', 'Iwate', '');
INSERT INTO `feel_province` VALUES (1819, '42', 'JPN', '长崎', 'Nagasaki', '');
INSERT INTO `feel_province` VALUES (1820, '20', 'JPN', '长野', 'Nagano', '');
INSERT INTO `feel_province` VALUES (1821, '25', 'JPN', '滋贺', 'Shiga', '');
INSERT INTO `feel_province` VALUES (1822, '41', 'JPN', '佐贺', 'Saga', '');
INSERT INTO `feel_province` VALUES (1823, 'BD', 'SWE', '北博滕', 'Norboten', '');
INSERT INTO `feel_province` VALUES (1824, 'K', 'SWE', '布莱金厄', 'Blekinge', '');
INSERT INTO `feel_province` VALUES (1825, 'DLN', 'SWE', '达拉纳', 'Dalarna', '');
INSERT INTO `feel_province` VALUES (1826, 'UGL', 'SWE', '东约特兰', 'East Yotland', '');
INSERT INTO `feel_province` VALUES (1827, 'T', 'SWE', '厄勒布鲁', 'Orebro', '');
INSERT INTO `feel_province` VALUES (1828, 'I', 'SWE', '哥得兰', 'Gotland', '');
INSERT INTO `feel_province` VALUES (1829, 'N', 'SWE', '哈兰', 'Hallan', '');
INSERT INTO `feel_province` VALUES (1830, 'H', 'SWE', '卡尔马', 'Kalmar', '');
INSERT INTO `feel_province` VALUES (1831, 'G', 'SWE', '克鲁努贝里', 'Kronoberg', '');
INSERT INTO `feel_province` VALUES (1832, 'D', 'SWE', '南曼兰', 'South Manlan', '');
INSERT INTO `feel_province` VALUES (1833, 'AB', 'SWE', '斯德哥尔摩', 'Stockholm', '');
INSERT INTO `feel_province` VALUES (1834, 'M', 'SWE', '斯科耐', 'Sco', '');
INSERT INTO `feel_province` VALUES (1835, 'S', 'SWE', '韦姆兰', 'Vemran', '');
INSERT INTO `feel_province` VALUES (1836, 'C', 'SWE', '乌普萨拉', 'Uppsala', '');
INSERT INTO `feel_province` VALUES (1837, 'AC', 'SWE', '西博滕', 'West Botten', '');
INSERT INTO `feel_province` VALUES (1838, 'U', 'SWE', '西曼兰', 'Westmanland', '');
INSERT INTO `feel_province` VALUES (1839, 'Y', 'SWE', '西诺尔兰', 'West Norrland', '');
INSERT INTO `feel_province` VALUES (1840, 'O', 'SWE', '西约特兰', 'West Yotland', '');
INSERT INTO `feel_province` VALUES (1841, 'F', 'SWE', '延雪平', 'Jonkoping', '');
INSERT INTO `feel_province` VALUES (1842, 'X', 'SWE', '耶夫勒堡', 'Gavleborg', '');
INSERT INTO `feel_province` VALUES (1843, 'Z', 'SWE', '耶姆特兰', 'Jemland', '');
INSERT INTO `feel_province` VALUES (1844, 'AG', 'CHE', '阿尔高', 'Allgäu', '');
INSERT INTO `feel_province` VALUES (1845, 'BS', 'CHE', '巴塞尔城市', 'Basel City', '');
INSERT INTO `feel_province` VALUES (1846, 'BL', 'CHE', '巴塞尔乡村', 'Basel countryside', '');
INSERT INTO `feel_province` VALUES (1847, 'BE', 'CHE', '伯尔尼', 'Bern', '');
INSERT INTO `feel_province` VALUES (1848, 'ZG', 'CHE', '楚格', 'Zug', '');
INSERT INTO `feel_province` VALUES (1849, 'FR', 'CHE', '弗里堡', 'Fribourg', '');
INSERT INTO `feel_province` VALUES (1850, 'GL', 'CHE', '格拉鲁斯', 'Glarus', '');
INSERT INTO `feel_province` VALUES (1851, 'GR', 'CHE', '格劳宾登', 'Graubunden', '');
INSERT INTO `feel_province` VALUES (1852, 'LU', 'CHE', '卢塞恩', 'Lucerne', '');
INSERT INTO `feel_province` VALUES (1853, 'LA', 'CHE', '洛桑', 'Lausanne', '');
INSERT INTO `feel_province` VALUES (1854, 'NE', 'CHE', '纳沙泰尔', 'Neuchâtel', '');
INSERT INTO `feel_province` VALUES (1855, 'AI', 'CHE', '内阿彭策尔', 'Appenzell', '');
INSERT INTO `feel_province` VALUES (1856, 'GE', 'CHE', '日内瓦', 'Geneva', '');
INSERT INTO `feel_province` VALUES (1857, 'JU', 'CHE', '汝拉', 'Gala', '');
INSERT INTO `feel_province` VALUES (1858, 'SH', 'CHE', '沙夫豪森', 'Schaffhausen', '');
INSERT INTO `feel_province` VALUES (1859, 'OW', 'CHE', '上瓦尔登', 'Oberwalden', '');
INSERT INTO `feel_province` VALUES (1860, 'SG', 'CHE', '圣加仑', 'St. Gallen', '');
INSERT INTO `feel_province` VALUES (1861, 'SZ', 'CHE', '施维茨', 'Schwitz', '');
INSERT INTO `feel_province` VALUES (1862, 'ZH', 'CHE', '苏黎世', 'Zurich', '');
INSERT INTO `feel_province` VALUES (1863, 'SO', 'CHE', '索洛图恩', 'Solothurn', '');
INSERT INTO `feel_province` VALUES (1864, 'TI', 'CHE', '提契诺', 'Ticino', '');
INSERT INTO `feel_province` VALUES (1865, 'TG', 'CHE', '图尔高', 'Tourco', '');
INSERT INTO `feel_province` VALUES (1866, 'VS', 'CHE', '瓦莱', 'Valle', '');
INSERT INTO `feel_province` VALUES (1867, 'AR', 'CHE', '外阿彭策尔', 'Appenzell', '');
INSERT INTO `feel_province` VALUES (1868, 'VD', 'CHE', '沃', 'fertile', '');
INSERT INTO `feel_province` VALUES (1869, 'UR', 'CHE', '乌里', 'Uri', '');
INSERT INTO `feel_province` VALUES (1870, 'NW', 'CHE', '下瓦尔登', 'Lower walden', '');
INSERT INTO `feel_province` VALUES (1871, 'APO', 'SLV', '阿波帕', 'Apopa', '');
INSERT INTO `feel_province` VALUES (1872, 'AH', 'SLV', '阿瓦查潘', 'Avachapan', '');
INSERT INTO `feel_province` VALUES (1873, 'LI', 'SLV', '滨海', 'Coast', '');
INSERT INTO `feel_province` VALUES (1874, 'CH', 'SLV', '查拉特南戈', 'Charatnango', '');
INSERT INTO `feel_province` VALUES (1875, 'DE', 'SLV', '德尔加多', 'Delgado', '');
INSERT INTO `feel_province` VALUES (1876, 'KN', 'SLV', '基埃恩特姆', 'Kientem', '');
INSERT INTO `feel_province` VALUES (1877, 'CA', 'SLV', '卡瓦尼亚斯', 'Cabañas', '');
INSERT INTO `feel_province` VALUES (1878, 'CU', 'SLV', '库斯卡特兰', 'Cuscatlan', '');
INSERT INTO `feel_province` VALUES (1879, 'PZ', 'SLV', '拉巴斯', 'La Paz', '');
INSERT INTO `feel_province` VALUES (1880, 'LB', 'SLV', '拉利伯塔德', 'La Libertad', '');
INSERT INTO `feel_province` VALUES (1881, 'UN', 'SLV', '拉乌尼翁', 'La Union', '');
INSERT INTO `feel_province` VALUES (1882, 'MEJ', 'SLV', '梅基卡诺斯', 'Mekicanos', '');
INSERT INTO `feel_province` VALUES (1883, 'MO', 'SLV', '莫拉桑', 'Morazan', '');
INSERT INTO `feel_province` VALUES (1884, 'SA', 'SLV', '圣安娜', 'Santa Ana', '');
INSERT INTO `feel_province` VALUES (1885, 'SM', 'SLV', '圣米格尔', 'San Miguel', '');
INSERT INTO `feel_province` VALUES (1886, 'SS', 'SLV', '圣萨尔瓦多', 'San salvador', '');
INSERT INTO `feel_province` VALUES (1887, 'SV', 'SLV', '圣维森特', 'San Vicente', '');
INSERT INTO `feel_province` VALUES (1888, 'SO', 'SLV', '松索纳特', 'Sonsonate', '');
INSERT INTO `feel_province` VALUES (1889, 'SOY', 'SLV', '索亚潘戈', 'Soyapango', '');
INSERT INTO `feel_province` VALUES (1890, 'WN', 'SLV', '韦莱恩萨斯', 'Veleansas', '');
INSERT INTO `feel_province` VALUES (1891, 'US', 'SLV', '乌苏卢坦', 'Usulutan', '');
INSERT INTO `feel_province` VALUES (1892, 'IL', 'SLV', '伊洛潘戈', 'Ilopango', '');
INSERT INTO `feel_province` VALUES (1893, 'CS', 'SLV', '中南', 'Central South', '');
INSERT INTO `feel_province` VALUES (1894, 'BEG', 'SCG', '贝尔格莱德', 'Belgrade', '');
INSERT INTO `feel_province` VALUES (1895, 'POD', 'SCG', '波德戈里察', 'Podgorica', '');
INSERT INTO `feel_province` VALUES (1896, 'KGV', 'SCG', '克拉古涅瓦茨', 'Kragunovac', '');
INSERT INTO `feel_province` VALUES (1897, 'INI', 'SCG', '尼什', 'Nis', '');
INSERT INTO `feel_province` VALUES (1898, 'NVS', 'SCG', '诺维萨德', 'Novi Sad', '');
INSERT INTO `feel_province` VALUES (1899, 'PRN', 'SCG', '普里什蒂纳', 'Pristina', '');
INSERT INTO `feel_province` VALUES (1900, 'SUB', 'SCG', '苏博蒂察', 'Subotica', '');
INSERT INTO `feel_province` VALUES (1901, 'ZEM', 'SCG', '泽蒙', 'Zemen', '');
INSERT INTO `feel_province` VALUES (1902, 'N', 'SLE', '北部', 'North', '');
INSERT INTO `feel_province` VALUES (1903, 'E', 'SLE', '东部', 'east', '');
INSERT INTO `feel_province` VALUES (1904, 'S', 'SLE', '南部', 'Southern', '');
INSERT INTO `feel_province` VALUES (1905, 'W', 'SLE', '西部区', 'Western District', '');
INSERT INTO `feel_province` VALUES (1906, 'DA', 'SEN', '达喀尔', 'Dakar', '');
INSERT INTO `feel_province` VALUES (1907, 'FA', 'SEN', '法蒂克', 'Fatik', '');
INSERT INTO `feel_province` VALUES (1908, 'ZI', 'SEN', '济金绍尔', 'Zijinsauer', '');
INSERT INTO `feel_province` VALUES (1909, 'TH', 'SEN', '捷斯', 'Jies', '');
INSERT INTO `feel_province` VALUES (1910, 'DI', 'SEN', '久尔贝勒', 'Jurber', '');
INSERT INTO `feel_province` VALUES (1911, 'KA', 'SEN', '考拉克', 'Korak', '');
INSERT INTO `feel_province` VALUES (1912, 'KO', 'SEN', '科尔达', 'Korda', '');
INSERT INTO `feel_province` VALUES (1913, 'LO', 'SEN', '卢加', 'Luga', '');
INSERT INTO `feel_province` VALUES (1914, 'MA', 'SEN', '马塔姆', 'Matam', '');
INSERT INTO `feel_province` VALUES (1915, 'SL', 'SEN', '圣路易', 'Saint Louis', '');
INSERT INTO `feel_province` VALUES (1916, 'TA', 'SEN', '坦巴昆达', 'Tambakunda', '');
INSERT INTO `feel_province` VALUES (1917, '4', 'CYP', '法马古斯塔', 'Famagusta', '');
INSERT INTO `feel_province` VALUES (1918, '6', 'CYP', '凯里尼亚', 'Kyrenia', '');
INSERT INTO `feel_province` VALUES (1919, '3', 'CYP', '拉纳卡', 'Larnaca', '');
INSERT INTO `feel_province` VALUES (1920, '2', 'CYP', '利马索尔', 'Limassol', '');
INSERT INTO `feel_province` VALUES (1921, '1', 'CYP', '尼科西亚', 'Nicosia', '');
INSERT INTO `feel_province` VALUES (1922, '5', 'CYP', '帕福斯', 'Paphos', '');
INSERT INTO `feel_province` VALUES (1923, 'ARA', 'SAU', '阿尔阿尔', 'Alal', '');
INSERT INTO `feel_province` VALUES (1924, 'AHB', 'SAU', '艾卜哈', 'Abha', '');
INSERT INTO `feel_province` VALUES (1925, 'BH', 'SAU', '巴哈', 'Baja', '');
INSERT INTO `feel_province` VALUES (1926, 'BUR', 'SAU', '布赖代', 'Buray', '');
INSERT INTO `feel_province` VALUES (1927, 'DAM', 'SAU', '达曼', 'Dammam', '');
INSERT INTO `feel_province` VALUES (1928, 'HBT', 'SAU', '哈费尔巴廷', 'Havelbatin', '');
INSERT INTO `feel_province` VALUES (1929, 'HL', 'SAU', '哈伊勒', 'Hajle', '');
INSERT INTO `feel_province` VALUES (1930, 'KMX', 'SAU', '海米斯穆谢特', 'Hemis Muschet', '');
INSERT INTO `feel_province` VALUES (1931, 'AKH', 'SAU', '海耶', 'Haye', '');
INSERT INTO `feel_province` VALUES (1932, 'HFF', 'SAU', '胡富夫', 'Hu Fufu', '');
INSERT INTO `feel_province` VALUES (1933, 'JED', 'SAU', '吉达', 'Jeddah', '');
INSERT INTO `feel_province` VALUES (1934, 'JZ', 'SAU', '吉赞', 'Jizan', '');
INSERT INTO `feel_province` VALUES (1935, 'RD', 'SAU', '利雅得', 'Riyadh', '');
INSERT INTO `feel_province` VALUES (1936, 'MED', 'SAU', '麦地那', 'Medina', '');
INSERT INTO `feel_province` VALUES (1937, 'ML', 'SAU', '麦加', 'Mecca', '');
INSERT INTO `feel_province` VALUES (1938, 'MBR', 'SAU', '姆巴拉兹', 'Mbalaz', '');
INSERT INTO `feel_province` VALUES (1939, 'NR', 'SAU', '纳季兰', 'Najran', '');
INSERT INTO `feel_province` VALUES (1940, 'SAK', 'SAU', '塞卡卡', 'Sekaka', '');
INSERT INTO `feel_province` VALUES (1941, 'TB', 'SAU', '塔布克', 'Tabuk', '');
INSERT INTO `feel_province` VALUES (1942, 'TAR', 'SAU', '塔伊夫', 'Taif', '');
INSERT INTO `feel_province` VALUES (1943, 'YNB', 'SAU', '延布', 'Yanbu', '');
INSERT INTO `feel_province` VALUES (1944, 'JBI', 'SAU', '朱拜勒', 'Jubail', '');
INSERT INTO `feel_province` VALUES (1945, 'ADP', 'LKA', '阿努拉德普勒', 'Anuradhapura', '');
INSERT INTO `feel_province` VALUES (1946, 'AMP', 'LKA', '安帕赖', 'Amapai', '');
INSERT INTO `feel_province` VALUES (1947, 'BAD', 'LKA', '巴杜勒', 'Badul', '');
INSERT INTO `feel_province` VALUES (1948, 'BTC', 'LKA', '拜蒂克洛', 'Batticalo', '');
INSERT INTO `feel_province` VALUES (1949, 'POL', 'LKA', '波隆纳鲁沃', 'Polonnaruwa', '');
INSERT INTO `feel_province` VALUES (1950, 'HBA', 'LKA', '汉班托特', 'Hambant', '');
INSERT INTO `feel_province` VALUES (1951, 'KIL', 'LKA', '基里诺奇', 'Kirinoch', '');
INSERT INTO `feel_province` VALUES (1952, 'GAL', 'LKA', '加勒', 'Galle', '');
INSERT INTO `feel_province` VALUES (1953, 'GAM', 'LKA', '加姆珀哈', 'Gampaha', '');
INSERT INTO `feel_province` VALUES (1954, 'JAF', 'LKA', '贾夫纳', 'Jaffna', '');
INSERT INTO `feel_province` VALUES (1955, 'KLT', 'LKA', '卡卢特勒', 'Kalutler', '');
INSERT INTO `feel_province` VALUES (1956, 'KEG', 'LKA', '凯格勒', 'Kegler', '');
INSERT INTO `feel_province` VALUES (1957, 'KAN', 'LKA', '康提', 'Kandy', '');
INSERT INTO `feel_province` VALUES (1958, 'CMB', 'LKA', '科伦坡', 'Colombo', '');
INSERT INTO `feel_province` VALUES (1959, 'KUR', 'LKA', '库鲁内格勒', 'Kurunegrad', '');
INSERT INTO `feel_province` VALUES (1960, 'RAT', 'LKA', '拉特纳普勒', 'Ratnapur', '');
INSERT INTO `feel_province` VALUES (1961, 'MAN', 'LKA', '马纳尔', 'Manal', '');
INSERT INTO `feel_province` VALUES (1962, 'MAT', 'LKA', '马特莱', 'Matale', '');
INSERT INTO `feel_province` VALUES (1963, 'MAA', 'LKA', '马特勒', 'Matler', '');
INSERT INTO `feel_province` VALUES (1964, 'MON', 'LKA', '莫讷勒格勒', 'Monne gle', '');
INSERT INTO `feel_province` VALUES (1965, 'MUL', 'LKA', '穆莱蒂武', 'Muletiwu', '');
INSERT INTO `feel_province` VALUES (1966, 'NUE', 'LKA', '努沃勒埃利耶', 'Nuwara Eliya', '');
INSERT INTO `feel_province` VALUES (1967, 'PUT', 'LKA', '普塔勒姆', 'Puttalam', '');
INSERT INTO `feel_province` VALUES (1968, 'TRR', 'LKA', '亭可马里', 'Trincomal', '');
INSERT INTO `feel_province` VALUES (1969, 'VAV', 'LKA', '瓦武尼亚', 'Vavonia', '');
INSERT INTO `feel_province` VALUES (1970, 'BBY', 'SVK', '班斯卡比斯特里察', 'Banska bistrica', '');
INSERT INTO `feel_province` VALUES (1971, 'BTS', 'SVK', '布拉迪斯拉发', 'Bratislava', '');
INSERT INTO `feel_province` VALUES (1972, 'KOR', 'SVK', '科希策', 'Kosice', '');
INSERT INTO `feel_province` VALUES (1973, 'NRA', 'SVK', '尼特拉', 'Nitra', '');
INSERT INTO `feel_province` VALUES (1974, 'POV', 'SVK', '普雷绍夫', 'Presov', '');
INSERT INTO `feel_province` VALUES (1975, 'RIL', 'SVK', '日利纳', 'Zilina', '');
INSERT INTO `feel_province` VALUES (1976, 'TNA', 'SVK', '特尔纳瓦', 'Trnava', '');
INSERT INTO `feel_province` VALUES (1977, 'TRE', 'SVK', '特伦钦', 'Trenchin', '');
INSERT INTO `feel_province` VALUES (1978, 'OKR', 'SVN', '奥巴尔诺克拉', 'Obarnokra', '');
INSERT INTO `feel_province` VALUES (1979, 'OSR', 'SVN', '奥斯雷德涅斯洛文', 'Osreden Nesloven', '');
INSERT INTO `feel_province` VALUES (1980, 'POD', 'SVN', '波德拉夫', 'Podrav', '');
INSERT INTO `feel_province` VALUES (1981, 'POM', 'SVN', '波穆尔', 'Pomor', '');
INSERT INTO `feel_province` VALUES (1982, 'DLJ', 'SVN', '多雷尼', 'Doreni', '');
INSERT INTO `feel_province` VALUES (1983, 'GSZ', 'SVN', '戈雷尼', 'Goreni', '');
INSERT INTO `feel_province` VALUES (1984, 'GSK', 'SVN', '戈里', 'Puli', '');
INSERT INTO `feel_province` VALUES (1985, 'KOR', 'SVN', '科洛', 'Colo', '');
INSERT INTO `feel_province` VALUES (1986, 'NKR', 'SVN', '诺特拉尼', 'Notrani', '');
INSERT INTO `feel_province` VALUES (1987, 'SAV', 'SVN', '萨维尼', 'Savigny', '');
INSERT INTO `feel_province` VALUES (1988, 'SPO', 'SVN', '斯波德涅波萨夫', 'Spodeni Posaf', '');
INSERT INTO `feel_province` VALUES (1989, 'ZAS', 'SVN', '扎萨夫', 'Zasaf', '');
INSERT INTO `feel_province` VALUES (1990, 'ASH', 'SDN', '北部', 'North', '');
INSERT INTO `feel_province` VALUES (1991, 'SIS', 'SDN', '赤道', 'equatorial', '');
INSERT INTO `feel_province` VALUES (1992, 'SDA', 'SDN', '达尔富尔', 'Darfur', '');
INSERT INTO `feel_province` VALUES (1993, 'SHA', 'SDN', '东部', 'east', '');
INSERT INTO `feel_province` VALUES (1994, 'SBG', 'SDN', '加扎勒河', 'Ghazal', '');
INSERT INTO `feel_province` VALUES (1995, 'KRT', 'SDN', '喀土穆', 'Khartoum', '');
INSERT INTO `feel_province` VALUES (1996, 'GKU', 'SDN', '科尔多凡', 'Kordofan', '');
INSERT INTO `feel_province` VALUES (1997, 'ANB', 'SDN', '上尼罗', 'Upper Nile', '');
INSERT INTO `feel_province` VALUES (1998, 'WDH', 'SDN', '中部', 'Central', '');
INSERT INTO `feel_province` VALUES (1999, 'BR', 'SUR', '布罗科蓬多', 'Brocopondo', '');
INSERT INTO `feel_province` VALUES (2000, 'CR', 'SUR', '科罗尼', 'Koroni', '');
INSERT INTO `feel_province` VALUES (2001, 'CM', 'SUR', '科默韦讷', 'Comerwane', '');
INSERT INTO `feel_province` VALUES (2002, 'MA', 'SUR', '马罗韦讷', 'Marovenne', '');
INSERT INTO `feel_province` VALUES (2003, 'NI', 'SUR', '尼克里', 'Nickley', '');
INSERT INTO `feel_province` VALUES (2004, 'PA', 'SUR', '帕拉', 'Para', '');
INSERT INTO `feel_province` VALUES (2005, 'PM', 'SUR', '帕拉马里博', 'Paramaribo', '');
INSERT INTO `feel_province` VALUES (2006, 'SA', 'SUR', '萨拉马卡', 'Saramaca', '');
INSERT INTO `feel_province` VALUES (2007, 'WA', 'SUR', '瓦尼卡', 'Wanika', '');
INSERT INTO `feel_province` VALUES (2008, 'SI', 'SUR', '西帕里韦尼', 'West Parivini', '');
INSERT INTO `feel_province` VALUES (2009, 'GC', 'SLB', '瓜达尔卡纳尔', 'Guadalcanal', '');
INSERT INTO `feel_province` VALUES (2010, 'HO', 'SLB', '霍尼亚拉', 'Honiara', '');
INSERT INTO `feel_province` VALUES (2011, 'RB', 'SLB', '拉纳尔和贝罗纳', 'Lanal and Bellona', '');
INSERT INTO `feel_province` VALUES (2012, 'MK', 'SLB', '马基拉', 'Makila', '');
INSERT INTO `feel_province` VALUES (2013, 'ML', 'SLB', '马莱塔', 'Maleta', '');
INSERT INTO `feel_province` VALUES (2014, 'CH', 'SLB', '乔伊索', 'Joe Isso', '');
INSERT INTO `feel_province` VALUES (2015, 'TM', 'SLB', '泰莫图', 'Temotu', '');
INSERT INTO `feel_province` VALUES (2016, 'WE', 'SLB', '西部', 'west', '');
INSERT INTO `feel_province` VALUES (2017, 'IS', 'SLB', '伊萨贝尔', 'Isabel', '');
INSERT INTO `feel_province` VALUES (2018, 'CE', 'SLB', '中部群岛', 'Central Islands', '');
INSERT INTO `feel_province` VALUES (2019, 'DYU', 'TJK', '杜尚别', 'Dushanbe', '');
INSERT INTO `feel_province` VALUES (2020, 'KHO', 'TJK', '霍罗格', 'Horrog', '');
INSERT INTO `feel_province` VALUES (2021, 'KAN', 'TJK', '卡尼巴达姆', 'Kanibaddam', '');
INSERT INTO `feel_province` VALUES (2022, 'KOF', 'TJK', '科法尔尼洪', 'Kofarnihong', '');
INSERT INTO `feel_province` VALUES (2023, 'KHU', 'TJK', '苦盏', 'Bitter', '');
INSERT INTO `feel_province` VALUES (2024, 'KTJ', 'TJK', '库尔干秋别', 'Kurgan autumn', '');
INSERT INTO `feel_province` VALUES (2025, 'KLB', 'TJK', '库洛布', 'Kulob', '');
INSERT INTO `feel_province` VALUES (2026, 'RGU', 'TJK', '洛贡', 'Logon', '');
INSERT INTO `feel_province` VALUES (2027, 'NUR', 'TJK', '努雷克', 'Nurek', '');
INSERT INTO `feel_province` VALUES (2028, 'PJK', 'TJK', '彭吉肯特', 'Pengji Kent', '');
INSERT INTO `feel_province` VALUES (2029, 'SBA', 'TJK', '萨班特', 'Saban', '');
INSERT INTO `feel_province` VALUES (2030, 'TBS', 'TJK', '塔博沙尔', 'Taboshal', '');
INSERT INTO `feel_province` VALUES (2031, 'TSZ', 'TJK', '图尔孙扎德', 'Tursunzad', '');
INSERT INTO `feel_province` VALUES (2032, 'UTJ', 'TJK', '乌拉秋别', 'Ulaqiu', '');
INSERT INTO `feel_province` VALUES (2033, 'ISF', 'TJK', '伊斯法拉', 'Isfara', '');
INSERT INTO `feel_province` VALUES (2034, '37', 'THA', '安纳乍能', 'Anna', '');
INSERT INTO `feel_province` VALUES (2035, '77', 'THA', '巴蜀', 'Bayu', '');
INSERT INTO `feel_province` VALUES (2036, '13', 'THA', '巴吞他尼', 'Pathum Thani', '');
INSERT INTO `feel_province` VALUES (2037, '25', 'THA', '巴真', 'Bazhen', '');
INSERT INTO `feel_province` VALUES (2038, '71', 'THA', '北碧', 'Kanchanaburi', '');
INSERT INTO `feel_province` VALUES (2039, '19', 'THA', '北标', 'North standard', '');
INSERT INTO `feel_province` VALUES (2040, '94', 'THA', '北大年', 'Pattani', '');
INSERT INTO `feel_province` VALUES (2041, '11', 'THA', '北揽', 'North', '');
INSERT INTO `feel_province` VALUES (2042, '60', 'THA', '北榄坡', 'Northern slope', '');
INSERT INTO `feel_province` VALUES (2043, '24', 'THA', '北柳', 'Kitayanagi', '');
INSERT INTO `feel_province` VALUES (2044, '76', 'THA', '碧差汶', 'Phetchabun', '');
INSERT INTO `feel_province` VALUES (2045, '93', 'THA', '博达伦', 'Bodalen', '');
INSERT INTO `feel_province` VALUES (2046, '18', 'THA', '猜那', 'Guess that', '');
INSERT INTO `feel_province` VALUES (2047, '36', 'THA', '猜也奔', 'Guess also', '');
INSERT INTO `feel_province` VALUES (2048, '53', 'THA', '程逸', 'Cheng Yi', '');
INSERT INTO `feel_province` VALUES (2049, '86', 'THA', '春蓬', 'Chumphon', '');
INSERT INTO `feel_province` VALUES (2050, '20', 'THA', '春武里', 'Chonburi', '');
INSERT INTO `feel_province` VALUES (2051, '63', 'THA', '达', 'Da', '');
INSERT INTO `feel_province` VALUES (2052, '23', 'THA', '达叻', 'Daban', '');
INSERT INTO `feel_province` VALUES (2053, '14', 'THA', '大城', 'Big city', '');
INSERT INTO `feel_province` VALUES (2054, '92', 'THA', '董里', 'Dong Li', '');
INSERT INTO `feel_province` VALUES (2055, '78', 'THA', '佛丕', 'Buddha', '');
INSERT INTO `feel_province` VALUES (2056, '73', 'THA', '佛统', 'Nakhon Pathom', '');
INSERT INTO `feel_province` VALUES (2057, '62', 'THA', '甘烹碧', 'Kamphabi', '');
INSERT INTO `feel_province` VALUES (2058, '15', 'THA', '红统', 'Anglo', '');
INSERT INTO `feel_province` VALUES (2059, '16', 'THA', '华富里', 'Huafuli', '');
INSERT INTO `feel_province` VALUES (2060, '46', 'THA', '加拉信', 'Kalasin', '');
INSERT INTO `feel_province` VALUES (2061, '81', 'THA', '甲米', 'Krabi', '');
INSERT INTO `feel_province` VALUES (2062, '22', 'THA', '尖竹汶', 'Chanthaburi', '');
INSERT INTO `feel_province` VALUES (2063, '40', 'THA', '孔敬', 'Khon Kaen', '');
INSERT INTO `feel_province` VALUES (2064, '21', 'THA', '拉农', 'Lanon', '');
INSERT INTO `feel_province` VALUES (2065, '43', 'THA', '廊开', 'Nongkai', '');
INSERT INTO `feel_province` VALUES (2066, '39', 'THA', '廊莫那浦', 'Ronnapur', '');
INSERT INTO `feel_province` VALUES (2067, '70', 'THA', '叻丕', 'Ratchaburi', '');
INSERT INTO `feel_province` VALUES (2068, '42', 'THA', '黎', 'Li', '');
INSERT INTO `feel_province` VALUES (2069, '45', 'THA', '黎逸', 'Li Yi', '');
INSERT INTO `feel_province` VALUES (2070, '74', 'THA', '龙仔厝', 'Long Tsai', '');
INSERT INTO `feel_province` VALUES (2071, '85', 'THA', '罗勇', 'Luo Yong', '');
INSERT INTO `feel_province` VALUES (2072, '80', 'THA', '洛坤', 'Nakhon', '');
INSERT INTO `feel_province` VALUES (2073, '44', 'THA', '玛哈沙拉堪', 'Maha Sarakham', '');
INSERT INTO `feel_province` VALUES (2074, '10', 'THA', '曼谷', 'Bangkok', '');
INSERT INTO `feel_province` VALUES (2075, '49', 'THA', '莫达汉', 'Modahan', '');
INSERT INTO `feel_province` VALUES (2076, '26', 'THA', '那空那育', 'Nakhon Nayok', '');
INSERT INTO `feel_province` VALUES (2077, '48', 'THA', '那空帕农', 'Nakhon Phanom', '');
INSERT INTO `feel_province` VALUES (2078, '55', 'THA', '难', 'difficult', '');
INSERT INTO `feel_province` VALUES (2079, '51', 'THA', '南奔', 'Nan Ben', '');
INSERT INTO `feel_province` VALUES (2080, '12', 'THA', '暖武里', 'Nonthaburi', '');
INSERT INTO `feel_province` VALUES (2081, '54', 'THA', '帕', 'Pa', '');
INSERT INTO `feel_province` VALUES (2082, '56', 'THA', '帕尧', 'Phan', '');
INSERT INTO `feel_province` VALUES (2083, '82', 'THA', '攀牙', 'Phang Nga', '');
INSERT INTO `feel_province` VALUES (2084, '65', 'THA', '彭世洛', 'Phitsanulok', '');
INSERT INTO `feel_province` VALUES (2085, '66', 'THA', '披集', 'Phi collection', '');
INSERT INTO `feel_province` VALUES (2086, '83', 'THA', '普吉', 'Phuket', '');
INSERT INTO `feel_province` VALUES (2087, '57', 'THA', '清莱', 'Chiang Rai', '');
INSERT INTO `feel_province` VALUES (2088, '50', 'THA', '清迈', 'Chiang Mai', '');
INSERT INTO `feel_province` VALUES (2089, '47', 'THA', '色军', 'Color army', '');
INSERT INTO `feel_province` VALUES (2090, '91', 'THA', '沙敦', 'Satun', '');
INSERT INTO `feel_province` VALUES (2091, '27', 'THA', '沙缴', 'Sand payment', '');
INSERT INTO `feel_province` VALUES (2092, '33', 'THA', '四色菊', 'Sisaket', '');
INSERT INTO `feel_province` VALUES (2093, '90', 'THA', '宋卡', 'Songka', '');
INSERT INTO `feel_province` VALUES (2094, '64', 'THA', '素可泰', 'Sukhothai', '');
INSERT INTO `feel_province` VALUES (2095, '84', 'THA', '素叻', 'Susie', '');
INSERT INTO `feel_province` VALUES (2096, '32', 'THA', '素林', 'Surin', '');
INSERT INTO `feel_province` VALUES (2097, '72', 'THA', '素攀武里', 'Suphan Buri', '');
INSERT INTO `feel_province` VALUES (2098, '96', 'THA', '陶公', 'Tao Gong', '');
INSERT INTO `feel_province` VALUES (2099, '41', 'THA', '乌隆', 'Udon', '');
INSERT INTO `feel_province` VALUES (2100, '61', 'THA', '乌泰他尼', 'Uthai Thani', '');
INSERT INTO `feel_province` VALUES (2101, '34', 'THA', '乌汶', 'Ubon', '');
INSERT INTO `feel_province` VALUES (2102, '31', 'THA', '武里南', 'Buriram', '');
INSERT INTO `feel_province` VALUES (2103, '17', 'THA', '信武里', 'Sing Buri', '');
INSERT INTO `feel_province` VALUES (2104, '35', 'THA', '耶梭通', 'Yesothon', '');
INSERT INTO `feel_province` VALUES (2105, '95', 'THA', '也拉', 'Also pull', '');
INSERT INTO `feel_province` VALUES (2106, '58', 'THA', '夜丰颂', 'Mae Hong', '');
INSERT INTO `feel_province` VALUES (2107, '75', 'THA', '夜功', 'Night work', '');
INSERT INTO `feel_province` VALUES (2108, 'AR', 'TZA', '阿鲁沙', 'Arusha', '');
INSERT INTO `feel_province` VALUES (2109, 'PN', 'TZA', '奔巴北', 'Pemba North', '');
INSERT INTO `feel_province` VALUES (2110, 'PS', 'TZA', '奔巴南', 'Ben Banan', '');
INSERT INTO `feel_province` VALUES (2111, 'PW', 'TZA', '滨海', 'Coast', '');
INSERT INTO `feel_province` VALUES (2112, 'DS', 'TZA', '达累斯萨拉姆', 'Dar es Salaam', '');
INSERT INTO `feel_province` VALUES (2113, 'DO', 'TZA', '多多马', 'Dodoma', '');
INSERT INTO `feel_province` VALUES (2114, 'KI', 'TZA', '基戈马', 'Kigoma', '');
INSERT INTO `feel_province` VALUES (2115, 'KA', 'TZA', '卡盖拉', 'Kagela', '');
INSERT INTO `feel_province` VALUES (2116, 'LN', 'TZA', '林迪', 'Lindy', '');
INSERT INTO `feel_province` VALUES (2117, 'RK', 'TZA', '鲁夸', 'Luqua', '');
INSERT INTO `feel_province` VALUES (2118, 'RV', 'TZA', '鲁伍马', 'Rovuma', '');
INSERT INTO `feel_province` VALUES (2119, 'MR', 'TZA', '马腊', 'Mara', '');
INSERT INTO `feel_province` VALUES (2120, 'MY', 'TZA', '曼亚拉', 'Manyala', '');
INSERT INTO `feel_province` VALUES (2121, 'MO', 'TZA', '莫洛戈罗', 'Morogoro', '');
INSERT INTO `feel_province` VALUES (2122, 'MB', 'TZA', '姆贝亚', 'Mbeya', '');
INSERT INTO `feel_province` VALUES (2123, 'MT', 'TZA', '姆特瓦拉', 'Mtwara', '');
INSERT INTO `feel_province` VALUES (2124, 'MW', 'TZA', '姆万扎', 'Mwanza', '');
INSERT INTO `feel_province` VALUES (2125, 'KJ', 'TZA', '乞力马扎罗', 'Kilimanjaro', '');
INSERT INTO `feel_province` VALUES (2126, 'ZN', 'TZA', '桑给巴尔', 'Zanzibar', '');
INSERT INTO `feel_province` VALUES (2127, 'UN', 'TZA', '桑给巴尔北', 'Zanzibar North', '');
INSERT INTO `feel_province` VALUES (2128, 'US', 'TZA', '桑给巴尔南', 'Zanzibar South', '');
INSERT INTO `feel_province` VALUES (2129, 'MM', 'TZA', '桑给巴尔市和西', 'Zanzibar City and West', '');
INSERT INTO `feel_province` VALUES (2130, 'TB', 'TZA', '塔波拉', 'Tabora', '');
INSERT INTO `feel_province` VALUES (2131, 'TN', 'TZA', '坦噶', 'Tanga', '');
INSERT INTO `feel_province` VALUES (2132, 'SI', 'TZA', '辛吉达', 'Singida', '');
INSERT INTO `feel_province` VALUES (2133, 'SH', 'TZA', '欣延加', 'Xin Yanjia', '');
INSERT INTO `feel_province` VALUES (2134, 'IR', 'TZA', '伊林加', 'Iringa', '');
INSERT INTO `feel_province` VALUES (2135, 'E', 'TON', '埃瓦', 'Eva', '');
INSERT INTO `feel_province` VALUES (2136, 'H', 'TON', '哈派', 'Hapa', '');
INSERT INTO `feel_province` VALUES (2137, 'N', 'TON', '纽阿斯', 'Newas', '');
INSERT INTO `feel_province` VALUES (2138, 'T', 'TON', '汤加塔布', 'Tongatabu', '');
INSERT INTO `feel_province` VALUES (2139, 'V', 'TON', '瓦瓦乌', 'Wawau', '');
INSERT INTO `feel_province` VALUES (2140, 'AR', 'TUN', '艾尔亚奈', 'El Yana', '');
INSERT INTO `feel_province` VALUES (2141, 'BJ', 'TUN', '巴杰', 'Bajie', '');
INSERT INTO `feel_province` VALUES (2142, 'BA', 'TUN', '本阿鲁斯', 'Ben Arous', '');
INSERT INTO `feel_province` VALUES (2143, 'BI', 'TUN', '比塞大', 'Bizerte', '');
INSERT INTO `feel_province` VALUES (2144, 'KB', 'TUN', '吉比利', 'Gibili', '');
INSERT INTO `feel_province` VALUES (2145, 'GB', 'TUN', '加贝斯', 'Gabes', '');
INSERT INTO `feel_province` VALUES (2146, 'GF', 'TUN', '加夫萨', 'Gafsa', '');
INSERT INTO `feel_province` VALUES (2147, 'JE', 'TUN', '坚杜拜', 'Jian Dubai', '');
INSERT INTO `feel_province` VALUES (2148, 'LK', 'TUN', '卡夫', 'Kraft', '');
INSERT INTO `feel_province` VALUES (2149, 'KS', 'TUN', '卡塞林', 'Caselin', '');
INSERT INTO `feel_province` VALUES (2150, 'KR', 'TUN', '凯鲁万', 'Kairouan', '');
INSERT INTO `feel_province` VALUES (2151, 'MH', 'TUN', '马赫迪耶', 'Mahdia', '');
INSERT INTO `feel_province` VALUES (2152, 'MN', 'TUN', '马努巴', 'Manuba', '');
INSERT INTO `feel_province` VALUES (2153, 'ME', 'TUN', '梅德宁', 'Medynin', '');
INSERT INTO `feel_province` VALUES (2154, 'MO', 'TUN', '莫纳斯提尔', 'Monastir', '');
INSERT INTO `feel_province` VALUES (2155, 'NA', 'TUN', '纳布勒', 'Nabule', '');
INSERT INTO `feel_province` VALUES (2156, 'SF', 'TUN', '斯法克斯', 'Sfax', '');
INSERT INTO `feel_province` VALUES (2157, 'SO', 'TUN', '苏塞', 'Sousse', '');
INSERT INTO `feel_province` VALUES (2158, 'TA', 'TUN', '泰塔温', 'Tatavin', '');
INSERT INTO `feel_province` VALUES (2159, 'TU', 'TUN', '突尼斯', 'Tunisia', '');
INSERT INTO `feel_province` VALUES (2160, 'TO', 'TUN', '托泽尔', 'Tozer', '');
INSERT INTO `feel_province` VALUES (2161, 'SD', 'TUN', '西迪布济德', 'Sidi Bouzid', '');
INSERT INTO `feel_province` VALUES (2162, 'SL', 'TUN', '锡勒亚奈', 'Silyanay', '');
INSERT INTO `feel_province` VALUES (2163, 'ZA', 'TUN', '宰格万', 'Zegwan', '');
INSERT INTO `feel_province` VALUES (2164, 'ADA', 'TUR', '阿达纳', 'Adana', '');
INSERT INTO `feel_province` VALUES (2165, 'ADI', 'TUR', '阿德亚曼', 'Adiyaman', '');
INSERT INTO `feel_province` VALUES (2166, 'ARD', 'TUR', '阿尔达罕', 'Aldahan', '');
INSERT INTO `feel_province` VALUES (2167, 'ART', 'TUR', '阿尔特温', 'Altwin', '');
INSERT INTO `feel_province` VALUES (2168, 'AFY', 'TUR', '阿菲永', 'Afyon', '');
INSERT INTO `feel_province` VALUES (2169, 'AKS', 'TUR', '阿克萨赖', 'Aksaray', '');
INSERT INTO `feel_province` VALUES (2170, 'AGR', 'TUR', '阿勒', 'Ale', '');
INSERT INTO `feel_province` VALUES (2171, 'AMA', 'TUR', '阿马西亚', 'Amasia', '');
INSERT INTO `feel_province` VALUES (2172, 'EDI', 'TUR', '埃迪尔内', 'Edirne', '');
INSERT INTO `feel_province` VALUES (2173, 'EZC', 'TUR', '埃尔津詹', 'Erzincan', '');
INSERT INTO `feel_province` VALUES (2174, 'EZR', 'TUR', '埃尔祖鲁姆', 'Erzurum', '');
INSERT INTO `feel_province` VALUES (2175, 'ELA', 'TUR', '埃拉泽', 'Elazig', '');
INSERT INTO `feel_province` VALUES (2176, 'ESK', 'TUR', '埃斯基谢希尔', 'Eskisehir', '');
INSERT INTO `feel_province` VALUES (2177, 'AYI', 'TUR', '艾登', 'Aiden', '');
INSERT INTO `feel_province` VALUES (2178, 'ANK', 'TUR', '安卡拉', 'Ankara', '');
INSERT INTO `feel_province` VALUES (2179, 'ANT', 'TUR', '安塔利亚', 'Antalya', '');
INSERT INTO `feel_province` VALUES (2180, 'ORD', 'TUR', '奥尔杜', 'Ordu', '');
INSERT INTO `feel_province` VALUES (2181, 'BAR', 'TUR', '巴尔腾', 'Barten', '');
INSERT INTO `feel_province` VALUES (2182, 'BAL', 'TUR', '巴勒克埃西尔', 'Balikesir', '');
INSERT INTO `feel_province` VALUES (2183, 'BAT', 'TUR', '巴特曼', 'Batman', '');
INSERT INTO `feel_province` VALUES (2184, 'BAY', 'TUR', '巴伊布尔特', 'Bayburt', '');
INSERT INTO `feel_province` VALUES (2185, 'BIL', 'TUR', '比莱吉克', 'Bilecik', '');
INSERT INTO `feel_province` VALUES (2186, 'BIT', 'TUR', '比特利斯', 'Bitlis', '');
INSERT INTO `feel_province` VALUES (2187, 'BIN', 'TUR', '宾格尔', 'Bingol', '');
INSERT INTO `feel_province` VALUES (2188, 'BOL', 'TUR', '博卢', 'Bolu', '');
INSERT INTO `feel_province` VALUES (2189, 'BRD', 'TUR', '布尔杜尔', 'Burdur', '');
INSERT INTO `feel_province` VALUES (2190, 'BRS', 'TUR', '布尔萨', 'Bursa', '');
INSERT INTO `feel_province` VALUES (2191, 'CKR', 'TUR', '昌克勒', 'Chankler', '');
INSERT INTO `feel_province` VALUES (2192, 'DEN', 'TUR', '代尼兹利', 'Denizli', '');
INSERT INTO `feel_province` VALUES (2193, 'DIY', 'TUR', '迪亚巴克尔', 'Diyarbakir', '');
INSERT INTO `feel_province` VALUES (2194, 'VAN', 'TUR', '凡', 'Where', '');
INSERT INTO `feel_province` VALUES (2195, 'HKR', 'TUR', '哈卡里', 'Hakkari', '');
INSERT INTO `feel_province` VALUES (2196, 'HTY', 'TUR', '哈塔伊', 'Hatay', '');
INSERT INTO `feel_province` VALUES (2197, 'KLS', 'TUR', '基利斯', 'Kilis', '');
INSERT INTO `feel_province` VALUES (2198, 'GIR', 'TUR', '吉雷松', 'Giresson', '');
INSERT INTO `feel_province` VALUES (2199, 'GAZ', 'TUR', '加济安泰普', 'Gaziantep', '');
INSERT INTO `feel_province` VALUES (2200, 'GMS', 'TUR', '居米什哈内', 'Gimishane', '');
INSERT INTO `feel_province` VALUES (2201, 'KRS', 'TUR', '卡尔斯', 'Kars', '');
INSERT INTO `feel_province` VALUES (2202, 'KAH', 'TUR', '卡赫拉曼马拉什', 'Kahramanmaras', '');
INSERT INTO `feel_province` VALUES (2203, 'KRB', 'TUR', '卡拉比克', 'Karabik', '');
INSERT INTO `feel_province` VALUES (2204, 'KRM', 'TUR', '卡拉曼', 'Karaman', '');
INSERT INTO `feel_province` VALUES (2205, 'KAS', 'TUR', '卡斯塔莫努', 'Kastamonu', '');
INSERT INTO `feel_province` VALUES (2206, 'KAY', 'TUR', '开塞利', 'Kayseri', '');
INSERT INTO `feel_province` VALUES (2207, 'KOC', 'TUR', '科贾埃利', 'Kocaeli', '');
INSERT INTO `feel_province` VALUES (2208, 'KLR', 'TUR', '柯克拉雷利', 'Koklareli', '');
INSERT INTO `feel_province` VALUES (2209, 'KON', 'TUR', '科尼亚', 'Konya', '');
INSERT INTO `feel_province` VALUES (2210, 'KRH', 'TUR', '克尔谢希尔', 'Kelsey hill', '');
INSERT INTO `feel_province` VALUES (2211, 'KRK', 'TUR', '克勒克卡莱', 'Klekkale', '');
INSERT INTO `feel_province` VALUES (2212, 'URF', 'TUR', '拉飞', 'Lafei', '');
INSERT INTO `feel_province` VALUES (2213, 'RIZ', 'TUR', '里泽', 'Rize', '');
INSERT INTO `feel_province` VALUES (2214, 'MAR', 'TUR', '马尔丁', 'Mardin', '');
INSERT INTO `feel_province` VALUES (2215, 'MAL', 'TUR', '马拉蒂亚', 'Malatya', '');
INSERT INTO `feel_province` VALUES (2216, 'MAN', 'TUR', '马尼萨', 'Manisa', '');
INSERT INTO `feel_province` VALUES (2217, 'MUG', 'TUR', '穆拉', 'Mugla', '');
INSERT INTO `feel_province` VALUES (2218, 'MUS', 'TUR', '穆什', 'Mush', '');
INSERT INTO `feel_province` VALUES (2219, 'NEV', 'TUR', '内夫谢希尔', 'Nevsehir', '');
INSERT INTO `feel_province` VALUES (2220, 'NIG', 'TUR', '尼代', 'Nide', '');
INSERT INTO `feel_province` VALUES (2221, 'CKL', 'TUR', '恰纳卡莱', 'Canakkale', '');
INSERT INTO `feel_province` VALUES (2222, 'COR', 'TUR', '乔鲁姆', 'Chorum', '');
INSERT INTO `feel_province` VALUES (2223, 'KUT', 'TUR', '屈塔希亚', 'Kutahia', '');
INSERT INTO `feel_province` VALUES (2224, 'SAK', 'TUR', '萨卡里亚', 'Sakarya', '');
INSERT INTO `feel_province` VALUES (2225, 'SAM', 'TUR', '萨姆松', 'Samsun', '');
INSERT INTO `feel_province` VALUES (2226, 'TEL', 'TUR', '泰基尔达', 'Tekirda', '');
INSERT INTO `feel_province` VALUES (2227, 'TRA', 'TUR', '特拉布宗', 'Trabzon', '');
INSERT INTO `feel_province` VALUES (2228, 'TUN', 'TUR', '通杰利', 'Tongjieli', '');
INSERT INTO `feel_province` VALUES (2229, 'TOK', 'TUR', '托卡特', 'Tokat', '');
INSERT INTO `feel_province` VALUES (2230, 'USK', 'TUR', '乌萨克', 'Usak', '');
INSERT INTO `feel_province` VALUES (2231, 'SIR', 'TUR', '锡尔纳克', 'Sirnak', '');
INSERT INTO `feel_province` VALUES (2232, 'SII', 'TUR', '锡尔特', 'Sirte', '');
INSERT INTO `feel_province` VALUES (2233, 'SIN', 'TUR', '锡诺普', 'Sinop', '');
INSERT INTO `feel_province` VALUES (2234, 'SIV', 'TUR', '锡瓦斯', 'Sivas', '');
INSERT INTO `feel_province` VALUES (2235, 'IGD', 'TUR', '伊迪尔', 'Idil', '');
INSERT INTO `feel_province` VALUES (2236, 'ICE', 'TUR', '伊切尔', 'Icher', '');
INSERT INTO `feel_province` VALUES (2237, 'ISP', 'TUR', '伊斯帕尔塔', 'Isparta', '');
INSERT INTO `feel_province` VALUES (2238, 'IST', 'TUR', '伊斯坦布尔', 'Istanbul', '');
INSERT INTO `feel_province` VALUES (2239, 'IZM', 'TUR', '伊兹密尔', 'Izmir', '');
INSERT INTO `feel_province` VALUES (2240, 'YOZ', 'TUR', '约兹加特', 'Yozgat', '');
INSERT INTO `feel_province` VALUES (2241, 'ZON', 'TUR', '宗古尔达克', 'Zonguldak', '');
INSERT INTO `feel_province` VALUES (2242, 'A', 'TKM', '阿哈尔', 'Ahar', '');
INSERT INTO `feel_province` VALUES (2243, 'ASB', 'TKM', '阿什哈巴德市', 'Ashgabat City', '');
INSERT INTO `feel_province` VALUES (2244, 'B', 'TKM', '巴尔坎', 'Balkan', '');
INSERT INTO `feel_province` VALUES (2245, 'D', 'TKM', '达沙古兹', 'Dashaguz', '');
INSERT INTO `feel_province` VALUES (2246, 'L', 'TKM', '列巴普', 'Lebap', '');
INSERT INTO `feel_province` VALUES (2247, 'M', 'TKM', '马雷', 'Marley', '');
INSERT INTO `feel_province` VALUES (2248, 'NEB', 'TKM', '涅比特达格', 'Nibbit Dag', '');
INSERT INTO `feel_province` VALUES (2249, 'MA', 'VUT', '马朗帕', 'Malampa', '');
INSERT INTO `feel_province` VALUES (2250, 'PE', 'VUT', '彭纳马', 'Pennama', '');
INSERT INTO `feel_province` VALUES (2251, 'SA', 'VUT', '桑马', 'Sanma', '');
INSERT INTO `feel_province` VALUES (2252, 'TA', 'VUT', '塔菲阿', 'Tafia', '');
INSERT INTO `feel_province` VALUES (2253, 'TO', 'VUT', '托尔巴', 'Torba', '');
INSERT INTO `feel_province` VALUES (2254, 'SH', 'VUT', '谢法', 'Xiefa', '');
INSERT INTO `feel_province` VALUES (2255, 'PR', 'GTM', '埃尔普罗格雷索', 'El progreso', '');
INSERT INTO `feel_province` VALUES (2256, 'ES', 'GTM', '埃斯昆特拉', 'Escuintla', '');
INSERT INTO `feel_province` VALUES (2257, 'JA', 'GTM', '哈拉帕', 'Harapa', '');
INSERT INTO `feel_province` VALUES (2258, 'JU', 'GTM', '胡蒂亚帕', 'Hutiyapa', '');
INSERT INTO `feel_province` VALUES (2259, 'QC', 'GTM', '基切', 'Quiche', '');
INSERT INTO `feel_province` VALUES (2260, 'QZ', 'GTM', '克萨尔特南戈', 'Quesaltenango', '');
INSERT INTO `feel_province` VALUES (2261, 'RE', 'GTM', '雷塔卢莱乌', 'Retaluleu', '');
INSERT INTO `feel_province` VALUES (2262, 'MIX', 'GTM', '米克斯科', 'Micksko', '');
INSERT INTO `feel_province` VALUES (2263, 'PE', 'GTM', '佩滕', 'Petten', '');
INSERT INTO `feel_province` VALUES (2264, 'CQ', 'GTM', '奇基穆拉', 'Chiquimula', '');
INSERT INTO `feel_province` VALUES (2265, 'CM', 'GTM', '奇马尔特南戈', 'Chimaltenango', '');
INSERT INTO `feel_province` VALUES (2266, 'ZA', 'GTM', '萨卡帕', 'Sacapa', '');
INSERT INTO `feel_province` VALUES (2267, 'ST', 'GTM', '萨卡特佩克斯', 'Zacatepex', '');
INSERT INTO `feel_province` VALUES (2268, 'AV', 'GTM', '上韦拉帕斯', 'Upper verapaz', '');
INSERT INTO `feel_province` VALUES (2269, 'SR', 'GTM', '圣罗莎', 'Santa Rosa', '');
INSERT INTO `feel_province` VALUES (2270, 'SM', 'GTM', '圣马科斯', 'San Marcos', '');
INSERT INTO `feel_province` VALUES (2271, 'SU', 'GTM', '苏奇特佩克斯', 'Suchett Pecks', '');
INSERT INTO `feel_province` VALUES (2272, 'SO', 'GTM', '索洛拉', 'Solola', '');
INSERT INTO `feel_province` VALUES (2273, 'TO', 'GTM', '托托尼卡潘', 'Totonikapan', '');
INSERT INTO `feel_province` VALUES (2274, 'GU', 'GTM', '危地马拉', 'Guatemala', '');
INSERT INTO `feel_province` VALUES (2275, 'HU', 'GTM', '韦韦特南戈', 'Vevetnango', '');
INSERT INTO `feel_province` VALUES (2276, 'BV', 'GTM', '下韦拉帕斯', 'Lower virapas', '');
INSERT INTO `feel_province` VALUES (2277, 'VIN', 'GTM', '新城', 'New city', '');
INSERT INTO `feel_province` VALUES (2278, 'IZ', 'GTM', '伊萨瓦尔', 'Isavar', '');
INSERT INTO `feel_province` VALUES (2279, 'D', 'VEN', '阿拉瓜', 'Aragua', '');
INSERT INTO `feel_province` VALUES (2280, 'Y', 'VEN', '阿马库罗三角洲', 'Amaculo Delta', '');
INSERT INTO `feel_province` VALUES (2281, 'C', 'VEN', '阿普雷', 'Apley', '');
INSERT INTO `feel_province` VALUES (2282, 'B', 'VEN', '安索阿特吉', 'Ansoatji', '');
INSERT INTO `feel_province` VALUES (2283, 'E', 'VEN', '巴里纳斯', 'Barinas', '');
INSERT INTO `feel_province` VALUES (2284, 'F', 'VEN', '玻利瓦尔', 'Bolivar', '');
INSERT INTO `feel_province` VALUES (2285, 'P', 'VEN', '波图格萨', 'Portuguesa', '');
INSERT INTO `feel_province` VALUES (2286, 'I', 'VEN', '法尔孔', 'Falcon', '');
INSERT INTO `feel_province` VALUES (2287, 'J', 'VEN', '瓜里科', 'Guarico', '');
INSERT INTO `feel_province` VALUES (2288, 'A', 'VEN', '加拉加斯', 'Caracas', '');
INSERT INTO `feel_province` VALUES (2289, 'G', 'VEN', '卡拉沃沃', 'Karavovo', '');
INSERT INTO `feel_province` VALUES (2290, 'H', 'VEN', '科赫德斯', 'Kodders', '');
INSERT INTO `feel_province` VALUES (2291, 'K', 'VEN', '拉腊', 'Lara', '');
INSERT INTO `feel_province` VALUES (2292, 'W', 'VEN', '联邦属地', 'Federal territories', '');
INSERT INTO `feel_province` VALUES (2293, 'L', 'VEN', '梅里达', 'Merida', '');
INSERT INTO `feel_province` VALUES (2294, 'M', 'VEN', '米兰达', 'Miranda', '');
INSERT INTO `feel_province` VALUES (2295, 'N', 'VEN', '莫纳加斯', 'Monagas', '');
INSERT INTO `feel_province` VALUES (2296, 'R', 'VEN', '苏克雷', 'Sucre', '');
INSERT INTO `feel_province` VALUES (2297, 'V', 'VEN', '苏利亚', 'Sulia', '');
INSERT INTO `feel_province` VALUES (2298, 'S', 'VEN', '塔奇拉', 'Takila', '');
INSERT INTO `feel_province` VALUES (2299, 'T', 'VEN', '特鲁希略', 'Trujillo', '');
INSERT INTO `feel_province` VALUES (2300, 'O', 'VEN', '新埃斯帕塔', 'New esparta', '');
INSERT INTO `feel_province` VALUES (2301, 'U', 'VEN', '亚拉奎', 'Yarakui', '');
INSERT INTO `feel_province` VALUES (2302, 'Z', 'VEN', '亚马孙', 'Amazon', '');
INSERT INTO `feel_province` VALUES (2303, 'ARU', 'UGA', '阿鲁阿', 'Arua', '');
INSERT INTO `feel_province` VALUES (2304, 'APC', 'UGA', '阿帕克', 'Apac', '');
INSERT INTO `feel_province` VALUES (2305, 'ADJ', 'UGA', '阿朱马尼', 'Ajumani', '');
INSERT INTO `feel_province` VALUES (2306, 'BUN', 'UGA', '本迪布焦', 'Bundibugio', '');
INSERT INTO `feel_province` VALUES (2307, 'BUG', 'UGA', '布吉里', 'Bugiori', '');
INSERT INTO `feel_province` VALUES (2308, 'BUS', 'UGA', '布西亚', 'Busia', '');
INSERT INTO `feel_province` VALUES (2309, 'BSH', 'UGA', '布谢尼', 'Buscheni', '');
INSERT INTO `feel_province` VALUES (2310, 'NTU', 'UGA', '恩通加莫', 'Ntonggamo', '');
INSERT INTO `feel_province` VALUES (2311, 'GUL', 'UGA', '古卢', 'Gulu', '');
INSERT INTO `feel_province` VALUES (2312, 'HOI', 'UGA', '霍伊马', 'Hoyma', '');
INSERT INTO `feel_province` VALUES (2313, 'KBA', 'UGA', '基巴莱', 'Kibale', '');
INSERT INTO `feel_province` VALUES (2314, 'KIB', 'UGA', '基博加', 'Kiboga', '');
INSERT INTO `feel_province` VALUES (2315, 'KYE', 'UGA', '基恩乔乔', 'Keanjocho', '');
INSERT INTO `feel_province` VALUES (2316, 'KIS', 'UGA', '基索罗', 'Kisoro', '');
INSERT INTO `feel_province` VALUES (2317, 'KIT', 'UGA', '基特古姆', 'Kitgum', '');
INSERT INTO `feel_province` VALUES (2318, 'JIN', 'UGA', '金贾', 'Jin Jia', '');
INSERT INTO `feel_province` VALUES (2319, 'KBL', 'UGA', '卡巴莱', 'Cabale', '');
INSERT INTO `feel_province` VALUES (2320, 'KAR', 'UGA', '卡巴罗莱', 'Cabalole', '');
INSERT INTO `feel_province` VALUES (2321, 'KAB', 'UGA', '卡贝拉马伊多', 'Cabela Maido', '');
INSERT INTO `feel_province` VALUES (2322, 'KAL', 'UGA', '卡兰加拉', 'Kalangala', '');
INSERT INTO `feel_province` VALUES (2323, 'KAM', 'UGA', '卡姆文盖', 'Kamwengai', '');
INSERT INTO `feel_province` VALUES (2324, 'KML', 'UGA', '卡穆利', 'Camuli', '');
INSERT INTO `feel_province` VALUES (2325, 'KAN', 'UGA', '卡农古', 'Cannongu', '');
INSERT INTO `feel_province` VALUES (2326, 'KPC', 'UGA', '卡普乔鲁瓦', 'Capchorowa', '');
INSERT INTO `feel_province` VALUES (2327, 'KAS', 'UGA', '卡塞塞', 'Cassese', '');
INSERT INTO `feel_province` VALUES (2328, 'KTK', 'UGA', '卡塔奎', 'Kataqui', '');
INSERT INTO `feel_province` VALUES (2329, 'KAY', 'UGA', '卡永加', 'Kayonga', '');
INSERT INTO `feel_province` VALUES (2330, 'KMP', 'UGA', '坎帕拉', 'Kampala', '');
INSERT INTO `feel_province` VALUES (2331, 'KOT', 'UGA', '科蒂多', 'Cotido', '');
INSERT INTO `feel_province` VALUES (2332, 'KUM', 'UGA', '库米', 'Kumi', '');
INSERT INTO `feel_province` VALUES (2333, 'RAK', 'UGA', '拉卡伊', 'Lacai', '');
INSERT INTO `feel_province` VALUES (2334, 'LIR', 'UGA', '利拉', 'Lila', '');
INSERT INTO `feel_province` VALUES (2335, 'LUW', 'UGA', '卢韦罗', 'Luvero', '');
INSERT INTO `feel_province` VALUES (2336, 'RUK', 'UGA', '鲁昆吉里', 'Lukungiri', '');
INSERT INTO `feel_province` VALUES (2337, 'MAS', 'UGA', '马萨卡', 'Masaka', '');
INSERT INTO `feel_province` VALUES (2338, 'MSN', 'UGA', '马辛迪', 'Masindi', '');
INSERT INTO `feel_province` VALUES (2339, 'MAY', 'UGA', '马尤盖', 'Majuga', '');
INSERT INTO `feel_province` VALUES (2340, 'MRT', 'UGA', '莫罗托', 'Moroto', '');
INSERT INTO `feel_province` VALUES (2341, 'MOY', 'UGA', '莫约', 'Moyo', '');
INSERT INTO `feel_province` VALUES (2342, 'MBR', 'UGA', '姆巴拉拉', 'Mbarara', '');
INSERT INTO `feel_province` VALUES (2343, 'MBA', 'UGA', '姆巴莱', 'Mbale', '');
INSERT INTO `feel_province` VALUES (2344, 'MPI', 'UGA', '姆皮吉', 'Mpiji', '');
INSERT INTO `feel_province` VALUES (2345, 'MUB', 'UGA', '穆本德', 'Mubende', '');
INSERT INTO `feel_province` VALUES (2346, 'MUK', 'UGA', '穆科诺', 'Mukono', '');
INSERT INTO `feel_province` VALUES (2347, 'NAK', 'UGA', '纳卡皮里皮里特', 'Nakapi Pirit', '');
INSERT INTO `feel_province` VALUES (2348, 'NKS', 'UGA', '纳卡松戈拉', 'Nakasongola', '');
INSERT INTO `feel_province` VALUES (2349, 'NEB', 'UGA', '内比', 'Nebi', '');
INSERT INTO `feel_province` VALUES (2350, 'PAD', 'UGA', '帕德尔', 'Padel', '');
INSERT INTO `feel_province` VALUES (2351, 'PAL', 'UGA', '帕利萨', 'Palissa', '');
INSERT INTO `feel_province` VALUES (2352, 'SEM', 'UGA', '森巴布莱', 'Sambabal', '');
INSERT INTO `feel_province` VALUES (2353, 'SOR', 'UGA', '索罗提', 'Sorotti', '');
INSERT INTO `feel_province` VALUES (2354, 'TOR', 'UGA', '托罗罗', 'Tororo', '');
INSERT INTO `feel_province` VALUES (2355, 'WAK', 'UGA', '瓦基索', 'Wakiso', '');
INSERT INTO `feel_province` VALUES (2356, 'SIR', 'UGA', '锡龙科', 'Xilongke', '');
INSERT INTO `feel_province` VALUES (2357, 'IGA', 'UGA', '伊甘加', 'Iganga', '');
INSERT INTO `feel_province` VALUES (2358, 'YUM', 'UGA', '永贝', 'Yongbei', '');
INSERT INTO `feel_province` VALUES (2359, '51', 'UKR', '敖德萨', 'Odessa', '');
INSERT INTO `feel_province` VALUES (2360, '53', 'UKR', '波尔塔瓦', 'Poltava', '');
INSERT INTO `feel_province` VALUES (2361, '12', 'UKR', '第聂伯罗波得罗夫斯克', 'Dnipropetrovsk', '');
INSERT INTO `feel_province` VALUES (2362, '14', 'UKR', '顿涅茨克', 'Donetsk', '');
INSERT INTO `feel_province` VALUES (2363, '63', 'UKR', '哈尔科夫', 'Kharkiv', '');
INSERT INTO `feel_province` VALUES (2364, '65', 'UKR', '赫尔松州', 'Kherson', '');
INSERT INTO `feel_province` VALUES (2365, '68', 'UKR', '赫梅利尼茨基', 'Khmelnitsky', '');
INSERT INTO `feel_province` VALUES (2366, '30', 'UKR', '基辅', 'Kiev', '');
INSERT INTO `feel_province` VALUES (2367, '35', 'UKR', '基洛夫格勒', 'Kirovgrad', '');
INSERT INTO `feel_province` VALUES (2368, '61', 'UKR', '捷尔诺波尔', 'Ternopil', '');
INSERT INTO `feel_province` VALUES (2369, '43', 'UKR', '克里米亚自治共和国', 'Autonomous Republic of Crimea', '');
INSERT INTO `feel_province` VALUES (2370, '46', 'UKR', '利沃夫', 'Lviv', '');
INSERT INTO `feel_province` VALUES (2371, '9', 'UKR', '卢甘斯克', 'Lugansk', '');
INSERT INTO `feel_province` VALUES (2372, '56', 'UKR', '罗夫诺', 'Rovno', '');
INSERT INTO `feel_province` VALUES (2373, '48', 'UKR', '尼古拉耶夫', 'Nikolaev', '');
INSERT INTO `feel_province` VALUES (2374, '71', 'UKR', '切尔卡瑟', 'Cherkasser', '');
INSERT INTO `feel_province` VALUES (2375, '74', 'UKR', '切尔尼戈夫', 'Chernigov', '');
INSERT INTO `feel_province` VALUES (2376, '77', 'UKR', '切尔诺夫策', 'Chernivtsi', '');
INSERT INTO `feel_province` VALUES (2377, '18', 'UKR', '日托米尔', 'Zhitomir', '');
INSERT INTO `feel_province` VALUES (2378, '59', 'UKR', '苏梅', 'Samui', '');
INSERT INTO `feel_province` VALUES (2379, '21', 'UKR', '外喀尔巴阡', 'Carpathians', '');
INSERT INTO `feel_province` VALUES (2380, '5', 'UKR', '文尼察', 'Vinnitsa', '');
INSERT INTO `feel_province` VALUES (2381, '7', 'UKR', '沃伦', 'Warren', '');
INSERT INTO `feel_province` VALUES (2382, '26', 'UKR', '伊万－弗兰科夫州', 'Ivan-Frankivsk', '');
INSERT INTO `feel_province` VALUES (2383, '23', 'UKR', '扎波罗热', 'Zaporozhye', '');
INSERT INTO `feel_province` VALUES (2384, 'AR', 'URY', '阿蒂加斯', 'Artigas', '');
INSERT INTO `feel_province` VALUES (2385, 'DU', 'URY', '杜拉斯诺', 'Durasno', '');
INSERT INTO `feel_province` VALUES (2386, 'FA', 'URY', '佛罗里达', 'Florida', '');
INSERT INTO `feel_province` VALUES (2387, 'FS', 'URY', '弗洛雷斯', 'Flores', '');
INSERT INTO `feel_province` VALUES (2388, 'CA', 'URY', '卡内洛内斯', 'Canelones', '');
INSERT INTO `feel_province` VALUES (2389, 'CO', 'URY', '科洛尼亚', 'Colonia', '');
INSERT INTO `feel_province` VALUES (2390, 'LA', 'URY', '拉瓦耶哈', 'Lavayeha', '');
INSERT INTO `feel_province` VALUES (2391, 'RV', 'URY', '里韦拉', 'Rivera', '');
INSERT INTO `feel_province` VALUES (2392, 'RO', 'URY', '罗恰', 'Rocha', '');
INSERT INTO `feel_province` VALUES (2393, 'MA', 'URY', '马尔多纳多', 'Maldonado', '');
INSERT INTO `feel_province` VALUES (2394, 'MO', 'URY', '蒙得维的亚', 'Montevideo', '');
INSERT INTO `feel_province` VALUES (2395, 'RN', 'URY', '内格罗河', 'Negros', '');
INSERT INTO `feel_province` VALUES (2396, 'PA', 'URY', '派桑杜', 'Pasangdu', '');
INSERT INTO `feel_province` VALUES (2397, 'SL', 'URY', '萨尔托', 'Salto', '');
INSERT INTO `feel_province` VALUES (2398, 'CL', 'URY', '塞罗拉尔戈', 'Cerro Largo', '');
INSERT INTO `feel_province` VALUES (2399, 'TT', 'URY', '三十三人', 'Thirty three', '');
INSERT INTO `feel_province` VALUES (2400, 'SJ', 'URY', '圣何塞', 'San Jose', '');
INSERT INTO `feel_province` VALUES (2401, 'SO', 'URY', '索里亚诺', 'Soriano', '');
INSERT INTO `feel_province` VALUES (2402, 'TAW', 'URY', '塔夸伦博', 'Taquarumbo', '');
INSERT INTO `feel_province` VALUES (2403, 'AN', 'UZB', '安集延', 'Andijan', '');
INSERT INTO `feel_province` VALUES (2404, 'BU', 'UZB', '布哈拉', 'Bukhara', '');
INSERT INTO `feel_province` VALUES (2405, 'FA', 'UZB', '费尔干纳', 'Fergana', '');
INSERT INTO `feel_province` VALUES (2406, 'XO', 'UZB', '花拉子模', 'Flower pull mold', '');
INSERT INTO `feel_province` VALUES (2407, 'JI', 'UZB', '吉扎克', 'Gizak', '');
INSERT INTO `feel_province` VALUES (2408, 'QR', 'UZB', '卡拉卡尔帕克斯坦共和国', 'Karakalpakstan Republic', '');
INSERT INTO `feel_province` VALUES (2409, 'QA', 'UZB', '卡什卡达里亚', 'Kashkadaria', '');
INSERT INTO `feel_province` VALUES (2410, 'NG', 'UZB', '纳曼干', 'Namangan', '');
INSERT INTO `feel_province` VALUES (2411, 'NW', 'UZB', '纳沃伊', 'Navoi', '');
INSERT INTO `feel_province` VALUES (2412, 'SA', 'UZB', '撒马尔罕', 'Samarkand', '');
INSERT INTO `feel_province` VALUES (2413, 'SU', 'UZB', '苏尔汉河', 'Sulhan River', '');
INSERT INTO `feel_province` VALUES (2414, 'TK', 'UZB', '塔什干', 'Tashkent', '');
INSERT INTO `feel_province` VALUES (2415, 'TO', 'UZB', '塔什干市', 'Tashkent City', '');
INSERT INTO `feel_province` VALUES (2416, 'SI', 'UZB', '锡尔河', 'Syr', '');
INSERT INTO `feel_province` VALUES (2417, 'LEI', 'ESP', '阿尔梅里亚', 'Almeria', '');
INSERT INTO `feel_province` VALUES (2418, 'ALB', 'ESP', '阿尔瓦塞特', 'Albacete', '');
INSERT INTO `feel_province` VALUES (2419, 'ALA', 'ESP', '阿拉瓦', 'Alava', '');
INSERT INTO `feel_province` VALUES (2420, 'ALC', 'ESP', '阿利坎特', 'Alicante', '');
INSERT INTO `feel_province` VALUES (2421, 'AST', 'ESP', '阿斯图利亚斯', 'Asturias', '');
INSERT INTO `feel_province` VALUES (2422, 'AVI', 'ESP', '阿维拉', 'Avila', '');
INSERT INTO `feel_province` VALUES (2423, 'ORE', 'ESP', '奥伦塞', 'Ourense', '');
INSERT INTO `feel_province` VALUES (2424, 'BJZ', 'ESP', '巴达霍斯', 'Badajoz', '');
INSERT INTO `feel_province` VALUES (2425, 'BLR', 'ESP', '巴利阿里', 'Balearic', '');
INSERT INTO `feel_province` VALUES (2426, 'VLL', 'ESP', '巴利亚多利德', 'Valladolid', '');
INSERT INTO `feel_province` VALUES (2427, 'VLC', 'ESP', '巴伦西亚', 'Valencia', '');
INSERT INTO `feel_province` VALUES (2428, 'BCN', 'ESP', '巴塞罗那', 'Barcelona', '');
INSERT INTO `feel_province` VALUES (2429, 'VSE', 'ESP', '比斯开', 'Biscayne', '');
INSERT INTO `feel_province` VALUES (2430, 'BUR', 'ESP', '布尔戈斯', 'Burgos', '');
INSERT INTO `feel_province` VALUES (2431, 'GRX', 'ESP', '格拉纳达', 'Granada', '');
INSERT INTO `feel_province` VALUES (2432, 'GUA', 'ESP', '瓜达拉哈拉', 'Guadalajara', '');
INSERT INTO `feel_province` VALUES (2433, 'JAE', 'ESP', '哈恩', 'Hahn', '');
INSERT INTO `feel_province` VALUES (2434, 'GRO', 'ESP', '赫罗纳', 'Girona', '');
INSERT INTO `feel_province` VALUES (2435, 'GUI', 'ESP', '吉普斯夸', 'Gippsqua', '');
INSERT INTO `feel_province` VALUES (2436, 'CAD', 'ESP', '加的斯', 'Cadiz', '');
INSERT INTO `feel_province` VALUES (2437, 'CCS', 'ESP', '卡塞雷斯', 'Caceres', '');
INSERT INTO `feel_province` VALUES (2438, 'CIR', 'ESP', '卡斯蒂利亚', 'Castilla', '');
INSERT INTO `feel_province` VALUES (2439, 'CAS', 'ESP', '卡斯特利翁', 'Castellon', '');
INSERT INTO `feel_province` VALUES (2440, 'ODB', 'ESP', '科尔多瓦', 'Cordova', '');
INSERT INTO `feel_province` VALUES (2441, 'CUE', 'ESP', '昆卡', 'Cuenca', '');
INSERT INTO `feel_province` VALUES (2442, 'LCG', 'ESP', '拉科鲁尼亚', 'La Coruña', '');
INSERT INTO `feel_province` VALUES (2443, 'ARL', 'ESP', '拉里奥哈', 'La Rioja', '');
INSERT INTO `feel_province` VALUES (2444, 'LPA', 'ESP', '拉斯帕尔马斯', 'Las Palmas', '');
INSERT INTO `feel_province` VALUES (2445, 'LEN', 'ESP', '莱昂', 'Leon', '');
INSERT INTO `feel_province` VALUES (2446, 'LLE', 'ESP', '莱里达', 'Lleida', '');
INSERT INTO `feel_province` VALUES (2447, 'LGO', 'ESP', '卢戈', 'Lugo', '');
INSERT INTO `feel_province` VALUES (2448, 'MAD', 'ESP', '马德里', 'Madrid', '');
INSERT INTO `feel_province` VALUES (2449, 'AGP', 'ESP', '马拉加', 'Malaga', '');
INSERT INTO `feel_province` VALUES (2450, 'MJV', 'ESP', '穆尔西亚', 'Murcia', '');
INSERT INTO `feel_province` VALUES (2451, 'NVV', 'ESP', '纳瓦拉', 'Navarre', '');
INSERT INTO `feel_province` VALUES (2452, 'PAC', 'ESP', '帕伦西亚', 'Palencia', '');
INSERT INTO `feel_province` VALUES (2453, 'PEV', 'ESP', '蓬特韦德拉', 'Pontevedra', '');
INSERT INTO `feel_province` VALUES (2454, 'ZAZ', 'ESP', '萨拉戈萨', 'Zaragoza', '');
INSERT INTO `feel_province` VALUES (2455, 'SLM', 'ESP', '萨拉曼卡', 'Salamanca', '');
INSERT INTO `feel_province` VALUES (2456, 'ZMR', 'ESP', '萨莫拉', 'Zamora', '');
INSERT INTO `feel_province` VALUES (2457, 'SEG', 'ESP', '塞哥维亚', 'Segovia', '');
INSERT INTO `feel_province` VALUES (2458, 'SVQ', 'ESP', '塞维利亚', 'Seville', '');
INSERT INTO `feel_province` VALUES (2459, 'SDR', 'ESP', '桑坦德', 'Santander', '');
INSERT INTO `feel_province` VALUES (2460, 'SCT', 'ESP', '圣克鲁斯德特内里费', 'Santa Cruz de Tenerife', '');
INSERT INTO `feel_province` VALUES (2461, 'SOR', 'ESP', '索里亚', 'Soria', '');
INSERT INTO `feel_province` VALUES (2462, 'TAR', 'ESP', '塔拉戈纳', 'Tarragona', '');
INSERT INTO `feel_province` VALUES (2463, 'TER', 'ESP', '特鲁埃尔', 'Teruel', '');
INSERT INTO `feel_province` VALUES (2464, 'TOL', 'ESP', '托莱多', 'Toledo', '');
INSERT INTO `feel_province` VALUES (2465, 'HUV', 'ESP', '韦尔瓦', 'Huelva', '');
INSERT INTO `feel_province` VALUES (2466, 'HUC', 'ESP', '韦斯卡', 'Huesca', '');
INSERT INTO `feel_province` VALUES (2467, 'PRI', 'GRC', '比雷埃夫斯', 'Piraeus', '');
INSERT INTO `feel_province` VALUES (2468, 'DO', 'GRC', '多德卡尼斯', 'Dodecanese', '');
INSERT INTO `feel_province` VALUES (2469, 'CHQ', 'GRC', '干尼亚', 'Chania', '');
INSERT INTO `feel_province` VALUES (2470, 'CY', 'GRC', '基克拉迪', 'Cyclades', '');
INSERT INTO `feel_province` VALUES (2471, 'LST', 'GRC', '拉西锡', 'Lasithi', '');
INSERT INTO `feel_province` VALUES (2472, 'LES', 'GRC', '莱斯博斯', 'Lesbos', '');
INSERT INTO `feel_province` VALUES (2473, 'RET', 'GRC', '雷西姆农', 'Resimnon', '');
INSERT INTO `feel_province` VALUES (2474, 'SMI', 'GRC', '萨摩斯', 'Samos', '');
INSERT INTO `feel_province` VALUES (2475, 'ATH', 'GRC', '雅典', 'Athens', '');
INSERT INTO `feel_province` VALUES (2476, 'HER', 'GRC', '伊拉克里翁', 'Heraklion', '');
INSERT INTO `feel_province` VALUES (2477, 'AUK', 'NZL', '奥克兰', 'Auckland', '');
INSERT INTO `feel_province` VALUES (2478, 'NSH', 'NZL', '北岸', 'North shore', '');
INSERT INTO `feel_province` VALUES (2479, 'PMR', 'NZL', '北帕默斯顿', 'Palmerston North', '');
INSERT INTO `feel_province` VALUES (2480, 'FNR', 'NZL', '北远', 'Beiyuan', '');
INSERT INTO `feel_province` VALUES (2481, 'BHE', 'NZL', '布莱尼姆', 'Blenheim', '');
INSERT INTO `feel_province` VALUES (2482, 'DUD', 'NZL', '达尼丁', 'Dunedin', '');
INSERT INTO `feel_province` VALUES (2483, 'GMN', 'NZL', '格雷茅斯', 'Greymouth', '');
INSERT INTO `feel_province` VALUES (2484, 'HLZ', 'NZL', '哈密尔顿', 'Hamilton', '');
INSERT INTO `feel_province` VALUES (2485, 'HAS', 'NZL', '黑斯廷斯', 'Hastings', '');
INSERT INTO `feel_province` VALUES (2486, 'WAE', 'NZL', '怀塔科拉', 'Waitakela', '');
INSERT INTO `feel_province` VALUES (2487, 'GIS', 'NZL', '吉斯伯恩', 'Gisborne', '');
INSERT INTO `feel_province` VALUES (2488, 'KAI', 'NZL', '凯帕拉', 'Kepala', '');
INSERT INTO `feel_province` VALUES (2489, 'CHC', 'NZL', '克赖斯特彻奇', 'Christchurch', '');
INSERT INTO `feel_province` VALUES (2490, 'RMD', 'NZL', '里士满', 'Richmond', '');
INSERT INTO `feel_province` VALUES (2491, 'MNK', 'NZL', '马努考', 'Manukau', '');
INSERT INTO `feel_province` VALUES (2492, 'NSN', 'NZL', '纳尔逊', 'Nelson', '');
INSERT INTO `feel_province` VALUES (2493, 'NPE', 'NZL', '内皮尔', 'Napier', '');
INSERT INTO `feel_province` VALUES (2494, 'STR', 'NZL', '斯特拉特福德', 'Stratford', '');
INSERT INTO `feel_province` VALUES (2495, 'TAU', 'NZL', '陶马鲁努伊', 'Taumarunui', '');
INSERT INTO `feel_province` VALUES (2496, 'WHK', 'NZL', '瓦卡塔尼', 'Wakatani', '');
INSERT INTO `feel_province` VALUES (2497, 'WRE', 'NZL', '旺阿雷', 'Whangarei', '');
INSERT INTO `feel_province` VALUES (2498, 'WAG', 'NZL', '旺格努伊', 'Whanganui', '');
INSERT INTO `feel_province` VALUES (2499, 'NPL', 'NZL', '新普利茅斯', 'New plymouth', '');
INSERT INTO `feel_province` VALUES (2500, 'IVC', 'NZL', '因弗卡吉尔', 'Invercargill', '');
INSERT INTO `feel_province` VALUES (2501, 'BA', 'HUN', '巴兰尼亚', 'Baranya', '');
INSERT INTO `feel_province` VALUES (2502, 'BK', 'HUN', '巴奇基什孔', 'Bakikiskon', '');
INSERT INTO `feel_province` VALUES (2503, 'BZ', 'HUN', '包尔绍德奥包乌伊曾普伦', 'Bauerhodebau Ujzenpuren', '');
INSERT INTO `feel_province` VALUES (2504, 'BE', 'HUN', '贝凯什', 'Bekesh', '');
INSERT INTO `feel_province` VALUES (2505, 'BU', 'HUN', '布达佩斯', 'Budapest', '');
INSERT INTO `feel_province` VALUES (2506, 'FE', 'HUN', '费耶尔', 'Feyer', '');
INSERT INTO `feel_province` VALUES (2507, 'HB', 'HUN', '豪伊杜比豪尔', 'Haj Dubyauer', '');
INSERT INTO `feel_province` VALUES (2508, 'HE', 'HUN', '赫维什', 'Heves', '');
INSERT INTO `feel_province` VALUES (2509, 'JN', 'HUN', '加兹纳杰孔索尔诺克', 'Gaznaj Kong Solnock', '');
INSERT INTO `feel_province` VALUES (2510, 'GS', 'HUN', '杰尔莫松肖普朗', 'Jermoson Sopron', '');
INSERT INTO `feel_province` VALUES (2511, 'KE', 'HUN', '科马罗姆', 'Komarom', '');
INSERT INTO `feel_province` VALUES (2512, 'NO', 'HUN', '诺格拉德', 'Nograd', '');
INSERT INTO `feel_province` VALUES (2513, 'PE', 'HUN', '佩斯', 'Pace', '');
INSERT INTO `feel_province` VALUES (2514, 'CS', 'HUN', '琼格拉德', 'Joangrad', '');
INSERT INTO `feel_province` VALUES (2515, 'SO', 'HUN', '绍莫吉', 'Somoji', '');
INSERT INTO `feel_province` VALUES (2516, 'SZ', 'HUN', '索博尔奇索特马尔贝拉格', 'Sobolchit Marbella', '');
INSERT INTO `feel_province` VALUES (2517, 'TO', 'HUN', '托尔瑙', 'Tornau', '');
INSERT INTO `feel_province` VALUES (2518, 'VE', 'HUN', '维斯普雷姆', 'Vesprem', '');
INSERT INTO `feel_province` VALUES (2519, 'VA', 'HUN', '沃什', 'Walsh', '');
INSERT INTO `feel_province` VALUES (2520, 'ZA', 'HUN', '佐洛', 'Zolo', '');
INSERT INTO `feel_province` VALUES (2521, 'HL', 'SYR', '阿勒颇', 'Aleppo', '');
INSERT INTO `feel_province` VALUES (2522, 'RD', 'SYR', '大马士革', 'Damascus', '');
INSERT INTO `feel_province` VALUES (2523, 'DI', 'SYR', '大马士革市', 'Damascus City', '');
INSERT INTO `feel_province` VALUES (2524, 'DZ', 'SYR', '代尔祖尔', 'Deir zuer', '');
INSERT INTO `feel_province` VALUES (2525, 'DA', 'SYR', '德拉', 'Della', '');
INSERT INTO `feel_province` VALUES (2526, 'HM', 'SYR', '哈马', 'Hama', '');
INSERT INTO `feel_province` VALUES (2527, 'HA', 'SYR', '哈塞克', 'Hasek', '');
INSERT INTO `feel_province` VALUES (2528, 'HI', 'SYR', '霍姆斯', 'Holmes', '');
INSERT INTO `feel_province` VALUES (2529, 'GH', 'SYR', '加布', 'Gab', '');
INSERT INTO `feel_province` VALUES (2530, 'QA', 'SYR', '卡米什利', 'Kamishli', '');
INSERT INTO `feel_province` VALUES (2531, 'QU', 'SYR', '库奈特拉', 'Cunette', '');
INSERT INTO `feel_province` VALUES (2532, 'RQ', 'SYR', '拉卡', 'Laka', '');
INSERT INTO `feel_province` VALUES (2533, 'LA', 'SYR', '拉塔基亚', 'Latakia', '');
INSERT INTO `feel_province` VALUES (2534, 'SU', 'SYR', '苏韦达', 'Suveda', '');
INSERT INTO `feel_province` VALUES (2535, 'TA', 'SYR', '塔尔图斯', 'Tartus', '');
INSERT INTO `feel_province` VALUES (2536, 'ID', 'SYR', '伊德利卜', 'Idlib', '');
INSERT INTO `feel_province` VALUES (2537, 'POR', 'JAM', '波特兰', 'Portland', '');
INSERT INTO `feel_province` VALUES (2538, 'HAN', 'JAM', '汉诺威', 'Hannover', '');
INSERT INTO `feel_province` VALUES (2539, 'KIN', 'JAM', '金斯敦', 'Kingston', '');
INSERT INTO `feel_province` VALUES (2540, 'CLA', 'JAM', '克拉伦登', 'Clarendon', '');
INSERT INTO `feel_province` VALUES (2541, 'MAN', 'JAM', '曼彻斯特', 'Manchester', '');
INSERT INTO `feel_province` VALUES (2542, 'AND', 'JAM', '圣安德鲁斯', 'St. Andrews', '');
INSERT INTO `feel_province` VALUES (2543, 'ANN', 'JAM', '圣安娜', 'Santa Ana', '');
INSERT INTO `feel_province` VALUES (2544, 'CAT', 'JAM', '圣凯瑟琳', 'St. Catherine', '');
INSERT INTO `feel_province` VALUES (2545, 'MAR', 'JAM', '圣玛丽', 'St. Mary', '');
INSERT INTO `feel_province` VALUES (2546, 'THO', 'JAM', '圣托马斯', 'St. Thomas', '');
INSERT INTO `feel_province` VALUES (2547, 'ELI', 'JAM', '圣伊丽莎白', 'St. Elizabeth', '');
INSERT INTO `feel_province` VALUES (2548, 'JAM', 'JAM', '圣詹姆斯', 'Saint jam', '');
INSERT INTO `feel_province` VALUES (2549, 'TRL', 'JAM', '特里洛尼', 'Trilloni', '');
INSERT INTO `feel_province` VALUES (2550, 'WML', 'JAM', '西摩兰', 'Seymour', '');
INSERT INTO `feel_province` VALUES (2551, 'ARM', 'ARM', '阿尔马维尔', 'Almaville', '');
INSERT INTO `feel_province` VALUES (2552, 'AGT', 'ARM', '阿拉加措特恩', 'Alagatot', '');
INSERT INTO `feel_province` VALUES (2553, 'ARA', 'ARM', '阿拉拉特', 'Ararat', '');
INSERT INTO `feel_province` VALUES (2554, 'EVN', 'ARM', '埃里温市', 'Yerevan', '');
INSERT INTO `feel_province` VALUES (2555, 'GEG', 'ARM', '格加尔库尼克', 'Ggarkunik', '');
INSERT INTO `feel_province` VALUES (2556, 'KOT', 'ARM', '科泰克', 'Kotek', '');
INSERT INTO `feel_province` VALUES (2557, 'LOR', 'ARM', '洛里', 'Lori', '');
INSERT INTO `feel_province` VALUES (2558, 'TAV', 'ARM', '塔武什', 'Tavush', '');
INSERT INTO `feel_province` VALUES (2559, 'VAY', 'ARM', '瓦约茨·佐尔', 'Vayoz Zor', '');
INSERT INTO `feel_province` VALUES (2560, 'SHI', 'ARM', '希拉克', 'Chirac', '');
INSERT INTO `feel_province` VALUES (2561, 'SYU', 'ARM', '休尼克', 'Hughnik', '');
INSERT INTO `feel_province` VALUES (2562, 'AB', 'YEM', '阿比扬', 'Abyan', '');
INSERT INTO `feel_province` VALUES (2563, 'AM', 'YEM', '阿姆兰', 'Amran', '');
INSERT INTO `feel_province` VALUES (2564, 'BA', 'YEM', '贝达', 'Beda', '');
INSERT INTO `feel_province` VALUES (2565, 'DA', 'YEM', '达利', 'Dali', '');
INSERT INTO `feel_province` VALUES (2566, 'HD', 'YEM', '哈德拉毛', 'Hadrama', '');
INSERT INTO `feel_province` VALUES (2567, 'HJ', 'YEM', '哈杰', 'Haj', '');
INSERT INTO `feel_province` VALUES (2568, 'HU', 'YEM', '荷台达', 'Hodda', '');
INSERT INTO `feel_province` VALUES (2569, 'JA', 'YEM', '焦夫', 'Jiaofu', '');
INSERT INTO `feel_province` VALUES (2570, 'LA', 'YEM', '拉赫季', 'Lahti', '');
INSERT INTO `feel_province` VALUES (2571, 'MA', 'YEM', '马里卜', 'Marib', '');
INSERT INTO `feel_province` VALUES (2572, 'MR', 'YEM', '迈赫拉', 'Mehra', '');
INSERT INTO `feel_province` VALUES (2573, 'MW', 'YEM', '迈赫维特', 'Mehwitt', '');
INSERT INTO `feel_province` VALUES (2574, 'SD', 'YEM', '萨达', 'Sada', '');
INSERT INTO `feel_province` VALUES (2575, 'SN', 'YEM', '萨那', 'Sana', '');
INSERT INTO `feel_province` VALUES (2576, 'GXF', 'YEM', '赛文', 'Severn', '');
INSERT INTO `feel_province` VALUES (2577, 'SH', 'YEM', '舍卜沃', 'Shebwo', '');
INSERT INTO `feel_province` VALUES (2578, 'TA', 'YEM', '塔伊兹', 'Taiz', '');
INSERT INTO `feel_province` VALUES (2579, 'ASR', 'YEM', '希赫尔', 'Hihr', '');
INSERT INTO `feel_province` VALUES (2580, 'AD', 'YEM', '亚丁', 'Aden', '');
INSERT INTO `feel_province` VALUES (2581, 'IB', 'YEM', '伊卜', 'Ib', '');
INSERT INTO `feel_province` VALUES (2582, 'DH', 'YEM', '扎玛尔', 'Zamal', '');
INSERT INTO `feel_province` VALUES (2583, 'ASH', 'ISR', '阿什杜德', 'Ashdod', '');
INSERT INTO `feel_province` VALUES (2584, 'BEV', 'ISR', '贝尔谢巴', 'Beersheba', '');
INSERT INTO `feel_province` VALUES (2585, 'BAT', 'ISR', '贝特雁', 'Beit Goose', '');
INSERT INTO `feel_province` VALUES (2586, 'HFA', 'ISR', '海法', 'Haifa', '');
INSERT INTO `feel_province` VALUES (2587, 'HOL', 'ISR', '霍隆', 'Holon', '');
INSERT INTO `feel_province` VALUES (2588, 'NAT', 'ISR', '内坦亚', 'Netanya', '');
INSERT INTO `feel_province` VALUES (2589, 'TLV', 'ISR', '特拉维夫', 'Tel Aviv', '');
INSERT INTO `feel_province` VALUES (2590, 'J', 'ISR', '耶路撒冷', 'Jerusalem', '');
INSERT INTO `feel_province` VALUES (2591, 'AST', 'ITA', '阿斯蒂', 'Asti', '');
INSERT INTO `feel_province` VALUES (2592, 'ASP', 'ITA', '阿斯科利皮切诺', 'Ascoli Piceno', '');
INSERT INTO `feel_province` VALUES (2593, 'AOI', 'ITA', '安科纳', 'Ancona', '');
INSERT INTO `feel_province` VALUES (2594, 'OLB', 'ITA', '奥尔比亚', 'Olbia', '');
INSERT INTO `feel_province` VALUES (2595, 'QOS', 'ITA', '奥里斯塔诺', 'Oristano', '');
INSERT INTO `feel_province` VALUES (2596, 'AOT', 'ITA', '奥斯塔', 'Aosta', '');
INSERT INTO `feel_province` VALUES (2597, 'PMO', 'ITA', '巴勒莫', 'Palermo', '');
INSERT INTO `feel_province` VALUES (2598, 'BRI', 'ITA', '巴里', 'Barry', '');
INSERT INTO `feel_province` VALUES (2599, 'BGO', 'ITA', '贝加莫', 'Bergamo', '');
INSERT INTO `feel_province` VALUES (2600, 'BEN', 'ITA', '贝内文托', 'Benevento', '');
INSERT INTO `feel_province` VALUES (2601, 'PSA', 'ITA', '比萨', 'pizza', '');
INSERT INTO `feel_province` VALUES (2602, 'PRD', 'ITA', '波代诺内', 'Pordenone', '');
INSERT INTO `feel_province` VALUES (2603, 'QPO', 'ITA', '波坦察', 'Potenza', '');
INSERT INTO `feel_province` VALUES (2604, 'BLQ', 'ITA', '博洛尼亚', 'Bologna', '');
INSERT INTO `feel_province` VALUES (2605, 'BIE', 'ITA', '布拉', 'Bra', '');
INSERT INTO `feel_province` VALUES (2606, 'BRC', 'ITA', '布雷西亚', 'Brescia', '');
INSERT INTO `feel_province` VALUES (2607, 'BDS', 'ITA', '布林迪西', 'Brindisi', '');
INSERT INTO `feel_province` VALUES (2608, 'TRS', 'ITA', '的里雅斯特', 'Trieste', '');
INSERT INTO `feel_province` VALUES (2609, 'TRN', 'ITA', '都灵', 'Turin', '');
INSERT INTO `feel_province` VALUES (2610, 'FRR', 'ITA', '费拉拉', 'Ferrara', '');
INSERT INTO `feel_province` VALUES (2611, 'FLR', 'ITA', '佛罗伦萨', 'Florence', '');
INSERT INTO `feel_province` VALUES (2612, 'FOG', 'ITA', '福贾', 'Foggia', '');
INSERT INTO `feel_province` VALUES (2613, 'CAG', 'ITA', '卡利亚里', 'Cagliari', '');
INSERT INTO `feel_province` VALUES (2614, 'CST', 'ITA', '卡塞塔', 'Caserta', '');
INSERT INTO `feel_province` VALUES (2615, 'CTA', 'ITA', '卡塔尼亚', 'Catania', '');
INSERT INTO `feel_province` VALUES (2616, 'QCZ', 'ITA', '卡坦扎罗', 'Catanzaro', '');
INSERT INTO `feel_province` VALUES (2617, 'COB', 'ITA', '坎波巴索', 'Campobasso', '');
INSERT INTO `feel_province` VALUES (2618, 'CIY', 'ITA', '科摩', 'Como', '');
INSERT INTO `feel_province` VALUES (2619, 'QCS', 'ITA', '科森扎', 'Cosenza', '');
INSERT INTO `feel_province` VALUES (2620, 'CRV', 'ITA', '克罗托内', 'Crotone', '');
INSERT INTO `feel_province` VALUES (2621, 'CUN', 'ITA', '库内奥', 'Cuneo', '');
INSERT INTO `feel_province` VALUES (2622, 'LAQ', 'ITA', '拉奎拉', 'L\'Aquila', '');
INSERT INTO `feel_province` VALUES (2623, 'SPE', 'ITA', '拉斯佩齐亚', 'La Spezia', '');
INSERT INTO `feel_province` VALUES (2624, 'LCO', 'ITA', '莱科', 'Lecco', '');
INSERT INTO `feel_province` VALUES (2625, 'LCC', 'ITA', '莱切', 'Lecce', '');
INSERT INTO `feel_province` VALUES (2626, 'RNE', 'ITA', '雷焦艾米利亚', 'Reggio Emilia', '');
INSERT INTO `feel_province` VALUES (2627, 'REG', 'ITA', '雷焦卡拉布里亚', 'Reggio Calabria', '');
INSERT INTO `feel_province` VALUES (2628, 'LIV', 'ITA', '里窝那', 'Livorno', '');
INSERT INTO `feel_province` VALUES (2629, 'ROM', 'ITA', '罗马', 'Rome', '');
INSERT INTO `feel_province` VALUES (2630, 'MCR', 'ITA', '马萨', 'Massa', '');
INSERT INTO `feel_province` VALUES (2631, 'MTR', 'ITA', '马泰拉', 'Matera', '');
INSERT INTO `feel_province` VALUES (2632, 'MZA', 'ITA', '蒙扎', 'Monza', '');
INSERT INTO `feel_province` VALUES (2633, 'MIL', 'ITA', '米兰', 'Milan', '');
INSERT INTO `feel_province` VALUES (2634, 'MOD', 'ITA', '摩德纳', 'Modena', '');
INSERT INTO `feel_province` VALUES (2635, 'MSN', 'ITA', '墨西拿', 'Messina', '');
INSERT INTO `feel_province` VALUES (2636, 'NAP', 'ITA', '那不勒斯', 'Naples', '');
INSERT INTO `feel_province` VALUES (2637, 'QNU', 'ITA', '努奥罗', 'Nuoro', '');
INSERT INTO `feel_province` VALUES (2638, 'NVR', 'ITA', '诺瓦拉', 'Novara', '');
INSERT INTO `feel_province` VALUES (2639, 'PMF', 'ITA', '帕尔马', 'Parma', '');
INSERT INTO `feel_province` VALUES (2640, 'PAV', 'ITA', '帕维亚', 'Pavia', '');
INSERT INTO `feel_province` VALUES (2641, 'PEG', 'ITA', '佩鲁贾', 'Perugia', '');
INSERT INTO `feel_province` VALUES (2642, 'CAX', 'ITA', '热那亚', 'Genoa', '');
INSERT INTO `feel_province` VALUES (2643, 'SAL', 'ITA', '萨莱诺', 'Salerno', '');
INSERT INTO `feel_province` VALUES (2644, 'QSS', 'ITA', '萨萨里', 'Sassari', '');
INSERT INTO `feel_province` VALUES (2645, 'SVN', 'ITA', '萨沃纳', 'Savona', '');
INSERT INTO `feel_province` VALUES (2646, 'TAR', 'ITA', '塔兰托', 'Taranto', '');
INSERT INTO `feel_province` VALUES (2647, 'TPS', 'ITA', '特拉帕尼', 'Trapani', '');
INSERT INTO `feel_province` VALUES (2648, 'TRT', 'ITA', '特伦托', 'Trento', '');
INSERT INTO `feel_province` VALUES (2649, 'VCE', 'ITA', '威尼斯', 'Venice', '');
INSERT INTO `feel_province` VALUES (2650, 'VRL', 'ITA', '韦尔切利', 'Vercelli', '');
INSERT INTO `feel_province` VALUES (2651, 'VIT', 'ITA', '维泰博', 'Viterbo', '');
INSERT INTO `feel_province` VALUES (2652, 'UDN', 'ITA', '乌迪内', 'Udine', '');
INSERT INTO `feel_province` VALUES (2653, 'SYR', 'ITA', '锡拉库扎', 'Syracuse', '');
INSERT INTO `feel_province` VALUES (2654, 'SNA', 'ITA', '锡耶纳', 'Siena', '');
INSERT INTO `feel_province` VALUES (2655, 'ALE', 'ITA', '亚历山德里亚', 'Alexandria', '');
INSERT INTO `feel_province` VALUES (2656, 'ISE', 'ITA', '伊塞尔尼亚', 'Isernia', '');
INSERT INTO `feel_province` VALUES (2657, 'AJL', 'IND', '艾藻尔', 'Ai Cao', '');
INSERT INTO `feel_province` VALUES (2658, 'BLR', 'IND', '班加罗尔', 'Bangalore', '');
INSERT INTO `feel_province` VALUES (2659, 'PNY', 'IND', '本地治里', 'Pondicherry', '');
INSERT INTO `feel_province` VALUES (2660, 'BHO', 'IND', '博帕尔', 'Bhopal', '');
INSERT INTO `feel_province` VALUES (2661, 'BBI', 'IND', '布巴内斯瓦尔', 'Bhubaneswar', '');
INSERT INTO `feel_province` VALUES (2662, 'IXC', 'IND', '昌迪加尔', 'Chandigarh', '');
INSERT INTO `feel_province` VALUES (2663, 'DAM', 'IND', '达曼', 'Dammam', '');
INSERT INTO `feel_province` VALUES (2664, 'DIU', 'IND', '第乌', 'Diwu', '');
INSERT INTO `feel_province` VALUES (2665, 'GTO', 'IND', '甘托克', 'Gangtok', '');
INSERT INTO `feel_province` VALUES (2666, 'CJB', 'IND', '哥印拜陀', 'Coimbatore', '');
INSERT INTO `feel_province` VALUES (2667, 'CCU', 'IND', '加尔各答', 'Kolkata', '');
INSERT INTO `feel_province` VALUES (2668, 'KRK', 'IND', '加里加尔', 'Garrigal', '');
INSERT INTO `feel_province` VALUES (2669, 'JLR', 'IND', '贾巴尔普尔', 'Jabalpur', '');
INSERT INTO `feel_province` VALUES (2670, 'JUC', 'IND', '贾朗达尔', 'Jalandhar', '');
INSERT INTO `feel_province` VALUES (2671, 'JDH', 'IND', '焦特布尔', 'Jodhpur', '');
INSERT INTO `feel_province` VALUES (2672, 'MAA', 'IND', '金奈', 'Kanana', '');
INSERT INTO `feel_province` VALUES (2673, 'KVA', 'IND', '卡瓦拉蒂', 'Cavalati', '');
INSERT INTO `feel_province` VALUES (2674, 'KOM', 'IND', '科希马', 'Kosima', '');
INSERT INTO `feel_province` VALUES (2675, 'MAH', 'IND', '马埃', 'Mahe', '');
INSERT INTO `feel_province` VALUES (2676, 'IXM', 'IND', '马杜赖', 'Madurai', '');
INSERT INTO `feel_province` VALUES (2677, 'SLR', 'IND', '森伯尔布尔', 'Sunburpur', '');
INSERT INTO `feel_province` VALUES (2678, 'TRV', 'IND', '特里凡得琅', 'Trivandrum', '');
INSERT INTO `feel_province` VALUES (2679, 'UDR', 'IND', '乌代布尔', 'Udaipur', '');
INSERT INTO `feel_province` VALUES (2680, 'SHL', 'IND', '西隆', 'Shillong', '');
INSERT INTO `feel_province` VALUES (2681, 'SIL', 'IND', '锡尔萨瓦', 'Silsava', '');
INSERT INTO `feel_province` VALUES (2682, 'ICD', 'IND', '新德里', 'New Delhi', '');
INSERT INTO `feel_province` VALUES (2683, 'SRV', 'IND', '亚南', 'Yanan', '');
INSERT INTO `feel_province` VALUES (2684, 'IMF', 'IND', '因帕尔', 'Impal', '');
INSERT INTO `feel_province` VALUES (2685, 'IDR', 'IND', '印多尔', 'Indore', '');
INSERT INTO `feel_province` VALUES (2686, 'JAI', 'IND', '斋普尔', 'Jaipur', '');
INSERT INTO `feel_province` VALUES (2687, 'BA', 'IDN', '巴厘', 'Bali', '');
INSERT INTO `feel_province` VALUES (2688, 'BB', 'IDN', '邦加－勿里洞群岛', 'Bangka-Belitung Islands', '');
INSERT INTO `feel_province` VALUES (2689, 'SA', 'IDN', '北苏拉威西', 'North Sulawesi', '');
INSERT INTO `feel_province` VALUES (2690, 'SU', 'IDN', '北苏门答腊', 'North Sumatra', '');
INSERT INTO `feel_province` VALUES (2691, 'KB', 'IDN', '大雅加达首都特区', 'Greater Jakarta Capital Territory', '');
INSERT INTO `feel_province` VALUES (2692, 'KI', 'IDN', '东加里曼丹', 'East kalimantan', '');
INSERT INTO `feel_province` VALUES (2693, 'SG', 'IDN', '东南苏拉威西', 'Southeast Sulawesi', '');
INSERT INTO `feel_province` VALUES (2694, 'NT', 'IDN', '东努沙登加拉', 'East Nusa Tenggara', '');
INSERT INTO `feel_province` VALUES (2695, 'JI', 'IDN', '东爪哇', 'East Java', '');
INSERT INTO `feel_province` VALUES (2696, 'RI', 'IDN', '廖内', 'Shonai', '');
INSERT INTO `feel_province` VALUES (2697, 'MA', 'IDN', '马鲁古', 'Maluku', '');
INSERT INTO `feel_province` VALUES (2698, 'BE', 'IDN', '明古鲁', 'Minggulu', '');
INSERT INTO `feel_province` VALUES (2699, 'LA', 'IDN', '楠榜', 'Lampung', '');
INSERT INTO `feel_province` VALUES (2700, 'KS', 'IDN', '南加里曼丹', 'South kalimantan', '');
INSERT INTO `feel_province` VALUES (2701, 'SN', 'IDN', '南苏拉威西', 'South sulawesi', '');
INSERT INTO `feel_province` VALUES (2702, 'SS', 'IDN', '南苏门答腊', 'South Sumatra', '');
INSERT INTO `feel_province` VALUES (2703, 'YO', 'IDN', '日惹特区', 'Yogyakarta', '');
INSERT INTO `feel_province` VALUES (2704, 'BT', 'IDN', '万丹', 'Banten', '');
INSERT INTO `feel_province` VALUES (2705, 'NB', 'IDN', '西努沙登加拉', 'West Nusa Tenggara', '');
INSERT INTO `feel_province` VALUES (2706, 'SR', 'IDN', '西苏门答腊', 'West Sumatra', '');
INSERT INTO `feel_province` VALUES (2707, 'JB', 'IDN', '西爪哇', 'West Java', '');
INSERT INTO `feel_province` VALUES (2708, 'JK', 'IDN', '雅加达', 'Jakarta', '');
INSERT INTO `feel_province` VALUES (2709, 'AC', 'IDN', '亚齐', 'Aceh', '');
INSERT INTO `feel_province` VALUES (2710, 'IJ', 'IDN', '伊里安查亚', 'Irian Jaya', '');
INSERT INTO `feel_province` VALUES (2711, 'JA', 'IDN', '占碑', 'Monument', '');
INSERT INTO `feel_province` VALUES (2712, 'KT', 'IDN', '中加里曼丹', 'Kalimantan', '');
INSERT INTO `feel_province` VALUES (2713, 'ST', 'IDN', '中苏拉威西', 'Central Sulawesi', '');
INSERT INTO `feel_province` VALUES (2714, 'JT', 'IDN', '中爪哇', 'Central Java', '');
INSERT INTO `feel_province` VALUES (2715, 'NIR', 'GBR', '北爱尔兰', 'Northern Ireland', '');
INSERT INTO `feel_province` VALUES (2716, 'SCT', 'GBR', '苏格兰', 'Scotland', '');
INSERT INTO `feel_province` VALUES (2717, 'WLS', 'GBR', '威尔士', 'Wales', '');
INSERT INTO `feel_province` VALUES (2718, 'ENG', 'GBR', '英格兰', 'England', '');
INSERT INTO `feel_province` VALUES (2719, 'AJ', 'JOR', '阿吉隆', 'Agilon', '');
INSERT INTO `feel_province` VALUES (2720, 'AM', 'JOR', '安曼', 'Amman', '');
INSERT INTO `feel_province` VALUES (2721, 'BA', 'JOR', '拜勒加', 'Bailega', '');
INSERT INTO `feel_province` VALUES (2722, 'JA', 'JOR', '杰拉什', 'Jerash', '');
INSERT INTO `feel_province` VALUES (2723, 'KA', 'JOR', '卡拉克', 'Karak', '');
INSERT INTO `feel_province` VALUES (2724, 'RU', 'JOR', '鲁赛法', 'Russell', '');
INSERT INTO `feel_province` VALUES (2725, 'MN', 'JOR', '马安', 'Ma An', '');
INSERT INTO `feel_province` VALUES (2726, 'MD', 'JOR', '马德巴', 'Madaba', '');
INSERT INTO `feel_province` VALUES (2727, 'MF', 'JOR', '马夫拉克', 'Mafrak', '');
INSERT INTO `feel_province` VALUES (2728, 'TA', 'JOR', '塔菲拉', 'Tafila', '');
INSERT INTO `feel_province` VALUES (2729, 'AQ', 'JOR', '亚喀巴', 'Aqaba', '');
INSERT INTO `feel_province` VALUES (2730, 'IR', 'JOR', '伊尔比德', 'Irbid', '');
INSERT INTO `feel_province` VALUES (2731, 'ZA', 'JOR', '扎尔卡', 'Zarka', '');
INSERT INTO `feel_province` VALUES (2732, 'HP', 'VNM', '海防', 'Haiphong', '');
INSERT INTO `feel_province` VALUES (2733, 'HI', 'VNM', '河内', 'Hanoi', '');
INSERT INTO `feel_province` VALUES (2734, 'HC', 'VNM', '胡志明市', 'Ho Chi Minh City', '');
INSERT INTO `feel_province` VALUES (2735, 'NO', 'ZMB', '北方', 'north', '');
INSERT INTO `feel_province` VALUES (2736, 'EA', 'ZMB', '东方', 'East', '');
INSERT INTO `feel_province` VALUES (2737, 'LP', 'ZMB', '卢阿普拉', 'Luapula', '');
INSERT INTO `feel_province` VALUES (2738, 'LK', 'ZMB', '卢萨卡', 'Lusaka', '');
INSERT INTO `feel_province` VALUES (2739, 'SO', 'ZMB', '南方', 'south', '');
INSERT INTO `feel_province` VALUES (2740, 'CB', 'ZMB', '铜带', 'Copper strip', '');
INSERT INTO `feel_province` VALUES (2741, 'NW', 'ZMB', '西北', 'northwest', '');
INSERT INTO `feel_province` VALUES (2742, 'WE', 'ZMB', '西方', 'West', '');
INSERT INTO `feel_province` VALUES (2743, 'CE', 'ZMB', '中央', 'central', '');
INSERT INTO `feel_province` VALUES (2744, 'AR', 'CHL', '阿劳卡尼亚大区', 'Araucanía', '');
INSERT INTO `feel_province` VALUES (2745, 'AT', 'CHL', '阿塔卡马大区', 'Atacama Region', '');
INSERT INTO `feel_province` VALUES (2746, 'AN', 'CHL', '安托法加斯塔大区', 'Antofagasta Region', '');
INSERT INTO `feel_province` VALUES (2747, 'BI', 'CHL', '比奥比奥大区', 'Bío Bío Region', '');
INSERT INTO `feel_province` VALUES (2748, 'LI', 'CHL', '复活节岛', 'Easter Island', '');
INSERT INTO `feel_province` VALUES (2749, 'LL', 'CHL', '湖大区', 'Lake District', '');
INSERT INTO `feel_province` VALUES (2750, 'CO', 'CHL', '科金博大区', 'Coquimbo', '');
INSERT INTO `feel_province` VALUES (2751, 'ML', 'CHL', '马乌莱大区', 'Maule region', '');
INSERT INTO `feel_province` VALUES (2752, 'MA', 'CHL', '麦哲伦智利南极大区', 'Magellan Chilean Antarctic District', '');
INSERT INTO `feel_province` VALUES (2753, 'RM', 'CHL', '圣地亚哥', 'San Diego', '');
INSERT INTO `feel_province` VALUES (2754, 'TA', 'CHL', '塔拉帕卡大区', 'Tarapaca Region', '');
INSERT INTO `feel_province` VALUES (2755, 'VS', 'CHL', '瓦尔帕莱索大区', 'Valparaiso', '');
INSERT INTO `feel_province` VALUES (2756, 'AI', 'CHL', '伊瓦涅斯将军的艾森大区', 'General Ibanez\'s Essen Region', '');
INSERT INTO `feel_province` VALUES (2757, 'BB', 'CAF', '巴明吉班戈兰', 'Baminji Bangoran', '');
INSERT INTO `feel_province` VALUES (2758, 'BGF', 'CAF', '班吉直辖市', 'Bangui municipality', '');
INSERT INTO `feel_province` VALUES (2759, 'BI', 'CAF', '宾博', 'Bimbo', '');
INSERT INTO `feel_province` VALUES (2760, 'KG', 'CAF', '凯莫', 'Kemo', '');
INSERT INTO `feel_province` VALUES (2761, 'LB', 'CAF', '洛巴伊', 'Lobay', '');
INSERT INTO `feel_province` VALUES (2762, 'HS', 'CAF', '曼贝雷卡代', 'Manberekade', '');
INSERT INTO `feel_province` VALUES (2763, 'MB', 'CAF', '姆博穆', 'Mbomu', '');
INSERT INTO `feel_province` VALUES (2764, 'KB', 'CAF', '纳纳格里比齐', 'Nana Gribzi', '');
INSERT INTO `feel_province` VALUES (2765, 'NM', 'CAF', '纳纳曼贝雷', 'Nanaman Bere', '');
INSERT INTO `feel_province` VALUES (2766, 'SE', 'CAF', '桑加姆巴埃雷', 'Sangambaere', '');
INSERT INTO `feel_province` VALUES (2767, 'HK', 'CAF', '上科托', 'Upper Coto', '');
INSERT INTO `feel_province` VALUES (2768, 'HM', 'CAF', '上姆博穆', 'Upper Mbomu', '');
INSERT INTO `feel_province` VALUES (2769, 'UK', 'CAF', '瓦卡', 'Waka', '');
INSERT INTO `feel_province` VALUES (2770, 'VK', 'CAF', '瓦卡加', 'Wakaga', '');
INSERT INTO `feel_province` VALUES (2771, 'AC', 'CAF', '瓦姆', 'Vam', '');
INSERT INTO `feel_province` VALUES (2772, 'OP', 'CAF', '瓦姆彭代', 'Vampende', '');
INSERT INTO `feel_province` VALUES (2773, 'MP', 'CAF', '翁贝拉姆波科', 'Umberram Poco', '');
INSERT INTO `feel_province` VALUES (2774, 'BK', 'CAF', '下科托', 'Lower Coto', '');

-- ----------------------------
-- Table structure for feel_region
-- ----------------------------
DROP TABLE IF EXISTS `feel_region`;
CREATE TABLE `feel_region`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `country_code` char(3) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '所属国家编码',
  `province_code` char(3) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '所属省份编码',
  `city_code` char(3) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '所属城市编码',
  `code` char(3) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '区县编码',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '城市名',
  `name_en` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '英文名称',
  `name_jp` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '日文名称',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `code`(`country_code`, `province_code`, `city_code`, `code`) USING BTREE,
  INDEX `code_name`(`country_code`, `province_code`, `city_code`, `name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2744 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of feel_region
-- ----------------------------
INSERT INTO `feel_region` VALUES (1, '1', '13', '1', '2', '长安区', 'Chang\'an District', '');
INSERT INTO `feel_region` VALUES (2, '1', '13', '1', '3', '桥东区', 'Qiaodong District', '');
INSERT INTO `feel_region` VALUES (3, '1', '13', '1', '4', '桥西区', 'Qiaoxi District', '');
INSERT INTO `feel_region` VALUES (4, '1', '13', '1', '5', '新华区', 'Xinhua District', '');
INSERT INTO `feel_region` VALUES (5, '1', '13', '1', '7', '井陉矿区', 'Jingjing mining area', '');
INSERT INTO `feel_region` VALUES (6, '1', '13', '1', '8', '裕华区', 'Yuhua District', '');
INSERT INTO `feel_region` VALUES (7, '1', '13', '1', '21', '井陉县', 'Jingyi County', '');
INSERT INTO `feel_region` VALUES (8, '1', '13', '1', '23', '正定县', 'Zhengding County', '');
INSERT INTO `feel_region` VALUES (9, '1', '13', '1', '24', '栾城县', 'Yucheng County', '');
INSERT INTO `feel_region` VALUES (10, '1', '13', '1', '25', '行唐县', 'Xingtang County', '');
INSERT INTO `feel_region` VALUES (11, '1', '13', '1', '26', '灵寿县', 'Lingshou County', '');
INSERT INTO `feel_region` VALUES (12, '1', '13', '1', '27', '高邑县', 'Gaochun County', '');
INSERT INTO `feel_region` VALUES (13, '1', '13', '1', '28', '深泽县', 'Shenze County', '');
INSERT INTO `feel_region` VALUES (14, '1', '13', '1', '29', '赞皇县', 'Zanhuang County', '');
INSERT INTO `feel_region` VALUES (15, '1', '13', '1', '30', '无极县', 'Wuji County', '');
INSERT INTO `feel_region` VALUES (16, '1', '13', '1', '31', '平山县', 'Pingshan County', '');
INSERT INTO `feel_region` VALUES (17, '1', '13', '1', '32', '元氏县', 'Yuanshi County', '');
INSERT INTO `feel_region` VALUES (18, '1', '13', '1', '33', '赵县', 'Zhao County', '');
INSERT INTO `feel_region` VALUES (19, '1', '13', '1', '81', '辛集市', 'Xinji City', '');
INSERT INTO `feel_region` VALUES (20, '1', '13', '1', '82', '藁城市', 'Gao city', '');
INSERT INTO `feel_region` VALUES (21, '1', '13', '1', '83', '晋州市', 'Jinzhou City', '');
INSERT INTO `feel_region` VALUES (22, '1', '13', '1', '84', '新乐市', 'Xinle City', '');
INSERT INTO `feel_region` VALUES (23, '1', '13', '1', '85', '鹿泉市', 'Luquan City', '');
INSERT INTO `feel_region` VALUES (24, '1', '13', '2', '2', '路南区', 'Lunan District', '');
INSERT INTO `feel_region` VALUES (25, '1', '13', '2', '3', '路北区', 'Lubei District', '');
INSERT INTO `feel_region` VALUES (26, '1', '13', '2', '4', '古冶区', 'Guye District', '');
INSERT INTO `feel_region` VALUES (27, '1', '13', '2', '5', '开平区', 'Kaiping District', '');
INSERT INTO `feel_region` VALUES (28, '1', '13', '2', '7', '丰南区', 'Fengnan District', '');
INSERT INTO `feel_region` VALUES (29, '1', '13', '2', '8', '丰润区', 'Fengrun District', '');
INSERT INTO `feel_region` VALUES (30, '1', '13', '2', '9', '曹妃甸区', 'Caofeidian District', '');
INSERT INTO `feel_region` VALUES (31, '1', '13', '2', '23', '滦　县', 'Luan County', '');
INSERT INTO `feel_region` VALUES (32, '1', '13', '2', '24', '滦南县', 'Yinan County', '');
INSERT INTO `feel_region` VALUES (33, '1', '13', '2', '25', '乐亭县', 'Laoting County', '');
INSERT INTO `feel_region` VALUES (34, '1', '13', '2', '27', '迁西县', 'Qianxi County', '');
INSERT INTO `feel_region` VALUES (35, '1', '13', '2', '29', '玉田县', 'Yutian County', '');
INSERT INTO `feel_region` VALUES (36, '1', '13', '2', '81', '遵化市', 'Zunhua City', '');
INSERT INTO `feel_region` VALUES (37, '1', '13', '2', '83', '迁安市', 'Qian\'an City', '');
INSERT INTO `feel_region` VALUES (38, '1', '13', '3', '2', '海港区', 'Harbour area', '');
INSERT INTO `feel_region` VALUES (39, '1', '13', '3', '3', '山海关区', 'Shanhaiguan District', '');
INSERT INTO `feel_region` VALUES (40, '1', '13', '3', '4', '北戴河区', 'Beidaihe District', '');
INSERT INTO `feel_region` VALUES (41, '1', '13', '3', '21', '青龙满族自治县', 'Qinglong Manchu Autonomous County', '');
INSERT INTO `feel_region` VALUES (42, '1', '13', '3', '22', '昌黎县', 'Changli County', '');
INSERT INTO `feel_region` VALUES (43, '1', '13', '3', '23', '抚宁县', 'Funing County', '');
INSERT INTO `feel_region` VALUES (44, '1', '13', '3', '24', '卢龙县', 'Lulong County', '');
INSERT INTO `feel_region` VALUES (45, '1', '13', '4', '2', '邯山区', 'Laoshan District', '');
INSERT INTO `feel_region` VALUES (46, '1', '13', '4', '3', '丛台区', 'Congtai District', '');
INSERT INTO `feel_region` VALUES (47, '1', '13', '4', '4', '复兴区', 'Fuxing District', '');
INSERT INTO `feel_region` VALUES (48, '1', '13', '4', '6', '峰峰矿区', 'Fengfeng Mining Area', '');
INSERT INTO `feel_region` VALUES (49, '1', '13', '4', '21', '邯郸县', 'Ji County', '');
INSERT INTO `feel_region` VALUES (50, '1', '13', '4', '23', '临漳县', 'Linyi County', '');
INSERT INTO `feel_region` VALUES (51, '1', '13', '4', '24', '成安县', 'Cheng\'an County', '');
INSERT INTO `feel_region` VALUES (52, '1', '13', '4', '25', '大名县', 'Daming County', '');
INSERT INTO `feel_region` VALUES (53, '1', '13', '4', '26', '涉　县', 'County', '');
INSERT INTO `feel_region` VALUES (54, '1', '13', '4', '27', '磁　县', 'Magnetic county', '');
INSERT INTO `feel_region` VALUES (55, '1', '13', '4', '28', '肥乡县', 'Feixiang County', '');
INSERT INTO `feel_region` VALUES (56, '1', '13', '4', '29', '永年县', 'Yongnian County', '');
INSERT INTO `feel_region` VALUES (57, '1', '13', '4', '30', '邱　县', 'Qiu County', '');
INSERT INTO `feel_region` VALUES (58, '1', '13', '4', '31', '鸡泽县', 'Jize County', '');
INSERT INTO `feel_region` VALUES (59, '1', '13', '4', '32', '广平县', 'Guangping County', '');
INSERT INTO `feel_region` VALUES (60, '1', '13', '4', '33', '馆陶县', 'Guantao County', '');
INSERT INTO `feel_region` VALUES (61, '1', '13', '4', '34', '魏　县', 'Wei County', '');
INSERT INTO `feel_region` VALUES (62, '1', '13', '4', '35', '曲周县', 'Quzhou County', '');
INSERT INTO `feel_region` VALUES (63, '1', '13', '4', '81', '武安市', 'Wu\'an City', '');
INSERT INTO `feel_region` VALUES (64, '1', '13', '5', '2', '桥东区', 'Qiaodong District', '');
INSERT INTO `feel_region` VALUES (65, '1', '13', '5', '3', '桥西区', 'Qiaoxi District', '');
INSERT INTO `feel_region` VALUES (66, '1', '13', '5', '21', '邢台县', 'Xingtai County', '');
INSERT INTO `feel_region` VALUES (67, '1', '13', '5', '22', '临城县', 'Lincheng County', '');
INSERT INTO `feel_region` VALUES (68, '1', '13', '5', '23', '内丘县', 'Neiqiu County', '');
INSERT INTO `feel_region` VALUES (69, '1', '13', '5', '24', '柏乡县', 'Baixiang County', '');
INSERT INTO `feel_region` VALUES (70, '1', '13', '5', '25', '隆尧县', 'Longyan County', '');
INSERT INTO `feel_region` VALUES (71, '1', '13', '5', '26', '任　县', 'Ren County', '');
INSERT INTO `feel_region` VALUES (72, '1', '13', '5', '27', '南和县', 'Nanhe County', '');
INSERT INTO `feel_region` VALUES (73, '1', '13', '5', '28', '宁晋县', 'Ningjin County', '');
INSERT INTO `feel_region` VALUES (74, '1', '13', '5', '29', '巨鹿县', 'Julu County', '');
INSERT INTO `feel_region` VALUES (75, '1', '13', '5', '30', '新河县', 'Xinhe County', '');
INSERT INTO `feel_region` VALUES (76, '1', '13', '5', '31', '广宗县', 'Guangzong County', '');
INSERT INTO `feel_region` VALUES (77, '1', '13', '5', '32', '平乡县', 'Pingxiang County', '');
INSERT INTO `feel_region` VALUES (78, '1', '13', '5', '33', '威　县', 'Wei County', '');
INSERT INTO `feel_region` VALUES (79, '1', '13', '5', '34', '清河县', 'Qinghe County', '');
INSERT INTO `feel_region` VALUES (80, '1', '13', '5', '35', '临西县', 'Linxi County', '');
INSERT INTO `feel_region` VALUES (81, '1', '13', '5', '81', '南宫市', 'Nangong City', '');
INSERT INTO `feel_region` VALUES (82, '1', '13', '5', '82', '沙河市', 'Shahe City', '');
INSERT INTO `feel_region` VALUES (83, '1', '13', '6', '2', '新市区', 'New urban area', '');
INSERT INTO `feel_region` VALUES (84, '1', '13', '6', '3', '北市区', 'North city', '');
INSERT INTO `feel_region` VALUES (85, '1', '13', '6', '4', '南市区', 'South City', '');
INSERT INTO `feel_region` VALUES (86, '1', '13', '6', '21', '满城县', 'Mancheng County', '');
INSERT INTO `feel_region` VALUES (87, '1', '13', '6', '22', '清苑县', 'Qingyuan County', '');
INSERT INTO `feel_region` VALUES (88, '1', '13', '6', '23', '涞水县', 'Yishui County', '');
INSERT INTO `feel_region` VALUES (89, '1', '13', '6', '24', '阜平县', 'Luanping County', '');
INSERT INTO `feel_region` VALUES (90, '1', '13', '6', '25', '徐水县', 'Xushui County', '');
INSERT INTO `feel_region` VALUES (91, '1', '13', '6', '26', '定兴县', 'Dingxing County', '');
INSERT INTO `feel_region` VALUES (92, '1', '13', '6', '27', '唐　县', 'Tang County', '');
INSERT INTO `feel_region` VALUES (93, '1', '13', '6', '28', '高阳县', 'Gaoyang County', '');
INSERT INTO `feel_region` VALUES (94, '1', '13', '6', '29', '容城县', 'Rongcheng County', '');
INSERT INTO `feel_region` VALUES (95, '1', '13', '6', '30', '涞源县', 'Wuyuan County', '');
INSERT INTO `feel_region` VALUES (96, '1', '13', '6', '31', '望都县', 'Wangdu County', '');
INSERT INTO `feel_region` VALUES (97, '1', '13', '6', '32', '安新县', 'Anxin County', '');
INSERT INTO `feel_region` VALUES (98, '1', '13', '6', '33', '易　县', 'Yi County', '');
INSERT INTO `feel_region` VALUES (99, '1', '13', '6', '34', '曲阳县', 'Quyang County', '');
INSERT INTO `feel_region` VALUES (100, '1', '13', '6', '35', '蠡　县', 'Li County', '');
INSERT INTO `feel_region` VALUES (101, '1', '13', '6', '36', '顺平县', 'Shunping County', '');
INSERT INTO `feel_region` VALUES (102, '1', '13', '6', '37', '博野县', 'Boye County', '');
INSERT INTO `feel_region` VALUES (103, '1', '13', '6', '38', '雄　县', 'Xiong County', '');
INSERT INTO `feel_region` VALUES (104, '1', '13', '6', '81', '涿州市', 'Quzhou City', '');
INSERT INTO `feel_region` VALUES (105, '1', '13', '6', '82', '定州市', 'Dingzhou City', '');
INSERT INTO `feel_region` VALUES (106, '1', '13', '6', '83', '安国市', 'Anguo City', '');
INSERT INTO `feel_region` VALUES (107, '1', '13', '6', '84', '高碑店市', 'Gaobeidian City', '');
INSERT INTO `feel_region` VALUES (108, '1', '13', '7', '2', '桥东区', 'Qiaodong District', '');
INSERT INTO `feel_region` VALUES (109, '1', '13', '7', '3', '桥西区', 'Qiaoxi District', '');
INSERT INTO `feel_region` VALUES (110, '1', '13', '7', '5', '宣化区', 'Xuanhua District', '');
INSERT INTO `feel_region` VALUES (111, '1', '13', '7', '6', '下花园区', 'Lower garden area', '');
INSERT INTO `feel_region` VALUES (112, '1', '13', '7', '21', '宣化县', 'Xuanhua County', '');
INSERT INTO `feel_region` VALUES (113, '1', '13', '7', '22', '张北县', 'Zhangbei County', '');
INSERT INTO `feel_region` VALUES (114, '1', '13', '7', '23', '康保县', 'Kangbao County', '');
INSERT INTO `feel_region` VALUES (115, '1', '13', '7', '24', '沽源县', 'Wuyuan County', '');
INSERT INTO `feel_region` VALUES (116, '1', '13', '7', '25', '尚义县', 'Shangyi County', '');
INSERT INTO `feel_region` VALUES (117, '1', '13', '7', '26', '蔚　县', 'Wei County', '');
INSERT INTO `feel_region` VALUES (118, '1', '13', '7', '27', '阳原县', 'Yangyuan County', '');
INSERT INTO `feel_region` VALUES (119, '1', '13', '7', '28', '怀安县', 'Huai\'an County', '');
INSERT INTO `feel_region` VALUES (120, '1', '13', '7', '29', '万全县', 'Wanquan County', '');
INSERT INTO `feel_region` VALUES (121, '1', '13', '7', '30', '怀来县', 'Huailai County', '');
INSERT INTO `feel_region` VALUES (122, '1', '13', '7', '31', '涿鹿县', 'Zhuolu County', '');
INSERT INTO `feel_region` VALUES (123, '1', '13', '7', '32', '赤城县', 'Chicheng County', '');
INSERT INTO `feel_region` VALUES (124, '1', '13', '7', '33', '崇礼县', 'Chongli County', '');
INSERT INTO `feel_region` VALUES (125, '1', '13', '8', '2', '双桥区', 'Shuangqiao District', '');
INSERT INTO `feel_region` VALUES (126, '1', '13', '8', '3', '双滦区', 'Double squat area', '');
INSERT INTO `feel_region` VALUES (127, '1', '13', '8', '4', '鹰手营子矿区', 'Eagle Hand Yingzi Mining Area', '');
INSERT INTO `feel_region` VALUES (128, '1', '13', '8', '21', '承德县', 'Chengde County', '');
INSERT INTO `feel_region` VALUES (129, '1', '13', '8', '22', '兴隆县', 'Xinglong County', '');
INSERT INTO `feel_region` VALUES (130, '1', '13', '8', '23', '平泉县', 'Pingquan County', '');
INSERT INTO `feel_region` VALUES (131, '1', '13', '8', '24', '滦平县', 'Luanping County', '');
INSERT INTO `feel_region` VALUES (132, '1', '13', '8', '25', '隆化县', 'Longhua County', '');
INSERT INTO `feel_region` VALUES (133, '1', '13', '8', '26', '丰宁满族自治县', 'Fengning Manchu Autonomous County', '');
INSERT INTO `feel_region` VALUES (134, '1', '13', '8', '27', '宽城满族自治县', 'Kuancheng Manchu Autonomous County', '');
INSERT INTO `feel_region` VALUES (135, '1', '13', '8', '28', '围场满族蒙古族自治县', 'Weichang Manchu Mongolian Autonomous County', '');
INSERT INTO `feel_region` VALUES (136, '1', '13', '9', '2', '新华区', 'Xinhua District', '');
INSERT INTO `feel_region` VALUES (137, '1', '13', '9', '3', '运河区', 'Canal area', '');
INSERT INTO `feel_region` VALUES (138, '1', '13', '9', '21', '沧　县', 'Cang County', '');
INSERT INTO `feel_region` VALUES (139, '1', '13', '9', '22', '青　县', 'Qing County', '');
INSERT INTO `feel_region` VALUES (140, '1', '13', '9', '23', '东光县', 'Dongguang County', '');
INSERT INTO `feel_region` VALUES (141, '1', '13', '9', '24', '海兴县', 'Haixing County', '');
INSERT INTO `feel_region` VALUES (142, '1', '13', '9', '25', '盐山县', 'Yanshan County', '');
INSERT INTO `feel_region` VALUES (143, '1', '13', '9', '26', '肃宁县', 'Suning County', '');
INSERT INTO `feel_region` VALUES (144, '1', '13', '9', '27', '南皮县', 'Nanpi County', '');
INSERT INTO `feel_region` VALUES (145, '1', '13', '9', '28', '吴桥县', 'Wuqiao County', '');
INSERT INTO `feel_region` VALUES (146, '1', '13', '9', '29', '献　县', 'Xian County', '');
INSERT INTO `feel_region` VALUES (147, '1', '13', '9', '30', '孟村回族自治县', 'Mengcun Hui Autonomous County', '');
INSERT INTO `feel_region` VALUES (148, '1', '13', '9', '81', '泊头市', 'Botou City', '');
INSERT INTO `feel_region` VALUES (149, '1', '13', '9', '82', '任丘市', 'Renqiu City', '');
INSERT INTO `feel_region` VALUES (150, '1', '13', '9', '83', '黄骅市', 'Huangpi City', '');
INSERT INTO `feel_region` VALUES (151, '1', '13', '9', '84', '河间市', 'Hejian City', '');
INSERT INTO `feel_region` VALUES (152, '1', '13', '10', '2', '安次区', 'Anci District', '');
INSERT INTO `feel_region` VALUES (153, '1', '13', '10', '3', '广阳区', 'Guangyang District', '');
INSERT INTO `feel_region` VALUES (154, '1', '13', '10', '22', '固安县', 'Gu\'an County', '');
INSERT INTO `feel_region` VALUES (155, '1', '13', '10', '23', '永清县', 'Yongqing County', '');
INSERT INTO `feel_region` VALUES (156, '1', '13', '10', '24', '香河县', 'Xianghe County', '');
INSERT INTO `feel_region` VALUES (157, '1', '13', '10', '25', '大城县', 'Dacheng County', '');
INSERT INTO `feel_region` VALUES (158, '1', '13', '10', '26', '文安县', 'Wen\'an County', '');
INSERT INTO `feel_region` VALUES (159, '1', '13', '10', '28', '大厂回族自治县', 'Dachang Hui Autonomous County', '');
INSERT INTO `feel_region` VALUES (160, '1', '13', '10', '81', '霸州市', 'Bazhou City', '');
INSERT INTO `feel_region` VALUES (161, '1', '13', '10', '82', '三河市', 'Sanhe City', '');
INSERT INTO `feel_region` VALUES (162, '1', '13', '11', '2', '桃城区', 'Taocheng District', '');
INSERT INTO `feel_region` VALUES (163, '1', '13', '11', '21', '枣强县', 'Zaoqiang County', '');
INSERT INTO `feel_region` VALUES (164, '1', '13', '11', '22', '武邑县', 'Wuyi County', '');
INSERT INTO `feel_region` VALUES (165, '1', '13', '11', '23', '武强县', 'Wuqiang County', '');
INSERT INTO `feel_region` VALUES (166, '1', '13', '11', '24', '饶阳县', 'Raoyang County', '');
INSERT INTO `feel_region` VALUES (167, '1', '13', '11', '25', '安平县', 'Anping County', '');
INSERT INTO `feel_region` VALUES (168, '1', '13', '11', '26', '故城县', 'Gucheng County', '');
INSERT INTO `feel_region` VALUES (169, '1', '13', '11', '27', '景　县', 'Jing County', '');
INSERT INTO `feel_region` VALUES (170, '1', '13', '11', '28', '阜城县', 'Yucheng County', '');
INSERT INTO `feel_region` VALUES (171, '1', '13', '11', '81', '冀州市', 'Quzhou City', '');
INSERT INTO `feel_region` VALUES (172, '1', '13', '11', '82', '深州市', 'Shenzhou City', '');
INSERT INTO `feel_region` VALUES (173, '1', '14', '1', '5', '小店区', 'Small shop area', '');
INSERT INTO `feel_region` VALUES (174, '1', '14', '1', '6', '迎泽区', 'Yingze District', '');
INSERT INTO `feel_region` VALUES (175, '1', '14', '1', '7', '杏花岭区', 'Xinghualing District', '');
INSERT INTO `feel_region` VALUES (176, '1', '14', '1', '8', '尖草坪区', 'Sharp lawn area', '');
INSERT INTO `feel_region` VALUES (177, '1', '14', '1', '9', '万柏林区', 'Wanblin District', '');
INSERT INTO `feel_region` VALUES (178, '1', '14', '1', '10', '晋源区', 'Jinyuan District', '');
INSERT INTO `feel_region` VALUES (179, '1', '14', '1', '21', '清徐县', 'Qingxu County', '');
INSERT INTO `feel_region` VALUES (180, '1', '14', '1', '22', '阳曲县', 'Yangqu County', '');
INSERT INTO `feel_region` VALUES (181, '1', '14', '1', '23', '娄烦县', 'Loufan County', '');
INSERT INTO `feel_region` VALUES (182, '1', '14', '1', '81', '古交市', 'Gujiao City', '');
INSERT INTO `feel_region` VALUES (183, '1', '14', '2', '2', '城　区', 'City area', '');
INSERT INTO `feel_region` VALUES (184, '1', '14', '2', '3', '矿　区', 'Mining area', '');
INSERT INTO `feel_region` VALUES (185, '1', '14', '2', '11', '南郊区', 'Southern suburb', '');
INSERT INTO `feel_region` VALUES (186, '1', '14', '2', '12', '新荣区', 'Xinrong District', '');
INSERT INTO `feel_region` VALUES (187, '1', '14', '2', '21', '阳高县', 'Yanggao County', '');
INSERT INTO `feel_region` VALUES (188, '1', '14', '2', '22', '天镇县', 'Tianzhen County', '');
INSERT INTO `feel_region` VALUES (189, '1', '14', '2', '23', '广灵县', 'Guangling County', '');
INSERT INTO `feel_region` VALUES (190, '1', '14', '2', '24', '灵丘县', 'Lingqiu County', '');
INSERT INTO `feel_region` VALUES (191, '1', '14', '2', '25', '浑源县', 'Wuyuan County', '');
INSERT INTO `feel_region` VALUES (192, '1', '14', '2', '26', '左云县', 'Zuoyun County', '');
INSERT INTO `feel_region` VALUES (193, '1', '14', '2', '27', '大同县', 'Datong County', '');
INSERT INTO `feel_region` VALUES (194, '1', '14', '3', '2', '城　区', 'City area', '');
INSERT INTO `feel_region` VALUES (195, '1', '14', '3', '3', '矿　区', 'Mining area', '');
INSERT INTO `feel_region` VALUES (196, '1', '14', '3', '11', '郊　区', 'Suburb', '');
INSERT INTO `feel_region` VALUES (197, '1', '14', '3', '21', '平定县', 'Pingding County', '');
INSERT INTO `feel_region` VALUES (198, '1', '14', '3', '22', '盂　县', 'Yu County', '');
INSERT INTO `feel_region` VALUES (199, '1', '14', '4', '2', '城　区', 'City area', '');
INSERT INTO `feel_region` VALUES (200, '1', '14', '4', '11', '郊　区', 'Suburb', '');
INSERT INTO `feel_region` VALUES (201, '1', '14', '4', '21', '长治县', 'Changzhi County', '');
INSERT INTO `feel_region` VALUES (202, '1', '14', '4', '23', '襄垣县', 'Ji County', '');
INSERT INTO `feel_region` VALUES (203, '1', '14', '4', '24', '屯留县', 'Tunliu County', '');
INSERT INTO `feel_region` VALUES (204, '1', '14', '4', '25', '平顺县', 'Pingshun County', '');
INSERT INTO `feel_region` VALUES (205, '1', '14', '4', '26', '黎城县', 'Licheng County', '');
INSERT INTO `feel_region` VALUES (206, '1', '14', '4', '27', '壶关县', 'Huguan County', '');
INSERT INTO `feel_region` VALUES (207, '1', '14', '4', '28', '长子县', 'Changzi County', '');
INSERT INTO `feel_region` VALUES (208, '1', '14', '4', '29', '武乡县', 'Wuxiang County', '');
INSERT INTO `feel_region` VALUES (209, '1', '14', '4', '30', '沁　县', 'Qin County', '');
INSERT INTO `feel_region` VALUES (210, '1', '14', '4', '31', '沁源县', 'Wuyuan County', '');
INSERT INTO `feel_region` VALUES (211, '1', '14', '4', '81', '潞城市', 'Lu city', '');
INSERT INTO `feel_region` VALUES (212, '1', '14', '5', '2', '城　区', 'City area', '');
INSERT INTO `feel_region` VALUES (213, '1', '14', '5', '21', '沁水县', 'Yishui County', '');
INSERT INTO `feel_region` VALUES (214, '1', '14', '5', '22', '阳城县', 'Yangcheng County', '');
INSERT INTO `feel_region` VALUES (215, '1', '14', '5', '24', '陵川县', 'Lingchuan County', '');
INSERT INTO `feel_region` VALUES (216, '1', '14', '5', '25', '泽州县', 'Zezhou County', '');
INSERT INTO `feel_region` VALUES (217, '1', '14', '5', '81', '高平市', 'Gaoping City', '');
INSERT INTO `feel_region` VALUES (218, '1', '14', '6', '2', '朔城区', 'Wucheng District', '');
INSERT INTO `feel_region` VALUES (219, '1', '14', '6', '3', '平鲁区', 'Pinglu District', '');
INSERT INTO `feel_region` VALUES (220, '1', '14', '6', '21', '山阴县', 'Shanyin County', '');
INSERT INTO `feel_region` VALUES (221, '1', '14', '6', '22', '应　县', 'Ying County', '');
INSERT INTO `feel_region` VALUES (222, '1', '14', '6', '23', '右玉县', 'Youyu County', '');
INSERT INTO `feel_region` VALUES (223, '1', '14', '6', '24', '怀仁县', 'Huairen County', '');
INSERT INTO `feel_region` VALUES (224, '1', '14', '7', '2', '榆次区', 'Yuci District', '');
INSERT INTO `feel_region` VALUES (225, '1', '14', '7', '21', '榆社县', 'Yushe County', '');
INSERT INTO `feel_region` VALUES (226, '1', '14', '7', '22', '左权县', 'Zuoquan County', '');
INSERT INTO `feel_region` VALUES (227, '1', '14', '7', '23', '和顺县', 'Heshun County', '');
INSERT INTO `feel_region` VALUES (228, '1', '14', '7', '24', '昔阳县', 'Xiyang County', '');
INSERT INTO `feel_region` VALUES (229, '1', '14', '7', '25', '寿阳县', 'Shouyang County', '');
INSERT INTO `feel_region` VALUES (230, '1', '14', '7', '26', '太谷县', 'Taigu County', '');
INSERT INTO `feel_region` VALUES (231, '1', '14', '7', '27', '祁　县', 'Qi County', '');
INSERT INTO `feel_region` VALUES (232, '1', '14', '7', '28', '平遥县', 'Pingyao County', '');
INSERT INTO `feel_region` VALUES (233, '1', '14', '7', '29', '灵石县', 'Lingshi County', '');
INSERT INTO `feel_region` VALUES (234, '1', '14', '7', '81', '介休市', 'Jiexiu City', '');
INSERT INTO `feel_region` VALUES (235, '1', '14', '8', '2', '盐湖区', 'Salt Lake District', '');
INSERT INTO `feel_region` VALUES (236, '1', '14', '8', '21', '临猗县', 'Linyi County', '');
INSERT INTO `feel_region` VALUES (237, '1', '14', '8', '22', '万荣县', 'Wanrong County', '');
INSERT INTO `feel_region` VALUES (238, '1', '14', '8', '23', '闻喜县', 'Wenxi County', '');
INSERT INTO `feel_region` VALUES (239, '1', '14', '8', '24', '稷山县', 'Daishan County', '');
INSERT INTO `feel_region` VALUES (240, '1', '14', '8', '25', '新绛县', 'Xinyi County', '');
INSERT INTO `feel_region` VALUES (241, '1', '14', '8', '26', '绛　县', 'Jiang County', '');
INSERT INTO `feel_region` VALUES (242, '1', '14', '8', '27', '垣曲县', 'Yuanqu County', '');
INSERT INTO `feel_region` VALUES (243, '1', '14', '8', '28', '夏　县', 'Xia County', '');
INSERT INTO `feel_region` VALUES (244, '1', '14', '8', '29', '平陆县', 'Pinglu County', '');
INSERT INTO `feel_region` VALUES (245, '1', '14', '8', '30', '芮城县', 'Yucheng County', '');
INSERT INTO `feel_region` VALUES (246, '1', '14', '8', '81', '永济市', 'Yongji City', '');
INSERT INTO `feel_region` VALUES (247, '1', '14', '8', '82', '河津市', 'Kawazu City', '');
INSERT INTO `feel_region` VALUES (248, '1', '14', '9', '2', '忻府区', 'Yufu District', '');
INSERT INTO `feel_region` VALUES (249, '1', '14', '9', '21', '定襄县', 'Dingxiang County', '');
INSERT INTO `feel_region` VALUES (250, '1', '14', '9', '22', '五台县', 'Wutai County', '');
INSERT INTO `feel_region` VALUES (251, '1', '14', '9', '23', '代　县', 'Dai County', '');
INSERT INTO `feel_region` VALUES (252, '1', '14', '9', '24', '繁峙县', 'Fanzhi County', '');
INSERT INTO `feel_region` VALUES (253, '1', '14', '9', '25', '宁武县', 'Ningwu County', '');
INSERT INTO `feel_region` VALUES (254, '1', '14', '9', '26', '静乐县', 'Jingle County', '');
INSERT INTO `feel_region` VALUES (255, '1', '14', '9', '27', '神池县', 'Shenchi County', '');
INSERT INTO `feel_region` VALUES (256, '1', '14', '9', '28', '五寨县', 'Wuzhai County', '');
INSERT INTO `feel_region` VALUES (257, '1', '14', '9', '29', '岢岚县', 'Ji County', '');
INSERT INTO `feel_region` VALUES (258, '1', '14', '9', '30', '河曲县', 'Hequ County', '');
INSERT INTO `feel_region` VALUES (259, '1', '14', '9', '31', '保德县', 'Baode County', '');
INSERT INTO `feel_region` VALUES (260, '1', '14', '9', '32', '偏关县', 'Pianguan County', '');
INSERT INTO `feel_region` VALUES (261, '1', '14', '9', '81', '原平市', 'Yuanping City', '');
INSERT INTO `feel_region` VALUES (262, '1', '14', '10', '2', '尧都区', 'Batu District', '');
INSERT INTO `feel_region` VALUES (263, '1', '14', '10', '21', '曲沃县', 'Quwo County', '');
INSERT INTO `feel_region` VALUES (264, '1', '14', '10', '22', '翼城县', 'Yicheng County', '');
INSERT INTO `feel_region` VALUES (265, '1', '14', '10', '23', '襄汾县', 'Ji County', '');
INSERT INTO `feel_region` VALUES (266, '1', '14', '10', '24', '洪洞县', 'Hongdong County', '');
INSERT INTO `feel_region` VALUES (267, '1', '14', '10', '25', '古　县', 'Ancient county', '');
INSERT INTO `feel_region` VALUES (268, '1', '14', '10', '26', '安泽县', 'Anze County', '');
INSERT INTO `feel_region` VALUES (269, '1', '14', '10', '27', '浮山县', 'Fushan County', '');
INSERT INTO `feel_region` VALUES (270, '1', '14', '10', '28', '吉　县', 'Ji County', '');
INSERT INTO `feel_region` VALUES (271, '1', '14', '10', '29', '乡宁县', 'Xiangning County', '');
INSERT INTO `feel_region` VALUES (272, '1', '14', '10', '30', '大宁县', 'Daning County', '');
INSERT INTO `feel_region` VALUES (273, '1', '14', '10', '31', '隰　县', 'Xi County', '');
INSERT INTO `feel_region` VALUES (274, '1', '14', '10', '32', '永和县', 'Yonghe County', '');
INSERT INTO `feel_region` VALUES (275, '1', '14', '10', '33', '蒲　县', 'Pu County', '');
INSERT INTO `feel_region` VALUES (276, '1', '14', '10', '34', '汾西县', 'Luxi County', '');
INSERT INTO `feel_region` VALUES (277, '1', '14', '10', '81', '侯马市', 'Houma City', '');
INSERT INTO `feel_region` VALUES (278, '1', '14', '10', '82', '霍州市', 'Huozhou City', '');
INSERT INTO `feel_region` VALUES (279, '1', '14', '11', '2', '离石区', 'Lishi District', '');
INSERT INTO `feel_region` VALUES (280, '1', '14', '11', '21', '文水县', 'Wenshui County', '');
INSERT INTO `feel_region` VALUES (281, '1', '14', '11', '22', '交城县', 'Jiaocheng County', '');
INSERT INTO `feel_region` VALUES (282, '1', '14', '11', '23', '兴　县', 'Xing County', '');
INSERT INTO `feel_region` VALUES (283, '1', '14', '11', '24', '临　县', 'Lin County', '');
INSERT INTO `feel_region` VALUES (284, '1', '14', '11', '25', '柳林县', 'Liulin County', '');
INSERT INTO `feel_region` VALUES (285, '1', '14', '11', '26', '石楼县', 'Shilou County', '');
INSERT INTO `feel_region` VALUES (286, '1', '14', '11', '27', '岚　县', 'Lan County', '');
INSERT INTO `feel_region` VALUES (287, '1', '14', '11', '28', '方山县', 'Fangshan County', '');
INSERT INTO `feel_region` VALUES (288, '1', '14', '11', '29', '中阳县', 'Zhongyang County', '');
INSERT INTO `feel_region` VALUES (289, '1', '14', '11', '30', '交口县', 'Jiaokou County', '');
INSERT INTO `feel_region` VALUES (290, '1', '14', '11', '81', '孝义市', 'Xiaoyi City', '');
INSERT INTO `feel_region` VALUES (291, '1', '14', '11', '82', '汾阳市', 'Fuyang City', '');
INSERT INTO `feel_region` VALUES (292, '1', '15', '1', '2', '新城区', 'New town area', '');
INSERT INTO `feel_region` VALUES (293, '1', '15', '1', '3', '回民区', 'Huimin District', '');
INSERT INTO `feel_region` VALUES (294, '1', '15', '1', '4', '玉泉区', 'Yuquan District', '');
INSERT INTO `feel_region` VALUES (295, '1', '15', '1', '5', '赛罕区', 'SaiHan District', '');
INSERT INTO `feel_region` VALUES (296, '1', '15', '1', '21', '土默特左旗', 'Tumut left flag', '');
INSERT INTO `feel_region` VALUES (297, '1', '15', '1', '22', '托克托县', 'Tokto County', '');
INSERT INTO `feel_region` VALUES (298, '1', '15', '1', '23', '和林格尔县', 'Linger County', '');
INSERT INTO `feel_region` VALUES (299, '1', '15', '1', '24', '清水河县', 'Qingshuihe County', '');
INSERT INTO `feel_region` VALUES (300, '1', '15', '1', '25', '武川县', 'Wuchuan County', '');
INSERT INTO `feel_region` VALUES (301, '1', '15', '2', '2', '东河区', 'Donghe District', '');
INSERT INTO `feel_region` VALUES (302, '1', '15', '2', '3', '昆都仑区', 'Kundulun District', '');
INSERT INTO `feel_region` VALUES (303, '1', '15', '2', '4', '青山区', 'Qingshan District', '');
INSERT INTO `feel_region` VALUES (304, '1', '15', '2', '5', '石拐区', 'Shizhu District', '');
INSERT INTO `feel_region` VALUES (305, '1', '15', '2', '6', '白云鄂博矿区', 'Bayan Obo Mining Area', '');
INSERT INTO `feel_region` VALUES (306, '1', '15', '2', '7', '九原区', 'Jiuyuan District', '');
INSERT INTO `feel_region` VALUES (307, '1', '15', '2', '21', '土默特右旗', 'Tumut Right Banner', '');
INSERT INTO `feel_region` VALUES (308, '1', '15', '2', '22', '固阳县', 'Guyang County', '');
INSERT INTO `feel_region` VALUES (309, '1', '15', '2', '23', '达尔罕茂明安联合旗', 'Dalhan Maomingan United Flag', '');
INSERT INTO `feel_region` VALUES (310, '1', '15', '3', '2', '海勃湾区', 'Haibowan District', '');
INSERT INTO `feel_region` VALUES (311, '1', '15', '3', '3', '海南区', 'Hainan District', '');
INSERT INTO `feel_region` VALUES (312, '1', '15', '3', '4', '乌达区', 'Wuda District', '');
INSERT INTO `feel_region` VALUES (313, '1', '15', '4', '2', '红山区', 'Hongshan District', '');
INSERT INTO `feel_region` VALUES (314, '1', '15', '4', '3', '元宝山区', 'Yuanbao Mountain Area', '');
INSERT INTO `feel_region` VALUES (315, '1', '15', '4', '4', '松山区', 'Songshan District', '');
INSERT INTO `feel_region` VALUES (316, '1', '15', '4', '21', '阿鲁科尔沁旗', 'Aruker flag', '');
INSERT INTO `feel_region` VALUES (317, '1', '15', '4', '22', '巴林左旗', 'Bahrain Zuoqi', '');
INSERT INTO `feel_region` VALUES (318, '1', '15', '4', '23', '巴林右旗', 'Bahrain Right Banner', '');
INSERT INTO `feel_region` VALUES (319, '1', '15', '4', '24', '林西县', 'Linxi County', '');
INSERT INTO `feel_region` VALUES (320, '1', '15', '4', '25', '克什克腾旗', 'Keshiketeng Banner', '');
INSERT INTO `feel_region` VALUES (321, '1', '15', '4', '26', '翁牛特旗', 'Weng Niute Banner', '');
INSERT INTO `feel_region` VALUES (322, '1', '15', '4', '28', '喀喇沁旗', 'Kalaqin flag', '');
INSERT INTO `feel_region` VALUES (323, '1', '15', '4', '29', '宁城县', 'Ningcheng County', '');
INSERT INTO `feel_region` VALUES (324, '1', '15', '4', '30', '敖汉旗', 'Aohan Banner', '');
INSERT INTO `feel_region` VALUES (325, '1', '15', '5', '2', '科尔沁区', 'Horqin District', '');
INSERT INTO `feel_region` VALUES (326, '1', '15', '5', '21', '科尔沁左翼中旗', 'Kerqin left wing flag', '');
INSERT INTO `feel_region` VALUES (327, '1', '15', '5', '22', '科尔沁左翼后旗', 'Horqin left wing flag', '');
INSERT INTO `feel_region` VALUES (328, '1', '15', '5', '23', '开鲁县', 'Kailu County', '');
INSERT INTO `feel_region` VALUES (329, '1', '15', '5', '24', '库伦旗', 'Kulun Banner', '');
INSERT INTO `feel_region` VALUES (330, '1', '15', '5', '25', '奈曼旗', 'Naiman flag', '');
INSERT INTO `feel_region` VALUES (331, '1', '15', '5', '26', '扎鲁特旗', 'Zalute flag', '');
INSERT INTO `feel_region` VALUES (332, '1', '15', '5', '81', '霍林郭勒市', 'Hollingol City', '');
INSERT INTO `feel_region` VALUES (333, '1', '15', '6', '2', '东胜区', 'Dongsheng District', '');
INSERT INTO `feel_region` VALUES (334, '1', '15', '6', '21', '达拉特旗', 'Dalat flag', '');
INSERT INTO `feel_region` VALUES (335, '1', '15', '6', '22', '准格尔旗', 'Zhungeer Banner', '');
INSERT INTO `feel_region` VALUES (336, '1', '15', '6', '23', '鄂托克前旗', 'Etuokeqian Banner', '');
INSERT INTO `feel_region` VALUES (337, '1', '15', '6', '24', '鄂托克旗', 'Etuoke flag', '');
INSERT INTO `feel_region` VALUES (338, '1', '15', '6', '25', '杭锦旗', 'Hang Jinqi', '');
INSERT INTO `feel_region` VALUES (339, '1', '15', '6', '26', '乌审旗', 'Wushenqi', '');
INSERT INTO `feel_region` VALUES (340, '1', '15', '6', '27', '伊金霍洛旗', 'Yijinhuoluoqi', '');
INSERT INTO `feel_region` VALUES (341, '1', '15', '7', '2', '海拉尔区', 'Hailar District', '');
INSERT INTO `feel_region` VALUES (342, '1', '15', '7', '21', '阿荣旗', 'Arong Banner', '');
INSERT INTO `feel_region` VALUES (343, '1', '15', '7', '22', '莫力达瓦达斡尔族自治旗', 'Molidawada Muir Autonomous Banner', '');
INSERT INTO `feel_region` VALUES (344, '1', '15', '7', '23', '鄂伦春自治旗', 'Oroqen Autonomous Banner', '');
INSERT INTO `feel_region` VALUES (345, '1', '15', '7', '24', '鄂温克族自治旗', 'Ewenki Autonomous Banner', '');
INSERT INTO `feel_region` VALUES (346, '1', '15', '7', '25', '陈巴尔虎旗', 'Chen Baerhu Banner', '');
INSERT INTO `feel_region` VALUES (347, '1', '15', '7', '26', '新巴尔虎左旗', 'New bay tiger left flag', '');
INSERT INTO `feel_region` VALUES (348, '1', '15', '7', '27', '新巴尔虎右旗', 'New Barr Right Banner', '');
INSERT INTO `feel_region` VALUES (349, '1', '15', '7', '81', '满洲里市', 'Manzhouli City', '');
INSERT INTO `feel_region` VALUES (350, '1', '15', '7', '82', '牙克石市', 'Yakeshi City', '');
INSERT INTO `feel_region` VALUES (351, '1', '15', '7', '83', '扎兰屯市', 'Zhalantun City', '');
INSERT INTO `feel_region` VALUES (352, '1', '15', '7', '84', '额尔古纳市', 'Ergun City', '');
INSERT INTO `feel_region` VALUES (353, '1', '15', '7', '85', '根河市', 'Genhe City', '');
INSERT INTO `feel_region` VALUES (354, '1', '15', '8', '2', '临河区', 'Linhe District', '');
INSERT INTO `feel_region` VALUES (355, '1', '15', '8', '21', '五原县', 'Wuyuan County', '');
INSERT INTO `feel_region` VALUES (356, '1', '15', '8', '22', '磴口县', 'Qikou County', '');
INSERT INTO `feel_region` VALUES (357, '1', '15', '8', '23', '乌拉特前旗', 'Urad Front Banner', '');
INSERT INTO `feel_region` VALUES (358, '1', '15', '8', '24', '乌拉特中旗', 'Urad Middle Banner', '');
INSERT INTO `feel_region` VALUES (359, '1', '15', '8', '25', '乌拉特后旗', 'Urad Rear Banner', '');
INSERT INTO `feel_region` VALUES (360, '1', '15', '8', '26', '杭锦后旗', 'Hang Jinhou Banner', '');
INSERT INTO `feel_region` VALUES (361, '1', '15', '9', '2', '集宁区', 'Jining District', '');
INSERT INTO `feel_region` VALUES (362, '1', '15', '9', '21', '卓资县', 'Zhuozi County', '');
INSERT INTO `feel_region` VALUES (363, '1', '15', '9', '22', '化德县', 'Huade County', '');
INSERT INTO `feel_region` VALUES (364, '1', '15', '9', '23', '商都县', 'Shangdu County', '');
INSERT INTO `feel_region` VALUES (365, '1', '15', '9', '24', '兴和县', 'Xinghe County', '');
INSERT INTO `feel_region` VALUES (366, '1', '15', '9', '25', '凉城县', 'Liangcheng County', '');
INSERT INTO `feel_region` VALUES (367, '1', '15', '9', '26', '察哈尔右翼前旗', 'Chahar right front flag', '');
INSERT INTO `feel_region` VALUES (368, '1', '15', '9', '27', '察哈尔右翼中旗', 'Chahar right wing middle flag', '');
INSERT INTO `feel_region` VALUES (369, '1', '15', '9', '28', '察哈尔右翼后旗', 'Chahar right wing flag', '');
INSERT INTO `feel_region` VALUES (370, '1', '15', '9', '29', '四子王旗', 'Siziwangqi', '');
INSERT INTO `feel_region` VALUES (371, '1', '15', '9', '81', '丰镇市', 'Fengzhen City', '');
INSERT INTO `feel_region` VALUES (372, '1', '15', '22', '1', '乌兰浩特市', 'Ulanhot City', '');
INSERT INTO `feel_region` VALUES (373, '1', '15', '22', '2', '阿尔山市', 'Aershan', '');
INSERT INTO `feel_region` VALUES (374, '1', '15', '22', '21', '科尔沁右翼前旗', 'Kerqin right front flag', '');
INSERT INTO `feel_region` VALUES (375, '1', '15', '22', '22', '科尔沁右翼中旗', 'Horqin right wing middle flag', '');
INSERT INTO `feel_region` VALUES (376, '1', '15', '22', '23', '扎赉特旗', 'Zhabit Banner', '');
INSERT INTO `feel_region` VALUES (377, '1', '15', '22', '24', '突泉县', 'Tuquan County', '');
INSERT INTO `feel_region` VALUES (378, '1', '15', '25', '1', '二连浩特市', 'Erlianhot City', '');
INSERT INTO `feel_region` VALUES (379, '1', '15', '25', '2', '锡林浩特市', 'Xilinhot City', '');
INSERT INTO `feel_region` VALUES (380, '1', '15', '25', '22', '阿巴嘎旗', 'Abaqi flag', '');
INSERT INTO `feel_region` VALUES (381, '1', '15', '25', '23', '苏尼特左旗', 'Sunite left flag', '');
INSERT INTO `feel_region` VALUES (382, '1', '15', '25', '24', '苏尼特右旗', 'Sunite Right Banner', '');
INSERT INTO `feel_region` VALUES (383, '1', '15', '25', '25', '东乌珠穆沁旗', 'East Ujimqin Banner', '');
INSERT INTO `feel_region` VALUES (384, '1', '15', '25', '26', '西乌珠穆沁旗', 'West Ujimqi Banner', '');
INSERT INTO `feel_region` VALUES (385, '1', '15', '25', '27', '太仆寺旗', 'Taipusi Banner', '');
INSERT INTO `feel_region` VALUES (386, '1', '15', '25', '28', '镶黄旗', 'Yellow flag', '');
INSERT INTO `feel_region` VALUES (387, '1', '15', '25', '29', '正镶白旗', 'White flag', '');
INSERT INTO `feel_region` VALUES (388, '1', '15', '25', '30', '正蓝旗', 'Positive blue flag', '');
INSERT INTO `feel_region` VALUES (389, '1', '15', '25', '31', '多伦县', 'Duolun County', '');
INSERT INTO `feel_region` VALUES (390, '1', '15', '29', '21', '阿拉善左旗', 'Alxa Zuoqi', '');
INSERT INTO `feel_region` VALUES (391, '1', '15', '29', '22', '阿拉善右旗', 'Alxa Right Banner', '');
INSERT INTO `feel_region` VALUES (392, '1', '15', '29', '23', '额济纳旗', 'Ejina Banner', '');
INSERT INTO `feel_region` VALUES (393, '1', '21', '1', '2', '和平区', 'Heping District', '');
INSERT INTO `feel_region` VALUES (394, '1', '21', '1', '3', '沈河区', 'Shenhe District', '');
INSERT INTO `feel_region` VALUES (395, '1', '21', '1', '4', '大东区', 'Dadong District', '');
INSERT INTO `feel_region` VALUES (396, '1', '21', '1', '5', '皇姑区', 'Huanggu District', '');
INSERT INTO `feel_region` VALUES (397, '1', '21', '1', '6', '铁西区', 'Tiexi District', '');
INSERT INTO `feel_region` VALUES (398, '1', '21', '1', '11', '苏家屯区', 'Sujiatun District', '');
INSERT INTO `feel_region` VALUES (399, '1', '21', '1', '12', '东陵区', 'Dongling District', '');
INSERT INTO `feel_region` VALUES (400, '1', '21', '1', '13', '沈北新区', 'Shenbei New District', '');
INSERT INTO `feel_region` VALUES (401, '1', '21', '1', '14', '于洪区', 'Yuhong District', '');
INSERT INTO `feel_region` VALUES (402, '1', '21', '1', '22', '辽中县', 'Liaozhong County', '');
INSERT INTO `feel_region` VALUES (403, '1', '21', '1', '23', '康平县', 'Kangping County', '');
INSERT INTO `feel_region` VALUES (404, '1', '21', '1', '24', '法库县', 'Faku County', '');
INSERT INTO `feel_region` VALUES (405, '1', '21', '1', '81', '新民市', 'Xinmin City', '');
INSERT INTO `feel_region` VALUES (406, '1', '21', '2', '2', '中山区', 'Zhongshan Area', '');
INSERT INTO `feel_region` VALUES (407, '1', '21', '2', '3', '西岗区', 'Xigang District', '');
INSERT INTO `feel_region` VALUES (408, '1', '21', '2', '4', '沙河口区', 'Shahekou District', '');
INSERT INTO `feel_region` VALUES (409, '1', '21', '2', '11', '甘井子区', 'Ganjingzi District', '');
INSERT INTO `feel_region` VALUES (410, '1', '21', '2', '12', '旅顺口区', 'Lushunkou District', '');
INSERT INTO `feel_region` VALUES (411, '1', '21', '2', '13', '金州区', 'Jinzhou District', '');
INSERT INTO `feel_region` VALUES (412, '1', '21', '2', '24', '长海县', 'Changhai County', '');
INSERT INTO `feel_region` VALUES (413, '1', '21', '2', '81', '瓦房店市', 'Wafangdian City', '');
INSERT INTO `feel_region` VALUES (414, '1', '21', '2', '82', '普兰店市', 'Pulandian City', '');
INSERT INTO `feel_region` VALUES (415, '1', '21', '2', '83', '庄河市', 'Zhuanghe City', '');
INSERT INTO `feel_region` VALUES (416, '1', '21', '3', '2', '铁东区', 'Tiedong District', '');
INSERT INTO `feel_region` VALUES (417, '1', '21', '3', '3', '铁西区', 'Tiexi District', '');
INSERT INTO `feel_region` VALUES (418, '1', '21', '3', '4', '立山区', 'Lishan District', '');
INSERT INTO `feel_region` VALUES (419, '1', '21', '3', '11', '千山区', 'Qianshan District', '');
INSERT INTO `feel_region` VALUES (420, '1', '21', '3', '21', '台安县', 'Tai\'an County', '');
INSERT INTO `feel_region` VALUES (421, '1', '21', '3', '23', '岫岩满族自治县', 'Xiuyan Manchu Autonomous County', '');
INSERT INTO `feel_region` VALUES (422, '1', '21', '3', '81', '海城市', 'Sea city', '');
INSERT INTO `feel_region` VALUES (423, '1', '21', '4', '2', '新抚区', 'Xinfu District', '');
INSERT INTO `feel_region` VALUES (424, '1', '21', '4', '3', '东洲区', 'Dongzhou District', '');
INSERT INTO `feel_region` VALUES (425, '1', '21', '4', '4', '望花区', 'Wanghua District', '');
INSERT INTO `feel_region` VALUES (426, '1', '21', '4', '11', '顺城区', 'Shuncheng District', '');
INSERT INTO `feel_region` VALUES (427, '1', '21', '4', '21', '抚顺县', 'Fushun County', '');
INSERT INTO `feel_region` VALUES (428, '1', '21', '4', '22', '新宾满族自治县', 'Xinbin Manchu Autonomous County', '');
INSERT INTO `feel_region` VALUES (429, '1', '21', '4', '23', '清原满族自治县', 'Qingyuan Manchu Autonomous County', '');
INSERT INTO `feel_region` VALUES (430, '1', '21', '5', '2', '平山区', 'Pingshan District', '');
INSERT INTO `feel_region` VALUES (431, '1', '21', '5', '3', '溪湖区', 'Xihu District', '');
INSERT INTO `feel_region` VALUES (432, '1', '21', '5', '4', '明山区', 'Mingshan District', '');
INSERT INTO `feel_region` VALUES (433, '1', '21', '5', '5', '南芬区', 'Nanfen District', '');
INSERT INTO `feel_region` VALUES (434, '1', '21', '5', '21', '本溪满族自治县', 'Benxi Manchu Autonomous County', '');
INSERT INTO `feel_region` VALUES (435, '1', '21', '5', '22', '桓仁满族自治县', 'Huanren Manchu Autonomous County', '');
INSERT INTO `feel_region` VALUES (436, '1', '21', '6', '2', '元宝区', 'Yuanbao District', '');
INSERT INTO `feel_region` VALUES (437, '1', '21', '6', '3', '振兴区', 'Zhenxing District', '');
INSERT INTO `feel_region` VALUES (438, '1', '21', '6', '4', '振安区', 'Zhen\'an District', '');
INSERT INTO `feel_region` VALUES (439, '1', '21', '6', '24', '宽甸满族自治县', 'Kuandian Manchu Autonomous County', '');
INSERT INTO `feel_region` VALUES (440, '1', '21', '6', '81', '东港市', 'Donggang City', '');
INSERT INTO `feel_region` VALUES (441, '1', '21', '6', '82', '凤城市', 'Fengcheng', '');
INSERT INTO `feel_region` VALUES (442, '1', '21', '7', '2', '古塔区', 'Guta District', '');
INSERT INTO `feel_region` VALUES (443, '1', '21', '7', '3', '凌河区', 'Linghe District', '');
INSERT INTO `feel_region` VALUES (444, '1', '21', '7', '11', '太和区', 'Taihe District', '');
INSERT INTO `feel_region` VALUES (445, '1', '21', '7', '26', '黑山县', 'Heishan County', '');
INSERT INTO `feel_region` VALUES (446, '1', '21', '7', '27', '义　县', 'Yi County', '');
INSERT INTO `feel_region` VALUES (447, '1', '21', '7', '81', '凌海市', 'Linghai City', '');
INSERT INTO `feel_region` VALUES (448, '1', '21', '7', '82', '北镇市', 'Beizhen City', '');
INSERT INTO `feel_region` VALUES (449, '1', '21', '8', '2', '站前区', 'Station front area', '');
INSERT INTO `feel_region` VALUES (450, '1', '21', '8', '3', '西市区', 'West District', '');
INSERT INTO `feel_region` VALUES (451, '1', '21', '8', '4', '鲅鱼圈区', 'Bayuquan District', '');
INSERT INTO `feel_region` VALUES (452, '1', '21', '8', '11', '老边区', 'Old border area', '');
INSERT INTO `feel_region` VALUES (453, '1', '21', '8', '81', '盖州市', 'Gaizhou', '');
INSERT INTO `feel_region` VALUES (454, '1', '21', '8', '82', '大石桥市', 'Dashiqiao City', '');
INSERT INTO `feel_region` VALUES (455, '1', '21', '9', '2', '海州区', 'Haizhou District', '');
INSERT INTO `feel_region` VALUES (456, '1', '21', '9', '3', '新邱区', 'Xinqiu District', '');
INSERT INTO `feel_region` VALUES (457, '1', '21', '9', '4', '太平区', 'Taiping District', '');
INSERT INTO `feel_region` VALUES (458, '1', '21', '9', '5', '清河门区', 'Qinghemen District', '');
INSERT INTO `feel_region` VALUES (459, '1', '21', '9', '11', '细河区', 'Xihe District', '');
INSERT INTO `feel_region` VALUES (460, '1', '21', '9', '21', '阜新蒙古族自治县', 'Fuxin Mongolian Autonomous County', '');
INSERT INTO `feel_region` VALUES (461, '1', '21', '9', '22', '彰武县', 'Zhangwu County', '');
INSERT INTO `feel_region` VALUES (462, '1', '21', '10', '2', '白塔区', 'Baita District', '');
INSERT INTO `feel_region` VALUES (463, '1', '21', '10', '3', '文圣区', 'Wensheng District', '');
INSERT INTO `feel_region` VALUES (464, '1', '21', '10', '4', '宏伟区', 'Grand District', '');
INSERT INTO `feel_region` VALUES (465, '1', '21', '10', '5', '弓长岭区', 'Gongchangling District', '');
INSERT INTO `feel_region` VALUES (466, '1', '21', '10', '11', '太子河区', 'Taizihe District', '');
INSERT INTO `feel_region` VALUES (467, '1', '21', '10', '21', '辽阳县', 'Liaoyang County', '');
INSERT INTO `feel_region` VALUES (468, '1', '21', '10', '81', '灯塔市', 'Lighthouse city', '');
INSERT INTO `feel_region` VALUES (469, '1', '21', '11', '2', '双台子区', 'Shuangtaizi District', '');
INSERT INTO `feel_region` VALUES (470, '1', '21', '11', '3', '兴隆台区', 'Xinglongtai District', '');
INSERT INTO `feel_region` VALUES (471, '1', '21', '11', '21', '大洼县', 'Dayi County', '');
INSERT INTO `feel_region` VALUES (472, '1', '21', '11', '22', '盘山县', 'Panshan County', '');
INSERT INTO `feel_region` VALUES (473, '1', '21', '12', '2', '银州区', 'Yinzhou District', '');
INSERT INTO `feel_region` VALUES (474, '1', '21', '12', '4', '清河区', 'Qinghe District', '');
INSERT INTO `feel_region` VALUES (475, '1', '21', '12', '21', '铁岭县', 'Tieling County', '');
INSERT INTO `feel_region` VALUES (476, '1', '21', '12', '23', '西丰县', 'Xifeng County', '');
INSERT INTO `feel_region` VALUES (477, '1', '21', '12', '24', '昌图县', 'Changtu County', '');
INSERT INTO `feel_region` VALUES (478, '1', '21', '12', '81', '调兵山市', 'Diaobingshan', '');
INSERT INTO `feel_region` VALUES (479, '1', '21', '12', '82', '开原市', 'Kaiyuan City', '');
INSERT INTO `feel_region` VALUES (480, '1', '21', '13', '2', '双塔区', 'Twin tower', '');
INSERT INTO `feel_region` VALUES (481, '1', '21', '13', '3', '龙城区', 'Longcheng District', '');
INSERT INTO `feel_region` VALUES (482, '1', '21', '13', '21', '朝阳县', 'Chaoyang County', '');
INSERT INTO `feel_region` VALUES (483, '1', '21', '13', '22', '建平县', 'Jianping County', '');
INSERT INTO `feel_region` VALUES (484, '1', '21', '13', '24', '喀喇沁左翼蒙古族自治县', 'Karachi Left Mongolian Autonomous County', '');
INSERT INTO `feel_region` VALUES (485, '1', '21', '13', '81', '北票市', 'Beipiao City', '');
INSERT INTO `feel_region` VALUES (486, '1', '21', '13', '82', '凌源市', 'Lingyuan City', '');
INSERT INTO `feel_region` VALUES (487, '1', '21', '14', '2', '连山区', 'Lianshan District', '');
INSERT INTO `feel_region` VALUES (488, '1', '21', '14', '3', '龙港区', 'Longgang District', '');
INSERT INTO `feel_region` VALUES (489, '1', '21', '14', '4', '南票区', 'Nanbu District', '');
INSERT INTO `feel_region` VALUES (490, '1', '21', '14', '21', '绥中县', 'Yuzhong County', '');
INSERT INTO `feel_region` VALUES (491, '1', '21', '14', '22', '建昌县', 'Jianchang County', '');
INSERT INTO `feel_region` VALUES (492, '1', '21', '14', '81', '兴城市', 'Xingcheng', '');
INSERT INTO `feel_region` VALUES (493, '1', '22', '1', '2', '南关区', 'Nanguan District', '');
INSERT INTO `feel_region` VALUES (494, '1', '22', '1', '3', '宽城区', 'Kuancheng District', '');
INSERT INTO `feel_region` VALUES (495, '1', '22', '1', '4', '朝阳区', 'Chaoyang District', '');
INSERT INTO `feel_region` VALUES (496, '1', '22', '1', '5', '二道区', 'Erdao District', '');
INSERT INTO `feel_region` VALUES (497, '1', '22', '1', '6', '绿园区', 'Green Park', '');
INSERT INTO `feel_region` VALUES (498, '1', '22', '1', '12', '双阳区', 'Shuangyang District', '');
INSERT INTO `feel_region` VALUES (499, '1', '22', '1', '22', '农安县', 'Nong\'an County', '');
INSERT INTO `feel_region` VALUES (500, '1', '22', '1', '81', '九台市', 'Jiutai City', '');
INSERT INTO `feel_region` VALUES (501, '1', '22', '1', '82', '榆树市', 'Yushu City', '');
INSERT INTO `feel_region` VALUES (502, '1', '22', '1', '83', '德惠市', 'Dehui City', '');
INSERT INTO `feel_region` VALUES (503, '1', '22', '2', '2', '昌邑区', 'Changyi District', '');
INSERT INTO `feel_region` VALUES (504, '1', '22', '2', '3', '龙潭区', 'Longtan District', '');
INSERT INTO `feel_region` VALUES (505, '1', '22', '2', '4', '船营区', 'Boat camp', '');
INSERT INTO `feel_region` VALUES (506, '1', '22', '2', '11', '丰满区', 'Fengman District', '');
INSERT INTO `feel_region` VALUES (507, '1', '22', '2', '21', '永吉县', 'Yongji County', '');
INSERT INTO `feel_region` VALUES (508, '1', '22', '2', '81', '蛟河市', 'Luohe City', '');
INSERT INTO `feel_region` VALUES (509, '1', '22', '2', '82', '桦甸市', 'Huadian City', '');
INSERT INTO `feel_region` VALUES (510, '1', '22', '2', '83', '舒兰市', 'Shulan City', '');
INSERT INTO `feel_region` VALUES (511, '1', '22', '2', '84', '磐石市', 'Panshi City', '');
INSERT INTO `feel_region` VALUES (512, '1', '22', '3', '2', '铁西区', 'Tiexi District', '');
INSERT INTO `feel_region` VALUES (513, '1', '22', '3', '3', '铁东区', 'Tiedong District', '');
INSERT INTO `feel_region` VALUES (514, '1', '22', '3', '22', '梨树县', 'Lishu County', '');
INSERT INTO `feel_region` VALUES (515, '1', '22', '3', '23', '伊通满族自治县', 'Yitong Manchu Autonomous County', '');
INSERT INTO `feel_region` VALUES (516, '1', '22', '3', '81', '公主岭市', 'Gongzhuling City', '');
INSERT INTO `feel_region` VALUES (517, '1', '22', '3', '82', '双辽市', 'Shuangliao City', '');
INSERT INTO `feel_region` VALUES (518, '1', '22', '4', '2', '龙山区', 'Longshan District', '');
INSERT INTO `feel_region` VALUES (519, '1', '22', '4', '3', '西安区', 'Xi\'an District', '');
INSERT INTO `feel_region` VALUES (520, '1', '22', '4', '21', '东丰县', 'Dongfeng County', '');
INSERT INTO `feel_region` VALUES (521, '1', '22', '4', '22', '东辽县', 'Dongliao County', '');
INSERT INTO `feel_region` VALUES (522, '1', '22', '5', '2', '东昌区', 'Dongchang District', '');
INSERT INTO `feel_region` VALUES (523, '1', '22', '5', '3', '二道江区', 'Erdaojiang District', '');
INSERT INTO `feel_region` VALUES (524, '1', '22', '5', '21', '通化县', 'Tonghua County', '');
INSERT INTO `feel_region` VALUES (525, '1', '22', '5', '23', '辉南县', 'Huinan County', '');
INSERT INTO `feel_region` VALUES (526, '1', '22', '5', '24', '柳河县', 'Liuhe County', '');
INSERT INTO `feel_region` VALUES (527, '1', '22', '5', '81', '梅河口市', 'Meihekou City', '');
INSERT INTO `feel_region` VALUES (528, '1', '22', '5', '82', '集安市', 'Ji\'an City', '');
INSERT INTO `feel_region` VALUES (529, '1', '22', '6', '2', '八道江区', 'Badaojiang District', '');
INSERT INTO `feel_region` VALUES (530, '1', '22', '6', '5', '江源区', 'Jiangyuan District', '');
INSERT INTO `feel_region` VALUES (531, '1', '22', '6', '21', '抚松县', 'Fusong County', '');
INSERT INTO `feel_region` VALUES (532, '1', '22', '6', '22', '靖宇县', 'Jingyu County', '');
INSERT INTO `feel_region` VALUES (533, '1', '22', '6', '23', '长白朝鲜族自治县', 'Changbai Korean Autonomous County', '');
INSERT INTO `feel_region` VALUES (534, '1', '22', '6', '81', '临江市', 'Linjiang City', '');
INSERT INTO `feel_region` VALUES (535, '1', '22', '7', '2', '宁江区', 'Ningjiang District', '');
INSERT INTO `feel_region` VALUES (536, '1', '22', '7', '21', '前郭尔罗斯蒙古族自治县', 'Qianguoerluosi Mongolian Autonomous County', '');
INSERT INTO `feel_region` VALUES (537, '1', '22', '7', '22', '长岭县', 'Changling County', '');
INSERT INTO `feel_region` VALUES (538, '1', '22', '7', '23', '乾安县', 'Qian\'an County', '');
INSERT INTO `feel_region` VALUES (539, '1', '22', '7', '24', '扶余县', 'Fuyu County', '');
INSERT INTO `feel_region` VALUES (540, '1', '22', '8', '2', '洮北区', 'Yubei District', '');
INSERT INTO `feel_region` VALUES (541, '1', '22', '8', '21', '镇赉县', 'Zhenlai County', '');
INSERT INTO `feel_region` VALUES (542, '1', '22', '8', '22', '通榆县', 'Tongyu County', '');
INSERT INTO `feel_region` VALUES (543, '1', '22', '8', '81', '洮南市', 'Weinan City', '');
INSERT INTO `feel_region` VALUES (544, '1', '22', '8', '82', '大安市', 'Daan City', '');
INSERT INTO `feel_region` VALUES (545, '1', '22', '24', '1', '延吉市', 'Yanji City', '');
INSERT INTO `feel_region` VALUES (546, '1', '22', '24', '2', '图们市', 'Tumen City', '');
INSERT INTO `feel_region` VALUES (547, '1', '22', '24', '3', '敦化市', 'Dunhua City', '');
INSERT INTO `feel_region` VALUES (548, '1', '22', '24', '4', '珲春市', 'Hunchun City', '');
INSERT INTO `feel_region` VALUES (549, '1', '22', '24', '5', '龙井市', 'Longjing City', '');
INSERT INTO `feel_region` VALUES (550, '1', '22', '24', '6', '和龙市', 'Helong City', '');
INSERT INTO `feel_region` VALUES (551, '1', '22', '24', '24', '汪清县', 'Wangqing County', '');
INSERT INTO `feel_region` VALUES (552, '1', '22', '24', '26', '安图县', 'Antu County', '');
INSERT INTO `feel_region` VALUES (553, '1', '23', '1', '2', '道里区', 'Daoli District', '');
INSERT INTO `feel_region` VALUES (554, '1', '23', '1', '3', '南岗区', 'Nangang District', '');
INSERT INTO `feel_region` VALUES (555, '1', '23', '1', '4', '道外区', 'Outer road area', '');
INSERT INTO `feel_region` VALUES (556, '1', '23', '1', '8', '平房区', 'Cottage area', '');
INSERT INTO `feel_region` VALUES (557, '1', '23', '1', '9', '松北区', 'Songbei District', '');
INSERT INTO `feel_region` VALUES (558, '1', '23', '1', '10', '香坊区', 'Xiangfang District', '');
INSERT INTO `feel_region` VALUES (559, '1', '23', '1', '11', '呼兰区', 'Hulan District', '');
INSERT INTO `feel_region` VALUES (560, '1', '23', '1', '12', '阿城区', 'Acheng District', '');
INSERT INTO `feel_region` VALUES (561, '1', '23', '1', '23', '依兰县', 'Yilan County', '');
INSERT INTO `feel_region` VALUES (562, '1', '23', '1', '24', '方正县', 'Fangzheng County', '');
INSERT INTO `feel_region` VALUES (563, '1', '23', '1', '25', '宾　县', 'Bin County', '');
INSERT INTO `feel_region` VALUES (564, '1', '23', '1', '26', '巴彦县', 'Bayan County', '');
INSERT INTO `feel_region` VALUES (565, '1', '23', '1', '27', '木兰县', 'Mulan County', '');
INSERT INTO `feel_region` VALUES (566, '1', '23', '1', '28', '通河县', 'Tonghe County', '');
INSERT INTO `feel_region` VALUES (567, '1', '23', '1', '29', '延寿县', 'Yanshou County', '');
INSERT INTO `feel_region` VALUES (568, '1', '23', '1', '82', '双城市', 'Double city', '');
INSERT INTO `feel_region` VALUES (569, '1', '23', '1', '83', '尚志市', 'Shangzhi City', '');
INSERT INTO `feel_region` VALUES (570, '1', '23', '1', '84', '五常市', 'Wuchang City', '');
INSERT INTO `feel_region` VALUES (571, '1', '23', '2', '2', '龙沙区', 'Longsha District', '');
INSERT INTO `feel_region` VALUES (572, '1', '23', '2', '3', '建华区', 'Jianhua District', '');
INSERT INTO `feel_region` VALUES (573, '1', '23', '2', '4', '铁锋区', 'Tiefeng District', '');
INSERT INTO `feel_region` VALUES (574, '1', '23', '2', '5', '昂昂溪区', 'Ang\'angxi District', '');
INSERT INTO `feel_region` VALUES (575, '1', '23', '2', '6', '富拉尔基区', 'Fulaerki District', '');
INSERT INTO `feel_region` VALUES (576, '1', '23', '2', '7', '碾子山区', 'Nianzishan', '');
INSERT INTO `feel_region` VALUES (577, '1', '23', '2', '8', '梅里斯达斡尔族区', 'Merisda Daur District', '');
INSERT INTO `feel_region` VALUES (578, '1', '23', '2', '21', '龙江县', 'Longjiang County', '');
INSERT INTO `feel_region` VALUES (579, '1', '23', '2', '23', '依安县', 'Yi\'an County', '');
INSERT INTO `feel_region` VALUES (580, '1', '23', '2', '24', '泰来县', 'Tailai County', '');
INSERT INTO `feel_region` VALUES (581, '1', '23', '2', '25', '甘南县', 'Gannan County', '');
INSERT INTO `feel_region` VALUES (582, '1', '23', '2', '27', '富裕县', 'Fuyu County', '');
INSERT INTO `feel_region` VALUES (583, '1', '23', '2', '29', '克山县', 'Keshan County', '');
INSERT INTO `feel_region` VALUES (584, '1', '23', '2', '30', '克东县', 'Kedong County', '');
INSERT INTO `feel_region` VALUES (585, '1', '23', '2', '31', '拜泉县', 'Baiquan County', '');
INSERT INTO `feel_region` VALUES (586, '1', '23', '2', '81', '讷河市', 'Nehe', '');
INSERT INTO `feel_region` VALUES (587, '1', '23', '3', '2', '鸡冠区', 'Jiguan District', '');
INSERT INTO `feel_region` VALUES (588, '1', '23', '3', '3', '恒山区', 'Hengshan District', '');
INSERT INTO `feel_region` VALUES (589, '1', '23', '3', '4', '滴道区', 'Drip zone', '');
INSERT INTO `feel_region` VALUES (590, '1', '23', '3', '5', '梨树区', 'Pear tree area', '');
INSERT INTO `feel_region` VALUES (591, '1', '23', '3', '6', '城子河区', 'Chengzihe District', '');
INSERT INTO `feel_region` VALUES (592, '1', '23', '3', '7', '麻山区', 'Mashan District', '');
INSERT INTO `feel_region` VALUES (593, '1', '23', '3', '21', '鸡东县', 'Jidong County', '');
INSERT INTO `feel_region` VALUES (594, '1', '23', '3', '81', '虎林市', 'Hulin City', '');
INSERT INTO `feel_region` VALUES (595, '1', '23', '3', '82', '密山市', 'Mishan City', '');
INSERT INTO `feel_region` VALUES (596, '1', '23', '4', '2', '向阳区', 'Xiangyang District', '');
INSERT INTO `feel_region` VALUES (597, '1', '23', '4', '3', '工农区', 'Industrial and agricultural area', '');
INSERT INTO `feel_region` VALUES (598, '1', '23', '4', '4', '南山区', 'Nanshan District', '');
INSERT INTO `feel_region` VALUES (599, '1', '23', '4', '5', '兴安区', 'Xing\'an District', '');
INSERT INTO `feel_region` VALUES (600, '1', '23', '4', '6', '东山区', 'Dongshan District', '');
INSERT INTO `feel_region` VALUES (601, '1', '23', '4', '7', '兴山区', 'Xingshan District', '');
INSERT INTO `feel_region` VALUES (602, '1', '23', '4', '21', '萝北县', 'Luobei County', '');
INSERT INTO `feel_region` VALUES (603, '1', '23', '4', '22', '绥滨县', 'Sibin County', '');
INSERT INTO `feel_region` VALUES (604, '1', '23', '5', '2', '尖山区', 'Jianshan District', '');
INSERT INTO `feel_region` VALUES (605, '1', '23', '5', '3', '岭东区', 'Lingdong District', '');
INSERT INTO `feel_region` VALUES (606, '1', '23', '5', '5', '四方台区', 'Sifangtai District', '');
INSERT INTO `feel_region` VALUES (607, '1', '23', '5', '6', '宝山区', 'Baoshan District', '');
INSERT INTO `feel_region` VALUES (608, '1', '23', '5', '21', '集贤县', 'Jixian County', '');
INSERT INTO `feel_region` VALUES (609, '1', '23', '5', '22', '友谊县', 'Friendship County', '');
INSERT INTO `feel_region` VALUES (610, '1', '23', '5', '23', '宝清县', 'Baoqing County', '');
INSERT INTO `feel_region` VALUES (611, '1', '23', '5', '24', '饶河县', 'Raohe County', '');
INSERT INTO `feel_region` VALUES (612, '1', '23', '6', '2', '萨尔图区', 'Saltu District', '');
INSERT INTO `feel_region` VALUES (613, '1', '23', '6', '3', '龙凤区', 'Longfeng District', '');
INSERT INTO `feel_region` VALUES (614, '1', '23', '6', '4', '让胡路区', 'Let Hulu District', '');
INSERT INTO `feel_region` VALUES (615, '1', '23', '6', '5', '红岗区', 'Honggang District', '');
INSERT INTO `feel_region` VALUES (616, '1', '23', '6', '6', '大同区', 'Datong District', '');
INSERT INTO `feel_region` VALUES (617, '1', '23', '6', '21', '肇州县', 'Quzhou County', '');
INSERT INTO `feel_region` VALUES (618, '1', '23', '6', '22', '肇源县', 'Wuyuan County', '');
INSERT INTO `feel_region` VALUES (619, '1', '23', '6', '23', '林甸县', 'Lindian County', '');
INSERT INTO `feel_region` VALUES (620, '1', '23', '6', '24', '杜尔伯特蒙古族自治县', 'Durbert Mongolian Autonomous County', '');
INSERT INTO `feel_region` VALUES (621, '1', '23', '7', '2', '伊春区', 'Yichun District', '');
INSERT INTO `feel_region` VALUES (622, '1', '23', '7', '3', '南岔区', 'Nanxun District', '');
INSERT INTO `feel_region` VALUES (623, '1', '23', '7', '4', '友好区', 'Friendly area', '');
INSERT INTO `feel_region` VALUES (624, '1', '23', '7', '5', '西林区', 'Xilin District', '');
INSERT INTO `feel_region` VALUES (625, '1', '23', '7', '6', '翠峦区', 'Cuiyu District', '');
INSERT INTO `feel_region` VALUES (626, '1', '23', '7', '7', '新青区', 'Xinqing District', '');
INSERT INTO `feel_region` VALUES (627, '1', '23', '7', '8', '美溪区', 'Meixi District', '');
INSERT INTO `feel_region` VALUES (628, '1', '23', '7', '9', '金山屯区', 'Jinshanyu District', '');
INSERT INTO `feel_region` VALUES (629, '1', '23', '7', '10', '五营区', 'Wuying District', '');
INSERT INTO `feel_region` VALUES (630, '1', '23', '7', '11', '乌马河区', 'Uma River District', '');
INSERT INTO `feel_region` VALUES (631, '1', '23', '7', '12', '汤旺河区', 'Tangwanghe District', '');
INSERT INTO `feel_region` VALUES (632, '1', '23', '7', '13', '带岭区', 'Belted area', '');
INSERT INTO `feel_region` VALUES (633, '1', '23', '7', '14', '乌伊岭区', 'Wuyiling District', '');
INSERT INTO `feel_region` VALUES (634, '1', '23', '7', '15', '红星区', 'Red Star District', '');
INSERT INTO `feel_region` VALUES (635, '1', '23', '7', '16', '上甘岭区', 'Shangganling District', '');
INSERT INTO `feel_region` VALUES (636, '1', '23', '7', '22', '嘉荫县', 'Jiayin County', '');
INSERT INTO `feel_region` VALUES (637, '1', '23', '7', '81', '铁力市', 'Tieli City', '');
INSERT INTO `feel_region` VALUES (638, '1', '23', '8', '3', '向阳区', 'Xiangyang District', '');
INSERT INTO `feel_region` VALUES (639, '1', '23', '8', '4', '前进区', 'Forward area', '');
INSERT INTO `feel_region` VALUES (640, '1', '23', '8', '5', '东风区', 'Dongfeng District', '');
INSERT INTO `feel_region` VALUES (641, '1', '23', '8', '11', '郊　区', 'Suburb', '');
INSERT INTO `feel_region` VALUES (642, '1', '23', '8', '22', '桦南县', 'Huanan County', '');
INSERT INTO `feel_region` VALUES (643, '1', '23', '8', '26', '桦川县', 'Huachuan County', '');
INSERT INTO `feel_region` VALUES (644, '1', '23', '8', '28', '汤原县', 'Tangyuan County', '');
INSERT INTO `feel_region` VALUES (645, '1', '23', '8', '33', '抚远县', 'Fuyuan County', '');
INSERT INTO `feel_region` VALUES (646, '1', '23', '8', '81', '同江市', 'Tongjiang City', '');
INSERT INTO `feel_region` VALUES (647, '1', '23', '8', '82', '富锦市', 'Fujin City', '');
INSERT INTO `feel_region` VALUES (648, '1', '23', '9', '2', '新兴区', 'Emerging area', '');
INSERT INTO `feel_region` VALUES (649, '1', '23', '9', '3', '桃山区', 'Taoshan District', '');
INSERT INTO `feel_region` VALUES (650, '1', '23', '9', '4', '茄子河区', 'Eggplant River District', '');
INSERT INTO `feel_region` VALUES (651, '1', '23', '9', '21', '勃利县', 'Boli County', '');
INSERT INTO `feel_region` VALUES (652, '1', '23', '10', '2', '东安区', 'Dong\'an District', '');
INSERT INTO `feel_region` VALUES (653, '1', '23', '10', '3', '阳明区', 'Yangming District', '');
INSERT INTO `feel_region` VALUES (654, '1', '23', '10', '4', '爱民区', 'Aimin District', '');
INSERT INTO `feel_region` VALUES (655, '1', '23', '10', '5', '西安区', 'Xi\'an District', '');
INSERT INTO `feel_region` VALUES (656, '1', '23', '10', '24', '东宁县', 'Dongning County', '');
INSERT INTO `feel_region` VALUES (657, '1', '23', '10', '25', '林口县', 'Linkou County', '');
INSERT INTO `feel_region` VALUES (658, '1', '23', '10', '81', '绥芬河市', 'Suifenhe', '');
INSERT INTO `feel_region` VALUES (659, '1', '23', '10', '83', '海林市', 'Hailin City', '');
INSERT INTO `feel_region` VALUES (660, '1', '23', '10', '84', '宁安市', 'Ning\'an City', '');
INSERT INTO `feel_region` VALUES (661, '1', '23', '10', '85', '穆棱市', 'Muling City', '');
INSERT INTO `feel_region` VALUES (662, '1', '23', '11', '2', '爱辉区', 'Aihui District', '');
INSERT INTO `feel_region` VALUES (663, '1', '23', '11', '21', '嫩江县', 'Nenjiang County', '');
INSERT INTO `feel_region` VALUES (664, '1', '23', '11', '23', '逊克县', 'Xunke County', '');
INSERT INTO `feel_region` VALUES (665, '1', '23', '11', '24', '孙吴县', 'Sun Wu County', '');
INSERT INTO `feel_region` VALUES (666, '1', '23', '11', '81', '北安市', 'Bei\'an City', '');
INSERT INTO `feel_region` VALUES (667, '1', '23', '11', '82', '五大连池市', 'Wudalianchi City', '');
INSERT INTO `feel_region` VALUES (668, '1', '23', '12', '2', '北林区', 'Beilin District', '');
INSERT INTO `feel_region` VALUES (669, '1', '23', '12', '21', '望奎县', 'Wangkui County', '');
INSERT INTO `feel_region` VALUES (670, '1', '23', '12', '22', '兰西县', 'Lanxi County', '');
INSERT INTO `feel_region` VALUES (671, '1', '23', '12', '23', '青冈县', 'Qinggang County', '');
INSERT INTO `feel_region` VALUES (672, '1', '23', '12', '24', '庆安县', 'Qing\'an County', '');
INSERT INTO `feel_region` VALUES (673, '1', '23', '12', '25', '明水县', 'Mingshui County', '');
INSERT INTO `feel_region` VALUES (674, '1', '23', '12', '26', '绥棱县', 'Yuling County', '');
INSERT INTO `feel_region` VALUES (675, '1', '23', '12', '81', '安达市', 'Anda City', '');
INSERT INTO `feel_region` VALUES (676, '1', '23', '12', '82', '肇东市', 'Zhaodong City', '');
INSERT INTO `feel_region` VALUES (677, '1', '23', '12', '83', '海伦市', 'Helen City', '');
INSERT INTO `feel_region` VALUES (678, '1', '23', '27', '21', '呼玛县', 'Huma County', '');
INSERT INTO `feel_region` VALUES (679, '1', '23', '27', '22', '塔河县', 'Tahe County', '');
INSERT INTO `feel_region` VALUES (680, '1', '23', '27', '23', '漠河县', 'Mohe County', '');
INSERT INTO `feel_region` VALUES (681, '1', '32', '1', '2', '玄武区', 'Xuanwu District', '');
INSERT INTO `feel_region` VALUES (682, '1', '32', '1', '3', '白下区', 'Baixia District', '');
INSERT INTO `feel_region` VALUES (683, '1', '32', '1', '4', '秦淮区', 'Qinhuai District', '');
INSERT INTO `feel_region` VALUES (684, '1', '32', '1', '5', '建邺区', 'Jianye District', '');
INSERT INTO `feel_region` VALUES (685, '1', '32', '1', '6', '鼓楼区', 'Gulou District', '');
INSERT INTO `feel_region` VALUES (686, '1', '32', '1', '7', '下关区', 'Xiaguan District', '');
INSERT INTO `feel_region` VALUES (687, '1', '32', '1', '11', '浦口区', 'Pukou District', '');
INSERT INTO `feel_region` VALUES (688, '1', '32', '1', '13', '栖霞区', 'Qixia District', '');
INSERT INTO `feel_region` VALUES (689, '1', '32', '1', '14', '雨花台区', 'Yuhuatai District', '');
INSERT INTO `feel_region` VALUES (690, '1', '32', '1', '15', '江宁区', 'Jiangning District', '');
INSERT INTO `feel_region` VALUES (691, '1', '32', '1', '16', '六合区', 'Liuhe District', '');
INSERT INTO `feel_region` VALUES (692, '1', '32', '1', '24', '溧水县', 'Yishui County', '');
INSERT INTO `feel_region` VALUES (693, '1', '32', '1', '25', '高淳县', 'Gaochun County', '');
INSERT INTO `feel_region` VALUES (694, '1', '32', '2', '2', '崇安区', 'Chong\'an District', '');
INSERT INTO `feel_region` VALUES (695, '1', '32', '2', '3', '南长区', 'Nanchang District', '');
INSERT INTO `feel_region` VALUES (696, '1', '32', '2', '4', '北塘区', 'Beitang District', '');
INSERT INTO `feel_region` VALUES (697, '1', '32', '2', '5', '锡山区', 'Xishan District', '');
INSERT INTO `feel_region` VALUES (698, '1', '32', '2', '6', '惠山区', 'Huishan District', '');
INSERT INTO `feel_region` VALUES (699, '1', '32', '2', '11', '滨湖区', 'Lake District', '');
INSERT INTO `feel_region` VALUES (700, '1', '32', '2', '81', '江阴市', 'Jiangyin City', '');
INSERT INTO `feel_region` VALUES (701, '1', '32', '2', '82', '宜兴市', 'Yixing City', '');
INSERT INTO `feel_region` VALUES (702, '1', '32', '3', '2', '鼓楼区', 'Gulou District', '');
INSERT INTO `feel_region` VALUES (703, '1', '32', '3', '3', '云龙区', 'Yunlong District', '');
INSERT INTO `feel_region` VALUES (704, '1', '32', '3', '4', '九里区', 'Jiuli District', '');
INSERT INTO `feel_region` VALUES (705, '1', '32', '3', '5', '贾汪区', 'Jiawang District', '');
INSERT INTO `feel_region` VALUES (706, '1', '32', '3', '11', '泉山区', 'Quanshan District', '');
INSERT INTO `feel_region` VALUES (707, '1', '32', '3', '21', '丰　县', 'Feng County', '');
INSERT INTO `feel_region` VALUES (708, '1', '32', '3', '22', '沛　县', 'Pei County', '');
INSERT INTO `feel_region` VALUES (709, '1', '32', '3', '23', '铜山县', 'Tongshan County', '');
INSERT INTO `feel_region` VALUES (710, '1', '32', '3', '24', '睢宁县', 'Suining County', '');
INSERT INTO `feel_region` VALUES (711, '1', '32', '3', '81', '新沂市', 'Xinyi City', '');
INSERT INTO `feel_region` VALUES (712, '1', '32', '3', '82', '邳州市', 'Quzhou City', '');
INSERT INTO `feel_region` VALUES (713, '1', '32', '4', '2', '天宁区', 'Tianning District', '');
INSERT INTO `feel_region` VALUES (714, '1', '32', '4', '4', '钟楼区', 'Clock tower area', '');
INSERT INTO `feel_region` VALUES (715, '1', '32', '4', '5', '戚墅堰区', 'Qishuyan District', '');
INSERT INTO `feel_region` VALUES (716, '1', '32', '4', '11', '新北区', 'Xinbei District', '');
INSERT INTO `feel_region` VALUES (717, '1', '32', '4', '12', '武进区', 'Wujin District', '');
INSERT INTO `feel_region` VALUES (718, '1', '32', '4', '81', '溧阳市', 'Fuyang City', '');
INSERT INTO `feel_region` VALUES (719, '1', '32', '4', '82', '金坛市', 'Jintan City', '');
INSERT INTO `feel_region` VALUES (720, '1', '32', '5', '4', '姑苏区', 'Gusu District', '');
INSERT INTO `feel_region` VALUES (721, '1', '32', '5', '5', '虎丘区', 'Huqiu District', '');
INSERT INTO `feel_region` VALUES (722, '1', '32', '5', '6', '吴中区', 'Wuzhong District', '');
INSERT INTO `feel_region` VALUES (723, '1', '32', '5', '7', '相城区', 'Xiangcheng District', '');
INSERT INTO `feel_region` VALUES (724, '1', '32', '5', '8', '吴江区', 'Wujiang District', '');
INSERT INTO `feel_region` VALUES (725, '1', '32', '5', '81', '常熟市', 'Changshu', '');
INSERT INTO `feel_region` VALUES (726, '1', '32', '5', '82', '张家港市', 'Zhangjiagang City', '');
INSERT INTO `feel_region` VALUES (727, '1', '32', '5', '83', '昆山市', 'Kunshan', '');
INSERT INTO `feel_region` VALUES (728, '1', '32', '5', '85', '太仓市', 'Taicang City', '');
INSERT INTO `feel_region` VALUES (729, '1', '32', '6', '2', '崇川区', 'Chongchuan District', '');
INSERT INTO `feel_region` VALUES (730, '1', '32', '6', '11', '港闸区', 'Gangzha District', '');
INSERT INTO `feel_region` VALUES (731, '1', '32', '6', '21', '海安县', 'Hai\'an County', '');
INSERT INTO `feel_region` VALUES (732, '1', '32', '6', '23', '如东县', 'Rudong County', '');
INSERT INTO `feel_region` VALUES (733, '1', '32', '6', '81', '启东市', 'Qidong City', '');
INSERT INTO `feel_region` VALUES (734, '1', '32', '6', '82', '如皋市', 'Rugao', '');
INSERT INTO `feel_region` VALUES (735, '1', '32', '6', '83', '通州市', 'Tongzhou City', '');
INSERT INTO `feel_region` VALUES (736, '1', '32', '6', '84', '海门市', 'Haimen City', '');
INSERT INTO `feel_region` VALUES (737, '1', '32', '7', '3', '连云区', 'Lianyun District', '');
INSERT INTO `feel_region` VALUES (738, '1', '32', '7', '5', '新浦区', 'Xinpu District', '');
INSERT INTO `feel_region` VALUES (739, '1', '32', '7', '6', '海州区', 'Haizhou District', '');
INSERT INTO `feel_region` VALUES (740, '1', '32', '7', '21', '赣榆县', 'Ji County', '');
INSERT INTO `feel_region` VALUES (741, '1', '32', '7', '22', '东海县', 'Donghai County', '');
INSERT INTO `feel_region` VALUES (742, '1', '32', '7', '23', '灌云县', 'Guanyun County', '');
INSERT INTO `feel_region` VALUES (743, '1', '32', '7', '24', '灌南县', 'Guannan County', '');
INSERT INTO `feel_region` VALUES (744, '1', '32', '8', '2', '清河区', 'Qinghe District', '');
INSERT INTO `feel_region` VALUES (745, '1', '32', '8', '3', '淮安区', 'Huai\'an District', '');
INSERT INTO `feel_region` VALUES (746, '1', '32', '8', '4', '淮阴区', 'Huaiyin District', '');
INSERT INTO `feel_region` VALUES (747, '1', '32', '8', '11', '清浦区', 'Qingpu District', '');
INSERT INTO `feel_region` VALUES (748, '1', '32', '8', '26', '涟水县', 'Yishui County', '');
INSERT INTO `feel_region` VALUES (749, '1', '32', '8', '29', '洪泽县', 'Hongze County', '');
INSERT INTO `feel_region` VALUES (750, '1', '32', '8', '30', '盱眙县', 'Ji County', '');
INSERT INTO `feel_region` VALUES (751, '1', '32', '8', '31', '金湖县', 'Jinhu County', '');
INSERT INTO `feel_region` VALUES (752, '1', '32', '9', '2', '亭湖区', 'Tinghu District', '');
INSERT INTO `feel_region` VALUES (753, '1', '32', '9', '3', '盐都区', 'Yandu District', '');
INSERT INTO `feel_region` VALUES (754, '1', '32', '9', '21', '响水县', 'Xiangshui County', '');
INSERT INTO `feel_region` VALUES (755, '1', '32', '9', '22', '滨海县', 'Binhai County', '');
INSERT INTO `feel_region` VALUES (756, '1', '32', '9', '23', '阜宁县', 'Suining County', '');
INSERT INTO `feel_region` VALUES (757, '1', '32', '9', '24', '射阳县', 'Sheyang County', '');
INSERT INTO `feel_region` VALUES (758, '1', '32', '9', '25', '建湖县', 'Jianhu County', '');
INSERT INTO `feel_region` VALUES (759, '1', '32', '9', '81', '东台市', 'Dongtai City', '');
INSERT INTO `feel_region` VALUES (760, '1', '32', '9', '82', '大丰市', 'Dafeng City', '');
INSERT INTO `feel_region` VALUES (761, '1', '32', '10', '2', '广陵区', 'Guangling District', '');
INSERT INTO `feel_region` VALUES (762, '1', '32', '10', '3', '邗江区', 'Hanjiang District', '');
INSERT INTO `feel_region` VALUES (763, '1', '32', '10', '11', '维扬区', 'Weiyang District', '');
INSERT INTO `feel_region` VALUES (764, '1', '32', '10', '23', '宝应县', 'Baoying County', '');
INSERT INTO `feel_region` VALUES (765, '1', '32', '10', '81', '仪征市', 'Yizheng City', '');
INSERT INTO `feel_region` VALUES (766, '1', '32', '10', '84', '高邮市', 'Gaoyou City', '');
INSERT INTO `feel_region` VALUES (767, '1', '32', '10', '88', '江都市', 'Jiangdu', '');
INSERT INTO `feel_region` VALUES (768, '1', '32', '11', '2', '京口区', 'Jingkou District', '');
INSERT INTO `feel_region` VALUES (769, '1', '32', '11', '11', '润州区', 'Runzhou District', '');
INSERT INTO `feel_region` VALUES (770, '1', '32', '11', '12', '丹徒区', 'Dantu District', '');
INSERT INTO `feel_region` VALUES (771, '1', '32', '11', '81', '丹阳市', 'Danyang City', '');
INSERT INTO `feel_region` VALUES (772, '1', '32', '11', '82', '扬中市', 'Yangzhong City', '');
INSERT INTO `feel_region` VALUES (773, '1', '32', '11', '83', '句容市', 'Jurong City', '');
INSERT INTO `feel_region` VALUES (774, '1', '32', '12', '2', '海陵区', 'Hailing District', '');
INSERT INTO `feel_region` VALUES (775, '1', '32', '12', '3', '高港区', 'Gaogang District', '');
INSERT INTO `feel_region` VALUES (776, '1', '32', '12', '81', '兴化市', 'Xinghua City', '');
INSERT INTO `feel_region` VALUES (777, '1', '32', '12', '82', '靖江市', 'Jingjiang City', '');
INSERT INTO `feel_region` VALUES (778, '1', '32', '12', '83', '泰兴市', 'Taixing City', '');
INSERT INTO `feel_region` VALUES (779, '1', '32', '12', '84', '姜堰市', 'Jiangyan City', '');
INSERT INTO `feel_region` VALUES (780, '1', '32', '13', '2', '宿城区', 'Ceci City', '');
INSERT INTO `feel_region` VALUES (781, '1', '32', '13', '11', '宿豫区', 'Suyu District', '');
INSERT INTO `feel_region` VALUES (782, '1', '32', '13', '22', '沭阳县', 'Shuyang County', '');
INSERT INTO `feel_region` VALUES (783, '1', '32', '13', '23', '泗阳县', 'Shuyang County', '');
INSERT INTO `feel_region` VALUES (784, '1', '32', '13', '24', '泗洪县', 'Sihong County', '');
INSERT INTO `feel_region` VALUES (785, '1', '33', '1', '2', '上城区', 'Uptown', '');
INSERT INTO `feel_region` VALUES (786, '1', '33', '1', '3', '下城区', 'Downtown area', '');
INSERT INTO `feel_region` VALUES (787, '1', '33', '1', '4', '江干区', 'Jianggan District', '');
INSERT INTO `feel_region` VALUES (788, '1', '33', '1', '5', '拱墅区', 'Gongshu District', '');
INSERT INTO `feel_region` VALUES (789, '1', '33', '1', '6', '西湖区', 'West Lake District', '');
INSERT INTO `feel_region` VALUES (790, '1', '33', '1', '8', '滨江区', 'Binjiang District', '');
INSERT INTO `feel_region` VALUES (791, '1', '33', '1', '9', '萧山区', 'Xiaoshan Strict', '');
INSERT INTO `feel_region` VALUES (792, '1', '33', '1', '10', '余杭区', 'Yuhang District', '');
INSERT INTO `feel_region` VALUES (793, '1', '33', '1', '22', '桐庐县', 'Tonglu County', '');
INSERT INTO `feel_region` VALUES (794, '1', '33', '1', '27', '淳安县', 'Chun\'an County', '');
INSERT INTO `feel_region` VALUES (795, '1', '33', '1', '82', '建德市', 'Jiande City', '');
INSERT INTO `feel_region` VALUES (796, '1', '33', '1', '83', '富阳市', 'Fuyang City', '');
INSERT INTO `feel_region` VALUES (797, '1', '33', '1', '85', '临安市', 'Lin\'an City', '');
INSERT INTO `feel_region` VALUES (798, '1', '33', '2', '3', '海曙区', 'Haishu District', '');
INSERT INTO `feel_region` VALUES (799, '1', '33', '2', '4', '江东区', 'Jiangdong District', '');
INSERT INTO `feel_region` VALUES (800, '1', '33', '2', '5', '江北区', 'Jiangbei District', '');
INSERT INTO `feel_region` VALUES (801, '1', '33', '2', '6', '北仑区', 'Beilun District', '');
INSERT INTO `feel_region` VALUES (802, '1', '33', '2', '11', '镇海区', 'Zhenhai District', '');
INSERT INTO `feel_region` VALUES (803, '1', '33', '2', '12', '鄞州区', 'Yinzhou District', '');
INSERT INTO `feel_region` VALUES (804, '1', '33', '2', '25', '象山县', 'Xiangshan County', '');
INSERT INTO `feel_region` VALUES (805, '1', '33', '2', '26', '宁海县', 'Ninghai County', '');
INSERT INTO `feel_region` VALUES (806, '1', '33', '2', '81', '余姚市', 'Yuyao City', '');
INSERT INTO `feel_region` VALUES (807, '1', '33', '2', '82', '慈溪市', 'Cixi City', '');
INSERT INTO `feel_region` VALUES (808, '1', '33', '2', '83', '奉化市', 'Fenghua City', '');
INSERT INTO `feel_region` VALUES (809, '1', '33', '3', '2', '鹿城区', 'Lucheng District', '');
INSERT INTO `feel_region` VALUES (810, '1', '33', '3', '3', '龙湾区', 'Longwan District', '');
INSERT INTO `feel_region` VALUES (811, '1', '33', '3', '4', '瓯海区', 'Ouhai District', '');
INSERT INTO `feel_region` VALUES (812, '1', '33', '3', '22', '洞头县', 'Dongtou County', '');
INSERT INTO `feel_region` VALUES (813, '1', '33', '3', '24', '永嘉县', 'Yongjia County', '');
INSERT INTO `feel_region` VALUES (814, '1', '33', '3', '26', '平阳县', 'Pingyang County', '');
INSERT INTO `feel_region` VALUES (815, '1', '33', '3', '27', '苍南县', 'Cangnan County', '');
INSERT INTO `feel_region` VALUES (816, '1', '33', '3', '28', '文成县', 'Wencheng County', '');
INSERT INTO `feel_region` VALUES (817, '1', '33', '3', '29', '泰顺县', 'Taishun County', '');
INSERT INTO `feel_region` VALUES (818, '1', '33', '3', '81', '瑞安市', 'Ruian City', '');
INSERT INTO `feel_region` VALUES (819, '1', '33', '3', '82', '乐清市', 'Yueqing City', '');
INSERT INTO `feel_region` VALUES (820, '1', '33', '4', '2', '南湖区', 'Nanhu District', '');
INSERT INTO `feel_region` VALUES (821, '1', '33', '4', '11', '秀洲区', 'Xiuzhou District', '');
INSERT INTO `feel_region` VALUES (822, '1', '33', '4', '21', '嘉善县', 'Jiashan County', '');
INSERT INTO `feel_region` VALUES (823, '1', '33', '4', '24', '海盐县', 'Haiyan County', '');
INSERT INTO `feel_region` VALUES (824, '1', '33', '4', '81', '海宁市', 'Haining City', '');
INSERT INTO `feel_region` VALUES (825, '1', '33', '4', '82', '平湖市', 'Pinghu City', '');
INSERT INTO `feel_region` VALUES (826, '1', '33', '4', '83', '桐乡市', 'Tongxiang City', '');
INSERT INTO `feel_region` VALUES (827, '1', '33', '5', '2', '吴兴区', 'Wuxing District', '');
INSERT INTO `feel_region` VALUES (828, '1', '33', '5', '3', '南浔区', 'Nanxun District', '');
INSERT INTO `feel_region` VALUES (829, '1', '33', '5', '21', '德清县', 'Deqing County', '');
INSERT INTO `feel_region` VALUES (830, '1', '33', '5', '22', '长兴县', 'Changxing County', '');
INSERT INTO `feel_region` VALUES (831, '1', '33', '5', '23', '安吉县', 'Anji County', '');
INSERT INTO `feel_region` VALUES (832, '1', '33', '6', '2', '越城区', 'Yuecheng District', '');
INSERT INTO `feel_region` VALUES (833, '1', '33', '6', '21', '绍兴县', 'Shaoxing County', '');
INSERT INTO `feel_region` VALUES (834, '1', '33', '6', '24', '新昌县', 'Xinchang County', '');
INSERT INTO `feel_region` VALUES (835, '1', '33', '6', '81', '诸暨市', 'Zhuji', '');
INSERT INTO `feel_region` VALUES (836, '1', '33', '6', '82', '上虞市', 'Shangyu', '');
INSERT INTO `feel_region` VALUES (837, '1', '33', '6', '83', '嵊州市', 'Quzhou City', '');
INSERT INTO `feel_region` VALUES (838, '1', '33', '7', '2', '婺城区', 'Wucheng District', '');
INSERT INTO `feel_region` VALUES (839, '1', '33', '7', '3', '金东区', 'Jindong District', '');
INSERT INTO `feel_region` VALUES (840, '1', '33', '7', '23', '武义县', 'Wuyi County', '');
INSERT INTO `feel_region` VALUES (841, '1', '33', '7', '26', '浦江县', 'Pujiang County', '');
INSERT INTO `feel_region` VALUES (842, '1', '33', '7', '27', '磐安县', 'Chun\'an County', '');
INSERT INTO `feel_region` VALUES (843, '1', '33', '7', '81', '兰溪市', 'Lanxi City', '');
INSERT INTO `feel_region` VALUES (844, '1', '33', '7', '82', '义乌市', 'Yiwu City', '');
INSERT INTO `feel_region` VALUES (845, '1', '33', '7', '83', '东阳市', 'Dongyang City', '');
INSERT INTO `feel_region` VALUES (846, '1', '33', '7', '84', '永康市', 'Yongkang City', '');
INSERT INTO `feel_region` VALUES (847, '1', '33', '8', '2', '柯城区', 'Kecheng District', '');
INSERT INTO `feel_region` VALUES (848, '1', '33', '8', '3', '衢江区', 'Hanjiang District', '');
INSERT INTO `feel_region` VALUES (849, '1', '33', '8', '22', '常山县', 'Changshan County', '');
INSERT INTO `feel_region` VALUES (850, '1', '33', '8', '24', '开化县', 'Kaihua County', '');
INSERT INTO `feel_region` VALUES (851, '1', '33', '8', '25', '龙游县', 'Longyou County', '');
INSERT INTO `feel_region` VALUES (852, '1', '33', '8', '81', '江山市', 'Jiangshan City', '');
INSERT INTO `feel_region` VALUES (853, '1', '33', '9', '2', '定海区', 'Dinghai District', '');
INSERT INTO `feel_region` VALUES (854, '1', '33', '9', '3', '普陀区', 'Putuo District', '');
INSERT INTO `feel_region` VALUES (855, '1', '33', '9', '21', '岱山县', 'Daishan County', '');
INSERT INTO `feel_region` VALUES (856, '1', '33', '9', '22', '嵊泗县', 'Ji County', '');
INSERT INTO `feel_region` VALUES (857, '1', '33', '10', '2', '椒江区', 'Jiaojiang District', '');
INSERT INTO `feel_region` VALUES (858, '1', '33', '10', '3', '黄岩区', 'Huangyan District', '');
INSERT INTO `feel_region` VALUES (859, '1', '33', '10', '4', '路桥区', 'Luqiao District', '');
INSERT INTO `feel_region` VALUES (860, '1', '33', '10', '21', '玉环县', 'Yuhuan County', '');
INSERT INTO `feel_region` VALUES (861, '1', '33', '10', '22', '三门县', 'Sanmen County', '');
INSERT INTO `feel_region` VALUES (862, '1', '33', '10', '23', '天台县', 'Tiantai County', '');
INSERT INTO `feel_region` VALUES (863, '1', '33', '10', '24', '仙居县', 'Xianju County', '');
INSERT INTO `feel_region` VALUES (864, '1', '33', '10', '81', '温岭市', 'Wenling City', '');
INSERT INTO `feel_region` VALUES (865, '1', '33', '10', '82', '临海市', 'Linhai City', '');
INSERT INTO `feel_region` VALUES (866, '1', '33', '11', '2', '莲都区', 'Liandu District', '');
INSERT INTO `feel_region` VALUES (867, '1', '33', '11', '21', '青田县', 'Qingtian County', '');
INSERT INTO `feel_region` VALUES (868, '1', '33', '11', '22', '缙云县', 'Jinyun County', '');
INSERT INTO `feel_region` VALUES (869, '1', '33', '11', '23', '遂昌县', 'Suichang County', '');
INSERT INTO `feel_region` VALUES (870, '1', '33', '11', '24', '松阳县', 'Songyang County', '');
INSERT INTO `feel_region` VALUES (871, '1', '33', '11', '25', '云和县', 'Yunhe County', '');
INSERT INTO `feel_region` VALUES (872, '1', '33', '11', '26', '庆元县', 'Qingyuan County', '');
INSERT INTO `feel_region` VALUES (873, '1', '33', '11', '27', '景宁畲族自治县', 'Jingning Yi Autonomous County', '');
INSERT INTO `feel_region` VALUES (874, '1', '33', '11', '81', '龙泉市', 'Longquan City', '');
INSERT INTO `feel_region` VALUES (875, '1', '34', '1', '2', '瑶海区', 'Yaohai District', '');
INSERT INTO `feel_region` VALUES (876, '1', '34', '1', '3', '庐阳区', 'Yuyang District', '');
INSERT INTO `feel_region` VALUES (877, '1', '34', '1', '4', '蜀山区', 'Laoshan District', '');
INSERT INTO `feel_region` VALUES (878, '1', '34', '1', '11', '包河区', 'Baohe District', '');
INSERT INTO `feel_region` VALUES (879, '1', '34', '1', '21', '长丰县', 'Changfeng County', '');
INSERT INTO `feel_region` VALUES (880, '1', '34', '1', '22', '肥东县', 'Feidong County', '');
INSERT INTO `feel_region` VALUES (881, '1', '34', '1', '23', '肥西县', 'Feixi County', '');
INSERT INTO `feel_region` VALUES (882, '1', '34', '1', '24', '庐江县', 'Qijiang County', '');
INSERT INTO `feel_region` VALUES (883, '1', '34', '1', '25', '巢湖市', 'Chaohu City', '');
INSERT INTO `feel_region` VALUES (884, '1', '34', '2', '2', '镜湖区', 'Jinghu District', '');
INSERT INTO `feel_region` VALUES (885, '1', '34', '2', '3', '弋江区', 'Hanjiang District', '');
INSERT INTO `feel_region` VALUES (886, '1', '34', '2', '7', '鸠江区', 'Hanjiang District', '');
INSERT INTO `feel_region` VALUES (887, '1', '34', '2', '8', '三山区', 'Sanshan District', '');
INSERT INTO `feel_region` VALUES (888, '1', '34', '2', '21', '芜湖县', 'Wuhu County', '');
INSERT INTO `feel_region` VALUES (889, '1', '34', '2', '22', '繁昌县', 'Fanchang County', '');
INSERT INTO `feel_region` VALUES (890, '1', '34', '2', '23', '南陵县', 'Nanling County', '');
INSERT INTO `feel_region` VALUES (891, '1', '34', '2', '24', '无为县', 'Wuwei County', '');
INSERT INTO `feel_region` VALUES (892, '1', '34', '3', '2', '龙子湖区', 'Longzihu District', '');
INSERT INTO `feel_region` VALUES (893, '1', '34', '3', '3', '蚌山区', 'Laoshan District', '');
INSERT INTO `feel_region` VALUES (894, '1', '34', '3', '4', '禹会区', 'Yuhui District', '');
INSERT INTO `feel_region` VALUES (895, '1', '34', '3', '11', '淮上区', 'Huai Shang District', '');
INSERT INTO `feel_region` VALUES (896, '1', '34', '3', '21', '怀远县', 'Huaiyuan County', '');
INSERT INTO `feel_region` VALUES (897, '1', '34', '3', '22', '五河县', 'Wuhe County', '');
INSERT INTO `feel_region` VALUES (898, '1', '34', '3', '23', '固镇县', 'Guzhen County', '');
INSERT INTO `feel_region` VALUES (899, '1', '34', '4', '2', '大通区', 'Datong District', '');
INSERT INTO `feel_region` VALUES (900, '1', '34', '4', '3', '田家庵区', 'Tianjiatun District', '');
INSERT INTO `feel_region` VALUES (901, '1', '34', '4', '4', '谢家集区', 'Xiejia District', '');
INSERT INTO `feel_region` VALUES (902, '1', '34', '4', '5', '八公山区', 'Bagong Mountain Area', '');
INSERT INTO `feel_region` VALUES (903, '1', '34', '4', '6', '潘集区', 'Panji District', '');
INSERT INTO `feel_region` VALUES (904, '1', '34', '4', '21', '凤台县', 'Fengtai County', '');
INSERT INTO `feel_region` VALUES (905, '1', '34', '5', '3', '花山区', 'Huashan District', '');
INSERT INTO `feel_region` VALUES (906, '1', '34', '5', '4', '雨山区', 'Rainy mountain', '');
INSERT INTO `feel_region` VALUES (907, '1', '34', '5', '5', '博望区', 'Bowang District', '');
INSERT INTO `feel_region` VALUES (908, '1', '34', '5', '21', '当涂县', 'Dangtu County', '');
INSERT INTO `feel_region` VALUES (909, '1', '34', '5', '22', '含山县', 'Hanshan County', '');
INSERT INTO `feel_region` VALUES (910, '1', '34', '5', '23', '和县', 'And county', '');
INSERT INTO `feel_region` VALUES (911, '1', '34', '6', '2', '杜集区', 'Duji District', '');
INSERT INTO `feel_region` VALUES (912, '1', '34', '6', '3', '相山区', 'Xiangshan', '');
INSERT INTO `feel_region` VALUES (913, '1', '34', '6', '4', '烈山区', 'Lieshan District', '');
INSERT INTO `feel_region` VALUES (914, '1', '34', '6', '21', '濉溪县', 'Tunxi County', '');
INSERT INTO `feel_region` VALUES (915, '1', '34', '7', '2', '铜官山区', 'Tongguan Mountain Area', '');
INSERT INTO `feel_region` VALUES (916, '1', '34', '7', '3', '狮子山区', 'Lion Mountain', '');
INSERT INTO `feel_region` VALUES (917, '1', '34', '7', '11', '郊　区', 'Suburb', '');
INSERT INTO `feel_region` VALUES (918, '1', '34', '7', '21', '铜陵县', 'Tongling County', '');
INSERT INTO `feel_region` VALUES (919, '1', '34', '8', '2', '迎江区', 'Yingjiang District', '');
INSERT INTO `feel_region` VALUES (920, '1', '34', '8', '3', '大观区', 'Grand View District', '');
INSERT INTO `feel_region` VALUES (921, '1', '34', '8', '11', '宜秀区', 'Yixiu District', '');
INSERT INTO `feel_region` VALUES (922, '1', '34', '8', '22', '怀宁县', 'Huaining County', '');
INSERT INTO `feel_region` VALUES (923, '1', '34', '8', '23', '枞阳县', 'Shuyang County', '');
INSERT INTO `feel_region` VALUES (924, '1', '34', '8', '24', '潜山县', 'Qianshan County', '');
INSERT INTO `feel_region` VALUES (925, '1', '34', '8', '25', '太湖县', 'Taihu County', '');
INSERT INTO `feel_region` VALUES (926, '1', '34', '8', '26', '宿松县', 'Susong County', '');
INSERT INTO `feel_region` VALUES (927, '1', '34', '8', '27', '望江县', 'Wangjiang County', '');
INSERT INTO `feel_region` VALUES (928, '1', '34', '8', '28', '岳西县', 'Yuexi County', '');
INSERT INTO `feel_region` VALUES (929, '1', '34', '8', '81', '桐城市', 'Tongcheng', '');
INSERT INTO `feel_region` VALUES (930, '1', '34', '10', '2', '屯溪区', 'Tunxi District', '');
INSERT INTO `feel_region` VALUES (931, '1', '34', '10', '3', '黄山区', 'Huangshan District', '');
INSERT INTO `feel_region` VALUES (932, '1', '34', '10', '4', '徽州区', 'Huizhou District', '');
INSERT INTO `feel_region` VALUES (933, '1', '34', '10', '21', '歙　县', '县 County', '');
INSERT INTO `feel_region` VALUES (934, '1', '34', '10', '22', '休宁县', 'Xiuning County', '');
INSERT INTO `feel_region` VALUES (935, '1', '34', '10', '23', '黟　县', '县 County', '');
INSERT INTO `feel_region` VALUES (936, '1', '34', '10', '24', '祁门县', 'Qimen County', '');
INSERT INTO `feel_region` VALUES (937, '1', '34', '11', '2', '琅琊区', 'Reclamation area', '');
INSERT INTO `feel_region` VALUES (938, '1', '34', '11', '3', '南谯区', 'Nanxun District', '');
INSERT INTO `feel_region` VALUES (939, '1', '34', '11', '22', '来安县', 'Lai\'an County', '');
INSERT INTO `feel_region` VALUES (940, '1', '34', '11', '24', '全椒县', 'Quanjiao County', '');
INSERT INTO `feel_region` VALUES (941, '1', '34', '11', '25', '定远县', 'Dingyuan County', '');
INSERT INTO `feel_region` VALUES (942, '1', '34', '11', '26', '凤阳县', 'Fengyang County', '');
INSERT INTO `feel_region` VALUES (943, '1', '34', '11', '81', '天长市', 'Tianchang City', '');
INSERT INTO `feel_region` VALUES (944, '1', '34', '11', '82', '明光市', 'Mingguang City', '');
INSERT INTO `feel_region` VALUES (945, '1', '34', '12', '2', '颍州区', 'Yinzhou District', '');
INSERT INTO `feel_region` VALUES (946, '1', '34', '12', '3', '颍东区', 'Yudong District', '');
INSERT INTO `feel_region` VALUES (947, '1', '34', '12', '4', '颍泉区', 'Yuquan District', '');
INSERT INTO `feel_region` VALUES (948, '1', '34', '12', '21', '临泉县', 'Linquan County', '');
INSERT INTO `feel_region` VALUES (949, '1', '34', '12', '22', '太和县', 'Taihe County', '');
INSERT INTO `feel_region` VALUES (950, '1', '34', '12', '25', '阜南县', 'Yinan County', '');
INSERT INTO `feel_region` VALUES (951, '1', '34', '12', '26', '颍上县', 'Yingshang County', '');
INSERT INTO `feel_region` VALUES (952, '1', '34', '12', '82', '界首市', 'Jieshou City', '');
INSERT INTO `feel_region` VALUES (953, '1', '34', '13', '2', '埇桥区', 'Yongqiao District', '');
INSERT INTO `feel_region` VALUES (954, '1', '34', '13', '21', '砀山县', 'Daishan County', '');
INSERT INTO `feel_region` VALUES (955, '1', '34', '13', '22', '萧　县', 'Xiao County', '');
INSERT INTO `feel_region` VALUES (956, '1', '34', '13', '23', '灵璧县', 'Lingbi County', '');
INSERT INTO `feel_region` VALUES (957, '1', '34', '13', '24', '泗　县', '县 County', '');
INSERT INTO `feel_region` VALUES (958, '1', '34', '15', '2', '金安区', 'Jin\'an District', '');
INSERT INTO `feel_region` VALUES (959, '1', '34', '15', '3', '裕安区', 'Yu\'an District', '');
INSERT INTO `feel_region` VALUES (960, '1', '34', '15', '21', '寿　县', 'Shou County', '');
INSERT INTO `feel_region` VALUES (961, '1', '34', '15', '22', '霍邱县', 'Huoqiu County', '');
INSERT INTO `feel_region` VALUES (962, '1', '34', '15', '23', '舒城县', 'Shucheng County', '');
INSERT INTO `feel_region` VALUES (963, '1', '34', '15', '24', '金寨县', 'Jinzhai County', '');
INSERT INTO `feel_region` VALUES (964, '1', '34', '15', '25', '霍山县', 'Huoshan County', '');
INSERT INTO `feel_region` VALUES (965, '1', '34', '16', '2', '谯城区', 'Wucheng District', '');
INSERT INTO `feel_region` VALUES (966, '1', '34', '16', '21', '涡阳县', 'Guoyang County', '');
INSERT INTO `feel_region` VALUES (967, '1', '34', '16', '22', '蒙城县', 'Mengcheng County', '');
INSERT INTO `feel_region` VALUES (968, '1', '34', '16', '23', '利辛县', 'Lixin County', '');
INSERT INTO `feel_region` VALUES (969, '1', '34', '17', '2', '贵池区', 'Guichi District', '');
INSERT INTO `feel_region` VALUES (970, '1', '34', '17', '21', '东至县', 'Dongzhi County', '');
INSERT INTO `feel_region` VALUES (971, '1', '34', '17', '22', '石台县', 'Shitai County', '');
INSERT INTO `feel_region` VALUES (972, '1', '34', '17', '23', '青阳县', 'Qingyang County', '');
INSERT INTO `feel_region` VALUES (973, '1', '34', '18', '2', '宣州区', 'Xuanzhou District', '');
INSERT INTO `feel_region` VALUES (974, '1', '34', '18', '21', '郎溪县', 'Langxi County', '');
INSERT INTO `feel_region` VALUES (975, '1', '34', '18', '22', '广德县', 'Guangde County', '');
INSERT INTO `feel_region` VALUES (976, '1', '34', '18', '23', '泾　县', '县 County', '');
INSERT INTO `feel_region` VALUES (977, '1', '34', '18', '24', '绩溪县', 'Jixi County', '');
INSERT INTO `feel_region` VALUES (978, '1', '34', '18', '25', '旌德县', 'Jude County', '');
INSERT INTO `feel_region` VALUES (979, '1', '34', '18', '81', '宁国市', 'Ningguo City', '');
INSERT INTO `feel_region` VALUES (980, '1', '35', '1', '2', '鼓楼区', 'Gulou District', '');
INSERT INTO `feel_region` VALUES (981, '1', '35', '1', '3', '台江区', 'Taijiang District', '');
INSERT INTO `feel_region` VALUES (982, '1', '35', '1', '4', '仓山区', 'Cangshan District', '');
INSERT INTO `feel_region` VALUES (983, '1', '35', '1', '5', '马尾区', 'Mawei District', '');
INSERT INTO `feel_region` VALUES (984, '1', '35', '1', '11', '晋安区', 'Jin\'an District', '');
INSERT INTO `feel_region` VALUES (985, '1', '35', '1', '21', '闽侯县', 'Minhou County', '');
INSERT INTO `feel_region` VALUES (986, '1', '35', '1', '22', '连江县', 'Lianjiang County', '');
INSERT INTO `feel_region` VALUES (987, '1', '35', '1', '23', '罗源县', 'Luoyuan County', '');
INSERT INTO `feel_region` VALUES (988, '1', '35', '1', '24', '闽清县', 'Minqing County', '');
INSERT INTO `feel_region` VALUES (989, '1', '35', '1', '25', '永泰县', 'Yongtai County', '');
INSERT INTO `feel_region` VALUES (990, '1', '35', '1', '28', '平潭县', 'Pingtan County', '');
INSERT INTO `feel_region` VALUES (991, '1', '35', '1', '81', '福清市', 'Fuqing City', '');
INSERT INTO `feel_region` VALUES (992, '1', '35', '1', '82', '长乐市', 'Changle City', '');
INSERT INTO `feel_region` VALUES (993, '1', '35', '2', '3', '思明区', 'Siming District', '');
INSERT INTO `feel_region` VALUES (994, '1', '35', '2', '5', '海沧区', 'Haishu District', '');
INSERT INTO `feel_region` VALUES (995, '1', '35', '2', '6', '湖里区', 'Huli District', '');
INSERT INTO `feel_region` VALUES (996, '1', '35', '2', '11', '集美区', 'Jimei District', '');
INSERT INTO `feel_region` VALUES (997, '1', '35', '2', '12', '同安区', 'Tong\'an District', '');
INSERT INTO `feel_region` VALUES (998, '1', '35', '2', '13', '翔安区', 'Xiang\'an District', '');
INSERT INTO `feel_region` VALUES (999, '1', '35', '3', '2', '城厢区', 'Chengxiang District', '');
INSERT INTO `feel_region` VALUES (1000, '1', '35', '3', '3', '涵江区', 'Hanjiang District', '');
INSERT INTO `feel_region` VALUES (1001, '1', '35', '3', '4', '荔城区', 'Wucheng District', '');
INSERT INTO `feel_region` VALUES (1002, '1', '35', '3', '5', '秀屿区', 'Xiuyu District', '');
INSERT INTO `feel_region` VALUES (1003, '1', '35', '3', '22', '仙游县', 'Xianyou County', '');
INSERT INTO `feel_region` VALUES (1004, '1', '35', '4', '2', '梅列区', 'Merle', '');
INSERT INTO `feel_region` VALUES (1005, '1', '35', '4', '3', '三元区', 'Sanyuan District', '');
INSERT INTO `feel_region` VALUES (1006, '1', '35', '4', '21', '明溪县', 'Mingxi County', '');
INSERT INTO `feel_region` VALUES (1007, '1', '35', '4', '23', '清流县', 'Qingliu County', '');
INSERT INTO `feel_region` VALUES (1008, '1', '35', '4', '24', '宁化县', 'Ninghua County', '');
INSERT INTO `feel_region` VALUES (1009, '1', '35', '4', '25', '大田县', 'Datian County', '');
INSERT INTO `feel_region` VALUES (1010, '1', '35', '4', '26', '尤溪县', 'Youxi County', '');
INSERT INTO `feel_region` VALUES (1011, '1', '35', '4', '27', '沙　县', 'Sha County', '');
INSERT INTO `feel_region` VALUES (1012, '1', '35', '4', '28', '将乐县', 'Le County', '');
INSERT INTO `feel_region` VALUES (1013, '1', '35', '4', '29', '泰宁县', 'Taining County', '');
INSERT INTO `feel_region` VALUES (1014, '1', '35', '4', '30', '建宁县', 'Jianning County', '');
INSERT INTO `feel_region` VALUES (1015, '1', '35', '4', '81', '永安市', 'Yong\'an City', '');
INSERT INTO `feel_region` VALUES (1016, '1', '35', '5', '2', '鲤城区', 'Wucheng District', '');
INSERT INTO `feel_region` VALUES (1017, '1', '35', '5', '3', '丰泽区', 'Fengze District', '');
INSERT INTO `feel_region` VALUES (1018, '1', '35', '5', '4', '洛江区', 'Luojiang District', '');
INSERT INTO `feel_region` VALUES (1019, '1', '35', '5', '5', '泉港区', 'Quangang District', '');
INSERT INTO `feel_region` VALUES (1020, '1', '35', '5', '21', '惠安县', 'Hui\'an County', '');
INSERT INTO `feel_region` VALUES (1021, '1', '35', '5', '24', '安溪县', 'Anxi County', '');
INSERT INTO `feel_region` VALUES (1022, '1', '35', '5', '25', '永春县', 'Yongchun County', '');
INSERT INTO `feel_region` VALUES (1023, '1', '35', '5', '26', '德化县', 'Dehua County', '');
INSERT INTO `feel_region` VALUES (1024, '1', '35', '5', '27', '金门县', 'Jinmen County', '');
INSERT INTO `feel_region` VALUES (1025, '1', '35', '5', '81', '石狮市', 'Shishi', '');
INSERT INTO `feel_region` VALUES (1026, '1', '35', '5', '82', '晋江市', 'Jinjiang City', '');
INSERT INTO `feel_region` VALUES (1027, '1', '35', '5', '83', '南安市', 'Nan\'an City', '');
INSERT INTO `feel_region` VALUES (1028, '1', '35', '6', '2', '芗城区', 'Wucheng District', '');
INSERT INTO `feel_region` VALUES (1029, '1', '35', '6', '3', '龙文区', 'Longwen District', '');
INSERT INTO `feel_region` VALUES (1030, '1', '35', '6', '22', '云霄县', 'Yunxiao County', '');
INSERT INTO `feel_region` VALUES (1031, '1', '35', '6', '23', '漳浦县', 'Zhangpu County', '');
INSERT INTO `feel_region` VALUES (1032, '1', '35', '6', '24', '诏安县', 'Chun\'an County', '');
INSERT INTO `feel_region` VALUES (1033, '1', '35', '6', '25', '长泰县', 'Changtai County', '');
INSERT INTO `feel_region` VALUES (1034, '1', '35', '6', '26', '东山县', 'Dongshan County', '');
INSERT INTO `feel_region` VALUES (1035, '1', '35', '6', '27', '南靖县', 'Nanjing County', '');
INSERT INTO `feel_region` VALUES (1036, '1', '35', '6', '28', '平和县', 'Pinghe County', '');
INSERT INTO `feel_region` VALUES (1037, '1', '35', '6', '29', '华安县', 'Hua\'an County', '');
INSERT INTO `feel_region` VALUES (1038, '1', '35', '6', '81', '龙海市', 'Longhai City', '');
INSERT INTO `feel_region` VALUES (1039, '1', '35', '7', '2', '延平区', 'Yanping District', '');
INSERT INTO `feel_region` VALUES (1040, '1', '35', '7', '21', '顺昌县', 'Shunchang County', '');
INSERT INTO `feel_region` VALUES (1041, '1', '35', '7', '22', '浦城县', 'Pucheng County', '');
INSERT INTO `feel_region` VALUES (1042, '1', '35', '7', '23', '光泽县', 'Gloss County', '');
INSERT INTO `feel_region` VALUES (1043, '1', '35', '7', '24', '松溪县', 'Songxi County', '');
INSERT INTO `feel_region` VALUES (1044, '1', '35', '7', '25', '政和县', 'Zhenghe County', '');
INSERT INTO `feel_region` VALUES (1045, '1', '35', '7', '81', '邵武市', 'Shaowu City', '');
INSERT INTO `feel_region` VALUES (1046, '1', '35', '7', '82', '武夷山市', 'Wuyishan City', '');
INSERT INTO `feel_region` VALUES (1047, '1', '35', '7', '83', '建瓯市', 'Jianye City', '');
INSERT INTO `feel_region` VALUES (1048, '1', '35', '7', '84', '建阳市', 'Jianyang City', '');
INSERT INTO `feel_region` VALUES (1049, '1', '35', '8', '2', '新罗区', 'Xinluo District', '');
INSERT INTO `feel_region` VALUES (1050, '1', '35', '8', '21', '长汀县', 'Changting County', '');
INSERT INTO `feel_region` VALUES (1051, '1', '35', '8', '22', '永定县', 'Yongding County', '');
INSERT INTO `feel_region` VALUES (1052, '1', '35', '8', '23', '上杭县', 'Shanghang County', '');
INSERT INTO `feel_region` VALUES (1053, '1', '35', '8', '24', '武平县', 'Wuping County', '');
INSERT INTO `feel_region` VALUES (1054, '1', '35', '8', '25', '连城县', 'Liancheng County', '');
INSERT INTO `feel_region` VALUES (1055, '1', '35', '8', '81', '漳平市', 'Zhangping City', '');
INSERT INTO `feel_region` VALUES (1056, '1', '35', '9', '2', '蕉城区', 'Jiaocheng District', '');
INSERT INTO `feel_region` VALUES (1057, '1', '35', '9', '21', '霞浦县', 'Xiapu County', '');
INSERT INTO `feel_region` VALUES (1058, '1', '35', '9', '22', '古田县', 'Gutian County', '');
INSERT INTO `feel_region` VALUES (1059, '1', '35', '9', '23', '屏南县', 'Pingnan County', '');
INSERT INTO `feel_region` VALUES (1060, '1', '35', '9', '24', '寿宁县', 'Shouning County', '');
INSERT INTO `feel_region` VALUES (1061, '1', '35', '9', '25', '周宁县', 'Zhouning County', '');
INSERT INTO `feel_region` VALUES (1062, '1', '35', '9', '26', '柘荣县', 'Zherong County', '');
INSERT INTO `feel_region` VALUES (1063, '1', '35', '9', '81', '福安市', 'Fu\'an City', '');
INSERT INTO `feel_region` VALUES (1064, '1', '35', '9', '82', '福鼎市', 'Fuding City', '');
INSERT INTO `feel_region` VALUES (1065, '1', '36', '1', '2', '东湖区', 'Donghu District', '');
INSERT INTO `feel_region` VALUES (1066, '1', '36', '1', '3', '西湖区', 'West Lake District', '');
INSERT INTO `feel_region` VALUES (1067, '1', '36', '1', '4', '青云谱区', 'Qingyun District', '');
INSERT INTO `feel_region` VALUES (1068, '1', '36', '1', '5', '湾里区', 'Wanli District', '');
INSERT INTO `feel_region` VALUES (1069, '1', '36', '1', '11', '青山湖区', 'Qingshan Lake District', '');
INSERT INTO `feel_region` VALUES (1070, '1', '36', '1', '21', '南昌县', 'Nanchang County', '');
INSERT INTO `feel_region` VALUES (1071, '1', '36', '1', '22', '新建县', 'New county', '');
INSERT INTO `feel_region` VALUES (1072, '1', '36', '1', '23', '安义县', 'Anyi County', '');
INSERT INTO `feel_region` VALUES (1073, '1', '36', '1', '24', '进贤县', 'Jinxian County', '');
INSERT INTO `feel_region` VALUES (1074, '1', '36', '2', '2', '昌江区', 'Changjiang District', '');
INSERT INTO `feel_region` VALUES (1075, '1', '36', '2', '3', '珠山区', 'Zhushan District', '');
INSERT INTO `feel_region` VALUES (1076, '1', '36', '2', '22', '浮梁县', 'Fuliang County', '');
INSERT INTO `feel_region` VALUES (1077, '1', '36', '2', '81', '乐平市', 'Leping City', '');
INSERT INTO `feel_region` VALUES (1078, '1', '36', '3', '2', '安源区', 'Anyuan District', '');
INSERT INTO `feel_region` VALUES (1079, '1', '36', '3', '13', '湘东区', 'Xiangdong District', '');
INSERT INTO `feel_region` VALUES (1080, '1', '36', '3', '21', '莲花县', 'Lianhua County', '');
INSERT INTO `feel_region` VALUES (1081, '1', '36', '3', '22', '上栗县', 'Shangli County', '');
INSERT INTO `feel_region` VALUES (1082, '1', '36', '3', '23', '芦溪县', 'Luxi County', '');
INSERT INTO `feel_region` VALUES (1083, '1', '36', '4', '2', '庐山区', 'Laoshan District', '');
INSERT INTO `feel_region` VALUES (1084, '1', '36', '4', '3', '浔阳区', 'Yuyang District', '');
INSERT INTO `feel_region` VALUES (1085, '1', '36', '4', '21', '九江县', 'Jiujiang County', '');
INSERT INTO `feel_region` VALUES (1086, '1', '36', '4', '23', '武宁县', 'Wuning County', '');
INSERT INTO `feel_region` VALUES (1087, '1', '36', '4', '24', '修水县', 'Xiushui County', '');
INSERT INTO `feel_region` VALUES (1088, '1', '36', '4', '25', '永修县', 'Yongxiu County', '');
INSERT INTO `feel_region` VALUES (1089, '1', '36', '4', '26', '德安县', 'Dean County', '');
INSERT INTO `feel_region` VALUES (1090, '1', '36', '4', '27', '星子县', 'Xingzi County', '');
INSERT INTO `feel_region` VALUES (1091, '1', '36', '4', '28', '都昌县', 'Duchang County', '');
INSERT INTO `feel_region` VALUES (1092, '1', '36', '4', '29', '湖口县', 'Hukou County', '');
INSERT INTO `feel_region` VALUES (1093, '1', '36', '4', '30', '彭泽县', 'Pengze County', '');
INSERT INTO `feel_region` VALUES (1094, '1', '36', '4', '81', '瑞昌市', 'Ruichang City', '');
INSERT INTO `feel_region` VALUES (1095, '1', '36', '5', '2', '渝水区', 'Surabaya', '');
INSERT INTO `feel_region` VALUES (1096, '1', '36', '5', '21', '分宜县', 'Fenyi County', '');
INSERT INTO `feel_region` VALUES (1097, '1', '36', '6', '2', '月湖区', 'Yuehu District', '');
INSERT INTO `feel_region` VALUES (1098, '1', '36', '6', '22', '余江县', 'Yujiang County', '');
INSERT INTO `feel_region` VALUES (1099, '1', '36', '6', '81', '贵溪市', 'Guixi City', '');
INSERT INTO `feel_region` VALUES (1100, '1', '36', '7', '2', '章贡区', 'Zhanggong District', '');
INSERT INTO `feel_region` VALUES (1101, '1', '36', '7', '21', '赣　县', 'Gan County', '');
INSERT INTO `feel_region` VALUES (1102, '1', '36', '7', '22', '信丰县', 'Xinfeng County', '');
INSERT INTO `feel_region` VALUES (1103, '1', '36', '7', '23', '大余县', 'Dayu County', '');
INSERT INTO `feel_region` VALUES (1104, '1', '36', '7', '24', '上犹县', 'Shangyou County', '');
INSERT INTO `feel_region` VALUES (1105, '1', '36', '7', '25', '崇义县', 'Chongyi County', '');
INSERT INTO `feel_region` VALUES (1106, '1', '36', '7', '26', '安远县', 'Anyuan County', '');
INSERT INTO `feel_region` VALUES (1107, '1', '36', '7', '27', '龙南县', 'Longnan County', '');
INSERT INTO `feel_region` VALUES (1108, '1', '36', '7', '28', '定南县', 'Dingnan County', '');
INSERT INTO `feel_region` VALUES (1109, '1', '36', '7', '29', '全南县', 'Quannan County', '');
INSERT INTO `feel_region` VALUES (1110, '1', '36', '7', '30', '宁都县', 'Ningdu County', '');
INSERT INTO `feel_region` VALUES (1111, '1', '36', '7', '31', '于都县', 'Yudu County', '');
INSERT INTO `feel_region` VALUES (1112, '1', '36', '7', '32', '兴国县', 'Xingguo County', '');
INSERT INTO `feel_region` VALUES (1113, '1', '36', '7', '33', '会昌县', 'Huichang County', '');
INSERT INTO `feel_region` VALUES (1114, '1', '36', '7', '34', '寻乌县', 'Xunwu County', '');
INSERT INTO `feel_region` VALUES (1115, '1', '36', '7', '35', '石城县', 'Shicheng County', '');
INSERT INTO `feel_region` VALUES (1116, '1', '36', '7', '81', '瑞金市', 'Ruijin City', '');
INSERT INTO `feel_region` VALUES (1117, '1', '36', '7', '82', '南康市', 'Nankang City', '');
INSERT INTO `feel_region` VALUES (1118, '1', '36', '8', '2', '吉州区', 'Jizhou District', '');
INSERT INTO `feel_region` VALUES (1119, '1', '36', '8', '3', '青原区', 'Qingyuan District', '');
INSERT INTO `feel_region` VALUES (1120, '1', '36', '8', '21', '吉安县', 'Ji\'an County', '');
INSERT INTO `feel_region` VALUES (1121, '1', '36', '8', '22', '吉水县', 'Jishui County', '');
INSERT INTO `feel_region` VALUES (1122, '1', '36', '8', '23', '峡江县', 'Xiajiang County', '');
INSERT INTO `feel_region` VALUES (1123, '1', '36', '8', '24', '新干县', 'Xingan County', '');
INSERT INTO `feel_region` VALUES (1124, '1', '36', '8', '25', '永丰县', 'Yongfeng County', '');
INSERT INTO `feel_region` VALUES (1125, '1', '36', '8', '26', '泰和县', 'Taihe County', '');
INSERT INTO `feel_region` VALUES (1126, '1', '36', '8', '27', '遂川县', 'Luanchuan County', '');
INSERT INTO `feel_region` VALUES (1127, '1', '36', '8', '28', '万安县', 'Wan\'an County', '');
INSERT INTO `feel_region` VALUES (1128, '1', '36', '8', '29', '安福县', 'Anfu County', '');
INSERT INTO `feel_region` VALUES (1129, '1', '36', '8', '30', '永新县', 'Yongxin County', '');
INSERT INTO `feel_region` VALUES (1130, '1', '36', '8', '81', '井冈山市', 'Jinggangshan City', '');
INSERT INTO `feel_region` VALUES (1131, '1', '36', '9', '2', '袁州区', 'Yuanzhou District', '');
INSERT INTO `feel_region` VALUES (1132, '1', '36', '9', '21', '奉新县', 'Fengxin County', '');
INSERT INTO `feel_region` VALUES (1133, '1', '36', '9', '22', '万载县', 'Wan Zai County', '');
INSERT INTO `feel_region` VALUES (1134, '1', '36', '9', '23', '上高县', 'Shanggao County', '');
INSERT INTO `feel_region` VALUES (1135, '1', '36', '9', '24', '宜丰县', 'Yifeng County', '');
INSERT INTO `feel_region` VALUES (1136, '1', '36', '9', '25', '靖安县', 'Jing\'an County', '');
INSERT INTO `feel_region` VALUES (1137, '1', '36', '9', '26', '铜鼓县', 'Tonggu County', '');
INSERT INTO `feel_region` VALUES (1138, '1', '36', '9', '81', '丰城市', 'Fengcheng', '');
INSERT INTO `feel_region` VALUES (1139, '1', '36', '9', '82', '樟树市', 'Yushu City', '');
INSERT INTO `feel_region` VALUES (1140, '1', '36', '9', '83', '高安市', 'Gao\'an City', '');
INSERT INTO `feel_region` VALUES (1141, '1', '36', '10', '2', '临川区', 'Linchuan District', '');
INSERT INTO `feel_region` VALUES (1142, '1', '36', '10', '21', '南城县', 'Nancheng County', '');
INSERT INTO `feel_region` VALUES (1143, '1', '36', '10', '22', '黎川县', 'Lichuan County', '');
INSERT INTO `feel_region` VALUES (1144, '1', '36', '10', '23', '南丰县', 'Nanfeng County', '');
INSERT INTO `feel_region` VALUES (1145, '1', '36', '10', '24', '崇仁县', 'Chongren County', '');
INSERT INTO `feel_region` VALUES (1146, '1', '36', '10', '25', '乐安县', 'Le\'an County', '');
INSERT INTO `feel_region` VALUES (1147, '1', '36', '10', '26', '宜黄县', 'Yihuang County', '');
INSERT INTO `feel_region` VALUES (1148, '1', '36', '10', '27', '金溪县', 'Jinxi County', '');
INSERT INTO `feel_region` VALUES (1149, '1', '36', '10', '28', '资溪县', 'Zixi County', '');
INSERT INTO `feel_region` VALUES (1150, '1', '36', '10', '29', '东乡县', 'Dongxiang County', '');
INSERT INTO `feel_region` VALUES (1151, '1', '36', '10', '30', '广昌县', 'Guangchang County', '');
INSERT INTO `feel_region` VALUES (1152, '1', '36', '11', '2', '信州区', 'Shinshu', '');
INSERT INTO `feel_region` VALUES (1153, '1', '36', '11', '21', '上饶县', 'Shangrao County', '');
INSERT INTO `feel_region` VALUES (1154, '1', '36', '11', '22', '广丰县', 'Guangfeng County', '');
INSERT INTO `feel_region` VALUES (1155, '1', '36', '11', '23', '玉山县', 'Yushan County', '');
INSERT INTO `feel_region` VALUES (1156, '1', '36', '11', '24', '铅山县', 'Lead Mountain County', '');
INSERT INTO `feel_region` VALUES (1157, '1', '36', '11', '25', '横峰县', 'Hengfeng County', '');
INSERT INTO `feel_region` VALUES (1158, '1', '36', '11', '26', '弋阳县', 'Shuyang County', '');
INSERT INTO `feel_region` VALUES (1159, '1', '36', '11', '27', '余干县', 'Yugan County', '');
INSERT INTO `feel_region` VALUES (1160, '1', '36', '11', '28', '鄱阳县', 'Shuyang County', '');
INSERT INTO `feel_region` VALUES (1161, '1', '36', '11', '29', '万年县', 'Wannian County', '');
INSERT INTO `feel_region` VALUES (1162, '1', '36', '11', '30', '婺源县', 'Wuyuan County', '');
INSERT INTO `feel_region` VALUES (1163, '1', '36', '11', '81', '德兴市', 'Dexing City', '');
INSERT INTO `feel_region` VALUES (1164, '1', '37', '1', '2', '历下区', 'Lixia District', '');
INSERT INTO `feel_region` VALUES (1165, '1', '37', '1', '3', '市中区', 'Central District', '');
INSERT INTO `feel_region` VALUES (1166, '1', '37', '1', '4', '槐荫区', 'Huaiyin District', '');
INSERT INTO `feel_region` VALUES (1167, '1', '37', '1', '5', '天桥区', 'Tianqiao District', '');
INSERT INTO `feel_region` VALUES (1168, '1', '37', '1', '12', '历城区', 'Licheng District', '');
INSERT INTO `feel_region` VALUES (1169, '1', '37', '1', '13', '长清区', 'Changqing District', '');
INSERT INTO `feel_region` VALUES (1170, '1', '37', '1', '24', '平阴县', 'Pingyin County', '');
INSERT INTO `feel_region` VALUES (1171, '1', '37', '1', '25', '济阳县', 'Jiyang County', '');
INSERT INTO `feel_region` VALUES (1172, '1', '37', '1', '26', '商河县', 'Shanghe County', '');
INSERT INTO `feel_region` VALUES (1173, '1', '37', '1', '81', '章丘市', 'Zhangqiu City', '');
INSERT INTO `feel_region` VALUES (1174, '1', '37', '2', '2', '市南区', 'City Southern District', '');
INSERT INTO `feel_region` VALUES (1175, '1', '37', '2', '3', '市北区', 'City North District', '');
INSERT INTO `feel_region` VALUES (1176, '1', '37', '2', '5', '四方区', 'Sifang District', '');
INSERT INTO `feel_region` VALUES (1177, '1', '37', '2', '11', '黄岛区', 'Huangdao District', '');
INSERT INTO `feel_region` VALUES (1178, '1', '37', '2', '12', '崂山区', 'Laoshan District', '');
INSERT INTO `feel_region` VALUES (1179, '1', '37', '2', '13', '李沧区', 'Lisong District', '');
INSERT INTO `feel_region` VALUES (1180, '1', '37', '2', '14', '城阳区', 'Chengyang District', '');
INSERT INTO `feel_region` VALUES (1181, '1', '37', '2', '81', '胶州市', 'Jiaozhou City', '');
INSERT INTO `feel_region` VALUES (1182, '1', '37', '2', '82', '即墨市', 'Jimo City', '');
INSERT INTO `feel_region` VALUES (1183, '1', '37', '2', '83', '平度市', 'Pingdu City', '');
INSERT INTO `feel_region` VALUES (1184, '1', '37', '2', '84', '胶南市', 'Jiaonan City', '');
INSERT INTO `feel_region` VALUES (1185, '1', '37', '2', '85', '莱西市', 'Lacey', '');
INSERT INTO `feel_region` VALUES (1186, '1', '37', '3', '2', '淄川区', 'Xichuan District', '');
INSERT INTO `feel_region` VALUES (1187, '1', '37', '3', '3', '张店区', 'Zhangdian District', '');
INSERT INTO `feel_region` VALUES (1188, '1', '37', '3', '4', '博山区', 'Boshan District', '');
INSERT INTO `feel_region` VALUES (1189, '1', '37', '3', '5', '临淄区', 'Linyi District', '');
INSERT INTO `feel_region` VALUES (1190, '1', '37', '3', '6', '周村区', 'Zhoucun District', '');
INSERT INTO `feel_region` VALUES (1191, '1', '37', '3', '21', '桓台县', 'Huantai County', '');
INSERT INTO `feel_region` VALUES (1192, '1', '37', '3', '22', '高青县', 'Gaoqing County', '');
INSERT INTO `feel_region` VALUES (1193, '1', '37', '3', '23', '沂源县', 'Wuyuan County', '');
INSERT INTO `feel_region` VALUES (1194, '1', '37', '4', '2', '市中区', 'Central District', '');
INSERT INTO `feel_region` VALUES (1195, '1', '37', '4', '3', '薛城区', 'Xuecheng District', '');
INSERT INTO `feel_region` VALUES (1196, '1', '37', '4', '4', '峄城区', 'Wucheng District', '');
INSERT INTO `feel_region` VALUES (1197, '1', '37', '4', '5', '台儿庄区', 'Taierzhuang District', '');
INSERT INTO `feel_region` VALUES (1198, '1', '37', '4', '6', '山亭区', 'Shanting District', '');
INSERT INTO `feel_region` VALUES (1199, '1', '37', '4', '81', '滕州市', 'Tengzhou City', '');
INSERT INTO `feel_region` VALUES (1200, '1', '37', '5', '2', '东营区', 'Dongying District', '');
INSERT INTO `feel_region` VALUES (1201, '1', '37', '5', '3', '河口区', 'Hekou District', '');
INSERT INTO `feel_region` VALUES (1202, '1', '37', '5', '21', '垦利县', 'Kenli County', '');
INSERT INTO `feel_region` VALUES (1203, '1', '37', '5', '22', '利津县', 'Lijin County', '');
INSERT INTO `feel_region` VALUES (1204, '1', '37', '5', '23', '广饶县', 'Guangrao County', '');
INSERT INTO `feel_region` VALUES (1205, '1', '37', '6', '2', '芝罘区', 'Zhifu District', '');
INSERT INTO `feel_region` VALUES (1206, '1', '37', '6', '11', '福山区', 'Fushan District', '');
INSERT INTO `feel_region` VALUES (1207, '1', '37', '6', '12', '牟平区', 'Muping District', '');
INSERT INTO `feel_region` VALUES (1208, '1', '37', '6', '13', '莱山区', 'Laishan District', '');
INSERT INTO `feel_region` VALUES (1209, '1', '37', '6', '34', '长岛县', 'Long Island County', '');
INSERT INTO `feel_region` VALUES (1210, '1', '37', '6', '81', '龙口市', 'Longkou City', '');
INSERT INTO `feel_region` VALUES (1211, '1', '37', '6', '82', '莱阳市', 'Laiyang City', '');
INSERT INTO `feel_region` VALUES (1212, '1', '37', '6', '83', '莱州市', 'Laizhou City', '');
INSERT INTO `feel_region` VALUES (1213, '1', '37', '6', '84', '蓬莱市', 'Penglai City', '');
INSERT INTO `feel_region` VALUES (1214, '1', '37', '6', '85', '招远市', 'Zhaoyuan City', '');
INSERT INTO `feel_region` VALUES (1215, '1', '37', '6', '86', '栖霞市', 'Qixia City', '');
INSERT INTO `feel_region` VALUES (1216, '1', '37', '6', '87', '海阳市', 'Haiyang City', '');
INSERT INTO `feel_region` VALUES (1217, '1', '37', '7', '2', '潍城区', 'Wucheng District', '');
INSERT INTO `feel_region` VALUES (1218, '1', '37', '7', '3', '寒亭区', 'Hanting District', '');
INSERT INTO `feel_region` VALUES (1219, '1', '37', '7', '4', '坊子区', 'Fangzi District', '');
INSERT INTO `feel_region` VALUES (1220, '1', '37', '7', '5', '奎文区', 'Kuiwen District', '');
INSERT INTO `feel_region` VALUES (1221, '1', '37', '7', '24', '临朐县', 'Linyi County', '');
INSERT INTO `feel_region` VALUES (1222, '1', '37', '7', '25', '昌乐县', 'Changle County', '');
INSERT INTO `feel_region` VALUES (1223, '1', '37', '7', '81', '青州市', 'Qingzhou City', '');
INSERT INTO `feel_region` VALUES (1224, '1', '37', '7', '82', '诸城市', 'Zhucheng', '');
INSERT INTO `feel_region` VALUES (1225, '1', '37', '7', '83', '寿光市', 'Shouguang City', '');
INSERT INTO `feel_region` VALUES (1226, '1', '37', '7', '84', '安丘市', 'Anqiu City', '');
INSERT INTO `feel_region` VALUES (1227, '1', '37', '7', '85', '高密市', 'Gaomi City', '');
INSERT INTO `feel_region` VALUES (1228, '1', '37', '7', '86', '昌邑市', 'Changyi City', '');
INSERT INTO `feel_region` VALUES (1229, '1', '37', '8', '2', '市中区', 'Central District', '');
INSERT INTO `feel_region` VALUES (1230, '1', '37', '8', '11', '任城区', 'Rencheng District', '');
INSERT INTO `feel_region` VALUES (1231, '1', '37', '8', '26', '微山县', 'Weishan County', '');
INSERT INTO `feel_region` VALUES (1232, '1', '37', '8', '27', '鱼台县', 'Yutai County', '');
INSERT INTO `feel_region` VALUES (1233, '1', '37', '8', '28', '金乡县', 'Jinxiang County', '');
INSERT INTO `feel_region` VALUES (1234, '1', '37', '8', '29', '嘉祥县', 'Jiaxiang County', '');
INSERT INTO `feel_region` VALUES (1235, '1', '37', '8', '30', '汶上县', 'Wenshang County', '');
INSERT INTO `feel_region` VALUES (1236, '1', '37', '8', '31', '泗水县', 'Yishui County', '');
INSERT INTO `feel_region` VALUES (1237, '1', '37', '8', '32', '梁山县', 'Liangshan County', '');
INSERT INTO `feel_region` VALUES (1238, '1', '37', '8', '81', '曲阜市', 'Qufu City', '');
INSERT INTO `feel_region` VALUES (1239, '1', '37', '8', '82', '兖州市', 'Quzhou City', '');
INSERT INTO `feel_region` VALUES (1240, '1', '37', '8', '83', '邹城市', 'Zoucheng', '');
INSERT INTO `feel_region` VALUES (1241, '1', '37', '9', '2', '泰山区', 'Taishan District', '');
INSERT INTO `feel_region` VALUES (1242, '1', '37', '9', '11', '岱岳区', 'Daiyue District', '');
INSERT INTO `feel_region` VALUES (1243, '1', '37', '9', '21', '宁阳县', 'Ningyang County', '');
INSERT INTO `feel_region` VALUES (1244, '1', '37', '9', '23', '东平县', 'Dongping County', '');
INSERT INTO `feel_region` VALUES (1245, '1', '37', '9', '82', '新泰市', 'Xintai City', '');
INSERT INTO `feel_region` VALUES (1246, '1', '37', '9', '83', '肥城市', 'Fat city', '');
INSERT INTO `feel_region` VALUES (1247, '1', '37', '10', '2', '环翠区', 'Huancui District', '');
INSERT INTO `feel_region` VALUES (1248, '1', '37', '10', '81', '文登市', 'Wendeng City', '');
INSERT INTO `feel_region` VALUES (1249, '1', '37', '10', '82', '荣成市', 'Rongcheng City', '');
INSERT INTO `feel_region` VALUES (1250, '1', '37', '10', '83', '乳山市', 'Rushan City', '');
INSERT INTO `feel_region` VALUES (1251, '1', '37', '11', '2', '东港区', 'Donggang District', '');
INSERT INTO `feel_region` VALUES (1252, '1', '37', '11', '3', '岚山区', 'Laoshan District', '');
INSERT INTO `feel_region` VALUES (1253, '1', '37', '11', '21', '五莲县', 'Wulian County', '');
INSERT INTO `feel_region` VALUES (1254, '1', '37', '11', '22', '莒　县', '县 County', '');
INSERT INTO `feel_region` VALUES (1255, '1', '37', '12', '2', '莱城区', 'Laicheng District', '');
INSERT INTO `feel_region` VALUES (1256, '1', '37', '12', '3', '钢城区', 'Steel city', '');
INSERT INTO `feel_region` VALUES (1257, '1', '37', '13', '2', '兰山区', 'Lanshan District', '');
INSERT INTO `feel_region` VALUES (1258, '1', '37', '13', '11', '罗庄区', 'Luozhuang District', '');
INSERT INTO `feel_region` VALUES (1259, '1', '37', '13', '12', '河东区', 'Hedong District', '');
INSERT INTO `feel_region` VALUES (1260, '1', '37', '13', '21', '沂南县', 'Yinan County', '');
INSERT INTO `feel_region` VALUES (1261, '1', '37', '13', '22', '郯城县', 'Yucheng County', '');
INSERT INTO `feel_region` VALUES (1262, '1', '37', '13', '23', '沂水县', 'Yishui County', '');
INSERT INTO `feel_region` VALUES (1263, '1', '37', '13', '24', '苍山县', 'Cangshan County', '');
INSERT INTO `feel_region` VALUES (1264, '1', '37', '13', '25', '费　县', 'Fei County', '');
INSERT INTO `feel_region` VALUES (1265, '1', '37', '13', '26', '平邑县', 'Pingyi County', '');
INSERT INTO `feel_region` VALUES (1266, '1', '37', '13', '27', '莒南县', 'Yinan County', '');
INSERT INTO `feel_region` VALUES (1267, '1', '37', '13', '28', '蒙阴县', 'Mengyin County', '');
INSERT INTO `feel_region` VALUES (1268, '1', '37', '13', '29', '临沭县', 'Linyi County', '');
INSERT INTO `feel_region` VALUES (1269, '1', '37', '14', '2', '德城区', 'Decheng District', '');
INSERT INTO `feel_region` VALUES (1270, '1', '37', '14', '21', '陵　县', 'Ling County', '');
INSERT INTO `feel_region` VALUES (1271, '1', '37', '14', '22', '宁津县', 'Ningjin County', '');
INSERT INTO `feel_region` VALUES (1272, '1', '37', '14', '23', '庆云县', 'Qingyun County', '');
INSERT INTO `feel_region` VALUES (1273, '1', '37', '14', '24', '临邑县', 'Linyi County', '');
INSERT INTO `feel_region` VALUES (1274, '1', '37', '14', '25', '齐河县', 'Qihe County', '');
INSERT INTO `feel_region` VALUES (1275, '1', '37', '14', '26', '平原县', 'Plain County', '');
INSERT INTO `feel_region` VALUES (1276, '1', '37', '14', '27', '夏津县', 'Xiajin County', '');
INSERT INTO `feel_region` VALUES (1277, '1', '37', '14', '28', '武城县', 'Wucheng County', '');
INSERT INTO `feel_region` VALUES (1278, '1', '37', '14', '81', '乐陵市', 'Leling City', '');
INSERT INTO `feel_region` VALUES (1279, '1', '37', '14', '82', '禹城市', 'Yu city', '');
INSERT INTO `feel_region` VALUES (1280, '1', '37', '15', '2', '东昌府区', 'Dongchangfu District', '');
INSERT INTO `feel_region` VALUES (1281, '1', '37', '15', '21', '阳谷县', 'Yanggu County', '');
INSERT INTO `feel_region` VALUES (1282, '1', '37', '15', '22', '莘　县', 'Shen County', '');
INSERT INTO `feel_region` VALUES (1283, '1', '37', '15', '23', '茌平县', 'Luanping County', '');
INSERT INTO `feel_region` VALUES (1284, '1', '37', '15', '24', '东阿县', 'Dong\'a County', '');
INSERT INTO `feel_region` VALUES (1285, '1', '37', '15', '25', '冠　县', 'Guan County', '');
INSERT INTO `feel_region` VALUES (1286, '1', '37', '15', '26', '高唐县', 'Gaotang County', '');
INSERT INTO `feel_region` VALUES (1287, '1', '37', '15', '81', '临清市', 'Linqing City', '');
INSERT INTO `feel_region` VALUES (1288, '1', '37', '16', '2', '滨城区', 'Bincheng District', '');
INSERT INTO `feel_region` VALUES (1289, '1', '37', '16', '21', '惠民县', 'Huimin County', '');
INSERT INTO `feel_region` VALUES (1290, '1', '37', '16', '22', '阳信县', 'Yangxin County', '');
INSERT INTO `feel_region` VALUES (1291, '1', '37', '16', '23', '无棣县', 'Wudi County', '');
INSERT INTO `feel_region` VALUES (1292, '1', '37', '16', '24', '沾化县', 'Zhanhua County', '');
INSERT INTO `feel_region` VALUES (1293, '1', '37', '16', '25', '博兴县', 'Boxing County', '');
INSERT INTO `feel_region` VALUES (1294, '1', '37', '16', '26', '邹平县', 'Zouping County', '');
INSERT INTO `feel_region` VALUES (1295, '1', '37', '17', '2', '牡丹区', 'Peony area', '');
INSERT INTO `feel_region` VALUES (1296, '1', '37', '17', '21', '曹　县', 'Cao County', '');
INSERT INTO `feel_region` VALUES (1297, '1', '37', '17', '22', '单　县', 'Single county', '');
INSERT INTO `feel_region` VALUES (1298, '1', '37', '17', '23', '成武县', 'Chengwu County', '');
INSERT INTO `feel_region` VALUES (1299, '1', '37', '17', '24', '巨野县', 'Juye County', '');
INSERT INTO `feel_region` VALUES (1300, '1', '37', '17', '25', '郓城县', 'Yucheng County', '');
INSERT INTO `feel_region` VALUES (1301, '1', '37', '17', '26', '鄄城县', 'Yucheng County', '');
INSERT INTO `feel_region` VALUES (1302, '1', '37', '17', '27', '定陶县', 'Dingtao County', '');
INSERT INTO `feel_region` VALUES (1303, '1', '37', '17', '28', '东明县', 'Dongming County', '');
INSERT INTO `feel_region` VALUES (1304, '1', '41', '1', '2', '中原区', 'Zhongyuan District', '');
INSERT INTO `feel_region` VALUES (1305, '1', '41', '1', '3', '二七区', 'Erqi District', '');
INSERT INTO `feel_region` VALUES (1306, '1', '41', '1', '4', '管城回族区', 'Guancheng Hui Nationality District', '');
INSERT INTO `feel_region` VALUES (1307, '1', '41', '1', '5', '金水区', 'Jinshui District', '');
INSERT INTO `feel_region` VALUES (1308, '1', '41', '1', '6', '上街区', 'Upper street', '');
INSERT INTO `feel_region` VALUES (1309, '1', '41', '1', '8', '惠济区', 'Huiji District', '');
INSERT INTO `feel_region` VALUES (1310, '1', '41', '1', '22', '中牟县', 'Zhongmu County', '');
INSERT INTO `feel_region` VALUES (1311, '1', '41', '1', '81', '巩义市', 'Gongyi City', '');
INSERT INTO `feel_region` VALUES (1312, '1', '41', '1', '82', '荥阳市', 'Fuyang City', '');
INSERT INTO `feel_region` VALUES (1313, '1', '41', '1', '83', '新密市', 'Xinmi City', '');
INSERT INTO `feel_region` VALUES (1314, '1', '41', '1', '84', '新郑市', 'Xinzheng City', '');
INSERT INTO `feel_region` VALUES (1315, '1', '41', '1', '85', '登封市', 'Dengfeng City', '');
INSERT INTO `feel_region` VALUES (1316, '1', '41', '2', '2', '龙亭区', 'Longting District', '');
INSERT INTO `feel_region` VALUES (1317, '1', '41', '2', '3', '顺河回族区', 'Shunhe Hui Nationality Area', '');
INSERT INTO `feel_region` VALUES (1318, '1', '41', '2', '4', '鼓楼区', 'Gulou District', '');
INSERT INTO `feel_region` VALUES (1319, '1', '41', '2', '5', '禹王台区', 'Wangwangtai District', '');
INSERT INTO `feel_region` VALUES (1320, '1', '41', '2', '11', '金明区', 'Jinming District', '');
INSERT INTO `feel_region` VALUES (1321, '1', '41', '2', '21', '杞　县', 'Qi County', '');
INSERT INTO `feel_region` VALUES (1322, '1', '41', '2', '22', '通许县', 'Tongxu County', '');
INSERT INTO `feel_region` VALUES (1323, '1', '41', '2', '23', '尉氏县', 'Weishi County', '');
INSERT INTO `feel_region` VALUES (1324, '1', '41', '2', '24', '开封县', 'Kaifeng County', '');
INSERT INTO `feel_region` VALUES (1325, '1', '41', '2', '25', '兰考县', 'Lankao County', '');
INSERT INTO `feel_region` VALUES (1326, '1', '41', '3', '2', '老城区', 'Old Town District', '');
INSERT INTO `feel_region` VALUES (1327, '1', '41', '3', '3', '西工区', 'Xigong District', '');
INSERT INTO `feel_region` VALUES (1328, '1', '41', '3', '4', '瀍河回族区', 'Luohe Hui Nationality Area', '');
INSERT INTO `feel_region` VALUES (1329, '1', '41', '3', '5', '涧西区', 'Yuxi District', '');
INSERT INTO `feel_region` VALUES (1330, '1', '41', '3', '6', '吉利区', 'Geely District', '');
INSERT INTO `feel_region` VALUES (1331, '1', '41', '3', '11', '洛龙区', 'Luolong District', '');
INSERT INTO `feel_region` VALUES (1332, '1', '41', '3', '22', '孟津县', 'Mengjin County', '');
INSERT INTO `feel_region` VALUES (1333, '1', '41', '3', '23', '新安县', 'Xin\'an County', '');
INSERT INTO `feel_region` VALUES (1334, '1', '41', '3', '24', '栾川县', 'Luanchuan County', '');
INSERT INTO `feel_region` VALUES (1335, '1', '41', '3', '25', '嵩　县', 'Song County', '');
INSERT INTO `feel_region` VALUES (1336, '1', '41', '3', '26', '汝阳县', 'Shuyang County', '');
INSERT INTO `feel_region` VALUES (1337, '1', '41', '3', '27', '宜阳县', 'Yiyang County', '');
INSERT INTO `feel_region` VALUES (1338, '1', '41', '3', '28', '洛宁县', 'Luoning County', '');
INSERT INTO `feel_region` VALUES (1339, '1', '41', '3', '29', '伊川县', 'Yichuan County', '');
INSERT INTO `feel_region` VALUES (1340, '1', '41', '3', '81', '偃师市', 'Yanshi City', '');
INSERT INTO `feel_region` VALUES (1341, '1', '41', '4', '2', '新华区', 'Xinhua District', '');
INSERT INTO `feel_region` VALUES (1342, '1', '41', '4', '3', '卫东区', 'Weidong District', '');
INSERT INTO `feel_region` VALUES (1343, '1', '41', '4', '4', '石龙区', 'Shilong District', '');
INSERT INTO `feel_region` VALUES (1344, '1', '41', '4', '11', '湛河区', 'Zhanhe District', '');
INSERT INTO `feel_region` VALUES (1345, '1', '41', '4', '21', '宝丰县', 'Baofeng County', '');
INSERT INTO `feel_region` VALUES (1346, '1', '41', '4', '22', '叶　县', 'Ye County', '');
INSERT INTO `feel_region` VALUES (1347, '1', '41', '4', '23', '鲁山县', 'Lushan County', '');
INSERT INTO `feel_region` VALUES (1348, '1', '41', '4', '25', '郏　县', 'Jia County', '');
INSERT INTO `feel_region` VALUES (1349, '1', '41', '4', '81', '舞钢市', 'Wugang City', '');
INSERT INTO `feel_region` VALUES (1350, '1', '41', '4', '82', '汝州市', 'Quzhou City', '');
INSERT INTO `feel_region` VALUES (1351, '1', '41', '5', '2', '文峰区', 'Wenfeng District', '');
INSERT INTO `feel_region` VALUES (1352, '1', '41', '5', '3', '北关区', 'Beiguan District', '');
INSERT INTO `feel_region` VALUES (1353, '1', '41', '5', '5', '殷都区', 'Yindu District', '');
INSERT INTO `feel_region` VALUES (1354, '1', '41', '5', '6', '龙安区', 'Long\'an District', '');
INSERT INTO `feel_region` VALUES (1355, '1', '41', '5', '22', '安阳县', 'Anyang County', '');
INSERT INTO `feel_region` VALUES (1356, '1', '41', '5', '23', '汤阴县', 'Tangyin County', '');
INSERT INTO `feel_region` VALUES (1357, '1', '41', '5', '26', '滑　县', 'Slip county', '');
INSERT INTO `feel_region` VALUES (1358, '1', '41', '5', '27', '内黄县', 'Neihuang County', '');
INSERT INTO `feel_region` VALUES (1359, '1', '41', '5', '81', '林州市', 'Linzhou City', '');
INSERT INTO `feel_region` VALUES (1360, '1', '41', '6', '2', '鹤山区', 'Heshan District', '');
INSERT INTO `feel_region` VALUES (1361, '1', '41', '6', '3', '山城区', 'Mountain town', '');
INSERT INTO `feel_region` VALUES (1362, '1', '41', '6', '11', '淇滨区', 'Qibin District', '');
INSERT INTO `feel_region` VALUES (1363, '1', '41', '6', '21', '浚　县', 'Xun County', '');
INSERT INTO `feel_region` VALUES (1364, '1', '41', '6', '22', '淇　县', 'Qi County', '');
INSERT INTO `feel_region` VALUES (1365, '1', '41', '7', '2', '红旗区', 'Hongqi District', '');
INSERT INTO `feel_region` VALUES (1366, '1', '41', '7', '3', '卫滨区', 'Weibin District', '');
INSERT INTO `feel_region` VALUES (1367, '1', '41', '7', '4', '凤泉区', 'Fengquan District', '');
INSERT INTO `feel_region` VALUES (1368, '1', '41', '7', '11', '牧野区', 'Makino', '');
INSERT INTO `feel_region` VALUES (1369, '1', '41', '7', '21', '新乡县', 'Xinxiang County', '');
INSERT INTO `feel_region` VALUES (1370, '1', '41', '7', '24', '获嘉县', 'Jiaxian County', '');
INSERT INTO `feel_region` VALUES (1371, '1', '41', '7', '25', '原阳县', 'Yuanyang County', '');
INSERT INTO `feel_region` VALUES (1372, '1', '41', '7', '26', '延津县', 'Yanjin County', '');
INSERT INTO `feel_region` VALUES (1373, '1', '41', '7', '27', '封丘县', 'Fengqiu County', '');
INSERT INTO `feel_region` VALUES (1374, '1', '41', '7', '28', '长垣县', 'Changyi County', '');
INSERT INTO `feel_region` VALUES (1375, '1', '41', '7', '81', '卫辉市', 'Weihui City', '');
INSERT INTO `feel_region` VALUES (1376, '1', '41', '7', '82', '辉县市', 'Huixian City', '');
INSERT INTO `feel_region` VALUES (1377, '1', '41', '8', '2', '解放区', 'Liberated area', '');
INSERT INTO `feel_region` VALUES (1378, '1', '41', '8', '3', '中站区', 'Middle station area', '');
INSERT INTO `feel_region` VALUES (1379, '1', '41', '8', '4', '马村区', 'Macun District', '');
INSERT INTO `feel_region` VALUES (1380, '1', '41', '8', '11', '山阳区', 'Shanyang District', '');
INSERT INTO `feel_region` VALUES (1381, '1', '41', '8', '21', '修武县', 'Xiuwu County', '');
INSERT INTO `feel_region` VALUES (1382, '1', '41', '8', '22', '博爱县', 'Bo\'ai County', '');
INSERT INTO `feel_region` VALUES (1383, '1', '41', '8', '23', '武陟县', 'Wuyi County', '');
INSERT INTO `feel_region` VALUES (1384, '1', '41', '8', '25', '温　县', 'Wen County', '');
INSERT INTO `feel_region` VALUES (1385, '1', '41', '8', '82', '沁阳市', 'Fuyang City', '');
INSERT INTO `feel_region` VALUES (1386, '1', '41', '8', '83', '孟州市', 'Mengzhou City', '');
INSERT INTO `feel_region` VALUES (1387, '1', '41', '9', '2', '华龙区', 'Hualong District', '');
INSERT INTO `feel_region` VALUES (1388, '1', '41', '9', '22', '清丰县', 'Qingfeng County', '');
INSERT INTO `feel_region` VALUES (1389, '1', '41', '9', '23', '南乐县', 'Nanle County', '');
INSERT INTO `feel_region` VALUES (1390, '1', '41', '9', '26', '范　县', 'Fan County', '');
INSERT INTO `feel_region` VALUES (1391, '1', '41', '9', '27', '台前县', 'Taiqian County', '');
INSERT INTO `feel_region` VALUES (1392, '1', '41', '9', '28', '濮阳县', 'Shuyang County', '');
INSERT INTO `feel_region` VALUES (1393, '1', '41', '10', '2', '魏都区', 'Weidu District', '');
INSERT INTO `feel_region` VALUES (1394, '1', '41', '10', '23', '许昌县', 'Xuchang County', '');
INSERT INTO `feel_region` VALUES (1395, '1', '41', '10', '24', '鄢陵县', 'Yanling County', '');
INSERT INTO `feel_region` VALUES (1396, '1', '41', '10', '25', '襄城县', 'Yucheng County', '');
INSERT INTO `feel_region` VALUES (1397, '1', '41', '10', '81', '禹州市', 'Quzhou City', '');
INSERT INTO `feel_region` VALUES (1398, '1', '41', '10', '82', '长葛市', 'Changge City', '');
INSERT INTO `feel_region` VALUES (1399, '1', '41', '11', '2', '源汇区', 'Source area', '');
INSERT INTO `feel_region` VALUES (1400, '1', '41', '11', '3', '郾城区', 'Wucheng District', '');
INSERT INTO `feel_region` VALUES (1401, '1', '41', '11', '4', '召陵区', 'Zhaoling District', '');
INSERT INTO `feel_region` VALUES (1402, '1', '41', '11', '21', '舞阳县', 'Wuyang County', '');
INSERT INTO `feel_region` VALUES (1403, '1', '41', '11', '22', '临颍县', 'Linyi County', '');
INSERT INTO `feel_region` VALUES (1404, '1', '41', '12', '2', '湖滨区', 'Lakeside area', '');
INSERT INTO `feel_region` VALUES (1405, '1', '41', '12', '21', '渑池县', 'Dianchi County', '');
INSERT INTO `feel_region` VALUES (1406, '1', '41', '12', '22', '陕　县', 'Shaanxi County', '');
INSERT INTO `feel_region` VALUES (1407, '1', '41', '12', '24', '卢氏县', 'Lushi County', '');
INSERT INTO `feel_region` VALUES (1408, '1', '41', '12', '81', '义马市', 'Yima City', '');
INSERT INTO `feel_region` VALUES (1409, '1', '41', '12', '82', '灵宝市', 'Lingbao City', '');
INSERT INTO `feel_region` VALUES (1410, '1', '41', '13', '2', '宛城区', 'Wancheng District', '');
INSERT INTO `feel_region` VALUES (1411, '1', '41', '13', '3', '卧龙区', 'Wolong District', '');
INSERT INTO `feel_region` VALUES (1412, '1', '41', '13', '21', '南召县', 'Nanzhao County', '');
INSERT INTO `feel_region` VALUES (1413, '1', '41', '13', '22', '方城县', 'Fangcheng County', '');
INSERT INTO `feel_region` VALUES (1414, '1', '41', '13', '23', '西峡县', 'Xixia County', '');
INSERT INTO `feel_region` VALUES (1415, '1', '41', '13', '24', '镇平县', 'Zhenping County', '');
INSERT INTO `feel_region` VALUES (1416, '1', '41', '13', '25', '内乡县', 'Neixiang County', '');
INSERT INTO `feel_region` VALUES (1417, '1', '41', '13', '26', '淅川县', 'Luanchuan County', '');
INSERT INTO `feel_region` VALUES (1418, '1', '41', '13', '27', '社旗县', 'Sheqi County', '');
INSERT INTO `feel_region` VALUES (1419, '1', '41', '13', '28', '唐河县', 'Tanghe County', '');
INSERT INTO `feel_region` VALUES (1420, '1', '41', '13', '29', '新野县', 'Xinye County', '');
INSERT INTO `feel_region` VALUES (1421, '1', '41', '13', '30', '桐柏县', 'Tongbai County', '');
INSERT INTO `feel_region` VALUES (1422, '1', '41', '13', '81', '邓州市', 'Dengzhou City', '');
INSERT INTO `feel_region` VALUES (1423, '1', '41', '14', '2', '梁园区', 'Liang Park', '');
INSERT INTO `feel_region` VALUES (1424, '1', '41', '14', '3', '睢阳区', 'Yuyang District', '');
INSERT INTO `feel_region` VALUES (1425, '1', '41', '14', '21', '民权县', 'Minquan County', '');
INSERT INTO `feel_region` VALUES (1426, '1', '41', '14', '22', '睢　县', 'Sui County', '');
INSERT INTO `feel_region` VALUES (1427, '1', '41', '14', '23', '宁陵县', 'Ningling County', '');
INSERT INTO `feel_region` VALUES (1428, '1', '41', '14', '24', '柘城县', 'Yucheng County', '');
INSERT INTO `feel_region` VALUES (1429, '1', '41', '14', '25', '虞城县', 'Yucheng County', '');
INSERT INTO `feel_region` VALUES (1430, '1', '41', '14', '26', '夏邑县', 'Xiayu County', '');
INSERT INTO `feel_region` VALUES (1431, '1', '41', '14', '81', '永城市', 'Yongcheng', '');
INSERT INTO `feel_region` VALUES (1432, '1', '41', '15', '2', '浉河区', 'Luohe District', '');
INSERT INTO `feel_region` VALUES (1433, '1', '41', '15', '3', '平桥区', 'Pingqiao District', '');
INSERT INTO `feel_region` VALUES (1434, '1', '41', '15', '21', '罗山县', 'Luoshan County', '');
INSERT INTO `feel_region` VALUES (1435, '1', '41', '15', '22', '光山县', 'Guangshan County', '');
INSERT INTO `feel_region` VALUES (1436, '1', '41', '15', '23', '新　县', 'New county', '');
INSERT INTO `feel_region` VALUES (1437, '1', '41', '15', '24', '商城县', 'Mall County', '');
INSERT INTO `feel_region` VALUES (1438, '1', '41', '15', '25', '固始县', 'Gushi County', '');
INSERT INTO `feel_region` VALUES (1439, '1', '41', '15', '26', '潢川县', 'Huangchuan County', '');
INSERT INTO `feel_region` VALUES (1440, '1', '41', '15', '27', '淮滨县', 'Huaibin County', '');
INSERT INTO `feel_region` VALUES (1441, '1', '41', '15', '28', '息　县', 'County', '');
INSERT INTO `feel_region` VALUES (1442, '1', '41', '16', '2', '川汇区', 'Chuanhui District', '');
INSERT INTO `feel_region` VALUES (1443, '1', '41', '16', '21', '扶沟县', 'Fugou County', '');
INSERT INTO `feel_region` VALUES (1444, '1', '41', '16', '22', '西华县', 'Xihua County', '');
INSERT INTO `feel_region` VALUES (1445, '1', '41', '16', '23', '商水县', 'Shangshui County', '');
INSERT INTO `feel_region` VALUES (1446, '1', '41', '16', '24', '沈丘县', 'Shenqiu County', '');
INSERT INTO `feel_region` VALUES (1447, '1', '41', '16', '25', '郸城县', 'Yucheng County', '');
INSERT INTO `feel_region` VALUES (1448, '1', '41', '16', '26', '淮阳县', 'Huaiyang County', '');
INSERT INTO `feel_region` VALUES (1449, '1', '41', '16', '27', '太康县', 'Taikang County', '');
INSERT INTO `feel_region` VALUES (1450, '1', '41', '16', '28', '鹿邑县', 'Luyi County', '');
INSERT INTO `feel_region` VALUES (1451, '1', '41', '16', '81', '项城市', 'City', '');
INSERT INTO `feel_region` VALUES (1452, '1', '41', '17', '2', '驿城区', 'Wucheng District', '');
INSERT INTO `feel_region` VALUES (1453, '1', '41', '17', '21', '西平县', 'Xiping County', '');
INSERT INTO `feel_region` VALUES (1454, '1', '41', '17', '22', '上蔡县', 'Shangcai County', '');
INSERT INTO `feel_region` VALUES (1455, '1', '41', '17', '23', '平舆县', 'Pingyi County', '');
INSERT INTO `feel_region` VALUES (1456, '1', '41', '17', '24', '正阳县', 'Zhengyang County', '');
INSERT INTO `feel_region` VALUES (1457, '1', '41', '17', '25', '确山县', 'Exact mountain county', '');
INSERT INTO `feel_region` VALUES (1458, '1', '41', '17', '26', '泌阳县', 'Biyang County', '');
INSERT INTO `feel_region` VALUES (1459, '1', '41', '17', '27', '汝南县', 'Yinan County', '');
INSERT INTO `feel_region` VALUES (1460, '1', '41', '17', '28', '遂平县', 'Luanping County', '');
INSERT INTO `feel_region` VALUES (1461, '1', '41', '17', '29', '新蔡县', 'Xincai County', '');
INSERT INTO `feel_region` VALUES (1462, '1', '42', '1', '2', '江岸区', 'Jiang\'an District', '');
INSERT INTO `feel_region` VALUES (1463, '1', '42', '1', '3', '江汉区', 'Jianghan District', '');
INSERT INTO `feel_region` VALUES (1464, '1', '42', '1', '4', '硚口区', 'Qikou District', '');
INSERT INTO `feel_region` VALUES (1465, '1', '42', '1', '5', '汉阳区', 'Hanyang District', '');
INSERT INTO `feel_region` VALUES (1466, '1', '42', '1', '6', '武昌区', 'Wuchang District', '');
INSERT INTO `feel_region` VALUES (1467, '1', '42', '1', '7', '青山区', 'Qingshan District', '');
INSERT INTO `feel_region` VALUES (1468, '1', '42', '1', '11', '洪山区', 'Hongshan District', '');
INSERT INTO `feel_region` VALUES (1469, '1', '42', '1', '12', '东西湖区', 'Dongxihu District', '');
INSERT INTO `feel_region` VALUES (1470, '1', '42', '1', '13', '汉南区', 'Hannan District', '');
INSERT INTO `feel_region` VALUES (1471, '1', '42', '1', '14', '蔡甸区', 'Caidian District', '');
INSERT INTO `feel_region` VALUES (1472, '1', '42', '1', '15', '江夏区', 'Jiangxia District', '');
INSERT INTO `feel_region` VALUES (1473, '1', '42', '1', '16', '黄陂区', 'Huangpi District', '');
INSERT INTO `feel_region` VALUES (1474, '1', '42', '1', '17', '新洲区', 'Xinzhou District', '');
INSERT INTO `feel_region` VALUES (1475, '1', '42', '2', '2', '黄石港区', 'Huangshi Port Area', '');
INSERT INTO `feel_region` VALUES (1476, '1', '42', '2', '3', '西塞山区', 'Western Sai Mountain', '');
INSERT INTO `feel_region` VALUES (1477, '1', '42', '2', '4', '下陆区', 'Lower land area', '');
INSERT INTO `feel_region` VALUES (1478, '1', '42', '2', '5', '铁山区', 'Tieshan District', '');
INSERT INTO `feel_region` VALUES (1479, '1', '42', '2', '22', '阳新县', 'Yangxin County', '');
INSERT INTO `feel_region` VALUES (1480, '1', '42', '2', '81', '大冶市', 'Daye City', '');
INSERT INTO `feel_region` VALUES (1481, '1', '42', '3', '2', '茅箭区', 'Maojian District', '');
INSERT INTO `feel_region` VALUES (1482, '1', '42', '3', '3', '张湾区', 'Zhangwan District', '');
INSERT INTO `feel_region` VALUES (1483, '1', '42', '3', '21', '郧　县', 'Yun County', '');
INSERT INTO `feel_region` VALUES (1484, '1', '42', '3', '22', '郧西县', 'Yunxi County', '');
INSERT INTO `feel_region` VALUES (1485, '1', '42', '3', '23', '竹山县', 'Zhushan County', '');
INSERT INTO `feel_region` VALUES (1486, '1', '42', '3', '24', '竹溪县', 'Zhuxi County', '');
INSERT INTO `feel_region` VALUES (1487, '1', '42', '3', '25', '房　县', 'Fang County', '');
INSERT INTO `feel_region` VALUES (1488, '1', '42', '3', '81', '丹江口市', 'Danjiangkou City', '');
INSERT INTO `feel_region` VALUES (1489, '1', '42', '5', '2', '西陵区', 'Xiling District', '');
INSERT INTO `feel_region` VALUES (1490, '1', '42', '5', '3', '伍家岗区', 'Wujiagang District', '');
INSERT INTO `feel_region` VALUES (1491, '1', '42', '5', '4', '点军区', 'Point military region', '');
INSERT INTO `feel_region` VALUES (1492, '1', '42', '5', '5', '猇亭区', 'Yuting District', '');
INSERT INTO `feel_region` VALUES (1493, '1', '42', '5', '6', '夷陵区', 'Yiling District', '');
INSERT INTO `feel_region` VALUES (1494, '1', '42', '5', '25', '远安县', 'Yuan\'an County', '');
INSERT INTO `feel_region` VALUES (1495, '1', '42', '5', '26', '兴山县', 'Xingshan County', '');
INSERT INTO `feel_region` VALUES (1496, '1', '42', '5', '27', '秭归县', 'Zigui County', '');
INSERT INTO `feel_region` VALUES (1497, '1', '42', '5', '28', '长阳土家族自治县', 'Changyang Tujia Autonomous County', '');
INSERT INTO `feel_region` VALUES (1498, '1', '42', '5', '29', '五峰土家族自治县', 'Wufeng Tujia Autonomous County', '');
INSERT INTO `feel_region` VALUES (1499, '1', '42', '5', '81', '宜都市', 'Yidu', '');
INSERT INTO `feel_region` VALUES (1500, '1', '42', '5', '82', '当阳市', 'Dangyang City', '');
INSERT INTO `feel_region` VALUES (1501, '1', '42', '5', '83', '枝江市', 'Zhijiang City', '');
INSERT INTO `feel_region` VALUES (1502, '1', '42', '6', '2', '襄城区', 'Wucheng District', '');
INSERT INTO `feel_region` VALUES (1503, '1', '42', '6', '6', '樊城区', 'Fancheng District', '');
INSERT INTO `feel_region` VALUES (1504, '1', '42', '6', '7', '襄州区', 'Yinzhou District', '');
INSERT INTO `feel_region` VALUES (1505, '1', '42', '6', '24', '南漳县', 'Nanxun County', '');
INSERT INTO `feel_region` VALUES (1506, '1', '42', '6', '25', '谷城县', 'Gucheng County', '');
INSERT INTO `feel_region` VALUES (1507, '1', '42', '6', '26', '保康县', 'Baokang County', '');
INSERT INTO `feel_region` VALUES (1508, '1', '42', '6', '82', '老河口市', 'Laohekou City', '');
INSERT INTO `feel_region` VALUES (1509, '1', '42', '6', '83', '枣阳市', 'Zaoyang City', '');
INSERT INTO `feel_region` VALUES (1510, '1', '42', '6', '84', '宜城市', 'Yicheng', '');
INSERT INTO `feel_region` VALUES (1511, '1', '42', '7', '2', '梁子湖区', 'Liangzihu District', '');
INSERT INTO `feel_region` VALUES (1512, '1', '42', '7', '3', '华容区', 'Huarong District', '');
INSERT INTO `feel_region` VALUES (1513, '1', '42', '7', '4', '鄂城区', 'Echeng District', '');
INSERT INTO `feel_region` VALUES (1514, '1', '42', '8', '2', '东宝区', 'Dongbao District', '');
INSERT INTO `feel_region` VALUES (1515, '1', '42', '8', '4', '掇刀区', 'Sickle area', '');
INSERT INTO `feel_region` VALUES (1516, '1', '42', '8', '21', '京山县', 'Jingshan County', '');
INSERT INTO `feel_region` VALUES (1517, '1', '42', '8', '22', '沙洋县', 'Shayang County', '');
INSERT INTO `feel_region` VALUES (1518, '1', '42', '8', '81', '钟祥市', 'Zhongxiang City', '');
INSERT INTO `feel_region` VALUES (1519, '1', '42', '9', '2', '孝南区', 'Xiaonan District', '');
INSERT INTO `feel_region` VALUES (1520, '1', '42', '9', '21', '孝昌县', 'Xiaochang County', '');
INSERT INTO `feel_region` VALUES (1521, '1', '42', '9', '22', '大悟县', 'Dawu County', '');
INSERT INTO `feel_region` VALUES (1522, '1', '42', '9', '23', '云梦县', 'Yunmeng County', '');
INSERT INTO `feel_region` VALUES (1523, '1', '42', '9', '81', '应城市', 'Yingcheng', '');
INSERT INTO `feel_region` VALUES (1524, '1', '42', '9', '82', '安陆市', 'Anlu City', '');
INSERT INTO `feel_region` VALUES (1525, '1', '42', '9', '84', '汉川市', 'Hanchuan City', '');
INSERT INTO `feel_region` VALUES (1526, '1', '42', '10', '2', '沙市区', 'Sand city', '');
INSERT INTO `feel_region` VALUES (1527, '1', '42', '10', '3', '荆州区', 'Jingzhou District', '');
INSERT INTO `feel_region` VALUES (1528, '1', '42', '10', '22', '公安县', 'Public security county', '');
INSERT INTO `feel_region` VALUES (1529, '1', '42', '10', '23', '监利县', 'Jianli County', '');
INSERT INTO `feel_region` VALUES (1530, '1', '42', '10', '24', '江陵县', 'Jiangling County', '');
INSERT INTO `feel_region` VALUES (1531, '1', '42', '10', '81', '石首市', 'Shishou City', '');
INSERT INTO `feel_region` VALUES (1532, '1', '42', '10', '83', '洪湖市', 'Honghu City', '');
INSERT INTO `feel_region` VALUES (1533, '1', '42', '10', '87', '松滋市', 'Songzi City', '');
INSERT INTO `feel_region` VALUES (1534, '1', '42', '11', '2', '黄州区', 'Huangzhou District', '');
INSERT INTO `feel_region` VALUES (1535, '1', '42', '11', '21', '团风县', 'Tuanfeng County', '');
INSERT INTO `feel_region` VALUES (1536, '1', '42', '11', '22', '红安县', 'Hong\'an County', '');
INSERT INTO `feel_region` VALUES (1537, '1', '42', '11', '23', '罗田县', 'Luotian County', '');
INSERT INTO `feel_region` VALUES (1538, '1', '42', '11', '24', '英山县', 'Yingshan County', '');
INSERT INTO `feel_region` VALUES (1539, '1', '42', '11', '25', '浠水县', 'Yishui County', '');
INSERT INTO `feel_region` VALUES (1540, '1', '42', '11', '26', '蕲春县', 'Hunchun County', '');
INSERT INTO `feel_region` VALUES (1541, '1', '42', '11', '27', '黄梅县', 'Huangmei County', '');
INSERT INTO `feel_region` VALUES (1542, '1', '42', '11', '81', '麻城市', 'Macheng', '');
INSERT INTO `feel_region` VALUES (1543, '1', '42', '11', '82', '武穴市', 'Wuxue City', '');
INSERT INTO `feel_region` VALUES (1544, '1', '42', '12', '2', '咸安区', 'Xian\'an District', '');
INSERT INTO `feel_region` VALUES (1545, '1', '42', '12', '21', '嘉鱼县', 'Jiayu County', '');
INSERT INTO `feel_region` VALUES (1546, '1', '42', '12', '22', '通城县', 'Tongcheng County', '');
INSERT INTO `feel_region` VALUES (1547, '1', '42', '12', '23', '崇阳县', 'Chongyang County', '');
INSERT INTO `feel_region` VALUES (1548, '1', '42', '12', '24', '通山县', 'Tongshan County', '');
INSERT INTO `feel_region` VALUES (1549, '1', '42', '12', '81', '赤壁市', 'Chibi City', '');
INSERT INTO `feel_region` VALUES (1550, '1', '42', '13', '2', '曾都区', 'Zengdu District', '');
INSERT INTO `feel_region` VALUES (1551, '1', '42', '13', '21', '随县', 'With the county', '');
INSERT INTO `feel_region` VALUES (1552, '1', '42', '13', '81', '广水市', 'Guangshui City', '');
INSERT INTO `feel_region` VALUES (1553, '1', '42', '28', '1', '恩施市', 'Enshi City', '');
INSERT INTO `feel_region` VALUES (1554, '1', '42', '28', '2', '利川市', 'Icheon City', '');
INSERT INTO `feel_region` VALUES (1555, '1', '42', '28', '22', '建始县', 'Jianshi County', '');
INSERT INTO `feel_region` VALUES (1556, '1', '42', '28', '23', '巴东县', 'Badong County', '');
INSERT INTO `feel_region` VALUES (1557, '1', '42', '28', '25', '宣恩县', 'Xuanen County', '');
INSERT INTO `feel_region` VALUES (1558, '1', '42', '28', '26', '咸丰县', 'Xianfeng County', '');
INSERT INTO `feel_region` VALUES (1559, '1', '42', '28', '27', '来凤县', 'Laifeng County', '');
INSERT INTO `feel_region` VALUES (1560, '1', '42', '28', '28', '鹤峰县', 'Hefeng County', '');
INSERT INTO `feel_region` VALUES (1561, '1', '43', '1', '2', '芙蓉区', 'Furong District', '');
INSERT INTO `feel_region` VALUES (1562, '1', '43', '1', '3', '天心区', 'Tianxin District', '');
INSERT INTO `feel_region` VALUES (1563, '1', '43', '1', '4', '岳麓区', 'Yuelu District', '');
INSERT INTO `feel_region` VALUES (1564, '1', '43', '1', '5', '开福区', 'Kaifu District', '');
INSERT INTO `feel_region` VALUES (1565, '1', '43', '1', '11', '雨花区', 'Yuhua District', '');
INSERT INTO `feel_region` VALUES (1566, '1', '43', '1', '21', '长沙县', 'Changsha County', '');
INSERT INTO `feel_region` VALUES (1567, '1', '43', '1', '22', '望城区', 'Wangcheng District', '');
INSERT INTO `feel_region` VALUES (1568, '1', '43', '1', '24', '宁乡县', 'Ningxiang County', '');
INSERT INTO `feel_region` VALUES (1569, '1', '43', '1', '81', '浏阳市', 'Liuyang City', '');
INSERT INTO `feel_region` VALUES (1570, '1', '43', '2', '2', '荷塘区', 'Lotus pond', '');
INSERT INTO `feel_region` VALUES (1571, '1', '43', '2', '3', '芦淞区', 'Lusong District', '');
INSERT INTO `feel_region` VALUES (1572, '1', '43', '2', '4', '石峰区', 'Shifeng District', '');
INSERT INTO `feel_region` VALUES (1573, '1', '43', '2', '11', '天元区', 'Tianyuan District', '');
INSERT INTO `feel_region` VALUES (1574, '1', '43', '2', '21', '株洲县', 'Zhuzhou County', '');
INSERT INTO `feel_region` VALUES (1575, '1', '43', '2', '23', '攸　县', 'You County', '');
INSERT INTO `feel_region` VALUES (1576, '1', '43', '2', '24', '茶陵县', 'Chaling County', '');
INSERT INTO `feel_region` VALUES (1577, '1', '43', '2', '25', '炎陵县', 'Yanling County', '');
INSERT INTO `feel_region` VALUES (1578, '1', '43', '2', '81', '醴陵市', 'Liling City', '');
INSERT INTO `feel_region` VALUES (1579, '1', '43', '3', '2', '雨湖区', 'Yuhu District', '');
INSERT INTO `feel_region` VALUES (1580, '1', '43', '3', '4', '岳塘区', 'Yuetang District', '');
INSERT INTO `feel_region` VALUES (1581, '1', '43', '3', '21', '湘潭县', 'Xiangtan County', '');
INSERT INTO `feel_region` VALUES (1582, '1', '43', '3', '81', '湘乡市', 'Xiangxiang City', '');
INSERT INTO `feel_region` VALUES (1583, '1', '43', '3', '82', '韶山市', 'Lushan City', '');
INSERT INTO `feel_region` VALUES (1584, '1', '43', '4', '5', '珠晖区', 'Zhuhui District', '');
INSERT INTO `feel_region` VALUES (1585, '1', '43', '4', '6', '雁峰区', 'Yanfeng District', '');
INSERT INTO `feel_region` VALUES (1586, '1', '43', '4', '7', '石鼓区', 'Shigu District', '');
INSERT INTO `feel_region` VALUES (1587, '1', '43', '4', '8', '蒸湘区', 'Steaming area', '');
INSERT INTO `feel_region` VALUES (1588, '1', '43', '4', '12', '南岳区', 'Nanyue District', '');
INSERT INTO `feel_region` VALUES (1589, '1', '43', '4', '21', '衡阳县', 'Hengyang County', '');
INSERT INTO `feel_region` VALUES (1590, '1', '43', '4', '22', '衡南县', 'Hengnan County', '');
INSERT INTO `feel_region` VALUES (1591, '1', '43', '4', '23', '衡山县', 'Hengshan County', '');
INSERT INTO `feel_region` VALUES (1592, '1', '43', '4', '24', '衡东县', 'Hengdong County', '');
INSERT INTO `feel_region` VALUES (1593, '1', '43', '4', '26', '祁东县', 'Zhaodong County', '');
INSERT INTO `feel_region` VALUES (1594, '1', '43', '4', '81', '耒阳市', 'Fuyang City', '');
INSERT INTO `feel_region` VALUES (1595, '1', '43', '4', '82', '常宁市', 'Changning City', '');
INSERT INTO `feel_region` VALUES (1596, '1', '43', '5', '2', '双清区', 'Shuangqing District', '');
INSERT INTO `feel_region` VALUES (1597, '1', '43', '5', '3', '大祥区', 'Daxiang District', '');
INSERT INTO `feel_region` VALUES (1598, '1', '43', '5', '11', '北塔区', 'Beita District', '');
INSERT INTO `feel_region` VALUES (1599, '1', '43', '5', '21', '邵东县', 'Shaodong County', '');
INSERT INTO `feel_region` VALUES (1600, '1', '43', '5', '22', '新邵县', 'Xinshao County', '');
INSERT INTO `feel_region` VALUES (1601, '1', '43', '5', '23', '邵阳县', 'Shaoyang County', '');
INSERT INTO `feel_region` VALUES (1602, '1', '43', '5', '24', '隆回县', 'Longhui County', '');
INSERT INTO `feel_region` VALUES (1603, '1', '43', '5', '25', '洞口县', 'Dongkou County', '');
INSERT INTO `feel_region` VALUES (1604, '1', '43', '5', '27', '绥宁县', 'Suining County', '');
INSERT INTO `feel_region` VALUES (1605, '1', '43', '5', '28', '新宁县', 'Xinning County', '');
INSERT INTO `feel_region` VALUES (1606, '1', '43', '5', '29', '城步苗族自治县', 'Chengbu Miao Autonomous County', '');
INSERT INTO `feel_region` VALUES (1607, '1', '43', '5', '81', '武冈市', 'Wugang City', '');
INSERT INTO `feel_region` VALUES (1608, '1', '43', '6', '2', '岳阳楼区', 'Yueyang Building Area', '');
INSERT INTO `feel_region` VALUES (1609, '1', '43', '6', '3', '云溪区', 'Yunxi District', '');
INSERT INTO `feel_region` VALUES (1610, '1', '43', '6', '11', '君山区', 'Junshan District', '');
INSERT INTO `feel_region` VALUES (1611, '1', '43', '6', '21', '岳阳县', 'Yueyang County', '');
INSERT INTO `feel_region` VALUES (1612, '1', '43', '6', '23', '华容县', 'Huarong County', '');
INSERT INTO `feel_region` VALUES (1613, '1', '43', '6', '24', '湘阴县', 'Xiangyin County', '');
INSERT INTO `feel_region` VALUES (1614, '1', '43', '6', '26', '平江县', 'Pingjiang County', '');
INSERT INTO `feel_region` VALUES (1615, '1', '43', '6', '81', '汨罗市', 'Miluo City', '');
INSERT INTO `feel_region` VALUES (1616, '1', '43', '6', '82', '临湘市', 'Linxiang City', '');
INSERT INTO `feel_region` VALUES (1617, '1', '43', '7', '2', '武陵区', 'Wuling District', '');
INSERT INTO `feel_region` VALUES (1618, '1', '43', '7', '3', '鼎城区', 'Dingcheng District', '');
INSERT INTO `feel_region` VALUES (1619, '1', '43', '7', '21', '安乡县', 'Anxiang County', '');
INSERT INTO `feel_region` VALUES (1620, '1', '43', '7', '22', '汉寿县', 'Hanshou County', '');
INSERT INTO `feel_region` VALUES (1621, '1', '43', '7', '23', '澧　县', 'Li County', '');
INSERT INTO `feel_region` VALUES (1622, '1', '43', '7', '24', '临澧县', 'Linli County', '');
INSERT INTO `feel_region` VALUES (1623, '1', '43', '7', '25', '桃源县', 'Taoyuan County', '');
INSERT INTO `feel_region` VALUES (1624, '1', '43', '7', '26', '石门县', 'Shimen County', '');
INSERT INTO `feel_region` VALUES (1625, '1', '43', '7', '81', '津市市', 'Tsu City', '');
INSERT INTO `feel_region` VALUES (1626, '1', '43', '8', '2', '永定区', 'Yongding District', '');
INSERT INTO `feel_region` VALUES (1627, '1', '43', '8', '11', '武陵源区', 'Wulingyuan District', '');
INSERT INTO `feel_region` VALUES (1628, '1', '43', '8', '21', '慈利县', 'Cili County', '');
INSERT INTO `feel_region` VALUES (1629, '1', '43', '8', '22', '桑植县', 'Sangzhi County', '');
INSERT INTO `feel_region` VALUES (1630, '1', '43', '9', '2', '资阳区', 'Ziyang District', '');
INSERT INTO `feel_region` VALUES (1631, '1', '43', '9', '3', '赫山区', 'Heshan District', '');
INSERT INTO `feel_region` VALUES (1632, '1', '43', '9', '21', '南　县', 'Nan County', '');
INSERT INTO `feel_region` VALUES (1633, '1', '43', '9', '22', '桃江县', 'Taojiang County', '');
INSERT INTO `feel_region` VALUES (1634, '1', '43', '9', '23', '安化县', 'Anhua County', '');
INSERT INTO `feel_region` VALUES (1635, '1', '43', '9', '81', '沅江市', 'Qijiang City', '');
INSERT INTO `feel_region` VALUES (1636, '1', '43', '10', '2', '北湖区', 'Beihu District', '');
INSERT INTO `feel_region` VALUES (1637, '1', '43', '10', '3', '苏仙区', 'Suxian District', '');
INSERT INTO `feel_region` VALUES (1638, '1', '43', '10', '21', '桂阳县', 'Guiyang County', '');
INSERT INTO `feel_region` VALUES (1639, '1', '43', '10', '22', '宜章县', 'Yizhang County', '');
INSERT INTO `feel_region` VALUES (1640, '1', '43', '10', '23', '永兴县', 'Yongxing County', '');
INSERT INTO `feel_region` VALUES (1641, '1', '43', '10', '24', '嘉禾县', 'Jiahe County', '');
INSERT INTO `feel_region` VALUES (1642, '1', '43', '10', '25', '临武县', 'Linwu County', '');
INSERT INTO `feel_region` VALUES (1643, '1', '43', '10', '26', '汝城县', 'Yucheng County', '');
INSERT INTO `feel_region` VALUES (1644, '1', '43', '10', '27', '桂东县', 'Guidong County', '');
INSERT INTO `feel_region` VALUES (1645, '1', '43', '10', '28', '安仁县', 'Anren County', '');
INSERT INTO `feel_region` VALUES (1646, '1', '43', '10', '81', '资兴市', 'Zixing City', '');
INSERT INTO `feel_region` VALUES (1647, '1', '43', '11', '2', '零陵区', 'Lingling District', '');
INSERT INTO `feel_region` VALUES (1648, '1', '43', '11', '3', '冷水滩区', 'Cold water beach area', '');
INSERT INTO `feel_region` VALUES (1649, '1', '43', '11', '21', '祁阳县', 'Shuyang County', '');
INSERT INTO `feel_region` VALUES (1650, '1', '43', '11', '22', '东安县', 'Dong\'an County', '');
INSERT INTO `feel_region` VALUES (1651, '1', '43', '11', '23', '双牌县', 'Shuangpai County', '');
INSERT INTO `feel_region` VALUES (1652, '1', '43', '11', '24', '道　县', 'Dao County', '');
INSERT INTO `feel_region` VALUES (1653, '1', '43', '11', '25', '江永县', 'Jiangyong County', '');
INSERT INTO `feel_region` VALUES (1654, '1', '43', '11', '26', '宁远县', 'Ningyuan County', '');
INSERT INTO `feel_region` VALUES (1655, '1', '43', '11', '27', '蓝山县', 'Lanshan County', '');
INSERT INTO `feel_region` VALUES (1656, '1', '43', '11', '28', '新田县', 'Xintian County', '');
INSERT INTO `feel_region` VALUES (1657, '1', '43', '11', '29', '江华瑶族自治县', 'Jianghua Yao Autonomous County', '');
INSERT INTO `feel_region` VALUES (1658, '1', '43', '12', '2', '鹤城区', 'Hecheng District', '');
INSERT INTO `feel_region` VALUES (1659, '1', '43', '12', '21', '中方县', 'Zhongfang County', '');
INSERT INTO `feel_region` VALUES (1660, '1', '43', '12', '22', '沅陵县', 'Yanling County', '');
INSERT INTO `feel_region` VALUES (1661, '1', '43', '12', '23', '辰溪县', 'Chenxi County', '');
INSERT INTO `feel_region` VALUES (1662, '1', '43', '12', '24', '溆浦县', 'Zhangpu County', '');
INSERT INTO `feel_region` VALUES (1663, '1', '43', '12', '25', '会同县', 'Huitong County', '');
INSERT INTO `feel_region` VALUES (1664, '1', '43', '12', '26', '麻阳苗族自治县', 'Mayang Miao Autonomous County', '');
INSERT INTO `feel_region` VALUES (1665, '1', '43', '12', '27', '新晃侗族自治县', 'Xinhuang Dai Autonomous County', '');
INSERT INTO `feel_region` VALUES (1666, '1', '43', '12', '28', '芷江侗族自治县', 'Minjiang Yi Autonomous County', '');
INSERT INTO `feel_region` VALUES (1667, '1', '43', '12', '29', '靖州苗族侗族自治县', 'Jingzhou Miao and Dong Autonomous County', '');
INSERT INTO `feel_region` VALUES (1668, '1', '43', '12', '30', '通道侗族自治县', 'Channel Yi Autonomous County', '');
INSERT INTO `feel_region` VALUES (1669, '1', '43', '12', '81', '洪江市', 'Hongjiang City', '');
INSERT INTO `feel_region` VALUES (1670, '1', '43', '13', '2', '娄星区', 'Comet area', '');
INSERT INTO `feel_region` VALUES (1671, '1', '43', '13', '21', '双峰县', 'Shuangfeng County', '');
INSERT INTO `feel_region` VALUES (1672, '1', '43', '13', '22', '新化县', 'Xinhua County', '');
INSERT INTO `feel_region` VALUES (1673, '1', '43', '13', '81', '冷水江市', 'Lengshuijiang City', '');
INSERT INTO `feel_region` VALUES (1674, '1', '43', '13', '82', '涟源市', 'Wuyuan City', '');
INSERT INTO `feel_region` VALUES (1675, '1', '43', '31', '1', '吉首市', 'Jishou City', '');
INSERT INTO `feel_region` VALUES (1676, '1', '43', '31', '22', '泸溪县', 'Tunxi County', '');
INSERT INTO `feel_region` VALUES (1677, '1', '43', '31', '23', '凤凰县', 'Fenghuang County', '');
INSERT INTO `feel_region` VALUES (1678, '1', '43', '31', '24', '花垣县', 'Huayuan County', '');
INSERT INTO `feel_region` VALUES (1679, '1', '43', '31', '25', '保靖县', 'Baojing County', '');
INSERT INTO `feel_region` VALUES (1680, '1', '43', '31', '26', '古丈县', 'Guzhang County', '');
INSERT INTO `feel_region` VALUES (1681, '1', '43', '31', '27', '永顺县', 'Yongshun County', '');
INSERT INTO `feel_region` VALUES (1682, '1', '43', '31', '30', '龙山县', 'Longshan County', '');
INSERT INTO `feel_region` VALUES (1683, '1', '44', '1', '3', '荔湾区', 'Liwan District', '');
INSERT INTO `feel_region` VALUES (1684, '1', '44', '1', '4', '越秀区', 'Yuexiu District', '');
INSERT INTO `feel_region` VALUES (1685, '1', '44', '1', '5', '海珠区', 'Haizhu District', '');
INSERT INTO `feel_region` VALUES (1686, '1', '44', '1', '6', '天河区', 'Tianhe District', '');
INSERT INTO `feel_region` VALUES (1687, '1', '44', '1', '11', '白云区', 'Baiyun District', '');
INSERT INTO `feel_region` VALUES (1688, '1', '44', '1', '12', '黄埔区', 'Huangpu District', '');
INSERT INTO `feel_region` VALUES (1689, '1', '44', '1', '13', '番禺区', 'Panyu District', '');
INSERT INTO `feel_region` VALUES (1690, '1', '44', '1', '14', '花都区', 'Huadu District', '');
INSERT INTO `feel_region` VALUES (1691, '1', '44', '1', '15', '南沙区', 'Nansha District', '');
INSERT INTO `feel_region` VALUES (1692, '1', '44', '1', '16', '萝岗区', 'Luogang District', '');
INSERT INTO `feel_region` VALUES (1693, '1', '44', '1', '83', '增城市', 'Zengcheng', '');
INSERT INTO `feel_region` VALUES (1694, '1', '44', '1', '84', '从化市', 'Conghua City', '');
INSERT INTO `feel_region` VALUES (1695, '1', '44', '2', '3', '武江区', 'Wujiang District', '');
INSERT INTO `feel_region` VALUES (1696, '1', '44', '2', '4', '浈江区', 'Hanjiang District', '');
INSERT INTO `feel_region` VALUES (1697, '1', '44', '2', '5', '曲江区', 'Qujiang District', '');
INSERT INTO `feel_region` VALUES (1698, '1', '44', '2', '22', '始兴县', 'Shixing County', '');
INSERT INTO `feel_region` VALUES (1699, '1', '44', '2', '24', '仁化县', 'Renhua County', '');
INSERT INTO `feel_region` VALUES (1700, '1', '44', '2', '29', '翁源县', 'Wengyuan County', '');
INSERT INTO `feel_region` VALUES (1701, '1', '44', '2', '32', '乳源瑶族自治县', 'Ruyuan Yao Autonomous County', '');
INSERT INTO `feel_region` VALUES (1702, '1', '44', '2', '33', '新丰县', 'Xinfeng County', '');
INSERT INTO `feel_region` VALUES (1703, '1', '44', '2', '81', '乐昌市', 'Lechang City', '');
INSERT INTO `feel_region` VALUES (1704, '1', '44', '2', '82', '南雄市', 'Nanxiong City', '');
INSERT INTO `feel_region` VALUES (1705, '1', '44', '3', '3', '罗湖区', 'Luohu district', '');
INSERT INTO `feel_region` VALUES (1706, '1', '44', '3', '4', '福田区', 'Futian district', '');
INSERT INTO `feel_region` VALUES (1707, '1', '44', '3', '5', '南山区', 'Nanshan District', '');
INSERT INTO `feel_region` VALUES (1708, '1', '44', '3', '6', '宝安区', 'Bao\'an District', '');
INSERT INTO `feel_region` VALUES (1709, '1', '44', '3', '7', '龙岗区', 'Longgang District', '');
INSERT INTO `feel_region` VALUES (1710, '1', '44', '3', '8', '盐田区', 'Yantian District', '');
INSERT INTO `feel_region` VALUES (1711, '1', '44', '4', '2', '香洲区', 'Xiangzhou District', '');
INSERT INTO `feel_region` VALUES (1712, '1', '44', '4', '3', '斗门区', 'Doumen District', '');
INSERT INTO `feel_region` VALUES (1713, '1', '44', '4', '4', '金湾区', 'Jinwan District', '');
INSERT INTO `feel_region` VALUES (1714, '1', '44', '5', '7', '龙湖区', 'Longhu District', '');
INSERT INTO `feel_region` VALUES (1715, '1', '44', '5', '11', '金平区', 'Kimping District', '');
INSERT INTO `feel_region` VALUES (1716, '1', '44', '5', '12', '濠江区', 'Hanjiang District', '');
INSERT INTO `feel_region` VALUES (1717, '1', '44', '5', '13', '潮阳区', 'Chaoyang District', '');
INSERT INTO `feel_region` VALUES (1718, '1', '44', '5', '14', '潮南区', 'Chaonan District', '');
INSERT INTO `feel_region` VALUES (1719, '1', '44', '5', '15', '澄海区', 'Chenghai District', '');
INSERT INTO `feel_region` VALUES (1720, '1', '44', '5', '23', '南澳县', 'Nan\'ao County', '');
INSERT INTO `feel_region` VALUES (1721, '1', '44', '6', '4', '禅城区', 'Chancheng District', '');
INSERT INTO `feel_region` VALUES (1722, '1', '44', '6', '5', '南海区', 'Nanhai District', '');
INSERT INTO `feel_region` VALUES (1723, '1', '44', '6', '6', '顺德区', 'Shunde', '');
INSERT INTO `feel_region` VALUES (1724, '1', '44', '6', '7', '三水区', 'Sanshui District', '');
INSERT INTO `feel_region` VALUES (1725, '1', '44', '6', '8', '高明区', 'Gaoming District', '');
INSERT INTO `feel_region` VALUES (1726, '1', '44', '7', '3', '蓬江区', 'Pengjiang District', '');
INSERT INTO `feel_region` VALUES (1727, '1', '44', '7', '4', '江海区', 'Jianghai District', '');
INSERT INTO `feel_region` VALUES (1728, '1', '44', '7', '5', '新会区', 'Xinhui District', '');
INSERT INTO `feel_region` VALUES (1729, '1', '44', '7', '81', '台山市', 'Taishan City', '');
INSERT INTO `feel_region` VALUES (1730, '1', '44', '7', '83', '开平市', 'Kaiping City', '');
INSERT INTO `feel_region` VALUES (1731, '1', '44', '7', '84', '鹤山市', 'Heshan City', '');
INSERT INTO `feel_region` VALUES (1732, '1', '44', '7', '85', '恩平市', 'Enping City', '');
INSERT INTO `feel_region` VALUES (1733, '1', '44', '8', '2', '赤坎区', 'Chikan District', '');
INSERT INTO `feel_region` VALUES (1734, '1', '44', '8', '3', '霞山区', 'Xiashan District', '');
INSERT INTO `feel_region` VALUES (1735, '1', '44', '8', '4', '坡头区', 'Potou District', '');
INSERT INTO `feel_region` VALUES (1736, '1', '44', '8', '11', '麻章区', 'Mazhang District', '');
INSERT INTO `feel_region` VALUES (1737, '1', '44', '8', '23', '遂溪县', 'Tunxi County', '');
INSERT INTO `feel_region` VALUES (1738, '1', '44', '8', '25', '徐闻县', 'Xuwen County', '');
INSERT INTO `feel_region` VALUES (1739, '1', '44', '8', '81', '廉江市', 'Lianjiang City', '');
INSERT INTO `feel_region` VALUES (1740, '1', '44', '8', '82', '雷州市', 'Leizhou', '');
INSERT INTO `feel_region` VALUES (1741, '1', '44', '8', '83', '吴川市', 'Wuchuan City', '');
INSERT INTO `feel_region` VALUES (1742, '1', '44', '9', '2', '茂南区', 'Maonan District', '');
INSERT INTO `feel_region` VALUES (1743, '1', '44', '9', '3', '茂港区', 'Maogang District', '');
INSERT INTO `feel_region` VALUES (1744, '1', '44', '9', '23', '电白县', 'Dianbai County', '');
INSERT INTO `feel_region` VALUES (1745, '1', '44', '9', '81', '高州市', 'Gaozhou', '');
INSERT INTO `feel_region` VALUES (1746, '1', '44', '9', '82', '化州市', 'Huazhou City', '');
INSERT INTO `feel_region` VALUES (1747, '1', '44', '9', '83', '信宜市', 'Xinyi City', '');
INSERT INTO `feel_region` VALUES (1748, '1', '44', '12', '2', '端州区', 'Duanzhou District', '');
INSERT INTO `feel_region` VALUES (1749, '1', '44', '12', '3', '鼎湖区', 'Dinghu District', '');
INSERT INTO `feel_region` VALUES (1750, '1', '44', '12', '23', '广宁县', 'Guangning County', '');
INSERT INTO `feel_region` VALUES (1751, '1', '44', '12', '24', '怀集县', 'Huaiji County', '');
INSERT INTO `feel_region` VALUES (1752, '1', '44', '12', '25', '封开县', 'Fengkai County', '');
INSERT INTO `feel_region` VALUES (1753, '1', '44', '12', '26', '德庆县', 'Deqing County', '');
INSERT INTO `feel_region` VALUES (1754, '1', '44', '12', '83', '高要市', 'Gaoyao City', '');
INSERT INTO `feel_region` VALUES (1755, '1', '44', '12', '84', '四会市', 'Sihui City', '');
INSERT INTO `feel_region` VALUES (1756, '1', '44', '13', '2', '惠城区', 'Huicheng District', '');
INSERT INTO `feel_region` VALUES (1757, '1', '44', '13', '3', '惠阳区', 'Huiyang District', '');
INSERT INTO `feel_region` VALUES (1758, '1', '44', '13', '22', '博罗县', 'Boluo County', '');
INSERT INTO `feel_region` VALUES (1759, '1', '44', '13', '23', '惠东县', 'Huidong County', '');
INSERT INTO `feel_region` VALUES (1760, '1', '44', '13', '24', '龙门县', 'Longmen County', '');
INSERT INTO `feel_region` VALUES (1761, '1', '44', '14', '2', '梅江区', 'Meijiang District', '');
INSERT INTO `feel_region` VALUES (1762, '1', '44', '14', '21', '梅　县', 'Mei County', '');
INSERT INTO `feel_region` VALUES (1763, '1', '44', '14', '22', '大埔县', 'Dapu County', '');
INSERT INTO `feel_region` VALUES (1764, '1', '44', '14', '23', '丰顺县', 'Fengshun County', '');
INSERT INTO `feel_region` VALUES (1765, '1', '44', '14', '24', '五华县', 'Wuhua County', '');
INSERT INTO `feel_region` VALUES (1766, '1', '44', '14', '26', '平远县', 'Pingyuan County', '');
INSERT INTO `feel_region` VALUES (1767, '1', '44', '14', '27', '蕉岭县', 'Jiaoling County', '');
INSERT INTO `feel_region` VALUES (1768, '1', '44', '14', '81', '兴宁市', 'Xingning City', '');
INSERT INTO `feel_region` VALUES (1769, '1', '44', '15', '2', '城　区', 'City area', '');
INSERT INTO `feel_region` VALUES (1770, '1', '44', '15', '21', '海丰县', 'Haifeng County', '');
INSERT INTO `feel_region` VALUES (1771, '1', '44', '15', '23', '陆河县', 'Luhe County', '');
INSERT INTO `feel_region` VALUES (1772, '1', '44', '15', '81', '陆丰市', 'Lufeng City', '');
INSERT INTO `feel_region` VALUES (1773, '1', '44', '16', '2', '源城区', 'Source city', '');
INSERT INTO `feel_region` VALUES (1774, '1', '44', '16', '21', '紫金县', 'Zijin County', '');
INSERT INTO `feel_region` VALUES (1775, '1', '44', '16', '22', '龙川县', 'Longchuan County', '');
INSERT INTO `feel_region` VALUES (1776, '1', '44', '16', '23', '连平县', 'Lianping County', '');
INSERT INTO `feel_region` VALUES (1777, '1', '44', '16', '24', '和平县', 'Peace County', '');
INSERT INTO `feel_region` VALUES (1778, '1', '44', '16', '25', '东源县', 'Dongyuan County', '');
INSERT INTO `feel_region` VALUES (1779, '1', '44', '17', '2', '江城区', 'Jiangcheng District', '');
INSERT INTO `feel_region` VALUES (1780, '1', '44', '17', '21', '阳西县', 'Yangxi County', '');
INSERT INTO `feel_region` VALUES (1781, '1', '44', '17', '23', '阳东县', 'Yangdong County', '');
INSERT INTO `feel_region` VALUES (1782, '1', '44', '17', '81', '阳春市', 'Yangchun City', '');
INSERT INTO `feel_region` VALUES (1783, '1', '44', '18', '2', '清城区', 'Qingcheng District', '');
INSERT INTO `feel_region` VALUES (1784, '1', '44', '18', '21', '佛冈县', 'Fogang County', '');
INSERT INTO `feel_region` VALUES (1785, '1', '44', '18', '23', '阳山县', 'Yangshan County', '');
INSERT INTO `feel_region` VALUES (1786, '1', '44', '18', '25', '连山壮族瑶族自治县', 'Lianshan Zhuang and Yao Autonomous County', '');
INSERT INTO `feel_region` VALUES (1787, '1', '44', '18', '26', '连南瑶族自治县', 'Liannan Yao Autonomous County', '');
INSERT INTO `feel_region` VALUES (1788, '1', '44', '18', '27', '清新县', 'Qingxin County', '');
INSERT INTO `feel_region` VALUES (1789, '1', '44', '18', '81', '英德市', 'Yingde City', '');
INSERT INTO `feel_region` VALUES (1790, '1', '44', '18', '82', '连州市', 'Lianzhou City', '');
INSERT INTO `feel_region` VALUES (1791, '1', '44', '19', '0', '东莞市', 'Dongguan city', '');
INSERT INTO `feel_region` VALUES (1792, '1', '44', '20', '0', '中山市', 'Zhongshan City', '');
INSERT INTO `feel_region` VALUES (1793, '1', '44', '51', '2', '湘桥区', 'Xiangqiao District', '');
INSERT INTO `feel_region` VALUES (1794, '1', '44', '51', '21', '潮安县', 'Chao\'an County', '');
INSERT INTO `feel_region` VALUES (1795, '1', '44', '51', '22', '饶平县', 'Raoping County', '');
INSERT INTO `feel_region` VALUES (1796, '1', '44', '52', '2', '榕城区', 'Wucheng District', '');
INSERT INTO `feel_region` VALUES (1797, '1', '44', '52', '21', '揭东县', 'Jiedong County', '');
INSERT INTO `feel_region` VALUES (1798, '1', '44', '52', '22', '揭西县', 'Jiexi County', '');
INSERT INTO `feel_region` VALUES (1799, '1', '44', '52', '24', '惠来县', 'Huilai County', '');
INSERT INTO `feel_region` VALUES (1800, '1', '44', '52', '81', '普宁市', 'Puning City', '');
INSERT INTO `feel_region` VALUES (1801, '1', '44', '53', '2', '云城区', 'Yuncheng District', '');
INSERT INTO `feel_region` VALUES (1802, '1', '44', '53', '21', '新兴县', 'Xinxing County', '');
INSERT INTO `feel_region` VALUES (1803, '1', '44', '53', '22', '郁南县', 'Yunan County', '');
INSERT INTO `feel_region` VALUES (1804, '1', '44', '53', '23', '云安县', 'Yun\'an County', '');
INSERT INTO `feel_region` VALUES (1805, '1', '44', '53', '81', '罗定市', 'Luoding City', '');
INSERT INTO `feel_region` VALUES (1806, '1', '45', '1', '2', '兴宁区', 'Xingning District', '');
INSERT INTO `feel_region` VALUES (1807, '1', '45', '1', '3', '青秀区', 'Qingxiu District', '');
INSERT INTO `feel_region` VALUES (1808, '1', '45', '1', '5', '江南区', 'Jiangnan District', '');
INSERT INTO `feel_region` VALUES (1809, '1', '45', '1', '7', '西乡塘区', 'Xixiangtang District', '');
INSERT INTO `feel_region` VALUES (1810, '1', '45', '1', '8', '良庆区', 'Liangqing District', '');
INSERT INTO `feel_region` VALUES (1811, '1', '45', '1', '9', '邕宁区', 'Suining District', '');
INSERT INTO `feel_region` VALUES (1812, '1', '45', '1', '22', '武鸣县', 'Wuming County', '');
INSERT INTO `feel_region` VALUES (1813, '1', '45', '1', '23', '隆安县', 'Longan County', '');
INSERT INTO `feel_region` VALUES (1814, '1', '45', '1', '24', '马山县', 'Mashan County', '');
INSERT INTO `feel_region` VALUES (1815, '1', '45', '1', '25', '上林县', 'Shanglin County', '');
INSERT INTO `feel_region` VALUES (1816, '1', '45', '1', '26', '宾阳县', 'Binyang County', '');
INSERT INTO `feel_region` VALUES (1817, '1', '45', '1', '27', '横　县', 'Heng County', '');
INSERT INTO `feel_region` VALUES (1818, '1', '45', '2', '2', '城中区', 'Chengzhong District', '');
INSERT INTO `feel_region` VALUES (1819, '1', '45', '2', '3', '鱼峰区', 'Yufeng District', '');
INSERT INTO `feel_region` VALUES (1820, '1', '45', '2', '4', '柳南区', 'Liunan District', '');
INSERT INTO `feel_region` VALUES (1821, '1', '45', '2', '5', '柳北区', 'Liubei District', '');
INSERT INTO `feel_region` VALUES (1822, '1', '45', '2', '21', '柳江县', 'Liujiang County', '');
INSERT INTO `feel_region` VALUES (1823, '1', '45', '2', '22', '柳城县', 'Liucheng County', '');
INSERT INTO `feel_region` VALUES (1824, '1', '45', '2', '23', '鹿寨县', 'Luzhai County', '');
INSERT INTO `feel_region` VALUES (1825, '1', '45', '2', '24', '融安县', 'Rong\'an County', '');
INSERT INTO `feel_region` VALUES (1826, '1', '45', '2', '25', '融水苗族自治县', 'Rongshui Miao Autonomous County', '');
INSERT INTO `feel_region` VALUES (1827, '1', '45', '2', '26', '三江侗族自治县', 'Sanjiang Dong Autonomous County', '');
INSERT INTO `feel_region` VALUES (1828, '1', '45', '3', '2', '秀峰区', 'Xiufeng District', '');
INSERT INTO `feel_region` VALUES (1829, '1', '45', '3', '3', '叠彩区', 'Stacking area', '');
INSERT INTO `feel_region` VALUES (1830, '1', '45', '3', '4', '象山区', 'Elephant mountain', '');
INSERT INTO `feel_region` VALUES (1831, '1', '45', '3', '5', '七星区', 'Qixing District', '');
INSERT INTO `feel_region` VALUES (1832, '1', '45', '3', '11', '雁山区', 'Yanshan District', '');
INSERT INTO `feel_region` VALUES (1833, '1', '45', '3', '21', '阳朔县', 'Yangshuo County', '');
INSERT INTO `feel_region` VALUES (1834, '1', '45', '3', '22', '临桂县', 'Lingui County', '');
INSERT INTO `feel_region` VALUES (1835, '1', '45', '3', '23', '灵川县', 'Lingchuan County', '');
INSERT INTO `feel_region` VALUES (1836, '1', '45', '3', '24', '全州县', 'Quanzhou County', '');
INSERT INTO `feel_region` VALUES (1837, '1', '45', '3', '25', '兴安县', 'Xing\'an County', '');
INSERT INTO `feel_region` VALUES (1838, '1', '45', '3', '26', '永福县', 'Yongfu County', '');
INSERT INTO `feel_region` VALUES (1839, '1', '45', '3', '27', '灌阳县', 'Guanyang County', '');
INSERT INTO `feel_region` VALUES (1840, '1', '45', '3', '28', '龙胜各族自治县', 'Longsheng County', '');
INSERT INTO `feel_region` VALUES (1841, '1', '45', '3', '29', '资源县', 'Resource county', '');
INSERT INTO `feel_region` VALUES (1842, '1', '45', '3', '30', '平乐县', 'Pingle County', '');
INSERT INTO `feel_region` VALUES (1843, '1', '45', '3', '31', '荔浦县', 'Zhangpu County', '');
INSERT INTO `feel_region` VALUES (1844, '1', '45', '3', '32', '恭城瑶族自治县', 'Gongcheng Yao Autonomous County', '');
INSERT INTO `feel_region` VALUES (1845, '1', '45', '4', '3', '万秀区', 'Wanxiu District', '');
INSERT INTO `feel_region` VALUES (1846, '1', '45', '4', '4', '蝶山区', 'Dieshan District', '');
INSERT INTO `feel_region` VALUES (1847, '1', '45', '4', '5', '长洲区', 'Changzhou District', '');
INSERT INTO `feel_region` VALUES (1848, '1', '45', '4', '21', '苍梧县', 'Cangwu County', '');
INSERT INTO `feel_region` VALUES (1849, '1', '45', '4', '22', '藤　县', 'Teng County', '');
INSERT INTO `feel_region` VALUES (1850, '1', '45', '4', '23', '蒙山县', 'Mengshan County', '');
INSERT INTO `feel_region` VALUES (1851, '1', '45', '4', '81', '岑溪市', 'Cenxi City', '');
INSERT INTO `feel_region` VALUES (1852, '1', '45', '5', '2', '海城区', 'Haicheng District', '');
INSERT INTO `feel_region` VALUES (1853, '1', '45', '5', '3', '银海区', 'Yinhai District', '');
INSERT INTO `feel_region` VALUES (1854, '1', '45', '5', '12', '铁山港区', 'Tieshan Port Area', '');
INSERT INTO `feel_region` VALUES (1855, '1', '45', '5', '21', '合浦县', 'Hepu County', '');
INSERT INTO `feel_region` VALUES (1856, '1', '45', '6', '2', '港口区', 'Port area', '');
INSERT INTO `feel_region` VALUES (1857, '1', '45', '6', '3', '防城区', 'Fangcheng District', '');
INSERT INTO `feel_region` VALUES (1858, '1', '45', '6', '21', '上思县', 'Shangsi County', '');
INSERT INTO `feel_region` VALUES (1859, '1', '45', '6', '81', '东兴市', 'Dongxing City', '');
INSERT INTO `feel_region` VALUES (1860, '1', '45', '7', '2', '钦南区', 'Qinnan District', '');
INSERT INTO `feel_region` VALUES (1861, '1', '45', '7', '3', '钦北区', 'Qinbei District', '');
INSERT INTO `feel_region` VALUES (1862, '1', '45', '7', '21', '灵山县', 'Lingshan County', '');
INSERT INTO `feel_region` VALUES (1863, '1', '45', '7', '22', '浦北县', 'Pubei County', '');
INSERT INTO `feel_region` VALUES (1864, '1', '45', '8', '2', '港北区', 'Kohoku Ward', '');
INSERT INTO `feel_region` VALUES (1865, '1', '45', '8', '3', '港南区', 'Konan Ward', '');
INSERT INTO `feel_region` VALUES (1866, '1', '45', '8', '4', '覃塘区', 'Qiangtang District', '');
INSERT INTO `feel_region` VALUES (1867, '1', '45', '8', '21', '平南县', 'Pingnan County', '');
INSERT INTO `feel_region` VALUES (1868, '1', '45', '8', '81', '桂平市', 'Guiping City', '');
INSERT INTO `feel_region` VALUES (1869, '1', '45', '9', '2', '玉州区', 'Yuzhou District', '');
INSERT INTO `feel_region` VALUES (1870, '1', '45', '9', '21', '容　县', 'Rong County', '');
INSERT INTO `feel_region` VALUES (1871, '1', '45', '9', '22', '陆川县', 'Luchuan County', '');
INSERT INTO `feel_region` VALUES (1872, '1', '45', '9', '23', '博白县', 'Bobai County', '');
INSERT INTO `feel_region` VALUES (1873, '1', '45', '9', '24', '兴业县', 'Xingye County', '');
INSERT INTO `feel_region` VALUES (1874, '1', '45', '9', '81', '北流市', 'Beiliu City', '');
INSERT INTO `feel_region` VALUES (1875, '1', '45', '10', '2', '右江区', 'Youjiang District', '');
INSERT INTO `feel_region` VALUES (1876, '1', '45', '10', '21', '田阳县', 'Tianyang County', '');
INSERT INTO `feel_region` VALUES (1877, '1', '45', '10', '22', '田东县', 'Tiandong County', '');
INSERT INTO `feel_region` VALUES (1878, '1', '45', '10', '23', '平果县', 'Pingguo County', '');
INSERT INTO `feel_region` VALUES (1879, '1', '45', '10', '24', '德保县', 'Debao County', '');
INSERT INTO `feel_region` VALUES (1880, '1', '45', '10', '25', '靖西县', 'Jingxi County', '');
INSERT INTO `feel_region` VALUES (1881, '1', '45', '10', '26', '那坡县', 'Napo County', '');
INSERT INTO `feel_region` VALUES (1882, '1', '45', '10', '27', '凌云县', 'Lingyun County', '');
INSERT INTO `feel_region` VALUES (1883, '1', '45', '10', '28', '乐业县', 'Leye County', '');
INSERT INTO `feel_region` VALUES (1884, '1', '45', '10', '29', '田林县', 'Tianlin County', '');
INSERT INTO `feel_region` VALUES (1885, '1', '45', '10', '30', '西林县', 'Xilin County', '');
INSERT INTO `feel_region` VALUES (1886, '1', '45', '10', '31', '隆林各族自治县', 'Longlin County', '');
INSERT INTO `feel_region` VALUES (1887, '1', '45', '11', '2', '八步区', 'Eight steps', '');
INSERT INTO `feel_region` VALUES (1888, '1', '45', '11', '21', '昭平县', 'Zhaoping County', '');
INSERT INTO `feel_region` VALUES (1889, '1', '45', '11', '22', '钟山县', 'Zhongshan County', '');
INSERT INTO `feel_region` VALUES (1890, '1', '45', '11', '23', '富川瑶族自治县', 'Fuchuan Yao Autonomous County', '');
INSERT INTO `feel_region` VALUES (1891, '1', '45', '12', '2', '金城江区', 'Jinchengjiang District', '');
INSERT INTO `feel_region` VALUES (1892, '1', '45', '12', '21', '南丹县', 'Nandan County', '');
INSERT INTO `feel_region` VALUES (1893, '1', '45', '12', '22', '天峨县', 'Tianzhu County', '');
INSERT INTO `feel_region` VALUES (1894, '1', '45', '12', '23', '凤山县', 'Fengshan County', '');
INSERT INTO `feel_region` VALUES (1895, '1', '45', '12', '24', '东兰县', 'Donglan County', '');
INSERT INTO `feel_region` VALUES (1896, '1', '45', '12', '25', '罗城仫佬族自治县', 'Luocheng Yi Autonomous County', '');
INSERT INTO `feel_region` VALUES (1897, '1', '45', '12', '26', '环江毛南族自治县', 'Huanjiang Maonan Autonomous County', '');
INSERT INTO `feel_region` VALUES (1898, '1', '45', '12', '27', '巴马瑶族自治县', 'Bama Yao Autonomous County', '');
INSERT INTO `feel_region` VALUES (1899, '1', '45', '12', '28', '都安瑶族自治县', 'Du\'an Yao Autonomous County', '');
INSERT INTO `feel_region` VALUES (1900, '1', '45', '12', '29', '大化瑶族自治县', 'Dahua Yao Autonomous County', '');
INSERT INTO `feel_region` VALUES (1901, '1', '45', '12', '81', '宜州市', 'Yizhou City', '');
INSERT INTO `feel_region` VALUES (1902, '1', '45', '13', '2', '兴宾区', 'Xingbin District', '');
INSERT INTO `feel_region` VALUES (1903, '1', '45', '13', '21', '忻城县', 'Yucheng County', '');
INSERT INTO `feel_region` VALUES (1904, '1', '45', '13', '22', '象州县', 'Xiangzhou County', '');
INSERT INTO `feel_region` VALUES (1905, '1', '45', '13', '23', '武宣县', 'Wuxuan County', '');
INSERT INTO `feel_region` VALUES (1906, '1', '45', '13', '24', '金秀瑶族自治县', 'Jinxiu Yao Autonomous County', '');
INSERT INTO `feel_region` VALUES (1907, '1', '45', '13', '81', '合山市', 'Heshan City', '');
INSERT INTO `feel_region` VALUES (1908, '1', '45', '14', '2', '江洲区', 'Jiangzhou District', '');
INSERT INTO `feel_region` VALUES (1909, '1', '45', '14', '21', '扶绥县', 'Fusui County', '');
INSERT INTO `feel_region` VALUES (1910, '1', '45', '14', '22', '宁明县', 'Ningming County', '');
INSERT INTO `feel_region` VALUES (1911, '1', '45', '14', '23', '龙州县', 'Longzhou County', '');
INSERT INTO `feel_region` VALUES (1912, '1', '45', '14', '24', '大新县', 'Daxin County', '');
INSERT INTO `feel_region` VALUES (1913, '1', '45', '14', '25', '天等县', 'Tian County', '');
INSERT INTO `feel_region` VALUES (1914, '1', '45', '14', '81', '凭祥市', 'Pingxiang City', '');
INSERT INTO `feel_region` VALUES (1915, '1', '46', '1', '5', '秀英区', 'Xiuying District', '');
INSERT INTO `feel_region` VALUES (1916, '1', '46', '1', '6', '龙华区', 'Longhua District', '');
INSERT INTO `feel_region` VALUES (1917, '1', '46', '1', '8', '美兰区', 'Meilan District', '');
INSERT INTO `feel_region` VALUES (1918, '1', '51', '1', '4', '锦江区', 'Jinjiang District', '');
INSERT INTO `feel_region` VALUES (1919, '1', '51', '1', '5', '青羊区', 'Qingyang District', '');
INSERT INTO `feel_region` VALUES (1920, '1', '51', '1', '6', '金牛区', 'Jinniu District', '');
INSERT INTO `feel_region` VALUES (1921, '1', '51', '1', '7', '武侯区', 'Wuhou District', '');
INSERT INTO `feel_region` VALUES (1922, '1', '51', '1', '8', '成华区', 'Chenghua District', '');
INSERT INTO `feel_region` VALUES (1923, '1', '51', '1', '9', '高新区', 'High-tech Zone', '');
INSERT INTO `feel_region` VALUES (1924, '1', '51', '1', '10', '天府新区', 'Tianfu New District', '');
INSERT INTO `feel_region` VALUES (1925, '1', '51', '1', '11', '龙泉驿区', 'Longquanyi District', '');
INSERT INTO `feel_region` VALUES (1926, '1', '51', '1', '12', '青白江区', 'Qingbaijiang District', '');
INSERT INTO `feel_region` VALUES (1927, '1', '51', '1', '13', '新都区', 'Xindu District', '');
INSERT INTO `feel_region` VALUES (1928, '1', '51', '1', '14', '温江区', 'Wenjiang District', '');
INSERT INTO `feel_region` VALUES (1929, '1', '51', '1', '21', '金堂县', 'Jintang County', '');
INSERT INTO `feel_region` VALUES (1930, '1', '51', '1', '22', '双流区', 'Double flow zone', '');
INSERT INTO `feel_region` VALUES (1931, '1', '51', '1', '24', '郫都区', 'Batu District', '');
INSERT INTO `feel_region` VALUES (1932, '1', '51', '1', '29', '大邑县', 'Dayi County', '');
INSERT INTO `feel_region` VALUES (1933, '1', '51', '1', '31', '蒲江县', 'Pujiang County', '');
INSERT INTO `feel_region` VALUES (1934, '1', '51', '1', '32', '新津县', 'Xinjin County', '');
INSERT INTO `feel_region` VALUES (1935, '1', '51', '1', '81', '都江堰市', 'Dujiangyan City', '');
INSERT INTO `feel_region` VALUES (1936, '1', '51', '1', '82', '彭州市', 'Pengzhou City', '');
INSERT INTO `feel_region` VALUES (1937, '1', '51', '1', '83', '邛崃市', 'Handan City', '');
INSERT INTO `feel_region` VALUES (1938, '1', '51', '1', '84', '崇州市', 'Chongzhou City', '');
INSERT INTO `feel_region` VALUES (1939, '1', '51', '3', '2', '自流井区', 'Artesian well area', '');
INSERT INTO `feel_region` VALUES (1940, '1', '51', '3', '3', '贡井区', 'Gongjing District', '');
INSERT INTO `feel_region` VALUES (1941, '1', '51', '3', '4', '大安区', 'Daan District', '');
INSERT INTO `feel_region` VALUES (1942, '1', '51', '3', '11', '沿滩区', 'Along the beach area', '');
INSERT INTO `feel_region` VALUES (1943, '1', '51', '3', '21', '荣　县', 'Rong County', '');
INSERT INTO `feel_region` VALUES (1944, '1', '51', '3', '22', '富顺县', 'Fushun County', '');
INSERT INTO `feel_region` VALUES (1945, '1', '51', '4', '2', '东　区', 'Eastern District', '');
INSERT INTO `feel_region` VALUES (1946, '1', '51', '4', '3', '西　区', 'West District', '');
INSERT INTO `feel_region` VALUES (1947, '1', '51', '4', '11', '仁和区', 'Ninwa district', '');
INSERT INTO `feel_region` VALUES (1948, '1', '51', '4', '21', '米易县', 'Miyi County', '');
INSERT INTO `feel_region` VALUES (1949, '1', '51', '4', '22', '盐边县', 'Yanbian County', '');
INSERT INTO `feel_region` VALUES (1950, '1', '51', '5', '2', '江阳区', 'Jiangyang District', '');
INSERT INTO `feel_region` VALUES (1951, '1', '51', '5', '3', '纳溪区', 'Naxi District', '');
INSERT INTO `feel_region` VALUES (1952, '1', '51', '5', '4', '龙马潭区', 'Longmatan District', '');
INSERT INTO `feel_region` VALUES (1953, '1', '51', '5', '21', '泸　县', '县 County', '');
INSERT INTO `feel_region` VALUES (1954, '1', '51', '5', '22', '合江县', 'Hejiang County', '');
INSERT INTO `feel_region` VALUES (1955, '1', '51', '5', '24', '叙永县', 'Xuyong County', '');
INSERT INTO `feel_region` VALUES (1956, '1', '51', '5', '25', '古蔺县', 'Gulin County', '');
INSERT INTO `feel_region` VALUES (1957, '1', '51', '6', '3', '旌阳区', 'Yuyang District', '');
INSERT INTO `feel_region` VALUES (1958, '1', '51', '6', '23', '中江县', 'Zhongjiang County', '');
INSERT INTO `feel_region` VALUES (1959, '1', '51', '6', '26', '罗江县', 'Luojiang County', '');
INSERT INTO `feel_region` VALUES (1960, '1', '51', '6', '81', '广汉市', 'Guanghan City', '');
INSERT INTO `feel_region` VALUES (1961, '1', '51', '6', '82', '什邡市', 'Shifang City', '');
INSERT INTO `feel_region` VALUES (1962, '1', '51', '6', '83', '绵竹市', 'Mianzhu City', '');
INSERT INTO `feel_region` VALUES (1963, '1', '51', '7', '3', '涪城区', 'Wucheng District', '');
INSERT INTO `feel_region` VALUES (1964, '1', '51', '7', '4', '游仙区', 'Youxian District', '');
INSERT INTO `feel_region` VALUES (1965, '1', '51', '7', '22', '三台县', 'Santai County', '');
INSERT INTO `feel_region` VALUES (1966, '1', '51', '7', '23', '盐亭县', 'Yanting County', '');
INSERT INTO `feel_region` VALUES (1967, '1', '51', '7', '24', '安　县', 'An County', '');
INSERT INTO `feel_region` VALUES (1968, '1', '51', '7', '25', '梓潼县', 'Ji County', '');
INSERT INTO `feel_region` VALUES (1969, '1', '51', '7', '26', '北川羌族自治县', 'Beichuan Yi Autonomous County', '');
INSERT INTO `feel_region` VALUES (1970, '1', '51', '7', '27', '平武县', 'Pingwu County', '');
INSERT INTO `feel_region` VALUES (1971, '1', '51', '7', '81', '江油市', 'Jiangyou City', '');
INSERT INTO `feel_region` VALUES (1972, '1', '51', '8', '2', '市中区', 'Central District', '');
INSERT INTO `feel_region` VALUES (1973, '1', '51', '8', '11', '元坝区', 'Yuanba District', '');
INSERT INTO `feel_region` VALUES (1974, '1', '51', '8', '12', '朝天区', 'Chaotian District', '');
INSERT INTO `feel_region` VALUES (1975, '1', '51', '8', '21', '旺苍县', 'Wangcang County', '');
INSERT INTO `feel_region` VALUES (1976, '1', '51', '8', '22', '青川县', 'Qingchuan County', '');
INSERT INTO `feel_region` VALUES (1977, '1', '51', '8', '23', '剑阁县', 'Jiange County', '');
INSERT INTO `feel_region` VALUES (1978, '1', '51', '8', '24', '苍溪县', 'Cangxi County', '');
INSERT INTO `feel_region` VALUES (1979, '1', '51', '9', '3', '船山区', 'Ship mountain', '');
INSERT INTO `feel_region` VALUES (1980, '1', '51', '9', '4', '安居区', 'Anju District', '');
INSERT INTO `feel_region` VALUES (1981, '1', '51', '9', '21', '蓬溪县', 'Pengxi County', '');
INSERT INTO `feel_region` VALUES (1982, '1', '51', '9', '22', '射洪县', 'Shehong County', '');
INSERT INTO `feel_region` VALUES (1983, '1', '51', '9', '23', '大英县', 'Daying County', '');
INSERT INTO `feel_region` VALUES (1984, '1', '51', '10', '2', '市中区', 'Central District', '');
INSERT INTO `feel_region` VALUES (1985, '1', '51', '10', '11', '东兴区', 'Dongxing District', '');
INSERT INTO `feel_region` VALUES (1986, '1', '51', '10', '24', '威远县', 'Weiyuan County', '');
INSERT INTO `feel_region` VALUES (1987, '1', '51', '10', '25', '资中县', 'Zizhong County', '');
INSERT INTO `feel_region` VALUES (1988, '1', '51', '10', '28', '隆昌县', 'Longchang County', '');
INSERT INTO `feel_region` VALUES (1989, '1', '51', '11', '2', '市中区', 'Central District', '');
INSERT INTO `feel_region` VALUES (1990, '1', '51', '11', '11', '沙湾区', 'Shawan District', '');
INSERT INTO `feel_region` VALUES (1991, '1', '51', '11', '12', '五通桥区', 'Wutongqiao District', '');
INSERT INTO `feel_region` VALUES (1992, '1', '51', '11', '13', '金口河区', 'Jinkouhe District', '');
INSERT INTO `feel_region` VALUES (1993, '1', '51', '11', '23', '犍为县', 'Qianwei County', '');
INSERT INTO `feel_region` VALUES (1994, '1', '51', '11', '24', '井研县', 'Jingyan County', '');
INSERT INTO `feel_region` VALUES (1995, '1', '51', '11', '26', '夹江县', 'Jiajiang County', '');
INSERT INTO `feel_region` VALUES (1996, '1', '51', '11', '29', '沐川县', 'Muchuan County', '');
INSERT INTO `feel_region` VALUES (1997, '1', '51', '11', '32', '峨边彝族自治县', 'Yibian Yi Autonomous County', '');
INSERT INTO `feel_region` VALUES (1998, '1', '51', '11', '33', '马边彝族自治县', 'Mabian Yi Autonomous County', '');
INSERT INTO `feel_region` VALUES (1999, '1', '51', '11', '81', '峨眉山市', 'Emeishan City', '');
INSERT INTO `feel_region` VALUES (2000, '1', '51', '13', '2', '顺庆区', 'Shunqing District', '');
INSERT INTO `feel_region` VALUES (2001, '1', '51', '13', '3', '高坪区', 'Gaoping District', '');
INSERT INTO `feel_region` VALUES (2002, '1', '51', '13', '4', '嘉陵区', 'Jialing District', '');
INSERT INTO `feel_region` VALUES (2003, '1', '51', '13', '21', '南部县', 'Southern County', '');
INSERT INTO `feel_region` VALUES (2004, '1', '51', '13', '22', '营山县', 'Yingshan County', '');
INSERT INTO `feel_region` VALUES (2005, '1', '51', '13', '23', '蓬安县', 'Peng\'an County', '');
INSERT INTO `feel_region` VALUES (2006, '1', '51', '13', '24', '仪陇县', 'Yilong County', '');
INSERT INTO `feel_region` VALUES (2007, '1', '51', '13', '25', '西充县', 'Xichong County', '');
INSERT INTO `feel_region` VALUES (2008, '1', '51', '13', '81', '阆中市', 'Langzhong City', '');
INSERT INTO `feel_region` VALUES (2009, '1', '51', '14', '2', '东坡区', 'Dongpo District', '');
INSERT INTO `feel_region` VALUES (2010, '1', '51', '14', '21', '仁寿县', 'Renshou County', '');
INSERT INTO `feel_region` VALUES (2011, '1', '51', '14', '22', '彭山县', 'Pengshan County', '');
INSERT INTO `feel_region` VALUES (2012, '1', '51', '14', '23', '洪雅县', 'Hongya County', '');
INSERT INTO `feel_region` VALUES (2013, '1', '51', '14', '24', '丹棱县', 'Danling County', '');
INSERT INTO `feel_region` VALUES (2014, '1', '51', '14', '25', '青神县', 'Qingshen County', '');
INSERT INTO `feel_region` VALUES (2015, '1', '51', '15', '2', '翠屏区', 'Cuiping District', '');
INSERT INTO `feel_region` VALUES (2016, '1', '51', '15', '21', '宜宾县', 'Yibin County', '');
INSERT INTO `feel_region` VALUES (2017, '1', '51', '15', '22', '南溪县', 'Nanxi County', '');
INSERT INTO `feel_region` VALUES (2018, '1', '51', '15', '23', '江安县', 'Jiang\'an County', '');
INSERT INTO `feel_region` VALUES (2019, '1', '51', '15', '24', '长宁县', 'Changning County', '');
INSERT INTO `feel_region` VALUES (2020, '1', '51', '15', '25', '高　县', 'Gao County', '');
INSERT INTO `feel_region` VALUES (2021, '1', '51', '15', '26', '珙　县', 'Gong County', '');
INSERT INTO `feel_region` VALUES (2022, '1', '51', '15', '27', '筠连县', 'Qilian County', '');
INSERT INTO `feel_region` VALUES (2023, '1', '51', '15', '28', '兴文县', 'Xingwen County', '');
INSERT INTO `feel_region` VALUES (2024, '1', '51', '15', '29', '屏山县', 'Pingshan County', '');
INSERT INTO `feel_region` VALUES (2025, '1', '51', '16', '2', '广安区', 'Guang\'an District', '');
INSERT INTO `feel_region` VALUES (2026, '1', '51', '16', '21', '岳池县', 'Yuechi County', '');
INSERT INTO `feel_region` VALUES (2027, '1', '51', '16', '22', '武胜县', 'Wusheng County', '');
INSERT INTO `feel_region` VALUES (2028, '1', '51', '16', '23', '邻水县', 'Linshui County', '');
INSERT INTO `feel_region` VALUES (2029, '1', '51', '16', '81', '华蓥市', 'Huaying City', '');
INSERT INTO `feel_region` VALUES (2030, '1', '51', '17', '2', '通川区', 'Tongchuan District', '');
INSERT INTO `feel_region` VALUES (2031, '1', '51', '17', '21', '达　县', 'Da County', '');
INSERT INTO `feel_region` VALUES (2032, '1', '51', '17', '22', '宣汉县', 'Xuanhan County', '');
INSERT INTO `feel_region` VALUES (2033, '1', '51', '17', '23', '开江县', 'Kaijiang County', '');
INSERT INTO `feel_region` VALUES (2034, '1', '51', '17', '24', '大竹县', 'Dazhu County', '');
INSERT INTO `feel_region` VALUES (2035, '1', '51', '17', '25', '渠　县', 'Qu County', '');
INSERT INTO `feel_region` VALUES (2036, '1', '51', '17', '81', '万源市', 'Wanyuan City', '');
INSERT INTO `feel_region` VALUES (2037, '1', '51', '18', '2', '雨城区', 'Yucheng District', '');
INSERT INTO `feel_region` VALUES (2038, '1', '51', '18', '21', '名山县', 'Mingshan County', '');
INSERT INTO `feel_region` VALUES (2039, '1', '51', '18', '22', '荥经县', 'Yingjing County', '');
INSERT INTO `feel_region` VALUES (2040, '1', '51', '18', '23', '汉源县', 'Hanyuan County', '');
INSERT INTO `feel_region` VALUES (2041, '1', '51', '18', '24', '石棉县', 'Shimian County', '');
INSERT INTO `feel_region` VALUES (2042, '1', '51', '18', '25', '天全县', 'Tianquan County', '');
INSERT INTO `feel_region` VALUES (2043, '1', '51', '18', '26', '芦山县', 'Lushan County', '');
INSERT INTO `feel_region` VALUES (2044, '1', '51', '18', '27', '宝兴县', 'Baoxing County', '');
INSERT INTO `feel_region` VALUES (2045, '1', '51', '19', '2', '巴州区', 'Bazhou District', '');
INSERT INTO `feel_region` VALUES (2046, '1', '51', '19', '21', '通江县', 'Tongjiang County', '');
INSERT INTO `feel_region` VALUES (2047, '1', '51', '19', '22', '南江县', 'Nanjiang County', '');
INSERT INTO `feel_region` VALUES (2048, '1', '51', '19', '23', '平昌县', 'Pingchang County', '');
INSERT INTO `feel_region` VALUES (2049, '1', '51', '20', '2', '雁江区', 'Yanjiang District', '');
INSERT INTO `feel_region` VALUES (2050, '1', '51', '20', '21', '安岳县', 'Anyue County', '');
INSERT INTO `feel_region` VALUES (2051, '1', '51', '20', '22', '乐至县', 'Lezhi County', '');
INSERT INTO `feel_region` VALUES (2052, '1', '51', '20', '81', '简阳市', 'Jianyang City', '');
INSERT INTO `feel_region` VALUES (2053, '1', '51', '32', '21', '汶川县', 'Wenchuan County', '');
INSERT INTO `feel_region` VALUES (2054, '1', '51', '32', '22', '理　县', 'County', '');
INSERT INTO `feel_region` VALUES (2055, '1', '51', '32', '23', '茂　县', 'Mao County', '');
INSERT INTO `feel_region` VALUES (2056, '1', '51', '32', '24', '松潘县', 'Songpan County', '');
INSERT INTO `feel_region` VALUES (2057, '1', '51', '32', '25', '九寨沟县', 'Jiuzhaigou County', '');
INSERT INTO `feel_region` VALUES (2058, '1', '51', '32', '26', '金川县', 'Jinchuan County', '');
INSERT INTO `feel_region` VALUES (2059, '1', '51', '32', '27', '小金县', 'Xiaojin County', '');
INSERT INTO `feel_region` VALUES (2060, '1', '51', '32', '28', '黑水县', 'Heishui County', '');
INSERT INTO `feel_region` VALUES (2061, '1', '51', '32', '29', '马尔康县', 'Malcom County', '');
INSERT INTO `feel_region` VALUES (2062, '1', '51', '32', '30', '壤塘县', 'Litang County', '');
INSERT INTO `feel_region` VALUES (2063, '1', '51', '32', '31', '阿坝县', 'Aba County', '');
INSERT INTO `feel_region` VALUES (2064, '1', '51', '32', '32', '若尔盖县', 'Zoige County', '');
INSERT INTO `feel_region` VALUES (2065, '1', '51', '32', '33', '红原县', 'Hongyuan County', '');
INSERT INTO `feel_region` VALUES (2066, '1', '51', '33', '21', '康定县', 'Kangding County', '');
INSERT INTO `feel_region` VALUES (2067, '1', '51', '33', '22', '泸定县', 'Luding County', '');
INSERT INTO `feel_region` VALUES (2068, '1', '51', '33', '23', '丹巴县', 'Danba County', '');
INSERT INTO `feel_region` VALUES (2069, '1', '51', '33', '24', '九龙县', 'Jiulong County', '');
INSERT INTO `feel_region` VALUES (2070, '1', '51', '33', '25', '雅江县', 'Yajiang County', '');
INSERT INTO `feel_region` VALUES (2071, '1', '51', '33', '26', '道孚县', 'Daofu County', '');
INSERT INTO `feel_region` VALUES (2072, '1', '51', '33', '27', '炉霍县', 'Huohuo County', '');
INSERT INTO `feel_region` VALUES (2073, '1', '51', '33', '28', '甘孜县', 'Ganzi County', '');
INSERT INTO `feel_region` VALUES (2074, '1', '51', '33', '29', '新龙县', 'Xinlong County', '');
INSERT INTO `feel_region` VALUES (2075, '1', '51', '33', '30', '德格县', 'Dege County', '');
INSERT INTO `feel_region` VALUES (2076, '1', '51', '33', '31', '白玉县', 'Baiyu County', '');
INSERT INTO `feel_region` VALUES (2077, '1', '51', '33', '32', '石渠县', 'Shiqu County', '');
INSERT INTO `feel_region` VALUES (2078, '1', '51', '33', '33', '色达县', 'Seda County', '');
INSERT INTO `feel_region` VALUES (2079, '1', '51', '33', '34', '理塘县', 'Litang County', '');
INSERT INTO `feel_region` VALUES (2080, '1', '51', '33', '35', '巴塘县', 'Batang County', '');
INSERT INTO `feel_region` VALUES (2081, '1', '51', '33', '36', '乡城县', 'Xiangcheng County', '');
INSERT INTO `feel_region` VALUES (2082, '1', '51', '33', '37', '稻城县', 'Daocheng County', '');
INSERT INTO `feel_region` VALUES (2083, '1', '51', '33', '38', '得荣县', 'Derong County', '');
INSERT INTO `feel_region` VALUES (2084, '1', '51', '34', '1', '西昌市', 'Xichang City', '');
INSERT INTO `feel_region` VALUES (2085, '1', '51', '34', '22', '木里藏族自治县', 'Muli Tibetan Autonomous County', '');
INSERT INTO `feel_region` VALUES (2086, '1', '51', '34', '23', '盐源县', 'Yanyuan County', '');
INSERT INTO `feel_region` VALUES (2087, '1', '51', '34', '24', '德昌县', 'Dechang County', '');
INSERT INTO `feel_region` VALUES (2088, '1', '51', '34', '25', '会理县', 'Huili County', '');
INSERT INTO `feel_region` VALUES (2089, '1', '51', '34', '26', '会东县', 'Huidong County', '');
INSERT INTO `feel_region` VALUES (2090, '1', '51', '34', '27', '宁南县', 'Ningnan County', '');
INSERT INTO `feel_region` VALUES (2091, '1', '51', '34', '28', '普格县', 'Pug County', '');
INSERT INTO `feel_region` VALUES (2092, '1', '51', '34', '29', '布拖县', 'Butuo County', '');
INSERT INTO `feel_region` VALUES (2093, '1', '51', '34', '30', '金阳县', 'Jinyang County', '');
INSERT INTO `feel_region` VALUES (2094, '1', '51', '34', '31', '昭觉县', 'Zhaojue County', '');
INSERT INTO `feel_region` VALUES (2095, '1', '51', '34', '32', '喜德县', 'Xide County', '');
INSERT INTO `feel_region` VALUES (2096, '1', '51', '34', '33', '冕宁县', 'Suining County', '');
INSERT INTO `feel_region` VALUES (2097, '1', '51', '34', '34', '越西县', 'Yuexi County', '');
INSERT INTO `feel_region` VALUES (2098, '1', '51', '34', '35', '甘洛县', 'Ganluo County', '');
INSERT INTO `feel_region` VALUES (2099, '1', '51', '34', '36', '美姑县', 'Meigu County', '');
INSERT INTO `feel_region` VALUES (2100, '1', '51', '34', '37', '雷波县', 'Leibo County', '');
INSERT INTO `feel_region` VALUES (2101, '1', '52', '1', '2', '南明区', 'Nanming District', '');
INSERT INTO `feel_region` VALUES (2102, '1', '52', '1', '3', '云岩区', 'Yunyan District', '');
INSERT INTO `feel_region` VALUES (2103, '1', '52', '1', '11', '花溪区', 'Huaxi District', '');
INSERT INTO `feel_region` VALUES (2104, '1', '52', '1', '12', '乌当区', 'Wudang District', '');
INSERT INTO `feel_region` VALUES (2105, '1', '52', '1', '13', '白云区', 'Baiyun District', '');
INSERT INTO `feel_region` VALUES (2106, '1', '52', '1', '14', '小河区', 'Xiaohe District', '');
INSERT INTO `feel_region` VALUES (2107, '1', '52', '1', '21', '开阳县', 'Kaiyang County', '');
INSERT INTO `feel_region` VALUES (2108, '1', '52', '1', '22', '息烽县', 'Xifeng County', '');
INSERT INTO `feel_region` VALUES (2109, '1', '52', '1', '23', '修文县', 'Xiuwen County', '');
INSERT INTO `feel_region` VALUES (2110, '1', '52', '1', '81', '清镇市', 'Qingzhen City', '');
INSERT INTO `feel_region` VALUES (2111, '1', '52', '2', '1', '钟山区', 'Zhongshan District', '');
INSERT INTO `feel_region` VALUES (2112, '1', '52', '2', '3', '六枝特区', 'Six branches', '');
INSERT INTO `feel_region` VALUES (2113, '1', '52', '2', '21', '水城县', 'Shuicheng County', '');
INSERT INTO `feel_region` VALUES (2114, '1', '52', '2', '22', '盘　县', 'Pan County', '');
INSERT INTO `feel_region` VALUES (2115, '1', '52', '3', '2', '红花岗区', 'Honghuagang District', '');
INSERT INTO `feel_region` VALUES (2116, '1', '52', '3', '3', '汇川区', 'Huichuan District', '');
INSERT INTO `feel_region` VALUES (2117, '1', '52', '3', '21', '遵义县', 'Zunyi County', '');
INSERT INTO `feel_region` VALUES (2118, '1', '52', '3', '22', '桐梓县', 'Tonglu County', '');
INSERT INTO `feel_region` VALUES (2119, '1', '52', '3', '23', '绥阳县', 'Shuyang County', '');
INSERT INTO `feel_region` VALUES (2120, '1', '52', '3', '24', '正安县', 'Zhengan County', '');
INSERT INTO `feel_region` VALUES (2121, '1', '52', '3', '25', '道真仡佬族苗族自治县', 'Daozhen Yi and Miao Autonomous County', '');
INSERT INTO `feel_region` VALUES (2122, '1', '52', '3', '26', '务川仡佬族苗族自治县', 'Wuchuan Yi and Miao Autonomous County', '');
INSERT INTO `feel_region` VALUES (2123, '1', '52', '3', '27', '凤冈县', 'Fenggang County', '');
INSERT INTO `feel_region` VALUES (2124, '1', '52', '3', '28', '湄潭县', 'Meitan County', '');
INSERT INTO `feel_region` VALUES (2125, '1', '52', '3', '29', '余庆县', 'Yuqing County', '');
INSERT INTO `feel_region` VALUES (2126, '1', '52', '3', '30', '习水县', 'Xishui County', '');
INSERT INTO `feel_region` VALUES (2127, '1', '52', '3', '81', '赤水市', 'Chishui City', '');
INSERT INTO `feel_region` VALUES (2128, '1', '52', '3', '82', '仁怀市', 'Renhuai City', '');
INSERT INTO `feel_region` VALUES (2129, '1', '52', '4', '2', '西秀区', 'Xixiu District', '');
INSERT INTO `feel_region` VALUES (2130, '1', '52', '4', '21', '平坝县', 'Pingba County', '');
INSERT INTO `feel_region` VALUES (2131, '1', '52', '4', '22', '普定县', 'Puding County', '');
INSERT INTO `feel_region` VALUES (2132, '1', '52', '4', '23', '镇宁布依族苗族自治县', 'Zhenning Buyi and Miao Autonomous County', '');
INSERT INTO `feel_region` VALUES (2133, '1', '52', '4', '24', '关岭布依族苗族自治县', 'Guanling Buyi and Miao Autonomous County', '');
INSERT INTO `feel_region` VALUES (2134, '1', '52', '4', '25', '紫云苗族布依族自治县', 'Ziyun Miao Buyi Autonomous County', '');
INSERT INTO `feel_region` VALUES (2135, '1', '52', '22', '1', '铜仁市', 'Tongren City', '');
INSERT INTO `feel_region` VALUES (2136, '1', '52', '22', '22', '江口县', 'Jiangkou County', '');
INSERT INTO `feel_region` VALUES (2137, '1', '52', '22', '23', '玉屏侗族自治县', 'Yuping Yi Autonomous County', '');
INSERT INTO `feel_region` VALUES (2138, '1', '52', '22', '24', '石阡县', 'Shiqian County', '');
INSERT INTO `feel_region` VALUES (2139, '1', '52', '22', '25', '思南县', 'Sinan County', '');
INSERT INTO `feel_region` VALUES (2140, '1', '52', '22', '26', '印江土家族苗族自治县', 'Yinjiang Tujia and Miao Autonomous County', '');
INSERT INTO `feel_region` VALUES (2141, '1', '52', '22', '27', '德江县', 'Dejiang County', '');
INSERT INTO `feel_region` VALUES (2142, '1', '52', '22', '28', '沿河土家族自治县', 'Along the river Tujia Autonomous County', '');
INSERT INTO `feel_region` VALUES (2143, '1', '52', '22', '29', '松桃苗族自治县', 'Songtao Miao Autonomous County', '');
INSERT INTO `feel_region` VALUES (2144, '1', '52', '22', '30', '万山特区', 'Wanshan Special Zone', '');
INSERT INTO `feel_region` VALUES (2145, '1', '52', '23', '1', '兴义市', 'Xingyi City', '');
INSERT INTO `feel_region` VALUES (2146, '1', '52', '23', '22', '兴仁县', 'Xingren County', '');
INSERT INTO `feel_region` VALUES (2147, '1', '52', '23', '23', '普安县', 'Pu\'an County', '');
INSERT INTO `feel_region` VALUES (2148, '1', '52', '23', '24', '晴隆县', 'Qinglong County', '');
INSERT INTO `feel_region` VALUES (2149, '1', '52', '23', '25', '贞丰县', 'Zhenfeng County', '');
INSERT INTO `feel_region` VALUES (2150, '1', '52', '23', '26', '望谟县', 'Wangyu County', '');
INSERT INTO `feel_region` VALUES (2151, '1', '52', '23', '27', '册亨县', 'Book Heng County', '');
INSERT INTO `feel_region` VALUES (2152, '1', '52', '23', '28', '安龙县', 'Anlong County', '');
INSERT INTO `feel_region` VALUES (2153, '1', '52', '24', '1', '毕节市', 'Bijie City', '');
INSERT INTO `feel_region` VALUES (2154, '1', '52', '24', '22', '大方县', 'Dafang County', '');
INSERT INTO `feel_region` VALUES (2155, '1', '52', '24', '23', '黔西县', 'Luxi County', '');
INSERT INTO `feel_region` VALUES (2156, '1', '52', '24', '24', '金沙县', 'Jinsha County', '');
INSERT INTO `feel_region` VALUES (2157, '1', '52', '24', '25', '织金县', 'Zhijin County', '');
INSERT INTO `feel_region` VALUES (2158, '1', '52', '24', '26', '纳雍县', 'Labuan County', '');
INSERT INTO `feel_region` VALUES (2159, '1', '52', '24', '27', '威宁彝族回族苗族自治县', 'Weining Yi Nationality Hui and Miao Autonomous County', '');
INSERT INTO `feel_region` VALUES (2160, '1', '52', '24', '28', '赫章县', 'Hezhang County', '');
INSERT INTO `feel_region` VALUES (2161, '1', '52', '26', '1', '凯里市', 'Kaili City', '');
INSERT INTO `feel_region` VALUES (2162, '1', '52', '26', '22', '黄平县', 'Huangping County', '');
INSERT INTO `feel_region` VALUES (2163, '1', '52', '26', '23', '施秉县', 'Shibing County', '');
INSERT INTO `feel_region` VALUES (2164, '1', '52', '26', '24', '三穗县', 'Sansui County', '');
INSERT INTO `feel_region` VALUES (2165, '1', '52', '26', '25', '镇远县', 'Zhenyuan County', '');
INSERT INTO `feel_region` VALUES (2166, '1', '52', '26', '26', '岑巩县', 'Qigong County', '');
INSERT INTO `feel_region` VALUES (2167, '1', '52', '26', '27', '天柱县', 'Tianzhu County', '');
INSERT INTO `feel_region` VALUES (2168, '1', '52', '26', '28', '锦屏县', 'Jinping County', '');
INSERT INTO `feel_region` VALUES (2169, '1', '52', '26', '29', '剑河县', 'Jianhe County', '');
INSERT INTO `feel_region` VALUES (2170, '1', '52', '26', '30', '台江县', 'Taijiang County', '');
INSERT INTO `feel_region` VALUES (2171, '1', '52', '26', '31', '黎平县', 'Liping County', '');
INSERT INTO `feel_region` VALUES (2172, '1', '52', '26', '32', '榕江县', 'Qijiang County', '');
INSERT INTO `feel_region` VALUES (2173, '1', '52', '26', '33', '从江县', 'From Jiang County', '');
INSERT INTO `feel_region` VALUES (2174, '1', '52', '26', '34', '雷山县', 'Leishan County', '');
INSERT INTO `feel_region` VALUES (2175, '1', '52', '26', '35', '麻江县', 'Majiang County', '');
INSERT INTO `feel_region` VALUES (2176, '1', '52', '26', '36', '丹寨县', 'Danzhai County', '');
INSERT INTO `feel_region` VALUES (2177, '1', '52', '27', '1', '都匀市', 'Duyun City', '');
INSERT INTO `feel_region` VALUES (2178, '1', '52', '27', '2', '福泉市', 'Fuquan City', '');
INSERT INTO `feel_region` VALUES (2179, '1', '52', '27', '22', '荔波县', 'Libo County', '');
INSERT INTO `feel_region` VALUES (2180, '1', '52', '27', '23', '贵定县', 'Guiding County', '');
INSERT INTO `feel_region` VALUES (2181, '1', '52', '27', '25', '瓮安县', 'Chun\'an County', '');
INSERT INTO `feel_region` VALUES (2182, '1', '52', '27', '26', '独山县', 'Dushan County', '');
INSERT INTO `feel_region` VALUES (2183, '1', '52', '27', '27', '平塘县', 'Pingtang County', '');
INSERT INTO `feel_region` VALUES (2184, '1', '52', '27', '28', '罗甸县', 'Luodian County', '');
INSERT INTO `feel_region` VALUES (2185, '1', '52', '27', '29', '长顺县', 'Changshun County', '');
INSERT INTO `feel_region` VALUES (2186, '1', '52', '27', '30', '龙里县', 'Longli County', '');
INSERT INTO `feel_region` VALUES (2187, '1', '52', '27', '31', '惠水县', 'Huishui County', '');
INSERT INTO `feel_region` VALUES (2188, '1', '52', '27', '32', '三都水族自治县', 'Sandu Shui Autonomous County', '');
INSERT INTO `feel_region` VALUES (2189, '1', '53', '1', '2', '五华区', 'Wuhua District', '');
INSERT INTO `feel_region` VALUES (2190, '1', '53', '1', '3', '盘龙区', 'Panlong District', '');
INSERT INTO `feel_region` VALUES (2191, '1', '53', '1', '11', '官渡区', 'Guandu District', '');
INSERT INTO `feel_region` VALUES (2192, '1', '53', '1', '12', '西山区', 'Xishan District', '');
INSERT INTO `feel_region` VALUES (2193, '1', '53', '1', '13', '东川区', 'Dongchuan District', '');
INSERT INTO `feel_region` VALUES (2194, '1', '53', '1', '21', '呈贡县', 'Chenggong County', '');
INSERT INTO `feel_region` VALUES (2195, '1', '53', '1', '22', '晋宁县', 'Jinning County', '');
INSERT INTO `feel_region` VALUES (2196, '1', '53', '1', '24', '富民县', 'Fumin County', '');
INSERT INTO `feel_region` VALUES (2197, '1', '53', '1', '25', '宜良县', 'Yiliang County', '');
INSERT INTO `feel_region` VALUES (2198, '1', '53', '1', '26', '石林彝族自治县', 'Shilin Yi Autonomous County', '');
INSERT INTO `feel_region` VALUES (2199, '1', '53', '1', '27', '嵩明县', 'Yuming County', '');
INSERT INTO `feel_region` VALUES (2200, '1', '53', '1', '28', '禄劝彝族苗族自治县', 'Luquan Yi and Miao Autonomous County', '');
INSERT INTO `feel_region` VALUES (2201, '1', '53', '1', '29', '寻甸回族彝族自治县', 'Xundian Hui and Yi Autonomous County', '');
INSERT INTO `feel_region` VALUES (2202, '1', '53', '1', '81', '安宁市', 'Anning City', '');
INSERT INTO `feel_region` VALUES (2203, '1', '53', '3', '2', '麒麟区', 'Qilin District', '');
INSERT INTO `feel_region` VALUES (2204, '1', '53', '3', '21', '马龙县', 'Malong County', '');
INSERT INTO `feel_region` VALUES (2205, '1', '53', '3', '22', '陆良县', 'Luliang County', '');
INSERT INTO `feel_region` VALUES (2206, '1', '53', '3', '23', '师宗县', 'Shizong County', '');
INSERT INTO `feel_region` VALUES (2207, '1', '53', '3', '24', '罗平县', 'Luoping County', '');
INSERT INTO `feel_region` VALUES (2208, '1', '53', '3', '25', '富源县', 'Fuyuan County', '');
INSERT INTO `feel_region` VALUES (2209, '1', '53', '3', '26', '会泽县', 'Huize County', '');
INSERT INTO `feel_region` VALUES (2210, '1', '53', '3', '28', '沾益县', 'Zhanyi County', '');
INSERT INTO `feel_region` VALUES (2211, '1', '53', '3', '81', '宣威市', 'Xuanwei City', '');
INSERT INTO `feel_region` VALUES (2212, '1', '53', '4', '2', '红塔区', 'Hongta District', '');
INSERT INTO `feel_region` VALUES (2213, '1', '53', '4', '21', '江川县', 'Jiangchuan County', '');
INSERT INTO `feel_region` VALUES (2214, '1', '53', '4', '22', '澄江县', 'Chengjiang County', '');
INSERT INTO `feel_region` VALUES (2215, '1', '53', '4', '23', '通海县', 'Tonghai County', '');
INSERT INTO `feel_region` VALUES (2216, '1', '53', '4', '24', '华宁县', 'Huaning County', '');
INSERT INTO `feel_region` VALUES (2217, '1', '53', '4', '25', '易门县', 'Yimen County', '');
INSERT INTO `feel_region` VALUES (2218, '1', '53', '4', '26', '峨山彝族自治县', 'Daishan Yi Autonomous County', '');
INSERT INTO `feel_region` VALUES (2219, '1', '53', '4', '27', '新平彝族傣族自治县', 'Xinping Yi and Dong Autonomous County', '');
INSERT INTO `feel_region` VALUES (2220, '1', '53', '4', '28', '元江哈尼族彝族傣族自治县', 'Yuanjiang Hani Yi and Dong Autonomous County', '');
INSERT INTO `feel_region` VALUES (2221, '1', '53', '5', '2', '隆阳区', 'Longyang District', '');
INSERT INTO `feel_region` VALUES (2222, '1', '53', '5', '21', '施甸县', 'Shidian County', '');
INSERT INTO `feel_region` VALUES (2223, '1', '53', '5', '22', '腾冲县', 'Tengchong County', '');
INSERT INTO `feel_region` VALUES (2224, '1', '53', '5', '23', '龙陵县', 'Longling County', '');
INSERT INTO `feel_region` VALUES (2225, '1', '53', '5', '24', '昌宁县', 'Changning County', '');
INSERT INTO `feel_region` VALUES (2226, '1', '53', '6', '2', '昭阳区', 'Zhaoyang District', '');
INSERT INTO `feel_region` VALUES (2227, '1', '53', '6', '21', '鲁甸县', 'Ludian County', '');
INSERT INTO `feel_region` VALUES (2228, '1', '53', '6', '22', '巧家县', 'Qiaojia County', '');
INSERT INTO `feel_region` VALUES (2229, '1', '53', '6', '23', '盐津县', 'Yanjin County', '');
INSERT INTO `feel_region` VALUES (2230, '1', '53', '6', '24', '大关县', 'Daguan County', '');
INSERT INTO `feel_region` VALUES (2231, '1', '53', '6', '25', '永善县', 'Yongshan County', '');
INSERT INTO `feel_region` VALUES (2232, '1', '53', '6', '26', '绥江县', 'Qijiang County', '');
INSERT INTO `feel_region` VALUES (2233, '1', '53', '6', '27', '镇雄县', 'Zhenxiong County', '');
INSERT INTO `feel_region` VALUES (2234, '1', '53', '6', '28', '彝良县', 'Yanliang County', '');
INSERT INTO `feel_region` VALUES (2235, '1', '53', '6', '29', '威信县', 'Weixin County', '');
INSERT INTO `feel_region` VALUES (2236, '1', '53', '6', '30', '水富县', 'Shuifu County', '');
INSERT INTO `feel_region` VALUES (2237, '1', '53', '7', '2', '古城区', 'Ancient city', '');
INSERT INTO `feel_region` VALUES (2238, '1', '53', '7', '21', '玉龙纳西族自治县', 'Yulong Naxi Autonomous County', '');
INSERT INTO `feel_region` VALUES (2239, '1', '53', '7', '22', '永胜县', 'Yongsheng County', '');
INSERT INTO `feel_region` VALUES (2240, '1', '53', '7', '23', '华坪县', 'Huaping County', '');
INSERT INTO `feel_region` VALUES (2241, '1', '53', '7', '24', '宁蒗彝族自治县', 'Ninglang Autonomous County', '');
INSERT INTO `feel_region` VALUES (2242, '1', '53', '8', '2', '思茅区', 'Simao District', '');
INSERT INTO `feel_region` VALUES (2243, '1', '53', '8', '21', '宁洱哈尼族彝族自治县', 'Ninglang Hani and Yi Autonomous County', '');
INSERT INTO `feel_region` VALUES (2244, '1', '53', '8', '22', '墨江哈尼族自治县', 'Mojiang Hani Autonomous County', '');
INSERT INTO `feel_region` VALUES (2245, '1', '53', '8', '23', '景东彝族自治县', 'Jingdong Yi Autonomous County', '');
INSERT INTO `feel_region` VALUES (2246, '1', '53', '8', '24', '景谷傣族彝族自治县', 'Jinggu Yi and Dong Autonomous County', '');
INSERT INTO `feel_region` VALUES (2247, '1', '53', '8', '25', '镇沅彝族哈尼族拉祜族自治县', 'Zhenyi Hani Lahu Autonomous County', '');
INSERT INTO `feel_region` VALUES (2248, '1', '53', '8', '26', '江城哈尼族彝族自治县', 'Jiangcheng Hani and Yi Autonomous County', '');
INSERT INTO `feel_region` VALUES (2249, '1', '53', '8', '27', '孟连傣族拉祜族佤族自治县', 'Menglian Dai Lahu and Dong Autonomous County', '');
INSERT INTO `feel_region` VALUES (2250, '1', '53', '8', '28', '澜沧拉祜族自治县', '澜沧拉祜 Autonomous County', '');
INSERT INTO `feel_region` VALUES (2251, '1', '53', '8', '29', '西盟佤族自治县', 'Ximeng Yi Autonomous County', '');
INSERT INTO `feel_region` VALUES (2252, '1', '53', '9', '2', '临翔区', 'Linxiang District', '');
INSERT INTO `feel_region` VALUES (2253, '1', '53', '9', '21', '凤庆县', 'Fengqing County', '');
INSERT INTO `feel_region` VALUES (2254, '1', '53', '9', '22', '云　县', 'Yun County', '');
INSERT INTO `feel_region` VALUES (2255, '1', '53', '9', '23', '永德县', 'Yongde County', '');
INSERT INTO `feel_region` VALUES (2256, '1', '53', '9', '24', '镇康县', 'Zhenkang County', '');
INSERT INTO `feel_region` VALUES (2257, '1', '53', '9', '25', '双江拉祜族佤族布朗族傣族自治县', 'Shuangjiang Lahu and Dai People\'s Blang and Dong Autonomous County', '');
INSERT INTO `feel_region` VALUES (2258, '1', '53', '9', '26', '耿马傣族佤族自治县', 'Hummer Yi and Dong Autonomous County', '');
INSERT INTO `feel_region` VALUES (2259, '1', '53', '9', '27', '沧源佤族自治县', 'Wuyuan Yi Autonomous County', '');
INSERT INTO `feel_region` VALUES (2260, '1', '53', '23', '1', '楚雄市', 'Chuxiong City', '');
INSERT INTO `feel_region` VALUES (2261, '1', '53', '23', '22', '双柏县', 'Shuangbai County', '');
INSERT INTO `feel_region` VALUES (2262, '1', '53', '23', '23', '牟定县', 'Luding County', '');
INSERT INTO `feel_region` VALUES (2263, '1', '53', '23', '24', '南华县', 'Nanhua County', '');
INSERT INTO `feel_region` VALUES (2264, '1', '53', '23', '25', '姚安县', 'Yao\'an County', '');
INSERT INTO `feel_region` VALUES (2265, '1', '53', '23', '26', '大姚县', 'Dayao County', '');
INSERT INTO `feel_region` VALUES (2266, '1', '53', '23', '27', '永仁县', 'Yongren County', '');
INSERT INTO `feel_region` VALUES (2267, '1', '53', '23', '28', '元谋县', 'Yuanmou County', '');
INSERT INTO `feel_region` VALUES (2268, '1', '53', '23', '29', '武定县', 'Wuding County', '');
INSERT INTO `feel_region` VALUES (2269, '1', '53', '23', '31', '禄丰县', 'Lufeng County', '');
INSERT INTO `feel_region` VALUES (2270, '1', '53', '25', '1', '个旧市', 'Gejiu City', '');
INSERT INTO `feel_region` VALUES (2271, '1', '53', '25', '2', '开远市', 'Kaiyuan City', '');
INSERT INTO `feel_region` VALUES (2272, '1', '53', '25', '22', '蒙自县', 'Mengzi County', '');
INSERT INTO `feel_region` VALUES (2273, '1', '53', '25', '23', '屏边苗族自治县', 'Pingbian Miao Autonomous County', '');
INSERT INTO `feel_region` VALUES (2274, '1', '53', '25', '24', '建水县', 'Jianshui County', '');
INSERT INTO `feel_region` VALUES (2275, '1', '53', '25', '25', '石屏县', 'Shiping County', '');
INSERT INTO `feel_region` VALUES (2276, '1', '53', '25', '26', '弥勒县', 'Mile County', '');
INSERT INTO `feel_region` VALUES (2277, '1', '53', '25', '27', '泸西县', 'Luxi County', '');
INSERT INTO `feel_region` VALUES (2278, '1', '53', '25', '28', '元阳县', 'Yuanyang County', '');
INSERT INTO `feel_region` VALUES (2279, '1', '53', '25', '29', '红河县', 'Honghe County', '');
INSERT INTO `feel_region` VALUES (2280, '1', '53', '25', '30', '金平苗族瑶族傣族自治县', 'Jinping Miao and Yao Autonomous County', '');
INSERT INTO `feel_region` VALUES (2281, '1', '53', '25', '31', '绿春县', 'Luchun County', '');
INSERT INTO `feel_region` VALUES (2282, '1', '53', '25', '32', '河口瑶族自治县', 'Hekou Yao Autonomous County', '');
INSERT INTO `feel_region` VALUES (2283, '1', '53', '26', '21', '文山县', 'Wenshan County', '');
INSERT INTO `feel_region` VALUES (2284, '1', '53', '26', '22', '砚山县', 'Daishan County', '');
INSERT INTO `feel_region` VALUES (2285, '1', '53', '26', '23', '西畴县', 'Xichou County', '');
INSERT INTO `feel_region` VALUES (2286, '1', '53', '26', '24', '麻栗坡县', 'Malipo County', '');
INSERT INTO `feel_region` VALUES (2287, '1', '53', '26', '25', '马关县', 'Maguan County', '');
INSERT INTO `feel_region` VALUES (2288, '1', '53', '26', '26', '丘北县', 'Qiubei County', '');
INSERT INTO `feel_region` VALUES (2289, '1', '53', '26', '27', '广南县', 'Guangnan County', '');
INSERT INTO `feel_region` VALUES (2290, '1', '53', '26', '28', '富宁县', 'Funing County', '');
INSERT INTO `feel_region` VALUES (2291, '1', '53', '28', '1', '景洪市', 'Jinghong City', '');
INSERT INTO `feel_region` VALUES (2292, '1', '53', '28', '22', '勐海县', 'Menghai County', '');
INSERT INTO `feel_region` VALUES (2293, '1', '53', '28', '23', '勐腊县', 'Mengla County', '');
INSERT INTO `feel_region` VALUES (2294, '1', '53', '29', '1', '大理市', 'Dali City', '');
INSERT INTO `feel_region` VALUES (2295, '1', '53', '29', '22', '漾濞彝族自治县', 'Yi Autonomous County', '');
INSERT INTO `feel_region` VALUES (2296, '1', '53', '29', '23', '祥云县', 'Xiangyun County', '');
INSERT INTO `feel_region` VALUES (2297, '1', '53', '29', '24', '宾川县', 'Binchuan County', '');
INSERT INTO `feel_region` VALUES (2298, '1', '53', '29', '25', '弥渡县', 'Midu County', '');
INSERT INTO `feel_region` VALUES (2299, '1', '53', '29', '26', '南涧彝族自治县', 'Nanzhao Autonomous County', '');
INSERT INTO `feel_region` VALUES (2300, '1', '53', '29', '27', '巍山彝族回族自治县', 'Daishan Yi and Hui Autonomous County', '');
INSERT INTO `feel_region` VALUES (2301, '1', '53', '29', '28', '永平县', 'Yongping County', '');
INSERT INTO `feel_region` VALUES (2302, '1', '53', '29', '29', '云龙县', 'Yunlong County', '');
INSERT INTO `feel_region` VALUES (2303, '1', '53', '29', '30', '洱源县', 'Wuyuan County', '');
INSERT INTO `feel_region` VALUES (2304, '1', '53', '29', '31', '剑川县', 'Jianchuan County', '');
INSERT INTO `feel_region` VALUES (2305, '1', '53', '29', '32', '鹤庆县', 'Heqing County', '');
INSERT INTO `feel_region` VALUES (2306, '1', '53', '31', '2', '瑞丽市', 'Ruili City', '');
INSERT INTO `feel_region` VALUES (2307, '1', '53', '31', '3', '潞西市', 'Luxi City', '');
INSERT INTO `feel_region` VALUES (2308, '1', '53', '31', '22', '梁河县', 'Lianghe County', '');
INSERT INTO `feel_region` VALUES (2309, '1', '53', '31', '23', '盈江县', 'Yingjiang County', '');
INSERT INTO `feel_region` VALUES (2310, '1', '53', '31', '24', '陇川县', 'Luanchuan County', '');
INSERT INTO `feel_region` VALUES (2311, '1', '53', '33', '21', '泸水县', 'Yishui County', '');
INSERT INTO `feel_region` VALUES (2312, '1', '53', '33', '23', '福贡县', 'Fugong County', '');
INSERT INTO `feel_region` VALUES (2313, '1', '53', '33', '24', '贡山独龙族怒族自治县', 'Gongshan Dulong Nationality Autonomous County', '');
INSERT INTO `feel_region` VALUES (2314, '1', '53', '33', '25', '兰坪白族普米族自治县', 'Lanping Baizu Pumi Autonomous County', '');
INSERT INTO `feel_region` VALUES (2315, '1', '53', '34', '21', '香格里拉县', 'Shangri-La County', '');
INSERT INTO `feel_region` VALUES (2316, '1', '53', '34', '22', '德钦县', 'Deqin County', '');
INSERT INTO `feel_region` VALUES (2317, '1', '53', '34', '23', '维西傈僳族自治县', 'Weixi Yi Autonomous County', '');
INSERT INTO `feel_region` VALUES (2318, '1', '54', '1', '2', '城关区', 'Chengguan District', '');
INSERT INTO `feel_region` VALUES (2319, '1', '54', '1', '21', '林周县', 'Lin Zhou County', '');
INSERT INTO `feel_region` VALUES (2320, '1', '54', '1', '22', '当雄县', 'Dangxiong County', '');
INSERT INTO `feel_region` VALUES (2321, '1', '54', '1', '23', '尼木县', 'Nimu County', '');
INSERT INTO `feel_region` VALUES (2322, '1', '54', '1', '24', '曲水县', 'Qushui County', '');
INSERT INTO `feel_region` VALUES (2323, '1', '54', '1', '25', '堆龙德庆县', 'Pile of Long Deqing County', '');
INSERT INTO `feel_region` VALUES (2324, '1', '54', '1', '26', '达孜县', 'Daban County', '');
INSERT INTO `feel_region` VALUES (2325, '1', '54', '1', '27', '墨竹工卡县', 'Mozhugongka County', '');
INSERT INTO `feel_region` VALUES (2326, '1', '54', '21', '21', '昌都县', 'Changdu County', '');
INSERT INTO `feel_region` VALUES (2327, '1', '54', '21', '22', '江达县', 'Jiangda County', '');
INSERT INTO `feel_region` VALUES (2328, '1', '54', '21', '23', '贡觉县', 'Gongjue County', '');
INSERT INTO `feel_region` VALUES (2329, '1', '54', '21', '24', '类乌齐县', 'Wuqi County', '');
INSERT INTO `feel_region` VALUES (2330, '1', '54', '21', '25', '丁青县', 'Dingqing County', '');
INSERT INTO `feel_region` VALUES (2331, '1', '54', '21', '26', '察雅县', 'Chaya County', '');
INSERT INTO `feel_region` VALUES (2332, '1', '54', '21', '27', '八宿县', 'Baju County', '');
INSERT INTO `feel_region` VALUES (2333, '1', '54', '21', '28', '左贡县', 'Zuogong County', '');
INSERT INTO `feel_region` VALUES (2334, '1', '54', '21', '29', '芒康县', 'Mangkang County', '');
INSERT INTO `feel_region` VALUES (2335, '1', '54', '21', '32', '洛隆县', 'Luolong County', '');
INSERT INTO `feel_region` VALUES (2336, '1', '54', '21', '33', '边坝县', 'Bianba County', '');
INSERT INTO `feel_region` VALUES (2337, '1', '54', '22', '21', '乃东县', 'Naidong County', '');
INSERT INTO `feel_region` VALUES (2338, '1', '54', '22', '22', '扎囊县', 'Zhakou County', '');
INSERT INTO `feel_region` VALUES (2339, '1', '54', '22', '23', '贡嘎县', 'Gongga County', '');
INSERT INTO `feel_region` VALUES (2340, '1', '54', '22', '24', '桑日县', 'Sanri County', '');
INSERT INTO `feel_region` VALUES (2341, '1', '54', '22', '25', '琼结县', 'Qiongjie County', '');
INSERT INTO `feel_region` VALUES (2342, '1', '54', '22', '26', '曲松县', 'Qusong County', '');
INSERT INTO `feel_region` VALUES (2343, '1', '54', '22', '27', '措美县', 'Cuomei County', '');
INSERT INTO `feel_region` VALUES (2344, '1', '54', '22', '28', '洛扎县', 'Loza County', '');
INSERT INTO `feel_region` VALUES (2345, '1', '54', '22', '29', '加查县', 'Jiacha County', '');
INSERT INTO `feel_region` VALUES (2346, '1', '54', '22', '31', '隆子县', 'Longzi County', '');
INSERT INTO `feel_region` VALUES (2347, '1', '54', '22', '32', '错那县', 'Wrong County', '');
INSERT INTO `feel_region` VALUES (2348, '1', '54', '22', '33', '浪卡子县', 'Langkazi County', '');
INSERT INTO `feel_region` VALUES (2349, '1', '54', '23', '1', '日喀则市', 'Shigatse City', '');
INSERT INTO `feel_region` VALUES (2350, '1', '54', '23', '22', '南木林县', 'South Mulin County', '');
INSERT INTO `feel_region` VALUES (2351, '1', '54', '23', '23', '江孜县', 'Jiangyan County', '');
INSERT INTO `feel_region` VALUES (2352, '1', '54', '23', '24', '定日县', 'Dingri County', '');
INSERT INTO `feel_region` VALUES (2353, '1', '54', '23', '25', '萨迦县', 'Saga County', '');
INSERT INTO `feel_region` VALUES (2354, '1', '54', '23', '26', '拉孜县', 'Lahu County', '');
INSERT INTO `feel_region` VALUES (2355, '1', '54', '23', '27', '昂仁县', 'Angren County', '');
INSERT INTO `feel_region` VALUES (2356, '1', '54', '23', '28', '谢通门县', 'Xietongmen County', '');
INSERT INTO `feel_region` VALUES (2357, '1', '54', '23', '29', '白朗县', 'Bailang County', '');
INSERT INTO `feel_region` VALUES (2358, '1', '54', '23', '30', '仁布县', 'Renbu County', '');
INSERT INTO `feel_region` VALUES (2359, '1', '54', '23', '31', '康马县', 'Kangma County', '');
INSERT INTO `feel_region` VALUES (2360, '1', '54', '23', '32', '定结县', 'Dingjie County', '');
INSERT INTO `feel_region` VALUES (2361, '1', '54', '23', '33', '仲巴县', 'Zhongba County', '');
INSERT INTO `feel_region` VALUES (2362, '1', '54', '23', '34', '亚东县', 'Yadong County', '');
INSERT INTO `feel_region` VALUES (2363, '1', '54', '23', '35', '吉隆县', 'Jilong County', '');
INSERT INTO `feel_region` VALUES (2364, '1', '54', '23', '36', '聂拉木县', 'Nyalam County', '');
INSERT INTO `feel_region` VALUES (2365, '1', '54', '23', '37', '萨嘎县', 'Saji County', '');
INSERT INTO `feel_region` VALUES (2366, '1', '54', '23', '38', '岗巴县', 'Gamba County', '');
INSERT INTO `feel_region` VALUES (2367, '1', '54', '24', '21', '那曲县', 'Naqu County', '');
INSERT INTO `feel_region` VALUES (2368, '1', '54', '24', '22', '嘉黎县', 'Jiali County', '');
INSERT INTO `feel_region` VALUES (2369, '1', '54', '24', '23', '比如县', 'Such as the county', '');
INSERT INTO `feel_region` VALUES (2370, '1', '54', '24', '24', '聂荣县', 'Nie Rong County', '');
INSERT INTO `feel_region` VALUES (2371, '1', '54', '24', '25', '安多县', 'Amdo County', '');
INSERT INTO `feel_region` VALUES (2372, '1', '54', '24', '26', '申扎县', 'Shenzha County', '');
INSERT INTO `feel_region` VALUES (2373, '1', '54', '24', '27', '索　县', 'Suo County', '');
INSERT INTO `feel_region` VALUES (2374, '1', '54', '24', '28', '班戈县', 'Bangor County', '');
INSERT INTO `feel_region` VALUES (2375, '1', '54', '24', '29', '巴青县', 'Baqing County', '');
INSERT INTO `feel_region` VALUES (2376, '1', '54', '24', '30', '尼玛县', 'Nima County', '');
INSERT INTO `feel_region` VALUES (2377, '1', '54', '25', '21', '普兰县', 'Pulan County', '');
INSERT INTO `feel_region` VALUES (2378, '1', '54', '25', '22', '札达县', 'Zanda County', '');
INSERT INTO `feel_region` VALUES (2379, '1', '54', '25', '23', '噶尔县', 'Muir County', '');
INSERT INTO `feel_region` VALUES (2380, '1', '54', '25', '24', '日土县', 'Ritu County', '');
INSERT INTO `feel_region` VALUES (2381, '1', '54', '25', '25', '革吉县', 'Geji County', '');
INSERT INTO `feel_region` VALUES (2382, '1', '54', '25', '26', '改则县', 'Change county', '');
INSERT INTO `feel_region` VALUES (2383, '1', '54', '25', '27', '措勤县', 'Coqin County', '');
INSERT INTO `feel_region` VALUES (2384, '1', '54', '26', '21', '林芝县', 'Linzhi County', '');
INSERT INTO `feel_region` VALUES (2385, '1', '54', '26', '22', '工布江达县', 'Gongbu Jiangda County', '');
INSERT INTO `feel_region` VALUES (2386, '1', '54', '26', '23', '米林县', 'Milin County', '');
INSERT INTO `feel_region` VALUES (2387, '1', '54', '26', '24', '墨脱县', 'Medog County', '');
INSERT INTO `feel_region` VALUES (2388, '1', '54', '26', '25', '波密县', 'Bomi County', '');
INSERT INTO `feel_region` VALUES (2389, '1', '54', '26', '26', '察隅县', 'Chayu County', '');
INSERT INTO `feel_region` VALUES (2390, '1', '54', '26', '27', '朗　县', 'Long County', '');
INSERT INTO `feel_region` VALUES (2391, '1', '61', '1', '2', '新城区', 'New town area', '');
INSERT INTO `feel_region` VALUES (2392, '1', '61', '1', '3', '碑林区', 'Beilin District', '');
INSERT INTO `feel_region` VALUES (2393, '1', '61', '1', '4', '莲湖区', 'Lianhu District', '');
INSERT INTO `feel_region` VALUES (2394, '1', '61', '1', '11', '灞桥区', 'Yongqiao District', '');
INSERT INTO `feel_region` VALUES (2395, '1', '61', '1', '12', '未央区', 'Weiyang District', '');
INSERT INTO `feel_region` VALUES (2396, '1', '61', '1', '13', '雁塔区', 'Yanta District', '');
INSERT INTO `feel_region` VALUES (2397, '1', '61', '1', '14', '阎良区', 'Yanliang District', '');
INSERT INTO `feel_region` VALUES (2398, '1', '61', '1', '15', '临潼区', 'Linyi District', '');
INSERT INTO `feel_region` VALUES (2399, '1', '61', '1', '16', '长安区', 'Chang\'an District', '');
INSERT INTO `feel_region` VALUES (2400, '1', '61', '1', '22', '蓝田县', 'Lantian County', '');
INSERT INTO `feel_region` VALUES (2401, '1', '61', '1', '24', '周至县', 'Zhouzhi County', '');
INSERT INTO `feel_region` VALUES (2402, '1', '61', '1', '25', '户　县', 'Hu County', '');
INSERT INTO `feel_region` VALUES (2403, '1', '61', '1', '26', '高陵县', 'Gaoling County', '');
INSERT INTO `feel_region` VALUES (2404, '1', '61', '2', '2', '王益区', 'Wang Yi District', '');
INSERT INTO `feel_region` VALUES (2405, '1', '61', '2', '3', '印台区', 'Yintai District', '');
INSERT INTO `feel_region` VALUES (2406, '1', '61', '2', '4', '耀州区', 'Yaozhou District', '');
INSERT INTO `feel_region` VALUES (2407, '1', '61', '2', '22', '宜君县', 'Yijun County', '');
INSERT INTO `feel_region` VALUES (2408, '1', '61', '3', '2', '渭滨区', 'Weibin District', '');
INSERT INTO `feel_region` VALUES (2409, '1', '61', '3', '3', '金台区', 'Jintai District', '');
INSERT INTO `feel_region` VALUES (2410, '1', '61', '3', '4', '陈仓区', 'Chencang District', '');
INSERT INTO `feel_region` VALUES (2411, '1', '61', '3', '22', '凤翔县', 'Fengxiang County', '');
INSERT INTO `feel_region` VALUES (2412, '1', '61', '3', '23', '岐山县', 'Daishan County', '');
INSERT INTO `feel_region` VALUES (2413, '1', '61', '3', '24', '扶风县', 'Fufeng County', '');
INSERT INTO `feel_region` VALUES (2414, '1', '61', '3', '26', '眉　县', 'Mei County', '');
INSERT INTO `feel_region` VALUES (2415, '1', '61', '3', '27', '陇　县', '县 County', '');
INSERT INTO `feel_region` VALUES (2416, '1', '61', '3', '28', '千阳县', 'Qianyang County', '');
INSERT INTO `feel_region` VALUES (2417, '1', '61', '3', '29', '麟游县', 'Linyou County', '');
INSERT INTO `feel_region` VALUES (2418, '1', '61', '3', '30', '凤　县', 'Feng County', '');
INSERT INTO `feel_region` VALUES (2419, '1', '61', '3', '31', '太白县', 'Taibai County', '');
INSERT INTO `feel_region` VALUES (2420, '1', '61', '4', '2', '秦都区', 'Qindu District', '');
INSERT INTO `feel_region` VALUES (2421, '1', '61', '4', '3', '杨凌区', 'Yangling District', '');
INSERT INTO `feel_region` VALUES (2422, '1', '61', '4', '4', '渭城区', 'Wucheng District', '');
INSERT INTO `feel_region` VALUES (2423, '1', '61', '4', '22', '三原县', 'Sanyuan County', '');
INSERT INTO `feel_region` VALUES (2424, '1', '61', '4', '23', '泾阳县', 'Shuyang County', '');
INSERT INTO `feel_region` VALUES (2425, '1', '61', '4', '24', '乾　县', 'Gan County', '');
INSERT INTO `feel_region` VALUES (2426, '1', '61', '4', '25', '礼泉县', 'Liquan County', '');
INSERT INTO `feel_region` VALUES (2427, '1', '61', '4', '26', '永寿县', 'Yongshou County', '');
INSERT INTO `feel_region` VALUES (2428, '1', '61', '4', '27', '彬　县', 'Bin County', '');
INSERT INTO `feel_region` VALUES (2429, '1', '61', '4', '28', '长武县', 'Changwu County', '');
INSERT INTO `feel_region` VALUES (2430, '1', '61', '4', '29', '旬邑县', 'Xunyi County', '');
INSERT INTO `feel_region` VALUES (2431, '1', '61', '4', '30', '淳化县', 'Suihua County', '');
INSERT INTO `feel_region` VALUES (2432, '1', '61', '4', '31', '武功县', 'Wugong County', '');
INSERT INTO `feel_region` VALUES (2433, '1', '61', '4', '81', '兴平市', 'Xingping City', '');
INSERT INTO `feel_region` VALUES (2434, '1', '61', '5', '2', '临渭区', 'Linyi District', '');
INSERT INTO `feel_region` VALUES (2435, '1', '61', '5', '21', '华　县', 'Hua County', '');
INSERT INTO `feel_region` VALUES (2436, '1', '61', '5', '22', '潼关县', 'Shaoguan County', '');
INSERT INTO `feel_region` VALUES (2437, '1', '61', '5', '23', '大荔县', 'Dayi County', '');
INSERT INTO `feel_region` VALUES (2438, '1', '61', '5', '24', '合阳县', 'Heyang County', '');
INSERT INTO `feel_region` VALUES (2439, '1', '61', '5', '25', '澄城县', 'Chengcheng County', '');
INSERT INTO `feel_region` VALUES (2440, '1', '61', '5', '26', '蒲城县', 'Pucheng County', '');
INSERT INTO `feel_region` VALUES (2441, '1', '61', '5', '27', '白水县', 'Baishui County', '');
INSERT INTO `feel_region` VALUES (2442, '1', '61', '5', '28', '富平县', 'Fuping County', '');
INSERT INTO `feel_region` VALUES (2443, '1', '61', '5', '81', '韩城市', 'Hancheng', '');
INSERT INTO `feel_region` VALUES (2444, '1', '61', '5', '82', '华阴市', 'Huayin City', '');
INSERT INTO `feel_region` VALUES (2445, '1', '61', '6', '2', '宝塔区', 'Baota District', '');
INSERT INTO `feel_region` VALUES (2446, '1', '61', '6', '21', '延长县', 'Yan County', '');
INSERT INTO `feel_region` VALUES (2447, '1', '61', '6', '22', '延川县', 'Yanchuan County', '');
INSERT INTO `feel_region` VALUES (2448, '1', '61', '6', '23', '子长县', 'Zichang County', '');
INSERT INTO `feel_region` VALUES (2449, '1', '61', '6', '24', '安塞县', 'Ansai County', '');
INSERT INTO `feel_region` VALUES (2450, '1', '61', '6', '25', '志丹县', 'Zhidan County', '');
INSERT INTO `feel_region` VALUES (2451, '1', '61', '6', '26', '吴起县', 'Wuqi County', '');
INSERT INTO `feel_region` VALUES (2452, '1', '61', '6', '27', '甘泉县', 'Ganquan County', '');
INSERT INTO `feel_region` VALUES (2453, '1', '61', '6', '28', '富　县', 'Fu County', '');
INSERT INTO `feel_region` VALUES (2454, '1', '61', '6', '29', '洛川县', 'Luochuan County', '');
INSERT INTO `feel_region` VALUES (2455, '1', '61', '6', '30', '宜川县', 'Yichuan County', '');
INSERT INTO `feel_region` VALUES (2456, '1', '61', '6', '31', '黄龙县', 'Huanglong County', '');
INSERT INTO `feel_region` VALUES (2457, '1', '61', '6', '32', '黄陵县', 'Huangling County', '');
INSERT INTO `feel_region` VALUES (2458, '1', '61', '7', '2', '汉台区', 'Hantai District', '');
INSERT INTO `feel_region` VALUES (2459, '1', '61', '7', '21', '南郑县', 'Nanzheng County', '');
INSERT INTO `feel_region` VALUES (2460, '1', '61', '7', '22', '城固县', 'Chenggu County', '');
INSERT INTO `feel_region` VALUES (2461, '1', '61', '7', '23', '洋　县', 'Yang County', '');
INSERT INTO `feel_region` VALUES (2462, '1', '61', '7', '24', '西乡县', 'Xixiang County', '');
INSERT INTO `feel_region` VALUES (2463, '1', '61', '7', '25', '勉　县', '县 County', '');
INSERT INTO `feel_region` VALUES (2464, '1', '61', '7', '26', '宁强县', 'Ningqiang County', '');
INSERT INTO `feel_region` VALUES (2465, '1', '61', '7', '27', '略阳县', 'Lueyang County', '');
INSERT INTO `feel_region` VALUES (2466, '1', '61', '7', '28', '镇巴县', 'Zhenba County', '');
INSERT INTO `feel_region` VALUES (2467, '1', '61', '7', '29', '留坝县', 'Liuba County', '');
INSERT INTO `feel_region` VALUES (2468, '1', '61', '7', '30', '佛坪县', 'Foping County', '');
INSERT INTO `feel_region` VALUES (2469, '1', '61', '8', '2', '榆阳区', 'Yuyang District', '');
INSERT INTO `feel_region` VALUES (2470, '1', '61', '8', '21', '神木县', 'Shenmu County', '');
INSERT INTO `feel_region` VALUES (2471, '1', '61', '8', '22', '府谷县', 'Fugu County', '');
INSERT INTO `feel_region` VALUES (2472, '1', '61', '8', '23', '横山县', 'Hengshan County', '');
INSERT INTO `feel_region` VALUES (2473, '1', '61', '8', '24', '靖边县', 'Jingbian County', '');
INSERT INTO `feel_region` VALUES (2474, '1', '61', '8', '25', '定边县', 'Dingbian County', '');
INSERT INTO `feel_region` VALUES (2475, '1', '61', '8', '26', '绥德县', 'Jude County', '');
INSERT INTO `feel_region` VALUES (2476, '1', '61', '8', '27', '米脂县', 'Mizhi County', '');
INSERT INTO `feel_region` VALUES (2477, '1', '61', '8', '28', '佳　县', 'Jia County', '');
INSERT INTO `feel_region` VALUES (2478, '1', '61', '8', '29', '吴堡县', 'Wubao County', '');
INSERT INTO `feel_region` VALUES (2479, '1', '61', '8', '30', '清涧县', 'Qingyi County', '');
INSERT INTO `feel_region` VALUES (2480, '1', '61', '8', '31', '子洲县', 'Zizhou County', '');
INSERT INTO `feel_region` VALUES (2481, '1', '61', '9', '2', '汉滨区', 'Hanbin District', '');
INSERT INTO `feel_region` VALUES (2482, '1', '61', '9', '21', '汉阴县', 'Hanyin County', '');
INSERT INTO `feel_region` VALUES (2483, '1', '61', '9', '22', '石泉县', 'Shiquan County', '');
INSERT INTO `feel_region` VALUES (2484, '1', '61', '9', '23', '宁陕县', 'Ningshan County', '');
INSERT INTO `feel_region` VALUES (2485, '1', '61', '9', '24', '紫阳县', 'Ziyang County', '');
INSERT INTO `feel_region` VALUES (2486, '1', '61', '9', '25', '岚皋县', 'Ji County', '');
INSERT INTO `feel_region` VALUES (2487, '1', '61', '9', '26', '平利县', 'Pingli County', '');
INSERT INTO `feel_region` VALUES (2488, '1', '61', '9', '27', '镇坪县', 'Zhenping County', '');
INSERT INTO `feel_region` VALUES (2489, '1', '61', '9', '28', '旬阳县', 'Xunyang County', '');
INSERT INTO `feel_region` VALUES (2490, '1', '61', '9', '29', '白河县', 'Baihe County', '');
INSERT INTO `feel_region` VALUES (2491, '1', '61', '10', '2', '商州区', 'Shangzhou District', '');
INSERT INTO `feel_region` VALUES (2492, '1', '61', '10', '21', '洛南县', 'Luonan County', '');
INSERT INTO `feel_region` VALUES (2493, '1', '61', '10', '22', '丹凤县', 'Danfeng County', '');
INSERT INTO `feel_region` VALUES (2494, '1', '61', '10', '23', '商南县', 'Shangnan County', '');
INSERT INTO `feel_region` VALUES (2495, '1', '61', '10', '24', '山阳县', 'Shanyang County', '');
INSERT INTO `feel_region` VALUES (2496, '1', '61', '10', '25', '镇安县', 'Zhen\'an County', '');
INSERT INTO `feel_region` VALUES (2497, '1', '61', '10', '26', '柞水县', 'Yishui County', '');
INSERT INTO `feel_region` VALUES (2498, '1', '62', '1', '2', '城关区', 'Chengguan District', '');
INSERT INTO `feel_region` VALUES (2499, '1', '62', '1', '3', '七里河区', 'Qilihe District', '');
INSERT INTO `feel_region` VALUES (2500, '1', '62', '1', '4', '西固区', 'Xigu District', '');
INSERT INTO `feel_region` VALUES (2501, '1', '62', '1', '5', '安宁区', 'Anning District', '');
INSERT INTO `feel_region` VALUES (2502, '1', '62', '1', '11', '红古区', 'Honggu District', '');
INSERT INTO `feel_region` VALUES (2503, '1', '62', '1', '21', '永登县', 'Yongdeng County', '');
INSERT INTO `feel_region` VALUES (2504, '1', '62', '1', '22', '皋兰县', 'Gaolan County', '');
INSERT INTO `feel_region` VALUES (2505, '1', '62', '1', '23', '榆中县', 'Yuzhong County', '');
INSERT INTO `feel_region` VALUES (2506, '1', '62', '2', '0', '嘉峪关市', 'Jiayuguan City', '');
INSERT INTO `feel_region` VALUES (2507, '1', '62', '3', '2', '金川区', 'Jinchuan District', '');
INSERT INTO `feel_region` VALUES (2508, '1', '62', '3', '21', '永昌县', 'Yongchang County', '');
INSERT INTO `feel_region` VALUES (2509, '1', '62', '4', '2', '白银区', 'Silver area', '');
INSERT INTO `feel_region` VALUES (2510, '1', '62', '4', '3', '平川区', 'Pingchuan District', '');
INSERT INTO `feel_region` VALUES (2511, '1', '62', '4', '21', '靖远县', 'Jingyuan County', '');
INSERT INTO `feel_region` VALUES (2512, '1', '62', '4', '22', '会宁县', 'Huining County', '');
INSERT INTO `feel_region` VALUES (2513, '1', '62', '4', '23', '景泰县', 'Jingtai County', '');
INSERT INTO `feel_region` VALUES (2514, '1', '62', '5', '2', '秦州区', 'Qinzhou District', '');
INSERT INTO `feel_region` VALUES (2515, '1', '62', '5', '3', '麦积区', 'Maiji District', '');
INSERT INTO `feel_region` VALUES (2516, '1', '62', '5', '21', '清水县', 'Qingshui County', '');
INSERT INTO `feel_region` VALUES (2517, '1', '62', '5', '22', '秦安县', 'Qin\'an County', '');
INSERT INTO `feel_region` VALUES (2518, '1', '62', '5', '23', '甘谷县', 'Gangu County', '');
INSERT INTO `feel_region` VALUES (2519, '1', '62', '5', '24', '武山县', 'Wushan County', '');
INSERT INTO `feel_region` VALUES (2520, '1', '62', '5', '25', '张家川回族自治县', 'Zhangjiachuan Hui Autonomous County', '');
INSERT INTO `feel_region` VALUES (2521, '1', '62', '6', '2', '凉州区', 'Liangzhou District', '');
INSERT INTO `feel_region` VALUES (2522, '1', '62', '6', '21', '民勤县', 'Minqin County', '');
INSERT INTO `feel_region` VALUES (2523, '1', '62', '6', '22', '古浪县', 'Gulang County', '');
INSERT INTO `feel_region` VALUES (2524, '1', '62', '6', '23', '天祝藏族自治县', 'Tianzhu Tibetan Autonomous County', '');
INSERT INTO `feel_region` VALUES (2525, '1', '62', '7', '2', '甘州区', 'Ganzhou District', '');
INSERT INTO `feel_region` VALUES (2526, '1', '62', '7', '21', '肃南裕固族自治县', 'Sunan Yugu Autonomous County', '');
INSERT INTO `feel_region` VALUES (2527, '1', '62', '7', '22', '民乐县', 'Minle County', '');
INSERT INTO `feel_region` VALUES (2528, '1', '62', '7', '23', '临泽县', 'Linze County', '');
INSERT INTO `feel_region` VALUES (2529, '1', '62', '7', '24', '高台县', 'Gaotai County', '');
INSERT INTO `feel_region` VALUES (2530, '1', '62', '7', '25', '山丹县', 'Shandan County', '');
INSERT INTO `feel_region` VALUES (2531, '1', '62', '8', '2', '崆峒区', 'Reclamation area', '');
INSERT INTO `feel_region` VALUES (2532, '1', '62', '8', '21', '泾川县', 'Luanchuan County', '');
INSERT INTO `feel_region` VALUES (2533, '1', '62', '8', '22', '灵台县', 'Lingtai County', '');
INSERT INTO `feel_region` VALUES (2534, '1', '62', '8', '23', '崇信县', 'Chongxin County', '');
INSERT INTO `feel_region` VALUES (2535, '1', '62', '8', '24', '华亭县', 'Huating County', '');
INSERT INTO `feel_region` VALUES (2536, '1', '62', '8', '25', '庄浪县', 'Zhuanglang County', '');
INSERT INTO `feel_region` VALUES (2537, '1', '62', '8', '26', '静宁县', 'Jingning County', '');
INSERT INTO `feel_region` VALUES (2538, '1', '62', '9', '2', '肃州区', 'Suzhou District', '');
INSERT INTO `feel_region` VALUES (2539, '1', '62', '9', '21', '金塔县', 'Jinta County', '');
INSERT INTO `feel_region` VALUES (2540, '1', '62', '9', '22', '瓜州县', 'Guazhou County', '');
INSERT INTO `feel_region` VALUES (2541, '1', '62', '9', '23', '肃北蒙古族自治县', 'Subei Mongolian Autonomous County', '');
INSERT INTO `feel_region` VALUES (2542, '1', '62', '9', '24', '阿克塞哈萨克族自治县', 'Akesai Kazakh Autonomous County', '');
INSERT INTO `feel_region` VALUES (2543, '1', '62', '9', '81', '玉门市', 'Yumen City', '');
INSERT INTO `feel_region` VALUES (2544, '1', '62', '9', '82', '敦煌市', 'Dunhuang City', '');
INSERT INTO `feel_region` VALUES (2545, '1', '62', '10', '2', '西峰区', 'Xifeng District', '');
INSERT INTO `feel_region` VALUES (2546, '1', '62', '10', '21', '庆城县', 'Qingcheng County', '');
INSERT INTO `feel_region` VALUES (2547, '1', '62', '10', '22', '环　县', 'Huan County', '');
INSERT INTO `feel_region` VALUES (2548, '1', '62', '10', '23', '华池县', 'Huachi County', '');
INSERT INTO `feel_region` VALUES (2549, '1', '62', '10', '24', '合水县', 'Heshui County', '');
INSERT INTO `feel_region` VALUES (2550, '1', '62', '10', '25', '正宁县', 'Zhengning County', '');
INSERT INTO `feel_region` VALUES (2551, '1', '62', '10', '26', '宁　县', 'Ning County', '');
INSERT INTO `feel_region` VALUES (2552, '1', '62', '10', '27', '镇原县', 'Zhenyuan County', '');
INSERT INTO `feel_region` VALUES (2553, '1', '62', '11', '2', '安定区', 'Anding District', '');
INSERT INTO `feel_region` VALUES (2554, '1', '62', '11', '21', '通渭县', 'Tongyu County', '');
INSERT INTO `feel_region` VALUES (2555, '1', '62', '11', '22', '陇西县', 'Luxi County', '');
INSERT INTO `feel_region` VALUES (2556, '1', '62', '11', '23', '渭源县', 'Wuyuan County', '');
INSERT INTO `feel_region` VALUES (2557, '1', '62', '11', '24', '临洮县', 'Linyi County', '');
INSERT INTO `feel_region` VALUES (2558, '1', '62', '11', '25', '漳　县', '县 County', '');
INSERT INTO `feel_region` VALUES (2559, '1', '62', '11', '26', '岷　县', '县 County', '');
INSERT INTO `feel_region` VALUES (2560, '1', '62', '12', '2', '武都区', 'Wudu District', '');
INSERT INTO `feel_region` VALUES (2561, '1', '62', '12', '21', '成　县', 'Cheng County', '');
INSERT INTO `feel_region` VALUES (2562, '1', '62', '12', '22', '文　县', 'Wen County', '');
INSERT INTO `feel_region` VALUES (2563, '1', '62', '12', '23', '宕昌县', 'Suichang County', '');
INSERT INTO `feel_region` VALUES (2564, '1', '62', '12', '24', '康　县', 'Kang County', '');
INSERT INTO `feel_region` VALUES (2565, '1', '62', '12', '25', '西和县', 'Xihe County', '');
INSERT INTO `feel_region` VALUES (2566, '1', '62', '12', '26', '礼　县', 'Li County', '');
INSERT INTO `feel_region` VALUES (2567, '1', '62', '12', '27', '徽　县', 'Hui County', '');
INSERT INTO `feel_region` VALUES (2568, '1', '62', '12', '28', '两当县', 'Liangdang County', '');
INSERT INTO `feel_region` VALUES (2569, '1', '62', '29', '1', '临夏市', 'Linxia City', '');
INSERT INTO `feel_region` VALUES (2570, '1', '62', '29', '21', '临夏县', 'Linxia County', '');
INSERT INTO `feel_region` VALUES (2571, '1', '62', '29', '22', '康乐县', 'Kangle County', '');
INSERT INTO `feel_region` VALUES (2572, '1', '62', '29', '23', '永靖县', 'Yongjing County', '');
INSERT INTO `feel_region` VALUES (2573, '1', '62', '29', '24', '广河县', 'Guanghe County', '');
INSERT INTO `feel_region` VALUES (2574, '1', '62', '29', '25', '和政县', 'Hezheng County', '');
INSERT INTO `feel_region` VALUES (2575, '1', '62', '29', '26', '东乡族自治县', 'Dongxiang Autonomous County', '');
INSERT INTO `feel_region` VALUES (2576, '1', '62', '29', '27', '积石山保安族东乡族撒拉族自治县', 'Jishishan Baoanzu Dongxiang Sala Autonomous County', '');
INSERT INTO `feel_region` VALUES (2577, '1', '62', '30', '1', '合作市', 'Cooperation city', '');
INSERT INTO `feel_region` VALUES (2578, '1', '62', '30', '21', '临潭县', 'Lintan County', '');
INSERT INTO `feel_region` VALUES (2579, '1', '62', '30', '22', '卓尼县', 'Zhuoni County', '');
INSERT INTO `feel_region` VALUES (2580, '1', '62', '30', '23', '舟曲县', 'Zhouqu County', '');
INSERT INTO `feel_region` VALUES (2581, '1', '62', '30', '24', '迭部县', 'Diebu County', '');
INSERT INTO `feel_region` VALUES (2582, '1', '62', '30', '25', '玛曲县', 'Maqu County', '');
INSERT INTO `feel_region` VALUES (2583, '1', '62', '30', '26', '碌曲县', 'Luqu County', '');
INSERT INTO `feel_region` VALUES (2584, '1', '62', '30', '27', '夏河县', 'Xiahe County', '');
INSERT INTO `feel_region` VALUES (2585, '1', '63', '1', '2', '城东区', 'Chengdong District', '');
INSERT INTO `feel_region` VALUES (2586, '1', '63', '1', '3', '城中区', 'Chengzhong District', '');
INSERT INTO `feel_region` VALUES (2587, '1', '63', '1', '4', '城西区', 'West District', '');
INSERT INTO `feel_region` VALUES (2588, '1', '63', '1', '5', '城北区', 'Chengbei District', '');
INSERT INTO `feel_region` VALUES (2589, '1', '63', '1', '21', '大通回族土族自治县', 'Datong Hui Nationality Autonomous County', '');
INSERT INTO `feel_region` VALUES (2590, '1', '63', '1', '22', '湟中县', 'Yuzhong County', '');
INSERT INTO `feel_region` VALUES (2591, '1', '63', '1', '23', '湟源县', 'Wuyuan County', '');
INSERT INTO `feel_region` VALUES (2592, '1', '63', '21', '21', '平安县', 'Pingan County', '');
INSERT INTO `feel_region` VALUES (2593, '1', '63', '21', '22', '民和回族土族自治县', 'Minhe Hui Nationality Autonomous County', '');
INSERT INTO `feel_region` VALUES (2594, '1', '63', '21', '23', '乐都县', 'Ledu County', '');
INSERT INTO `feel_region` VALUES (2595, '1', '63', '21', '26', '互助土族自治县', 'Mutual Autonomous County', '');
INSERT INTO `feel_region` VALUES (2596, '1', '63', '21', '27', '化隆回族自治县', 'Hualong Hui Autonomous County', '');
INSERT INTO `feel_region` VALUES (2597, '1', '63', '21', '28', '循化撒拉族自治县', 'Xunhua Salar Autonomous County', '');
INSERT INTO `feel_region` VALUES (2598, '1', '63', '22', '21', '门源回族自治县', 'Menyuan Hui Autonomous County', '');
INSERT INTO `feel_region` VALUES (2599, '1', '63', '22', '22', '祁连县', 'Qilian County', '');
INSERT INTO `feel_region` VALUES (2600, '1', '63', '22', '23', '海晏县', 'Haitang County', '');
INSERT INTO `feel_region` VALUES (2601, '1', '63', '22', '24', '刚察县', 'Gangcha County', '');
INSERT INTO `feel_region` VALUES (2602, '1', '63', '23', '21', '同仁县', 'Tongren County', '');
INSERT INTO `feel_region` VALUES (2603, '1', '63', '23', '22', '尖扎县', 'Jianzha County', '');
INSERT INTO `feel_region` VALUES (2604, '1', '63', '23', '23', '泽库县', 'Zeku County', '');
INSERT INTO `feel_region` VALUES (2605, '1', '63', '23', '24', '河南蒙古族自治县', 'Henan Mongolian Autonomous County', '');
INSERT INTO `feel_region` VALUES (2606, '1', '63', '25', '21', '共和县', 'Gonghe County', '');
INSERT INTO `feel_region` VALUES (2607, '1', '63', '25', '22', '同德县', 'Tongde County', '');
INSERT INTO `feel_region` VALUES (2608, '1', '63', '25', '23', '贵德县', 'Guide County', '');
INSERT INTO `feel_region` VALUES (2609, '1', '63', '25', '24', '兴海县', 'Xinghai County', '');
INSERT INTO `feel_region` VALUES (2610, '1', '63', '25', '25', '贵南县', 'Guinan County', '');
INSERT INTO `feel_region` VALUES (2611, '1', '63', '26', '21', '玛沁县', 'Malang County', '');
INSERT INTO `feel_region` VALUES (2612, '1', '63', '26', '22', '班玛县', 'Banma County', '');
INSERT INTO `feel_region` VALUES (2613, '1', '63', '26', '23', '甘德县', 'Gande County', '');
INSERT INTO `feel_region` VALUES (2614, '1', '63', '26', '24', '达日县', 'Dari County', '');
INSERT INTO `feel_region` VALUES (2615, '1', '63', '26', '25', '久治县', 'Jiuzhi County', '');
INSERT INTO `feel_region` VALUES (2616, '1', '63', '26', '26', '玛多县', 'Maduo County', '');
INSERT INTO `feel_region` VALUES (2617, '1', '63', '27', '21', '玉树县', 'Yushu County', '');
INSERT INTO `feel_region` VALUES (2618, '1', '63', '27', '22', '杂多县', 'Zaduo County', '');
INSERT INTO `feel_region` VALUES (2619, '1', '63', '27', '23', '称多县', 'Duo County', '');
INSERT INTO `feel_region` VALUES (2620, '1', '63', '27', '24', '治多县', 'Zhiduo County', '');
INSERT INTO `feel_region` VALUES (2621, '1', '63', '27', '25', '囊谦县', 'Nangqian County', '');
INSERT INTO `feel_region` VALUES (2622, '1', '63', '27', '26', '曲麻莱县', 'Qumalai County', '');
INSERT INTO `feel_region` VALUES (2623, '1', '63', '28', '1', '格尔木市', 'Golmud', '');
INSERT INTO `feel_region` VALUES (2624, '1', '63', '28', '2', '德令哈市', 'Delingha', '');
INSERT INTO `feel_region` VALUES (2625, '1', '63', '28', '21', '乌兰县', 'Wulan County', '');
INSERT INTO `feel_region` VALUES (2626, '1', '63', '28', '22', '都兰县', 'Dulan County', '');
INSERT INTO `feel_region` VALUES (2627, '1', '63', '28', '23', '天峻县', 'Tianjun County', '');
INSERT INTO `feel_region` VALUES (2628, '1', '64', '1', '4', '兴庆区', 'Xingqing District', '');
INSERT INTO `feel_region` VALUES (2629, '1', '64', '1', '5', '西夏区', 'Xixia District', '');
INSERT INTO `feel_region` VALUES (2630, '1', '64', '1', '6', '金凤区', 'Jinfeng District', '');
INSERT INTO `feel_region` VALUES (2631, '1', '64', '1', '21', '永宁县', 'Yongning County', '');
INSERT INTO `feel_region` VALUES (2632, '1', '64', '1', '22', '贺兰县', 'Helan County', '');
INSERT INTO `feel_region` VALUES (2633, '1', '64', '1', '81', '灵武市', 'Lingwu City', '');
INSERT INTO `feel_region` VALUES (2634, '1', '64', '2', '2', '大武口区', 'Dawukou District', '');
INSERT INTO `feel_region` VALUES (2635, '1', '64', '2', '5', '惠农区', 'Huinong District', '');
INSERT INTO `feel_region` VALUES (2636, '1', '64', '2', '21', '平罗县', 'Pingluo County', '');
INSERT INTO `feel_region` VALUES (2637, '1', '64', '3', '2', '利通区', 'Litong District', '');
INSERT INTO `feel_region` VALUES (2638, '1', '64', '3', '3', '红寺堡区', 'Hongsibao District', '');
INSERT INTO `feel_region` VALUES (2639, '1', '64', '3', '23', '盐池县', 'Yanchi County', '');
INSERT INTO `feel_region` VALUES (2640, '1', '64', '3', '24', '同心县', 'Tongxin County', '');
INSERT INTO `feel_region` VALUES (2641, '1', '64', '3', '81', '青铜峡市', 'Qingtongxia City', '');
INSERT INTO `feel_region` VALUES (2642, '1', '64', '4', '2', '原州区', 'Wonju District', '');
INSERT INTO `feel_region` VALUES (2643, '1', '64', '4', '22', '西吉县', 'Xiji County', '');
INSERT INTO `feel_region` VALUES (2644, '1', '64', '4', '23', '隆德县', 'Longde County', '');
INSERT INTO `feel_region` VALUES (2645, '1', '64', '4', '24', '泾源县', 'Wuyuan County', '');
INSERT INTO `feel_region` VALUES (2646, '1', '64', '4', '25', '彭阳县', 'Pengyang County', '');
INSERT INTO `feel_region` VALUES (2647, '1', '64', '5', '2', '沙坡头区', 'Shapotou District', '');
INSERT INTO `feel_region` VALUES (2648, '1', '64', '5', '21', '中宁县', 'Zhongning County', '');
INSERT INTO `feel_region` VALUES (2649, '1', '64', '5', '22', '海原县', 'Haiyuan County', '');
INSERT INTO `feel_region` VALUES (2650, '1', '65', '1', '2', '天山区', 'Tianshan District', '');
INSERT INTO `feel_region` VALUES (2651, '1', '65', '1', '3', '沙依巴克区', 'Shaybak District', '');
INSERT INTO `feel_region` VALUES (2652, '1', '65', '1', '4', '新市区', 'New urban area', '');
INSERT INTO `feel_region` VALUES (2653, '1', '65', '1', '5', '水磨沟区', 'Shuimogou District', '');
INSERT INTO `feel_region` VALUES (2654, '1', '65', '1', '6', '头屯河区', 'Toutunhe District', '');
INSERT INTO `feel_region` VALUES (2655, '1', '65', '1', '7', '达坂城区', 'Dabancheng District', '');
INSERT INTO `feel_region` VALUES (2656, '1', '65', '1', '9', '米东区', 'Mido District', '');
INSERT INTO `feel_region` VALUES (2657, '1', '65', '1', '21', '乌鲁木齐县', 'Urumqi County', '');
INSERT INTO `feel_region` VALUES (2658, '1', '65', '2', '2', '独山子区', 'Dushanzi District', '');
INSERT INTO `feel_region` VALUES (2659, '1', '65', '2', '3', '克拉玛依区', 'Karamay District', '');
INSERT INTO `feel_region` VALUES (2660, '1', '65', '2', '4', '白碱滩区', 'Baijitan area', '');
INSERT INTO `feel_region` VALUES (2661, '1', '65', '2', '5', '乌尔禾区', 'Urho District', '');
INSERT INTO `feel_region` VALUES (2662, '1', '65', '21', '1', '吐鲁番市', 'Turpan City', '');
INSERT INTO `feel_region` VALUES (2663, '1', '65', '21', '22', '鄯善县', 'Shanshan County', '');
INSERT INTO `feel_region` VALUES (2664, '1', '65', '21', '23', '托克逊县', 'Toksun County', '');
INSERT INTO `feel_region` VALUES (2665, '1', '65', '22', '1', '哈密市', 'Hami City', '');
INSERT INTO `feel_region` VALUES (2666, '1', '65', '22', '22', '巴里坤哈萨克自治县', 'Balikun Kazakh Autonomous County', '');
INSERT INTO `feel_region` VALUES (2667, '1', '65', '22', '23', '伊吾县', 'Yiwu County', '');
INSERT INTO `feel_region` VALUES (2668, '1', '65', '23', '1', '昌吉市', 'Changji City', '');
INSERT INTO `feel_region` VALUES (2669, '1', '65', '23', '2', '阜康市', 'Fukang City', '');
INSERT INTO `feel_region` VALUES (2670, '1', '65', '23', '23', '呼图壁县', 'Hutubi County', '');
INSERT INTO `feel_region` VALUES (2671, '1', '65', '23', '24', '玛纳斯县', 'Manas County', '');
INSERT INTO `feel_region` VALUES (2672, '1', '65', '23', '25', '奇台县', 'Qitai County', '');
INSERT INTO `feel_region` VALUES (2673, '1', '65', '23', '27', '吉木萨尔县', 'Jimsar County', '');
INSERT INTO `feel_region` VALUES (2674, '1', '65', '23', '28', '木垒哈萨克自治县', 'Mulei Kazakh Autonomous County', '');
INSERT INTO `feel_region` VALUES (2675, '1', '65', '27', '1', '博乐市', 'Bole City', '');
INSERT INTO `feel_region` VALUES (2676, '1', '65', '27', '22', '精河县', 'Jinghe County', '');
INSERT INTO `feel_region` VALUES (2677, '1', '65', '27', '23', '温泉县', 'Hot spring county', '');
INSERT INTO `feel_region` VALUES (2678, '1', '65', '28', '1', '库尔勒市', 'Korla', '');
INSERT INTO `feel_region` VALUES (2679, '1', '65', '28', '22', '轮台县', 'Luntai County', '');
INSERT INTO `feel_region` VALUES (2680, '1', '65', '28', '23', '尉犁县', 'Yuli County', '');
INSERT INTO `feel_region` VALUES (2681, '1', '65', '28', '24', '若羌县', 'Rugao County', '');
INSERT INTO `feel_region` VALUES (2682, '1', '65', '28', '25', '且末县', 'Qiemo County', '');
INSERT INTO `feel_region` VALUES (2683, '1', '65', '28', '26', '焉耆回族自治县', 'Min Hui Autonomous County', '');
INSERT INTO `feel_region` VALUES (2684, '1', '65', '28', '27', '和静县', 'Hejing County', '');
INSERT INTO `feel_region` VALUES (2685, '1', '65', '28', '28', '和硕县', 'Heshuo County', '');
INSERT INTO `feel_region` VALUES (2686, '1', '65', '28', '29', '博湖县', 'Bohu County', '');
INSERT INTO `feel_region` VALUES (2687, '1', '65', '29', '1', '阿克苏市', 'Aksu City', '');
INSERT INTO `feel_region` VALUES (2688, '1', '65', '29', '22', '温宿县', 'Wensu County', '');
INSERT INTO `feel_region` VALUES (2689, '1', '65', '29', '23', '库车县', 'Kuche County', '');
INSERT INTO `feel_region` VALUES (2690, '1', '65', '29', '24', '沙雅县', 'Shaya County', '');
INSERT INTO `feel_region` VALUES (2691, '1', '65', '29', '25', '新和县', 'Xinhe County', '');
INSERT INTO `feel_region` VALUES (2692, '1', '65', '29', '26', '拜城县', 'Baicheng County', '');
INSERT INTO `feel_region` VALUES (2693, '1', '65', '29', '27', '乌什县', 'Wushi County', '');
INSERT INTO `feel_region` VALUES (2694, '1', '65', '29', '28', '阿瓦提县', 'Awati County', '');
INSERT INTO `feel_region` VALUES (2695, '1', '65', '29', '29', '柯坪县', 'Keping County', '');
INSERT INTO `feel_region` VALUES (2696, '1', '65', '30', '1', '阿图什市', 'Atushi', '');
INSERT INTO `feel_region` VALUES (2697, '1', '65', '30', '22', '阿克陶县', 'Akto County', '');
INSERT INTO `feel_region` VALUES (2698, '1', '65', '30', '23', '阿合奇县', 'Aheqi County', '');
INSERT INTO `feel_region` VALUES (2699, '1', '65', '30', '24', '乌恰县', 'Wuqia County', '');
INSERT INTO `feel_region` VALUES (2700, '1', '65', '31', '1', '喀什市', 'Kashgar', '');
INSERT INTO `feel_region` VALUES (2701, '1', '65', '31', '21', '疏附县', 'Shufu County', '');
INSERT INTO `feel_region` VALUES (2702, '1', '65', '31', '22', '疏勒县', 'Shule County', '');
INSERT INTO `feel_region` VALUES (2703, '1', '65', '31', '23', '英吉沙县', 'Yingjisha County', '');
INSERT INTO `feel_region` VALUES (2704, '1', '65', '31', '24', '泽普县', 'Zepu County', '');
INSERT INTO `feel_region` VALUES (2705, '1', '65', '31', '25', '莎车县', 'Shache County', '');
INSERT INTO `feel_region` VALUES (2706, '1', '65', '31', '26', '叶城县', 'Yecheng County', '');
INSERT INTO `feel_region` VALUES (2707, '1', '65', '31', '27', '麦盖提县', 'Makati County', '');
INSERT INTO `feel_region` VALUES (2708, '1', '65', '31', '28', '岳普湖县', 'Yuepuhu County', '');
INSERT INTO `feel_region` VALUES (2709, '1', '65', '31', '29', '伽师县', 'Jiashi County', '');
INSERT INTO `feel_region` VALUES (2710, '1', '65', '31', '30', '巴楚县', 'Bachu County', '');
INSERT INTO `feel_region` VALUES (2711, '1', '65', '31', '31', '塔什库尔干塔吉克自治县', 'Tashkurgan Tajik Autonomous County', '');
INSERT INTO `feel_region` VALUES (2712, '1', '65', '32', '1', '和田市', 'Wada', '');
INSERT INTO `feel_region` VALUES (2713, '1', '65', '32', '21', '和田县', 'Hotan County', '');
INSERT INTO `feel_region` VALUES (2714, '1', '65', '32', '22', '墨玉县', 'Moyu County', '');
INSERT INTO `feel_region` VALUES (2715, '1', '65', '32', '23', '皮山县', 'Pishan County', '');
INSERT INTO `feel_region` VALUES (2716, '1', '65', '32', '24', '洛浦县', 'Luopu County', '');
INSERT INTO `feel_region` VALUES (2717, '1', '65', '32', '25', '策勒县', 'Celle County', '');
INSERT INTO `feel_region` VALUES (2718, '1', '65', '32', '26', '于田县', 'Yutian County', '');
INSERT INTO `feel_region` VALUES (2719, '1', '65', '32', '27', '民丰县', 'Minfeng County', '');
INSERT INTO `feel_region` VALUES (2720, '1', '65', '40', '2', '伊宁市', 'Yining City', '');
INSERT INTO `feel_region` VALUES (2721, '1', '65', '40', '3', '奎屯市', 'Kuitun City', '');
INSERT INTO `feel_region` VALUES (2722, '1', '65', '40', '21', '伊宁县', 'Yining County', '');
INSERT INTO `feel_region` VALUES (2723, '1', '65', '40', '22', '察布查尔锡伯自治县', 'Chabuchar Xibe Autonomous County', '');
INSERT INTO `feel_region` VALUES (2724, '1', '65', '40', '23', '霍城县', 'Huocheng County', '');
INSERT INTO `feel_region` VALUES (2725, '1', '65', '40', '24', '巩留县', 'Gongliu County', '');
INSERT INTO `feel_region` VALUES (2726, '1', '65', '40', '25', '新源县', 'Xinyuan County', '');
INSERT INTO `feel_region` VALUES (2727, '1', '65', '40', '26', '昭苏县', 'Zhaosu County', '');
INSERT INTO `feel_region` VALUES (2728, '1', '65', '40', '27', '特克斯县', 'Turks County', '');
INSERT INTO `feel_region` VALUES (2729, '1', '65', '40', '28', '尼勒克县', 'Nilek County', '');
INSERT INTO `feel_region` VALUES (2730, '1', '65', '42', '1', '塔城市', 'Tower city', '');
INSERT INTO `feel_region` VALUES (2731, '1', '65', '42', '2', '乌苏市', 'Wusu City', '');
INSERT INTO `feel_region` VALUES (2732, '1', '65', '42', '21', '额敏县', 'Emin County', '');
INSERT INTO `feel_region` VALUES (2733, '1', '65', '42', '23', '沙湾县', 'Shawan County', '');
INSERT INTO `feel_region` VALUES (2734, '1', '65', '42', '24', '托里县', 'Tori County', '');
INSERT INTO `feel_region` VALUES (2735, '1', '65', '42', '25', '裕民县', 'Yumin County', '');
INSERT INTO `feel_region` VALUES (2736, '1', '65', '42', '26', '和布克赛尔蒙古自治县', 'And Buxail Mongolian Autonomous County', '');
INSERT INTO `feel_region` VALUES (2737, '1', '65', '43', '1', '阿勒泰市', 'Altay City', '');
INSERT INTO `feel_region` VALUES (2738, '1', '65', '43', '21', '布尔津县', 'Burqin County', '');
INSERT INTO `feel_region` VALUES (2739, '1', '65', '43', '22', '富蕴县', 'Fuyun County', '');
INSERT INTO `feel_region` VALUES (2740, '1', '65', '43', '23', '福海县', 'Fuhai County', '');
INSERT INTO `feel_region` VALUES (2741, '1', '65', '43', '24', '哈巴河县', 'Habahe County', '');
INSERT INTO `feel_region` VALUES (2742, '1', '65', '43', '25', '青河县', 'Qinghe County', '');
INSERT INTO `feel_region` VALUES (2743, '1', '65', '43', '26', '吉木乃县', 'Jimunai County', '');

-- ----------------------------
-- Table structure for feel_reply_comment
-- ----------------------------
DROP TABLE IF EXISTS `feel_reply_comment`;
CREATE TABLE `feel_reply_comment`  (
  `comment_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `member_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '评论人',
  `ticket_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '工单ID',
  `reply_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '回复ID',
  `comment_type` char(7) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '评论类型 reply 工单回复评论  inside 内部协作回复评论',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '评论内容',
  `create_time` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '评论时间',
  PRIMARY KEY (`comment_id`) USING BTREE,
  INDEX `comment_index`(`company_id`, `reply_id`, `comment_type`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of feel_reply_comment
-- ----------------------------

-- ----------------------------
-- Table structure for feel_role
-- ----------------------------
DROP TABLE IF EXISTS `feel_role`;
CREATE TABLE `feel_role`  (
  `role_id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '管理员类型ID',
  `part_id` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '角色UUID',
  `original_id` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '角色在第三方系统中的ID',
  `company_id` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `role_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '管理员类型名称',
  `closed` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '启用状态',
  `create_ip` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `create_time` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `is_supper` tinyint(2) UNSIGNED NOT NULL DEFAULT 10 COMMENT '是否是超级管理员 10 不是 20 是',
  `is_default` tinyint(2) UNSIGNED NOT NULL DEFAULT 20 COMMENT '默认角色 10 是 20 否',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = FIXED;

-- ----------------------------
-- Records of feel_role
-- ----------------------------
INSERT INTO `feel_role` VALUES (1, 'F7207b8e80764e190ce0942baf196766', '', 1, '超级管理员', 0, '127.0.0.1', 1623987441, 20, 10);

-- ----------------------------
-- Table structure for feel_role_auth
-- ----------------------------
DROP TABLE IF EXISTS `feel_role_auth`;
CREATE TABLE `feel_role_auth`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `role_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '角色ID',
  `company_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '公司ID',
  `menu_id` json NULL COMMENT '角色权限Json数据',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `role_auth_index`(`company_id`, `role_id`) USING BTREE,
  INDEX `role_id_index`(`role_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of feel_role_auth
-- ----------------------------
INSERT INTO `feel_role_auth` VALUES (1, 1, 1, '[\"1\", \"2\", \"3\", \"4\", \"5\", \"6\", \"7\", \"8\", \"9\", \"10\", \"11\", \"12\", \"13\", \"14\", \"15\", \"16\", \"17\", \"18\", \"19\", \"20\", \"21\", \"22\", \"23\", \"50\", \"51\", \"52\", \"53\", \"54\", \"55\", \"56\", \"57\", \"58\", \"59\", \"60\", \"61\", \"62\", \"63\", \"64\", \"65\", \"87\", \"88\", \"89\", \"90\", \"91\", \"93\", \"95\", \"98\", \"99\", \"100\", \"101\", \"102\", \"103\", \"104\", \"105\", \"106\", \"107\", \"108\", \"109\", \"110\", \"111\", \"112\", \"116\", \"117\", \"118\", \"128\", \"129\", \"130\", \"131\", \"132\", \"133\", \"134\", \"156\", \"158\", \"159\", \"160\", \"162\", \"185\", \"188\", \"189\", \"190\", \"191\", \"200\", \"201\", \"202\", \"203\", \"204\", \"205\", \"206\", \"207\", \"208\", \"209\", \"210\", \"211\", \"212\", \"213\", \"223\", \"224\", \"225\", \"226\", \"227\", \"228\", \"229\", \"230\", \"237\", \"238\"]');

-- ----------------------------
-- Table structure for feel_route
-- ----------------------------
DROP TABLE IF EXISTS `feel_route`;
CREATE TABLE `feel_route`  (
  `route_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `route_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '路由名称',
  `channel` enum('template','mail') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'template' COMMENT '渠道来源',
  `route_value` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '规则值',
  `group_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '默认处理部门',
  `create_time` int(11) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`route_id`) USING BTREE,
  INDEX `route_index_1`(`company_id`, `channel`, `route_value`, `group_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of feel_route
-- ----------------------------

-- ----------------------------
-- Table structure for feel_satisfaction
-- ----------------------------
DROP TABLE IF EXISTS `feel_satisfaction`;
CREATE TABLE `feel_satisfaction`  (
  `satisfy_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `satisfy_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '满意项名称',
  `name_en` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `name_jp` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `score` int(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '满意项分值',
  PRIMARY KEY (`satisfy_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of feel_satisfaction
-- ----------------------------
INSERT INTO `feel_satisfaction` VALUES (1, 1, '非常不满意', 'Very dissatisfied', '非常に満足していない', 1);
INSERT INTO `feel_satisfaction` VALUES (2, 1, '不满意', 'Dissatisfied', '気に入らない', 2);
INSERT INTO `feel_satisfaction` VALUES (3, 1, '一般', 'Commonly', '普通', 3);
INSERT INTO `feel_satisfaction` VALUES (4, 1, '满意', 'Satisfied', '満足する', 4);
INSERT INTO `feel_satisfaction` VALUES (5, 1, '非常满意', 'Very satisfied', '非常に満足している', 5);

-- ----------------------------
-- Table structure for feel_satisfy_label
-- ----------------------------
DROP TABLE IF EXISTS `feel_satisfy_label`;
CREATE TABLE `feel_satisfy_label`  (
  `label_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `satisfy_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '满意项ID',
  `label_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '满意项标签名称',
  `name_en` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `name_jp` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`label_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of feel_satisfy_label
-- ----------------------------
INSERT INTO `feel_satisfy_label` VALUES (1, 1, 1, '服务非常差', '', '');
INSERT INTO `feel_satisfy_label` VALUES (2, 1, 2, '服务很差', '', '');
INSERT INTO `feel_satisfy_label` VALUES (3, 1, 3, '服务一般', '', '');
INSERT INTO `feel_satisfy_label` VALUES (4, 1, 4, '服务很好', '', '');
INSERT INTO `feel_satisfy_label` VALUES (5, 1, 5, '服务非常好', '', '');

-- ----------------------------
-- Table structure for feel_session
-- ----------------------------
DROP TABLE IF EXISTS `feel_session`;
CREATE TABLE `feel_session`  (
  `session_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `session_expire` int(11) NOT NULL,
  `session_data` blob NULL,
  UNIQUE INDEX `session_id`(`session_id`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of feel_session
-- ----------------------------

-- ----------------------------
-- Table structure for feel_setting
-- ----------------------------
DROP TABLE IF EXISTS `feel_setting`;
CREATE TABLE `feel_setting`  (
  `key` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `value` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL
) ENGINE = MyISAM CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of feel_setting
-- ----------------------------

-- ----------------------------
-- Table structure for feel_sms
-- ----------------------------
DROP TABLE IF EXISTS `feel_sms`;
CREATE TABLE `feel_sms`  (
  `sms_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `account` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `password` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `balance` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '余额',
  `is_open` tinyint(1) UNSIGNED NOT NULL DEFAULT 2 COMMENT '是否开启短信功能，1 开启 2 关闭',
  `sms_from` enum('Elephant','ChuangLan','BaiWu') CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '短信渠道',
  `business_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '百悟业务代码',
  `update_time` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `create_ip` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `create_time` int(11) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`sms_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of feel_sms
-- ----------------------------

-- ----------------------------
-- Table structure for feel_stop_timing
-- ----------------------------
DROP TABLE IF EXISTS `feel_stop_timing`;
CREATE TABLE `feel_stop_timing`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `ticket_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `status_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '需要停止计时的状态ID',
  `start_time` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '状态变更开始时间',
  `close_time` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '状态变更结束时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `ticket_stop`(`company_id`, `ticket_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = FIXED;

-- ----------------------------
-- Records of feel_stop_timing
-- ----------------------------

-- ----------------------------
-- Table structure for feel_storage
-- ----------------------------
DROP TABLE IF EXISTS `feel_storage`;
CREATE TABLE `feel_storage`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `storage_space` tinyint(2) UNSIGNED NOT NULL DEFAULT 10 COMMENT '存储配置 10 本地  20 七牛云',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = FIXED;

-- ----------------------------
-- Records of feel_storage
-- ----------------------------
INSERT INTO `feel_storage` VALUES (1, 1, 10);

-- ----------------------------
-- Table structure for feel_sub_event
-- ----------------------------
DROP TABLE IF EXISTS `feel_sub_event`;
CREATE TABLE `feel_sub_event`  (
  `event_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `ticket_id` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `member_id` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `dispose_id` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `reply_id` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `status_id` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `ip` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `event_type` enum('create','modify','reply','status','assign','delete','recover') CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '事件类型',
  `user_agent` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '浏览器标识',
  `create_time` int(11) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`event_id`) USING BTREE,
  INDEX `event_index`(`company_id`, `ticket_id`, `member_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of feel_sub_event
-- ----------------------------

-- ----------------------------
-- Table structure for feel_sub_reply
-- ----------------------------
DROP TABLE IF EXISTS `feel_sub_reply`;
CREATE TABLE `feel_sub_reply`  (
  `reply_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `ticket_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '子工单ID',
  `member_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '回复人ID',
  `look` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '是否查看，用于判断最新回复：1 未查看，2 已查看',
  `reply_content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '回复内容',
  `reply_from` enum('system','mail') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'system' COMMENT '回复来源',
  `reply_time` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '回复时间',
  PRIMARY KEY (`reply_id`) USING BTREE,
  INDEX `index_1`(`company_id`, `ticket_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of feel_sub_reply
-- ----------------------------

-- ----------------------------
-- Table structure for feel_sub_ticket
-- ----------------------------
DROP TABLE IF EXISTS `feel_sub_ticket`;
CREATE TABLE `feel_sub_ticket`  (
  `ticket_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `ticket_no` varchar(18) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '子工单编号',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '子工单标题',
  `parent_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '父级工单ID',
  `member_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '子工单发布人ID',
  `group_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '子工单所属部门ID',
  `process_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '子工单处理人ID',
  `status_id` tinyint(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '子工单状态 10 处理中，20 已完成',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '子工单内容',
  `photo` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '上传图片',
  `been` enum('updated','created') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'created',
  `assign_time` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '分配时间',
  `process_time` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '处理时间',
  `update_time` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '更新时间',
  `end_time` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '完成时间',
  `create_time` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '创建时间',
  `is_delete` tinyint(2) UNSIGNED NOT NULL DEFAULT 10 COMMENT '删除状态，10 正常 20 删除',
  `delete_member_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '删除操作人',
  `delete_ip` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '删除操作IP',
  `delete_time` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '删除时间，加入回收站',
  PRIMARY KEY (`ticket_id`) USING BTREE,
  INDEX `index_1`(`company_id`, `parent_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of feel_sub_ticket
-- ----------------------------

-- ----------------------------
-- Table structure for feel_system_message
-- ----------------------------
DROP TABLE IF EXISTS `feel_system_message`;
CREATE TABLE `feel_system_message`  (
  `msg_id` int(11) NOT NULL AUTO_INCREMENT,
  `company_id` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `ticket_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '工单ID',
  `sub_ticket_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '子工单ID',
  `category` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '消息分类 \r\nhandle 工单流程通知；\r\nurge 催单通知;\r\nend 工单结束通知;crm_customer crm客户通知;crm_order crm订单通知',
  `customer_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '客户id',
  `order_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '订单id',
  `contract_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '合同id',
  `receipt_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '收款id',
  `invoice_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '发票id',
  `recipient_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '接收人ID',
  `recipient` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '接收人类型 1 用户,2 客户',
  `urge_member_id` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `msg_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '消息模板类型 \r\n修改工单通知发布人：editor_ticket\r\n回复工单通知发布人：reply_ticket\r\n分配工单通知处理人：assign_ticket\r\n工单回复通知处理人：dispose_reply_ticket\r\n内部回复通知处理人：dispose_team_reply\r\n重启工单通知处理人：restart_ticket\r\n超时工单通知处理人：timeout_ticket\r\n发布工单通知抄送人：cc_ticket\r\n工单回复通知抄送人：cc_reply_ticket\r\n内部回复通知抄送人：cc_team_reply\r\n评论回复通知回复人：comment_reply\r\n催促工单通知被催人：urge_ticket\r\n分配工单通知管理员：assign_group_manager\r\n自动任务：automation\r\n工单触发器：trigger\r\n\r\n\r\ncrm_allot_customer\r\ncrm_draw_customer\r\ncrm_transfer_customer\r\ncrm_follow_customer\r\ncrm_new_customer\r\ncrm_new_order',
  `msg_title` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '消息标题',
  `msg_content` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '消息内容',
  `msg_url` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `read_status` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '读取状态 1 未读  2 已读',
  `is_remind` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '是否已经提醒 1 未提醒 2 已提醒',
  `msg_system` enum('ticket','crm','plan') CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'ticket',
  `create_time` int(11) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`msg_id`) USING BTREE,
  INDEX `msg_index2`(`msg_id`, `recipient_id`, `recipient`) USING BTREE,
  INDEX `msg_index1`(`company_id`, `recipient_id`, `recipient`, `read_status`, `is_remind`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of feel_system_message
-- ----------------------------

-- ----------------------------
-- Table structure for feel_team_reply
-- ----------------------------
DROP TABLE IF EXISTS `feel_team_reply`;
CREATE TABLE `feel_team_reply`  (
  `reply_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `member_id` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `ticket_id` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `cc_member_id` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '当前回复相关抄送人',
  `look` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '查看状态 1 未查看 2已查看',
  `reply_content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `reply_from` enum('system','mail') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'system',
  `reply_ip` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `reply_time` int(11) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`reply_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of feel_team_reply
-- ----------------------------

-- ----------------------------
-- Table structure for feel_temp_type
-- ----------------------------
DROP TABLE IF EXISTS `feel_temp_type`;
CREATE TABLE `feel_temp_type`  (
  `type_id` int(11) NOT NULL AUTO_INCREMENT,
  `type_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `type_form` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '1 邮件 2短信',
  PRIMARY KEY (`type_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of feel_temp_type
-- ----------------------------

-- ----------------------------
-- Table structure for feel_template_type
-- ----------------------------
DROP TABLE IF EXISTS `feel_template_type`;
CREATE TABLE `feel_template_type`  (
  `type_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `type_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `name_en` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `name_jp` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `apply` enum('currency','inside','external') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'currency',
  `closed` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  `sort` tinyint(3) UNSIGNED NOT NULL DEFAULT 100 COMMENT '排序',
  `create_ip` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `create_time` int(11) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`type_id`) USING BTREE,
  INDEX `type_index_1`(`company_id`, `apply`, `type_name`, `closed`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of feel_template_type
-- ----------------------------
INSERT INTO `feel_template_type` VALUES (1, 1, '默认模板类型', 'Default', 'デフォルトのテンプレートタイプ', 'currency', 0, 100, '127.0.0.1', 1623987441);

-- ----------------------------
-- Table structure for feel_ticket
-- ----------------------------
DROP TABLE IF EXISTS `feel_ticket`;
CREATE TABLE `feel_ticket`  (
  `ticket_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '工单ID',
  `ticket_no` varchar(18) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '工单编号',
  `company_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '工单所属公司ID',
  `member_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户ID',
  `firm_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '工单所属客户公司',
  `crm_customer_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT 'CRM中的用户ID',
  `crm_order_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT 'CRM订单ID',
  `crm_contract_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT 'CRM合同id',
  `recipient_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '接收人，第一个接收工单的客服',
  `dispose_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '处理人ID',
  `project_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '项目ID',
  `type_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '模板类型ID',
  `ticket_model_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '工单类型ID',
  `group_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '分派部门id',
  `related_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '客户组件，相关会员ID',
  `related_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '客户组件，相关会员名称',
  `customer_level_id` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `visitor_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '客户组件，相关游客ID',
  `visitor_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '客户组件，相关游客名称',
  `mobile_discrete` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '手机组件，相关手机号码',
  `mail_discrete` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '邮箱组件，相关邮箱',
  `ticket_from` enum('Crm','Service','Wechat','API','Email','Mobile','Visitor','WebChat','Chaterman','PC') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'PC' COMMENT '工单来源',
  `crm_source` enum('contract','order','product','customer') CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'CRM工单来源，客户和订单',
  `api_source` enum('Service','Crm') CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'API来源',
  `title` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '工单标题',
  `content` mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '通过邮件发送的工单内容',
  `wait_assign_status` tinyint(1) NOT NULL DEFAULT -1 COMMENT '-1 未分配 1 已分配',
  `photo` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '工单上传图片',
  `status_id` int(11) UNSIGNED NOT NULL DEFAULT 1 COMMENT '工单状态: 与工单状态ID对应',
  `audit_status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '审核状态 \r\n1 不需要审核 \r\n2 发布工单 - 待审核  \r\n3 已审核\r\n4 发布工单 - 已驳回\r\n5 非发布工单 - 待审核\r\n6 非发布工单 - 已驳回',
  `look` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '查看状态 1 未查看 2 已查看',
  `cclook` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '查看状态 1 未查看 2 已查看',
  `priority` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '工单优先级',
  `dispose_time` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '处理时间',
  `recipient_time` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '接收时间',
  `assign_time` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '分配工单的时间',
  `been` enum('updated','created') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'created' COMMENT '工单动作，created 被创建，updated 被更新',
  `closed` tinyint(1) UNSIGNED NOT NULL DEFAULT 2 COMMENT '关闭状态，1 是 2 否',
  `delete` tinyint(1) UNSIGNED NOT NULL DEFAULT 2 COMMENT '是否进入回收站 1 是 2 否',
  `delete_member_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '删除操作人ID',
  `delete_ip` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '删除时的IP地址',
  `delete_time` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '删除时间',
  `end_time` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '完成时间',
  `create_ip` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '创建IP',
  `update_time` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '更新时间',
  `create_time` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '创建时间',
  PRIMARY KEY (`ticket_id`) USING BTREE,
  INDEX `ticket_index_1`(`ticket_id`, `company_id`, `audit_status`, `status_id`, `dispose_id`, `group_id`) USING BTREE,
  INDEX `ticket_index_2`(`company_id`, `member_id`) USING BTREE,
  INDEX `ticket_index_3`(`ticket_no`, `company_id`) USING BTREE,
  INDEX `ticket_index_4`(`company_id`, `ticket_model_id`) USING BTREE,
  INDEX `publish_ticket`(`company_id`, `delete`, `member_id`) USING BTREE,
  INDEX `dispose_ticket`(`company_id`, `delete`, `dispose_id`) USING BTREE,
  INDEX `wait_reply_member`(`company_id`, `firm_id`, `member_id`, `status_id`, `audit_status`, `look`, `delete`) USING BTREE COMMENT '会员待回复工单索引',
  INDEX `order_index`(`create_time`) USING BTREE COMMENT '时间排序索引'
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '工单表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of feel_ticket
-- ----------------------------

-- ----------------------------
-- Table structure for feel_ticket_area
-- ----------------------------
DROP TABLE IF EXISTS `feel_ticket_area`;
CREATE TABLE `feel_ticket_area`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `country_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '国家编码',
  `province_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '省份编码',
  `city_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '城市编码',
  `region_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '区县编码',
  `ticket_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '工单ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of feel_ticket_area
-- ----------------------------

-- ----------------------------
-- Table structure for feel_ticket_config
-- ----------------------------
DROP TABLE IF EXISTS `feel_ticket_config`;
CREATE TABLE `feel_ticket_config`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `handler_closed` tinyint(2) UNSIGNED NOT NULL DEFAULT 10 COMMENT '处理人关闭工单 10 开启，20 关闭',
  `publisher_closed` tinyint(2) UNSIGNED NOT NULL DEFAULT 10 COMMENT '发布人关闭工单 10 开启 20 关闭',
  `feedback` tinyint(2) UNSIGNED NOT NULL DEFAULT 10 COMMENT '邮件生成工单成功后是否发送成功反馈。10 是 20 否',
  `internal_state` tinyint(2) UNSIGNED NOT NULL DEFAULT 20 COMMENT '内部状态开关，10 开启 20 关闭',
  `end_operate` tinyint(2) UNSIGNED NOT NULL DEFAULT 20 COMMENT '工单在结束后是否可以继续回复。10 是 20 否',
  `status_go_back` tinyint(2) UNSIGNED NOT NULL DEFAULT 20 COMMENT '工单状态是否允许回退 10 是 20 否',
  `handler_go_back` tinyint(2) UNSIGNED NOT NULL DEFAULT 10 COMMENT '处理人回退 10 开启 20关闭',
  `publisher_go_back` tinyint(2) UNSIGNED NOT NULL DEFAULT 20 COMMENT '发布人回退 10 开启 20关闭',
  `overtime` int(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '工单超时配置',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of feel_ticket_config
-- ----------------------------
INSERT INTO `feel_ticket_config` VALUES (1, 1, 10, 10, 10, 20, 20, 20, 10, 20, 0);

-- ----------------------------
-- Table structure for feel_ticket_deadlines
-- ----------------------------
DROP TABLE IF EXISTS `feel_ticket_deadlines`;
CREATE TABLE `feel_ticket_deadlines`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `ticket_id` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `remind_status` tinyint(2) UNSIGNED NOT NULL DEFAULT 20 COMMENT '提醒状态 10 已提醒 20 未提醒',
  `remind_time` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '提醒时间',
  `deadtime` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '完成时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = FIXED;

-- ----------------------------
-- Records of feel_ticket_deadlines
-- ----------------------------

-- ----------------------------
-- Table structure for feel_ticket_detail
-- ----------------------------
DROP TABLE IF EXISTS `feel_ticket_detail`;
CREATE TABLE `feel_ticket_detail`  (
  `ticket_id` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `company_id` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `ticket_form_id` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `ticket_form_content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  INDEX `detail_index`(`ticket_id`, `company_id`, `ticket_form_id`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of feel_ticket_detail
-- ----------------------------

-- ----------------------------
-- Table structure for feel_ticket_event
-- ----------------------------
DROP TABLE IF EXISTS `feel_ticket_event`;
CREATE TABLE `feel_ticket_event`  (
  `event_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `ticket_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '事件相关工单ID',
  `member_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '事件相关用户ID',
  `reply_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '工单回复或者内部协作回复ID',
  `status_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '工单状态ID',
  `associated_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '关联的工单ID',
  `cancel_associate_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '取消关联的工单ID',
  `priority_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '优先级ID',
  `reject_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '会员工单驳回理由ID',
  `modify_record_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '修改记录ID，与修改工单事件绑定',
  `ip` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '操作IP',
  `opinion_id` int(11) NOT NULL COMMENT '用户审批意见ID',
  `event_type` enum('resubmit_audit','pass','reject','priority','recover','delete','comment','urge','cancel_associate','associate','restart','assign','receive','status','progress_node','reply','team_reply','modify','create','assign_operate','follow','unfollow') CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '事件类型',
  `user_agent` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '浏览器标识',
  `create_time` int(11) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`event_id`) USING BTREE,
  INDEX `event_index`(`company_id`, `ticket_id`, `member_id`) USING BTREE,
  INDEX `event_index3`(`company_id`, `create_time`) USING BTREE,
  INDEX `event_index2`(`ticket_id`, `member_id`, `create_time`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of feel_ticket_event
-- ----------------------------

-- ----------------------------
-- Table structure for feel_ticket_follow
-- ----------------------------
DROP TABLE IF EXISTS `feel_ticket_follow`;
CREATE TABLE `feel_ticket_follow`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `member_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '关注人ID',
  `ticket_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '关注工单ID',
  `create_time` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '关注时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = FIXED;

-- ----------------------------
-- Records of feel_ticket_follow
-- ----------------------------

-- ----------------------------
-- Table structure for feel_ticket_form
-- ----------------------------
DROP TABLE IF EXISTS `feel_ticket_form`;
CREATE TABLE `feel_ticket_form`  (
  `ticket_form_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `ticket_model_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '所属工单模型id',
  `company_id` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `ticket_form_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '工单表单名称',
  `ticket_form_description` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '工单表单显示名称',
  `ticket_form_explain` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '工单表单说明',
  `ticket_form_type` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '工单表单类型',
  `ticket_form_option` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '工单表单选项值',
  `is_required` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否必填 0 必填 1选填',
  `closed` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否启用',
  `orderby` int(11) UNSIGNED NOT NULL DEFAULT 100 COMMENT '表单的排序值',
  PRIMARY KEY (`ticket_form_id`) USING BTREE,
  INDEX `form_index`(`company_id`, `ticket_model_id`, `closed`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of feel_ticket_form
-- ----------------------------
INSERT INTO `feel_ticket_form` VALUES (1, 1, 1, 'describe', '问题描述', '', 'textarea', NULL, 0, 0, 100);

-- ----------------------------
-- Table structure for feel_ticket_model
-- ----------------------------
DROP TABLE IF EXISTS `feel_ticket_model`;
CREATE TABLE `feel_ticket_model`  (
  `ticket_model_id` int(11) NOT NULL AUTO_INCREMENT,
  `type_id` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `company_id` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `ticket_model_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `name_en` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `name_jp` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `user_discrete` tinyint(1) UNSIGNED NOT NULL DEFAULT 20 COMMENT '是否启用客户组件 10 启用 20禁用',
  `cc_discrete` tinyint(2) UNSIGNED NOT NULL DEFAULT 20,
  `mobile_discrete` tinyint(2) UNSIGNED NOT NULL DEFAULT 20 COMMENT '手机组件 10 开启 20 关闭',
  `mobile_required` tinyint(2) UNSIGNED NOT NULL DEFAULT 20 COMMENT '手机组件是否必填 10 是 20 否',
  `mail_discrete` tinyint(2) UNSIGNED NOT NULL DEFAULT 20 COMMENT '邮箱组件 10 开启 20 关闭',
  `mail_required` tinyint(2) UNSIGNED NOT NULL DEFAULT 20 COMMENT '邮箱组件是否必填 10 是 20 否',
  `handle_discrete` tinyint(2) UNSIGNED NOT NULL DEFAULT 20 COMMENT '指定处理人组件，10 开启，20 关闭',
  `order_discrete` tinyint(2) UNSIGNED NOT NULL DEFAULT 20 COMMENT '订单组件，10 开启，20 关闭',
  `product_discrete` tinyint(2) UNSIGNED NOT NULL DEFAULT 20 COMMENT '产品组件，10 开启，20 关闭',
  `deadlines_discrete` tinyint(2) UNSIGNED NOT NULL DEFAULT 20 COMMENT '完成期限组件，10 开启，20 关闭',
  `audit_discrete` tinyint(2) UNSIGNED NOT NULL DEFAULT 20 COMMENT '审核组件，10 开启，20 关闭',
  `area_discrete` tinyint(2) UNSIGNED NOT NULL DEFAULT 20 COMMENT '地区组件，10 开启，20 关闭',
  `subject_discrete` tinyint(2) UNSIGNED NOT NULL DEFAULT 20 COMMENT '主题组件，10 开启，20 关闭',
  `project_discrete` tinyint(2) UNSIGNED NOT NULL DEFAULT 20 COMMENT '项目组件 10 开启 20 关闭',
  `sort` int(3) UNSIGNED NOT NULL DEFAULT 100 COMMENT '排序',
  `create_time` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `create_ip` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `closed` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`ticket_model_id`) USING BTREE,
  INDEX `template_index_1`(`company_id`, `ticket_model_id`, `ticket_model_name`, `closed`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of feel_ticket_model
-- ----------------------------
INSERT INTO `feel_ticket_model` VALUES (1, 1, 1, '默认模板', 'Default', 'デフォルトのテンプレート', 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 100, 1623987441, '127.0.0.1', 0);

-- ----------------------------
-- Table structure for feel_ticket_partake
-- ----------------------------
DROP TABLE IF EXISTS `feel_ticket_partake`;
CREATE TABLE `feel_ticket_partake`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `member_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '参与人ID',
  `ticket_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `create_time` int(10) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '我参与的工单' ROW_FORMAT = FIXED;

-- ----------------------------
-- Records of feel_ticket_partake
-- ----------------------------

-- ----------------------------
-- Table structure for feel_ticket_reply
-- ----------------------------
DROP TABLE IF EXISTS `feel_ticket_reply`;
CREATE TABLE `feel_ticket_reply`  (
  `reply_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `ticket_id` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `company_id` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `member_id` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `look` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '查看状态 1 未查看 2已查看',
  `reply_content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `reply_from` enum('system','mail') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'system',
  `reply_ip` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `reply_time` int(11) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`reply_id`) USING BTREE,
  INDEX `reply_index`(`reply_id`, `ticket_id`, `company_id`, `member_id`) USING BTREE,
  INDEX `export`(`ticket_id`, `company_id`) USING BTREE COMMENT '导出工单索引'
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of feel_ticket_reply
-- ----------------------------

-- ----------------------------
-- Table structure for feel_ticket_restart
-- ----------------------------
DROP TABLE IF EXISTS `feel_ticket_restart`;
CREATE TABLE `feel_ticket_restart`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `ticket_id` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `restart_time` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '重启时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '工单重启记录' ROW_FORMAT = FIXED;

-- ----------------------------
-- Records of feel_ticket_restart
-- ----------------------------

-- ----------------------------
-- Table structure for feel_ticket_satisfy
-- ----------------------------
DROP TABLE IF EXISTS `feel_ticket_satisfy`;
CREATE TABLE `feel_ticket_satisfy`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `satisfy_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '满意项ID',
  `ticket_id` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `member_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '受理客服ID',
  `score` int(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '评分',
  `advise` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '建议',
  `label_id` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '满意项标签',
  `create_time` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '评价时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of feel_ticket_satisfy
-- ----------------------------

-- ----------------------------
-- Table structure for feel_ticket_status
-- ----------------------------
DROP TABLE IF EXISTS `feel_ticket_status`;
CREATE TABLE `feel_ticket_status`  (
  `status_id` int(11) NOT NULL AUTO_INCREMENT,
  `company_id` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `status_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `name_en` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `name_jp` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `status_color` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '字段颜色值',
  `is_first` tinyint(1) UNSIGNED NOT NULL DEFAULT 2 COMMENT '是否为初始状态，1 是 2 不是',
  `is_end` tinyint(1) UNSIGNED NOT NULL DEFAULT 2 COMMENT '是否为结束状态，1 是 2 不是',
  `is_stop_timing` tinyint(2) UNSIGNED NOT NULL DEFAULT 20 COMMENT '是否停止计时，10 是 20 否',
  `sort` tinyint(2) UNSIGNED NOT NULL DEFAULT 100,
  `create_time` int(11) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`status_id`) USING BTREE,
  INDEX `status_index_1`(`company_id`, `status_id`, `status_name`, `is_first`, `is_end`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of feel_ticket_status
-- ----------------------------
INSERT INTO `feel_ticket_status` VALUES (1, 1, '待处理', 'Untreated', '処理されない', '#b8d900', 1, 2, 20, 1, 1623987441);
INSERT INTO `feel_ticket_status` VALUES (2, 1, '已接收', 'Received', '受信した', '#ff8911', 2, 2, 20, 2, 1623987441);
INSERT INTO `feel_ticket_status` VALUES (3, 1, '预处理', 'Preprocessing', '事前処理', '#e03636', 2, 2, 20, 3, 1623987441);
INSERT INTO `feel_ticket_status` VALUES (4, 1, '处理中', 'In process', '処理', '#3290f9', 2, 2, 20, 4, 1623987441);
INSERT INTO `feel_ticket_status` VALUES (5, 1, '待确认', 'To be confirmed', '確認する', '#9c2189', 2, 2, 20, 5, 1623987441);
INSERT INTO `feel_ticket_status` VALUES (6, 1, '已完成', 'Completed', '完成した', '#00b5ad', 2, 1, 20, 6, 1623987441);

-- ----------------------------
-- Table structure for feel_ticket_suspend
-- ----------------------------
DROP TABLE IF EXISTS `feel_ticket_suspend`;
CREATE TABLE `feel_ticket_suspend`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `ticket_id` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `start_time` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '挂起状态开始时间',
  `close_time` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '挂起状态结束时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `ticket_suspend`(`company_id`, `ticket_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = FIXED;

-- ----------------------------
-- Records of feel_ticket_suspend
-- ----------------------------

-- ----------------------------
-- Table structure for feel_ticket_view
-- ----------------------------
DROP TABLE IF EXISTS `feel_ticket_view`;
CREATE TABLE `feel_ticket_view`  (
  `view_id` int(11) NOT NULL AUTO_INCREMENT,
  `view_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `name_en` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `name_jp` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `field_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `field_icon` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `orderby` int(2) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`view_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 19 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of feel_ticket_view
-- ----------------------------
INSERT INTO `feel_ticket_view` VALUES (1, '标题', 'Title', 'タイトル', 'title', 'icon-title', 1);
INSERT INTO `feel_ticket_view` VALUES (2, '来源', 'Source', 'ソース', 'Source', 'icon-laiyuan', 2);
INSERT INTO `feel_ticket_view` VALUES (3, '最新回复', 'Latest reply', '最新回答', '', 'icon-newreply', 3);
INSERT INTO `feel_ticket_view` VALUES (4, '状态', 'Status', '状態', 'status_name', 'icon-state', 4);
INSERT INTO `feel_ticket_view` VALUES (5, '优先级', 'Priority', '優先度', 'priority', 'icon-youxianji', 7);
INSERT INTO `feel_ticket_view` VALUES (6, '发布人', 'Release', '登録者', 'release_name', 'icon-publisher', 8);
INSERT INTO `feel_ticket_view` VALUES (7, '接收人', 'Acceptance', '受信者', 'recipient_id', 'icon-acceptance', 9);
INSERT INTO `feel_ticket_view` VALUES (8, '处理人', 'Dispose', '処理者', 'dispose_id', 'icon-dispose', 10);
INSERT INTO `feel_ticket_view` VALUES (9, '发布时间', 'Release Time', '登録時間', 'create_time', 'icon-ptime', 14);
INSERT INTO `feel_ticket_view` VALUES (10, '已耗时', 'Time Consuming', '経過時間', '', 'icon-yihaoshi', 15);
INSERT INTO `feel_ticket_view` VALUES (11, '工单编号', 'Ticket Number', 'タスク番号', '', 'icon-no', 16);
INSERT INTO `feel_ticket_view` VALUES (12, '是否超时', 'Whether timeout', 'タイムアウトかどうか', '', 'icon-timeoutview', 17);
INSERT INTO `feel_ticket_view` VALUES (13, '超时时长', 'Timeout length', 'タイムアウト時長', '', 'icon-timeoutview', 18);
INSERT INTO `feel_ticket_view` VALUES (15, '模板类型', 'Template type', 'テンプレートの種類', 'type_id', 'icon-moban', 11);
INSERT INTO `feel_ticket_view` VALUES (16, '工单模板', 'Template', '作業オーダーテンプレート', 'ticket_model_id', 'icon-moban', 12);

-- ----------------------------
-- Table structure for feel_ticket_webchat
-- ----------------------------
DROP TABLE IF EXISTS `feel_ticket_webchat`;
CREATE TABLE `feel_ticket_webchat`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `customer_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT 'webchat 访客id',
  `seller_code` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT 'webchat 商户code',
  `ticket_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `service_log_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '客服系统对话id',
  `create_time` int(10) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of feel_ticket_webchat
-- ----------------------------

-- ----------------------------
-- Table structure for feel_upload_file
-- ----------------------------
DROP TABLE IF EXISTS `feel_upload_file`;
CREATE TABLE `feel_upload_file`  (
  `file_id` int(11) NOT NULL AUTO_INCREMENT,
  `company_id` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `ticket_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '工单ID',
  `reply_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '工单回复ID',
  `team_reply_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '内部协作回复ID',
  `problem_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '知识库或FAQ问题ID',
  `sub_ticket_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '子工单ID',
  `sub_reply_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '子工单回复ID',
  `file_form` enum('sub_reply','sub_ticket','faq','library','reply','third_ticket','team_reply','ticket') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'ticket',
  `save_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '储存的文件明',
  `file_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '文件原名',
  `file_size` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `file_type` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `file_link` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `create_time` int(11) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`file_id`) USING BTREE,
  INDEX `file_index1`(`company_id`, `ticket_id`, `reply_id`, `file_form`, `team_reply_id`) USING BTREE,
  INDEX `problem_index`(`company_id`, `problem_id`, `file_form`) USING BTREE,
  INDEX `sub_index`(`company_id`, `sub_ticket_id`, `sub_reply_id`, `file_form`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of feel_upload_file
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
