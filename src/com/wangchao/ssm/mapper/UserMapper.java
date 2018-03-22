package com.wangchao.ssm.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.wangchao.ssm.pojo.User;

public interface UserMapper {
	
	public List<User> findUserList();
	
	public User findUserById(Integer id);
	
	public int updateUserById(User user);
	
	//登录查询
	public User findUserByUserAccountAndPassword(User user);
	//更新最新登录时间
	public int updateUserLastLoginTime(User user);
	//根据QQ账号查找QQ好友
	public List<User> finduserListByAccount(String searchQQ);
	//根据QQ昵称查找QQ好友
	public List<User> finduserListByName(String searchQQ);
	//查找用户详细信息
	public User viewFriendDetails(int userId);
	//根据好友id的list集合查找userlist
	public List<User> findUserListByUserIds(@Param("friendsIds")List<Integer> friendsIds);
	//注册新用户
	public int addOneUser(User user);
}
