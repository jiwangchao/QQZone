package com.wangchao.ssm.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.wangchao.ssm.mapper.GroupMapper;
import com.wangchao.ssm.pojo.Group;
import com.wangchao.ssm.service.GroupService;

public class GroupServiceImpl implements GroupService {
	
	@Autowired
	private GroupMapper groupMapper;
	
	@Override
	public List<Group> findMyGroup(int userId) {
		return groupMapper.findMyGroup(userId);
	}

	@Override
	public int addOneGroup(Group group) {
		return groupMapper.addOneGroup(group);
	}

	@Override
	public int updateGroupName(Group group) {
		return groupMapper.updateGroupName(group);
	}

}
