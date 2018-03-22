package com.wangchao.ssm.pojo;

import java.util.Date;

public class Friendmap {
	private int friendmapId;
	private int userId;
	private int friendId;
	private int status;			//好友状态：0.申请添加好友,等待验证；1.通过验证，添加成功；2.拒绝添加；3.删除；4.待验证
	private String verifyInfo;	//添加好友时输入：验证信息
	private Date addTime;
	private String beiZhu;		//好友备注，默认备注用户昵称
	private Date lastVisitTime;	//最近访问时间
	private int allowVisited;	//允许访问我的空间：	0允许，1不允许
	private int hideDynamic;	//隐藏他的动态：		0：是，1：否
	private int careStatus; 	//特表关心：0：是，1：否
	private String gNo;			//所属用户好友分组号
	
	public int getFriendmapId() {
		return friendmapId;
	}
	public void setFriendmapId(int friendmapId) {
		this.friendmapId = friendmapId;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public int getFriendId() {
		return friendId;
	}
	public void setFriendId(int friendId) {
		this.friendId = friendId;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public String getVerifyInfo() {
		return verifyInfo;
	}
	public void setVerifyInfo(String verifyInfo) {
		this.verifyInfo = verifyInfo;
	}
	public Date getAddTime() {
		return addTime;
	}
	public void setAddTime(Date addTime) {
		this.addTime = addTime;
	}
	public String getBeiZhu() {
		return beiZhu;
	}
	public void setBeiZhu(String beiZhu) {
		this.beiZhu = beiZhu;
	}
	public Date getLastVisitTime() {
		return lastVisitTime;
	}
	public void setLastVisitTime(Date lastVisitTime) {
		this.lastVisitTime = lastVisitTime;
	}
	public int getAllowVisited() {
		return allowVisited;
	}
	public void setAllowVisited(int allowVisited) {
		this.allowVisited = allowVisited;
	}
	public int getHideDynamic() {
		return hideDynamic;
	}
	public void setHideDynamic(int hideDynamic) {
		this.hideDynamic = hideDynamic;
	}
	public int getCareStatus() {
		return careStatus;
	}
	public void setCareStatus(int careStatus) {
		this.careStatus = careStatus;
	}
	public String getgNo() {
		return gNo;
	}
	public void setgNo(String gNo) {
		this.gNo = gNo;
	}
	
}
