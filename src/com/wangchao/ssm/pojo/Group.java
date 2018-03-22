package com.wangchao.ssm.pojo;

public class Group {
	private int gId;		//分组id
	private int userId;		//所属用户
	private String gNo;		//所属用户分组号 
	private String gName;	//分组名称
	
	public int getgId() {
		return gId;
	}
	public void setgId(int gId) {
		this.gId = gId;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public String getgNo() {
		return gNo;
	}
	public void setgNo(String gNo) {
		this.gNo = gNo;
	}
	public String getgName() {
		return gName;
	}
	public void setgName(String gName) {
		this.gName = gName;
	}
	
}
