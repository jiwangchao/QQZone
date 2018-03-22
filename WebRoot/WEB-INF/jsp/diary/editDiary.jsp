<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
    <c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>我的日志</title>

	<link rel="stylesheet" type="text/css" href="${ctx}/css/bootstrap.css"/>
	<link rel="stylesheet" type="text/css" href="${ctx}/css/personal_zone.css"/>
	<link rel="stylesheet" type="text/css" href="${ctx}/css/personal_talk.css"/>
	
	<link rel="stylesheet" type="text/css" href="${ctx}/css/diary.css"/>
	
	<!-- 富文本编辑器 -->
	<link rel="stylesheet" type="text/css" href="${ctx}/css/wangEditor/wangEditor.css">
	<script type="text/javascript" src="${ctx}/js/jquery-1.11.3.js"></script>
	<script type="text/javascript" src="${ctx}/js/bootstrap.min.js"></script>
	
	<script type="text/javascript">
		function sendDiary(){
			var textArea=$("#textarea2").html();
			var diaryTitle=$("#diaryContentTitle").val();
			var diaryBg=$("#diaryBg").val();
			//日志编辑器内默认有这些字符 ：  <p><br></p>
			if(textArea.length == 11){
				alert("不能发表内容为空的日志");
				return ; 
			}else if(diaryTitle==""){
				alert("请输入日志标题");
				return ; 
			}else{
				//$("#showDiaryContent").html(textArea);
				var path=$("#hiddenPath").val();
				$.ajax({
		              url:path+"/diary/addDiary.action",   
		              type: "POST",
		              data:{textArea:textArea,diaryTitle:diaryTitle,diaryBg:diaryBg},
		              cache: false,
		              dataType:"json",
		              success: function(data) {
		              	if(data == '1'){
		              			//alert("发表成功");
		              			window.location.href=path+"/diary/index.action";
		              		}else if(data== "-1"){
		              			alert("session失效，请重新登录!");
		              		}else if(data== "0"){
		              			alert("发表失败，参数为空!");
		              		}else{
		              			alert("发表失败！不明错误。");
		              		}
		              }
		         });
			}
		}
	</script>
</head>
<body>
	<%--隐藏域存放路径值，方便js获取 --%>
	<input type="hidden" value="${ctx}" id="hiddenPath" />
	<!-- 顶部一级菜单 -->
		<div id="nav">
			<div id="QQlogo"></div>
			<ul id="menu">
				<li><a href="${ctx}/log/personalZone.action" class="glyphicon glyphicon-star">&nbsp;个人中心</a></li>
				<li><a href="#" class="glyphicon glyphicon-home">&nbsp;我的主页</a></li>
				<li><a href="${ctx}/friend/myfriends.action" class="glyphicon glyphicon-user">&nbsp;好友</a></li>
				<!-- <li><a href="#" class="glyphicon glyphicon-asterisk">&nbsp;装扮</a></li> -->
			</ul>
			<div id="logout">
				<span>上次登录时间：<fmt:formatDate value="${sessionScope.user.lastLoginTime }" pattern="yyyy年MM月dd日  EEEE HH:mm:ss"/></span>
				<span><a href="${ctx}/log/logout.action">注销</a></span>
			</div>
		</div>

		<!-- 用户头像和昵称 -->
		<div id="center_nav">
			<div id="person_title">
				<h1>Family</h1>
				<span>我们终其一生想要的不过就是一个家，一个温暖的地方。http://user.qzone.qq.com</span>
			</div>
			<div id="person_pic">
				<img src="${ctx}/img/person_pic.jpg"/>
			</div>
			<div id="person_nickname">
				<span id="nickname_body">${sessionScope.user.userName }</span>
				<span id="yellow_diamond" onclick="yellow_diamond()"></span>
			</div>
		</div>
		
		<!-- 中部菜单 -->
		<div id="body_menu">
			<ul>
				<li><a href="#">主页</a></li>
				<li><a href="${ctx }/diary/index.action">日志</a></li>
				<li><a href="${ctx }/photo/index.action">相册</a></li>
				<li><a href="${ctx }/messageBoard/queryMymessageBoard.action">留言板</a></li>
				<li><a href="${ctx }/talk/queryMyTalkList.action">说说</a></li>
				<li><a href="#">个人档</a></li>
			</ul>
		</div>

		<!-- 右侧统计说说数量 -->		
		<%-- <div id="talkTotal">
			<table>
				<tr>
					<td rowspan="2"><img src="${ctx}/img/person_pic.jpg" /></td>
					<td>${sessionScope.user.userName }</td>
				</tr>
				<tr>
					<td><font color="orange" size="10px">${mytalkList.size() }</font>&nbsp;条说说</td>
				</tr>
			</table>
		</div> --%>
		
		
		<!-- 空间主体 -->
		<!-- <div id="body_content" >
			<div id="qq">
				<p>记录下生活中的点点滴滴</p>
				<div class="message" contentEditable='true' id="textarea2" style='height:1000px; width:100%;'></div>
			
				<div class="But">
					<span class='submit' onclick="sendDiary();">发表</span>
				</div>
			</div>
			
			
		</div> -->
		<br />
		
		<div id="diaryListmain">
			<div  style="margin-left:15px;">
				<div>
					<select name="diaryBg" id="diaryBg" onchange="diaryBg(this)" class="form-control" >
						<option value="0" selected="selected">无</option>
						<option value="1">yellow</option>
						<option value="2">paper</option>
						<option value="3">green</option>
						<option value="4">darkgrey</option>
						<option value="5">brown</option>
						<option value="6">buwen</option>
						<option value="7">white</option>
						<option value="8">book</option>
					</select>
				</div>
				<div style="background-color:white;height:60px;line-height:60px;border-radius:5px;color:black;font-size:700;">
					<input type="text" name="diaryContentTitle" id="diaryContentTitle" class="form-control" placeholder="请输入日志标题" style="height:60px;line-height:60px;ont-size:18px; "/>
				</div>
				<div class="message" contentEditable='true' id="textarea2" style='height:1000px; width:100%;'></div>
				<div class="But">
					<span class="submit btn btn-primary" onclick="sendDiary();">发表</span>
				</div>
				<div id="showDiaryContent" style="background-color:white;width:100%;">
					
				</div>
			</div>
		</div>
		
		<div>
			<br/>	
			<br/>
		</div>
	
	
	
	
	<%-- <script type="text/javascript" src="${ctx}/js/wangEditor-1.3.0.min.js"></script> --%>
	<script type="text/javascript" src="${ctx}/js/wangEditor.js"></script>
	
	<script type="text/javascript">
		//黄钻申请
		function yellow_diamond(){
			window.open("http://pay.qq.com/ipay/index.shtml?n=3&c=xxjzgw,xxjzghh&aid=info.nickname&ch=qdqb,kj"); 
		}
		//顶级菜单样式切换
		$(document).ready(function(){
	
			$('#menu li').mouseover(function(){
				$(this).addClass('on');
			}).mouseout(function(){
				$(this).removeClass('on');				
			});
			//加载富文本编辑器
			/* var editor1 = $('#textarea1').wangEditor(); */
			var editor = new wangEditor('textarea2');
			var path=$("#hiddenPath").val();
			//配置富文本表情包start
			// 配置自定义表情，在 create() 之前配置
			editor.config.emotions = {
			    //第一组
			    'weibo':{
			    	title: '本地',  // 组名称
			    	data: [  // data 还可以直接赋值为一个表情包数组
			    	         {
			    	             icon : path+"/img/zz2_thumb.gif",
			    	             value : "[织]"
			    	         }, {
			    	             icon : path+"/img/horse2_thumb.gif",
			    	             value : "[神马]"
			    	         }, {
			    	             icon : path+"/img/fuyun_thumb.gif",
			    	             value : "[浮云]"
			    	         }, {
			    	             icon : path+"/img/geili_thumb.gif",
			    	             value : "[给力]"
			    	         }, {
			    	             icon : path+"/img/wg_thumb.gif",
			    	             value : "[围观]"
			    	         }, {
			    	             icon : path+"/img/vw_thumb.gif",
			    	             value : "[威武]"
			    	         }, {
			    	             icon : path+"/img/panda_thumb.gif",
			    	             value : "[熊猫]"
			    	         }, {
			    	             icon : path+"/img/rabbit_thumb.gif",
			    	             value : "[兔子]"
			    	         }, {
			    	             icon : path+"/img/otm_thumb.gif",
			    	             value : "[奥特曼]"
			    	         }, {
			    	             icon : path+"/img/j_thumb.gif",
			    	             value : "[囧]"
			    	         }, {
			    	             icon : path+"/img/hufen_thumb.gif",
			    	             value : "[互粉]"
			    	         }, {
			    	             icon : path+"/img/liwu_thumb.gif",
			    	             value : "[礼物]"
			    	         }, {
			    	             icon : path+"/img/smilea_thumb.gif",
			    	             value : "[呵呵]"
			    	         }, {
			    	             icon : path+"/img/tootha_thumb.gif",
			    	             value : "[嘻嘻]"
			    	         }, {
			    	             icon : path+"/img/laugh.gif",
			    	             value : "[哈哈]"
			    	         }, {
			    	             icon : path+"/img/tza_thumb.gif",
			    	             value : "[可爱]"
			    	         }, {
			    	             icon : path+"/img/kl_thumb.gif",
			    	             value : "[可怜]"
			    	         }, {
			    	             icon : path+"/img/kbsa_thumb.gif",
			    	             value : "[挖鼻屎]"
			    	         }, {
			    	             icon : path+"/img/cj_thumb.gif",
			    	             value : "[吃惊]"
			    	         }, {
			    	             icon : path+"/img/shamea_thumb.gif",
			    	             value : "[害羞]"
			    	         }, {
			    	             icon : path+"/img/zy_thumb.gif",
			    	             value : "[挤眼]"
			    	         }, {
			    	             icon : path+"/img/bz_thumb.gif",
			    	             value : "[闭嘴]"
			    	         }, {
			    	             icon : path+"/img/bs2_thumb.gif",
			    	             value : "[鄙视]"
			    	         }, {
			    	             icon : path+"/img/lovea_thumb.gif",
			    	             value : "[爱你]"
			    	         }, {
			    	             icon : path+"/img/sada_thumb.gif",
			    	             value : "[泪]"
			    	         }, {
			    	             icon : path+"/img/heia_thumb.gif",
			    	             value : "[偷笑]"
			    	         }, {
			    	             icon : path+"/img/qq_thumb.gif",
			    	             value : "[亲亲]"
			    	         }, {
			    	             icon : path+"/img/sb_thumb.gif",
			    	             value : "[生病]"
			    	         }, {
			    	             icon : path+"/img/mb_thumb.gif",
			    	             value : "[太开心]"
			    	         }, {
			    	             icon : path+"/img/ldln_thumb.gif",
			    	             value : "[懒得理你]"
			    	         }, {
			    	             icon : path+"/img/yhh_thumb.gif",
			    	             value : "[右哼哼]"
			    	         }, {
			    	             icon : path+"/img/zhh_thumb.gif",
			    	             value : "[左哼哼]"
			    	         }, {
			    	             icon : path+"/img/x_thumb.gif",
			    	             value : "[嘘]"
			    	         }, {
			    	             icon : path+"/img/cry.gif",
			    	             value : "[衰]"
			    	         }, {
			    	             icon : path+"/img/wq_thumb.gif",
			    	             value : "[委屈]"
			    	         }, {
			    	             icon : path+"/img/t_thumb.gif",
			    	             value : "[吐]"
			    	         }, {
			    	             icon : path+"/img/k_thumb.gif",
			    	             value : "[打哈欠]"
			    	         }, {
			    	             icon : path+"/img/bba_thumb.gif",
			    	             value : "[抱抱]"
			    	         }, {
			    	             icon : path+"/img/angrya_thumb.gif",
			    	             value : "[怒]"
			    	         }, {
			    	             icon : path+"/img/yw_thumb.gif",
			    	             value : "[疑问]"
			    	         }, {
			    	             icon : path+"/img/cza_thumb.gif",
			    	             value : "[馋嘴]"
			    	         }, {
			    	             icon : path+"/img/88_thumb.gif",
			    	             value : "[拜拜]"
			    	         }, {
			    	             icon : path+"/img/sk_thumb.gif",
			    	             value : "[思考]"
			    	         }, {
			    	             icon : path+"/img/sweata_thumb.gif",
			    	             value : "[汗]"
			    	         }, {
			    	             icon : path+"/img/sleepya_thumb.gif",
			    	             value : "[困]"
			    	         }, {
			    	             icon : path+"/img/sleepa_thumb.gif",
			    	             value : "[睡觉]"
			    	         }, {
			    	             icon : path+"/img/money_thumb.gif",
			    	             value : "[钱]"
			    	         }, {
			    	             icon : path+"/img/sw_thumb.gif",
			    	             value : "[失望]"
			    	         }, {
			    	             icon : path+"/img/cool_thumb.gif",
			    	             value : "[酷]"
			    	         }, {
			    	             icon : path+"/img/hsa_thumb.gif",
			    	             value : "[花心]"
			    	         }, {
			    	             icon : path+"/img/hatea_thumb.gif",
			    	             value : "[哼]"
			    	         }, {
			    	             icon : path+"/img/gza_thumb.gif",
			    	             value : "[鼓掌]"
			    	         }, {
			    	             icon : path+"/img/dizzya_thumb.gif",
			    	             value : "[晕]"
			    	         }, {
			    	             icon : path+"/img/bs_thumb.gif",
			    	             value : "[悲伤]"
			    	         }, {
			    	             icon : path+"/img/crazya_thumb.gif",
			    	             value : "[抓狂]"
			    	         }, {
			    	             icon : path+"/img/h_thumb.gif",
			    	             value : "[黑线]"
			    	         }, {
			    	             icon : path+"/img/yx_thumb.gif",
			    	             value : "[阴险]"
			    	         }, {
			    	             icon : path+"/img/nm_thumb.gif",
			    	             value : "[怒骂]"
			    	         }, {
			    	             icon : path+"/img/hearta_thumb.gif",
			    	             value : "[心]"
			    	         }, {
			    	             icon : path+"/img/unheart.gif",
			    	             value : "[伤心]"
			    	         }, {
			    	             icon : path+"/img/pig.gif",
			    	             value : "[猪头]"
			    	         }, {
			    	             icon : path+"/img/ok_thumb.gif",
			    	             value : "[ok]"
			    	         }, {
			    	             icon : path+"/img/ye_thumb.gif",
			    	             value : "[耶]"
			    	         }, {
			    	             icon : path+"/img/good_thumb.gif",
			    	             value : "[good]"
			    	         }, {
			    	             icon : path+"/img/no_thumb.gif",
			    	             value : "[不要]"
			    	         }, {
			    	             icon : path+"/img/z2_thumb.gif",
			    	             value : "[赞]"
			    	         }, {
			    	             icon : path+"/img/come_thumb.gif",
			    	             value : "[来]"
			    	         }, {
			    	             icon : path+"/img/sad_thumb.gif",
			    	             value : "[弱]"
			    	         }, {
			    	             icon : path+"/img/lazu_thumb.gif",
			    	             value : "[蜡烛]"
			    	         }, {
			    	             icon : path+"/img/cake.gif",
			    	             value : "[蛋糕]"
			    	         }, {
			    	             icon : path+"/img/clock_thumb.gif",
			    	             value : "[钟]"
			    	         }, {
			    	             icon : path+"/img/m_thumb.gif",
			    	             value : "[话筒]"
			    	         }, {
			    	             icon : path+"/img/weijin_thumb.gif",
			    	             value : "[围脖]"
			    	         }, {
			    	             icon : path+"/img/lxhzhuanfa_thumb.gif",
			    	             value : "[转发]"
			    	         }, {
			    	             icon : path+"/img/lxhluguo_thumb.gif",
			    	             value : "[路过这儿]"
			    	         }, {
			    	             icon : path+"/img/bofubianlian_thumb.gif",
			    	             value : "[bofu变脸]"
			    	         }, {
			    	             icon : path+"/img/gbzkun_thumb.gif",
			    	             value : "[gbz困]"
			    	         }, {
			    	             icon : path+"/img/boboshengmenqi_thumb.gif",
			    	             value : "[生闷气]"
			    	         }, {
			    	             icon : path+"/img/chn_buyaoya_thumb.gif",
			    	             value : "[不要啊]"
			    	         }, {
			    	             icon : path+"/img/daxiongleibenxiong_thumb.gif",
			    	             value : "[dx泪奔]"
			    	         }, {
			    	             icon : path+"/img/cat_yunqizhong_thumb.gif",
			    	             value : "[运气中]"
			    	         }, {
			    	             icon : path+"/img/youqian_thumb.gif",
			    	             value : "[有钱]"
			    	         }, {
			    	             icon : path+"/img/cf_thumb.gif",
			    	             value : "[冲锋]"
			    	         }, {
			    	             icon : path+"/img/camera_thumb.gif",
			    	             value : "[照相机]"
			    	         }
			    	      ]
			    		},
			    	   // 第一组，id叫做 'default' 
					    'default': {
					        title: '网络',  // 组名称
					        data: 'http://www.wangeditor.com/wangEditor/test/emotions.data'  // 服务器的一个json文件url，例如官网这里配置的是 http://www.wangeditor.com/wangEditor/test/emotions.data
					    }
			 	// 下面还可以继续，第三组、第四组、、、
			};
			//第二步 将显示方式改为 icon ，要在 create() 之前修改----icon插入图片时会显示真正的图片，value会显示图片的名称
			editor.config.emotionsShow = 'icon';
			editor.create();
			//配置富文本表情包end
		});	
		
		function diaryBg(obj){
			var path=$("#hiddenPath").val();
			console.log(path);
			var bgimg=$(obj).val();
			console.log(bgimg);
			if(bgimg=='1'){
				$("#textarea2").attr("style","background:url("+path+"/img/diarybg/yellow.jpg);height: 900px;");
			}else if(bgimg=='2'){
				$("#textarea2").attr("style","background:url("+path+"/img/diarybg/paper.jpg);height: 900px;");
			}else if(bgimg=='3'){
				$("#textarea2").attr("style","background:url("+path+"/img/diarybg/green.jpg);height: 900px;");
			}else if(bgimg=='4'){
				$("#textarea2").attr("style","background:url("+path+"/img/diarybg/darkgrey.jpg);height: 900px;");
			}else if(bgimg=='5'){
				$("#textarea2").attr("style","background:url("+path+"/img/diarybg/brown.jpg);height: 900px;");
			}else if(bgimg=='6'){
				$("#textarea2").attr("style","background:url("+path+"/img/diarybg/buwen.jpg);height: 900px;");
			}else if(bgimg=='7'){
				$("#textarea2").attr("style","background:url("+path+"/img/diarybg/white.jpg);height: 900px;");
			}else if(bgimg=='8'){
				$("#textarea2").attr("style","background:url("+path+"/img/diarybg/book.jpg);height: 900px;");
			}
			
			// paper  green  darkgrey
		}
	</script>
	
</body>
</html>