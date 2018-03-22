package com.wangchao.ssm.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
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

import com.sun.org.apache.bcel.internal.generic.ReturnInstruction;
import com.wangchao.ssm.pojo.Comment;
import com.wangchao.ssm.pojo.Diary;
import com.wangchao.ssm.pojo.DiaryContent;
import com.wangchao.ssm.pojo.User;
import com.wangchao.ssm.service.CommentService;
import com.wangchao.ssm.service.DiaryService;

import sun.util.logging.resources.logging;

/**
 * @author 吉王超
 * @date 2017年5月28日 上午12:18:51
 * @Description 日志controller
 */
@Controller
@RequestMapping("/diary")
public class DiaryController {
	
	@Autowired
	private DiaryService diaryService;
	@Autowired
	private CommentService commentService;
	
	Logger log=LoggerFactory.getLogger(DiaryController.class);
	
	/**
	 * 查找我的日志标题列表
	 */
	@RequestMapping("/index")
	public String diaryIndex(HttpServletRequest request,Model model){
		User user=(User)request.getSession().getAttribute("user");
		if(user==null){
			return "/login/login";
		}
		//查询日志列表
		List<Diary> list=new ArrayList<>();
		list=diaryService.queryMyDiaryList(user.getUserId());
		log.info("查询出的日志list为：list.size="+list.size());
		model.addAttribute("list", list);
		return "/diary/diary";
	}
	/**
	 * 编写日志路由
	 */
	@RequestMapping("/editDiary")
	public String editDiary(){
		return "/diary/editDiary";
	}
	/**
	 * 编写日志内容
	 */
	@RequestMapping("/addDiary")
	@ResponseBody
	public String addDiary(HttpServletRequest request){
		User user=(User)request.getSession().getAttribute("user");
		if(user==null){
			return "-1";
		}
		String diaryTitle=request.getParameter("diaryTitle");
		String diaryContent=request.getParameter("textArea");
		String diaryBg=request.getParameter("diaryBg");
		if(diaryTitle ==null|| diaryContent==null || diaryBg==null 
				||diaryTitle =="" || diaryContent=="" || diaryBg ==""){
			log.info("接收日志参数为空");
			return "0";
		}
		String diaryContentId="";
		diaryContentId=new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
		log.info("生成日志主键ID为：diaryContentId="+diaryContentId);
		DiaryContent diary=new DiaryContent();
		diary.setDiaryContentTitle(diaryTitle);
		diary.setDiaryContentText(diaryContent);
		diary.setDiaryBg(diaryBg);
		diary.setDiaryContentId(diaryContentId);
		diary.setDiaryContentTime(new Date());
		
		int row=diaryService.addDiaryContent(diary);
		
		Diary diary2=new Diary();
		diary2.setDiaryContentId(diaryContentId);
		diary2.setDiaryContentTitle(diaryTitle);
		diary2.setDiaryTime(new Date());
		diary2.setUserId(user.getUserId());
		
		int row2=diaryService.addDiary(diary2);
		
		log.info("插入日志包，影响行数：row2="+row2);
		log.info("插入日志内容表，影响行数：row="+row);
		if(row==1){
			return "1";
		}else{
			return "0";
		}
	}
	/**
	 * 查看指定日志
	 */
	@RequestMapping("/queryDiaryByDiaryContentId")
	public String queryDiaryByDiaryContentId(HttpServletRequest request,Model model){
		User user=(User)request.getSession().getAttribute("user");
		if(user==null){
			log.info("获取用户信息为空，session超时");
			return "/login/login";
		}
		String diaryContentId=request.getParameter("diaryContentId");
		if(diaryContentId!=null){
			//查询日志内容
			DiaryContent myDiary=diaryService.queryDiaryByDiaryContentId(diaryContentId);
			log.info("查询到的日志的标题："+myDiary.getDiaryContentTitle());
			model.addAttribute("myDiary", myDiary);
			//查询日志评论
			Comment com=new Comment();
			com.setCommentTypeId(diaryContentId);
			com.setCommentType(1);	//日志类型的评论
			com.setaUserId(user.getUserId());
			List<Comment> comments=commentService.queryCommentList(com);
			log.info("查询出的该篇日志的评论集合：comments.size="+comments.size());
			model.addAttribute("diaryCommentList", comments);
		}
		return "/diary/viewDiary";
	}
	/**
	 * 修改日志路由跳转 
	 */
	@RequestMapping("/updateDiaryByDiaryContentId")
	public String updateDiaryByDiaryContentId(HttpServletRequest request,Model model){
		User user=(User)request.getSession().getAttribute("user");
		if(user==null){
			log.info("获取用户信息为空，session超时");
			return "/login/login";
		}
		String diaryContentId=request.getParameter("diaryContentId");
		if(diaryContentId!=null){
			DiaryContent myDiary=diaryService.queryDiaryByDiaryContentId(diaryContentId);
			log.info("查询到的日志的标题："+myDiary.getDiaryContentTitle());
			model.addAttribute("myDiary", myDiary);
			model.addAttribute("updateDiaryFlag","update");
		}
		return "/diary/viewDiary";
	}
	/**
	 * 修改日志提交
	 */
	@RequestMapping("/updateDiarySubmit")
	@ResponseBody
	public String updateDiarySubmit(HttpServletRequest request,Model model){
		User user=(User)request.getSession().getAttribute("user");
		if(user==null){
			log.info("获取用户信息为空，session超时");
			return "-1";
		}
		String diaryContentId=request.getParameter("diaryContentId");
		String diaryTitle=request.getParameter("diaryTitle");
		String diaryContent=request.getParameter("textArea");
		String diaryBg=request.getParameter("diaryBg");
		if(diaryTitle ==null|| diaryContent==null || diaryBg==null ||diaryContentId==null
				||diaryTitle =="" || diaryContent=="" || diaryBg =="" ||diaryContentId==""){
			log.info("修改日志时，接收日志参数为空");
			return "0";
		}
		DiaryContent diary=new DiaryContent();
		diary.setDiaryContentId(diaryContentId);
		diary.setDiaryContentTitle(diaryTitle);
		diary.setDiaryContentText(diaryContent);
		diary.setDiaryBg(diaryBg);
		diary.setDiaryContentTime(new Date());
		
		int row=diaryService.updateDiaryContentByContentId(diary);
		
		Diary diary2=new Diary();
		diary2.setDiaryContentId(diaryContentId);
		diary2.setDiaryContentTitle(diaryTitle);
		diary2.setDiaryTime(new Date());
		
		int row2=diaryService.updateDiaryByContentId(diary2);
		
		log.info("修改日志表，影响行数：row2="+row2);
		log.info("修改日志内容表，影响行数：row="+row);
		if(row == 1 && row2 == 1){
			return "1";
		}else{
			return "0";
		}
	}
	/**
	 * 删除日志
	 */
	@RequestMapping("/deleteDiaryByDiaryContentId")
	@ResponseBody
	public String deleteDiaryByDiaryContentId(HttpServletRequest request){
		User user=(User)request.getSession().getAttribute("user");
		if(user==null){
			log.info("获取用户信息为空，session超时");
			return "-1";
		}
		String diaryContentId=request.getParameter("diaryContentId");
		if(diaryContentId==null){
			log.info("删除日志时，接收日志参数id为空");
			return "0";
		}
		Diary diary=new Diary();
		diary.setDiaryContentId(diaryContentId);
		diary.setUserId(user.getUserId());
		int row1=diaryService.deleteDiaryByDiaryContentId(diary);
		
		DiaryContent diaryContent=new DiaryContent();
		diaryContent.setDiaryContentId(diaryContentId);
		int row2=diaryService.deleteDiaryContentByDiaryContentId(diaryContent);
		
		if(row1==1 && row2 ==1){
			return "1";
		}else{
			return "0";
		}
	}
}
