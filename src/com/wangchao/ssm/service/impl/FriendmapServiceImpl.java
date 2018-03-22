package com.wangchao.ssm.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;

import com.wangchao.ssm.mapper.FriendmapMapper;
import com.wangchao.ssm.pojo.Friendmap;
import com.wangchao.ssm.service.FriendmapService;

public class FriendmapServiceImpl implements FriendmapService {
	
	@Autowired
	private FriendmapMapper friendmapMapper;
	
	@Override
	public List<Friendmap> findMyFriend(int userId) {
		return friendmapMapper.findMyFriend(userId);
	}

	@Override
	public int updateFriendRight(Map<String, Integer> map) {
		return friendmapMapper.updateFriendRight(map);
	}

	@Override
	public int updateFriendDynamic(Map<String, Integer> map) {
		return friendmapMapper.updateFriendDynamic(map);
	}

	@Override
	public int updateCareStatus(Map<String, Integer> map) {
		return friendmapMapper.updateCareStatus(map);
	}

	@Override
	public int addFriend(Friendmap fm) {
		return friendmapMapper.addFriend(fm);
	}

	@Override
	public Friendmap findVerifyfriend(Map<String, Integer> map) {
		return friendmapMapper.findVerifyfriend(map);
	}

	@Override
	public int updateFriendRequest(Friendmap fm1) {
		return friendmapMapper.updateFriendRequest(fm1);
	}

	@Override
	public int updateFriendInGroup(Friendmap fm) {
		return friendmapMapper.updateFriendInGroup(fm);
	}

	@Override
	public String queryFriendInGroup(Friendmap fm) {
		return friendmapMapper.queryFriendInGroup(fm);
	}

	@Override
	public Friendmap viewFriendVerifyInfo(Friendmap fm) {
		return friendmapMapper.viewFriendVerifyInfo(fm);
	}

	@Override
	public int updateFriendBeiZhu(Friendmap fm) {
		return friendmapMapper.updateFriendBeiZhu(fm);
	}

	@Override
	public int deleteFriend(Friendmap fm) {
		return friendmapMapper.deleteFriend(fm);
	}

	@Override
	public Friendmap queryFriendSetting(Friendmap fm) {
		return friendmapMapper.queryFriendSetting(fm);
	}

	@Override
	public int updateFriendLastVisitTime(Friendmap fm) {
		return friendmapMapper.updateFriendLastVisitTime(fm);
	}


}
