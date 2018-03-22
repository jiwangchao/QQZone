<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>QQ登录页面</title>
	<c:set var="ctx" value="${pageContext.request.contextPath}"/>
	
	<link rel="stylesheet" type="text/css" href="${ctx}/css/bootstrap.css"/>
	<link rel="stylesheet" href="${ctx}/css/login.css" />
	
	<script type="text/javascript" src="${ctx}/js/jquery-1.11.3.js"></script>
	<script type="text/javascript" src="${ctx}/js/bootstrap.min.js"></script>
</head>
<body>
		<!-- 账号密码登录  -->
		<div class="login-box" id="inputlog" align="center">
			<h3>账号密码登录</h3>
			<h4>推荐使用<a href="javascript:inputlogtype()">快速安全登录</a>，防止盗号</h4>
			<c:if test="${empty loginError }">
			<div id="error">
				<div id="error-body" style="display: none;">
					<span id="error-icon" class="glyphicon glyphicon-info-sign"></span>
					<span id="error-content"></span>
				</div>
			</div>
			</c:if>
			<c:if test="${not empty loginError }">
				<div id="error">
					<div id="error-body">
						<span id="error-icon" class="glyphicon glyphicon-info-sign"></span>
						<span id="error-content">${loginError }</span>
					</div>
				</div>
			</c:if>
			<!-- log/login.action -->
			<form action="${pageContext.request.contextPath}/log/login.action" method="post" name="form1">
				
				<div id="nameArea">
					<input type="text" name="userAccount" id="logname" class="form-control"  placeholder="请输入QQ号码"/>
				</div>
				<div id="pwdArea">
					<input type="password" name="password" id="logpwd" class="form-control" placeholder="密码"/>
				</div>
				<div id="subArea">
					<input type="submit" name="submit" class="form-control btn btn-success" value="登录"/>
				</div>
				<div class="bottomArea">
					<a href="#">忘记密码</a>
					<span class="">|</span>
					<a href="${pageContext.request.contextPath}/log/register.action">注册账号</a>
				</div>
			</form>
		</div>
		<!-- 二维码扫描登录  -->
		<div class="login-box" id="scanlog" align="center" style="display: none;">
			<h3>快速安全登录</h3>
			<h4>请使用<a href="http://im.qq.com/mobileqq/#from=login" target="_blank">QQ手机版</a>扫描二维码</h4> 
			<div id="scanArea">
				<a id="scancode"><img src="${ctx}/img/TDcode.png" id="TDcode" class="img-thumbnail"/></a>
				<a class="rounded" id="scanphone"><img src="${ctx}/img/phone.png" /></a>
			</div>
			<div class="bottomArea">
				<a href="javascript:scanlogtype()">账号密码登录</a>
				<span class="">|</span>
				<a href="${pageContext.request.contextPath}/log/register.action">注册账号</a>
			</div>
		</div>
		<!-- QQlogo  -->
		<div id="QQlogo">
			<img src="${ctx}/img/qzonelogo.png" />
		</div>
		<!-- 底部logo  -->
		<div id="bottomCopyright">
			<p>Copyright @ 2016-12-17 wangchao.All Rights Reserved.</p>
			<p>Jiwangchao 版权所有 [2016-2017]</p>
		</div>
		<script>
			function inputlogtype(){
				$("#inputlog").hide();
				$("#scanlog").show();
			}
			function scanlogtype(){
				$("#inputlog").show();
				$("#scanlog").hide();
			}
//			function checklogname(){
//				var logname=$("#logname").val();
//				if(logname==""){
//					$("#error-body").show();
//					$("#error-content").html("您没有输入账号");					
//				}else{
//					$("#error-body").hide();
//					$("#error-content").html("");		
//				}
//			}
			
			function mycheck(){
				for(var i=0;i<document.form1.elements.length-1;i++){
					if(document.form1.elements[i].value==""){
						$("#error-body").show();
						$("#error-content").html("账号和密码为必填项");
						return false;
					}
				}
				return true;
			}
			$(document).ready(function(){
//				$("#logname").blur(checklogname);				
				$("input[name=submit]").click(mycheck);
				
			});
//			$(function(){
//				alert("简写");
//			});
		</script>
</body>
</html>