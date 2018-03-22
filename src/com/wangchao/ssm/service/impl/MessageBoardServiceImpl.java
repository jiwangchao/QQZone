package com.wangchao.ssm.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.wangchao.ssm.mapper.MessageBoardMapper;
import com.wangchao.ssm.pojo.MessageBoard;
import com.wangchao.ssm.service.MessageBoardService;

public class MessageBoardServiceImpl implements MessageBoardService {
	
	@Autowired
	private MessageBoardMapper mBoardMapper;

	@Override
	public int sendLeaveMessage(MessageBoard messageBoard) {
		return mBoardMapper.sendLeaveMessage(messageBoard);
	}

	@Override
	public List<MessageBoard> queryMyMessageBoard(int userId) {
		return mBoardMapper.queryMyMessageBoard(userId);
	}

	@Override
	public int getMessageCounts(int userId) {
		return mBoardMapper.getMessageCounts(userId);
	}

}
