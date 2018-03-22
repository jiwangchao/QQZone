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
			var diaryContentId=$("#hiddenDiaryContentId").val();
			var textArea=$("#textarea2").html();
			var diaryTitle=$("#diaryContentTitle").val();
			var diaryBg=$("#diaryBg").val();
			//日志编辑器内默认有这些字符 ：  <p><br></p>
			console.log(textArea.length);
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
		              url:path+"/diary/updateDiarySubmit.action",   
		              type: "POST",
		              data:{diaryContentId:diaryContentId,textArea:textArea,diaryTitle:diaryTitle,diaryBg:diaryBg},
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
				<c:if test="${empty logUser }">
					<!--<span id="error-icon" class="glyphicon glyphicon-info-sign"></span>-->
					<li><a href="${ctx}/log/personalZone.action" class="glyphicon glyphicon-star">&nbsp;个人中心</a></li>
					<li><a href="#" class="glyphicon glyphicon-home">&nbsp;我的主页</a></li>
					<li><a href="${ctx}/friend/myfriends.action" class="glyphicon glyphicon-user">&nbsp;好友</a></li>
					<!-- <li><a href="#" class="glyphicon glyphicon-asterisk">&nbsp;装扮</a></li> -->
				</c:if>
				<c:if test="${not empty logUser }">
					<li><a href="#" class="glyphicon glyphicon-home">&nbsp;他的主页</a></li>
				</c:if>
			</ul>
			<div id="logout">
				<c:if test="${empty logUser }">
					<span>上次登录时间：<fmt:formatDate value="${sessionScope.user.lastLoginTime }" pattern="yyyy年MM月dd日  EEEE HH:mm:ss"/></span>
					<span><a href="${ctx}/log/logout.action">注销</a></span>
				</c:if>
				<c:if test="${not empty logUser }">
					<span>上次访问时间：<fmt:formatDate value="${friendSetting.lastVisitTime }" pattern="yyyy年MM月dd日  EEEE HH:mm:ss"/></span>
					<span><a href="${ctx}/log/logout.action">注销</a></span>
					<span><a href="${ctx}/log/personalZone.action?returnMyConter=return">返回个人中心</a></span>
				</c:if>
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
	
		<br />
		
		<div id="diaryListmain">
			<div id="">
			
			<c:if test="${not empty updateDiaryFlag }">
				
				<div>
					<select name="diaryBg" id="diaryBg" onchange="diaryBg(this)" class="form-control" >
						<option value="0" <c:if test="${myDiary.diaryBg =='0'}">selected="selected"</c:if> >无</option>
						<option value="1" <c:if test="${myDiary.diaryBg =='1'}">selected="selected"</c:if> >yellow</option>
						<option value="2" <c:if test="${myDiary.diaryBg =='2'}">selected="selected"</c:if> >paper</option>
						<option value="3" <c:if test="${myDiary.diaryBg =='3'}">selected="selected"</c:if> >green</option>
						<option value="4" <c:if test="${myDiary.diaryBg =='4'}">selected="selected"</c:if> >darkgrey</option>
						<option value="5" <c:if test="${myDiary.diaryBg =='5'}">selected="selected"</c:if> >brown</option>
						<option value="6" <c:if test="${myDiary.diaryBg =='6'}">selected="selected"</c:if> >buwen</option>
						<option value="7" <c:if test="${myDiary.diaryBg =='7'}">selected="selected"</c:if> >white</option>
						<option value="8" <c:if test="${myDiary.diaryBg =='8'}">selected="selected"</c:if> >book</option>
					</select>
				</div>
				<div style="background-color:white;height:60px;line-height:60px;border-radius:5px;color:black;font-size:700;">
					<input type="text" name="diaryContentTitle" id="diaryContentTitle" class="form-control" value="${myDiary.diaryContentTitle }" placeholder="请输入日志标题" style="height:60px;line-height:60px;ont-size:18px; "/>
				</div>
				<div class="message" contentEditable='true' id="textarea2" style='height:1000px; width:100%;'>${myDiary.diaryContentText }</div>
				<div class="But">
					<span class="submit btn btn-primary" onclick="sendDiary();">保存</span>&nbsp;&nbsp;
					<span class="submit btn btn-primary" onclick="cancleEdit('${myDiary.diaryContentId}');">退出</span>
				</div>
			</c:if>
			
			<%--隐藏域存放日志信息 --%>
			<input type="hidden" id="hiddenDiaryContentId" value="${myDiary.diaryContentId}"/>
			<input type="hidden" id="hiddenDiaryBg" value="${myDiary.diaryBg }"/>
			<input type="hidden" id="hiddenDiaryUserId" value="${myDiary.userId }"/>
			
			<c:if test="${empty updateDiaryFlag }">
				
				<div id="showDiaryContent" style="background-color:white;width:100%;">
					<div style="height:60px;line-height:60px;border-radius:5px;color:black;font-size:700;">
						<h4 align="center" style="height:60px;line-height:60px;">${myDiary.diaryContentTitle }</h4>
					</div>
					<p>
						${myDiary.diaryContentText }
					</p>
					<br/>
				</div>
			</c:if>
			</div>
			<!-- 发表评论 -->
			<c:if test="${empty updateDiaryFlag }">
			<div id="qqCommentDiary">
				<p>快来给这篇日志评论吧</p>
				<div class="commentMessage" contentEditable='true' id="commentTextArea"></div>
				
				<div class="commentMessageBtn">
					<img src="${ctx}/img/bba_thumb.gif" class='bq'/>
					<span class='submitC' onclick="sendDiaryComment();">发表</span>
					<!--face begin-->
					<div class="face">
						<ul>
							<li><img src="${ctx}/img/zz2_thumb.gif" title="[织]" ></li>
							<li><img src="${ctx}/img/horse2_thumb.gif" title="神马]"></li>
							<li><img src="${ctx}/img/fuyun_thumb.gif" title="[浮云]"></li>
							<li><img src="${ctx}/img/geili_thumb.gif" title="[给力]"></li>
							<li><img src="${ctx}/img/wg_thumb.gif" title="[围观]"></li>
							<li><img src="${ctx}/img/vw_thumb.gif" title="[威武]"></li>
							<li><img src="${ctx}/img/panda_thumb.gif" title="[熊猫]"></li>
							<li><img src="${ctx}/img/rabbit_thumb.gif" title="兔子]"></li>
							<li><img src="${ctx}/img/otm_thumb.gif" title="[奥特曼]"></li>
							<li><img src="${ctx}/img/j_thumb.gif" title="[囧]"></li>
							<li><img src="${ctx}/img/hufen_thumb.gif" title="[互粉]"></li>
							<li><img src="${ctx}/img/liwu_thumb.gif" title="[礼物]"></li>
							<li><img src="${ctx}/img/smilea_thumb.gif" title="呵呵]"></li>
							<li><img src="${ctx}/img/tootha_thumb.gif" title="嘻嘻]"></li>
							<li><img src="${ctx}/img/laugh.gif" title="[哈哈]"></li>
							<li><img src="${ctx}/img/tza_thumb.gif" title="[可爱]"></li>
							<li><img src="${ctx}/img/kl_thumb.gif" title="[可怜]"></li>
							<li><img src="${ctx}/img/kbsa_thumb.gif" title="[挖鼻屎]"></li>
							<li><img src="${ctx}/img/cj_thumb.gif" title="[吃惊]"></li>
							<li><img src="${ctx}/img/shamea_thumb.gif" title="[害羞]"></li>
							<li><img src="${ctx}/img/zy_thumb.gif" title="[挤眼]"></li>
							<li><img src="${ctx}/img/bz_thumb.gif" title="[闭嘴]"></li>
							<li><img src="${ctx}/img/bs2_thumb.gif" title="[鄙视]"></li>
							<li><img src="${ctx}/img/lovea_thumb.gif" title="[爱你]"></li>
							<li><img src="${ctx}/img/sada_thumb.gif" title="[泪]"></li>
							<li><img src="${ctx}/img/heia_thumb.gif" title="[偷笑]"></li>
							<li><img src="${ctx}/img/qq_thumb.gif" title="[亲亲]"></li>
							<li><img src="${ctx}/img/sb_thumb.gif" title="[生病]"></li>
							<li><img src="${ctx}/img/mb_thumb.gif" title="[太开心]"></li>
							<li><img src="${ctx}/img/ldln_thumb.gif" title="[懒得理你]"></li>
							<li><img src="${ctx}/img/yhh_thumb.gif" title="[右哼哼]"></li>
							<li><img src="${ctx}/img/zhh_thumb.gif" title="[左哼哼]"></li>
							<li><img src="${ctx}/img/x_thumb.gif" title="[嘘]"></li>
							<li><img src="${ctx}/img/cry.gif" title="[衰]"></li>
							<li><img src="${ctx}/img/wq_thumb.gif" title="[委屈]"></li>
							<li><img src="${ctx}/img/t_thumb.gif" title="[吐]"></li>
							<li><img src="${ctx}/img/k_thumb.gif" title="[打哈气]"></li>
							<li><img src="${ctx}/img/bba_thumb.gif" title="[抱抱]"></li>
							<li><img src="${ctx}/img/angrya_thumb.gif" title="[怒]"></li>
							<li><img src="${ctx}/img/yw_thumb.gif" title="[疑问]"></li>
							<li><img src="${ctx}/img/cza_thumb.gif" title="[馋嘴]"></li>
							<li><img src="${ctx}/img/88_thumb.gif" title="[拜拜]"></li>
							<li><img src="${ctx}/img/sk_thumb.gif" title="[思考]"></li>
							<li><img src="${ctx}/img/sweata_thumb.gif" title="[汗]"></li>
							<li><img src="${ctx}/img/sleepya_thumb.gif" title="[困]"></li>
							<li><img src="${ctx}/img/sleepa_thumb.gif" title="[睡觉]"></li>
							<li><img src="${ctx}/img/money_thumb.gif" title="[钱]"></li>
							<li><img src="${ctx}/img/sw_thumb.gif" title="[失望]"></li>
							<li><img src="${ctx}/img/cool_thumb.gif" title="[酷]"></li>
							<li><img src="${ctx}/img/hsa_thumb.gif" title="[花心]"></li>
							<li><img src="${ctx}/img/hatea_thumb.gif" title="[哼]"></li>
							<li><img src="${ctx}/img/gza_thumb.gif" title="[鼓掌]"></li>
							<li><img src="${ctx}/img/dizzya_thumb.gif" title="[晕]"></li>
							<li><img src="${ctx}/img/bs_thumb.gif" title="[悲伤]"></li>
							<li><img src="${ctx}/img/crazya_thumb.gif" title="[抓狂]"></li>
							<li><img src="${ctx}/img/h_thumb.gif" title="[黑线]"></li>
							<li><img src="${ctx}/img/yx_thumb.gif" title="[阴险]"></li>
							<li><img src="${ctx}/img/nm_thumb.gif" title="[怒骂]"></li>
							<li><img src="${ctx}/img/hearta_thumb.gif" title="[心]"></li>
							<li><img src="${ctx}/img/unheart.gif" title="[伤心]"></li>
							<li><img src="${ctx}/img/pig.gif" title="[猪头]"></li>
							<li><img src="${ctx}/img/ok_thumb.gif" title="[ok]"></li>
							<li><img src="${ctx}/img/ye_thumb.gif" title="[耶]"></li>
							<li><img src="${ctx}/img/good_thumb.gif" title="[good]"></li>
							<li><img src="${ctx}/img/no_thumb.gif" title="[不要]"></li>
							<li><img src="${ctx}/img/z2_thumb.gif" title="[赞]"></li>
							<li><img src="${ctx}/img/come_thumb.gif" title="[来]"></li>
							<li><img src="${ctx}/img/sad_thumb.gif" title="[弱]"></li>
							<li><img src="${ctx}/img/lazu_thumb.gif" title="[蜡烛]"></li>
							<li><img src="${ctx}/img/clock_thumb.gif" title="[钟]"></li>
							<li><img src="${ctx}/img/cake.gif" title="[蛋糕]"></li>
							<li><img src="${ctx}/img/m_thumb.gif" title="[话筒]"></li>
							<li><img src="${ctx}/img/weijin_thumb.gif" title="[围脖]"></li>
							<li><img src="${ctx}/img/lxhzhuanfa_thumb.gif" title="[转发]"></li>
							<li><img src="${ctx}/img/lxhluguo_thumb.gif" title="[路过这儿]"></li>
							<li><img src="${ctx}/img/bofubianlian_thumb.gif" title="[bofu变脸]"></li>
							<li><img src="${ctx}/img/gbzkun_thumb.gif" title="[gbz困]"></li>
							<li><img src="${ctx}/img/boboshengmenqi_thumb.gif" title="[生闷气]"></li>
							<li><img src="${ctx}/img/chn_buyaoya_thumb.gif" title="[不要啊]"></li>
							<li><img src="${ctx}/img/daxiongleibenxiong_thumb.gif" title="[dx泪奔]"></li>
							<li><img src="${ctx}/img/cat_yunqizhong_thumb.gif" title="[运气中]"></li>
							<li><img src="${ctx}/img/youqian_thumb.gif" title="[有钱]"></li>
							<li><img src="${ctx}/img/cf_thumb.gif" title="[冲锋]"></li>
							<li><img src="${ctx}/img/camera_thumb.gif" title="[照相机]"></li>	
						</ul>
					</div>
					<!--face end-->
				</div>
			</div>
			<!-- 发表评论结束 -->
			
			<div class="panel panel-info">
			    <div class="panel-heading">评论区</div>
			    <div class="panel-body">
			      <p>来自好友的评论</p>
			      
			      <!-- 遍历好友的评论 -->
			      <div id="list" style="display:block;">
					<c:if test="${not empty diaryCommentList }">
						<ul class="list-group">
						<c:forEach items="${diaryCommentList }" var="comment">
						    <li class="list-group-item" style="height:150px;">
						    	<div>
							    	<div class="col-lg-2 "  >
										<a class="thumbnail "><img src="${ctx}/img/tx.jpg" class="img-circle"/></a>
									</div>
							    	<%-- <img class="head" src="${ctx}/img/tx.jpg" alt="" height="100px" width="100px" /> --%>
							    	<span><font color="#369">${comment.userName }</font>:</span>
						    	</div>
						    	<div>
							    	<div>${comment.commentContent }</div>
							    	<div>${comment.commentTime }</div>
						    	</div>
						    </li>
							
							<%-- <div class="box clearfix">
					            <img class="head" src="${ctx}/img/tx.jpg" alt="" />
					            <div class="content">
					                <div class="main">
					                    <p class="txt">
					                    	<input type="hidden" class="hiddenTalkId" value="${list.talkId }" />
					                    	<input type="hidden" class="talkMasterUserId" value="${list.userId }" />
					                        <span class="user">${comment.userName }：</span>${comment.commentContent }
					                    </p>
					                </div>
					                <div class="info clearfix">
					                    <span class="time">${comment.commentTime }</span>		<fmt:formatDate value="${comment.commentTime }" pattern="yyyy年MM月dd日   HH:mm:ss"/>
					                    <a class="praise" href="javascript:;">赞</a>
					                </div>
					                <div class="praises-total" total="3" style="display: block;">4个人觉得很赞</div>
					                <div style="padding-left:20px;height:30px;line-height:30px;" class="glyphicon glyphicon-comment">
					                	<a href="javascript:;" onclick="viewComment('${list.talkId }','${list.userId }','0',this);" >&nbsp;查看评论</a>&nbsp;&nbsp;
					                	<a href="javascript:;" onclick="closeComment();">收起评论</a>
					                </div>
					                <!-- 遍历回复 -->
					                <div class="comment-list">
					                    
					                </div>
					                <div class="text-box">
					                    <textarea class="comment" autocomplete="off">评论…</textarea>
					                    <button class="btn ">回 复</button>
					                    <span class="word"><span class="length">0</span>/140</span>
					                </div>
					            </div>
					        </div> --%>
			        	</c:forEach>	
						</ul>	 	
					</c:if>

					<c:if test="${empty diaryCommentList }">
						<div class='msgBox'>
							还没有人发表过评论哦
						</div>
					</c:if>
					
					
				</div>
			      
			      
			    </div>
			</div>
			</c:if>
			<!-- <div id="diaryCommentList" class="col-lg-12" >
				kek
			</div> -->
		</div>
		
	
	
	
	
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
			//加载日志背景
			var path=$("#hiddenPath").val();
			console.log(path);
			var bgimg=$("#hiddenDiaryBg").val();
			console.log(bgimg);
			if(bgimg=='1'){
				$("#showDiaryContent").attr("style","background:url("+path+"/img/diarybg/yellow.jpg);");
				$("#textarea2").attr("style","background:url("+path+"/img/diarybg/yellow.jpg);");
			}else if(bgimg=='2'){
				$("#showDiaryContent").attr("style","background:url("+path+"/img/diarybg/paper.jpg);");
				$("#textarea2").attr("style","background:url("+path+"/img/diarybg/paper.jpg);");
			}else if(bgimg=='3'){
				$("#showDiaryContent").attr("style","background:url("+path+"/img/diarybg/green.jpg);");
				$("#textarea2").attr("style","background:url("+path+"/img/diarybg/green.jpg);");
			}else if(bgimg=='4'){
				$("#showDiaryContent").attr("style","background:url("+path+"/img/diarybg/darkgrey.jpg);");
				$("#textarea2").attr("style","background:url("+path+"/img/diarybg/darkgrey.jpg);");
			}else if(bgimg=='5'){
				$("#showDiaryContent").attr("style","background:url("+path+"/img/diarybg/brown.jpg);");
				$("#textarea2").attr("style","background:url("+path+"/img/diarybg/borwn.jpg);height: 900px;");
			}else if(bgimg=='6'){
				$("#showDiaryContent").attr("style","background:url("+path+"/img/diarybg/buwen.jpg);");
				$("#textarea2").attr("style","background:url("+path+"/img/diarybg/buwen.jpg);height: 900px;");
			}else if(bgimg=='7'){
				$("#showDiaryContent").attr("style","background:url("+path+"/img/diarybg/white.jpg);");
				$("#textarea2").attr("style","background:url("+path+"/img/diarybg/white.jpg);height: 900px;");
			}else if(bgimg=='8'){
				$("#showDiaryContent").attr("style","background:url("+path+"/img/diarybg/book.jpg);");
				$("#textarea2").attr("style","background:url("+path+"/img/diarybg/book.jpg);height: 900px;");
			}
			
			//加载富文本编辑器
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
		
		//点击小图片，显示表情
		$(".bq").click(function(e){
			$(".face").slideDown();//慢慢向下展开
			e.stopPropagation();   //阻止冒泡事件
		});
	
		//在桌面任意地方点击，他是关闭
		$(document).click(function(){
			$(".face").slideUp();//慢慢向上收
		});
	
		//点击小图标时，添加功能
		$(".face ul li").click(function(){
			var simg=$(this).find("img").clone();
			$(".commentMessage").append(simg);
		});
	
		//取消修改日志
		function cancleEdit(diaryContentId){
			var path=$("#hiddenPath").val();
			window.location.href=path+"/diary/queryDiaryByDiaryContentId.action?diaryContentId="+diaryContentId;
			/* $.post(
					path+"/diary/queryDiaryByDiaryContentId.action", 
					{ diaryContentId: diaryContentId } 
			); */
		}	
		
		function sendDiaryComment(){
			//var userId=$("#hidden_userId").val();
			var commentInfo=$("#commentTextArea").html();
			var masterUserId=$("#hiddenDiaryUserId").val();
			var typeId=$("#hiddenDiaryContentId").val();
			var type=1;
			var path=$("#hiddenPath").val();
			//alert(userId+":"+talkTextArea);
			if(commentInfo == ""){
				alert("不能发表内容为空的评论");
				$('.commentMessage').focus();//自动获取焦点
				return ; 
			}else{
				//alert("内容有效");
				//return ;
				$.ajax({
		              url:path+"/comment/addComment.action",   
		              type: "POST",
		              data:{commentInfo:commentInfo,masterUserId:masterUserId,typeId:typeId,type:type}, 
		              cache: false,
		              dataType:"json",
		              success: function(data) {
		              	if(data == '1'){
	              			alert("发表成功");
	              			window.location.href=path+"/diary/queryDiaryByDiaryContentId.action?diaryContentId="+typeId;
	              			
	              		}else if(data== "-1"){
	    	      			alert("session失效，请重新登录!");
	    	      		}else if(data== "0"){
	    	      			alert("评论失败，获取参数为空!");
	    	      		}
		              }
		         });
			}
		}
	</script>
	
</body>
</html>