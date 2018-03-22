package com.wangchao.ssm.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.wangchao.ssm.pojo.User;
import com.wangchao.ssm.service.UserService;

/**
 * @author 吉王超
 * @date 2016年12月21日 下午8:30:37
 * @Description 用户UserController
 */
@Controller
@RequestMapping("/user")
//窄化请求映射，为了更好的管理多个controller，可以在这里定义根路径，最终访问url是：根路径+子路径，比如：user/queryUsers.action
public class UserController {

	@Autowired
	private UserService userService;
	
	@RequestMapping("/queryUsers")
	public ModelAndView queryUsers(){
		
		List<User> list=userService.findUserList();
		
		//返回ModelAndView
		ModelAndView modelAndView=new ModelAndView();
		//相当于request.setAttibute()
		modelAndView.addObject("userList", list);
		
		//指定视图
		modelAndView.setViewName("/user/usersList");

//		return new ModelAndView(viewName, modelName, modelObject);
		return modelAndView;
	}

	
	//商品修改页面显示
	@RequestMapping(value="/editUser",method={RequestMethod.POST,RequestMethod.GET})
	public String editUser(Model model,@RequestParam(value="userId")Integer userId){

		//调用service根据id查询用户信息
		User user=userService.findUserById(userId);

		//相当于request.setAttibute()
		//相当于modelAndView.addObject("user", user);
		model.addAttribute("user", user);
		
		return "/user/editUser";
	}
	
	@RequestMapping("/editUserSubmit")
	public String editUserSubmit(User user){

		//调用service更新用户信息
		userService.updateUserById(user);
		//重定向到查询列表
		return "redirect:queryUsers.action";  //因为同在一个controller，故不需要加 user/
//		return "/user/success";
	}
}
