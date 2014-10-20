package com.cmwebgame.team.blog.entity;

import java.sql.Timestamp;

import com.cmwebgame.dao.IdEntity;

/**
 * Blog類，暫用於測試
 * 
 * @author YouAndMe
 * 
 */
public class Blog extends IdEntity {

	private static final long serialVersionUID = 1L;
	private String title;
	private String content;
	private String contentHtml;
	private Timestamp createDate;
	private long userId;

	public Blog() {
	}

	public Blog(long id, String title, String content, String contentHtml,
			Timestamp createDate) {
		this.id = id;
		this.title = title;
		this.content = content;
		this.contentHtml = contentHtml;
		this.createDate = createDate;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Timestamp getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Timestamp createDate) {
		this.createDate = createDate;
	}

	public String getContentHtml() {
		return contentHtml;
	}

	public void setContentHtml(String contentHtml) {
		this.contentHtml = contentHtml;
	}

	public long getUserId() {
		return userId;
	}

	public void setUserId(long userId) {
		this.userId = userId;
	}
}
