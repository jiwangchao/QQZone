package com.wangchao.ssm.pojo;

import java.util.Date;

public class DiaryContent {

	private String diaryContentId;		//日志主键Id 十里春风，风华醉透
	private String diaryContentTitle;	//标题
	private String diaryContentText;	//内容
	private Date diaryContentTime;		//创建时间
	private String diaryBg; 			//日志背景
	
	private int userId;				//日志所属用户
	
	public String getDiaryContentId() {
		return diaryContentId;
	}
	public void setDiaryContentId(String diaryContentId) {
		this.diaryContentId = diaryContentId;
	}
	public String getDiaryContentTitle() {
		return diaryContentTitle;
	}
	public void setDiaryContentTitle(String diaryContentTitle) {
		this.diaryContentTitle = diaryContentTitle;
	}
	public String getDiaryContentText() {
		return diaryContentText;
	}
	public void setDiaryContentText(String diaryContentText) {
		this.diaryContentText = diaryContentText;
	}
	public Date getDiaryContentTime() {
		return diaryContentTime;
	}
	public void setDiaryContentTime(Date diaryContentTime) {
		this.diaryContentTime = diaryContentTime;
	}
	public String getDiaryBg() {
		return diaryBg;
	}
	public void setDiaryBg(String diaryBg) {
		this.diaryBg = diaryBg;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	
	
}
