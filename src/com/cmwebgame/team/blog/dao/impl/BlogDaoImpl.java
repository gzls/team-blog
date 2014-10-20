package com.cmwebgame.team.blog.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.cmwebgame.dao.BaseDao;
import com.cmwebgame.team.blog.entity.Blog;
import com.cmwebgame.team.common.JdbcUtil;

public class BlogDaoImpl extends BaseDao<Blog> {

	@Override
	protected Connection getConnection() {
		return JdbcUtil.getConnection();
	}

	@Override
	public void setConnection(Connection arg0) {}
	
	public boolean insert(Blog blog){
		int result = 0;
		try {
			Connection conn = this.getConnection();
			String sql = "insert into blog_blogs (title,content,contentHtml,user_id) values (?,?,?,?)";
			List<Object> conditions = new ArrayList<Object>();
			conditions.add(blog.getTitle());
			conditions.add(blog.getContent());
			conditions.add(blog.getContentHtml());
			conditions.add(blog.getUserId());
			result = this.insert(conn, sql, conditions);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result > 0;
	}
	
	public Blog getBlogById(long id){
		Connection conn = this.getConnection();
		String sql = "select * from blog_blogs where id = ?";
		List<Object> conditions = new ArrayList<Object>();
		conditions.add(id);
		List<Blog> blogs = this.getResultSetByCondition(conn, sql, conditions);
		if (blogs.size() > 0){
			return blogs.get(0);
		}
		return null;
	}
	
	public List<Blog> getBlogsByUser(long userId){
		Connection conn = this.getConnection();
		String sql = "select b.* from blog_blogs b where b.user_id = ?";
		List<Object> conditions = new ArrayList<Object>();
		conditions.add(userId);
		List<Blog> blogs = this.getResultSetByCondition(conn, sql, conditions);
		return blogs;
	}
	
	public boolean deleteBlogById(long id){
		int result = 0;
		Connection conn = this.getConnection();
		PreparedStatement pstmt = null;
		String sql = "delete from blog_blogs where id = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setLong(1, id);
			result = pstmt.executeUpdate();
			pstmt.close();
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result > 0;
	}

	public boolean modifyBlogById(Blog blog){
		Connection conn = this.getConnection();
		String sql = "update blog_blogs set title = ?,content = ?,contentHtml =? where id = ? ";
		List<Object> conditions = new ArrayList<Object>();
		conditions.add(blog.getTitle());
		conditions.add(blog.getContent());
		conditions.add(blog.getContentHtml());
		conditions.add(blog.getId());
		boolean flag = this.modify(conn, sql, conditions);
		return flag;
	}
}
