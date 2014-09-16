package com.cmwebgame.team.demo;

import java.sql.Timestamp;

public class User {
	
	private long id;
	private String name;
	private Timestamp createTime;
	
	public User(){}
	public User(long long1, String string, Timestamp timestamp) {
		this.id = long1;
		this.name = string;
		this.createTime = timestamp;
	}
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Timestamp getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Timestamp createTime) {
		this.createTime = createTime;
	}
}
