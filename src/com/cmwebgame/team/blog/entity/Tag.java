package com.cmwebgame.team.blog.entity;

import com.cmwebgame.dao.IdEntity;

/**
 * 博客标签
 * @author YouAndMe
 *
 */
public class Tag extends IdEntity {

	private static final long serialVersionUID = 1L;
	
	private String name;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
}
