package com.cmwebgame.team.blog.entity;

import java.sql.Timestamp;

import com.cmwebgame.dao.IdEntity;

/**
 * 博客评论
 * @author YouAndMe
 *
 */
public class BlogComment extends IdEntity {
	
	private static final long serialVersionUID = 1L;
	
	private long blogId;
	private Timestamp commentTime;
	private long authorId;
	private String content;
	
	public long getBlogId() {
		return blogId;
	}
	public void setBlogId(long blogId) {
		this.blogId = blogId;
	}
	public Timestamp getCommentTime() {
		return commentTime;
	}
	public void setCommentTime(Timestamp commentTime) {
		this.commentTime = commentTime;
	}
	public long getAuthorId() {
		return authorId;
	}
	public void setAuthorId(long authorId) {
		this.authorId = authorId;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
}
