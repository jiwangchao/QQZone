package com.wangchao.ssm.pojo;

public class Comment {

	private String commentId;		//评论表主键Id
	private int cUserId;			//评论者id
	private int aUserId;			//被评论的主人id
	private int commentType;		//评论类型：0：说说，1：日志
	private String commentTypeId;		//评论类型的主键Id：说说：说说表主键Id，日志：日志表主键Id
	private String commentContent;	//评论内容
	private String commentTime;		//评论时间
	
	private String userName;		//评论者昵称
	
	public String getCommentId() {
		return commentId;
	}
	public void setCommentId(String commentId) {
		this.commentId = commentId;
	}
	public int getcUserId() {
		return cUserId;
	}
	public void setcUserId(int cUserId) {
		this.cUserId = cUserId;
	}
	public int getaUserId() {
		return aUserId;
	}
	public void setaUserId(int aUserId) {
		this.aUserId = aUserId;
	}
	public String getCommentTypeId() {
		return commentTypeId;
	}
	public void setCommentTypeId(String commentTypeId) {
		this.commentTypeId = commentTypeId;
	}
	public int getCommentType() {
		return commentType;
	}
	public void setCommentType(int commentType) {
		this.commentType = commentType;
	}
	public String getCommentContent() {
		return commentContent;
	}
	public void setCommentContent(String commentContent) {
		this.commentContent = commentContent;
	}
	public String getCommentTime() {
		return commentTime;
	}
	public void setCommentTime(String commentTime) {
		this.commentTime = commentTime;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	
	
}
