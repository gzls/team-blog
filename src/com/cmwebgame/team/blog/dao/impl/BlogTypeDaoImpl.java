package com.cmwebgame.team.blog.dao.impl;

import java.sql.Connection;
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
		String sql = "select * from custom_blog_type where user_id = ?";
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
	
}
