package com.wangchao.ssm.service;

import java.util.List;
import java.util.Set;

import com.wangchao.ssm.pojo.User;

/**
 * @author 吉王超
 * @date 2016年12月21日 下午4:22:29
 * @Description 用户管理service
 */
public interface UserService {

	//用户查询接口
	public List<User> findUserList();
	//根据id查询用户
	public User findUserById(Integer id);
	//根据id更新用户
	public int updateUserById(User user);
	
	
	//用户登录
	public User findUserByUserAccountAndPassword(User user);
	//更新用户最新登录时间
	public int updateUserLastLoginTime(User user1);
	/**
	 * 根据qq账户查找QQ
	 */
	public List<User> finduserListByAccount(String searchQQ);
	/**
	 * 根据QQ昵称查找QQ
	 */
	public List<User> finduserListByName(String searchQQ);
	/**
	 * 根据QQ用户id查找用户详细信息
	 */
	public User viewFriendDetails(int userId);
	/**
	 * 根据好友id的listt集合查找userlist
	 */
	public List<User> findUserListByUserIds(List<Integer> friendsIds);
	/**
	 * 注册新用户
	 */
	public int addOneUser(User user);
}
