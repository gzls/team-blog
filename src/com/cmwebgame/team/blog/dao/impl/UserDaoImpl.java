package com.cmwebgame.team.blog.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;

import com.cmwebgame.dao.BaseDao;
import com.cmwebgame.team.blog.entity.User;
import com.cmwebgame.team.blog.entity.UserGroupRole;
import com.cmwebgame.team.blog.util.MD5;
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
		String sql = "select * from user where login_name = ? or email = ?";
		List<Object> conditions = new ArrayList<Object>();
		conditions.add(username);
		conditions.add(username);
		List<User> users =  this.getResultSetByCondition(conn, sql, conditions);
		User user = null;
		try {
			user = users.get(0);
			if (user != null && user.getPassword().equals(MD5.crypt(password))){
				//更新
				user.setLastLogin(new Timestamp(System.currentTimeMillis()));
				user.setLoginCount(user.getLoginCount() + 1);
				this.updateLogin(user);
				return user;
			}
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return null;
	}
	
	//更新用戶登錄後 最後登錄時間和登錄次數
	private void updateLogin(User user) {
		Connection conn = getConnection();
		String sql = "update user set last_login = ?,login_count=? where id = ?";
		List<Object> conditions = new ArrayList<Object>();
		conditions.add(user.getLastLogin());
		conditions.add(user.getLoginCount());
		conditions.add(user.getId());
		this.modify(conn,sql,conditions);
	}

	//插入用户记录
	public int insertUser(User user){
		//獲取連接
		Connection conn = this.getConnection();
		int result = 0;
		try {
			String sql = "insert into user (login_name,nickname,password,email) values (?,?,?,?)";
			List<Object> conditions = new ArrayList<Object>();
			conditions.add(user.getLoginName());
			conditions.add(user.getNickName());
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
		String sql = "select * from user where 1=1";
		List<Object> conditions = new ArrayList<Object>();
		if (param instanceof Long){
			sql += " and id = ?";
		} else if (param instanceof String) {
			sql += " and login_name = ?";
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
		String sql = "select count(*) from user where 1=1";
		try {
			if (StringUtils.isNotBlank(username)){
				sql += " and login_name = ?";
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
		String sql = "update user set password = ? where id = ?";
		List<Object> conditions = new ArrayList<Object>();
		conditions.add(user.getPassword());
		conditions.add(user.getId());
		return this.modify(conn, sql, conditions);
	}
	
	//存储用户-组-角色信息
	public boolean insertUserGroupRole(UserGroupRole ugr){
		//獲取連接
		Connection conn = this.getConnection();
		PreparedStatement pstmt = null;
		int result = 0;
		try {
			List<Object> conditions = new ArrayList<Object>();
			conditions.add(ugr.getUid());
			conditions.add(ugr.getGroupId());
			conditions.add(ugr.getRid());
			String sql = "insert into user_group_role (uid,group_id,rid) values (?,?,?)";
			
			//表无主键，采用原始方法。
			pstmt = conn.prepareStatement(sql);
			pstmt.setLong(1, ugr.getUid());
			pstmt.setLong(2, ugr.getGroupId());
			pstmt.setLong(3, ugr.getRid());
			
			//结果
			result = pstmt.executeUpdate();
		} catch (Exception e){
			e.printStackTrace();
			result = -1;
		} finally {
			JdbcUtil.close(conn, pstmt, null);
		}
		System.out.println("insert user_group_role result : " + (result > 0));
		return result > 0;
	}

}
