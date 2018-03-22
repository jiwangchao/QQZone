package com.wangchao.ssm.service;

import java.util.List;

import com.wangchao.ssm.pojo.Comment;

public interface CommentService {

	int addComment(Comment comment);
	
	List<Comment> queryCommentList(Comment comment);

	int deleteComment(String commentId);

}
