package com.cmwebgame.team.blog.entity;

import java.sql.Timestamp;

/**
 * Blog類，暫用於測試
 * @author YouAndMe
 *
 */
public class Blog {
	
	private long id;
	private String title;
	private String content;
	private String contentText;
	private Timestamp time;
	
	public Blog(){}
	
	public Blog(long id,String title,String content,String contentText,Timestamp time){
		this.id = id;
		this.title = title;
		this.content = content;
		this.contentText = contentText;
		this.time = time;
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
	public Timestamp getTime() {
		return time;
	}
	public void setTime(Timestamp time) {
		this.time = time;
	}

	public String getContentText() {
		return contentText;
	}

	public void setContentText(String contentText) {
		this.contentText = contentText;
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}
}
