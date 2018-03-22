package com.wangchao.ssm.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.wangchao.ssm.pojo.Group;
import com.wangchao.ssm.pojo.Talk;
import com.wangchao.ssm.pojo.User;
import com.wangchao.ssm.service.GroupService;
import com.wangchao.ssm.service.TalkService;
import com.wangchao.ssm.service.UserService;


/**
 * @author 吉王超
 * @date 2017年4月4日 下午6:48:39
 * @Description QQ空间登录controller
 */
@Controller
@RequestMapping("/log")
public class LoginController {
	@Autowired
	private UserService userService;
	@Autowired
	private TalkService talkService;
	@Autowired
	private GroupService groupService;
	
	Logger log=LoggerFactory.getLogger(LoginController.class);
	
	//用户登录
	@RequestMapping("/login")
	private String login(Model model,User user,HttpServletRequest request){
		
		User user1=userService.findUserByUserAccountAndPassword(user);
		//如果验证登录账号及密码可用，则更新该用户上次登录时间
		if(user1!=null){
			HttpSession session = request.getSession();
			session.setAttribute("user", user1); 
			//设置session会话后再更新该用户最新登录时间，这样session中存放的就是上次登录时间。
			User user2=new User();
			user2.setUserId(user1.getUserId());
			user2.setLastLoginTime(new Date());
			userService.updateUserLastLoginTime(user2);
			
			return "redirect:personalZone.action";
			//return "forward:/user/queryUsers.action";
		}else{
			model.addAttribute("loginError", "用户名或密码错误");
			return "/login/login";
		}
		
	}
	/**
	 * 用户注册页面跳转
	 */
	@RequestMapping("/register")
	public String register(){
		
		return "/login/register";
	}
	/**
	 * 已有账号，返回登录
	 */
	@RequestMapping("/loginQQ")
	public String loginQQ(){
		return "/login/login";
	}
	/**
	 * 注册信息提交
	 */
	@RequestMapping("/registerSubmit")
	public String registerSubmit(HttpServletRequest request,Model model){
		
		String userAccount=request.getParameter("userAccount");
		String password=request.getParameter("password");
		String sex=request.getParameter("sex");
		String birthdayY=request.getParameter("birthdayY");
		String birthdayM=request.getParameter("birthdayM");
		String birthdayD=request.getParameter("birthdayD");
		String currentAddress=request.getParameter("currentAddress");
		String hometown=request.getParameter("hometown");
		
		String userName=request.getParameter("userName"); 
		
		if(userAccount==null ||password==null ||sex==null ||birthdayY==null ||	userName==null ||
				birthdayM==null ||birthdayD==null ||currentAddress==null ||hometown==null ){
			log.error("接收注册用户信息为空");
			return "/login/register";
		}
		//拼接生日
		String birthday=new StringBuffer("").append(birthdayY).append("-")
					.append(birthdayM).append("-").append(birthdayD).toString();
		//计算年龄
		String now=new SimpleDateFormat("yyyy").format(new Date());
		int age=Integer.parseInt(now)-Integer.parseInt(birthdayY);
		
		User user=new User();
		user.setUserAccount(userAccount);
		user.setPassword(password);
		user.setSex(sex);
		user.setBirthday(birthday);
		user.setAge(age);
		user.setCurrentAddress(currentAddress);
		user.setHometown(hometown);
		user.setUserName(userName);
		int row1=userService.addOneUser(user);
		if(row1==1){
			//注册成功则未该用户创建一个默认好友分组
			User registerUser=userService.findUserByUserAccountAndPassword(user);
			//添加分组
			Group group=new Group();
			group.setUserId(registerUser.getUserId());
			group.setgName("我的好友");
			group.setgNo("default");
			int row2=groupService.addOneGroup(group);
			if(row2==1){
				log.info("为该注册用户创建默认好友分组成功");
			}
			model.addAttribute("loginError", "注册成功，请登录");
			return "/login/login";
		}else{
			model.addAttribute("loginError", "注册失败，请重新注册");
			return "/login/login";
		}
	}
	//用户注销
	@RequestMapping("/logout")
	private String LogOut(HttpServletRequest request){
		HttpSession session = request.getSession();
		session.removeAttribute("user");
		return "/login/login";
	}
	//登录之后进入的个人中心
	@RequestMapping("personalZone")
	private String personalZone(Model model,HttpServletRequest request){
		//在好友QQ空间点击返回个人中心
		String flag=request.getParameter("returnMyConter");
		if(flag!=null){
			//获取当前登录用户
			User logUser=(User) request.getSession().getAttribute("logUser");
			if(logUser==null){
				return "/login/login";
			}
			//充值session域当前登录用户信息，并移除访问好友session域用户信息
			request.getSession().setAttribute("user", logUser);
			request.getSession().removeAttribute("logUser");
		}
		
		User user = (User) request.getSession().getAttribute("user");
		if(user!=null){
			
			List<Talk> atList=talkService.queryAllTalkList(user);
			model.addAttribute("atList", atList);
			
			return "/personal/personal_zone";
		}else{
			return "/login/login";
		}
	}
}
