/*
Navicat MySQL Data Transfer

Source Server         : 本地2
Source Server Version : 50553
Source Host           : localhost:3306
Source Database       : eacoophp

Target Server Type    : MYSQL
Target Server Version : 50553
File Encoding         : 65001

Date: 2019-06-13 16:00:13
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for qyc_action
-- ----------------------------
DROP TABLE IF EXISTS `qyc_action`;
CREATE TABLE `qyc_action` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(30) NOT NULL COMMENT '行为唯一标识（组合控制器名+操作名）',
  `depend_type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '来源类型。0系统,1module，2plugin，3theme',
  `depend_flag` varchar(16) NOT NULL DEFAULT '' COMMENT '所属模块名',
  `title` varchar(80) NOT NULL DEFAULT '' COMMENT '行为说明',
  `remark` varchar(140) NOT NULL DEFAULT '' COMMENT '行为描述',
  `rule` varchar(255) NOT NULL DEFAULT '' COMMENT '行为规则',
  `log` varchar(255) NOT NULL DEFAULT '' COMMENT '日志规则',
  `action_type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '执行类型。1自定义操作，2记录操作',
  `create_time` datetime NOT NULL DEFAULT '0001-01-01 00:00:00' COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT '0001-01-01 00:00:00' COMMENT '修改时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态。0禁用，1启用',
  PRIMARY KEY (`id`),
  KEY `idx_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='系统行为表';

-- ----------------------------
-- Records of qyc_action
-- ----------------------------
INSERT INTO `qyc_action` VALUES ('1', 'login_index', '1', 'admin', '登录后台', '用户登录后台', '', '[user|get_nickname]在[time|time_format]登录了后台', '1', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `qyc_action` VALUES ('2', 'update_config', '1', 'admin', '更新配置', '新增或修改或删除配置', '', '', '2', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `qyc_action` VALUES ('3', 'update_channel', '1', 'admin', '更新导航', '新增或修改或删除导航', '', '', '2', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `qyc_action` VALUES ('4', 'update_category', '1', 'admin', '更新分类', '新增或修改或删除分类', '', '', '2', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `qyc_action` VALUES ('5', 'database_export', '1', 'admin', '数据库备份', '后台进行数据库备份操作', '', '', '1', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `qyc_action` VALUES ('6', 'database_optimize', '1', 'admin', '数据表优化', '数据库管理-》数据表优化', '', '', '1', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `qyc_action` VALUES ('7', 'database_repair', '1', 'admin', '数据表修复', '数据库管理-》数据表修复', '', '', '1', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `qyc_action` VALUES ('8', 'database_delbackup', '1', 'admin', '备份文件删除', '数据库管理-》备份文件删除', '', '', '1', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `qyc_action` VALUES ('9', 'database_import', '1', 'admin', '数据库完成', '数据库管理-》数据还原', '', '', '1', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `qyc_action` VALUES ('10', 'delete_actionlog', '1', 'admin', '删除行为日志', '后台删除用户行为日志', '', '', '1', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `qyc_action` VALUES ('11', 'user_register', '1', 'admin', '注册', '', '', '', '1', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `qyc_action` VALUES ('12', 'action_add', '1', 'admin', '添加行为', '', '', '', '1', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `qyc_action` VALUES ('13', 'action_edit', '1', 'admin', '编辑用户行为', '', '', '', '1', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `qyc_action` VALUES ('14', 'action_dellog', '1', 'admin', '清空日志', '清空所有行为日志', '', '', '1', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `qyc_action` VALUES ('15', 'setstatus', '1', 'admin', '改变数据状态', '通过列表改变了数据的status状态值', '', '', '1', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `qyc_action` VALUES ('16', 'modules_delapp', '1', 'admin', '删除模块', '删除整个模块的时候记录', '', '', '2', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');

-- ----------------------------
-- Table structure for qyc_action_log
-- ----------------------------
DROP TABLE IF EXISTS `qyc_action_log`;
CREATE TABLE `qyc_action_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `action_id` int(10) unsigned NOT NULL COMMENT '行为ID',
  `is_admin` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否后台操作。0否，1是',
  `uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '执行用户id（管理员用户）',
  `nickname` varchar(60) NOT NULL DEFAULT '' COMMENT '用户名',
  `request_method` varchar(20) NOT NULL DEFAULT '' COMMENT '请求类型',
  `url` varchar(120) NOT NULL DEFAULT '' COMMENT '操作页面',
  `data` varchar(300) NOT NULL DEFAULT '0' COMMENT '相关数据,json格式',
  `ip` varchar(18) NOT NULL COMMENT 'IP',
  `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '日志备注',
  `user_agent` varchar(360) NOT NULL DEFAULT '' COMMENT 'User-Agent',
  `create_time` datetime NOT NULL DEFAULT '0001-01-01 00:00:00' COMMENT '操作时间',
  PRIMARY KEY (`id`),
  KEY `idx_uid` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='系统行为日志表';

-- ----------------------------
-- Records of qyc_action_log
-- ----------------------------
INSERT INTO `qyc_action_log` VALUES ('1', '15', '1', '1', 'admin', 'GET', '/admin.php/admin/producttype/setstatus/status/forbid/ids/1.html?model=Producttype', '{\"param\":{\"model\":\"Producttype\"}}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36', '2019-06-12 16:43:01');
INSERT INTO `qyc_action_log` VALUES ('2', '15', '1', '1', 'admin', 'GET', '/admin.php/admin/producttype/setstatus/status/resume/ids/1.html?model=Producttype', '{\"param\":{\"model\":\"Producttype\"}}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36', '2019-06-12 16:43:05');
INSERT INTO `qyc_action_log` VALUES ('3', '15', '1', '1', 'admin', 'GET', '/admin.php/admin/producttype/setstatus/status/delete/ids/1.html?model=Producttype', '{\"param\":{\"model\":\"Producttype\"}}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36', '2019-06-12 16:43:20');

-- ----------------------------
-- Table structure for qyc_ad
-- ----------------------------
DROP TABLE IF EXISTS `qyc_ad`;
CREATE TABLE `qyc_ad` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `title` varchar(200) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '广告名称',
  `position_id` int(12) DEFAULT '0' COMMENT '广告位id',
  `icon` int(12) DEFAULT '0' COMMENT '图片id',
  `linktype` tinyint(2) DEFAULT '1' COMMENT '1外连接，2站内链接',
  `url` varchar(200) CHARACTER SET utf8 DEFAULT NULL COMMENT '完整外链接，或对应的ID',
  `sort` int(12) DEFAULT '0' COMMENT '排序',
  `create_time` datetime DEFAULT '0001-01-01 00:00:00' COMMENT '添加时间',
  `update_time` datetime NOT NULL DEFAULT '0001-01-01 00:00:00' COMMENT '更新时间',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '状态 0：禁用； 1：正常 ；',
  PRIMARY KEY (`id`),
  KEY `idx_username` (`title`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='用户会员表';

-- ----------------------------
-- Records of qyc_ad
-- ----------------------------
INSERT INTO `qyc_ad` VALUES ('1', 'Banner图一', '2', '98', '1', 'http://192.168.0.198:827', '0', '2019-06-12 10:00:35', '2019-06-12 10:06:03', '1');

-- ----------------------------
-- Table structure for qyc_admin
-- ----------------------------
DROP TABLE IF EXISTS `qyc_admin`;
CREATE TABLE `qyc_admin` (
  `uid` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '管理员UID',
  `username` varchar(32) NOT NULL DEFAULT '' COMMENT '用户名',
  `password` char(32) NOT NULL DEFAULT '' COMMENT '登录密码',
  `nickname` varchar(60) NOT NULL DEFAULT '' COMMENT '用户昵称',
  `email` varchar(100) NOT NULL DEFAULT '' COMMENT '登录邮箱',
  `mobile` varchar(20) NOT NULL DEFAULT '' COMMENT '手机号',
  `avatar` varchar(150) NOT NULL DEFAULT '' COMMENT '用户头像，相对于uploads/avatar目录',
  `sex` smallint(1) unsigned NOT NULL DEFAULT '0' COMMENT '性别；0：保密，1：男；2：女',
  `description` varchar(200) NOT NULL DEFAULT '' COMMENT '个人介绍',
  `login_num` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '登录次数',
  `last_login_ip` varchar(16) NOT NULL DEFAULT '' COMMENT '最后登录ip',
  `last_login_time` datetime NOT NULL DEFAULT '0001-01-01 00:00:00' COMMENT '最后登录时间',
  `activation_auth_sign` varchar(60) NOT NULL DEFAULT '' COMMENT '激活码',
  `bind_uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '绑定前台用户ID（可选）',
  `create_time` datetime NOT NULL DEFAULT '0001-01-01 00:00:00' COMMENT '注册时间',
  `update_time` datetime NOT NULL DEFAULT '0001-01-01 00:00:00' COMMENT '更新时间',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '2' COMMENT '用户状态 0：禁用； 1：正常 ；2：待验证',
  PRIMARY KEY (`uid`),
  UNIQUE KEY `uniq_username` (`username`),
  KEY `idx_email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='管理员用户表';

-- ----------------------------
-- Records of qyc_admin
-- ----------------------------
INSERT INTO `qyc_admin` VALUES ('1', 'admin', '031c9ffc4b280d3e78c750163d07d275', 'admin', '123123@qq.com', '', 'http://cdn.eacoo.xin/attachment/static/assets/img/default-avatar.png', '0', '', '0', '127.0.0.1', '2019-06-12 09:13:42', 'db6c6ff9e3f2b465bcfb1a6ee258871b489e8377', '1', '2019-06-06 10:28:40', '2019-06-06 10:28:40', '1');

-- ----------------------------
-- Table structure for qyc_ad_positon
-- ----------------------------
DROP TABLE IF EXISTS `qyc_ad_positon`;
CREATE TABLE `qyc_ad_positon` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `title` varchar(200) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '广告位名称',
  `type` tinyint(2) DEFAULT '1' COMMENT '1单图，2多图',
  `size` varchar(200) DEFAULT '' COMMENT '尺寸（200*300）',
  `sort` int(12) DEFAULT '0' COMMENT '排序',
  `create_time` datetime DEFAULT '0001-01-01 00:00:00' COMMENT '添加时间',
  `update_time` datetime NOT NULL DEFAULT '0001-01-01 00:00:00' COMMENT '更新时间',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '用户状态 0：禁用； 1：正常 ；',
  PRIMARY KEY (`id`),
  KEY `idx_username` (`title`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COMMENT='用户会员表';

-- ----------------------------
-- Records of qyc_ad_positon
-- ----------------------------
INSERT INTO `qyc_ad_positon` VALUES ('2', '首页Banner图', '2', '1230*2000', '0', '2019-06-11 14:32:12', '2019-06-11 14:38:53', '1');
INSERT INTO `qyc_ad_positon` VALUES ('3', '顶部Logo', '1', '200*200', '2', '2019-06-11 14:38:44', '2019-06-11 14:38:44', '1');

-- ----------------------------
-- Table structure for qyc_app_loginad
-- ----------------------------
DROP TABLE IF EXISTS `qyc_app_loginad`;
CREATE TABLE `qyc_app_loginad` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `title` varchar(100) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '广告名称',
  `longtime` int(10) DEFAULT '0' COMMENT '跳转时间单位秒',
  `icon` int(10) DEFAULT '0' COMMENT '广告图',
  `linktype` tinyint(2) DEFAULT '1' COMMENT '1外连接，2站内链接',
  `url` varchar(100) DEFAULT '' COMMENT '链接或跳转的id',
  `sort` int(10) DEFAULT '0' COMMENT '排序',
  `create_time` datetime DEFAULT '0001-01-01 00:00:00' COMMENT '添加时间',
  `update_time` datetime NOT NULL DEFAULT '0001-01-01 00:00:00' COMMENT '更新时间',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '用户状态 0：禁用； 1：正常 ；',
  PRIMARY KEY (`id`),
  KEY `idx_username` (`title`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COMMENT='用户会员表';

-- ----------------------------
-- Records of qyc_app_loginad
-- ----------------------------
INSERT INTO `qyc_app_loginad` VALUES ('2', '广告一', '10', '98', '1', 'http://www.baidu.com', '2', '2019-06-10 16:48:27', '2019-06-10 17:19:06', '1');
INSERT INTO `qyc_app_loginad` VALUES ('3', '广告二', '0', '102', '2', '2', '1', '2019-06-10 17:19:53', '2019-06-11 15:04:51', '1');

-- ----------------------------
-- Table structure for qyc_app_startad
-- ----------------------------
DROP TABLE IF EXISTS `qyc_app_startad`;
CREATE TABLE `qyc_app_startad` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `title` varchar(100) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '广告名称',
  `longtime` int(10) DEFAULT '0' COMMENT '跳转时间单位秒',
  `icon1` int(10) DEFAULT '0' COMMENT '尺寸1080*1920',
  `icon2` int(10) DEFAULT '0' COMMENT '尺寸1536*2048',
  `icon3` int(10) DEFAULT '0' COMMENT '尺寸1125*2436',
  `icon4` int(10) DEFAULT '0' COMMENT '尺寸750*1334',
  `icon5` int(10) DEFAULT '0' COMMENT '尺寸640*1136',
  `icon6` int(10) DEFAULT '0' COMMENT '尺寸640*960',
  `create_time` datetime DEFAULT '0001-01-01 00:00:00' COMMENT '添加时间',
  `update_time` datetime NOT NULL DEFAULT '0001-01-01 00:00:00' COMMENT '更新时间',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '用户状态 0：禁用； 1：正常 ；',
  PRIMARY KEY (`id`),
  KEY `idx_username` (`title`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='用户会员表';

-- ----------------------------
-- Records of qyc_app_startad
-- ----------------------------
INSERT INTO `qyc_app_startad` VALUES ('1', '启动广告', '10', '98', '98', '98', '98', '98', '98', null, '2019-06-12 10:37:30', '1');

-- ----------------------------
-- Table structure for qyc_attachment
-- ----------------------------
DROP TABLE IF EXISTS `qyc_attachment`;
CREATE TABLE `qyc_attachment` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `is_admin` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否后台用户上传',
  `uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT '文件名',
  `path` varchar(255) NOT NULL DEFAULT '' COMMENT '文件路径',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '文件链接（暂时无用）',
  `location` varchar(15) NOT NULL DEFAULT '' COMMENT '文件存储位置(或驱动)',
  `path_type` varchar(20) DEFAULT 'picture' COMMENT '路径类型，存储在uploads的哪个目录中',
  `ext` char(4) NOT NULL DEFAULT '' COMMENT '文件类型',
  `mime_type` varchar(60) NOT NULL DEFAULT '' COMMENT '文件mime类型',
  `size` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '文件大小',
  `alt` varchar(255) DEFAULT NULL COMMENT '替代文本图像alt',
  `md5` char(32) NOT NULL DEFAULT '' COMMENT '文件md5',
  `sha1` char(40) NOT NULL DEFAULT '' COMMENT '文件sha1编码',
  `download` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '下载次数',
  `create_time` datetime NOT NULL DEFAULT '0001-01-01 00:00:00' COMMENT '上传时间',
  `update_time` datetime NOT NULL DEFAULT '0001-01-01 00:00:00' COMMENT '修改时间',
  `sort` mediumint(8) unsigned NOT NULL DEFAULT '99' COMMENT '排序，值越小越靠前',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态',
  PRIMARY KEY (`id`),
  KEY `idx_paty_type` (`path_type`)
) ENGINE=InnoDB AUTO_INCREMENT=105 DEFAULT CHARSET=utf8mb4 COMMENT='附件表';

-- ----------------------------
-- Records of qyc_attachment
-- ----------------------------
INSERT INTO `qyc_attachment` VALUES ('1', '1', '1', 'preg_match_imgs.jpeg', '/uploads/Editor/Picture/2016-06-12/575d4bd8d0351.jpeg', '', 'local', 'editor', 'jpeg', '', '19513', '', '4cf157e42b44c95d579ee39b0a1a48a4', 'dee76e7b39f1afaad14c1e03cfac5f6031c3c511', '0', '2018-09-30 12:32:26', '2018-09-30 22:32:26', '99', '1');
INSERT INTO `qyc_attachment` VALUES ('2', '1', '1', 'gerxiangimg200x200.jpg', '/uploads/Editor/Picture/2016-06-12/575d4bfb09961.jpg', '', 'local', 'editor', 'jpg', '', '5291', 'gerxiangimg200x200', '4db879c357c4ab80c77fce8055a0785f', '480eb2e097397856b99b373214fb28c2f717dacf', '0', '2018-09-30 13:32:26', '2018-09-30 22:32:26', '99', '1');
INSERT INTO `qyc_attachment` VALUES ('3', '1', '1', 'oraclmysqlzjfblhere.jpg', '/uploads/Editor/Picture/2016-06-12/575d4c691e976.jpg', '', 'local', 'editor', 'jpg', '', '23866', 'mysql', '5a3a5a781a6d9b5f0089f6058572f850', 'a17bfe395b29ba06ae5784486bcf288b3b0adfdb', '0', '2018-09-30 14:32:26', '2018-09-30 22:32:26', '99', '1');
INSERT INTO `qyc_attachment` VALUES ('10', '1', '1', '苹果短信-三全音 - 铃声', '/uploads/file/2016-07-27/579857b5aca95.mp3', '', 'local', 'file', 'mp3', '', '19916', null, 'bab00edb8d6a5cf4de5444a2e5c05009', '73cda0fb4f947dcb496153d8b896478af1247935', '0', '2018-09-30 15:15:26', '2018-09-30 22:32:26', '99', '-1');
INSERT INTO `qyc_attachment` VALUES ('12', '1', '1', 'music', '/uploads/file/2016-07-28/57995fe9bf0da.mp3', '', 'local', 'file', 'mp3', '', '160545', null, '935cd1b8950f1fdcd23d47cf791831cf', '73c318221faa081544db321bb555148f04b61f00', '0', '2018-09-30 15:16:26', '2018-09-30 22:32:26', '99', '1');
INSERT INTO `qyc_attachment` VALUES ('13', '1', '1', '7751775467283337', '/uploads/picture/2016-09-26/57e8dc9d29b01.jpg', '', 'local', 'picture', 'jpg', '', '70875', null, '3e3bfc950aa0b6ebb56654c15fe8e392', 'c75e70753eaf36aaee10efb3682fdbd8f766d32d', '0', '2018-09-30 15:17:26', '2018-09-30 22:32:26', '99', '-1');
INSERT INTO `qyc_attachment` VALUES ('98', '1', '1', '5c80ac7ebad3f', '/uploads/picture/2019-06-06/5cf88f3ee2336.jpg', '/uploads/picture/2019-06-06/5cf88f3ee2336.jpg', 'local', 'picture', 'jpg', 'image', '89387', '5c80ac7ebad3f', 'd2adbd319bb829d6dcb7bf7fbb376b50', '29f04764eb917fad475f8c77730b75fe6ed0e02a', '0', '2019-06-06 11:57:50', '2019-06-10 14:58:44', '99', '1');
INSERT INTO `qyc_attachment` VALUES ('102', '1', '1', '21', '/uploads/picture/2019-06-11/5cff2287ef087.png', '/uploads/picture/2019-06-11/5cff2287ef087.png', 'local', 'picture', 'png', 'image', '215859', '21', '65ab7a33d47cb4d1eabb0e78b5bdeab8', '8f8aa6f0942d051a8f1f40f86deeaee58120af76', '0', '2019-06-11 11:39:52', '2019-06-11 11:39:52', '99', '1');
INSERT INTO `qyc_attachment` VALUES ('103', '1', '1', 'null2c8628f4ee511000', '/uploads/picture/2019-06-11/5cff22881d517.jpg', '/uploads/picture/2019-06-11/5cff22881d517.jpg', 'local', 'picture', 'jpg', 'image', '65601', 'null2c8628f4ee511000', '26cf9b65f080fc32f2ee77653097f860', '0e54f7431ba47adc61358d883299f7b2fd38818a', '0', '2019-06-11 11:39:52', '2019-06-11 11:39:52', '99', '1');
INSERT INTO `qyc_attachment` VALUES ('104', '1', '1', '5cff6cbc335e5', '/uploads/picture/2019-06-11/5cff7ae557254.jpg', '/uploads/picture/2019-06-11/5cff7ae557254.jpg', 'local', 'picture', 'jpg', 'image', '506057', '5cff6cbc335e5', '3c548b6053edc3b1904c2871bf097727', 'f71fe06daea743bba7ce95f848da2ac86d31a393', '0', '2019-06-11 17:56:53', '2019-06-11 17:56:53', '99', '1');

-- ----------------------------
-- Table structure for qyc_auth_group
-- ----------------------------
DROP TABLE IF EXISTS `qyc_auth_group`;
CREATE TABLE `qyc_auth_group` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `title` char(100) NOT NULL DEFAULT '' COMMENT '用户组中文名称',
  `description` varchar(80) DEFAULT NULL COMMENT '描述信息',
  `rules` varchar(160) NOT NULL DEFAULT '',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态。1启用，0禁用',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='用户组表';

-- ----------------------------
-- Records of qyc_auth_group
-- ----------------------------
INSERT INTO `qyc_auth_group` VALUES ('1', '超级管理员', '拥有网站的最高权限', '1,2,6,18,9,12,19,25,17,26,3,7,21,43,44,4,37,38,39,40,41,42,5,22,23,30,24,10,11,13,14,20,32,15,8,16,45,27,28,29', '1');
INSERT INTO `qyc_auth_group` VALUES ('2', '管理员', '授权管理员', '1,6,18,12,19,26,3,7,21,44,4,37,38,39,40,41,42,5,22,23,30,24,10,11,13,14,20,15,8,16,27,28,29', '1');
INSERT INTO `qyc_auth_group` VALUES ('3', '普通用户', '这是普通用户的权限', '1,3,8,10,11,94,95,96,97,98,99,41,42,43,44,38,39,40', '1');
INSERT INTO `qyc_auth_group` VALUES ('4', '客服', '客服处理订单发货', '1,27,28,29,7,4,52,53,54,55', '1');

-- ----------------------------
-- Table structure for qyc_auth_group_access
-- ----------------------------
DROP TABLE IF EXISTS `qyc_auth_group_access`;
CREATE TABLE `qyc_auth_group_access` (
  `uid` int(11) unsigned NOT NULL COMMENT '管理员用户ID',
  `group_id` mediumint(8) unsigned NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否审核  2：未审核，1:启用，0：禁用，-1：删除',
  KEY `uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户组明细表';

-- ----------------------------
-- Records of qyc_auth_group_access
-- ----------------------------
INSERT INTO `qyc_auth_group_access` VALUES ('1', '1', '1');

-- ----------------------------
-- Table structure for qyc_auth_rule
-- ----------------------------
DROP TABLE IF EXISTS `qyc_auth_rule`;
CREATE TABLE `qyc_auth_rule` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `name` char(80) NOT NULL DEFAULT '' COMMENT '导航链接',
  `title` char(20) NOT NULL DEFAULT '' COMMENT '导航名字',
  `depend_type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '来源类型。1module，2plugin，3theme',
  `depend_flag` varchar(30) NOT NULL DEFAULT '' COMMENT '来源标记。如：模块或插件标识',
  `type` tinyint(1) DEFAULT '1' COMMENT '是否支持规则表达式',
  `pid` smallint(6) unsigned DEFAULT '0' COMMENT '上级id',
  `icon` varchar(50) DEFAULT '' COMMENT '图标',
  `condition` char(200) DEFAULT '',
  `is_menu` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否菜单',
  `position` varchar(20) DEFAULT 'admin' COMMENT '菜单显示位置。如果是插件就写模块名',
  `developer` tinyint(1) NOT NULL DEFAULT '0' COMMENT '开发者',
  `sort` smallint(6) unsigned DEFAULT '99' COMMENT '排序，值越小越靠前',
  `update_time` datetime NOT NULL DEFAULT '0001-01-01 00:00:00' COMMENT '更新时间',
  `create_time` datetime NOT NULL DEFAULT '0001-01-01 00:00:00' COMMENT '创建时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否有效(0:无效,1:有效)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8 COMMENT='规则表（后台菜单）';

-- ----------------------------
-- Records of qyc_auth_rule
-- ----------------------------
INSERT INTO `qyc_auth_rule` VALUES ('1', 'admin/dashboard/index', '仪表盘', '1', 'admin', '1', '0', 'fa fa-tachometer', null, '1', 'admin', '0', '3', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `qyc_auth_rule` VALUES ('2', 'admin/manage', '系统管理', '1', 'admin', '1', '0', 'fa fa-cog', null, '1', 'admin', '0', '7', '2018-12-03 00:47:34', '2018-09-30 22:32:26', '1');
INSERT INTO `qyc_auth_rule` VALUES ('3', 'user/user/', '会员管理', '1', 'user', '1', '0', 'fa fa-users', null, '1', 'user', '0', '28', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '0');
INSERT INTO `qyc_auth_rule` VALUES ('4', 'admin/attachment/index', '附件空间', '1', 'admin', '1', '0', 'fa fa-picture-o', null, '1', 'admin', '0', '28', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `qyc_auth_rule` VALUES ('6', 'admin/navigation/index', '前台导航菜单', '1', 'admin', '1', '0', 'fa fa-leaf', null, '1', 'admin', '0', '25', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `qyc_auth_rule` VALUES ('7', 'user/user/index', '用户列表', '1', 'user', '1', '0', 'fa fa-user', null, '1', 'user', '0', '4', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `qyc_auth_rule` VALUES ('8', 'admin/AuthGroup/index', '角色组', '1', 'admin', '1', '15', '', null, '1', 'admin', '0', '10', '2018-12-03 00:49:26', '2018-09-30 22:32:26', '1');
INSERT INTO `qyc_auth_rule` VALUES ('9', 'admin/menu/index', '后台菜单管理', '1', 'admin', '1', '2', 'fa fa-inbox', null, '1', 'admin', '1', '31', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `qyc_auth_rule` VALUES ('10', 'tools', '工具', '1', 'admin', '1', '0', 'fa fa-gavel', null, '1', 'admin', '1', '29', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `qyc_auth_rule` VALUES ('11', 'admin/database', '安全', '1', 'admin', '1', '10', 'fa fa-database', null, '0', 'admin', '0', '32', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `qyc_auth_rule` VALUES ('12', 'admin/attachment/setting', '设置', '1', 'admin', '1', '0', '', null, '0', 'admin', '0', '1', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `qyc_auth_rule` VALUES ('13', 'admin/link/index', '友情链接', '1', 'admin', '1', '10', '', null, '1', 'admin', '0', '26', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `qyc_auth_rule` VALUES ('14', 'admin/link/edit', '链接编辑', '1', 'admin', '1', '13', '', null, '0', 'admin', '0', '4', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `qyc_auth_rule` VALUES ('15', 'user/auth', '权限管理', '1', 'user', '1', '0', 'fa fa-sun-o', null, '1', 'admin', '0', '25', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `qyc_auth_rule` VALUES ('16', 'admin/auth/index', '规则管理', '1', 'admin', '1', '2', 'fa fa-500px', null, '1', 'admin', '0', '19', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `qyc_auth_rule` VALUES ('17', 'admin/config/edit', '配置编辑或添加', '1', 'admin', '1', '25', '', null, '0', 'admin', '0', '27', '2018-12-02 22:56:27', '2018-09-30 22:32:26', '1');
INSERT INTO `qyc_auth_rule` VALUES ('18', 'admin/navigation/edit', '导航编辑或添加', '1', 'admin', '1', '6', '', null, '0', 'admin', '0', '5', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `qyc_auth_rule` VALUES ('19', 'admin/config/website', '网站设置', '1', 'admin', '1', '0', '', null, '1', 'admin', '0', '6', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `qyc_auth_rule` VALUES ('20', 'admin/database/index', '数据库管理', '1', 'admin', '1', '10', 'fa fa-database', null, '1', 'admin', '0', '33', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `qyc_auth_rule` VALUES ('21', 'user/user/resetPassword', '修改密码', '1', 'user', '1', '0', '', '', '1', 'user', '0', '40', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `qyc_auth_rule` VALUES ('25', 'admin/config/index', '配置管理', '1', 'admin', '1', '2', '', null, '1', 'admin', '1', '34', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `qyc_auth_rule` VALUES ('26', 'admin/config/group', '系统设置', '1', 'admin', '1', '2', '', null, '1', 'admin', '0', '8', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `qyc_auth_rule` VALUES ('27', 'admin/action', '行为管理', '1', 'user', '1', '0', 'fa fa-list-alt', null, '1', 'user', '0', '23', '2018-12-03 00:10:26', '2018-09-30 22:32:26', '1');
INSERT INTO `qyc_auth_rule` VALUES ('28', 'admin/action/index', '用户行为', '1', 'user', '1', '27', '', null, '1', 'user', '0', '11', '2018-12-03 00:08:20', '2018-09-30 22:32:26', '1');
INSERT INTO `qyc_auth_rule` VALUES ('29', 'admin/action/log', '行为日志', '1', 'user', '1', '27', 'fa fa-address-book-o', null, '1', 'user', '0', '21', '2018-12-03 00:08:30', '2018-09-30 22:32:26', '1');
INSERT INTO `qyc_auth_rule` VALUES ('30', 'admin/plugins/hooks', '钩子管理', '1', 'admin', '1', '10', '', null, '1', 'admin', '1', '12', '2019-06-06 15:49:24', '2018-09-30 22:32:26', '1');
INSERT INTO `qyc_auth_rule` VALUES ('32', 'admin/mailer/template', '邮件模板', '1', 'admin', '1', '10', null, null, '1', 'admin', '0', '24', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `qyc_auth_rule` VALUES ('37', 'admin/attachment/attachmentCategory', '附件分类', '1', 'admin', '1', '4', null, null, '0', 'admin', '0', '13', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `qyc_auth_rule` VALUES ('38', 'admin/attachment/upload', '文件上传', '1', 'admin', '1', '4', null, null, '0', 'admin', '0', '14', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `qyc_auth_rule` VALUES ('39', 'admin/attachment/uploadPicture', '上传图片', '1', 'admin', '1', '4', null, null, '0', 'admin', '0', '15', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `qyc_auth_rule` VALUES ('40', 'admin/attachment/upload_onlinefile', '添加外链附件', '1', 'admin', '1', '4', null, null, '0', 'admin', '0', '16', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `qyc_auth_rule` VALUES ('41', 'admin/attachment/attachmentInfo', '附件详情', '1', 'admin', '1', '4', null, null, '0', 'admin', '0', '17', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `qyc_auth_rule` VALUES ('42', 'admin/attachment/uploadAvatar', '上传头像', '1', 'admin', '1', '4', null, null, '0', 'admin', '0', '18', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `qyc_auth_rule` VALUES ('43', 'user/tags/index', '标签管理', '1', 'user', '1', '0', '', null, '1', 'user', '0', '22', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '0');
INSERT INTO `qyc_auth_rule` VALUES ('44', 'user/tongji/analyze', '会员统计', '1', 'user', '1', '0', '', null, '1', 'user', '0', '27', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `qyc_auth_rule` VALUES ('45', 'admin/AdminUser/index', '管理员', '1', 'admin', '1', '15', 'fa fa-users', '', '1', 'admin', '0', '9', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `qyc_auth_rule` VALUES ('46', 'ad', '广告管理', '1', 'Content', '1', '0', 'fa fa-camera', '', '1', 'Content', '0', '99', '2019-06-10 14:13:38', '2019-06-10 14:08:02', '1');
INSERT INTO `qyc_auth_rule` VALUES ('47', 'appad/startad', 'App启动广告', '1', 'Content', '1', '46', 'fa fa-align-justify', '', '1', 'Content', '0', '99', '2019-06-11 11:24:23', '2019-06-10 14:09:40', '1');
INSERT INTO `qyc_auth_rule` VALUES ('48', 'appad/loginad', 'App登录广告', '1', 'Content', '1', '46', 'fa fa-align-justify', '', '1', 'Content', '0', '99', '2019-06-11 11:24:33', '2019-06-10 14:11:23', '1');
INSERT INTO `qyc_auth_rule` VALUES ('49', 'adpositon/index', '广告位置', '1', 'Content', '1', '46', 'fa fa-align-justify', '', '1', 'Content', '0', '99', '2019-06-11 11:24:42', '2019-06-10 14:12:38', '1');
INSERT INTO `qyc_auth_rule` VALUES ('51', 'ad/index', '广告列表', '1', 'Content', '1', '46', 'fa fa-align-justify', '', '1', 'Content', '0', '99', '2019-06-11 11:24:51', '2019-06-10 14:13:59', '1');
INSERT INTO `qyc_auth_rule` VALUES ('52', 'Product', '商品管理', '1', 'Product', '1', '0', 'fa fa-cart-plus', '', '1', 'Product', '0', '99', '2019-06-12 11:47:59', '2019-06-12 11:47:59', '1');
INSERT INTO `qyc_auth_rule` VALUES ('53', 'Producttype/index', '商品分类', '1', 'Product', '1', '52', 'fa fa-bookmark-o', '', '1', 'Product', '0', '99', '2019-06-12 11:49:18', '2019-06-12 11:49:18', '1');
INSERT INTO `qyc_auth_rule` VALUES ('54', 'Tjpositon/index', '推荐位列表', '1', 'Product', '1', '52', 'fa fa-cloud', '', '1', 'Product', '0', '99', '2019-06-12 11:56:46', '2019-06-12 11:56:46', '1');

-- ----------------------------
-- Table structure for qyc_config
-- ----------------------------
DROP TABLE IF EXISTS `qyc_config`;
CREATE TABLE `qyc_config` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '配置ID',
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT '配置名称',
  `title` varchar(50) NOT NULL COMMENT '配置说明',
  `value` text NOT NULL COMMENT '配置值',
  `options` varchar(255) NOT NULL COMMENT '配置额外值',
  `group` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '配置分组',
  `sub_group` tinyint(3) DEFAULT '0' COMMENT '子分组，子分组需要自己定义',
  `type` varchar(16) NOT NULL DEFAULT '' COMMENT '配置类型',
  `remark` varchar(500) NOT NULL COMMENT '配置说明',
  `create_time` datetime NOT NULL DEFAULT '0001-01-01 00:00:00' COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT '0001-01-01 00:00:00' COMMENT '更新时间',
  `sort` tinyint(3) unsigned NOT NULL DEFAULT '99' COMMENT '排序，值越小越靠前',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态',
  PRIMARY KEY (`id`),
  KEY `idx_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8 COMMENT='配置表';

-- ----------------------------
-- Records of qyc_config
-- ----------------------------
INSERT INTO `qyc_config` VALUES ('1', 'toggle_web_site', '站点开关', '1', '0:关闭\r\n1:开启', '1', '0', 'select', '站点关闭后将提示网站已关闭，不能正常访问', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1', '1');
INSERT INTO `qyc_config` VALUES ('2', 'web_site_title', '网站标题', '后台内容管理系统', '', '6', '0', 'text', '网站标题前台显示标题', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '2', '1');
INSERT INTO `qyc_config` VALUES ('4', 'web_site_logo', '网站LOGO', '4', '', '6', '0', 'picture', '网站LOGO', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '4', '1');
INSERT INTO `qyc_config` VALUES ('5', 'web_site_description', 'SEO描述', '后台内容管理系统', '', '6', '1', 'textarea', '网站搜索引擎描述', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '6', '1');
INSERT INTO `qyc_config` VALUES ('6', 'web_site_keyword', 'SEO关键字', '后台内容管理系统', '', '6', '1', 'textarea', '网站搜索引擎关键字', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '4', '1');
INSERT INTO `qyc_config` VALUES ('7', 'web_site_copyright', '版权信息', '', '', '1', '0', 'text', '设置在网站底部显示的版权信息', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '7', '1');
INSERT INTO `qyc_config` VALUES ('8', 'web_site_icp', '网站备案号', '', '', '6', '0', 'text', '设置在网站底部显示的备案号，如“苏ICP备1502009-2号\"', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '8', '1');
INSERT INTO `qyc_config` VALUES ('9', 'web_site_statistics', '站点统计', '', '', '1', '0', 'textarea', '支持百度、Google、cnzz等所有Javascript的统计代码', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '9', '1');
INSERT INTO `qyc_config` VALUES ('10', 'index_url', '首页地址', 'http://oneuser.com', '', '2', '0', 'text', '可以通过配置此项自定义系统首页的地址，比如：http://www.xxx.com', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '0', '1');
INSERT INTO `qyc_config` VALUES ('13', 'admin_tags', '后台多标签', '1', '0:关闭\r\n1:开启', '2', '0', 'radio', '', '2018-09-30 22:32:26', '2018-12-02 23:00:29', '99', '1');
INSERT INTO `qyc_config` VALUES ('14', 'admin_page_size', '后台分页数量', '12', '', '2', '0', 'number', '后台列表分页时每页的记录数', '2018-09-30 22:32:26', '2018-12-02 23:01:12', '99', '1');
INSERT INTO `qyc_config` VALUES ('15', 'admin_theme', '后台主题', 'default', 'default:默认主题\r\nblue:蓝色理想\r\ngreen:绿色生活', '2', '0', 'select', '后台界面主题', '2018-09-30 22:32:26', '2018-12-02 23:00:44', '98', '1');
INSERT INTO `qyc_config` VALUES ('16', 'develop_mode', '开发模式', '1', '1:开启\r\n0:关闭', '3', '0', 'select', '开发模式下会显示菜单管理、配置管理、数据字典等开发者工具', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1', '1');
INSERT INTO `qyc_config` VALUES ('17', 'app_trace', '是否显示页面Trace', '0', '1:开启\r\n0:关闭', '3', '0', 'select', '是否显示页面Trace信息', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '2', '1');
INSERT INTO `qyc_config` VALUES ('18', 'auth_key', '系统加密KEY', 'vzxI=vf[=xV)?a^XihbLKx?pYPw$;Mi^R*<mV;yJh$wy(~~E?<.JA&ANdIZ#QhPq', '', '3', '0', 'textarea', '轻易不要修改此项，否则容易造成用户无法登录；如要修改，务必备份原key', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '3', '1');
INSERT INTO `qyc_config` VALUES ('19', 'only_auth_rule', '权限仅验证规则表', '1', '1:开启\n0:关闭', '4', '0', 'radio', '开启此项，则后台验证授权只验证规则表存在的规则', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '0', '1');
INSERT INTO `qyc_config` VALUES ('20', 'static_domain', '静态文件独立域名', '', '', '3', '0', 'text', '静态文件独立域名一般用于在用户无感知的情况下平和的将网站图片自动存储到腾讯万象优图、又拍云等第三方服务。', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '3', '1');
INSERT INTO `qyc_config` VALUES ('21', 'config_group_list', '配置分组', '1:基本\r\n2:系统\r\n3:开发\r\n4:安全\r\n5:数据库\r\n6:网站设置\r\n7:用户\r\n8:邮箱\r\n9:高级', '', '3', '0', 'array', '配置分组的键值对不要轻易改变', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '5', '1');
INSERT INTO `qyc_config` VALUES ('25', 'form_item_type', '表单项目类型', 'hidden:隐藏\r\nreadonly:仅读文本\r\nnumber:数字\r\ntext:单行文本\r\ntextarea:多行文本\r\narray:数组\r\npassword:密码\r\nradio:单选框\r\ncheckbox:复选框\r\nselect:下拉框\r\nicon:字体图标\r\ndate:日期\r\ndatetime:时间\r\npicture:单张图片\r\npictures:多张图片\r\nfile:单个文件\r\nfiles:多个文件\r\nwangeditor:wangEditor编辑器\r\nueditor:百度富文本编辑器\r\neditormd:Markdown编辑器\r\ntags:标签\nselect2:高级下拉框\r\njson:JSON\r\nboard:拖', '', '3', '0', 'array', '专为配置管理设定\r\n', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '0', '1');
INSERT INTO `qyc_config` VALUES ('26', 'term_taxonomy', '分类法', 'post_category:分类目录\r\npost_tag:标签\r\nmedia_cat:多媒体分类', '', '3', '0', 'array', '', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '0', '1');
INSERT INTO `qyc_config` VALUES ('27', 'data_backup_path', '数据库备份根路径', '../data/backup', '', '5', '0', 'text', '', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '0', '1');
INSERT INTO `qyc_config` VALUES ('28', 'data_backup_part_size', '数据库备份卷大小', '20971520', '', '5', '0', 'number', '', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '0', '1');
INSERT INTO `qyc_config` VALUES ('29', 'data_backup_compress_level', '数据库备份文件压缩级别', '4', '1:普通\r\n4:一般\r\n9:最高', '5', '0', 'radio', '', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '0', '1');
INSERT INTO `qyc_config` VALUES ('30', 'data_backup_compress', '数据库备份文件压缩', '1', '0:不压缩\r\n1:启用压缩', '5', '0', 'radio', '', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '0', '1');
INSERT INTO `qyc_config` VALUES ('31', 'hooks_type', '钩子的类型', '1:视图\r\n2:控制器', '', '3', '0', 'array', '', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '0', '1');
INSERT INTO `qyc_config` VALUES ('33', 'action_type', '行为类型', '1:系统\r\n2:用户', '1:系统\r\n2:用户', '7', '0', 'array', '配置说明', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '0', '1');
INSERT INTO `qyc_config` VALUES ('34', 'website_group', '网站信息子分组', '0:基本信息\r\n1:SEO设置\r\n3:其它', '', '6', '0', 'array', '作为网站信息配置的子分组配置，每个大分组可设置子分组作为tab切换', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '20', '1');
INSERT INTO `qyc_config` VALUES ('36', 'mail_reg_active_template', '注册激活邮件模板', '{\"active\":\"0\",\"subject\":\"\\u6ce8\\u518c\\u6fc0\\u6d3b\\u901a\\u77e5\"}', '', '8', '0', 'json', 'JSON格式保存除了模板内容的属性', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '0', '1');
INSERT INTO `qyc_config` VALUES ('37', 'mail_captcha_template', '验证码邮件模板', '{\"active\":\"0\",\"subject\":\"\\u90ae\\u7bb1\\u9a8c\\u8bc1\\u7801\\u901a\\u77e5\"}', '', '8', '0', 'json', 'JSON格式保存除了模板内容的属性', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '0', '1');
INSERT INTO `qyc_config` VALUES ('38', 'mail_reg_active_template_content', '注册激活邮件模板内容', '<p><span style=\"font-family: 微软雅黑; font-size: 14px;\"></span><span style=\"font-family: 微软雅黑; font-size: 14px;\">您在{$title}的激活链接为</span><a href=\"{$url}\" target=\"_blank\" style=\"font-family: 微软雅黑; font-size: 14px; white-space: normal;\">激活</a><span style=\"font-family: 微软雅黑; font-size: 14px;\">，或者请复制链接：{$url}到浏览器打开。</span></p>', '', '8', '0', 'textarea', '注册激活模板邮件内容部分，模板内容单独存放', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '0', '1');
INSERT INTO `qyc_config` VALUES ('39', 'mail_captcha_template_content', '验证码邮件模板内容', '<p><span style=\"font-family: 微软雅黑; font-size: 14px;\">您的验证码为{$verify}验证码，账号为{$account}。</span></p>', '', '8', '0', 'textarea', '验证码邮件模板内容部分', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '0', '1');
INSERT INTO `qyc_config` VALUES ('40', 'attachment_options', '附件配置选项', '{\"driver\":\"local\",\"file_max_size\":\"2097152\",\"file_exts\":\"doc,docx,xls,xlsx,ppt,pptx,pdf,wps,txt,zip,rar,gz,bz2,7z\",\"file_save_name\":\"uniqid\",\"image_max_size\":\"2097152\",\"image_exts\":\"gif,jpg,jpeg,bmp,png\",\"image_save_name\":\"uniqid\",\"page_number\":\"24\",\"widget_show_type\":\"0\",\"cut\":\"1\",\"small_size\":{\"width\":\"150\",\"height\":\"150\"},\"medium_size\":{\"width\":\"320\",\"height\":\"280\"},\"large_size\":{\"width\":\"560\",\"height\":\"430\"},\"watermark_scene\":\"2\",\"watermark_type\":\"1\",\"water_position\":\"9\",\"water_img\":\"\\/logo.png\",\"water_opacity\":\"80\"}', '', '9', '0', 'json', '以JSON格式保存', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '0', '1');
INSERT INTO `qyc_config` VALUES ('42', 'user_deny_username', '保留用户名和昵称', '管理员,测试,admin,垃圾', '', '7', '0', 'textarea', '禁止注册用户名和昵称，包含这些即无法注册,用&quot; , &quot;号隔开，用户只能是英文，下划线_，数字等', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '0', '1');
INSERT INTO `qyc_config` VALUES ('43', 'captcha_open', '验证码配置', 'reg,login,reset', 'reg:注册显示\r\nlogin:登陆显示\r\nreset:密码重置', '4', '0', 'checkbox', '验证码开启配置', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '0', '1');
INSERT INTO `qyc_config` VALUES ('44', 'captcha_type', '验证码类型', '4', '1:中文\r\n2:英文\r\n3:数字\r\n4:英文+数字', '4', '0', 'select', '验证码类型', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '0', '1');
INSERT INTO `qyc_config` VALUES ('45', 'web_site_subtitle', '网站副标题', '', '', '6', '0', 'textarea', '用简洁的文字描述本站点（网站口号、宣传标语、一句话介绍）', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '2', '1');
INSERT INTO `qyc_config` VALUES ('46', 'cache', '缓存配置', '{\"type\":\"File\",\"path\":\"\\/Library\\/WebServer\\/Documents\\/EacooPHP\\/runtime\\/cache\\/\",\"prefix\":\"\",\"expire\":\"0\"}', '', '9', '0', 'json', '以JSON格式保存', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '0', '1');
INSERT INTO `qyc_config` VALUES ('47', 'session', 'Session配置', '{\"type\":\"\",\"prefix\":\"eacoophp_\",\"auto_start\":\"1\"}', '', '9', '0', 'json', '以JSON格式保存', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '99', '1');
INSERT INTO `qyc_config` VALUES ('48', 'cookie', 'Cookie配置', '{\"path\":\"\\/\",\"prefix\":\"eacoophp_\",\"expire\":\"0\",\"domain\":\"\",\"secure\":\"0\",\"httponly\":\"\",\"setcookie\":\"1\"}', '', '9', '0', 'json', '以JSON格式保存', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '99', '1');
INSERT INTO `qyc_config` VALUES ('49', 'reg_default_roleid', '注册默认角色', '4', '', '7', '0', 'select', '', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '0', '1');
INSERT INTO `qyc_config` VALUES ('50', 'open_register', '开放注册', '0', '1:是\r\n0:否', '7', '0', 'radio', '', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '0', '1');
INSERT INTO `qyc_config` VALUES ('56', 'meanwhile_user_online', '允许同时登录', '1', '1:是\r\n0:否', '7', '0', 'radio', '是否允许同一帐号在不同地方同时登录', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '0', '1');
INSERT INTO `qyc_config` VALUES ('57', 'admin_collect_menus', '后台收藏菜单', '[]', '', '2', '0', 'json', '在后台顶部菜单栏展示，可以方便快速菜单入口', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '99', '1');
INSERT INTO `qyc_config` VALUES ('58', 'minify_status', '开启minify', '1', '1:开启\r\n0:关闭', '2', '0', 'radio', '开启minify会压缩合并js、css文件，可以减少资源请求次数，如果不支持minify，可关闭', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '99', '1');
INSERT INTO `qyc_config` VALUES ('59', 'admin_allow_login_many', '同账号多人登录后台', '0', '0:不允许\r\n1:允许', '4', '0', 'radio', '允许多个人使用同一个账号登录后台。默认：不允许', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '99', '1');
INSERT INTO `qyc_config` VALUES ('60', 'admin_allow_ip', '仅限登录后台IP', '', '', '4', '0', 'textarea', '填写IP地址，多个IP用英文逗号隔开。默认为空，允许所有IP', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '99', '1');
INSERT INTO `qyc_config` VALUES ('61', 'redis', 'Redis配置', '{\"host\":\"127.0.0.1\",\"port\":\"6979\"}', '', '9', '0', 'json', '以JSON格式保存', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '99', '1');
INSERT INTO `qyc_config` VALUES ('62', 'memcache', 'Memcache配置', '{\"host\":\"127.0.0.1\",\"port\":\"11211\"}', '', '9', '0', 'json', '以JSON格式保存', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '99', '1');
INSERT INTO `qyc_config` VALUES ('63', 'admin_menus_mode', '后台菜单模式', '2', '1:全局模式\r\n2:模块模式', '2', '0', 'radio', '全局模式：所有菜单都显示在后台左侧。\r\n模式模式：菜单根据模式的方式显示在顶部加载。', '2018-12-02 22:59:47', '2018-12-03 00:57:51', '20', '0');

-- ----------------------------
-- Table structure for qyc_hooks
-- ----------------------------
DROP TABLE IF EXISTS `qyc_hooks`;
CREATE TABLE `qyc_hooks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '钩子ID',
  `name` varchar(32) NOT NULL DEFAULT '' COMMENT '钩子名称',
  `description` varchar(300) NOT NULL DEFAULT '' COMMENT '描述',
  `type` tinyint(4) unsigned NOT NULL DEFAULT '1' COMMENT '类型。1视图，2控制器',
  `create_time` datetime NOT NULL DEFAULT '0001-01-01 00:00:00' COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT '0001-01-01 00:00:00' COMMENT '更新时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态。1启用，0禁用',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COMMENT='钩子表';

-- ----------------------------
-- Records of qyc_hooks
-- ----------------------------
INSERT INTO `qyc_hooks` VALUES ('1', 'AdminIndex', '后台首页小工具', '1', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `qyc_hooks` VALUES ('2', 'FormBuilderExtend', 'FormBuilder类型扩展Builder', '1', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `qyc_hooks` VALUES ('3', 'UploadFile', '上传文件钩子', '1', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `qyc_hooks` VALUES ('4', 'PageHeader', '页面header钩子，一般用于加载插件CSS文件和代码', '1', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `qyc_hooks` VALUES ('5', 'PageFooter', '页面footer钩子，一般用于加载插件CSS文件和代码', '1', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `qyc_hooks` VALUES ('6', 'LoginUser', '用户登录钩子', '1', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `qyc_hooks` VALUES ('7', 'SendMessage', '发送消息钩子，用于消息发送途径的扩展', '2', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `qyc_hooks` VALUES ('8', 'sms', '短信插件钩子', '2', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `qyc_hooks` VALUES ('9', 'RegisterUser', '用户注册钩子', '2', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `qyc_hooks` VALUES ('10', 'ImageGallery', '图片轮播钩子', '1', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `qyc_hooks` VALUES ('11', 'JChinaCity', '每个系统都需要的一个中国省市区三级联动插件。', '1', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `qyc_hooks` VALUES ('13', 'editor', '内容编辑器钩子', '1', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `qyc_hooks` VALUES ('14', 'adminEditor', '后台内容编辑页编辑器', '1', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `qyc_hooks` VALUES ('15', 'ThirdLogin', '集成第三方授权登录，包括微博、QQ、微信、码云', '1', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `qyc_hooks` VALUES ('16', 'comment', '实现本地评论功能，支持评论点赞', '1', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `qyc_hooks` VALUES ('17', 'uploadPicture', '实现阿里云OSS对象存储，管理附件', '1', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `qyc_hooks` VALUES ('18', 'MicroTopicsUserPost', '微话题，专注实时热点、个人兴趣、网友讨论等，包含用户等级机制，权限机制。', '1', '2019-01-06 19:08:38', '2019-01-06 19:08:38', '1');

-- ----------------------------
-- Table structure for qyc_hooks_extra
-- ----------------------------
DROP TABLE IF EXISTS `qyc_hooks_extra`;
CREATE TABLE `qyc_hooks_extra` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `hook_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '钩子ID',
  `depend_type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '应用类型。1module，2plugin，3theme',
  `depend_flag` varchar(30) NOT NULL DEFAULT '' COMMENT '应用标记。如：模块或插件标识',
  `sort` smallint(6) unsigned NOT NULL DEFAULT '99' COMMENT '排序，值越小越靠前',
  `create_time` datetime NOT NULL DEFAULT '0001-01-01 00:00:00' COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT '0001-01-01 00:00:00' COMMENT '更新时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态。0禁用，1正常',
  PRIMARY KEY (`id`),
  KEY `idx_hookid_depend` (`hook_id`,`depend_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='钩子应用依赖表';

-- ----------------------------
-- Records of qyc_hooks_extra
-- ----------------------------

-- ----------------------------
-- Table structure for qyc_links
-- ----------------------------
DROP TABLE IF EXISTS `qyc_links`;
CREATE TABLE `qyc_links` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT '标题',
  `image` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '图标',
  `url` varchar(150) NOT NULL DEFAULT '' COMMENT '链接',
  `target` varchar(25) NOT NULL DEFAULT '_blank' COMMENT '打开方式',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '类型',
  `rating` int(11) unsigned NOT NULL COMMENT '评级',
  `create_time` datetime NOT NULL DEFAULT '0001-01-01 00:00:00' COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT '0001-01-01 00:00:00' COMMENT '修改时间',
  `sort` tinyint(3) unsigned NOT NULL DEFAULT '99' COMMENT '排序，值越小越靠前',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态，1启用，0禁用',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='友情链接表';

-- ----------------------------
-- Records of qyc_links
-- ----------------------------
INSERT INTO `qyc_links` VALUES ('1', 'EacooPHP官网', '96', 'https://www.eacoophp.com', '_blank', '2', '8', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '2', '1');
INSERT INTO `qyc_links` VALUES ('2', '社区', '89', 'https://forum.eacoophp.com', '_blank', '1', '9', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '2', '0');

-- ----------------------------
-- Table structure for qyc_modules
-- ----------------------------
DROP TABLE IF EXISTS `qyc_modules`;
CREATE TABLE `qyc_modules` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(31) NOT NULL DEFAULT '' COMMENT '名称',
  `title` varchar(63) NOT NULL DEFAULT '' COMMENT '标题',
  `description` varchar(127) NOT NULL DEFAULT '' COMMENT '描述',
  `author` varchar(31) NOT NULL DEFAULT '' COMMENT '开发者',
  `icon` varchar(120) NOT NULL DEFAULT '' COMMENT '图标',
  `version` varchar(7) NOT NULL DEFAULT '' COMMENT '版本',
  `config` text NOT NULL COMMENT '配置',
  `is_system` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否允许卸载',
  `url` varchar(120) NOT NULL DEFAULT '' COMMENT '站点',
  `admin_manage_into` varchar(60) DEFAULT '' COMMENT '后台管理入口',
  `create_time` datetime NOT NULL DEFAULT '0001-01-01 00:00:00' COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT '0001-01-01 00:00:00' COMMENT '更新时间',
  `sort` tinyint(3) unsigned NOT NULL DEFAULT '99' COMMENT '排序，值越小越靠前',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态。0禁用，1启用',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='模块功能表';

-- ----------------------------
-- Records of qyc_modules
-- ----------------------------
INSERT INTO `qyc_modules` VALUES ('1', 'admin', '系统', '后台系统模块', '心云间、凝听', 'fa fa-home', '1.0.0', '', '1', '', '', '2018-12-02 22:32:26', '2018-12-02 22:32:26', '99', '1');
INSERT INTO `qyc_modules` VALUES ('2', 'home', 'Home模块', '一款基础前台Home模块', '心云间、凝听', 'fa fa-home', '1.0.0', '', '1', '', '', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '99', '1');
INSERT INTO `qyc_modules` VALUES ('3', 'user', '用户', '用户模块，系统核心模块，不可卸载', '心云间、凝听', 'fa fa-users', '1.0.2', '', '1', 'https://www.eacoophp.com', '', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '99', '1');
INSERT INTO `qyc_modules` VALUES ('4', 'Content', '内容', '', '', 'fa fa-users', '1.0.2', '', '1', '', '', '0001-01-01 00:00:00', '0001-01-01 00:00:00', '100', '1');
INSERT INTO `qyc_modules` VALUES ('5', 'Product', '商品', '', '', 'fa fa-cart-plus', '', '', '1', '', '', '0001-01-01 00:00:00', '0001-01-01 00:00:00', '99', '1');

-- ----------------------------
-- Table structure for qyc_nav
-- ----------------------------
DROP TABLE IF EXISTS `qyc_nav`;
CREATE TABLE `qyc_nav` (
  `id` smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(60) NOT NULL DEFAULT '' COMMENT '标题',
  `value` varchar(120) DEFAULT '' COMMENT 'url地址',
  `pid` smallint(6) unsigned NOT NULL DEFAULT '0' COMMENT '父级',
  `position` varchar(20) NOT NULL DEFAULT '' COMMENT '位置。头部：header，我的：my',
  `target` varchar(15) DEFAULT '_self' COMMENT '打开方式。',
  `depend_type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '来源类型。0普通外链http，1模块扩展，2插件扩展，3主题扩展',
  `depend_flag` varchar(30) NOT NULL DEFAULT '' COMMENT '来源标记。如：模块或插件标识',
  `icon` varchar(120) NOT NULL DEFAULT '' COMMENT '图标',
  `sort` tinyint(3) unsigned NOT NULL DEFAULT '99' COMMENT '排序，值越小越靠前',
  `update_time` datetime NOT NULL DEFAULT '0001-01-01 00:00:00' COMMENT '更新时间',
  `create_time` datetime NOT NULL DEFAULT '0001-01-01 00:00:00' COMMENT '创建时间',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '状态。0禁用，1启用',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='前台导航';

-- ----------------------------
-- Records of qyc_nav
-- ----------------------------
INSERT INTO `qyc_nav` VALUES ('1', '主页', '/', '0', 'header', '_self', '1', 'home', 'fa fa-home', '10', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `qyc_nav` VALUES ('2', '会员', 'user/index/index', '0', 'header', '_self', '1', 'user', '', '99', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `qyc_nav` VALUES ('3', '下载', 'https://gitee.com/ZhaoJunfeng/EacooPHP/attach_files', '0', 'header', '_blank', '0', '', '', '99', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `qyc_nav` VALUES ('4', '社区', 'https://forum.eacoophp.com', '0', 'header', '_blank', '0', '', '', '99', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `qyc_nav` VALUES ('5', '文档', 'https://www.kancloud.cn/youpzt/eacoo', '0', 'header', '_blank', '0', '', '', '99', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');

-- ----------------------------
-- Table structure for qyc_plugins
-- ----------------------------
DROP TABLE IF EXISTS `qyc_plugins`;
CREATE TABLE `qyc_plugins` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(32) NOT NULL DEFAULT '' COMMENT '插件名或标识',
  `title` varchar(32) NOT NULL DEFAULT '' COMMENT '中文名',
  `description` text NOT NULL COMMENT '插件描述',
  `config` text COMMENT '配置',
  `author` varchar(32) NOT NULL DEFAULT '' COMMENT '作者',
  `version` varchar(8) NOT NULL DEFAULT '' COMMENT '版本号',
  `admin_manage_into` varchar(60) DEFAULT '0' COMMENT '后台管理入口',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '插件类型',
  `create_time` datetime NOT NULL DEFAULT '0001-01-01 00:00:00' COMMENT '安装时间',
  `update_time` datetime NOT NULL DEFAULT '0001-01-01 00:00:00' COMMENT '修改时间',
  `sort` tinyint(3) unsigned NOT NULL DEFAULT '99' COMMENT '排序，值越小越靠前',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态',
  PRIMARY KEY (`id`),
  KEY `idx_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='插件表';

-- ----------------------------
-- Records of qyc_plugins
-- ----------------------------

-- ----------------------------
-- Table structure for qyc_producttype
-- ----------------------------
DROP TABLE IF EXISTS `qyc_producttype`;
CREATE TABLE `qyc_producttype` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `title` char(20) NOT NULL DEFAULT '' COMMENT '分类名称',
  `pid` smallint(6) unsigned DEFAULT '0' COMMENT '上级id',
  `icon` varchar(50) DEFAULT '' COMMENT '图标',
  `is_tjposition` tinyint(1) NOT NULL DEFAULT '2' COMMENT '是否开启推荐位：1开启，2关闭',
  `sort` smallint(6) unsigned DEFAULT '99' COMMENT '排序，值越小越靠前',
  `content` text COMMENT '内容',
  `update_time` datetime NOT NULL DEFAULT '0001-01-01 00:00:00' COMMENT '更新时间',
  `create_time` datetime NOT NULL DEFAULT '0001-01-01 00:00:00' COMMENT '创建时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否有效(0:无效,1:有效)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='规则表（后台菜单）';

-- ----------------------------
-- Records of qyc_producttype
-- ----------------------------

-- ----------------------------
-- Table structure for qyc_rewrite
-- ----------------------------
DROP TABLE IF EXISTS `qyc_rewrite`;
CREATE TABLE `qyc_rewrite` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id自增',
  `rule` varchar(255) NOT NULL DEFAULT '' COMMENT '规则',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT 'url',
  `create_time` datetime NOT NULL DEFAULT '0001-01-01 00:00:00' COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT '0001-01-01 00:00:00' COMMENT '更新时间',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '状态：0禁用，1启用',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='伪静态表';

-- ----------------------------
-- Records of qyc_rewrite
-- ----------------------------

-- ----------------------------
-- Table structure for qyc_terms
-- ----------------------------
DROP TABLE IF EXISTS `qyc_terms`;
CREATE TABLE `qyc_terms` (
  `term_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(100) NOT NULL COMMENT '分类名称',
  `slug` varchar(100) DEFAULT '' COMMENT '分类别名',
  `taxonomy` varchar(32) DEFAULT '' COMMENT '分类类型',
  `pid` int(10) unsigned DEFAULT '0' COMMENT '上级ID',
  `seo_title` varchar(128) DEFAULT '' COMMENT 'seo标题',
  `seo_keywords` varchar(255) DEFAULT '' COMMENT 'seo 关键词',
  `seo_description` varchar(255) DEFAULT '' COMMENT 'seo描述',
  `create_time` datetime NOT NULL DEFAULT '0001-01-01 00:00:00' COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT '0001-01-01 00:00:00' COMMENT '更新时间',
  `sort` mediumint(8) unsigned DEFAULT '99' COMMENT '排序，值越小越靠前',
  `status` tinyint(1) DEFAULT '1' COMMENT '状态，1发布，0不发布',
  PRIMARY KEY (`term_id`),
  KEY `idx_taxonomy` (`taxonomy`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT='分类';

-- ----------------------------
-- Records of qyc_terms
-- ----------------------------
INSERT INTO `qyc_terms` VALUES ('1', '未分类', 'nocat', 'post_category', '0', '未分类', '', '自定义分类描述', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '99', '1');
INSERT INTO `qyc_terms` VALUES ('4', '大数据', 'tag_dashuju', 'post_tag', '0', '大数据', '', '这是标签描述', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '99', '-1');
INSERT INTO `qyc_terms` VALUES ('5', '技术类', 'technology', 'post_category', '0', '技术类', '关键词', '自定义分类描述', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '99', '-1');
INSERT INTO `qyc_terms` VALUES ('7', '运营', 'yunying', 'post_tag', '0', '运营', '关键字', '自定义标签描述', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '99', '1');
INSERT INTO `qyc_terms` VALUES ('9', '人物', 'renwu', 'media_cat', '0', '人物', '', '聚集多为人物显示的分类', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '99', '1');
INSERT INTO `qyc_terms` VALUES ('10', '美食', 'meishi', 'media_cat', '0', '美食', '', '', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '99', '1');
INSERT INTO `qyc_terms` VALUES ('11', '图标素材', 'icons', 'media_cat', '0', '图标素材', '', '', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '99', '1');
INSERT INTO `qyc_terms` VALUES ('12', '风景', 'fengjin', 'media_cat', '0', '风景', '风景', '', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '99', '1');
INSERT INTO `qyc_terms` VALUES ('13', '其它', 'others', 'media_cat', '0', '其它', '', '', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '99', '1');

-- ----------------------------
-- Table structure for qyc_term_relationships
-- ----------------------------
DROP TABLE IF EXISTS `qyc_term_relationships`;
CREATE TABLE `qyc_term_relationships` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `object_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'posts表里文章id',
  `term_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '分类id',
  `table` varchar(60) NOT NULL COMMENT '数据表',
  `uid` int(11) unsigned DEFAULT '0' COMMENT '分类与用户关系',
  `create_time` datetime DEFAULT '0001-01-01 00:00:00' COMMENT '创建时间',
  `sort` int(10) unsigned NOT NULL DEFAULT '99' COMMENT '排序，值越小越靠前',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '状态，1发布，0不发布',
  PRIMARY KEY (`id`),
  KEY `idx_term_id` (`term_id`),
  KEY `idx_object_id` (`object_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='对象分类对应表';

-- ----------------------------
-- Records of qyc_term_relationships
-- ----------------------------
INSERT INTO `qyc_term_relationships` VALUES ('3', '116', '12', 'attachment', '1', '2018-09-30 22:32:26', '99', '1');

-- ----------------------------
-- Table structure for qyc_themes
-- ----------------------------
DROP TABLE IF EXISTS `qyc_themes`;
CREATE TABLE `qyc_themes` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(32) NOT NULL DEFAULT '' COMMENT '名称',
  `title` varchar(64) NOT NULL DEFAULT '' COMMENT '标题',
  `description` varchar(127) NOT NULL DEFAULT '' COMMENT '描述',
  `author` varchar(32) NOT NULL DEFAULT '' COMMENT '开发者',
  `version` varchar(8) NOT NULL DEFAULT '' COMMENT '版本',
  `config` text COMMENT '主题配置',
  `current` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '当前主题类型，1PC端，2手机端。默认0',
  `website` varchar(120) DEFAULT '' COMMENT '站点',
  `sort` tinyint(4) unsigned NOT NULL DEFAULT '99' COMMENT '排序，值越小越靠前',
  `create_time` datetime NOT NULL DEFAULT '0001-01-01 00:00:00' COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT '0001-01-01 00:00:00' COMMENT '更新时间',
  `status` tinyint(3) NOT NULL DEFAULT '1' COMMENT '状态',
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='前台主题表';

-- ----------------------------
-- Records of qyc_themes
-- ----------------------------
INSERT INTO `qyc_themes` VALUES ('1', 'default', '默认主题', '内置于系统中，是其它主题的基础主题', '心云间、凝听', '1.0.2', '', '1', 'https://www.eacoophp.com', '99', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `qyc_themes` VALUES ('2', 'default-mobile', '默认主题-手机端', '内置于系统中，是系统的默认主题。手机端', '心云间、凝听', '1.0.1', '', '2', '', '99', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');

-- ----------------------------
-- Table structure for qyc_users
-- ----------------------------
DROP TABLE IF EXISTS `qyc_users`;
CREATE TABLE `qyc_users` (
  `uid` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '前台用户ID',
  `username` varchar(32) NOT NULL DEFAULT '' COMMENT '用户名',
  `number` char(10) NOT NULL DEFAULT '' COMMENT '会员编号',
  `password` char(32) NOT NULL DEFAULT '' COMMENT '登录密码',
  `nickname` varchar(60) NOT NULL DEFAULT '' COMMENT '用户昵称',
  `email` varchar(100) NOT NULL DEFAULT '' COMMENT '登录邮箱',
  `mobile` varchar(20) NOT NULL DEFAULT '' COMMENT '手机号',
  `avatar` varchar(150) NOT NULL DEFAULT '' COMMENT '用户头像，相对于uploads/avatar目录',
  `sex` smallint(1) unsigned NOT NULL DEFAULT '0' COMMENT '性别；0：保密，1：男；2：女',
  `birthday` date NOT NULL DEFAULT '0000-00-00' COMMENT '生日',
  `description` varchar(200) NOT NULL DEFAULT '' COMMENT '个人描述',
  `register_ip` varchar(16) NOT NULL DEFAULT '' COMMENT '注册IP',
  `login_num` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '登录次数',
  `last_login_ip` varchar(16) NOT NULL DEFAULT '' COMMENT '最后登录ip',
  `last_login_time` datetime NOT NULL DEFAULT '0001-01-01 00:00:00' COMMENT '最后登录时间',
  `activation_auth_sign` varchar(60) NOT NULL DEFAULT '' COMMENT '激活码',
  `url` varchar(100) NOT NULL DEFAULT '' COMMENT '用户个人网站',
  `score` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户积分',
  `money` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '金额',
  `freeze_money` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '冻结金额，和金币相同换算',
  `pay_pwd` char(32) NOT NULL DEFAULT '' COMMENT '支付密码',
  `reg_from` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '注册来源。1PC端，2WAP端，3微信端，4APP端，5后台添加',
  `reg_method` varchar(30) NOT NULL DEFAULT '' COMMENT '注册方式。wechat,sina,等',
  `level` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '等级，关联表user_level主键',
  `p_uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '推荐人会员ID',
  `is_lock` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否锁定。0否，1是',
  `actived` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否激活，0否，1是',
  `reg_time` datetime NOT NULL DEFAULT '0001-01-01 00:00:00' COMMENT '注册时间',
  `update_time` datetime NOT NULL DEFAULT '0001-01-01 00:00:00' COMMENT '更新时间',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '用户状态 0：禁用； 1：正常 ；',
  PRIMARY KEY (`uid`),
  UNIQUE KEY `uniq_number` (`number`),
  KEY `idx_username` (`username`),
  KEY `idx_email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COMMENT='用户会员表';

-- ----------------------------
-- Records of qyc_users
-- ----------------------------
INSERT INTO `qyc_users` VALUES ('1', 'admin', '5257975351', '031c9ffc4b280d3e78c750163d07d275', '站长', '981248356@qq.com', '15801182251', 'http://cdn.eacoo.xin/attachment/static/assets/img/default-avatar.png', '1', '0000-00-00', '网站创始人和超级管理员。1', '', '0', '127.0.0.1', '2018-10-30 23:37:51', 'e2847283eb09508cfe0db793e5a90ad53b1b570b', 'https://www.eacoophp.com', '100', '100.00', '0.00', 'eba6095468eb32492d20d5db6a85aa5d', '0', '', '0', '0', '0', '1', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `qyc_users` VALUES ('3', 'U1471610993', '9948511005', '031c9ffc4b280d3e78c750163d07d275', '陈婧', '', '', '/static/assets/img/avatar-woman.png', '2', '0000-00-00', '', '', '0', '', '2018-09-30 22:32:26', 'a525c9259ff2e51af1b6e629dd47766f99f26c69', '', '0', '2.00', '0.00', '', '0', '', '0', '0', '0', '0', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');

-- ----------------------------
-- Table structure for qyc_user_level
-- ----------------------------
DROP TABLE IF EXISTS `qyc_user_level`;
CREATE TABLE `qyc_user_level` (
  `id` smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(60) NOT NULL DEFAULT '' COMMENT '等级名称',
  `description` varchar(300) NOT NULL DEFAULT '' COMMENT '描述',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态。0禁用，1启用',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户等级表';

-- ----------------------------
-- Records of qyc_user_level
-- ----------------------------
