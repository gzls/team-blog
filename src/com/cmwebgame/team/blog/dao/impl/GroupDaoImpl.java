package com.cmwebgame.team.blog.dao.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import com.cmwebgame.dao.BaseDao;
import com.cmwebgame.team.blog.entity.Group;
import com.cmwebgame.team.common.JdbcUtil;

public class GroupDaoImpl extends BaseDao<Group> {

	
	public List<Group> getGroupList(){
		
		String sql = "select * from blog.group";
		
		return this.getResultSetByCondition(getConnection(), sql, new ArrayList<Object>());
	}
	
	
	@Override
	protected Connection getConnection() {
		return JdbcUtil.getConnection();
	}

	@Override
	public void setConnection(Connection arg0) {}

}
