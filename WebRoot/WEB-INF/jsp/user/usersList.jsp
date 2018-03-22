<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath }" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>我的好友</title>
	<link rel="stylesheet" type="text/css" href="${ctx}/css/bootstrap.css"/>
	<link rel="stylesheet" type="text/css" href="${ctx}/css/personal_zone.css"/>
	<script type="text/javascript" src="${ctx}/js/jquery-1.11.3.js"></script>
	<script type="text/javascript" src="${ctx}/js/bootstrap.min.js"></script>
</head>
<body>

		<!-- 顶部一级菜单 -->
		<div id="nav">
			<div id="QQlogo"></div>
			<ul id="menu">
				<!--<span id="error-icon" class="glyphicon glyphicon-info-sign"></span>-->
				<li><a href="${ctx}/log/personalZone.action" class="glyphicon glyphicon glyphicon-star">&nbsp;个人中心</a></li>
				<li><a href="#" class="glyphicon glyphicon glyphicon glyphicon-home">&nbsp;我的主页</a></li>
				<li><a href="${ctx}/user/queryUsers.action" class="glyphicon glyphicon glyphicon-user">&nbsp;好友</a></li>
				<li><a href="#" class="glyphicon glyphicon glyphicon-asterisk">&nbsp;装扮</a></li>
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
				<li><a href="#">日志</a></li>
				<li><a href="#">相册</a></li>
				<li><a href="${ctx }/messageBoard/queryMymessageBoard.action">留言板</a></li>
				<li><a href="${ctx }/talk/queryMyTalkList.action">说说</a></li>
				<li><a href="#">个人档</a></li>
			</ul>
		</div>

		<div id="friendMenu">
			<ul>
				<li>好友列表</li>
				<li>寻找好友</li>
				<li>好友请求</li>
			</ul>
		</div>
		<!-- 好友列表 -->
		<div class="friendContent">
			<c:if test="${not empty userList }">
			<c:forEach items="${userList }" var="item">
				<div class="friendList">
					<span><font></font></span>
				</div>
			</c:forEach>
			</c:if>
			<c:if test="${empty userList }">
				<div>
					您还未拥有好友，快去添加几个好友吧
				</div>
			</c:if>
		</div>
		<!-- 寻找好友 -->
		<div class="friendContent">
			
		</div>
		<!-- 好友请求 -->
		<div class="friendContent">
			
		</div>




	<h3 align="center">用户列表${sessionScope.user.userName }${user.userAccount }</h3>
	<table width="800px" border="1" cellpadding="0" cellspacing="0" align="center">
		<tr align="center">
			<td>用户ID</td>
			<td>用户名</td>
			<td>性别</td>
			<td>年龄</td>
			<td>操作</td>
		</tr>
		<c:forEach items="${userList }" var="item">
		<tr align="center">
			<td>${item.userId}</td>
			<td>${item.userName}</td>
			<td>${item.sex}</td>
			<td>${item.age}</td>
			<td>
				<a href="${pageContext.request.contextPath }/user/editUser.action?userId=${item.userId}">修改</a>
				<a href="${pageContext.request.contextPath }/user/deleteUser.action?userId=${item.userId}">删除</a>
			</td>
		</tr>
		</c:forEach>
	</table> 




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
	
	</script>
</body>
</html>