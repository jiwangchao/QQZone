package com.wangchao.ssm.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.wangchao.ssm.pojo.MessageBoard;

public interface MessageBoardMapper {

	int sendLeaveMessage(MessageBoard messageBoard);

	List<MessageBoard> queryMyMessageBoard(@Param("userId")int userId);

	int getMessageCounts(@Param("userId")int userId);

}
