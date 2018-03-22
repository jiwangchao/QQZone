package com.wangchao.ssm.pojo;

import java.util.Date;

/**
 * @author 吉王超
 * @date 2017年5月13日 下午4:18:34
 * @Description 个人相册pojo
 */
public class Photo {

	private int photoId;
	private int userId;
	private int photoDirId;
	private String photoUrl;
	private Date uploadTime;
	private String photoName;
	
	public int getPhotoId() {
		return photoId;
	}
	public void setPhotoId(int photoId) {
		this.photoId = photoId;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public int getPhotoDirId() {
		return photoDirId;
	}
	public void setPhotoDirId(int photoDirId) {
		this.photoDirId = photoDirId;
	}
	public String getPhotoUrl() {
		return photoUrl;
	}
	public void setPhotoUrl(String photoUrl) {
		this.photoUrl = photoUrl;
	}
	public Date getUploadTime() {
		return uploadTime;
	}
	public void setUploadTime(Date uploadTime) {
		this.uploadTime = uploadTime;
	}
	public String getPhotoName() {
		return photoName;
	}
	public void setPhotoName(String photoName) {
		this.photoName = photoName;
	}
	
}
