package com.cmwebgame.team.blog.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.cmwebgame.dao.BaseDao;
import com.cmwebgame.team.blog.entity.User;
import com.cmwebgame.team.common.JdbcUtil;

public class UserDaoImpl extends BaseDao<User> {

	@Override
	protected Connection getConnection() {
		return JdbcUtil.getConnection();
	}

	@Override
	public void setConnection(Connection arg0) {}
	
	public User login(String username,String password) {
		Connection conn = this.getConnection();
		String sql = "select * from blog_users where username = ? or email = ?";
		List<Object> conditions = new ArrayList<Object>();
		conditions.add(username);
		conditions.add(username);
		List<User> users =  this.getResultSetByCondition(conn, sql, conditions);
		User user = null;
		try {
			user = users.get(0);
			if (user != null && user.getPassword().equals(password)){
				return user;
			}
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return null;
	}
	
	//插入用户记录
	public int insert(User user){
		//獲取連接
		Connection conn = this.getConnection();
		int result = 0;
		try {
			String sql = "insert into blog_users (username,password,email) values (?,?,?)";
			List<Object> conditions = new ArrayList<Object>();
			conditions.add(user.getUsername());
			conditions.add(user.getPassword());
			conditions.add(user.getEmail());
			result = this.insert(conn, sql, conditions);
		} catch (Exception e) {
			e.printStackTrace();
			result = -1;
		}
		return result;
	}
	
	//根据用户ID或者名字查找
	public User getUserByIdOrName(Object param){
		Connection conn = this.getConnection();
		String sql = "select * from blog_users where 1=1";
		List<Object> conditions = new ArrayList<Object>();
		if (param instanceof Long){
			sql += " and id = ?";
		} else if (param instanceof String) {
			sql += " and username = ?";
		}else {
			return null;//不处理其他类型。
		}
		conditions.add(param);
		List<User> users = this.getResultSetByCondition(conn, sql, conditions);
		if (users.size() > 0){
			return users.get(0);
		}
		return null;
	}

	public boolean getUserByNameOrEmail(String username ,String email) {
		ResultSet rs = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		int result = 0;
		String sql = "select count(*) from blog_users where 1=1";
		try {
			if (StringUtils.isNotBlank(username)){
				sql += " and username = ?";
			}
			if (StringUtils.isNotBlank(email)){
				sql += " and email = ?";
			}
			conn = this.getConnection();
			pstmt = conn.prepareStatement(sql);
			if (StringUtils.isNotBlank(username)){
				pstmt.setString(1, username);
			}
			if (StringUtils.isNotBlank(email)){
				pstmt.setString(1, email);
			}
			rs = pstmt.executeQuery();
			if (rs.next()){
				result = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JdbcUtil.close(conn, pstmt, rs);
		}
		return result > 0;
	}

	public boolean changerPwd(User user) {
		Connection conn = getConnection();
		String sql = "update blog_users set password = ? where id = ?";
		List<Object> conditions = new ArrayList<Object>();
		conditions.add(user.getPassword());
		conditions.add(user.getId());
		return this.modify(conn, sql, conditions);
	}
	
}
