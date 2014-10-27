package com.cmwebgame.team.blog.dao.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import com.cmwebgame.dao.BaseDao;
import com.cmwebgame.team.blog.entity.Tag;
import com.cmwebgame.team.common.JdbcUtil;

public class TagDaoImpl extends BaseDao<Tag> {

	//檢查Tag是否存在。
	public boolean isExits(String tagName){
		Connection conn = this.getConnection();
		List<Object> conditions = new ArrayList<Object>();
		int result = 0;
		try {
			String sql = "select count(*) from tag where name = ?";
			conditions.add(tagName);
			result = JdbcUtil.getResultCount(conn, sql, conditions);
		}catch(Exception e){
			result = -1;
			e.printStackTrace();
		}
		return result > 0;
		
	}
	
	
	
	@Override
	protected Connection getConnection() {
		return JdbcUtil.getConnection();
	}

	@Override
	public void setConnection(Connection connection) {}

}
