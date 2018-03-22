package com.wangchao.ssm.service;

import com.wangchao.ssm.pojo.Group;

import java.util.List;

public interface GroupService {

	/**
	 * 查找我的全部好友分组
	 */
	public List<Group> findMyGroup(int userId);

	public int addOneGroup(Group group);

	public int updateGroupName(Group group);
}
