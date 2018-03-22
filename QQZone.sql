/*
Navicat MySQL Data Transfer

Source Server         : MySql
Source Server Version : 50162
Source Host           : 127.0.0.1:3306
Source Database       : ssmpractice

Target Server Type    : MYSQL
Target Server Version : 50162
File Encoding         : 65001

Date: 2017-06-06 08:09:11
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for comments
-- ----------------------------
DROP TABLE IF EXISTS `comments`;
CREATE TABLE `comments` (
  `commentId` int(11) NOT NULL AUTO_INCREMENT,
  `cUserId` int(11) NOT NULL COMMENT '评论者id',
  `aUserId` int(11) NOT NULL COMMENT '被评论的作者id',
  `commentType` int(2) DEFAULT NULL COMMENT '评论类型：0：说说，1：日志，2：评论',
  `commentTypeId` varchar(20) DEFAULT NULL COMMENT '评论类型的主键Id：说说：说说表主键Id，日志：日志表主键Id，评论：评论表主键Id',
  `commentContent` varchar(255) DEFAULT NULL,
  `commentTime` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`commentId`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8 COMMENT='˵˵����־���۱�';

-- ----------------------------
-- Records of comments
-- ----------------------------
INSERT INTO `comments` VALUES ('3', '7', '8', '0', '46', '评论祖父第二条', '2017-06-04 00:38:20');
INSERT INTO `comments` VALUES ('4', '7', '8', '0', '45', '评论祖父第一条', '2017-06-04 00:38:30');
INSERT INTO `comments` VALUES ('26', '8', '8', '0', '45', '回复@萧炎：ahahaha', '2017-06-04 10:59:16');
INSERT INTO `comments` VALUES ('30', '8', '8', '0', '47', '没人评论，那我自己给自己评论喽', '2017-06-04 18:07:31');
INSERT INTO `comments` VALUES ('31', '8', '8', '1', '20170603121019', '沙发还是我自己来做吧，这篇日志写的很棒噢<img src=\"http://localhost:8080/springmvc_mybatis/img/mb_thumb.gif\" title=\"[太开心]\">', '2017-06-04 18:07:53');
INSERT INTO `comments` VALUES ('32', '7', '8', '1', '20170603121019', '我是二楼，哈哈', '2017-06-04 18:10:22');
INSERT INTO `comments` VALUES ('33', '8', '8', '1', '20170603121019', '自己给自己顶一下，啦啦啦<img src=\"/springmvc_mybatis/img/shamea_thumb.gif\" title=\"[害羞]\">', '2017-06-04 18:51:02');
INSERT INTO `comments` VALUES ('34', '8', '8', '0', '46', '回复@萧炎：欢迎欢迎', '2017-06-05 18:10:10');
INSERT INTO `comments` VALUES ('36', '7', '8', '0', '47', '看你这么可怜，我来给你评论一下吧', '2017-06-05 19:12:32');
INSERT INTO `comments` VALUES ('37', '7', '8', '1', '20170603121019', '我来给祖父评论一条日志吧', '2017-06-05 20:42:04');

-- ----------------------------
-- Table structure for diary
-- ----------------------------
DROP TABLE IF EXISTS `diary`;
CREATE TABLE `diary` (
  `diaryId` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `diaryTime` timestamp NULL DEFAULT NULL,
  `diaryContentId` varchar(255) DEFAULT NULL COMMENT '按时间格式生成主键id：yyyyMMddHHmmss',
  `diaryContentTitle` varchar(255) DEFAULT NULL COMMENT '日志标题',
  PRIMARY KEY (`diaryId`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='��־��Ϣ��';

-- ----------------------------
-- Records of diary
-- ----------------------------
INSERT INTO `diary` VALUES ('1', '7', '2017-06-03 10:17:02', '20170601231643', '十里春风，风华醉透');
INSERT INTO `diary` VALUES ('2', '7', '2017-06-03 10:18:03', '20170603101803', '三月，醉一场青春的流年');
INSERT INTO `diary` VALUES ('3', '7', '2017-06-03 10:18:56', '20170603101856', '红尘陌上雪，散落随花开');
INSERT INTO `diary` VALUES ('4', '7', '2017-06-03 10:20:27', '20170603102027', '浅遇深藏，温柔时光');
INSERT INTO `diary` VALUES ('5', '7', '2017-06-03 10:21:48', '20170603102148', '时间叶片，指间岁月');
INSERT INTO `diary` VALUES ('6', '7', '2017-06-03 12:15:14', '20170603115331', '人总要学会在深夜跟往事和解，晚安即释怀');
INSERT INTO `diary` VALUES ('8', '8', '2017-06-03 12:10:49', '20170603121019', '红颜如去，莫留岁月浅唱');

-- ----------------------------
-- Table structure for diarycontent
-- ----------------------------
DROP TABLE IF EXISTS `diarycontent`;
CREATE TABLE `diarycontent` (
  `diaryContentId` varchar(255) DEFAULT NULL COMMENT '按时间格式生成主键id：yyyyMMddHHmmss',
  `diaryContentText` text,
  `diaryContentTitle` varchar(255) DEFAULT NULL,
  `diaryContentTime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  `diaryBg` varchar(1) NOT NULL DEFAULT '0' COMMENT '日志背景图片'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of diarycontent
-- ----------------------------
INSERT INTO `diarycontent` VALUES ('20170601231643', '<p style=\"text-align: center;\">&nbsp;<img src=\"http://localhost:8080/springmvc_mybatis/img/tootha_thumb.gif\"><img src=\"/springmvc_mybatis/img/smilea_thumb.gif\" style=\"line-height: 1; text-align: left; background-color: initial;\"><img src=\"/springmvc_mybatis/img/zy_thumb.gif\" style=\"line-height: 1; text-align: left; background-color: initial;\"></p><p style=\"text-align: center;\">落花，你尽揽风声，凌一寸尘起舞，</p><p style=\"text-align: center;\">陌上沉醉中，谁懂那一双眼眸？</p><p style=\"text-align: center;\">那点红染丛中绿，醉卧沉沉睡去，</p><p style=\"text-align: center;\">一转身，落花从无到有，从有到无。</p><p style=\"text-align: center;\">夕阳垂暮，你与谁相守黄昏后？</p><p style=\"text-align: center;\">依稀回旋，一路频频回顾，</p><p style=\"text-align: center;\">洒了几多情，反反复复，</p><p style=\"text-align: center;\">却醉不尽此生万瓣香入袖。</p><p style=\"text-align: center;\">隔着江雾，你舞一寸情心中驻，</p><p style=\"text-align: center;\">闭上眼帘，陷入一季春柔，</p><p style=\"text-align: center;\">红尘情难休引燃了一树绿独孤，</p><p style=\"text-align: center;\">落在彼岸却是一世结局落幕。</p><p style=\"text-align: center;\">十里春风，你一笑风华醉透，</p><p style=\"text-align: center;\">奈何这一世为春舞，乱了尘埃路，</p><p style=\"text-align: center;\">一晌贪欢，却为红尘倾尽所有，</p><p style=\"text-align: center;\">一树点绿，一地枯，情丝自顾。</p><p style=\"text-align: center;\">静默地结束一场华丽的邂逅，</p><p style=\"text-align: center;\">一低眉，一回首，恋上你的柔，</p><p style=\"text-align: center;\">你化作土，我走陌上路，情却难收，</p><p style=\"text-align: center;\">一朝春去，你在我心口香浓淡依旧。</p><p style=\"text-align: center;\">你点点婉转，残也难留，落也难留</p><p style=\"text-align: center;\">牵动几许情悠悠，心事千千于谁诉？</p><p style=\"text-align: center;\">短相聚匆别离，乱花锁心意难休，</p><p style=\"text-align: center;\">莫道归去，斜阳未语多一层双眸雾。</p><p style=\"text-align: center;\">你似故，摇一叶兰舟为春摆渡，</p><p style=\"text-align: center;\">留一树浅绿，酿一壶春雨徒增一地闲愁，</p><p style=\"text-align: center;\">纵有琼花千树，来时如梦，去时刺骨，</p><p style=\"text-align: center;\">醉风匆匆去，只道片片残红舞为春柔。</p><p style=\"text-align: center;\"><img src=\"http://localhost:8080/springmvc_mybatis/img/bba_thumb.gif\"></p><p style=\"text-align: center;\"><br></p><p style=\"text-align: center;\"><br></p>', '十里春风，风华醉透', '2017-06-03 10:17:02', '3');
INSERT INTO `diarycontent` VALUES ('20170603101803', '<p><font color=\"#000000\">&nbsp; &nbsp; &nbsp; &nbsp;三月，醉一场青春的流年。慢步在三月的春光里，走走停停，看花开嫣然，看春雨绵绵，感受春风拂面，春天，就是青春的流年。青春，是人生中最美的风景。青春，是一场花开的遇见；青春，是一场痛并快乐着的旅行；青春，是一场轰轰烈烈的比赛；青春，是一场鲜衣奴马的争荣岁月；青春，是一场风花雪月的光阴。</font></p><p><font color=\"#000000\">&nbsp;</font></p><p><font color=\"#000000\">　　青春往事，多么甜蜜；青春岁月，多么靓丽；青春流年，如火如荼。青春里，我们向着梦想前进。跌倒过，伤心过，快乐过，痛苦过，孤独过，彷徨过，迷茫过。总是，在悠悠的岁月中徘徊；总是，在如春的生命中成长；总是，在季节的交替中感悟人生四季的美妙与韵律；总是，在多愁善感中体悟青春的美好与无奈。</font></p><p><font color=\"#000000\">&nbsp;</font></p><p><font color=\"#000000\">　　三月的鲜花，一树树，一束束，一簇簇，而青春，就是像三月的鲜花一样美丽迷人，生机盎然，姹紫嫣红，生机勃勃。三月，是青春里最美最温暖的风景。三月的美，就像青春的美，充满活力，充满生机，充满昂扬的斗志。三月的美，就像青春的花季，在那里我们可以感受青春的跳动与感动，感受青春的曼妙与奇妙；感受青春的悸动与心跳。</font></p><p><font color=\"#000000\">&nbsp;</font></p><p><font color=\"#000000\">　　青春，如三月的春光，安暖向阳。在美丽的青春年华，我们手牵手，肩并肩，跨过岁月山河，跨过锦瑟流年，跨过天涯海角，在三月的春光里沐浴金色的光泽。三月的春光，让青春的我们看到希望，看到自己有一颗年轻跳动的心，看到蓝天白云，看到明媚的灿烂。三月的春光，温暖无比，就像我们的青春，有着长辈的呵护，有着老师的循循教导，它们就像春光，照耀着我们年轻的心。</font></p><p><font color=\"#000000\">&nbsp;</font></p><p><font color=\"#000000\">　　青春，如三月的春雨，我们在春雨中得到滋润。春雨，淅淅沥沥，纷纷扬扬，打在青春的雨季，打在我们心里，打在我们的生活里，打在我们的生命中，打在我们的灵魂深处。一场春雨，滋润着我们的青春流年，让我们快乐成长，让我们如沐春雨，让我们感受亲恩。三月的春雨，就像我们的父母，用他们的爱心，滋润着我们幼小不安的心灵。</font></p><p><font color=\"#000000\">&nbsp;</font></p><p><font color=\"#000000\">　　青春，如三月的春风，我们沐浴在春风里。三月的春风，是我们的朋友，是我们的同窗，是陪伴我们成长的玩伴。因为有了春风，我们感受到友谊的温暖；因为有了春风，我们不再寂寞；因为有了春风，我们总在需要帮助的时候，有他们伸出援助之手。春风，是那样感情丰富，温婉细腻。在春风里，我们跳着，唱着，欢呼着，只因为这如春风的情谊。</font></p><p><font color=\"#000000\">&nbsp;</font></p><p><font color=\"#000000\">　　青春，如三月的春花，我们陶醉在春花里。三月的春花，是我们的初恋。花开半夏，岁月静好，浅笑安然。三月春花，有着不同的颜色，不同的形状，不同的意向。那水灵灵的粉红的桃花，恋着春风，恋着春雨； 那纯白娇小的茉莉，散发着淡淡的清香；那深红的杜鹃，像燃烧着红色的火焰。初恋，是一种颜色鲜艳的花朵；初恋，是一种幽幽的馨香；初恋，是一种岁月的沉淀。</font></p><p><font color=\"#000000\">&nbsp;</font></p><p><font color=\"#000000\">　　青春，是三月的风景，美到极致。我们，在三月的春雨中奔跑嬉戏，在春风中感受它的温润，在春光里感受暖暖的温度，在春花里享醉人的芬芳。三月的风景，陪我们一路向梦想的地方进发；三月的风景，让我们路上不再孤独，不再迷茫，不再彷徨；三月的风景，让我们的青春更加色彩斑斓，鸟语花香。</font></p><p><font color=\"#000000\">&nbsp;</font></p><p><font color=\"#000000\">　　三月，醉一场青春的流年。我们珍惜三月，就像我们珍惜来之不易的幸福青春。三月的雨，三月的风，三月的春光，三月的花香，让我们沉醉不知归路，兴尽晚回舟。在这样一场盛大而清新的流年，我们懂得，青春是一种一去不复返的风景，应当好好保护；青春是一种美丽而活跃的热情，我们必须耐心保持；青春是一种来之不易的懂得，我们必须细心呵护。</font></p><p><font color=\"#000000\">&nbsp;</font></p><p><font color=\"#000000\">　　三月，醉一场青春的流年。风过无痕，花开向暖。无论是哪一年的三月，都是青春是里最美丽的花朵，都是青春里最难舍的风景，都是青春里最妩媚的清香。无论在哪一年的三月，无论我们有没有老去，心中的青春千万不能割舍，心中的青春永远跳动着快乐，心中的青春永远伴随我们一生一世。</font></p><p><font color=\"#000000\">&nbsp;</font></p><p></p><p><font color=\"#000000\">　　三月，醉一场青春的流年。人生的三月，我们正值青春，风华正茂。在这样一个充满活力的年纪，我们要把握机遇，朝人生的巅峰冲刺；我们要珍惜每一个让我们流连忘返的风景，保持年青的心态，随时准备着与时间赛跑；我们要在时光深处，保持一种淡然而洒脱，矜持而深情的微笑，让三月的风景陪我们笑语盈盈，清芬一路。</font></p><p><br></p>', '三月，醉一场青春的流年', '2017-06-03 10:18:03', '1');
INSERT INTO `diarycontent` VALUES ('20170603101856', '<p>文/雨夜情深</p><p>&nbsp;</p><p>红尘陌上的花开。似比相见又恨晚的聚散，相遇过早前方的路人，便会成为身后的过客。相识过晚倾城清风的颜美。便会与你擦肩，来不及仰望。说不出再见，从此山隔一河。却天涯此岸，回眸仰望已是曾经沧海，百花残月之冬。相遇有缘，离花漂过。景色的相遇正如那份。一直落在思念里的寒冬，无论冰川怎样刺骨。雪花怎样漂过，一颗执着的心。一直苦苦寻找。天暗未明微落的天空却被大雪覆盖，热血的少年。曾经的意志，却从未止步。从春天到寒冬。从寒冬到天荒，一直守护着这份。从未揭开的思念。 &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;</p><p>——题记&nbsp;</p><p>红尘相遇，年华已老。岁月花开多少不在，古往今来相遇是一件既微妙。而又神圣的事情，红尘的情网中。有前者因聚散而离开，后者才因前者的离开。而深深的相遇，曾经有人说过。有缘份相遇的人。无论彼此绕开多大个圈，也会在某个不经意间。彼此依然可以重逢相遇，其实这种故事。只是说说而已。故此，却有很多人相信。从而走进缘分的刹那。</p><p>&nbsp;</p><p>世间的感情，仅隔着一道距离。有些感情因距离而变得美好，有些美好因为距离。鼓励了彼此，才会让前进的路。充满了阳光照进了幸福。温暖了彼此，不过有时候。距离真是一把，验证感情的时光机。故此，有人因它而坚持。因为相信熬过了距离。剩下的便是春风，有人因它而离去，因为相信前方的未明。故此半路匆匆离去，</p><p>&nbsp;</p><p>故年走远，人故未来。走过一段是相知，走过一年是相交。在生命中，有些人一起走。在年华中，有些人分开走。在相遇的渡口，有些人。走着走着就没了，有些陌生人。走着走着就在一起了，有些人我始终不知道。会在哪里相聚，又会在哪里提前离开。生命的短暂，相遇的珍惜。所以相遇就是缘，相识便是份。生命中。时间是一场盛宴，爱情是一场坚守。时间走过的雪月，是年华似水中。那一曲独听静好，爱情是一场相遇。一场落花，同样是一场聚散。人生因情而美。岁月因爱而坚守。</p><p>&nbsp;</p><p>陌上花开，隔桌花夜。一雨芳年，相遇的竹叶。刻写着一一路走过的青苔，时光雨下。散落一地落红，那景，那月。正如初好，一丝寒风袭来。碧玉含羞的清风，凝固了月下。送走了独夜，留下了一丝静好。</p><p>&nbsp;</p><p>年华依旧。散落曾经，你说雨中的风。是你曾经追逐的梦，而冬天的雪。是你曾经散落的花，花开有别。言过其辞。多年以后，每到雪花飘落的季节。都会想起那个曾经的画面，既唯美而又纷飞。既伤感而又无言，一场大雪。一场落花，托清风捎去了思念。托无言凝固了沧海。托花开美丽了过往，时而雨。一路一花开，一路一菩提。今生的遇见，相逢的花开。</p><p>&nbsp;</p><p>走过一段路，总会看一些风景。停留一段时光，总会留下一些故事。其实很多时候。我们都知道每一个故事，总有一个美丽的结局。只是这个结局太过沧桑，也太过唯美，直至最后的散场，竞美得透露着忧伤。忧伤里散播着凄凉，凄凉里隐藏着无言。岁月中总有一场景，落在不经意的地方，人生中总有一场雪，漂在夜深人静的时候，一场散，一场缘。一场雪。只愿时光芬芳，落花静好。</p><p>&nbsp;</p><p>人生的路上，总是一路走过。人生的感情总是，一路擦肩聚散。这个世间，总有人因懂你而停留，也总有人因误解而离开。对于一路走过而停留的人，我们心存感激。因为有共鸣。所以不会离开，生命的路上。红尘的渡口。总有一些人不曾深交。也不再打扰，却也一直都在不曾离开。只是时光仿佛将相遇。定格在彼岸与此岸的一角，从此隔了一个美丽的春天。</p><p>&nbsp;</p><p>生命中一些风。一些景，总在岁月中，演奏的远去的故事，一些落叶。漂过枝头，随风飞翔，这样的季节，这样的回忆。不知道还能在岁月中展示多久，但我知道走过的路，一定会留下一些我们无法预料到的意外，预料多了也就习惯了。生命是如此。岁月便也跟着如此，走过时间的沧海。借往日那段无声的沉默，漂泊着属于自己的天涯。</p><p>&nbsp;</p><p>流年的道别中，总有一段无法言辞的往诉。站在惜忆的尽头，数数奔赶过的黄昏，言出黄昏的每一季：静惜的落雨中，总带着这样或那样的心情，慢步独入那冰雨的清风里，感受着每一个季节带来别样的静好，</p><p>&nbsp;</p><p></p><p>寒风吹过。陌上红尘，散落过往。</p><p><br></p>', '红尘陌上雪，散落随花开', '2017-06-03 10:18:56', '2');
INSERT INTO `diarycontent` VALUES ('20170603102027', '<p><font color=\"#880000\">&nbsp; &nbsp; &nbsp;红尘冷暖，岁月清浅，仓促间，遗落一地，如诗的句点，不甘愿，不决绝，掬一份刻骨的思念，系一根心的挂牵，在你回眸的瞬间，一抹兰轩的底色，悄然纳于心间，不问深浅，暖一世的欢颜。</font></p><p><font color=\"#880000\">----------题记</font></p><p><font color=\"#880000\">&nbsp; 近来，有丝丝倦怠，铺天盖地的不肯离开，执笔，画圈，一闪而过的念，总是一而再，再而三的被搁浅，那些不情不愿的小情绪，占领了太多的空间，庸庸碌碌中，任光阴无情的在指缝中删删减减。</font></p><p><font color=\"#880000\">&nbsp; 早春，微寒缠绵，风，温和的吹醒，春的语言，柳丝抽芽，百花争艳，桃花灼灼的世界是温婉多情的烟花三月。柳岸花堤，亭水榭间，行吟山水，一梦千年。“水光潋滟晴方好，山色空蒙雨亦奇。欲把西湖比西子，淡妆浓抹总相宜”。爱上一座城，爱它的雅韵别致，温润纤细，痴恋一场雨，恋它的清新淡雅，水墨成烟。空蒙蒙的烟雨，摇曳着柳枝，泪水涟涟。古往今来，江南春梦，被悠悠岁华，洗濯了千年。忧怨的姑娘，青石板的小巷，一柄多情的油纸伞，清晰而玲珑的在一湖瘦水中沉淀。</font></p><p><font color=\"#880000\">&nbsp; 一朵时光，反复的被书写，写一程山水，春意翩翩，写柴米油盐，独自清闲，写万千的情意，羽化成美丽的语言，写小小的心绪，深深浅浅，心中，始终有一处温暖，如雨后的晨露，洋溢在眉眼，不增不减。佛说：“欲行净土，当净其心，随其心净，即佛土净。圣人求心不求佛，愚人求佛不求心；智者调心不调身，愚者调身不调心。”拥一颗禅心，平和宁静，不攀比，不争名夺利，在温和的光阴中，恪守自己，品人生百味，世事洞明。</font></p><p><font color=\"#880000\">&nbsp; 我心中对于圆满，或许不是鲜衣怒马，也或许不是海棠佳话，而是，一段清简的况味，禅风流韵，与喜欢的人，素心相对，你护我冷暖，我慰你心安，在眼眸顾盼的瞬间，捕捉着岁月最美的箴言，一人一心，一花一叶。</font></p><p><font color=\"#880000\">&nbsp; 如水的良辰，闲云悠悠，薄薄的阳光，还在云上，怀惴着晴朗，与风月对望，迎风中伫立，将繁华与落寞，细细丈量，佛说；万物皆有因果，世事变幻无常，命运，向你掩盖了一扇门，定会为你打开另一窗，只要你用心承载着阳光，便是明媚不可阻挡的方向。</font></p><p></p><p><font color=\"#880000\">&nbsp; 行走在岁月的小巷，听风，读雨，夜色空寂，一切烟云，皆会慢慢散去，光阴眷顾，你我默默相依，慢慢老去，红尘若可安好，便可不悲不喜，不离不弃，情真意切，绵绵无期。</font></p><p><br></p><p><br></p><p><br></p>', '浅遇深藏，温柔时光', '2017-06-03 10:20:27', '4');
INSERT INTO `diarycontent` VALUES ('20170603102148', '<p>岁月迁徙流转，人生兜兜转转，日子悠悠长长，光阴匆匆忙忙，当年华老去，青春无从追忆，来自于喧嚣繁华的声音，若有若无的响起，是惺松，是叹息，是人来人往的潮夕，是没完没了的继续。&nbsp;</p><p>----------------题记&nbsp;</p><p>&nbsp; &nbsp; &nbsp; &nbsp;携一缕牵念，选一隅宁静，温一盏茶香，研墨于纸张，深冬的午后，有清风有暖阳，还有与你，小小的对话框，深深浅浅，敲出的墨香。听过了花的低语，走过了风的记忆，还有什么，需要，用心丝密密的穿起，那些与你一起，在流年里，明媚如斯，如一枚朱砂的印记，被隐入寻常的日子里，掬不起，也无法疏离。&nbsp;&nbsp;&nbsp;&nbsp;</p><p>&nbsp; &nbsp;一直，只想做简单的事，闲来小聚，时常写字，梳理心情，远离情绪，有时，会期待一场雨，从黎明到黄昏，淅淅沥沥，淋湿一地，隔窗听雨，一整天，将庸懒的自己，漫无目的的游离，看雨后石阶旁，滋生出凉薄的凛冽，看细微斑驳的痕迹，不动声色的落入尘埃里，光阴，无声无息，你我，默默分离。&nbsp;</p><p>&nbsp; &nbsp;时常，会邂逅一句美妙的话语，仿佛清风拂过一树的葱郁，低眉垂目中，都是那样的满心欢喜，念在唇边，放在心里，不遮掩，不刻意，如花开静好，清香泗溢。&nbsp;</p><p>&nbsp; &nbsp;海子说：“生命中有很多的东西，能忘掉的叫过去，忘不掉的叫记忆。”三毛说：“如果有来生，要做一棵树，站成永恒，没有悲伤的姿势；一半在尘土里安详，一半在空中飞扬；一半散落阴凉，一半沐浴阳光。非常沉默，非常骄傲，从不依靠，从不寻找。”&nbsp;这样的句子，轻轻一嗅，有暗香，有领悟，不需要揣摩，不需要拿捏，清晰的禅韵，妥妥的安放在文字里，温良四起。&nbsp;</p><p>&nbsp; “你来世间一趟，你要看看太阳，和你的心上人，一起走在街上。”&nbsp;</p><p>&nbsp; 拈一朵花在手，细细端详着温和，日子长长久久，一步一步的走，每一个过程，每一次交集，都是一种意念的修行，努力了，快乐与阳光，就会多一些，懒惰了，情绪与忧伤，就会乱一些，遇见了，情意与感动，就会满一些，生活的向往，静怡的光芒，时刻要懂得与从容为伴，要明了豁达的真善，做一个有智慧的人，寻一个可心体贴的人。&nbsp;</p><p>&nbsp;“泅渡一个世界，共赴一场生死，等一个人，还是等一个故事。”&nbsp;</p><p>&nbsp;将记忆之门打开，有声音穿过四季，那是远山的眷恋，散落了一地，如果我与你，青山澄碧，云水相系，最初的艳丽，只能用思念来代替，一份情感，隔着悠悠岁月，始终温润如玉，驿动的心，从未停息，我在你眼里，你在我心里，爱，是不可分割的主题，情，是惯穿光阴的回忆，当霜染白发，浮华散去，我提笔整理，心之角落，存放的种种记忆，那是岁月赠予我们，无与伦比的美丽。&nbsp;</p><p></p><p>&nbsp; 沿着指间的时光，轻触岁月的回廊，偷吻一夜梦的馨香，思绪，飘逸绵长，输一段冬情，许欢歌随行，幸福，简单生长，吾心，静好畅想&nbsp;。</p><p><br></p>', '时间叶片，指间岁月', '2017-06-03 10:21:48', '3');
INSERT INTO `diarycontent` VALUES ('20170603115331', '<p>每个深夜都是矛盾体在释放，忍住了，你是天使；忍不住，你是恶魔。</p><p>&nbsp;</p><p>圣诞结，嗯，我没写错，不是圣诞节；</p><p>有些事，解得开，是结，解不开，是劫；</p><p>对于橘子来说，似乎每一场喧嚣的节日，都像是形单影只煎熬的渡劫；</p><p>热闹是别人的，她什么也没有，就像奶茶歌里唱得“一群人的狂欢一个人的孤单……”</p><p>&nbsp;</p><p>快两年了……时间这个狡猾的骗子，所有一切掩藏的毫无痕迹，伤痛仿佛快要被治愈，却又慢慢衍生着新的伤痛慢慢入侵，像个后发制人的突击者，毫无防备，瞬间击杀，随之崩塌。</p><p>&nbsp;</p><p>我一直以为，她笑得那么开心，一定从病房走出来了。原来，坚强，不过是温柔生的茧。</p><p>&nbsp;</p><p>平安夜，很多朋友邀橘子出去嗨，看电影、蒸桑拿、飙车去外滩、K歌、吃饭…后来她统统推掉，说回家陪父母。本以为回家了就能好一些，可是敲门没人应，自己拿钥匙开门，家里空无一人…憋了一天的情绪仿佛找到一个泄洪口，一下子爆发，然后再也守不住。橘子又掉眼泪了！！甩掉背包、脱掉棉衣，跑进房间坐地上就哭，也不知道哪来这么多委屈，哪来这么多眼泪…这个平安夜真的平静又安静……</p><p>&nbsp;</p><p>或许，她没有走出内心的阴霾。一到深夜，橘子就会释放自己的恶魔，变成另一个自己。我问，她只说没事。后来，我装作知道，又装作不知道，静静的看着黑夜沉沦的另一个橘子。只是，夜尽天明，她若无其事的样子，真得好令人心疼。</p><p>&nbsp;</p><p>前任和她说：“在我们的事情上，确实错在我，那么优秀的你，该过好的生活。我希望你好，也希望有那么样的机会以最最最好朋友的身份照顾你陪着你！”</p><p>&nbsp;</p><p>看着橘子的记录，黄莲味的心酸缱绻在舌尖，吃了大半个橙子，嘴里还是觉得有些涩，就像你听见有一个异性对你说“你是个好人”一样。</p><p>&nbsp;</p><p>我们诚惶诚恐，我们小心翼翼，我们毫无保留，却不一定就能把爱，变成相爱。如果这一次真得背过身我们不再遇见了，那我希望我们可以面对面再背对背，永远不留遗憾，一生山高水阔。只是，后来，我们都甘愿被生活凌迟。</p><p>&nbsp;</p><p>大道理，橘子都懂，只是安慰别人的话劝不了自己。橘子说，我不怪他，我也不会再需要他。可有时候，你会觉得谁都可以，又觉得谁都不可以。</p><p>&nbsp;</p><blockquote>就像曾经的那段日子“早”，“晚安”一天，甜蜜的开始，幸福的结束。后来，只有冷冷的早晨，没有了夜里的温暖。没有了晚安后来，再也没有了后来</blockquote><p>&nbsp;</p><p>我们熟悉的习惯，突然被抽离的时候，你会觉得少了什么，可又说不出是什么，只知道，有一种空落落，让自己夜夜辗转难侧。</p><p>&nbsp;</p><p>就像等得公交没有按时来，点得外卖拖了一刻又一刻&nbsp;&nbsp;</p><p>&nbsp;</p><p>&nbsp;</p><p>我们都像是上了桌的赌徒，从未想着输着离开</p><p>我们不是在逞强，只是忘记了怎么软弱；</p><p>于是，夜里，都变成了自己的吸血鬼。</p><p>&nbsp;</p><p>橘子，记得，难过的时候，嘴里含一颗糖</p><p>&nbsp;</p><blockquote>你的眼睛，辣么好看适合装下所有深情&nbsp;你的鼻子，辣么好看适合闻爱情的味道&nbsp;你的手，辣么好看适合牵着到老&nbsp;你的耳朵，辣么好看适合听上一生的情话</blockquote><p>&nbsp;</p><p>脱缰的马不是好马，宝马跑了，你会有奥迪的</p><p></p><p>深夜，是和往事和解的咖啡屋，晚安即释怀</p><p><br></p>', '人总要学会在深夜跟往事和解，晚安即释怀', '2017-06-03 12:15:14', '8');
INSERT INTO `diarycontent` VALUES ('20170603121019', '<p><img src=\"/springmvc_mybatis/img/tza_thumb.gif\" style=\"line-height: 1; background-color: initial;\">回眸，你的轻笑抹过我肩头；一缕长发的幽香散尽，千里之外，你已是让人思念的风景。天涯从此成为寄托温柔的梦乡，牵指漫步的相爱经历，在月华相依的小池荷径模糊了深情。</p><p>&nbsp;</p><p>　　悠然轻放的菊收尽晚秋的花色，叶等久了时间的诺言，枯萎了期待的热情，在霜白露重的清晨落下枝头。芬芳已埋葬在昨日的记忆里，放一只空杯盛满你以往的丝呓纤影，醉了眼神在月夜凄楚的孤零中熬着空境。</p><p>&nbsp;</p><p>　　脚步依旧在那清冷的河堤漫走，干裸的柳条抽痛了额头，惊醒的瞬间寻着你的衣窈裙秀。秋水冰寒，澜波不起，羞问河流去的方向，能否捎一段相思的倾诉。</p><p>&nbsp;</p><p>　　心已在风雨后满目创伤，在没有哪一夜能息眠安详，每一刻你都是我的最想，落花流影处你已在水一方。不要在温阳沐浴的午后嘱托雁行，遥远的地方只有蓝色的渺茫，一缕霞光无法链接千重山峦的阻挡。</p><p>&nbsp;</p><p>　　彼此为念为春天的小路编织浓香，引来蜂蝶酝酿蜜汁甜稠的过往。不是追求你一生一世年轻的面庞，只若我逸洒春水，你颖然无忌的绽放。</p><p>&nbsp;</p><p>　　求一符平安，祈福你来时或去时的路上。</p><p>&nbsp;</p><p>　　想你，你已在万星寥寂的远方，是否愿意记起这里还有一个人，一个想着你饥寒冷暖的情郎。又一季情人相偎的时光，玫瑰独自在轮回着惆怅，送不出渐渐失掉真爱的模样。</p><p>&nbsp;</p><p>　　素笔嫣花画满了记录岁月的廊坊，你的长发曾经婉落如潮，袭人心色，迷人眸茫。曾为你梳妆，挽留你长发绕手的馨香。</p><p>&nbsp;</p><p>　　红颜如去，莫留岁月浅唱，一把孤独终老的琴弦犹自弹弄着忧伤。生活浪费了太多的情感激荡，能有多少放下，多少收藏。也许等待不需要你来验证，眼角依旧挂着你走时不舍的泪光。</p><p>&nbsp;</p><p>　　知道你来过我的世界，不再奢求你总在我空白的院场里留爱，留一曲安慰寂寞的浅唱。多希望能有穿梭离空的绝世武功，将这凄楚的思念讲给你天涯独醉的夜乡。</p><p>&nbsp;</p><p>　　风不愿在桃花深处徜徉，雨不愿在秋水微澜里联想。如果你想借走我的光阴，愿意用生命挽留你的青春。</p><p>&nbsp;</p><p></p><p>　　浩瀚迷离，红颜如去，苦了岁月的荏苒年华。翻开书页，捻起那丝长发，为爱做一个结，一个梦里的繁华。</p><p><br></p>', '红颜如去，莫留岁月浅唱', '2017-06-03 12:15:43', '8');

-- ----------------------------
-- Table structure for friendgroup
-- ----------------------------
DROP TABLE IF EXISTS `friendgroup`;
CREATE TABLE `friendgroup` (
  `gId` int(11) NOT NULL AUTO_INCREMENT COMMENT '分组表id',
  `userId` int(11) NOT NULL COMMENT '分组所属用户',
  `gNo` varchar(20) NOT NULL DEFAULT 'default' COMMENT '所属用户好友分组号,规则：userId_yyyyMMddHHmmss',
  `gName` varchar(255) NOT NULL DEFAULT '我的好友' COMMENT '分组名称',
  PRIMARY KEY (`gId`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of friendgroup
-- ----------------------------
INSERT INTO `friendgroup` VALUES ('1', '7', 'default', '我的好友');
INSERT INTO `friendgroup` VALUES ('3', '7', '7_20170430145758', '斗破苍穹好友');
INSERT INTO `friendgroup` VALUES ('4', '1', 'default', '我的好友');
INSERT INTO `friendgroup` VALUES ('5', '8', 'default', '我的好友');
INSERT INTO `friendgroup` VALUES ('7', '8', '8_20170605012443', '大学同学');
INSERT INTO `friendgroup` VALUES ('8', '9', 'default', '我的好友');

-- ----------------------------
-- Table structure for friendmap
-- ----------------------------
DROP TABLE IF EXISTS `friendmap`;
CREATE TABLE `friendmap` (
  `friendmapId` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) DEFAULT NULL COMMENT '用户id',
  `friendId` int(11) DEFAULT NULL COMMENT '好友id',
  `verifyInfo` varchar(255) DEFAULT NULL COMMENT '添加好友时输入：验证信息',
  `status` int(1) DEFAULT NULL COMMENT '好友状态：0.申请添加好友,等待验证；1.通过验证，添加成功；2.拒绝添加；3.删除；4.待验证',
  `addTime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  `beiZhu` varchar(255) DEFAULT NULL COMMENT '好友备注',
  `lastVisitTime` datetime DEFAULT NULL COMMENT '上次访问空间时间',
  `gNo` varchar(20) DEFAULT 'default' COMMENT '分组id，默认有一个分组default，默认新添加好友在默认分组里',
  `allowVisited` int(1) DEFAULT '0' COMMENT '允许访问我的空间：0允许，1不允许',
  `hideDynamic` int(1) DEFAULT '1' COMMENT '隐藏他的动态：0：是，1：否',
  `careStatus` int(1) DEFAULT '1' COMMENT '特别关心：0：是，1：否',
  PRIMARY KEY (`friendmapId`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of friendmap
-- ----------------------------
INSERT INTO `friendmap` VALUES ('1', '4', '7', null, '1', '2017-06-05 23:25:52', '萧炎-企鹅', '2017-06-05 23:25:52', 'default', '0', '1', '1');
INSERT INTO `friendmap` VALUES ('2', '7', '4', null, '1', '2017-05-09 20:46:58', '唐斐', '2017-04-22 17:44:22', 'default', '1', '1', '1');
INSERT INTO `friendmap` VALUES ('13', '7', '11', null, '1', '2017-04-30 16:47:16', '薰儿', '2017-04-30 16:47:14', '7_20170430145758', '0', '1', '1');
INSERT INTO `friendmap` VALUES ('14', '11', '7', null, '1', '2017-04-30 16:47:44', '萧炎', '2017-04-30 16:47:40', 'default', '0', '1', '1');
INSERT INTO `friendmap` VALUES ('19', '7', '1', '超哥，你好啊，我想加你为好友可以么？', '0', '2017-06-05 12:34:58', '超哥', null, 'default', '0', '1', '1');
INSERT INTO `friendmap` VALUES ('20', '1', '7', null, '4', '2017-06-05 12:35:06', '新好友', null, 'default', '0', '1', '1');
INSERT INTO `friendmap` VALUES ('33', '7', '9', 'daddy，加我好友啊', '1', '2017-06-05 11:55:09', '萧战爸比', null, '7_20170430145758', '0', '1', '1');
INSERT INTO `friendmap` VALUES ('34', '9', '7', 'daddy，加我好友啊', '1', '2017-06-05 11:22:31', '儿子', null, 'default', '0', '1', '1');
INSERT INTO `friendmap` VALUES ('39', '7', '8', '你好啊，祖父', '1', '2017-06-05 23:21:19', '萧玄祖父', '2017-06-05 23:21:19', 'default', '0', '1', '1');
INSERT INTO `friendmap` VALUES ('40', '8', '7', '你好啊，祖父', '1', '2017-06-05 20:38:56', '萧炎祖孙', '2017-06-05 20:38:56', 'default', '0', '1', '1');

-- ----------------------------
-- Table structure for messageboard
-- ----------------------------
DROP TABLE IF EXISTS `messageboard`;
CREATE TABLE `messageboard` (
  `messageId` int(11) NOT NULL AUTO_INCREMENT,
  `leaveId` int(11) DEFAULT NULL,
  `masterId` int(11) DEFAULT NULL,
  `messageContent` varchar(255) DEFAULT NULL,
  `messageTime` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`messageId`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of messageboard
-- ----------------------------
INSERT INTO `messageboard` VALUES ('1', '8', '7', '萧炎啊，恭喜你晋入斗帝境界，总算是为我们萧族争了口气啊。啊哈哈~<img src=\"/springmvc_mybatis/img/laugh.gif\" title=\"[哈哈]\">', '2017-06-05 23:22:55');

-- ----------------------------
-- Table structure for photo
-- ----------------------------
DROP TABLE IF EXISTS `photo`;
CREATE TABLE `photo` (
  `photoId` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) DEFAULT NULL,
  `photoDirId` int(11) DEFAULT NULL,
  `photoUrl` varchar(255) DEFAULT NULL,
  `uploadTime` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `photoName` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`photoId`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of photo
-- ----------------------------
INSERT INTO `photo` VALUES ('2', '7', '1', '20170514091352boy17.jpg', '2017-05-21 11:57:26', 'boy17');
INSERT INTO `photo` VALUES ('3', '7', '1', '20170514091352boyGun.jpg', '2017-05-21 11:57:22', 'boyGun');
INSERT INTO `photo` VALUES ('39', '7', '2', '20170521111644world_tree.jpg', '2017-05-21 11:57:19', 'world_tree');
INSERT INTO `photo` VALUES ('41', '7', '2', '20170521112629shilan.jpg', '2017-05-21 11:57:14', 'shilan');
INSERT INTO `photo` VALUES ('42', '7', '2', '20170521112813green.jpg', '2017-05-21 11:57:11', 'green');
INSERT INTO `photo` VALUES ('43', '7', '1', '20170521112835green.jpg', '2017-05-21 11:57:07', 'green');
INSERT INTO `photo` VALUES ('44', '7', '1', '20170521112852window7.jpg', '2017-05-21 11:57:04', 'window7');
INSERT INTO `photo` VALUES ('45', '7', '1', '20170521112945boy.jpg', '2017-05-21 11:57:01', 'boy');
INSERT INTO `photo` VALUES ('47', '7', '1', '20170521113331yellow.jpg', '2017-05-21 11:56:56', 'yellow');
INSERT INTO `photo` VALUES ('48', '7', '1', '20170521115426lettleYellow.jpg', '2017-05-21 11:54:26', 'lettleYellow');
INSERT INTO `photo` VALUES ('49', '7', '1', '20170524205900BingNight12.jpg', '2017-05-24 20:59:00', 'BingNight12');
INSERT INTO `photo` VALUES ('50', '7', '3', '20170525230505boy17.jpg', '2017-05-25 23:05:05', 'boy17');
INSERT INTO `photo` VALUES ('51', '7', '3', '20170525230505boyGun.jpg', '2017-05-25 23:05:05', 'boyGun');

-- ----------------------------
-- Table structure for photodir
-- ----------------------------
DROP TABLE IF EXISTS `photodir`;
CREATE TABLE `photodir` (
  `photoDirId` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) DEFAULT NULL COMMENT '所属用户',
  `photoDirName` varchar(255) DEFAULT NULL COMMENT '相册名称',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`photoDirId`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of photodir
-- ----------------------------
INSERT INTO `photodir` VALUES ('1', '7', '风景', '2017-05-20 22:42:16');
INSERT INTO `photodir` VALUES ('2', '7', '人物', '2017-05-20 23:17:10');
INSERT INTO `photodir` VALUES ('3', '7', '大学的那些美好时光-纪念回不去的过去', '2017-05-20 23:17:27');
INSERT INTO `photodir` VALUES ('4', '7', '高中', '2017-05-20 23:17:34');
INSERT INTO `photodir` VALUES ('5', '7', '旅游', '2017-05-20 23:17:52');

-- ----------------------------
-- Table structure for talk
-- ----------------------------
DROP TABLE IF EXISTS `talk`;
CREATE TABLE `talk` (
  `talkId` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `talkTime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  `talkContent` text,
  `talkPic` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`talkId`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8 COMMENT='˵˵��Ϣ��';

-- ----------------------------
-- Records of talk
-- ----------------------------
INSERT INTO `talk` VALUES ('1', '1', '2017-04-03 08:00:00', '今天星期一', null);
INSERT INTO `talk` VALUES ('2', '1', '2017-04-05 12:36:00', '今天星期三', null);
INSERT INTO `talk` VALUES ('3', '1', '2017-04-09 15:00:25', '今天海贼王更新，龙珠超更新', null);
INSERT INTO `talk` VALUES ('4', '1', '2017-04-09 17:00:00', '明天发工资，耶，该买个什么手机呢', null);
INSERT INTO `talk` VALUES ('5', '1', '2017-04-09 17:00:32', '测试时间戳', null);
INSERT INTO `talk` VALUES ('22', '1', '2017-04-09 19:35:02', 'fadfadfa', null);
INSERT INTO `talk` VALUES ('24', '1', '2017-04-09 19:39:47', '今天是个好日子', null);
INSERT INTO `talk` VALUES ('25', '1', '2017-04-09 19:43:46', '能不能自动刷新页面呢', null);
INSERT INTO `talk` VALUES ('26', '1', '2017-04-09 19:44:34', '可以刷新耶 ，不错，发表说说成功', null);
INSERT INTO `talk` VALUES ('27', '1', '2017-04-09 20:19:31', '你猜啊', null);
INSERT INTO `talk` VALUES ('28', '1', '2017-04-09 20:30:09', '大', null);
INSERT INTO `talk` VALUES ('29', '1', '2017-04-09 20:32:04', '测试能不能发表呢', null);
INSERT INTO `talk` VALUES ('30', '1', '2017-04-09 20:32:18', '可以发表耶', null);
INSERT INTO `talk` VALUES ('31', '4', '2017-04-09 20:54:47', '第一次发说说，好激动啊', null);
INSERT INTO `talk` VALUES ('32', '4', '2017-04-09 21:00:42', '阿贵会唱什么歌啊', null);
INSERT INTO `talk` VALUES ('33', '4', '2017-04-09 21:06:16', '阿贵是个麦霸', null);
INSERT INTO `talk` VALUES ('34', '4', '2017-04-09 21:08:32', '阿贵也是个学霸', null);
INSERT INTO `talk` VALUES ('35', '4', '2017-04-09 21:08:37', '吼吼吼', null);
INSERT INTO `talk` VALUES ('36', '4', '2017-04-09 21:29:04', '测试能不能发表表情呢？<img src=\"/springmvc_mybatis/img/yw_thumb.gif\" title=\"[疑问]\">', null);
INSERT INTO `talk` VALUES ('37', '4', '2017-04-09 21:53:16', '哇咔咔', null);
INSERT INTO `talk` VALUES ('38', '7', '2017-04-18 22:12:58', '测试发第一条说说哦', null);
INSERT INTO `talk` VALUES ('39', '7', '2017-04-18 22:18:37', 'haha<img src=\"/springmvc_mybatis/img/kl_thumb.gif\" title=\"[可怜]\" style=\"line-height: 1.42857;\">', null);
INSERT INTO `talk` VALUES ('40', '7', '2017-04-18 22:31:55', '我就想发个说说<img src=\"/springmvc_mybatis/img/mb_thumb.gif\" title=\"[太开心]\">', null);
INSERT INTO `talk` VALUES ('41', '4', '2017-04-23 14:36:15', '我就想发个说说<img src=\"/springmvc_mybatis/img/mb_thumb.gif\" title=\"[太开心]\">', null);
INSERT INTO `talk` VALUES ('42', '7', '2017-05-01 20:36:39', '撒大苏打<img src=\"/springmvc_mybatis/img/zhh_thumb.gif\" title=\"[左哼哼]\"><img src=\"/springmvc_mybatis/img/x_thumb.gif\" title=\"[嘘]\">', null);
INSERT INTO `talk` VALUES ('43', '7', '2017-05-01 20:36:54', '阿斯顿撒旦<img src=\"/springmvc_mybatis/img/cj_thumb.gif\" title=\"[吃惊]\">', null);
INSERT INTO `talk` VALUES ('44', '7', '2017-05-13 18:56:05', '你好啊<img src=\"/springmvc_mybatis/img/lovea_thumb.gif\" title=\"[爱你]\">', null);
INSERT INTO `talk` VALUES ('45', '8', '2017-06-03 18:21:49', '我就发一条说说<img src=\"/springmvc_mybatis/img/x_thumb.gif\" title=\"[嘘]\">', null);
INSERT INTO `talk` VALUES ('46', '8', '2017-06-03 18:22:17', '还是发两条吧<img src=\"/springmvc_mybatis/img/zy_thumb.gif\" title=\"[挤眼]\">', null);
INSERT INTO `talk` VALUES ('47', '8', '2017-06-04 17:24:50', '哈喽，我又来发说说啦，嘿嘿&nbsp;<img src=\"/springmvc_mybatis/img/mb_thumb.gif\" title=\"[太开心]\">', null);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `userId` int(11) NOT NULL AUTO_INCREMENT,
  `userAccount` varchar(10) NOT NULL COMMENT '用户登录账户',
  `password` varchar(20) NOT NULL,
  `userName` varchar(10) DEFAULT NULL COMMENT '用户昵称',
  `sex` varchar(1) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `lastLoginTime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT '上次登录时间',
  `masterHope` varchar(255) DEFAULT NULL COMMENT '主人寄语',
  `personalSign` varchar(255) DEFAULT NULL COMMENT '个性签名',
  `bloodType` varchar(255) DEFAULT NULL COMMENT '血型',
  `emotion` varchar(255) DEFAULT NULL COMMENT '感情状况：单身，恋爱中，已婚，（离异）',
  `prefessional` varchar(255) DEFAULT NULL COMMENT '职业',
  `company` varchar(255) DEFAULT NULL COMMENT '公司',
  `hobby` varchar(255) DEFAULT NULL COMMENT '爱好',
  `currentAddress` varchar(255) DEFAULT NULL COMMENT '现居地',
  `hometown` varchar(255) DEFAULT NULL COMMENT '故乡',
  `birthday` date DEFAULT NULL COMMENT '生日',
  `constellation` varchar(255) DEFAULT NULL COMMENT '星座',
  PRIMARY KEY (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COMMENT='QQ�û���Ϣ��';

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', '854493984', '123456', '超哥', '男', '24', '2017-05-01 12:28:31', '欢迎给我留言', '愿你过的尽兴而不是庆幸', 'O', '单身', 'IT', '高阳', '滑旱冰、打台球、听音乐、敲代码', '北京市海淀区', '山西省晋城市', '1994-03-01', null);
INSERT INTO `user` VALUES ('2', '121212121', '123456', '阿贵', '男', '24', '2017-04-26 21:38:36', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `user` VALUES ('3', '123456789', '123456', '简兮', '女', '26', '2017-04-26 21:38:36', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `user` VALUES ('4', '123456781', '123456', '唐斐', '男', '28', '2017-04-26 21:38:36', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `user` VALUES ('5', '123456782', '123456', '安心', '女', '29', '2017-04-26 21:38:36', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `user` VALUES ('6', '123456783', '123456', '路飞', '男', '20', '2017-04-26 21:38:36', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `user` VALUES ('7', '123', '123', '萧炎', '男', '20', '2017-06-06 00:09:24', 'system.out.println(\"Hello world!\");', null, null, null, null, null, null, null, null, null, null);
INSERT INTO `user` VALUES ('8', '100', '100', '萧玄', '男', '21', '2017-06-05 23:19:54', 'hello，你们好啊', '我乃萧族族长是也，虽然萧族如今衰败，我还是相信我儿子会带来萧族重新崛起的。', 'AB', '已婚', 'IT', '腾讯', '下棋，喝茶，打高尔夫', '西北地域加码帝国乌坦城', '乌坦城', '1970-07-01', null);
INSERT INTO `user` VALUES ('9', '101', '101', '萧战', '男', '22', '2017-06-05 12:05:23', '咳咳', null, null, null, null, null, null, null, null, null, null);
INSERT INTO `user` VALUES ('10', '102', '102', '萧媚', '女', '22', '2017-06-05 12:30:12', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `user` VALUES ('11', '103', '103', '薰儿', '女', '22', '2017-04-30 23:31:28', null, '谁敢伤我萧炎哥哥，我让他死无葬身之地', 'O', '恋爱中', 'IT', '百度', '唱歌，跳舞，听音乐，修炼金帝焚天炎', '中州古界', '古界', '1994-06-01', '');
INSERT INTO `user` VALUES ('12', '104', '104', '小医仙', '女', '21', '2017-06-03 18:40:35', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `user` VALUES ('13', '105', '105', '药尘', '男', '52', '2017-06-03 11:08:20', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `user` VALUES ('14', '106', '106', '彩鳞', '女', '22', '2017-04-29 16:07:21', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `user` VALUES ('15', '107', '107', '萧玉', '女', '22', '2017-05-13 18:51:28', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `user` VALUES ('16', '108', '108', '云韵', '女', '21', '2017-04-29 16:07:22', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `user` VALUES ('17', '109', '109', '纳兰嫣然', '女', '22', '2017-04-29 16:07:27', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `user` VALUES ('18', '110', '110', '欣然', '女', '22', '2017-05-13 17:29:08', null, null, null, null, null, null, null, null, null, null, null);
