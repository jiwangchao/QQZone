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
	<%-- <link rel="stylesheet" type="text/css" href="${ctx}/css/messageBoard.css"/> --%>
	<link rel="stylesheet" type="text/css" href="${ctx}/css/personal_talk.css"/>
	
	<link rel="stylesheet" type="text/css" href="${ctx}/css/diary.css"/>
	
	<!-- 富文本编辑器 -->
	<link rel="stylesheet" type="text/css" href="${ctx}/css/wangEditor/wangEditor.css">
	<script type="text/javascript" src="${ctx}/js/jquery-1.11.3.js"></script>
	<script type="text/javascript" src="${ctx}/js/bootstrap.min.js"></script>
	
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
		
		<div id="diaryListmain" >
			<div id="diaryList" style="margin-left:15px;">
				<div class="panel panel-info">
					<div class="panel-heading">
						日志列表&nbsp;&nbsp;&nbsp;
						<c:if test="${empty logUser }">
							<a href="${ctx }/diary/editDiary.action" class="btn btn-primary" >写日志</a>
						</c:if>
					</div>
					<div class="panel-body" style="color:darkgray;">
					  <p>
					  	看一场花事，淋一场烟雨，写一生传奇
					  </p>
					  <p>
					  	流云过，烟雨遥，空中有微尘曼舞。一袖清雅薄衣，天光微浅，沉醉了几多轩墨，香痕诗里字，浅浅笔画魅影人。翩然而至柳岸堤边，一语诗成，紫陌自生烟，携几分飘逸，带几分幽怨。一书墨痕，半卷清词，荷盈曼妙，蝶舞翩跹。晶莹心语，细腻如丝，花谢花开花满天，烟雨声里数流年。
					  </p>
					</div>
					<table align="center"  width="100%" class="table table-condensed">
						<c:if test="${not empty list }">
						<c:forEach items="${list }" var="list">
							<tr class="active" >
								<td width="50%" height="40px"><span><a href="${ctx }/diary/queryDiaryByDiaryContentId.action?diaryContentId=${list.diaryContentId }">${list.diaryContentTitle }</a></span></td>
								<td width="30%" height="40px"><span><fmt:formatDate value="${list.diaryTime }" pattern="yyyy-MM-dd EEEE HH:mm:ss"/></span></td>
								<td width="20%" height="40px">
									<span>
										<c:if test="${empty logUser }">
											<a href="javascript:;" onclick="deleteDiary('${list.diaryContentId }')"  class="btn btn-danger">删除</a>&nbsp;&nbsp;
											<a href="${ctx }/diary/updateDiaryByDiaryContentId.action?diaryContentId=${list.diaryContentId }"  class="btn btn-primary">修改</a>
										</c:if>
									</span>
								</td>
							</tr>
						</c:forEach>
						</c:if>
						<c:if test="${empty list }">
							<tr class="active" >
								<td colspan="3">没有日志记录</td>
							</tr>
						</c:if>
					</table>
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
			
		});	
		
		function deleteDiary(diaryContentId){
			if(confirm("你确定要删除该日志么？")){
				var path=$("#hiddenPath").val();
				$.ajax({
		              url:path+"/diary/deleteDiaryByDiaryContentId.action",   
		              type: "POST",
		              data:{diaryContentId:diaryContentId},
		              cache: false,
		              dataType:"json",
		              success: function(data) {
		              	if(data == '1'){
		              			alert("删除成功");
		              			window.location.href=path+"/diary/index.action";
	              		}else if(data== "-1"){
	              			alert("session失效，请重新登录!");
	              		}else if(data== "0"){
	              			alert("删除失败，参数为空!");
	              		}
		              }
		         });
			}
		}
	
	</script>
	
</body>
</html>