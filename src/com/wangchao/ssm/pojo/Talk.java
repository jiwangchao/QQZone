package com.wangchao.ssm.pojo;

import java.util.Date;

public class Talk {

	private int talkId;
	private int userId;
	private Date talkTime;
	private String talkContent;
	private String talkPic;
	
	private String userName;  //说说所有者
	
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public int getTalkId() {
		return talkId;
	}
	public void setTalkId(int talkId) {
		this.talkId = talkId;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public Date getTalkTime() {
		return talkTime;
	}
	public void setTalkTime(Date talkTime) {
		this.talkTime = talkTime;
	}
	public String getTalkContent() {
		return talkContent;
	}
	public void setTalkContent(String talkContent) {
		this.talkContent = talkContent;
	}
	public String getTalkPic() {
		return talkPic;
	}
	public void setTalkPic(String talkPic) {
		this.talkPic = talkPic;
	}
	
}
