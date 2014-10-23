package com.cmwebgame.team.blog.entity;

import java.sql.Timestamp;

import com.cmwebgame.dao.IdEntity;

/**
 * 工作日志评论
 * @author YouAndMe
 *
 */
public class WorkDiaryComment extends IdEntity {

	private static final long serialVersionUID = 1L;
	
	private long diaryId;
	private Timestamp commentTime;
	private long authorId;
	private String content;
	
	public long getDiaryId() {
		return diaryId;
	}
	public void setDiaryId(long diaryId) {
		this.diaryId = diaryId;
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
