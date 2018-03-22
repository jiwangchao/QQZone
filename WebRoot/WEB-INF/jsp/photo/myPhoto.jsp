<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
    <c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>我的相册</title>

	<link rel="stylesheet" type="text/css" href="${ctx}/css/bootstrap.css"/>
	<link rel="stylesheet" type="text/css" href="${ctx}/css/personal_zone.css"/>
	<link rel="stylesheet" type="text/css" href="${ctx}/css/myPhoto.css"/>
	<script type="text/javascript" src="${ctx}/js/jquery-1.11.3.js"></script>
	<script type="text/javascript" src="${ctx}/js/bootstrap.min.js"></script>
	
	<script type="text/javascript" src="${ctx}/js/jwcFile.js"></script>
	
	<script type="text/javascript" src="${ctx }/js/myPhoto.js"></script>
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
		
		<div id="photoMain">
			<h3>上传精彩瞬间</h3>
			<!-- <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#addPhotoDir">创建相册</button> -->   <!-- onclick="addPhotoDir()" -->
			<!-- 添加相册 -->
			<div class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog" id="addPhotoDir" aria-labelledby="mySmallModalLabel" style="color:black;">
			  <div class="modal-dialog modal-sm" role="document">
			      <form action="${ctx }/photo/addPhotoDir.action" method="post">
				    <div class="modal-content">
			    	  <div class="modal-header">
				        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				        <h4 class="modal-title" id="myModalLabel">创建相册</h4>
				      </div>
				      <div class="modal-body">
				      	  <label >相册名称</label>	
				    	 <input type="text" name="photoDirName" class="form-control" />
				      </div>
				      <div class="modal-footer">
				        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
				        <input type="submit" class="btn btn-primary" value="添加" />
				      </div>
				      
				    </div>
			     </form>
			  </div>
			</div>
			
			<!-- 修改相册名字 -->
			<div class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog" id="updatePhotoDirName" aria-labelledby="mySmallModalLabel" style="color:black;">
			  <div class="modal-dialog modal-sm" role="document">
			      <form action="${ctx }/photo/updatePhotoDirName.action" method="post">
				    <div class="modal-content">
			    	  <div class="modal-header">
				        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				        <h4 class="modal-title" id="myModalLabel">修改相册名字</h4>
				      </div>
				      <div class="modal-body">
				      	  <label >相册名称</label>	
				      	  <input type="hidden" name="photoDirId" id="hiddenDirId"/>
				    	 <input type="text" name="photoDirName" id="photoDirName" class="form-control" />
				      </div>
				      <div class="modal-footer">
				        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
				        <input type="submit" class="btn btn-primary" value="修改" />
				      </div>
				      
				    </div>
			     </form>
			  </div>
			</div>
			
			<c:if test="${empty logUser }">
		    <div id="uploadBody" class="light" style="height:81px;">
		        <div id="uploadContent" class="show">
		            <div class="demo">
		                <form id="uploadForm" action="${ctx}/photo/uploadPhoto.action" method="post" enctype="multipart/form-data">
		                    <div class="upload_box col-lg-12">
		                        <div class="upload_main">
		                        	
		                            <div class="upload_choose">
		                            	<!-- 自定义上传按钮 -->
		                                <div id="uploadPhotoBtn">
		                                	<button class="btn btn-primary">选择照片</button>
		                                	<input id="fileImage" type="file" size="30" id="uploadPhotoInput" name="uploadFiles" multiple="">
		                                </div>
		                                
		                                <input type="submit" class="btn btn-primary" value="确认上传" />
		                                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#addPhotoDir">创建相册</button>
		                                
		                                	<!-- <span>上传到...</span> -->
		                                <div id="selectOption" class="col-lg-3">
			                                <select name="photoDirId" style="color:black;" class="form-control ">
			                                	<c:if test="${ not empty photoDirlist }">
			                                		<c:forEach items="${photoDirlist }" var="photoDir">
			                                			<option value="${photoDir.photoDirId }">${photoDir.photoDirName }</option>
			                                		</c:forEach>
			                                	</c:if>
			                                </select>
		                                </div>
		                                <!-- <span id="fileDragArea" class="upload_drag_area">或者将图片拖到此处</span> -->
		                            </div>
		                            
		                            <div id="preview" class="upload_preview"></div>
		                        </div>
		                        <div class="upload_submit">
		                           <!--  <button type="button" id="fileSubmit" class="upload_submit_btn">确认上传图片</button> -->
		                            
		                        </div>
		                        <div id="uploadInf" class="upload_inf"></div>
		                    </div>
		                </form>
		            </div>
		        </div>       
		    </div>
		    </c:if>
			<!-- 查看我的相册 -->
			<div id="Myphoto" style="color:black;">
				<c:if test="${ not empty photoDirlist }">
					<ul class="list-group" id="photoDirUl">
						<c:forEach items="${photoDirlist }" var="photoDir" >
							<li class="list-group-item" class="col-lg-3" >
								<a href="${ctx}/photo/queryMyPhotosByDir.action?dirId=${photoDir.photoDirId }&dirName=${ photoDir.photoDirName}" >   <%-- onclick="queryMyPhotoByDir(${photoDir.photoDirId });" --%>
									<div>
										<input type="hidden" value="${photoDir.photoDirId }" />
										<img alt="" src="${ctx}/img/loveMusic.png" width="160px" height="160px" >
										<div align="center" class="photoDirDiv"><span>${ photoDir.photoDirName}</span><br /></div>
										<span><fmt:formatDate value="${ photoDir.createTime}" pattern="yyyy年MM月dd日   HH:mm:ss"/></span>
									</div>
								</a>
									<c:if test="${empty logUser }">
									<div class="photoDirOption" >
									<!-- <div class="btn-group"> -->
										<button type="button" class="btn btn-default dropdown-toggle" style="height:34px;" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
										    <span class="caret"></span>
										    <span class="sr-only">Toggle Dropdown</span>
										</button>
										<ul class="dropdown-menu">
											<li><a href="javascript:;" onclick="updateDirName('${photoDir.photoDirId }','${ photoDir.photoDirName}');" data-toggle="modal" data-target="#updatePhotoDirName">修改相册名字</a></li>
											<li><a href="javascript:;" onclick="delDir('${photoDir.photoDirId }');">删除</a></li>
										</ul>
									<!-- </div> -->
									</div>
									</c:if>
							<li>
						</c:forEach>
					</ul>
				</c:if>
				<c:if test="${empty photoDirlist }">
					<div style="height:40px;line-height:40px;padding-left:20px;background-color:white;">
						<span>您还没有新建相册，快去创建一个吧 ^_^</span>
					</div>
				</c:if>
			</div>
			
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
		 
			//上传图片之前预览图片缩略图
			var params = {
			    fileInput: $("#fileImage").get(0),
			    dragDrop: $("#fileDragArea").get(0),
			    upButton: $("#fileSubmit").get(0),
			    url: $("#uploadForm").attr("action"),
			    filter: function(files) {
			        var arrFiles = [];
			        for (var i = 0, file; file = files[i]; i++) {
			            if (file.type.indexOf("image") == 0) {
			                if (file.size >= 1024000) {
			                    alert('您这张"'+ file.name +'"图片大小过大，应小于500k');    
			                } else {
			                    arrFiles.push(file);    
			                }            
			            } else {
			                alert('文件"' + file.name + '"不是图片。');    
			            }
			        }
			        return arrFiles;
			    },
			    onSelect: function(files) {
			        var html = '', i = 0;
			        $("#preview").html('<div class="upload_loading"></div>');
			        var funAppendImage = function() {
			            file = files[i];
			            if (file) {
			                var reader = new FileReader()
			                reader.onload = function(e) {
			                    html = html + '<div id="uploadList_'+ i +'" class="upload_append_list"><p>'+		/*<strong>' + file.name + '</strong>*/ 
			                        /* '<a href="javascript:" class="upload_delete" title="删除" data-index="'+ i +'">删除</a><br />' + */
			                        '<img id="uploadImage_' + i + '" src="' + e.target.result + '" class="upload_image" height="100px" width="100px" /></p>'+ 
			                        '<span id="uploadProgress_' + i + '" class="upload_progress"></span>' +
			                    '</div>';
			                    
			                    i++;
			                    funAppendImage();
			                }
			                reader.readAsDataURL(file);
			            } else {
			                $("#preview").html(html);
			                if (html) {
			                    //删除方法
			                    $(".upload_delete").click(function() {
			                        ZXXFILE.funDeleteFile(files[parseInt($(this).attr("data-index"))]);
			                        return false;    
			                    });
			                    //提交按钮显示
			                    $("#fileSubmit").show();    
			                } else {
			                    //提交按钮隐藏
			                    $("#fileSubmit").hide();    
			                }
			            }
			        };
			        funAppendImage();        
			    },
			    onDelete: function(file) {
			        $("#uploadList_" + file.index).fadeOut();
			    },
			    onDragOver: function() {
			        $(this).addClass("upload_drag_hover");
			    },
			    onDragLeave: function() {
			        $(this).removeClass("upload_drag_hover");
			    },
			    onProgress: function(file, loaded, total) {
			        var eleProgress = $("#uploadProgress_" + file.index), percent = (loaded / total * 100).toFixed(2) + '%';
			        eleProgress.show().html(percent);
			    },
			    onSuccess: function(file, response) {
			        $("#uploadInf").append("<p>上传成功，图片地址是：" + response + "</p>");
			    },
			    onFailure: function(file) {
			        $("#uploadInf").append("<p>图片" + file.name + "上传失败！</p>");    
			        $("#uploadImage_" + file.index).css("opacity", 0.2);
			    },
			    onComplete: function() {
			        //提交按钮隐藏
			        $("#fileSubmit").hide();
			        //file控件value置空
			        $("#fileImage").val("");
			        $("#uploadInf").append("<p>当前图片全部上传完毕，可继续添加上传。</p>");
			    }
			};
			ZXXFILE = $.extend(ZXXFILE, params);
			ZXXFILE.init();
		</script>
</body>
</html>