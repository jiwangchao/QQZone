package com.wangchao.ssm.service;

import java.util.List;

import com.wangchao.ssm.pojo.Talk;
import com.wangchao.ssm.pojo.User;

public interface TalkService {

	/**
	 * 查询我的历史说说list
	 */
	public List<Talk> queryMyTalkList(User user);

	/**
	 * 添加一条说说记录
	 */
	public int addOneTalk(Talk talk);
	/**
	 * 查询我和我的好友的全部说说
	 */
	public List<Talk> queryAllTalkList(User user);
	
	
}
