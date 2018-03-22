package com.wangchao.ssm.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.wangchao.ssm.mapper.TalkMapper;
import com.wangchao.ssm.pojo.Talk;
import com.wangchao.ssm.pojo.User;
import com.wangchao.ssm.service.TalkService;

public class TalkServiceImpl implements TalkService {

	@Autowired
	private TalkMapper talkMapper;
	
	@Override
	public List<Talk> queryMyTalkList(User user) {
		return talkMapper.queryMyTalkList(user);
	}

	@Override
	public int addOneTalk(Talk talk) {
		return talkMapper.addOneTalk(talk);
	}

	@Override
	public List<Talk> queryAllTalkList(User user) {
		return talkMapper.queryAllTalkList(user);
	}

}
