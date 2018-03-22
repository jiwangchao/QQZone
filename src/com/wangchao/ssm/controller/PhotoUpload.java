package com.wangchao.ssm.controller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.wangchao.ssm.pojo.Photo;
import com.wangchao.ssm.pojo.PhotoDir;
import com.wangchao.ssm.pojo.User;
import com.wangchao.ssm.service.PhotoService;

/**
 * @author 吉王超
 * @date 2017年5月13日 上午11:01:18
 * @Description 相册上传
 */
@Controller
@RequestMapping("/photo")
public class PhotoUpload {

	Logger log=LoggerFactory.getLogger(PhotoUpload.class);
	
	@Autowired
	private PhotoService photoService;
	
	@RequestMapping("/index")
	public String index(HttpServletRequest request,Model model){
		User user=(User)request.getSession().getAttribute("user");
		if(user!=null){
			
			List<PhotoDir> list=photoService.queryMyPhotoDir(user.getUserId());
			model.addAttribute("photoDirlist", list);
			return "/photo/myPhoto";
		}else{
			return "/login/login";
		}
	}
	
	@RequestMapping("/uploadPhoto")
	public String uploadPhoto(HttpServletRequest request,String photoDirId,@RequestParam(value="uploadFiles")MultipartFile[] uploadFiles){ 
		User user = (User) request.getSession().getAttribute("user");
		int dirId=-1;
		if(photoDirId!=null){
			dirId=Integer.parseInt(photoDirId);
		}
		if(user!=null){

			String fileUrl="";
			log.info("开始上传图片");
			for(MultipartFile uploadFile:uploadFiles){
				
				//String path = session.getServletContext().getRealPath("/upload");  
				
				String pic_path = "D:\\uploadPhoto\\"+user.getUserAccount();  
				log.info("real path: " + pic_path);  
				
				String date=new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
				String photoName=new String(uploadFile.getOriginalFilename().substring(0, uploadFile.getOriginalFilename().indexOf(".")));
				
				String fileName = date+uploadFile.getOriginalFilename();  
				log.info("file name: " + fileName);  
				
				File targetFile =  new File(pic_path, fileName);  
				if (!targetFile.exists()) {  
				    targetFile.mkdirs();  
				}  
				try {
					uploadFile.transferTo(targetFile);
				} catch (IllegalStateException | IOException e) {
					e.printStackTrace();
				}
				fileUrl = fileName; 
				
				Photo photo=new Photo();
				photo.setUserId(user.getUserId());
				photo.setPhotoUrl(fileUrl);
				photo.setPhotoDirId(dirId);
				photo.setUploadTime(new Date());
				photo.setPhotoName(photoName);
				int row=photoService.addPhotos(photo);
				if(row==1){
					log.info("图片上传成功：fileName="+fileName);
				}else{
					log.error("图片上传失败:fileName="+fileName);
				}
			}
			log.info("图片上传结束");
			
			return "redirect:index.action"; 
		
		}else{
			//session过期，重新登录
			log.info("session过期，上传图片取消，重新登录。");
			return "/login/login";
		}
	}
	//查看指定相册的照片
	@RequestMapping("/queryMyPhotosByDir")
	public ModelAndView queryMyPhotosByDir(HttpServletRequest request){
		User user=(User)request.getSession().getAttribute("user");
		//web.xml中字符集过滤只对post请求方式有效，对于get方式提交的参数编码，只支持iso8859-1编码，需要进行手动转码
		String dirName=request.getParameter("dirName");
		log.info("转码前，get方式接收到的参数：dirName="+dirName);
		try {
			dirName=new String(dirName.getBytes("iso-8859-1"),"UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		log.info("转码后，get方式接收到的参数：dirName="+dirName);
		ModelAndView mv=new ModelAndView();
		if(user==null){
			mv.setViewName("/login/login");
			return mv;
		}
		int dirId=-1;
		String photoDirId=request.getParameter("dirId");
		if(photoDirId!=null){
			dirId=Integer.parseInt(photoDirId);
		}
		PhotoDir pd=new PhotoDir();
		pd.setPhotoDirId(dirId);
		pd.setUserId(user.getUserId());
		List<Photo> list=photoService.queryMyPhotoByDirId(pd);
		mv.addObject("photoList", list);
		mv.addObject("dirId", photoDirId);
		mv.addObject("dirName", dirName);
		mv.setViewName("/photo/myPhotoDetails");
		return mv;
	}
	//删除相册中的指定相片
	
	//添加相册
	@RequestMapping("/addPhotoDir")
	public String addPhotoDir(HttpServletRequest request){
		User user=(User)request.getSession().getAttribute("user");
		if(user==null){
			return "/login/login";
		}
		String photoDirName=request.getParameter("photoDirName");
		log.info("接收到的新相册名称,photoDirName={}",photoDirName);
		PhotoDir pd=new PhotoDir();
		pd.setUserId(user.getUserId());
		pd.setPhotoDirName(photoDirName);
		pd.setCreateTime(new Date());
		int row=photoService.addPhotoDir(pd);
		log.info("执行添加影响行数：row="+row);
		return "redirect:index.action";
	}
	//删除相册
	@RequestMapping("/multiDelPhoto")
	@ResponseBody
	public int multiDelPhoto(HttpServletRequest request,Model model){
		User user=(User)request.getSession().getAttribute("user");
		if(user==null){
			return -1;
		}
		String photoIdsString = request.getParameter("photoIds");
		log.info("接收到的照片id长String="+photoIdsString);
		int row=0;
		if(photoIdsString!=null){
			String [] photoIds = photoIdsString.split(",");
			List<Integer> list=new ArrayList<>();
			if(photoIds != null && photoIds.length > 0){
				for(int i=0;i<photoIds.length;i++){
					int photoid=Integer.parseInt(photoIds[i]);
					list.add(photoid);
				}
				log.info("转换为int类型的photoId的list集合：list.size()="+list.size());
			}
			row=photoService.multiDelPhoto(list);
			log.info("受影响的行:row="+row);
			model.addAttribute("row", row);
		}
		
		return row;
	}
	
	//修改相册名字
	@RequestMapping("/updatePhotoDirName")
	public String updatePhotoDirName(HttpServletRequest request){
		User user=(User)request.getSession().getAttribute("user");
		if(user==null){
			return "/login/login";
		}
		String photoDirName=request.getParameter("photoDirName");
		String photoDirIdString=request.getParameter("photoDirId");
		log.info("接收到的新相册名称和相册id:photoDirName={},photoDirId={}",photoDirName,photoDirIdString);
		int photoDirId = -1;
		if(photoDirIdString!=null){
			photoDirId=Integer.parseInt(photoDirIdString);
		}
		PhotoDir pd=new PhotoDir();
		pd.setUserId(user.getUserId());
		pd.setPhotoDirName(photoDirName);
		pd.setPhotoDirId(photoDirId);
		int row = photoService.updateMyPhotoDirNameByDirId(pd);
		log.info("修改相册名称影响的行数：row={}",row);
		return "redirect:index.action";
	}
	
	//删除相册，包括删除该相册下所有照片
	@RequestMapping("/delDir")
	@ResponseBody
	public String delDir(HttpServletRequest request){
		User user=(User)request.getSession().getAttribute("user");
		if(user==null){
			return "-1";
		}
		String dirIdString=request.getParameter("dirId");
		log.info("接收到的相册Id：dirId="+dirIdString);
		int dirId=-1;
		if(dirIdString!=null){
			dirId=Integer.parseInt(dirIdString);
		}
		//删除该相册下所有照片
		int row1=photoService.deleteMyPhotoByDirId(dirId);
		//删除该相册
		int row2=photoService.deleteMyPhotoDirByDirId(dirId);
		
		log.info("删除照片影响的行：row1={},删除相册影响的行：row2={}",row1,row2);
		String result="";
		if(row1>0 && row2>0){
			result= "success";
		}else{
			result= "fail";
		}
		return result;
	}
}
