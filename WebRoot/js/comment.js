window.onload = function () {

    var list = document.getElementById("list");
    var boxs = list.children;
    var timer;

    // 删除节点
    function removeNode (node) {
        node.parentNode.removeChild(node);
    }

    // 赞分享
    function pariseBox (box, el) {
        var pariseElement = box.getElementsByClassName("praises-total")[0];
        var oldTotla = parseInt(pariseElement.getAttribute("total"));
        var txt = el.innerHTML;
        var newTotal;
        if (txt == "赞") {
            newTotal = oldTotla + 1;
            pariseElement.innerHTML = (newTotal == 1) ? "我觉得很赞" : "我和" + oldTotla + "个人觉得很赞"
            el.innerHTML = "取消赞"
        } else {
            newTotal = oldTotla - 1;
            pariseElement.innerHTML = (newTotal == 0) ? "" : newTotal + "个人觉得很赞"
            el.innerHTML = "赞"
        }
        pariseElement.setAttribute("total", newTotal);
        pariseElement.style.display = (newTotal == 0) ? "none" : "block"
    }

    // 格式化时间
    function getTime () {
        var time = new Date();
        var y = time.getFullYear();
        var m = time.getMonth() + 1;
        var d = time.getDay();
        var h = time.getHours();
        var mi = time.getMinutes();
        m = m < 10 ? "0" + m : m
        d = d < 10 ? "0" + d : d
        h = h < 10 ? "0" + h : h
        mi = mi < 10 ? "0" + mi : mi
        return y + "-" + m + "-" + d + " " + h + ":" + mi;
    }

    // 发表评论-说说
    function replayBox (box) {
    	var path=$("#hiddenPath").val();
    	var masterUserId=box.getElementsByClassName("talkMasterUserId")[0].value;
    	var typeId=box.getElementsByClassName("hiddenTalkId")[0].value;
    	var type=0;
    	var textarea = box.getElementsByClassName('comment')[0];
    	console.log("masterUserId:"+masterUserId+",talkId:"+typeId);
        //var list = box.getElementsByClassName('comment-list')[0];
        /*var li = document.createElement('div');
        li.className = 'comment-box clearfix';
        li.setAttribute('user', 'self');
        li.innerHTML =
            '<img class="myhead" src="../img/comment/my.jpg" alt=""/>' +
            '<div class="comment-content">' +
            '<p class="comment-text"><span class="user">我：</span>' + textarea.value + '</p>' +
            '<p class="comment-time">' +
            getTime() +
            '<a href="javascript:;" class="comment-praise" total="0" my="0" style="">赞</a>' +
            '<a href="javascript:;" class="comment-operate">删除</a>' +
            '</p>' +
            '</div>'
        list.appendChild(li);*/
        
        var commentInfo=textarea.value;
        console.log(masterUserId);
        console.log(commentInfo);
        //return false;
        $.ajax({
            url:path+"/comment/addComment.action",   
            type: "POST",
            data:{masterUserId:masterUserId,commentInfo:commentInfo,typeId:typeId,type:type},
            cache: false,
            dataType:"json",
            success: function(data) {
            	if(data == '1'){
            		//alert("评论成功"); --说说
            		var node=box.getElementsByClassName("glyphicon")[0].firstChild;
            		viewComment(typeId,masterUserId,0,node);
	      		}else if(data== "-1"){
	      			alert("session失效，请重新登录!");
	      		}else if(data== "0"){
	      			alert("评论失败，获取参数为空!");
	      		}
            }
       });
        
        textarea.value = '';
        textarea.onblur();
    }

    // 赞回复
    function praiseReply (el) {
        var myPraise = parseInt(el.getAttribute("my"));
        var oldTotal = parseInt(el.getAttribute("total"));
        var newTotal;
        if (myPraise == 0) {
            newTotal = oldTotal + 1;
            el.setAttribute("total", newTotal);
            el.setAttribute("my", 1);
            el.innerHTML = newTotal + " 取消赞";
        }
        else {
            newTotal = oldTotal - 1;
            el.setAttribute("total", newTotal);
            el.setAttribute("my", 0);
            el.innerHTML = (newTotal == 0) ? "赞" : newTotal + " 赞";
        }
        el.style.display = (newTotal == 0) ? "" : "inline-block"
    }

    // 操作回复
    function operateReply (el) {
        var commentBox = el.parentNode.parentNode.parentNode;
        var box = commentBox.parentNode.parentNode.parentNode;
        var txt = el.innerHTML;
        var user = commentBox.getElementsByClassName('user')[0].innerHTML;
        var textarea = box.getElementsByClassName('comment')[0];
        if (txt == "回复") {
            textarea.onfocus();
            textarea.focus();
            textarea.value = "回复@" + user;
            textarea.onkeyup();
        } else {
            //removeNode(commentBox);  删除评论
        	var commentId=commentBox.getElementsByClassName('hiddenCommentId')[0].value;
        	var talkMasterUserId=box.getElementsByClassName("talkMasterUserId")[0].value;
        	var talkId=box.getElementsByClassName("hiddenTalkId")[0].value;
        	//console.log(commentId);
        	var path=$("#hiddenPath").val();
        	$.ajax({
                url:path+"/comment/deleteComment.action",   
                type: "POST",
                data:{commentId:commentId},
                cache: false,
                dataType:"json",
                success: function(data) {
                	if(data == '1'){
                		var node=box.getElementsByClassName("glyphicon")[0].firstChild;
                		//console.log(node);
                		viewComment(talkId,talkMasterUserId,0,node);
    	      		}else if(data== "-1"){
    	      			alert("session失效，请重新登录!");
    	      		}else if(data== "0"){
    	      			alert("删除失败，获取参数为空!");
    	      		}
                }
           });
        }
    }


    // 利用 className 实现每条分享 div 容器事件代理，点击对应
    for (var i = 0; i < boxs.length; i++) {

        // 点击
        boxs[i].onclick = function (e) {
            e = e || window.event;  //区分ff和IE
            var el = e.srcElement;	//IE下支持e.srcElement，ff支持e.target
            switch (el.className) {

                // 关闭分享
                case "close":
                    removeNode(el.parentNode);
                    break;

                // 赞分享
                case "praise":
                    pariseBox(el.parentNode.parentNode.parentNode, el);
                    break;

                // 回复按钮灰色的时候
                case "btn btn-off":
                    clearInterval(timer);
                    break;

                // 回复
                case "btn":
                    replayBox(el.parentNode.parentNode.parentNode);
                    break;

                // 赞回复
                case "comment-praise":
                    praiseReply(el);
                    break;

                // 操作回复
                case "comment-operate":
                    operateReply(el);
                    break;
            }
        }

        // 输入框
        var textarea = boxs[i].getElementsByClassName("comment")[0];

        // 输入框获取焦点事件
        textarea.onfocus = function () {
            this.parentNode.className = "text-box text-box-on";
            this.value = this.value == "评论…" ? "" : this.value
            this.onkeyup();
        }

        // 输入框失去焦点事件
        textarea.onblur = function () {
            var _this = this;
            if (_this.value == "") {
                timer = setTimeout(function () {
                    _this.parentNode.className = "text-box";
                    _this.value = "评论…";
                }, 300)

            }
        }

        // 键盘事件
        textarea.onkeyup = function (e) {
            var len = this.value.length;
            var p = this.parentNode;
            var btn = p.children[1];
            var word = p.children[2];
            if (len == 0 || len > 140) {
                btn.className = "btn btn-off"
            } else {
                btn.className = "btn";
            }
            word.innerHTML = len + "/140"
        }

    }
}

//自定义查看评论js
function viewComment(commentTypeId,masterId,commentType,obj){
	var path=$("#hiddenPath").val();
	
	$.ajax({
        url:path+"/comment/queryCommentBy.action",   
        type: "POST",
        data:{commentType:commentType,commentTypeId:commentTypeId,masterId:masterId},
        cache: false,
        dataType:"json",
        success: function(data) {
        	if(data != null){
        		var commentList=data;
        		//加载评论list,拼节点
        		var node=$(obj).parent().next(".comment-list");
        		node.empty();
        		for(var i=0;i<commentList.length;i++){
        			var comment=commentList[i];
        			console.log(comment.commentContent);
        			var userName="";
        			var option="";
        			var sessionUserName=$("#hiddenSessionUserName").val();
        			if(sessionUserName == comment.userName){
        				userName="我";
        				option="删除";
        			}else{
        				userName=comment.userName;
        				option="回复";
        			}	
        			node.append("<div class='comment-box clearfix' user='self'>" +
	        					"	<img class='myhead' src='../img/comment/my.jpg' alt=''/>" +
	        					"	<div class='comment-content'>" +
	        					"		<input type='hidden' class='hiddenCommentId' value='"+comment.commentId+"'  "+
	        					"		<p class='comment-text'><span class='user'>"+userName+"：</span>"+comment.commentContent+"</p>" +
	        					"		<p class='comment-time'>" + comment.commentTime +
	        					"			<a href='javascript:;' class='comment-praise' total='1' my='0' style='display: inline-block'>1 赞</a>" +
	        					"			<a href='javascript:;' class='comment-operate'>"+option+"</a>" +
	        					"		</p>" +
	        					"	</div>" +
	        					"</div>");
        			
        		}
        		node.show();
      		}else{
      			alert("查看评论失败,参数为空，或者session失效。");
      		}
        }
	});
	
}
function closeComment(){
	$(".comment-list").hide();
}