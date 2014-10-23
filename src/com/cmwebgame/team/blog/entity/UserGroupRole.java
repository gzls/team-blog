package com.cmwebgame.team.blog.entity;

/**
 * 用户组角色关联
 */
public class UserGroupRole {
	
	private long uid;
	private long groupId;
	private long rid;
	public long getUid() {
		return uid;
	}
	public void setUid(long uid) {
		this.uid = uid;
	}
	public long getGroupId() {
		return groupId;
	}
	public void setGroupId(long groupId) {
		this.groupId = groupId;
	}
	public long getRid() {
		return rid;
	}
	public void setRid(long rid) {
		this.rid = rid;
	}
}
