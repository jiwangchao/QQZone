package com.wangchao.ssm.pojo;

import java.util.Date;

public class MessageBoard {
	private int messageId;
	private int leaveId;	//留言的用户
	private int masterId;	//被留言的主人
	private String messageContent;
	private Date messageTime;
	
	private String userName;	//留言者名字
	
	public int getMessageId() {
		return messageId;
	}
	public void setMessageId(int messageId) {
		this.messageId = messageId;
	}
	public int getLeaveId() {
		return leaveId;
	}
	public void setLeaveId(int leaveId) {
		this.leaveId = leaveId;
	}
	public int getMasterId() {
		return masterId;
	}
	public void setMasterId(int masterId) {
		this.masterId = masterId;
	}
	public String getMessageContent() {
		return messageContent;
	}
	public void setMessageContent(String messageContent) {
		this.messageContent = messageContent;
	}
	public Date getMessageTime() {
		return messageTime;
	}
	public void setMessageTime(Date messageTime) {
		this.messageTime = messageTime;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	
}
