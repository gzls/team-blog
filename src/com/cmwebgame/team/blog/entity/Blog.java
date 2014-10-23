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
	private Timestamp publishTime;
	private Timestamp modifyTime;
	private long authorId;
	private long customType;
	private long moduleType;

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

	public long getCustomType() {
		return customType;
	}

	public void setCustomType(long customType) {
		this.customType = customType;
	}
	
	public Blog() {
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


	public String getContentHtml() {
		return contentHtml;
	}

	public void setContentHtml(String contentHtml) {
		this.contentHtml = contentHtml;
	}

	public long getModuleType() {
		return moduleType;
	}

	public void setModuleType(long moduleType) {
		this.moduleType = moduleType;
	}

}
