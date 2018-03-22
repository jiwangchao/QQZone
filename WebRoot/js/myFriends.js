/**
 * 
 */
$(document).ready(function(){
	$("#friendMenu ul li").click(function(){
		$(this).addClass("on");
		$(this).siblings("li").removeClass("on");
		$(".friendContent").hide();
		$(".friendContent").eq($(this).index()).show(100);
		
	});
	
});

function updateFriendRight(param1,param2,type,path){
	
	$.ajax({
        url:path+"/friend/updateFriendRight.action",   
        type: "POST",
        data:{friendId:param1,option:param2,type:type},
        cache: false,
        dataType:"json",
        success: function(data) {
        	if(data == '0'){
        			window.location.href=path+"/friend/myfriends.action";
        		}else if(data=='1'){
        			alert("数据库修改失败！");
        		}else if(data=='-1'){
        			alert("session失效，请重新登录");
        		}else{
        			alert("操作失败，获取参数为空。");
        		}
        }
   });
}
//判断依据QQ账号进行查找时输入框输入内容的合法性
function checkfindFriendByAccount(){
	
}
//添加好友
function addfriend(friendId){
	var path=$("#hiddenPath").val();
	
	$("#inputVerifyInfo").click();
	$("#hiddenFriendId").val(friendId);
	
}
function sendVerifyInfo(){
	
	var friendId=$("#hiddenFriendId").val();
	var verifyInfo=$("#verifyInfo").val();
	var beiZhu=$("#beiZhu").val();
	var path=$("#hiddenPath").val();
	$.ajax({
        url:path+"/friend/addFriend.action",   
        type: "POST",
        data:{friendId:friendId,verifyInfo:verifyInfo,beiZhu:beiZhu},
        cache: false,
        dataType:"json",
        success: function(data) {
        	if(data == 'success'){
        			alert("发送请求成功，请等待对方验证");
        			window.location.href=path+"/friend/myfriends.action";
        		}else if(data=="0"){
        			alert("待对方验证，请稍等");
        		}else if(data=="1"){
        			alert("对方和您已经成为好友，不可再次添加");
        		}else if(data=="4"){
        			alert("添加成功，恭喜你们成为好友");
        			window.location.href=path+"/friend/myfriends.action";
        		}else{
        			alert("添加失败！");
        		}
        }
   });
}
//查看好友添加验证信息
function viewVerifyInfo(friendId){
	var path=$("#hiddenPath").val();
	$.ajax({
        url:path+"/friend/viewFriendVerifyInfo.action",   
        type: "POST",
        data:{friendId:friendId},
        cache: false,
        dataType:"json",
        success: function(data) {
        	if(data != null){
        			$("#quertVerifyInfo").val(data.verifyInfo);
        			$("#friendVerifyInfo").click();
        		}else{
        			alert("查询失败，session失效或者查询验证信息为空");
        		}
        }
   });
	
}
function findFriend(type,path){
	var searchQQ="";
	//获取我的userid，以过滤搜索好友中我的搜索结果
	var myId=$("#hiddenUserId").val();
	if(type=='ByName'){
		searchQQ=$("#QQnickname").val();
	}else if(type='ByAccount'){
		searchQQ=$("#QQaccount").val();
	}
	//return false;
	$.ajax({
        url:path+"/friend/searchFriend.action",   
        type: "POST",
        data:{searchQQ:searchQQ,type:type},
        cache: false,
        dataType:"json",
        success: function(list) {
        	var node=$("#searchFriendResult");
        	node.empty();
        	node.append("<tr align='center'>"+
					"	<td>#</td>"+
					"	<td>QQ昵称</td>"+
					"	<td>QQ账号</td>"+
					"	<td>操作</td>"+
					"</tr>");
        	var num=1;
        	for(i in list){
        		var user=list[i];
        		if(user.userId== myId ){
        			continue;
        		}
        		node.append("<tr align='center'>"+
        					"	<td>"+num+"</td>"+
        					"	<td>"+user.userName+"</td>"+
        					"	<td>"+user.userAccount+"</td>"+
        					"	<td><button class='btn btn-primary' onclick='addfriend("+user.userId+");'>添加</button>"+
        					"		<button class='btn btn-primary' onclick='viewFriendDetails("+user.userId+");'>查看</button></td>"+
        					"</tr>");
        		num++;
        	}
        }
   });
}
//查看好友的详细信息
function viewFriendDetails(userId){
	var path=$("#hiddenPath").val();
	$.ajax({
        url:path+"/friend/viewFriendDetails.action",   
        type: "POST",
        data:{userId:userId},
        cache: false,
        dataType:"json",
        success: function(user) {
        	if(user == null){
        		details.empty();
        		details.append("没有找到该用户");
        	}else{
        		var details=$(".viewfriendDetails");
        		details.empty();
        		details.append("<ul class='list-group' style='color: black;margin-top:10px;'>"+
        							"<li class='list-group-item'>"+user.userAccount+"</li>"+
        							"<li class='list-group-item'>"+user.userName+"</li>"+
        							"<li class='list-group-item'>"+user.sex+"</li>"+
        							"<li class='list-group-item'>"+user.birthday+"</li>"+
        							"<li class='list-group-item'>"+user.personalSign+"</li>"+
        							"<li class='list-group-item'>"+user.bloodType+"</li>"+
        							"<li class='list-group-item'>"+user.currentAddress+"</li>"+
        							"<li class='list-group-item'>"+user.hometown+"</li>"+
        							"<li class='list-group-item'>"+user.emotion+"</li>"+
        							"<li class='list-group-item'>"+user.constellation+"</li>"+
        							"<li class='list-group-item'>"+user.prefessional+"</li>"+
        							"<li class='list-group-item'>"+user.company+"</li>"+
        							"<li class='list-group-item'>"+user.hobby+"</li>"+
        						"</ul>");
        	}
        }
   });
}
//处理好友请求0：同意,1：拒绝
function updateFriendRequest(friendId,type){
	var path=$("#hiddenPath").val();
	var beiZhu=$("#friendBeiZhu").val();
	$.ajax({
        url:path+"/friend/updateFriendRequest.action",   
        type: "POST",
        data:{friendId:friendId,type:type,beiZhu:beiZhu},
        cache: false,
        dataType:"json",
        success: function(data) {
        	if(data == '0'){
        			window.location.href=path+"/friend/myfriends.action";
        		}else if(data=="1"){
        			alert("对方拒绝添加你为好友");
        		}else if(data=="-1"){
        			alert("session失效，请重新登录");
        		}else if(data=="-1"){
        			alert("获取好友数据为空，操作失败");
        		}else{
        			alert("操作失败，其他未知错误。");
        		}
        }
   });
}
//移动好友分组
function moveToGroupJsM(gNo){
	var friendId=$("#moveToGroupFriendId").val();
	var path=$("#hiddenPath").val();
	$.ajax({
        url:path+"/friend/updateFriendInGroup.action",   
        type: "POST",
        data:{friendId:friendId,gNo:gNo},
        cache: false,
        dataType:"json",
        success: function(data) {
        	if(data == '0'){
        			alert("移动好友成功");
        			window.location.href=path+"/friend/myfriends.action";
        		}else if(data=='1'){
        			alert("移动好友失败");
        		}else if(data=='-2'){
        			alert("接收好友数据异常");
        		}else if(data=="-1"){
        			alert("session失效，请重新登录");
        		}else if(data=="-3"){
        			alert("你的好友已经在目标分组，请勿重复此操做 ！");
        		}else{
        			alert("操作失败，其他未知错误。");
        		}
        }
   });
}
