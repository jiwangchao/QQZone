package com.wangchao.ssm.service.impl;

import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;

import com.wangchao.ssm.mapper.UserMapper;
import com.wangchao.ssm.pojo.User;
import com.wangchao.ssm.service.UserService;

/**
 * @author 吉王超
 * @date 2016年12月21日 下午4:27:47
 * @Description UserService接口的实现类
 */
public class UserServiceImpl implements UserService {

	@Autowired
	private UserMapper userMapper;

	@Override
	public List<User> findUserList() {
		return userMapper.findUserList();
	}

	@Override
	public User findUserById(Integer id) {
		return userMapper.findUserById(id);
	}

	@Override
	public int updateUserById(User user) {
		return userMapper.updateUserById(user);
	}

	@Override
	public User findUserByUserAccountAndPassword(User user) {
		return userMapper.findUserByUserAccountAndPassword(user);
	}

	@Override
	public int updateUserLastLoginTime(User user1) {
		return userMapper.updateUserLastLoginTime(user1);
	}

	@Override
	public List<User> finduserListByAccount(String searchQQ) {
		return userMapper.finduserListByAccount(searchQQ);
	}

	@Override
	public List<User> finduserListByName(String searchQQ) {
		return userMapper.finduserListByName(searchQQ);
	}

	@Override
	public User viewFriendDetails(int userId) {
		return userMapper.viewFriendDetails(userId);
	}

	@Override
	public List<User> findUserListByUserIds(List<Integer> friendsIds) {
		return userMapper.findUserListByUserIds(friendsIds);
	}

	@Override
	public int addOneUser(User user) {
		return userMapper.addOneUser(user);
	}

}
