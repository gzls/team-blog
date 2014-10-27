package com.cmwebgame.team.blog.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.cmwebgame.dao.BaseDao;
import com.cmwebgame.team.blog.entity.Blog;
import com.cmwebgame.team.blog.entity.BlogType;
import com.cmwebgame.team.blog.util.PageBean;
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
	
	/**
	 * 根據用戶id分頁展示相對應Blog信息
	 * @param userId
	 * @return
	 */
	public List<Blog> getBlogsByUserAndPage(long userId,PageBean pageBean){
		Connection conn = this.getConnection();
		List<Object> conditions = new ArrayList<Object>();
		conditions.add(userId);
		//查詢總條數
		String countSql = "select count(*) from blog where author_id = ?";
		int totalCount = JdbcUtil.getResultCount(conn, countSql, conditions);
		pageBean.setTotalCount(totalCount);
		//查詢分頁數據
		conn = this.getConnection();//查詢count時連接被關，重新獲取
		String sql = "select * from blog where author_id = ? limit ?,?";
		conditions.add(pageBean.getStart());
		conditions.add(pageBean.getPageSize());
		List<Blog> blogs = this.getResultSetByCondition(conn, sql, conditions);
		if (blogs.size() == 0){
			pageBean.setPage(1);
		}
		return blogs;
	}
	
	
	/**
	 * 根據用戶ID，博客類型 查詢對應博客
	 * @param blog
	 * @param pageBean
	 * @return
	 */
	public List<Blog> getBlogsByBlogAndPage(Blog blog,PageBean pageBean){
		Connection conn = this.getConnection();
		List<Object> conditions = new ArrayList<Object>();
		conditions.add(blog.getAuthorId());
		//查詢總條數
		String countSql = "select count(*) from blog where author_id = ?";
		String sql = "select * from blog where author_id = ? ";
	
		if (blog.getCustomType() != 0){
			countSql += " and custom_type = ?";
			sql += "  and custom_type = ?";
			conditions.add(blog.getCustomType());
		}
		sql += " limit ?,?";
		
		System.out.println("sql:" + sql);
		System.out.println("countsql:" + countSql);
		
		int totalCount = JdbcUtil.getResultCount(conn, countSql, conditions);
		pageBean.setTotalCount(totalCount);
		//查詢分頁數據
		conn = this.getConnection();//查詢count時連接被關，重新獲取
		conditions.add(pageBean.getStart());
		conditions.add(pageBean.getPageSize());
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
		List<Object> conditions = new ArrayList<Object>();
		int result = 0;
		try {
			String sql = "select count(*) from custom_blog_type cbt where cbt.user_id = ? and cbt.name = ?";
			conditions.add(blogType.getUserId());
			conditions.add(blogType.getName());
			result = JdbcUtil.getResultCount(conn, sql, conditions);
		} catch (Exception e){
			result = -1;
			e.printStackTrace();
		}
		
		return result > 0;
	}

	//分頁查詢博客數據
	public List<Blog> getBlogList(PageBean pageBean) {
		Connection conn = this.getConnection();
		String sqlCount = "select count(*) from blog";
		String sql = "select * from blog limit ?,?";
		//獲取 總條數 
		int total = JdbcUtil.getResultCount(conn, sqlCount, null);
		pageBean.setTotalCount(total);
		List<Object> conditions = new ArrayList<Object>();
		conditions.add(pageBean.getStart());
		conditions.add(pageBean.getPageSize());
		List<Blog> blogs = this.getResultSetByCondition(this.getConnection(), sql, conditions);
		if (blogs.size() == 0){
			pageBean.setPage(1);
		}
		System.out.println("blogs size : " + blogs.size());
		return blogs;
	}
	
}
