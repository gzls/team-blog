package com.cmwebgame.team.blog.entity;

import com.cmwebgame.dao.IdEntity;

/**
 * 博客类型
 * @author YouAndMe
 *
 */
public class BlogType extends IdEntity {

	private static final long serialVersionUID = 1L;
	
	private long userId;
	private String name;
	private int blogcount;
	public long getUserId() {
		return userId;
	}
	public void setUserId(long userId) {
		this.userId = userId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getBlogcount() {
		return blogcount;
	}
	public void setBlogcount(int blogcount) {
		this.blogcount = blogcount;
	}
	
}
