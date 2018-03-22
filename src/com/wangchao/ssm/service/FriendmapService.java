package com.wangchao.ssm.service;

import java.util.List;
import java.util.Map;

import com.wangchao.ssm.pojo.Friendmap;

public interface FriendmapService {
	/**
	 * 查找我的好友
	 */
	public List<Friendmap> findMyFriend(int userId);
	/**
	 * 修改指定好友访问空间权限
	 */
	public int updateFriendRight(Map<String, Integer> map);
	/**
	 * 修改好友动态屏蔽
	 */
	public int updateFriendDynamic(Map<String, Integer> map);
	/**
	 * 修改好友特别关心状态
	 */
	public int updateCareStatus(Map<String, Integer> map);
	/**
	 * 添加好友之前先查数据库中是否已经有该好友
	 */
	public Friendmap findVerifyfriend(Map<String, Integer> map);
	/**
	 * 添加好友，发送好友添加请求
	 */
	public int addFriend(Friendmap fm);
	/**
	 * 处理好友添加请求
	 */
	public int updateFriendRequest(Friendmap fm1);
	/**
	 * 移动好友 分组位置
	 */
	public int updateFriendInGroup(Friendmap fm);
	/**
	 * 移动分组之前先查看好友所在分组
	 */
	public String queryFriendInGroup(Friendmap fm);
	/**
	 * 查询好友验证信息
	 */
	public Friendmap viewFriendVerifyInfo(Friendmap fm);
	/**
	 * 修改好友备注
	 */
	public int updateFriendBeiZhu(Friendmap fm);
	/**
	 * 删除好友
	 */
	
	public int deleteFriend(Friendmap fm1);
	/**
	 * 查询好友互动设置,我访问他，查询的是他对我的好友设置
	 */
	public Friendmap queryFriendSetting(Friendmap fm1);
	/**
	 * 更新好友表-访问时间：userId=friendId
	 */
	public int updateFriendLastVisitTime(Friendmap fm3);
	
}
