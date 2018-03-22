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
	<link rel="stylesheet" type="text/css" href="${ctx}/css/myFriends.css"/>
	<link rel="stylesheet" type="text/css" href="${ctx}/css/smartMenu.css"/>
	<script type="text/javascript" src="${ctx}/js/jquery-1.11.3.js"></script>
	<script type="text/javascript" src="${ctx}/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="${ctx}/js/myFriends.js"></script>
	<script type="text/javascript" src="${ctx}/js/jquery-smartMenu.js"></script>
</head>
<body>
		<%--隐藏域存放路径值，方便js获取 --%>
		<input type="hidden" value="${ctx}" id="hiddenPath" />
		<!-- 顶部一级菜单 -->
		<div id="nav">
			<div id="QQlogo"></div>
			<ul id="menu">
				<!--<span id="error-icon" class="glyphicon glyphicon-info-sign"></span>-->
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
				 <!-- 获取我的userid，以过滤搜索好友中我的搜索结果 -->
				<input type="hidden" value="${sessionScope.user.userId }" id="hiddenUserId" />
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

		<div id="friendbody">
			<div id="friendMenu">
				<ul>
					<li class="on"><a href="#">好友列表</a></li>
					<li><a href="#">寻找好友</a></li>
					<li><a href="#">好友请求</a></li>
				</ul>
			</div>
			<!-- 好友列表 -->
			<div class="friendContent col-lg-12"> 	
				<div class="col-lg-8" >		<!-- class="friendsTable " id="friendsTableLeft" -->
				
				 <!-- 显示好友信息 -->
					 <div class="col-lg-12" style="margin-top:10px;">
					 	<div class="panel panel-info">
						  <!-- Default panel contents -->
						  <div class="panel-heading">以下是为您查找出来的好友列表</div>
						  <div class="panel-body" style="color:darkgray;">
						    <p>
						    	以下好友是按最新访问您空间进行的排序，来而不往非礼也，你也快去好友空间留下你的足迹吧
						    </p>
						  </div>
						  <!-- Table ajax动态生成遍历搜索的好友 -->
						  <table class="table" style="color:black;">
					 		<tr align="center" height="40px">
								<td>全部好友</td>
								<td>最近访问时间</td>
								<td>管理</td>			
							</tr>
							<c:if test="${not empty friends }">
							<c:forEach items="${friends }" var="friends">
								<tr align="center" height="70px">
									<td width="200px">
										<%-- <input type="hidden" name="friendId" value="${friends.friendId }" /> --%>
										<font>${friends.beiZhu }</font>
									</td>
									<td width="300px">
										<fmt:formatDate value="${friends.lastVisitTime }" pattern="yyyy年MM月dd日  EEEE HH:mm:ss"/>
									</td>
									<td width="200px" class="friendsManager">
										<div class="btn-group">
										  <c:if test="${friends.careStatus == 1 }">
										  	<button type="button" class="btn btn-danger" onclick="updateFriendRight('${friends.friendId }',0,'careStatus','${ctx}');">❤ 特别关心</button>
										  </c:if>
										  <c:if test="${friends.careStatus == 0 }">
										  	<button type="button" class="btn btn-danger" onclick="updateFriendRight('${friends.friendId }',1,'careStatus','${ctx}');">取消特别关心</button>
										  </c:if>
										  <button type="button" class="btn btn-danger dropdown-toggle" style="height:34px;" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
										    <span class="caret"></span>
										    <span class="sr-only">Toggle Dropdown</span>
										  </button>
										  <ul class="dropdown-menu">
									    	<c:if test="${friends.allowVisited == 0 }">
												<li><a href="javascript:;" onclick="updateFriendRight('${friends.friendId }',1,'allowVisited','${ctx}');">禁止访问</a><li>
											</c:if>
											<c:if test="${friends.allowVisited == 1 }">
												<li><a href="javascript:;" onclick="updateFriendRight('${friends.friendId }',0,'allowVisited','${ctx}');">允许访问</a><li>
											</c:if>
									   	 	<li role="separator" class="divider"></li>
											<c:if test="${friends.hideDynamic == 1 }">
												<li><a href="javascript:;" onclick="updateFriendRight('${friends.friendId }',0,'hideDynamic','${ctx}');">隐藏动态</a><li>
											</c:if>
											<c:if test="${friends.hideDynamic == 0 }">
												<li><a href="javascript:;" onclick="updateFriendRight('${friends.friendId }',1,'hideDynamic','${ctx}');">显示动态</a><li>
											</c:if>
										  </ul>
										</div>
									</td>
								</tr>
							</c:forEach>
							</c:if>
							<c:if test="${empty friends }">
								<tr>
									<td colspan="3">您还未拥有好友，快去添加几个好友吧</td>
								</tr>
							</c:if>
						  </table>
						</div>
					 </div>
				
				</div>
				<div class="col-lg-4" >		<!-- class="friendsTable" id="friendsTableRight" -->
					<table id="friendsGroup" class="on">
						<tr align="center">
							<td height="40px">好友分组</td>
						</tr>
						<!-- <tr align="center">
							<td height="40px"><input type="text" placeholder=" 搜索QQ好友" name="beiZhu" style="color:darkgray;border-radius: 5px;" /></td> class="input-medium search-query"
						</tr> -->
						<!-- 循环分组id和分组中的好友 -->
						<c:if test="${not empty groupList && not empty friends }">
							<c:forEach items="${groupList }" var="gList">
								<tr align="center" class="friendsGroup">	
									<td>
										<button class="btn btn-info RightKeyOfGroups" style="width: 270px;" type="button" data-toggle="collapse" data-target="#collapseExample${gList.gId }" aria-expanded="false" aria-controls="collapseExample">
										  ${gList.gName }
										</button>
										<input type="hidden" value="${gList.gId }" />
										<div class="collapse groupFriends" id="collapseExample${gList.gId }">
											<ul class="RightKeyOfFriends">
										  	<c:forEach items="${friends }" var="friends">
											   	<c:if test="${friends.gNo eq gList.gNo }">
													<li>
														<button class="btn btn-default" style="width: 260px;" type="button">${friends.beiZhu }</button>
														<input type="hidden" value="${friends.friendId }" />
													</li>
											   	</c:if>
										  	</c:forEach>
											</ul>
										</div>
										
									
									</td>
								</tr>
							</c:forEach>
						</c:if>
					</table>
				</div>	
			</div>
			<!-- 寻找好友 -->
			<div class="friendContent" style="display:none;margin-top:10px;">
				<%--显示搜索好友列表 --%>
				<div class="col-lg-8">
					<div class="col-lg-6">
					    <div class="input-group">
					      <input type="text" class="form-control" placeholder="QQ昵称" id="QQnickname">
					      <span class="input-group-btn">
					        <button class="btn btn-default" type="button" onclick="findFriend('ByName','${ctx}');">查找</button>
					      </span>
					    </div>
					 </div>
					 <div class="col-lg-6">
					    <div class="input-group">
					      <input type="text" class="form-control" placeholder="QQ账号" id="QQaccount">
					      <span class="input-group-btn">
					        <button class="btn btn-default" type="button" onclick="findFriend('ByAccount','${ctx}');" onblur="checkfindFriendByAccount();">查找</button>
					      </span>
					    </div>
					 </div>
					 <!-- 显示好友信息 -->
					 <div class="col-lg-12" style="margin-top:10px;">
					 	<div class="panel panel-info">
						  <!-- Default panel contents -->
						  <div class="panel-heading">以下是为您查找出来的好友列表</div>
						  <div class="panel-body" style="color:darkgray;">
						    <p>突然有多年未见的同学加你好友有如下可能：①TA要结婚了；②TA要做微商了；③TA家孩子参赛要投票了;④TA需要点赞了。
						    	添加好友需谨慎啊...
						    </p>
						  </div>
						  <!-- Table ajax动态生成遍历搜索的好友 -->
						  <table class="table" style="color:black;" id="searchFriendResult">
						  </table>
						</div>
					 </div>
				 </div>
				 <%-- 显示单个好友详细信息 --%>
				 <div class="col-lg-4">
					<button class="btn btn-info col-lg-12" type="button" data-toggle="collapse" data-target=".viewfriendDetails" 
							aria-expanded="false" aria-controls="collapseExample">
							好友详细信息
					</button>
					<div class="col-lg-12 collapse.in viewfriendDetails" id="viewfriendDetails">
					</div>				 		
				 </div>
				 
				 <!-- 输入添加验证信息 .modal start -->
				 <div style="display:none;">
					<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#addFriendsModal" id="inputVerifyInfo">发送添加请求</button>
				 </div>
				 <div class="modal fade" tabindex="-1" role="dialog" aria-labelledby="gridSystemModalLabel" id="addFriendsModal">
					  <div class="modal-dialog" role="document">
					    <div class="modal-content" style="color:black;">
					      <div class="modal-header">
					        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					        <h4 class="modal-title" id="gridSystemModalLabel">发送添加请求：</h4>
					      </div>
					      <div class="modal-body">
					        <div class="row">
					          <div class="col-sm-12" >
					          	<input type="hidden" value="" id="hiddenFriendId" />
					          	<input type="text" name="beiZhu" id="beiZhu" class="form-control" placeholder="请设置好友备注"/> 
					           	<textarea rows="5" class="col-lg-12" name="verifyInfo" id="verifyInfo" class="form-control" placeholder="输入添加验证信息"></textarea>
					          </div>
					        </div>
					      </div>
					      <div class="modal-footer">
					        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					        <button type="button" class="btn btn-primary" onclick="sendVerifyInfo();" data-dismiss="modal">Send</button>
					      </div>
					    </div><!-- /.modal-content -->
					  </div><!-- /.modal-dialog -->
				</div>
				<!-- .modal end -->
			</div>
			<!-- 好友请求 -->
			<div class="friendContent" style="display:none;">
				<!-- 显示好友请求信息 -->
				 <div class="col-lg-8" style="margin-top:10px;">
				 	<div class="panel panel-info">
					  <!-- Default panel contents -->
					  <div class="panel-heading">好友添加请求</div>
					  <div class="panel-body" style="color:darkgray;">
					    <p>突然有多年未见的同学加你好友有如下可能：①TA要结婚了；②TA要做微商了；③TA家孩子参赛要投票了;④TA需要点赞了。
					    	添加好友需谨慎啊...
					    </p>
					  </div>
					  <!-- Table ajax动态生成遍历搜索的好友 -->
					  <table class="table" style="color:black;" id="searchFriendResultR">
							<c:if test="${ not empty friendsRequest }">
								<c:forEach items="${friendsRequest }" var="user" varStatus="status">
									<tr align="center">
										<td>${status.index+1 } </td>
										<td>${user.userAccount }</td>
										<td>${user.userName }</td>
										<td>
											<button type="button" class="btn btn-paimary" onclick="viewVerifyInfo('${user.userId }');">查看验证信息</button>
											<%-- <button type="button" class="btn btn-primary" onclick="updateFriendRequest('${user.userId }',0);">同意</button>
											<button type="button" class="btn btn-danger" onclick="updateFriendRequest('${user.userId }',1);">拒绝</button> --%>
											<button type="button" class="btn btn-primary" onclick="viewFriendDetails('${user.userId }');">查看个人信息</button>
											<!-- 查看好友添加验证信息 .modal start -->
											 <div style="display:none;">
												<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#prosessFriendVerifyInfo" id="friendVerifyInfo">处理好友添加请求</button>
											 </div>
											 <div class="modal fade" tabindex="-1" role="dialog" aria-labelledby="gridSystemModalLabel" id="prosessFriendVerifyInfo">
												  <div class="modal-dialog" role="document">
												    <div class="modal-content" style="color:black;">
												      <div class="modal-header">
												        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
												        <h4 class="modal-title" id="gridSystemModalLabel">处理好友添加请求：</h4>
												      </div>
												      <div class="modal-body">
												        <div class="row">
												          <div class="col-sm-12" >
												          	<input type="hidden" value="" id="hiddenFriendId" />
												          	<input type="text" name="beiZhu" id="friendBeiZhu" class="form-control" placeholder="请设置好友备注"/> 
												           	<textarea rows="5" class="col-lg-12" name="verifyInfo" id="quertVerifyInfo" class="form-control" ></textarea>
												          </div>
												        </div>
												      </div>
												      <div class="modal-footer">
												      	<button type="button" class="btn btn-primary" onclick="updateFriendRequest('${user.userId }',0);" data-dismiss="modal">同意</button>
														<button type="button" class="btn btn-danger" onclick="updateFriendRequest('${user.userId }',1);" data-dismiss="modal">拒绝</button>
														<button type="button" class="btn btn-default" data-dismiss="modal">暂不处理</button>
												      </div>
												    </div><!-- /.modal-content -->
												  </div><!-- /.modal-dialog -->
											</div>
											<!-- .modal end -->
										</td>
									</tr>	
								</c:forEach>
							</c:if>
							<c:if test="${ empty friendsRequest }">
								<tr align="center">
									<td colspan="4">尚未有发送给您的好友添加请求</td>
								</tr>
							</c:if>
					  </table>
					</div>
				 </div>
				 <%-- 显示单个好友详细信息 --%>
				 <div class="col-lg-4">
					<button class="btn btn-info col-lg-12" type="button" data-toggle="collapse" data-target=".viewfriendDetails" 
							aria-expanded="false" aria-controls="collapseExample">
							好友详细信息
					</button>
					<div class="col-lg-12 collapse.in viewfriendDetails" >
					</div>				 		
				 </div>
			</div>
	
		</div>
		<!-- 移动好友分组模态框 -->
		<div id="moveToGroupMark">
			<div style="display:none;">
				<!-- Button trigger modal -->
				<button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#moveToGroupModal" id="moveToGroupButton">
				</button>
			</div>
			<!-- 小模态框 -- 分组列表弹框显示-->
			<div class="modal fade bs-example-modal-sm" id="moveToGroupModal" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
			  <div class="modal-dialog modal-sm" role="document">
			    <div class="modal-content">
			      <div class="modal-header">
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			        <h4 class="modal-title" id="myModalLabel">请选择目标分组：</h4><input type="hidden" id="moveToGroupFriendId" value="" />
			      </div>
			      <div class="modal-body" align="center">
			      		 <ul style="padding:0px;">
			      		<c:if test="${not empty groupList }">
			      			<c:forEach items="${groupList }" var="gList" > 
			      				<li><button class="btn btn-info" style="width: 260px;" onclick="moveToGroupJsM('${gList.gNo }');">${gList.gName }</button></li> <!-- href="javascript:;" -->
			      			</c:forEach>
			      		</c:if>
			      		</ul>
			      </div>
			      <div class="modal-footer">
			      	<span>要移动的好友：</span>&nbsp;<span id="moveToGroupFriendName"></span>
			      </div>
			    </div>
			  </div>
			</div>
			
		</div>

		<!-- 添加分组、重命名分组 -->
		<div id="rightKeyEventMark">
			<div style="display:none;">
				<!-- Button trigger modal -->
				<button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#rightKeyEventModal" id="rightKeyEventButton">
				</button>
			</div>
			<!-- 小模态框 -- 分组列表弹框显示-->
			<form action="${ctx }/friend/rightOptionType.action" id="formGroupRight" method="post">
			<div class="modal fade bs-example-modal-sm" id="rightKeyEventModal" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
			  <div class="modal-dialog modal-sm" role="document">
			    <div class="modal-content">
			      <div class="modal-header">
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			        <h4 class="modal-title" id="messageLabel"></h4>
			      </div>
			      <div class="modal-body" align="center">
			      	
			      </div>
			      	<%--隐藏域存放右键操作类别 --%>
			      	<input type="hidden" id="hiddenId" value="" name="gfId" />
	      			<input type="hidden" value="" name="rightOptionType" id="rightOptionType"/>
			      <div class="modal-footer">
			      	<span id="optionId"></span>
			      	<input type="submit" class="btn btn-primary" id="submitGroupRight" value="确定"/>&nbsp;
			      	<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
			      </div>
			    </div>
			  </div>
			</div>
			</form>
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
	
	</script>
	<script>
	
		/* var chkSingle = $("th input"),
		chkGroup = $("td input");
		var funTrStyle = function() {
				chkGroup.each(function() {
					
				});
			},
			funTrGet = function() {
				
			};
		chkSingle.bind("click", function() {
			if ($(this).attr("checked")) {
				chkGroup.attr("checked", "checked");
			} else {
				chkGroup.attr("checked", "");
			}
			funTrStyle();
		});
		chkGroup.bind("click", funTrStyle);
		funTrStyle();  */
		
		//遍历groupList
		/* var dataList=eval(listToJson);
		for(var i in dataList) */
		
		$(".friendsGroup").bind("mousedown",(function(e){
			if(e.which == 3){
				//js右键触发事件
				// console.log("所选内容为:cellIndex: "+e.target.cellIndex+",InnerHtml:"+e.target.innerHTML+",nodeName:"+e.target.nodeName);
				
				/* var getIndex = function (element) {
				    return Array.prototype.slice.call(element.parentNode.children).indexOf(element);
				}; */
				
				var node1=e.target;
				var hidden= $(node1).next("input").val();
				// console.log("hiddenId:"+hidden);
				
				//自定义右键上下文
				var objUpdateBeiZhu = {
						text: "修改备注 ",
						func: function() {
							$("#hiddenId").val(hidden);
							$("#messageLabel").html("修改备注:<font color='#369'>"+e.target.innerHTML+"</font>");
							$("#rightOptionType").val(3);
							$("#rightKeyEventButton").click();
							var node=$("#messageLabel").parent().next();
							node.empty();
							node.append("	<input type='text' name='beiZhu' class='form-control' />	");
						}
					},
					objGotoZone = {
						text: "进入QQ空间",
						func: function() {
							var path=$("#hiddenPath").val();
							var friendId=hidden;
							window.location.href=path+"/talk/queryMyTalkList.action?friendId="+friendId;
						}
					},
					objDeleteFriend= {
							text: "删除好友",
							func: function() {
								var path=$("#hiddenPath").val();
								var friendId=hidden;
								$.ajax({
							        url:path+"/friend/deleteFriend.action",   
							        type: "POST",
							        data:{friendId:friendId},
							        cache: false,
							        dataType:"json",
							        success: function(data) {
							        	if(data == '1'){
							        			alert("删除成功");
							        			window.location.href=path+"/friend/myfriends.action";
							        		}else if(data=='0'){
							        			alert("删除好友失败！");
							        		}else if(data=='-1'){
							        			alert("session失效，请重新登录");
							        		}else if(data=="-2"){
							        			alert("操作失败，获取参数为空。");
							        		}
							        }
							   });
							}
					},
					objDeleteGroup = {
						text: "删除分组",
						func: function() {
							/* funTrGet().css("font-weight", "700"); */
						}
					},
					objAddGroup = {
						text: "添加分组",
						func: function() {
							$("#rightKeyEventButton").click();
							$("#messageLabel").html("创建分组");
							$("#rightOptionType").val(1);
							var node=$("#messageLabel").parent().next();
							node.empty();
							node.append("	<input type='text' name='gName' class='form-control' />	");
						}
					},
					objRenameGroup={
						text: "重命名分组",
						func: function() {
							$("#hiddenId").val(hidden);
							$("#messageLabel").html("重命名分组:<font color='#369'>"+e.target.innerHTML+"</font>");
							$("#rightOptionType").val(2);
							$("#rightKeyEventButton").click();
							var node=$("#messageLabel").parent().next();
							node.empty();
							node.append("	<input type='text' name='gName' class='form-control' />	");
						}
					},
					objMoveToGroup = {
						text: "移动到分组",
						func: function() {
							$("#moveToGroupFriendId").val(hidden);
							$("#moveToGroupButton").click();
							$("#moveToGroupFriendName").html(e.target.innerHTML);
						}
						/* data: [
							[
							 {
								text: "暂未开发1",
								func: function() {
									
								}
							 }, {
								text: "暂未开发2",
								func: function() {
									
								}
							 }
							],
							[{
								text: "我的好友",
								func: function() {
									console.log("把friendID移动到我的好友分组："+hidden);
								}
							}]
						] */
					};
				var groupsMenuData = [
					[objDeleteGroup,objAddGroup,objRenameGroup]
				];
				$(".RightKeyOfGroups").smartMenu(groupsMenuData, {
					name: "groups",
					beforeShow: function() {
						
					/* 	funTrStyle(); */
						//动态数据，及时清除
						$.smartMenu.remove();
						
					}
				});
				var friendsMenuData = [
		   			[objUpdateBeiZhu,objMoveToGroup,objDeleteFriend],[objGotoZone]
		   		];
		   		$(".RightKeyOfFriends").smartMenu(friendsMenuData, {
		   			name: "friends",
		   			beforeShow: function() {
		
		   				/* funTrStyle(); */
		   				//动态数据，及时清除
		   				$.smartMenu.remove();
		   				
		   			}
		   		});
				
			}
		}));
		
		
		</script>
</body>
</html>