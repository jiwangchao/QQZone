<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
    <c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>我的留言板</title>

	<link rel="stylesheet" type="text/css" href="${ctx}/css/bootstrap.css"/>
	<link rel="stylesheet" type="text/css" href="${ctx}/css/personal_zone.css"/>
	<link rel="stylesheet" type="text/css" href="${ctx}/css/messageBoard.css"/>
	<link rel="stylesheet" type="text/css" href="${ctx}/css/personal_talk.css"/>
	<script type="text/javascript" src="${ctx}/js/jquery-1.11.3.js"></script>
	<script type="text/javascript" src="${ctx}/js/bootstrap.min.js"></script>
	<script type="text/javascript">
		function sendLeaveMessage(){
			var textArea=$("#leaveMessageTextArea").html();
			if(textArea == ""){
				alert("不能发表内容为空的留言");
				return ; 
			}else{
				var path=$("#hiddenPath").val();
				$.ajax({
		              url:path+"/messageBoard/sendLeaveMessage.action",   
		              type: "POST",
		              data:{textArea:textArea},
		              cache: false,
		              dataType:"json",
		              success: function(data) {
		              	if(data == '1'){
		              			//alert("发表成功");
		              			window.location.href=path+"/messageBoard/queryMymessageBoard.action";
		              		}else if(data == "-1"){
		              			alert("session失效，请重新登录!");
		              		}else if(data == "-2"){
		              			alert("接收留言信息参数失败");
		              		}else if(data =="0"){
		              			alert("发表留言失败！");
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
		<div id="messageBoardmain">
			<div id="messageBoardTitle">
				<span>留言板</span>
			</div>
			<div id="masterContent">
				<div id="masterTitle">
					<span><font color="white">主人寄语</font></span>
				</div>
				<div id="masterSay">
					<span>${sessionScope.user.masterHope }</span>
				</div>
			</div>
			<!-- 发表留言开始 -->
			<c:if test="${not empty logUser }">
			<div id="leaveMessage">
				<p>快来给这篇日志评论吧</p>
				<div class="leaveMessage" contentEditable='true' id="leaveMessageTextArea"></div>
				
				<div class="leaveMessageBtn">
					<img src="${ctx}/img/bba_thumb.gif" class='bq'/>
					<span class='submitL' onclick="sendLeaveMessage();">发表</span>
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
			</c:if>
			<!-- 发表留言结束 -->
			<div id="messageBoardBody">
				<%-- <div id="messageBoardTotal">
					<span><font color="white" >留言( ${count } )</font></span>
				</div>
				<div id="messageBoardList">
					<div id="userName">
						<span><font color="#D58512">用户姓名</font></span>
					</div>
					<div id="messageDetails">
						<span><font>留言内容</font></span>
					</div>
				</div> --%>
				<div class="panel panel-info">
				    <div class="panel-heading">留言板( ${messageCount } )</div>
				    <div class="panel-body">
				      <p>来自好友的留言</p>
				      
				      <!-- 遍历好友的评论 -->
				      <div id="list" style="display:block;">
						<c:if test="${not empty messageList }">
							<ul class="list-group">
							<c:forEach items="${messageList }" var="message">
							    <li class="list-group-item" style="height:150px;">
							    	<div>
								    	<div class="col-lg-2 "  >
											<a class="thumbnail "><img src="${ctx}/img/tx.jpg" class="img-circle"/></a>
										</div>
								    	<span><font color="#369">${message.userName }</font>:</span>
							    	</div>
							    	<div>
								    	<div>${message.messageContent }</div>
								    	<div><fmt:formatDate value="${message.messageTime }" pattern="yyyy年MM月dd日  EEEE HH:mm:ss"/></div>
							    	</div>
							    </li>
								
				        	</c:forEach>	
							</ul>	 	
						</c:if>
	
						<c:if test="${empty messageList }">
							<P>
								还没有人给你留过言噢，赶紧呼吁你的好友来留言吧。
							</p>
						</c:if>
						
					</div>
				    </div>
				</div>
				
				
				
				
				
			</div>
		</div>
		
	<div>
		<br/>	
		<br/>
	</div>
	
	
	
	
	
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
			
		});	
	
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
			$(".leaveMessage").append(simg);
		});
	
		//点击发表按扭，判断说说框是否为空，若为空则把焦点自动校准说说框
		$("span.submit").click(function(){
			var txt=$(".message").html();
			if(txt==""){
				$('.leaveMessage').focus();//自动获取焦点
				return;
			}
		});

	</script>
	
</body>
</html>