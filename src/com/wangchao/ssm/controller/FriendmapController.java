package com.wangchao.ssm.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.wangchao.ssm.pojo.Friendmap;
import com.wangchao.ssm.pojo.Group;
import com.wangchao.ssm.pojo.User;
import com.wangchao.ssm.service.FriendmapService;
import com.wangchao.ssm.service.GroupService;
import com.wangchao.ssm.service.UserService;

/**
 * @author 吉王超
 * @date 2017年4月27日 上午12:23:22
 * @Description 我的好友关系controller
 */
@Controller
@RequestMapping("/friend")
public class FriendmapController {
	@Autowired
	private FriendmapService friendmapService;
	@Autowired
	private GroupService groupService;
	@Autowired
	private UserService userService;

	Logger log=LoggerFactory.getLogger(FriendmapController.class);
	//Logger log=LoggerFactory.getLogger("wangchao");
	/**
	 *  查找我的好友
	 */
	@RequestMapping("/myfriends")
	public ModelAndView queryMyFriends(HttpServletRequest request){
		HttpSession session =request.getSession();
		User user=(User) session.getAttribute("user");
		log.info("获取session中的user:"+user);
		//查找我的全部好友
		if(user==null){
			ModelAndView mv=new ModelAndView();
			mv.setViewName("/login/login");
			return mv;
		}
		List<Friendmap> friendmapList=friendmapService.findMyFriend(user.getUserId());
		List<Friendmap> friends=new ArrayList<Friendmap>();			//已经互为好友：status=1
		List<User> friendsRequest=null;								//发送给我的好友添加请求：status=4
		//Set<Integer> friendsIds=new HashSet<>();
		List<Integer> friendsIds=new ArrayList<>();
		if(friendmapList!=null){
			//friends不为空，则进行好友分类：已经互为好友：status=1 , 发送给我的好友添加请求：status=4
			for (Friendmap friendmap : friendmapList) {
				if(friendmap.getStatus()==1){
					friends.add(friendmap);
				}else if(friendmap.getStatus()==4){
					//分装好友id
					friendsIds.add(friendmap.getFriendId());
				}
			}
			if(friendsIds.size()>0){
				friendsRequest=userService.findUserListByUserIds(friendsIds);
			}
		}
		
		log.info("查找我的全部好友（不分状态）：{},查找我已经添加的好友：{},封装好友id的set集合{},查找发送给我的好友添加请求：{}",friendmapList,friends,friendsIds,friendsRequest);
		//查找我的全部好友分组
		List<Group> groupList=groupService.findMyGroup(user.getUserId());
		log.info("查找我的全部好友分组：{}",groupList);
		ModelAndView modelAndView=new ModelAndView();
		modelAndView.addObject("friends", friends);
		modelAndView.addObject("friendsRequest", friendsRequest);
		modelAndView.addObject("groupList", groupList);
		modelAndView.setViewName("/friends/myFriends");
		return modelAndView;
	}
	/**
	 * 修改指定用户的权限：访问空间，动态屏蔽
	 */
	@RequestMapping("/updateFriendRight")
	public void updateFriendRight(Model model,HttpServletRequest request,HttpServletResponse response){
		String friendIdString=request.getParameter("friendId");
		String optionString=request.getParameter("option");	//操作状态
		String type=request.getParameter("type");			//操作类别：allowVisited、hideDynamic
		
		int friendId=-1;
		int option=-1;
		int userId=-1;
		if(friendIdString!=null && optionString!=null){
			friendId=Integer.parseInt(friendIdString);
			option=Integer.parseInt(optionString);
		}
		User user=(User) request.getSession().getAttribute("user");
		int updateRow=0;
		String result="";
		if(user!=null){
			userId=user.getUserId();
		
			Map<String, Integer> map=new HashMap<>();
			map.put("userId",userId);
			map.put("friendId",friendId);
			
			//根据不同类别封装不同字段
			if("allowVisited".equals(type)){
				map.put("allowvVisited",option);
				//修改访问空间权限
				updateRow=friendmapService.updateFriendRight(map);
			}else if ("hideDynamic".equals(type)) {
				map.put("hideDynamic",option);
				//修改动态屏蔽状态
				updateRow=friendmapService.updateFriendDynamic(map);
			}else if ("careStatus".equals(type)) {
				map.put("careStatus",option);
				//修改特别关心状态
				updateRow=friendmapService.updateCareStatus(map);
			}
			
			if(updateRow==1){
				result="0";
			}else if(updateRow==0){
				result="1";
			}
		}else{
			result="-1";
		}
		
		log.info("ajax修改访问权限，用户：{},好友：{},修改类别：{},修改状态：{},result：{}", user.getUserName(),friendId,type,option,result);
		
		response.setCharacterEncoding("utf-8");
		response.setContentType("application/json;charset=utf-8");
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	/**
	 * 模糊搜索好友列表
	 */
	@RequestMapping("/searchFriend")
	@ResponseBody
	public List<User> searchFriend(HttpServletRequest request){
		String type=request.getParameter("type");
		String searchQQ=request.getParameter("searchQQ");
		log.info("接收type:{},searchQQ:{}",type,searchQQ);
		List<User> list=null;
		if("ByAccount".equals(type)){
			list=userService.finduserListByAccount(searchQQ);
		}else if("ByName".equals(type)){
			list=userService.finduserListByName(searchQQ);
		}
		log.info("查询出来的list：{}",list);
		
		return list;
	}
	/**
	 * 查找用户详细信息
	 */
	@RequestMapping("/viewFriendDetails")
	@ResponseBody
	public User viewFriendDetails(HttpServletRequest request){
		String userIdString=request.getParameter("userId");
		log.info("接收QQ用户id:{}",userIdString);
		int userId=0;
		if(userIdString!=null){
			userId=Integer.parseInt(userIdString);
		}
		User user=userService.viewFriendDetails(userId);
		//重设user属性，若有null字段，则置空
		user.setSex(user.getSex()==null?"--":user.getSex());
		user.setBirthday(user.getBirthday()==null?"--":user.getBirthday());
		user.setPersonalSign(user.getPersonalSign()==null?"--":user.getPersonalSign());
		user.setBloodType(user.getBloodType()==null?"--":user.getBloodType());
		user.setCurrentAddress(user.getCurrentAddress()==null?"--":user.getCurrentAddress());
		user.setHometown(user.getHometown()==null?"--":user.getHometown());
		user.setEmotion(user.getEmotion()==null?"--":user.getEmotion());
		user.setConstellation(user.getConstellation()==null?"--":user.getConstellation());
		user.setPrefessional(user.getPrefessional()==null?"--":user.getPrefessional());
		user.setCompany(user.getCompany()==null?"--":user.getCompany());
		user.setHobby(user.getHobby()==null?"--":user.getHobby());
		
		log.info("查找用户的详细信息：{}",user);
		return user;
	}
	/**
	 * 添加好友
	 */
	@RequestMapping("/addFriend")
	@ResponseBody
	public String addFriend(HttpServletRequest request){
		User user=(User)request.getSession().getAttribute("user");
		String friendIdString =request.getParameter("friendId");
		int friendId=0;
		if(friendIdString!=null){
			friendId=Integer.parseInt(friendIdString);
		}
		int userId=0;
		if(user!=null){
			userId=user.getUserId();
		}else{
			return null;
		}
		log.info("userId:{},friendId:{}",userId,friendIdString);
		Map<String, Integer> map=new HashMap<>();
		map.put("userId", userId);
		map.put("friendId", friendId);
		
		//添加之前先判断是否已经是好友状态，待对方验证，已加为好友,对方已经向你发送好友请求（此时直接更新双方status为1，及双方成为好友）
		Friendmap verifyfriend=null;
		verifyfriend=friendmapService.findVerifyfriend(map);
		log.info("verifyFriend:{}",verifyfriend);
		if(verifyfriend!=null){
			if(verifyfriend.getStatus()==1){
			//已加为好友，不可在此添加
				return "1";
			}else if(verifyfriend.getStatus()==0){
			//验证中，不可重复添加	
				return "0";
			}else if(verifyfriend.getStatus()==4 || verifyfriend.getStatus()==2){
				//对方已经向你发送好友添加请求，此时再次添加直接修改双方status为1，及成为好友
				//已拒绝对方发送的添加好友请求，主动添加将修改己方好友status由2置1，修改好友方status由0置1，及双方成为好友
				Friendmap fm1=new Friendmap();
				Friendmap fm2=new Friendmap();
				int num1=-1;
				int num2=-1;
				fm1=new Friendmap();
				fm1.setUserId(userId);
				fm1.setFriendId(friendId);
				fm1.setStatus(1);
				num1=friendmapService.updateFriendRequest(fm1);
				fm2=new Friendmap();
				fm2.setUserId(friendId);
				fm2.setFriendId(userId);
				fm2.setStatus(1);
				num2=friendmapService.updateFriendRequest(fm2);
				log.info("【查找好友】中点击【添加】结果：userId:{},friendId:{},num1:{},num2:{}",userId,friendId,num1,num2);
				
				if(num1 > 0 && num2 > 0){
					return "4";
				}
			}
		}
		String verifyInfo=request.getParameter("verifyInfo");
		String beizhu=request.getParameter("beiZhu");
		log.info("verifyInfo:{}");
		//若查找出的verifyFriend为空，则未添加过该好友，可以插入数据
		Friendmap fm1=new Friendmap();
		fm1.setUserId(userId);
		fm1.setFriendId(friendId);
		fm1.setVerifyInfo(verifyInfo);
		fm1.setStatus(0);
		fm1.setBeiZhu(beizhu);
		//申请方插入friendmap数据
		int num1=friendmapService.addFriend(fm1);
		
		Friendmap fm2=new Friendmap();
		fm2.setUserId(friendId);      
		fm2.setFriendId(userId);  
		fm2.setVerifyInfo(verifyInfo);      
		fm2.setStatus(4);           
		fm2.setBeiZhu("新好友");          
		//接收方插入friendmap数据
		int num2=friendmapService.addFriend(fm2);
		
		if(num1>0 && num2>0){
			return "success";
		}else{
			return "false";
		}
	}
	/**
	 * 查看好友验证信息
	 */
	@RequestMapping("/viewFriendVerifyInfo")
	@ResponseBody
	public Friendmap viewFriendVerifyInfo(HttpServletRequest request){
		User user=(User) request.getSession().getAttribute("user");
		if(user==null){
			log.info("session失效，获取用户信息失败");
			return null;
		}
		String friendId=request.getParameter("friendId");
		Friendmap fm=new Friendmap();
		fm.setUserId(user.getUserId());
		fm.setFriendId(Integer.parseInt(friendId));
		//查询好友验证信息
		Friendmap fm2=friendmapService.viewFriendVerifyInfo(fm);
		if(fm2!=null ){
			log.info("查询到的好友验证信息为："+fm2.getVerifyInfo());
			return fm2;
		}else{
			return null;
		}
	}
	/**
	 * 处理好友添加请求    0：同意,1：拒绝
	 */
	@RequestMapping("/updateFriendRequest")
	@ResponseBody
	public String updateFriendRequest(HttpServletRequest request){
		User user=(User) request.getSession().getAttribute("user");
		int userId=-1;
		if(user!=null){
			userId=user.getUserId();
			String friendIdString=request.getParameter("friendId");
			String typeString=request.getParameter("type");
			String beiZhu=request.getParameter("beiZhu");
			log.info("user:{},FriendIdString:{},typeString:{}",user,friendIdString,typeString);
			int friendId=-1;
			int type=-1;
			int num1=0;
			int num2=0;
			Friendmap fm1=null;
			Friendmap fm2=null;
			if(friendIdString!=null && typeString!=null &&
					friendIdString!="" && typeString!=""){
				friendId=Integer.parseInt(friendIdString);
				type=Integer.parseInt(typeString);
				if(type==0){				//同意添加，修改两条数据：userId的status由4置1，friendId的status由0置1
					if( beiZhu==null || beiZhu ==""){
						return "-2";
					}
					fm1=new Friendmap();
					fm1.setUserId(userId);
					fm1.setFriendId(friendId);
					fm1.setStatus(1);
					fm1.setBeiZhu(beiZhu);
					num1=friendmapService.updateFriendRequest(fm1);
					fm2=new Friendmap();
					fm2.setUserId(friendId);
					fm2.setFriendId(userId);
					fm2.setStatus(1);
					num2=friendmapService.updateFriendRequest(fm2);
					log.info("【同意】添加结果：userId:{},friendId:{},type:{},num1:{},num2:{}",userId,friendId,type,num1,num2);
					
					if(num1 > 0 && num2 > 0){
						return "0";
					}
				}else if(type==1){			//拒绝添加,修改一条数据，userId的status由4置2
					fm1=new Friendmap();
					fm1.setUserId(userId);
					fm1.setFriendId(friendId);
					fm1.setStatus(2);
					num1=friendmapService.updateFriendRequest(fm1);
					log.info("【拒绝】添加结果：userId:{},friendId:{},type:{},num1:{}",userId,friendId,type,num1);
					
					if(num1 > 0 ){
						return "1";
					}
				}
			}
			return "-2";
		}else{
			return "-1";
		}
		
	}
	/**
	 * 移动好友分组
	 */
	@RequestMapping("/updateFriendInGroup")
	@ResponseBody
	public String updateFriendInGroup(HttpServletRequest request){
		User user=(User) request.getSession().getAttribute("user");
		if(user!=null){
			int userId=user.getUserId();
			String friendIdString =request.getParameter("friendId");
			String gNo=request.getParameter("gNo");
			int rownum=0;
			if(friendIdString!=null && gNo!=null){
				int friendId=Integer.parseInt(friendIdString);
				Friendmap fm=new Friendmap();
				fm.setUserId(userId);
				fm.setFriendId(friendId);
				fm.setgNo(gNo);
				//执行更改分组之前先查看是否在目标分组，即向所在的租移动。
				String gNo2=friendmapService.queryFriendInGroup(fm);
				if(gNo.equals(gNo2)){
					return "-3";
				}
				rownum=friendmapService.updateFriendInGroup(fm);
				if(rownum==1){
					return "0";
				}else {
					return "1";
				}
			}else{
				return "-2";
			}
		}else{
			return "-1";
		}
	}
	
	/**
	 * 分组右键操作
	 */
	@RequestMapping("/rightOptionType")
	public String rightOptionType(HttpServletRequest request,Model model){
		User user=(User) request.getSession().getAttribute("user");
		if(user==null){
			return "/login/login";
		}
		// type: 1:创建分组     2：重命名分组    3:修改好友备注
		String type=request.getParameter("rightOptionType");
		
		if(type==null || type == "" ){
			log.error("接收右键操作参数为空");
			
		}
		if("1".equals(type)){
			String gName=request.getParameter("gName");
			if( gName ==null || gName == ""){
				log.error("接收右键操作参数为空");
			}
			//创建分组唯一序列号   userId_yyyyMMddHHmmss
			String gNo = new StringBuffer(String.valueOf(user.getUserId())).append("_")
					.append(new SimpleDateFormat("yyyyMMddHHmmss").format(new Date())).toString();
			Group group=new Group();
			group.setUserId(user.getUserId());
			group.setgName(gName);
			group.setgNo(gNo);
			int row=groupService.addOneGroup(group);
			if(row==1){
				log.info("创建分组成功");
			}else{
				log.error("创建分组失败");
			}
		}else if("2".equals(type)){
			String gName=request.getParameter("gName");
			String gId=request.getParameter("gfId");
			if( gId ==null || gId == "" || gName ==null || gName == ""){
				log.error("接收右键操作参数为空");
			}
			Group group=new Group();
			group.setUserId(user.getUserId());
			group.setgName(gName);
			group.setgId(Integer.parseInt(gId));
			int row=groupService.updateGroupName(group);
			if(row==1){
				log.info("重命名分组成功");
			}else{
				log.error("重命名分组失败");
			}
		}else if("3".equals(type)){
			String beiZhu=request.getParameter("beiZhu");
			String fId=request.getParameter("gfId");
			if( fId ==null || fId == "" || beiZhu ==null || beiZhu == ""){
				log.error("接收右键操作参数为空");
			}
			Friendmap fm=new Friendmap();
			fm.setUserId(user.getUserId());
			fm.setFriendId(Integer.parseInt(fId));
			fm.setBeiZhu(beiZhu);
			int row=friendmapService.updateFriendBeiZhu(fm);
			if(row==1){
				log.info("重命名分组成功");
			}else{
				log.error("重命名分组失败");
			}
		}
		return "redirect:myfriends.action";
	}
	
	/**
	 * 删除好友
	 */
	@RequestMapping("/deleteFriend")
	public String deleteFriend(HttpServletRequest request){
		User user=(User) request.getSession().getAttribute("user");
		if(user==null){
			log.info("session失效，获取用户信息失败");
			return "-1";
		}
		String friendId=request.getParameter("friendId");
		if(friendId==null || friendId ==""){
			log.info("删除好友失败，获取好友Id参数为空");
			return "-2";
		}
		//删除好友，删除friendmap表两条数据
		Friendmap fm1=new Friendmap();
		fm1.setUserId(user.getUserId());
		fm1.setFriendId(Integer.parseInt(friendId));
		int row1=friendmapService.deleteFriend(fm1);
		Friendmap fm2=new Friendmap();
		fm2.setUserId(Integer.parseInt(friendId));
		fm2.setFriendId(user.getUserId());
		int row2=friendmapService.deleteFriend(fm2);
		if(row1==1 && row2==1){
			log.info("删除好友成功");
			return "1";
		}else{
			log.info("删除好友失败");
			return "0";
		}
	}
}
