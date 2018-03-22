package com.wangchao.ssm.pojo;

import java.util.Date;

public class Diary {

	private int diaryId;
	private int userId;
	private Date diaryTime;
	private String diaryContentId;
	private String diaryContentTitle;
	
	public int getDiaryId() {
		return diaryId;
	}
	public void setDiaryId(int diaryId) {
		this.diaryId = diaryId;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public Date getDiaryTime() {
		return diaryTime;
	}
	public void setDiaryTime(Date diaryTime) {
		this.diaryTime = diaryTime;
	}
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
	
}
