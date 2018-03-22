
$(function(){
	$(".list-group-item").mouseover(function(){
		$(this).find(".photoDirOption").show();
	}).mouseout(function(){
		$(this).find(".photoDirOption").hide();				
	});
});
/**
 * 相册
 */
function addPhotoDir(){
	var path=$("#hiddenPath").val();
	$.ajax({
        url:path+"/photo/addPhotoDir.action",   
        type: "POST",
        data:{friendId:param1,option:param2,type:type},
        cache: false,
        dataType:"json",
        success: function(data) {
        	if(data == '0'){
        			window.location.href=path+"/photo/index.action";
        		}else if(data=='1'){
        			alert("数据库修改失败！");
        		}else if(data=='-1'){
        			alert("session失效，请重新登录");
        		}else{
        			alert("操作失败，其他未知错误。");
        		}
        }
   });
}
//删除相册
function delDir(dirId){
	var path=$("#hiddenPath").val();
	if(confirm("确定要删除该相册么？这将同时删除该相册下的所有照片，请慎思!")){
		
		$.ajax({
	        url:path+"/photo/delDir.action",   
	        type: "POST",
	        data:{dirId:dirId},
	        cache: false,
	        dataType:"json",
	        success: function(data) {
	        	if(data == 'success'){
	        			window.location.href=path+"/photo/index.action";
	        		}else if(data=='fail'){
	        			alert("数据库修改失败！");
	        		}else if(data=='-1'){
	        			alert("session失效，请重新登录");
	        		}else{
	        			alert("操作失败，其他未知错误。");
	        		}
	        }
	   });
	}
}
//修改相册名字
function updateDirName(dirId,dirName){
	$("#hiddenDirId").val(dirId);
	$("#photoDirName").val(dirName);
}
//批量删除照片
function multiDelPhoto(){
	var path=$("#hiddenPath").val();
	var checkBoxs=$(".photoCheckBox").find("input[type='checkbox']:checked");
	var photoIds="";
	var i=1;
	checkBoxs.each(function(){
		var dirId=$(this).next().val();
		if(i==checkBoxs.length){
			photoIds=photoIds+dirId+"";
		}else{
			photoIds=photoIds+dirId+",";
		}
		i=i+1;
	});
	console.log(photoIds);
	$.ajax({
        url:path+"/photo/multiDelPhoto.action",   
        type: "POST",
        data:{photoIds:photoIds},
        cache: false,
        dataType:"json",
        success: function(data) {
        	if(data >= '0'){
        			window.location.href=path+"/photo/index.action";
        		}else if(data=='0'){
        			alert("数据库修改失败！");
        		}else if(data=='-1'){
        			alert("session失效，请重新登录");
        		}else{
        			alert("操作失败，其他未知错误。");
        		}
        }
   });
}
//批量移动照片
function moveToDir(){
	var path=$("#hiddenPath").val();
	var checkBoxs=$(".photoCheckBox").find("input[type='checkbox']:checked");
	var photoIds="";
	var i=1;
	//alert(checkBoxs.length);
	checkBoxs.each(function(){
		//console.log(i);
		var dirId=$(this).next().val();
		if(i==checkBoxs.length){
			photoIds=photoIds+dirId+"";
		}else{
			photoIds=photoIds+dirId+",";
		}
		i=i+1;
	});
	console.log(photoIds);
	return false;
	$.ajax({
        url:path+"/photo/moveToDir.action",   
        type: "POST",
        data:{photoIds:photoIds,dirId:dirId},
        cache: false,
        dataType:"json",
        success: function(data) {
        	if(data == '0'){
        			window.location.href=path+"/photo/index.action";
        		}else if(data=='1'){
        			alert("数据库修改失败！");
        		}else if(data=='-1'){
        			alert("session失效，请重新登录");
        		}else{
        			alert("操作失败，其他未知错误。");
        		}
        }
   });
}