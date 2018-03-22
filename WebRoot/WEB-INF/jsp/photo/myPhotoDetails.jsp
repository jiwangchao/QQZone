<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
	<!-- 图片轮播 -->
	<script src="${ctx }/layer/jquery.js?v=1.83.min"></script>
	<script src="${ctx }/layer/layer.min.js"></script>
	<link rel="stylesheet" type="text/css" href="${ctx}/layer/skin/layer.ext.css"/>
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
			<input type="hidden" value="${dirName }" id="hiddenDirName"/>
			<button class="btn btn-primary">${dirName }</button>
			
			<c:if test="${empty logUser }">
		    <div id="uploadBody" class="light">
		        <div id="uploadContent" class="show">
		            <div class="demo">
		                <form id="uploadForm" action="${ctx}/photo/uploadPhoto.action" method="post" enctype="multipart/form-data">
		                    <div class="upload_box">
		                        <div class="upload_main">
		                        	
		                            <div class="upload_choose">
		                            	<!-- 自定义上传按钮 -->
		                                <div id="uploadPhotoBtn">
		                                	<button class="btn btn-primary">选择照片</button>
		                                	<input id="fileImage" type="file" size="30" id="uploadPhotoInput" name="uploadFiles" multiple="">
		                                </div>
		                                <input type="hidden" name="photoDirId" value="${dirId }" />
		                                <input type="submit" class="btn btn-primary" value="确认上传"/>
		                                <input type="button" class="btn btn-primary" id="multiManager" value="批量管理" />
		                                <div id="multiManagerOptions" style="float:right;display:none;"> 
		                                	<input type="button" class="btn btn-primary" value="移动到相册" onclick="moveToDir();" />
		                                	<input type="button" class="btn btn-primary" value="删除" onclick="multiDelPhoto();"/>
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
		    <div class="box">
			<div  id="imgs" >  <!-- id="myPhotoDetails" -->
				<c:forEach items="${photoList }" var="photo">
					<div  class="col-lg-3">
						<a class="thumbnail " href="javascript:;">
							<img alt="" src="http://127.0.0.1:8080/photo/${sessionScope.user.userAccount }/${photo.photoUrl }" height="119px">
							<div  class="photoCheckBox" style="color:black;display:none;"><input type="checkbox" /><input type="hidden" value="${photo.photoId }"></div>
							<div align="center"><span>${photo.photoName }</span></div>
						</a>
					</div>
				</c:forEach>
			</div>
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
			
			$("#multiManager").click(function(){
				if($(".photoCheckBox").is(":hidden")){
					$(".photoCheckBox").show();
					$("#multiManagerOptions").show();
				}else{
					$(".photoCheckBox").hide();
					$("#multiManagerOptions").hide();
				}
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
		<!-- 轮播 -->
		<script type="text/javascript">
			;!function(){
				layer.use('extend/layer.ext.js', function(){
				    //初始加载即调用，所以需放在ext回调里
				    layer.ext = function(){
				        layer.photosPage({
				            html:'<div style="padding:20px;">这里传入自定义的html<p>我的相册</p><p id="change"></p></div>',
				            title: $("#hiddenDirName").val(),
				            id: 100, //相册id，可选
				            parent:'#imgs'
				        });
				    };
				});
				}();
		</script>
</body>
</html>