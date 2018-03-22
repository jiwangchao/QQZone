package com.wangchao.ssm.controller;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.wangchao.ssm.pojo.MessageBoard;
import com.wangchao.ssm.pojo.User;
import com.wangchao.ssm.service.MessageBoardService;

/**
 * @author 吉王超
 * @date 2017年4月23日 下午6:34:40
 * @Description 留言板功能
 */
@Controller
@RequestMapping("/messageBoard")
public class MessageBoardController {
	@Autowired
	private MessageBoardService mbService;
	
	Logger log=LoggerFactory.getLogger(MessageBoardController.class);
	
	@RequestMapping("/queryMymessageBoard")
	public ModelAndView queryMymessageBoard(HttpServletRequest request){
		
		ModelAndView mv=new ModelAndView();
		User user = (User)request.getSession().getAttribute("user");
		if(user==null){
			log.info("session失效，获取用户信息失败");
			mv.setViewName("/login/login");
			return mv;
		}
		//查询留言板
		List<MessageBoard> mBoards=mbService.queryMyMessageBoard(user.getUserId());
		log.info("查询到的留言记录：mboards.size="+mBoards.size());
		//查询留言板总数
		int count=mbService.getMessageCounts(user.getUserId());
		log.info("查询到的留言板总记录数为：count="+count);
		
		mv.setViewName("/messageBoard/messageBoard");
		mv.addObject("messageList", mBoards);
		mv.addObject("messageCount", count);
		return mv;
	}
	
	/**
	 * 发表留言
	 */
	@RequestMapping("/sendLeaveMessage")
	@ResponseBody
	public String sendLeaveMessage(HttpServletRequest request){
		User friend=(User) request.getSession().getAttribute("user");
		User logUser=(User) request.getSession().getAttribute("logUser");
		if(friend==null || logUser== null){
			log.error("session失效，获取用户信息失败");
			return "-1";
		}
		//接收留言信息参数
		String messageInfo=request.getParameter("textArea");
		if(messageInfo==null || messageInfo ==""){
			return "-2";
		}
		MessageBoard message=new MessageBoard();
		message.setLeaveId(logUser.getUserId());
		message.setMasterId(friend.getUserId());
		message.setMessageContent(messageInfo);
		message.setMessageTime(new Date());
		//执行数据库插入操作
		int row=mbService.sendLeaveMessage(message);
		if(row==1){
			log.info("发表留言成功");
			return "1";
		}else{
			log.error("发表留言失败");
			return "0";
		}
	}
	
	
}
