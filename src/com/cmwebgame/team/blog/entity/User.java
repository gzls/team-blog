package com.cmwebgame.team.blog.entity;

import java.sql.Timestamp;

import com.cmwebgame.dao.IdEntity;

/**
 * 用户类
 * @author YouAndMe
 *
 */
public class User extends IdEntity {

	private static final long serialVersionUID = 1L;
	private String loginName;
	private int gender;
	private String password;
	private String email;
	private String nickName;
	private String sign;
	private String icon;
	private Timestamp createTime;
	private Timestamp lastLogin;
	private long loginCount;
	private int status;
	public String getLoginName() {
		return loginName;
	}
	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}
	public int getGender() {
		return gender;
	}
	public void setGender(int gender) {
		this.gender = gender;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public String getSign() {
		return sign;
	}
	public void setSign(String sign) {
		this.sign = sign;
	}
	public String getIcon() {
		return icon;
	}
	public void setIcon(String icon) {
		this.icon = icon;
	}
	public Timestamp getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Timestamp createTime) {
		this.createTime = createTime;
	}
	public Timestamp getLastLogin() {
		return lastLogin;
	}
	public void setLastLogin(Timestamp lastLogin) {
		this.lastLogin = lastLogin;
	}
	public long getLoginCount() {
		return loginCount;
	}
	public void setLoginCount(long loginCount) {
		this.loginCount = loginCount;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}

}
