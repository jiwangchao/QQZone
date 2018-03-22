<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
    <c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>我的说说</title>

	<link rel="stylesheet" type="text/css" href="${ctx}/css/bootstrap.css"/>
	<link rel="stylesheet" type="text/css" href="${ctx}/css/personal_zone.css"/>
	<link rel="stylesheet" type="text/css" href="${ctx}/css/personal_talk.css"/>
	<script type="text/javascript" src="${ctx}/js/jquery-1.11.3.js"></script>
	<script type="text/javascript" src="${ctx}/js/bootstrap.min.js"></script>
	<%--评论回复css --%>
	<style type="text/css">
		/* body { font-size: 12px; line-height: 120%; text-align: center; color:#333; padding: 20px;} */
		a { color: #333; text-decoration: none;}
		a:hover { text-decoration: underline;}
		/* * { margin: 0; padding: 0; border: none;} */
		.clearfix:after { content:"."; display:block; height:0; clear:both; visibility:hidden}
		.clearfix { *height:1%;}
		#list { margin: 0 auto; text-align: left; width: 600px;background-color:white;padding-left:20px;}
		.box { border-top: 1px solid #eee; position: relative;  width: 540px; padding: 20px 0}
		.box:hover .close { display: block;}
		.close { display: none; top:0px; right: 0px; width: 28px; height: 28px; border: 1px solid #eee; position: absolute; background: #f2f4f7; line-height: 27px; text-align: center;}
		.close:hover { background: #c8d2e2; text-decoration: none;}
		.head { float: left; width: 60px; height: 60px; margin-right: 10px;}
		.content { float: left; width: 440px;}
		.main { margin-bottom: 10px;}
		.txt { margin-bottom: 10px;}
		.user { color: #369; }
		.pic { margin-right: 5px; width: 200px; border: 1px solid #eee;}
		.info { height: 20px; line-height: 19px; font-size: 12px; margin: 0 0 10px 0;}
		.info .time { color: #ccc; float: left; height: 20px; padding-left: 20px; background: url("${ctx}/img/comment/bg1.jpg") no-repeat left top;}
		.info .praise { color: #369; float: right; height: 20px; padding-left: 18px; background: url("${ctx}/img/comment/bg2.jpg") no-repeat left top;}
		.info .praise:hover { text-decoration: underline; background: url("${ctx}/img/comment/bg3.jpg") no-repeat left top;}
		.praises-total { margin: 0 0 10px 0; height: 30px; background: url("${ctx}/img/comment/praise.png") no-repeat 5px 5px rgb(247, 247, 247); padding: 5px 0 5px 25px; line-height: 19px;}
		.comment-box { padding: 10px 0; border-top: 1px solid #eee;}
		.comment-box:hover { background: rgb(247, 247, 247);}
		.comment-box .myhead { float: left; width: 30px; height: 30px; margin-right: 10px;}
		.comment-box .comment-content { float: left; width: 400px; }
		.comment-box .comment-content .comment-time { color: #ccc; margin-top: 3px; line-height: 16px; position: relative;}
		.comment-box .comment-content .comment-praise { display: none; color: #369; padding-left: 17px; height: 20px; background: url("${ctx}/img/comment/praise.png") no-repeat;  position: absolute; bottom: 0px; right: 44px;}
		.comment-box .comment-content .comment-operate { display: none; color: #369; height: 20px;  position: absolute; bottom: 0px; right: 10px;}
		.comment-box .comment-content:hover .comment-praise { display: inline-block;}
		.comment-box .comment-content:hover .comment-operate { display: inline-block;}
		.text-box .comment { border: 1px solid #eee; display: block; height: 32px; width: 428px; padding: 5px; resize: none; color: #ccc}
		.text-box .btn { font-size: 12px; font-weight: bold; display: none; float: right; width: 65px; height: 25px; border: 1px solid #0C528D; color: #fff; background: #4679AC;}
		.text-box .btn-off { border: 1px solid #ccc; color: #ccc; background: #F7F7F7;}
		.text-box .word{ display: none; float: right; margin: 7px 10px 0 0; color: #666;}
		.text-box-on .comment{ height: 50px; color: #333;}
		.text-box-on .btn{ display: inline;}
		.text-box-on .word{ display: inline;}
	</style>
	<%--评论回复js --%>
	<script type="text/javascript" src="${ctx}/js/comment.js"></script>
	<script type="text/javascript">
		function sendTalk(){
			var userId=$("#hidden_userId").val();
			var talkTextArea=$("#talkTextArea").html();
			var path=$("#hiddenPath").val();
			//alert(userId+":"+talkTextArea);
			if(talkTextArea == ""){
				alert("不能发表内容为空的说说");
				return ; 
			}else{
				//alert("内容有效");
				$.ajax({
		              url:path+"/talk/addOneTalk.action",   
		              type: "POST",
		              data:{talkTextArea:talkTextArea,userId:userId},
		              cache: false,
		              dataType:"json",
		              success: function(data) {
		              	if(data == '0'){
		              			//alert("发表成功");
		              			window.location.href=path+"/talk/queryMyTalkList.action";
		              		}else{
		              			alert("发表失败！");
		              		}
		              }
		         });
			}
		}
	</script>
</head>
<body>
	<%--隐藏域存放路径值，方便js获取 --%>
		<input type="hidden" value="${ctx}" id="hiddenPath" />
		<%-- <input type="hidden" value="${sessionScope.user.userName }" id="hiddenSessionUserName" /> --%>
		<c:if test="${not empty sessionScope.logUser }">
			<input type="hidden" value="${sessionScope.logUser.userName }" id="hiddenSessionUserName" />
		</c:if>
		<c:if test="${empty sessionScope.logUser }">
			<input type="hidden" value="${sessionScope.user.userName }" id="hiddenSessionUserName" />
		</c:if>
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
				<img src="${ctx}/img/tx.jpg"/>
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

		<!-- 右侧统计说说数量 -->		
		<div id="talkTotal">
			<table>
				<tr>
					<td rowspan="2"><img src="${ctx}/img/tx.jpg" width="100px" height="100px" /></td>
					<td align="center">${sessionScope.user.userName }</td>
				</tr>
				<tr>
					<td align="center">&nbsp;<font color="orange" size="10px">${mytalkList.size() }</font>&nbsp;条说说</td>
				</tr>
			</table>
		</div>
		
		
		<!-- 空间主体 -->
		<div id="body_content">
			<c:if test="${empty logUser }">
			<div id="qq">
				<p>有什么新鲜事想告诉大家?</p>
				<div class="message" contentEditable='true' id="talkTextArea"></div>
			
				<div class="But">
					<img src="${ctx}/img/bba_thumb.gif" class='bq'/>
					<span class='submit' onclick="sendTalk();">发表</span>
					<!--face begin-->
					<div class="face">
						<ul>
							<li><img src="${ctx}/img/zz2_thumb.gif" title="[织]" ></li>
							<li><img src="${ctx}/img/horse2_thumb.gif" title="神马]"></li>
							<li><img src="${ctx}/img/fuyun_thumb.gif" title="[浮云]"></li>
							<li><img src="${ctx}/img/geili_thumb.gif" title="[给力]"></li>
							<li><img src="${ctx}/img/wg_thumb.gif" title="[围观]"></li>
							<li><img src="${ctx}/img/vw_thumb.gif" title="[威武]"></li>
							<li><img src="${ctx}/img/panda_thumb.gif" title="[熊猫]"></li>
							<li><img src="${ctx}/img/rabbit_thumb.gif" title="兔子]"></li>
							<li><img src="${ctx}/img/otm_thumb.gif" title="[奥特曼]"></li>
							<li><img src="${ctx}/img/j_thumb.gif" title="[囧]"></li>
							<li><img src="${ctx}/img/hufen_thumb.gif" title="[互粉]"></li>
							<li><img src="${ctx}/img/liwu_thumb.gif" title="[礼物]"></li>
							<li><img src="${ctx}/img/smilea_thumb.gif" title="呵呵]"></li>
							<li><img src="${ctx}/img/tootha_thumb.gif" title="嘻嘻]"></li>
							<li><img src="${ctx}/img/laugh.gif" title="[哈哈]"></li>
							<li><img src="${ctx}/img/tza_thumb.gif" title="[可爱]"></li>
							<li><img src="${ctx}/img/kl_thumb.gif" title="[可怜]"></li>
							<li><img src="${ctx}/img/kbsa_thumb.gif" title="[挖鼻屎]"></li>
							<li><img src="${ctx}/img/cj_thumb.gif" title="[吃惊]"></li>
							<li><img src="${ctx}/img/shamea_thumb.gif" title="[害羞]"></li>
							<li><img src="${ctx}/img/zy_thumb.gif" title="[挤眼]"></li>
							<li><img src="${ctx}/img/bz_thumb.gif" title="[闭嘴]"></li>
							<li><img src="${ctx}/img/bs2_thumb.gif" title="[鄙视]"></li>
							<li><img src="${ctx}/img/lovea_thumb.gif" title="[爱你]"></li>
							<li><img src="${ctx}/img/sada_thumb.gif" title="[泪]"></li>
							<li><img src="${ctx}/img/heia_thumb.gif" title="[偷笑]"></li>
							<li><img src="${ctx}/img/qq_thumb.gif" title="[亲亲]"></li>
							<li><img src="${ctx}/img/sb_thumb.gif" title="[生病]"></li>
							<li><img src="${ctx}/img/mb_thumb.gif" title="[太开心]"></li>
							<li><img src="${ctx}/img/ldln_thumb.gif" title="[懒得理你]"></li>
							<li><img src="${ctx}/img/yhh_thumb.gif" title="[右哼哼]"></li>
							<li><img src="${ctx}/img/zhh_thumb.gif" title="[左哼哼]"></li>
							<li><img src="${ctx}/img/x_thumb.gif" title="[嘘]"></li>
							<li><img src="${ctx}/img/cry.gif" title="[衰]"></li>
							<li><img src="${ctx}/img/wq_thumb.gif" title="[委屈]"></li>
							<li><img src="${ctx}/img/t_thumb.gif" title="[吐]"></li>
							<li><img src="${ctx}/img/k_thumb.gif" title="[打哈气]"></li>
							<li><img src="${ctx}/img/bba_thumb.gif" title="[抱抱]"></li>
							<li><img src="${ctx}/img/angrya_thumb.gif" title="[怒]"></li>
							<li><img src="${ctx}/img/yw_thumb.gif" title="[疑问]"></li>
							<li><img src="${ctx}/img/cza_thumb.gif" title="[馋嘴]"></li>
							<li><img src="${ctx}/img/88_thumb.gif" title="[拜拜]"></li>
							<li><img src="${ctx}/img/sk_thumb.gif" title="[思考]"></li>
							<li><img src="${ctx}/img/sweata_thumb.gif" title="[汗]"></li>
							<li><img src="${ctx}/img/sleepya_thumb.gif" title="[困]"></li>
							<li><img src="${ctx}/img/sleepa_thumb.gif" title="[睡觉]"></li>
							<li><img src="${ctx}/img/money_thumb.gif" title="[钱]"></li>
							<li><img src="${ctx}/img/sw_thumb.gif" title="[失望]"></li>
							<li><img src="${ctx}/img/cool_thumb.gif" title="[酷]"></li>
							<li><img src="${ctx}/img/hsa_thumb.gif" title="[花心]"></li>
							<li><img src="${ctx}/img/hatea_thumb.gif" title="[哼]"></li>
							<li><img src="${ctx}/img/gza_thumb.gif" title="[鼓掌]"></li>
							<li><img src="${ctx}/img/dizzya_thumb.gif" title="[晕]"></li>
							<li><img src="${ctx}/img/bs_thumb.gif" title="[悲伤]"></li>
							<li><img src="${ctx}/img/crazya_thumb.gif" title="[抓狂]"></li>
							<li><img src="${ctx}/img/h_thumb.gif" title="[黑线]"></li>
							<li><img src="${ctx}/img/yx_thumb.gif" title="[阴险]"></li>
							<li><img src="${ctx}/img/nm_thumb.gif" title="[怒骂]"></li>
							<li><img src="${ctx}/img/hearta_thumb.gif" title="[心]"></li>
							<li><img src="${ctx}/img/unheart.gif" title="[伤心]"></li>
							<li><img src="${ctx}/img/pig.gif" title="[猪头]"></li>
							<li><img src="${ctx}/img/ok_thumb.gif" title="[ok]"></li>
							<li><img src="${ctx}/img/ye_thumb.gif" title="[耶]"></li>
							<li><img src="${ctx}/img/good_thumb.gif" title="[good]"></li>
							<li><img src="${ctx}/img/no_thumb.gif" title="[不要]"></li>
							<li><img src="${ctx}/img/z2_thumb.gif" title="[赞]"></li>
							<li><img src="${ctx}/img/come_thumb.gif" title="[来]"></li>
							<li><img src="${ctx}/img/sad_thumb.gif" title="[弱]"></li>
							<li><img src="${ctx}/img/lazu_thumb.gif" title="[蜡烛]"></li>
							<li><img src="${ctx}/img/clock_thumb.gif" title="[钟]"></li>
							<li><img src="${ctx}/img/cake.gif" title="[蛋糕]"></li>
							<li><img src="${ctx}/img/m_thumb.gif" title="[话筒]"></li>
							<li><img src="${ctx}/img/weijin_thumb.gif" title="[围脖]"></li>
							<li><img src="${ctx}/img/lxhzhuanfa_thumb.gif" title="[转发]"></li>
							<li><img src="${ctx}/img/lxhluguo_thumb.gif" title="[路过这儿]"></li>
							<li><img src="${ctx}/img/bofubianlian_thumb.gif" title="[bofu变脸]"></li>
							<li><img src="${ctx}/img/gbzkun_thumb.gif" title="[gbz困]"></li>
							<li><img src="${ctx}/img/boboshengmenqi_thumb.gif" title="[生闷气]"></li>
							<li><img src="${ctx}/img/chn_buyaoya_thumb.gif" title="[不要啊]"></li>
							<li><img src="${ctx}/img/daxiongleibenxiong_thumb.gif" title="[dx泪奔]"></li>
							<li><img src="${ctx}/img/cat_yunqizhong_thumb.gif" title="[运气中]"></li>
							<li><img src="${ctx}/img/youqian_thumb.gif" title="[有钱]"></li>
							<li><img src="${ctx}/img/cf_thumb.gif" title="[冲锋]"></li>
							<li><img src="${ctx}/img/camera_thumb.gif" title="[照相机]"></li>	
						</ul>
					</div>
					<!--face end-->
				</div>
			</div>
			</c:if>
			<!--qq end-->
			
			<div id="list" style="display:block;">
				<c:if test="${not empty mytalkList }">
					<c:forEach items="${mytalkList }" var="list">
						<div class="box clearfix">
				            <img class="head" src="${ctx}/img/tx.jpg" alt=""/>
				            <div class="content">
				                <div class="main">
				                    <p class="txt">
				                    	<input type="hidden" class="hiddenTalkId" value="${list.talkId }" />
				                    	<input type="hidden" class="talkMasterUserId" value="${list.userId }" />
				                        <span class="user">${sessionScope.user.userName }：</span>${list.talkContent }
				                    </p>
				                    <c:if test="${not empty list.talkPic }">
				                   		<img class="pic" src="${ctx}/img/comment/${list.talkPic }" alt=""/>
				                    </c:if>
				                </div>
				                <div class="info clearfix">
				                    <span class="time"><fmt:formatDate value="${list.talkTime }" pattern="yyyy年MM月dd日   HH:mm:ss"/></span>
				                    <a class="praise" href="javascript:;">赞</a>
				                </div>
				                <div class="praises-total" total="4" style="display: block;">4个人觉得很赞</div>
				                <div style="padding-left:20px;height:30px;line-height:30px;" class="glyphicon glyphicon-comment">
				                	<a href="javascript:;" onclick="viewComment('${list.talkId }','${list.userId }','0',this);" >&nbsp;查看评论</a>&nbsp;&nbsp;
				                	<a href="javascript:;" onclick="closeComment();">收起评论</a>
				                </div>
				                <div class="comment-list">
				                    
				                </div>
				                <div class="text-box">
				                    <textarea class="comment" autocomplete="off">评论…</textarea>
				                    <button class="btn ">回 复</button>
				                    <span class="word"><span class="length">0</span>/140</span>
				                </div>
				            </div>
				        </div>
		        	</c:forEach>	
				</c:if>
				<c:if test="${empty mytalkList }">
					<div class='msgBox'>
						您尚未发表任何说说，快去发表一条记录一下美好生活吧。
					</div>
				</c:if>
			</div>
			
			
			
			
			<!--msgCon begin-->
			<%-- <div id="talklist" align="center">
				<table align="center">
					<c:if test="${not empty mytalkList }">
						<c:forEach items="${mytalkList }" var="list">
							<tr height="30px">
								<td>
									<div class="msgCon">
										<div class='msgBox'>
											<dl>
												<dt>
													<img src='${ctx}/img/tx.jpg' width='50' height='50'/>
												</dt>
												<dd>
													${sessionScope.user.userName }
												</dd>
											</dl>
											<div class='msgTxt'>
												${list.userId }&nbsp;
												 &nbsp;<fmt:formatDate value="${list.talkTime }" pattern="yyyy年MM月dd日   HH:mm:ss"/> 
												<div class='msgTxt'>
													<font size="3px">${list.talkContent }</font>&nbsp;
													${list.talkPic }
												</div>
											</div>
											
										</div>
									</div>
								</td>
							</tr>
						</c:forEach>	
					</c:if>
					
					<c:if test="${empty mytalkList }">
						<tr>
							<td >
								<div class="msgCon">
										<div class='msgBox'>
											您尚未发表任何说说，快去发表一条记录一下美好生活吧。
										</div>
									</div>
							</td>
						</tr>
					</c:if>
					
					
				</table>
			</div> --%>
			<!--msgCon end-->
			
		</div>
		
	<div>
		<br/>	
		<br/>
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
	
		//点击小图片，显示表情
		$(".bq").click(function(e){
			$(".face").slideDown();//慢慢向下展开
			e.stopPropagation();   //阻止冒泡事件
		});
	
		//在桌面任意地方点击，他是关闭
		$(document).click(function(){
			$(".face").slideUp();//慢慢向上收
		});
	
		//点击小图标时，添加功能
		$(".face ul li").click(function(){
			var simg=$(this).find("img").clone();
			$(".message").append(simg);
		});
	
		//点击发表按扭，判断说说框是否为空，若为空则把焦点自动校准说说框
		$("span.submit").click(function(){
			var txt=$(".message").html();
			if(txt==""){
				$('.message').focus();//自动获取焦点
				return;
			}
			//$(".msgCon").prepend("<div class='msgBox'><dl><dt><img src='${ctx}/img/tx.jpg' width='50' height='50'/></dt><dd>神马都是浮云</dd></dl><div class='msgTxt'>"+txt+"</div></div>");
		});

	</script>
	
</body>
</html>