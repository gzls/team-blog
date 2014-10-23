package com.cmwebgame.team.blog.entity;

import com.cmwebgame.dao.IdEntity;
/**
 * 操作日志
 * @author YouAndMe
 *
 */
public class Log extends IdEntity {

	private static final long serialVersionUID = 1L;

	private long uid;
	private String content;
	public long getUid() {
		return uid;
	}
	public void setUid(long uid) {
		this.uid = uid;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
}
