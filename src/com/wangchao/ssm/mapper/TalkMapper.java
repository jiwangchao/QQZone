package com.wangchao.ssm.mapper;

import java.util.List;

import com.wangchao.ssm.pojo.Talk;
import com.wangchao.ssm.pojo.User;

public interface TalkMapper {

	/**
	 * 查询我的说说list
	 */
	public List<Talk> queryMyTalkList(User user);
	/**
	 * 添加一条说说
	 */
	public int addOneTalk(Talk talk);
	/**
	 * 个人中心-查询我和我的好友说说
	 */
	public List<Talk> queryAllTalkList(User user);
}
