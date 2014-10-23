package com.cmwebgame.team.blog.entity;

import java.sql.Timestamp;

import com.cmwebgame.dao.IdEntity;

/**
 * 工作日志
 * @author YouAndMe
 *
 */
public class WorkDiary extends IdEntity {

	private static final long serialVersionUID = 1L;
	
	private String content;
	private String contentHtml;
	private Timestamp publishTime;
	private Timestamp modifyTime;
	private long authorId;
	
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getContentHtml() {
		return contentHtml;
	}
	public void setContentHtml(String contentHtml) {
		this.contentHtml = contentHtml;
	}
	public Timestamp getPublishTime() {
		return publishTime;
	}
	public void setPublishTime(Timestamp publishTime) {
		this.publishTime = publishTime;
	}
	public Timestamp getModifyTime() {
		return modifyTime;
	}
	public void setModifyTime(Timestamp modifyTime) {
		this.modifyTime = modifyTime;
	}
	public long getAuthorId() {
		return authorId;
	}
	public void setAuthorId(long authorId) {
		this.authorId = authorId;
	}
	
}
