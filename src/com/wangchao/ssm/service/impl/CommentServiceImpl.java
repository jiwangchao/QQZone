package com.wangchao.ssm.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.wangchao.ssm.mapper.CommentMapper;
import com.wangchao.ssm.pojo.Comment;
import com.wangchao.ssm.service.CommentService;

public class CommentServiceImpl implements CommentService {

	@Autowired
	private CommentMapper commentMapper;
	
	@Override
	public int addComment(Comment comment) {
		return commentMapper.addComment(comment);
	}

	@Override
	public List<Comment> queryCommentList(Comment comment) {
		return commentMapper.queryCommentList(comment);
	}

	@Override
	public int deleteComment(String commentId) {
		return commentMapper.deleteComment(commentId);
	}

}
