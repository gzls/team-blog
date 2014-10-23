package com.cmwebgame.team.blog.controller;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;

import com.cmwebgame.core.ActionContext;
import com.cmwebgame.core.Mapping;
import com.cmwebgame.dao.BaseDao;
import com.cmwebgame.team.blog.entity.Group;
import com.cmwebgame.team.common.JdbcUtil;

public class GroupController extends BaseDao<Group> {
	
	//新增用户部门
	@Mapping("/group/add")
	public void addGroup(){
		HttpServletRequest request = ActionContext.getActionContext().getHttpServletRequest();
		String name = request.getParameter("name");
		if (StringUtils.isNotBlank(name)){
			String sql = "insert into blog.group (name) values (?)";
			List<Object> con = new ArrayList<Object>();
			con.add(name);
			int result = this.insert(getConnection(), sql, con);
			System.out.println("insert group result : " + (result > 0));
		}
	}

	@Override
	protected Connection getConnection() {
		return JdbcUtil.getConnection();
	}

	@Override
	public void setConnection(Connection arg0) {
	}
}
