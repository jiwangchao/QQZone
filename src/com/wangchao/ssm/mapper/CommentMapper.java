package com.wangchao.ssm.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.wangchao.ssm.pojo.Comment;

public interface CommentMapper {

	int addComment(Comment comment);

	List<Comment> queryCommentList(Comment comment);

	int deleteComment(@Param(value="commentId")String commentId);

	
}
