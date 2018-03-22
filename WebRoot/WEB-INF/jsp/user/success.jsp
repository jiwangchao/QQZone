<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<script>
	function setClock() {
		//debugger;
		var second = document.getElementById("second");
		var i = parseInt(second.innerText);
		i--;
		second.innerText = i;
		if (i > 0) {
			setTimeout("setClock()", 1000);
		}
		else
		{
			window.location.href='${pageContext.request.contextPath }/user/queryUsers.action';
		}
	}
	setTimeout("setClock()", 1000);
</script>

<title>操作提示页</title>
</head>
<body>
<h3>操作成功</h3>
	<label id="second">3</label>秒钟后，页面自动跳转，如未跳转，单击<a href="${pageContext.request.contextPath }/user/queryUsers.action">用户列表</a> 手动跳转
</body>
</html>