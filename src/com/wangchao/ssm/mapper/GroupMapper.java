package com.wangchao.ssm.mapper;

import java.util.List;

import com.wangchao.ssm.pojo.Group;

public interface GroupMapper {
	
	/**
	 * 查询我的所有好友分组
	 */
	public List<Group> findMyGroup(int userId);

	public int addOneGroup(Group group);

	public int updateGroupName(Group group);
}
