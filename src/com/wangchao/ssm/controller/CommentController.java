package com.wangchao.ssm.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wangchao.ssm.pojo.Comment;
import com.wangchao.ssm.pojo.User;
import com.wangchao.ssm.service.CommentService;

/**
 * @author 吉王超
 * @date 2017年6月3日 下午7:40:52
 * @Description 评论回复controller
 */
@Controller
@RequestMapping("/comment")
public class CommentController {

	@Autowired
	private CommentService commentService;
	
	Logger log=LoggerFactory.getLogger(CommentController.class);
	
	/**
	 * 添加一条评论-说说
	 */
	@RequestMapping("/addComment")
	@ResponseBody
	public String addComment(HttpServletRequest request,Model model){
		//在自己的空间给别发评论的时候，当前登录用户是User
		User user=(User)request.getSession().getAttribute("user");
		if(user==null){
			log.info("获取用户信息失败，session失效!");
			return "-1";
		}
		//在别人空间给别人发评论的时候，当前登录用户是logUser
		User logUser=(User) request.getSession().getAttribute("logUser");
		if(logUser!=null){
			user=logUser;
		}
		String masterUserId=request.getParameter("masterUserId");
		String commentInfo=request.getParameter("commentInfo");
		String typeId=request.getParameter("typeId");
		String type=request.getParameter("type");
		if(masterUserId==null || commentInfo==null || typeId == null || type ==null
			||	masterUserId =="" || commentInfo =="" || typeId=="" || type=="" ){
			log.info("获取评论参数为空");
			return "0";
		}
		log.info("获取评论参数为：说说主人Id={},评论者Id={},评论类型表Id={},评论内容={}",masterUserId,user.getUserId(),typeId,commentInfo);
		Comment comment=new Comment();
		comment.setcUserId(user.getUserId());
		comment.setaUserId(Integer.parseInt(masterUserId));
		comment.setCommentContent(commentInfo);
		comment.setCommentTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
		//评论类型：0：说说，1：日志
		comment.setCommentType(Integer.parseInt(type));
		//评论类型的主键Id：说说：说说表主键Id，日志：日志表主键Id
		comment.setCommentTypeId(typeId);
		
		int row=commentService.addComment(comment);
		log.info("插入评论表影响行数：row="+row);
		if(row==1){
			return "1";
		}else{
			return "0";
		}
		
	}
	/**
	 * 查看指定说说或日志的评论
	 */
	@RequestMapping("/queryCommentBy")
	@ResponseBody
	public List<Comment> queryCommentBy(HttpServletRequest request,Model model){
		//在自己空间查看评论的时候，当前登录用户是user
		User user=(User)request.getSession().getAttribute("user");
		if(user==null){
			log.info("获取用户信息失败，session失效!");
			return null;
		}
		//在别人空间查看评论的时候，当前登录用户是logUser
		/*User logUser=(User) request.getSession().getAttribute("logUser");
		if(logUser!=null){
			user=logUser;
		}*/
		//commentType,commentTypeId,masterId
		String commentType=request.getParameter("commentType");
		String commentTypeId=request.getParameter("commentTypeId");
		String masterId=request.getParameter("masterId");
		if(commentType==null || commentTypeId==null || masterId == null 
				||	commentType =="" || commentTypeId =="" || masterId=="" ){
			log.info("获取参数为空");
			return null;
		}
		log.info("获取评论参数为：评论类型={},当前登录用户={},评论类型对应表Id={},被评论用户Id={}",commentType,user.getUserId(),commentTypeId,masterId);
		
		Comment comment=new Comment();
		comment.setCommentType(Integer.parseInt(commentType));
		comment.setCommentTypeId(commentTypeId);
		comment.setaUserId(Integer.parseInt(masterId));
		
		List<Comment> commentList=commentService.queryCommentList(comment);
		if(commentList!=null){
			return commentList;
		}else{
			log.info("未知错误");
			return null;
		}
		
		
	}
	/**
	 * 删除我的评论或回复
	 */
	@RequestMapping("/deleteComment")
	@ResponseBody
	public String deleteComment(HttpServletRequest request,Model model){
		User user=(User)request.getSession().getAttribute("user");
		if(user==null){
			log.info("获取用户信息失败，session失效!");
			return "-1";
		}
		String commentId=request.getParameter("commentId");
		if(commentId==null || commentId==""){
			log.info("获取评论表主键Id为空");
			return "0";
		}
		int row=commentService.deleteComment(commentId);
		if(row==1){
			return "1";
		}else{
			return "0";
		}
	}
}
