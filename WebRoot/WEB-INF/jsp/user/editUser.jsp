<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改用户信息</title>
</head>
<body>
<form action="${pageContext.request.contextPath}/user/editUserSubmit.action" method="post">
	<input type="hidden" name="userId" value="${user.userId}">
	<table width="800px" align="center">
		<%-- <tr>
			<td>用户id</td>
			<td><input type="text" name="userId" value="${user.userId}"></td>
		</tr> --%>
		<tr>
			<td>姓名:</td>
			<td><input type="text" name="userName" value="${user.userName}"></td>
		</tr>
		<tr>
			<td>性别:</td>
			<td>
				<!-- <input type="radio" name="sex" value="男" checked="checked">男
				<input type="radio" name="sex" value="女">女 -->
				<input type="text" name="sex" value="${user.sex}" />
			</td>
		</tr>
		<tr>
			<td>年龄:</td>
			<td><input type="text" name="age" value="${user.age}"></td>
		</tr>
		<tr>
			<td colspan="2">
				<input type="submit" value="提交">&nbsp;&nbsp; 
				<input type="reset" value="重置">
			</td>
		</tr>
	</table>
</form>
</body>
</html>