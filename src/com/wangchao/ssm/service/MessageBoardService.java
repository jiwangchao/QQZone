package com.wangchao.ssm.service;

import java.util.List;

import com.wangchao.ssm.pojo.MessageBoard;

public interface MessageBoardService {
	/**
	 * 发表留言
	 */
	public int sendLeaveMessage(MessageBoard messageBoard);

	/**
	 * 查看留言板
	 */
	public List<MessageBoard> queryMyMessageBoard(int userId);
	
	/**
	 * 查询留言板总记录数
	 */
	public int getMessageCounts(int userId);
}
