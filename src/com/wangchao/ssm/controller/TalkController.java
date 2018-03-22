package com.wangchao.ssm.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.wangchao.ssm.pojo.Friendmap;
import com.wangchao.ssm.pojo.Talk;
import com.wangchao.ssm.pojo.User;
import com.wangchao.ssm.service.FriendmapService;
import com.wangchao.ssm.service.TalkService;
import com.wangchao.ssm.service.UserService;

/**
 * @author 吉王超
 * @date 2017年4月9日 下午4:14:24
 * @Description 查看及发表说说
 */
@Controller
@RequestMapping("/talk")
public class TalkController {

	@Autowired
	private TalkService talkService;
	@Autowired
	private UserService userService;
	@Autowired
	private FriendmapService friendmapService;
	
	Logger log=LoggerFactory.getLogger(TalkController.class);
	
	@RequestMapping("/queryMyTalkList")
	public ModelAndView queryMyTalkList(HttpServletRequest request){
		ModelAndView mv = new ModelAndView();
		
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("user");
		if(user==null){
			log.info("获取用户信息为空，session超时");
			mv.setViewName("/personal/personal_talk");
			return mv;
		}
		//访问好友空间
		String friendId=request.getParameter("friendId");
		if(friendId!=null){
			//查询好友互动设置,我访问他，查询的是他对我的好友设置
			Friendmap fm1=new Friendmap();
			fm1.setUserId(Integer.parseInt(friendId));
			fm1.setFriendId(user.getUserId());
			Friendmap fm2=friendmapService.queryFriendSetting(fm1);
			mv.addObject("friendSetting", fm2);
			
			//更新好友表-访问时间：userId=friendId
			Friendmap fm3=new Friendmap();
			fm3.setUserId(Integer.parseInt(friendId));
			fm3.setFriendId(user.getUserId());
			fm3.setLastVisitTime(new Date()); 
			int row3=friendmapService.updateFriendLastVisitTime(fm3);
			log.info("更新访问时间影响的行：row="+row3);
			
			//查询好友基本信息user表
			List<Integer> friendsIds=new ArrayList<>();
			friendsIds.add(Integer.parseInt(friendId));
			List<User> friendList=userService.findUserListByUserIds(friendsIds);
			User friend=friendList.get(0);
			log.info("根据friendId查询到的好友信息：friend="+friend);
			
			//设置session域当前登录用户为user，被访问的好友用户为friend
			request.getSession().setAttribute("logUser", user);
			request.getSession().setAttribute("user", friend);
			log.info("设置session域用户转换成功");
			//设置session完后，将user重新指向friend,即重新获取一下user
			user=(User) request.getSession().getAttribute("user");
		}
		
		//访问当前登录用户的说说列表
		
		List<Talk> list=talkService.queryMyTalkList(user);
		mv.addObject("mytalkList", list);
		mv.setViewName("/personal/personal_talk");

		return mv;
	}
	
	/*@RequestMapping("/queryAllTalkList")
	public ModelAndView queryAllTalkList(HttpServletRequest request){
		ModelAndView mv = new ModelAndView();
		
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("user");
		
		//List<Talk> list=talkService.queryAllTalkList(user);
		//mv.addObject("mytalkList", list);
		mv.setViewName("/personal/personal_center");

		return mv;
	}*/
	
	@RequestMapping("/addOneTalk")
	public void addOneTalk(HttpServletRequest request,HttpServletResponse response){
		HttpSession session = request.getSession();
		
		User user =(User)session.getAttribute("user");
		if(user!=null){

			String talkTextArea=request.getParameter("talkTextArea");
			String userId = request.getParameter("userId");
			
			Talk talk= new Talk();
			talk.setUserId(user.getUserId());
			talk.setTalkContent(talkTextArea);
			
			String sendResult="";
			int resultId=talkService.addOneTalk(talk);
			if(resultId > 0){
				sendResult = "0";
			}else{
				sendResult = "1";
			}
			//mv.setViewName("/queryMyTalkList.action");
			
			System.out.println("ajax send userId:"+userId+",session get userId:"+user.getUserId());
			
			response.setCharacterEncoding("utf-8");
			response.setContentType("application/json;charset=utf-8");
			try {
				response.getWriter().write(sendResult);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}else{
			log.info("获取用户信息为空，session超时");
		}
		
		
	}
	
	
	
	
}
