<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>QQ注册页面</title>
	<c:set var="ctx" value="${pageContext.request.contextPath}"/>
	
	<link rel="stylesheet" type="text/css" href="${ctx}/css/bootstrap.css"/>
	<link rel="stylesheet" href="${ctx}/css/login.css" />
	
	<script type="text/javascript" src="${ctx}/js/jquery-1.11.3.js"></script>
	<script type="text/javascript" src="${ctx}/js/bootstrap.min.js"></script>
	<!-- 生日选择器 -->
	<script type="text/javascript" src="${ctx}/js/birthday.js"></script>
	<!-- 城市选择器 -->
	<link href="${ctx}/cityselect/cityLayout.css" type="text/css" rel="stylesheet">
	<script src="${ctx}/cityselect/cityselect.js"></script>
	
</head>
<body>
	<%--隐藏域存放路径值，方便js获取 --%>
	<input type="hidden" value="${ctx}" id="hiddenPath" />
	
		<!-- 账号密码登录  -->
		<div class="register-box" id="inputlog" align="center">
			<h3>QQ账号注册</h3>
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
			<form action="${ctx}/log/registerSubmit.action" method="post" name="form1">
				<table width="80%">
					<tr>
						<td align="right">
							<div class="QQinput">
								<span>账号</span>
							</div>
						</td>
						<td>
							<div class="QQinput">
								<input type="text" name="userAccount" id="logname" class="form-control"  placeholder="请输入QQ号码"/>
							</div>
						</td>
					</tr>
					<tr>
						<td align="right">
							<div class="QQinput">
								<span>密码</span>
							</div>
						</td>
						<td>
							<div class="QQinput">
								<input type="password" name="password" id="logpwd" class="form-control" placeholder="密码"/>
							</div>
						</td>
					</tr>
					<tr>
						<td align="right">
							<div class="QQinput">
								<span>昵称</span>
							</div>
						</td>
						<td>
							<div class="QQinput">
								<input type=text name="userName" id="" class="form-control" placeholder="昵称"/>
							</div>
						</td>
					</tr>
					<tr>
						<td align="right">
							<div class="QQinput">
								<span>性别</span>
							</div>
						</td>
						<td>
							<div class="QQinput" align="center">
								<input type="radio" name="sex" value="男" /><span>男</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<input type="radio" name="sex" value="女" /><span>女</span>
							</div>
						</td>
					</tr>
					<tr>
						<td align="right">
							<div class="QQinput">
								<span>生日</span>
							</div>
						</td>
						<td>
							<div class="QQinput" align="center">
								<select id="sel_year" name="birthdayY" rel="1994"></select>年
						        <select id="sel_month"name="birthdayM" rel="3"></select>月
						        <select id="sel_day"name="birthdayD" rel="1"></select>日
							</div>
						</td>
					</tr>
					<tr>
						<td align="right">
							<div class="QQinput">
								<span>所在地</span>
							</div>
						</td>
						<td>
							<div class="QQinput" align="center">
								<input name="currentAddress" id="sel1"  type="text"  class="city_input form-control" readonly="readonly">
							</div>
						</td>
					</tr>
					<tr>
						<td align="right">
							<div class="QQinput">
								<span>家乡</span>
							</div>
						</td>
						<td>
							<div class="QQinput" align="center">
								<input name="hometown" id="sel2"  type="text" value="山西省-晋城市-阳城县" class="city_input form-control" readonly="readonly">
							</div>
						</td>
					</tr>
				</table>
				
				<div id="subArea">
					<input type="submit" name="submit" class="form-control btn btn-success" value="注册"/>
				</div>
				<div class="bottomArea">
					<a href="${ctx}/log/loginQQ.action">返回登录</a>
				</div>
			</form>
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
			
			function mycheck(){
				for(var i=0;i<document.form1.elements.length-1;i++){
					if(document.form1.elements[i].value==""){
						$("#error-body").show();
						$("#error-content").html("所有注册项均为必填项");
						/* node=document.form1.elements[i];
						$(node).onfocus(); */
						return false;
					}
					console.log(document.form1.elements[i].value+"\n");
				}
				
				return true;
				//return true;
			}
			$(document).ready(function(){
				$("input[name=submit]").click(mycheck);
				//生日选择器
				$.ms_DatePicker({
		            YearSelector: ".sel_year",
		            MonthSelector: ".sel_month",
		            DaySelector: ".sel_day"
			    });
				$.ms_DatePicker();
				//地区选择器
				init_city_select($("#sel1, #sel2"));
			});
		</script>
</body>
</html>