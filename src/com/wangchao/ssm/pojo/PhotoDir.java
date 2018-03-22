package com.wangchao.ssm.pojo;

import java.util.Date;

public class PhotoDir {

	private int photoDirId;			//相册Id
	private int userId;				//所属用户
	private String photoDirName;	//相册名称
	private Date createTime;		//创建时间
	
	public int getPhotoDirId() {
		return photoDirId;
	}
	public void setPhotoDirId(int photoDirId) {
		this.photoDirId = photoDirId;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public String getPhotoDirName() {
		return photoDirName;
	}
	public void setPhotoDirName(String photoDirName) {
		this.photoDirName = photoDirName;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	
}
