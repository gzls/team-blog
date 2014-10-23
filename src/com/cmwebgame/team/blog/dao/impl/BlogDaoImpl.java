package com.cmwebgame.team.blog.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.cmwebgame.dao.BaseDao;
import com.cmwebgame.team.blog.entity.Blog;
import com.cmwebgame.team.blog.entity.BlogType;
import com.cmwebgame.team.common.JdbcUtil;

public class BlogDaoImpl extends BaseDao<Blog> {

	@Override
	protected Connection getConnection() {
		return JdbcUtil.getConnection();
	}

	@Override
	public void setConnection(Connection arg0) {}
	
	public boolean saveOrUpdate(Blog blog){
		boolean result = false;
		Connection conn = this.getConnection();
		String sql = "";
		List<Object> conditions = new ArrayList<Object>();
		try {
			if (blog.getId() == null){
				sql = "insert into blog (title,content,contentHtml,author_id,custom_type) values (?,?,?,?,?)";
				conditions.add(blog.getTitle());
				conditions.add(blog.getContent());
				conditions.add(blog.getContentHtml());
				conditions.add(blog.getAuthorId());
				conditions.add(blog.getCustomType());
				result = this.insert(conn, sql, conditions) > 0;
			}else{
				sql = "update blog set title = ?,content = ?,contentHtml =?,custom_type=?,modify_time=? where id = ? ";
				conditions.add(blog.getTitle());
				conditions.add(blog.getContent());
				conditions.add(blog.getContentHtml());
				conditions.add(blog.getCustomType());
				conditions.add(new Timestamp(System.currentTimeMillis()));
				conditions.add(blog.getId());
				result = this.modify(conn, sql, conditions);
			}
		} catch (Exception e){
			result = false;
			e.printStackTrace();
		}
		
		return result;
	}
	
	public Blog getBlogById(long id){
		Connection conn = this.getConnection();
		String sql = "select * from blog where id = ?";
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
		String sql = "select * from blog where author_id = ?";
		List<Object> conditions = new ArrayList<Object>();
		conditions.add(userId);
		List<Blog> blogs = this.getResultSetByCondition(conn, sql, conditions);
		return blogs;
	}
	
	public boolean deleteBlogById(long id){
		int result = 0;
		Connection conn = this.getConnection();
		PreparedStatement pstmt = null;
		String sql = "delete from blog where id = ?";
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

	//新增用户博客类型
	public int addUserBlogType(BlogType blogType) {
		Connection conn = this.getConnection();
		int result = 0;
		try {
			String sql = "insert into custom_blog_type (user_id,name) values (?,?)";
			List<Object> conditions = new ArrayList<Object>();
			conditions.add(blogType.getUserId());
			conditions.add(blogType.getName());
			result = this.insert(conn, sql, conditions);
		} catch (Exception e){
			result = -1;
			e.printStackTrace();
		}
		return result;
	}
	//檢測用戶是否有此分類
	public boolean checkUserBlogType(BlogType blogType) {
		Connection conn = this.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int result = 0;
		try {
			String sql = "select count(*) from custom_blog_type cbt where cbt.user_id = ? and cbt.name = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setLong(1, blogType.getUserId());
			pstmt.setString(2, blogType.getName());
			rs = pstmt.executeQuery();
			if (rs.next()){
				result = rs.getInt(1);
			}
		} catch (Exception e){
			result = -1;
			e.printStackTrace();
		} finally {
			JdbcUtil.close(conn, pstmt, rs);
		}
		
		return result > 0;
	}
	
}
