package com.cmwebgame.team.blog.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.cmwebgame.dao.BaseDao;
import com.cmwebgame.team.blog.entity.BlogType;
import com.cmwebgame.team.common.JdbcUtil;

public class BlogTypeDaoImpl extends BaseDao<BlogType> {
	
	
	
	//獲取用戶所有博客類型
	public List<BlogType> getBlogTypeList(Long id) {
		// TODO Auto-generated method stub
		Connection conn = this.getConnection();
		String sql = "select *,(select count(*) from blog b where b.custom_type = cbt.id) as blogcount from custom_blog_type cbt where user_id = ?";
		List<Object> conditions = new ArrayList<Object>();
		conditions.add(id);
		List<BlogType> blogTypes = this.getResultSetByCondition(conn, sql, conditions);
		return blogTypes;
	}

	@Override
	protected Connection getConnection() {
		return JdbcUtil.getConnection();
	}

	@Override
	public void setConnection(Connection arg0) {}
	
	public static void main(String[] args) {
		BlogTypeDaoImpl b = new BlogTypeDaoImpl();
		Connection conn =b.getConnection();
		String sql = "select cbt.id,cbt.name,cbt.user_id,(select count(*) from blog b where b.custom_type = cbt.id) blogcount from custom_blog_type cbt where user_id = ?";
		List<Object> conditions = new ArrayList<Object>();
		conditions.add("2");
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setLong(1, new Long(2));
			rs = pstmt.executeQuery();
			ResultSetMetaData rsmd = rs.getMetaData();
			int re = rsmd.getColumnCount();
			for (int i = 1; i <= re; i++) {
				System.out.println(rsmd.getColumnLabel(i));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
}
