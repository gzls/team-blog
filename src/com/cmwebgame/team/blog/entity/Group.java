package com.cmwebgame.team.blog.entity;

import com.cmwebgame.dao.IdEntity;

/**
 * 用户组
 * @author YouAndMe
 *
 */
public class Group extends IdEntity {

	private static final long serialVersionUID = 1L;

	private String name;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
}
