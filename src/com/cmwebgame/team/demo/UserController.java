package com.cmwebgame.team.demo;

import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.cmwebgame.core.ActionContext;
import com.cmwebgame.core.Mapping;
import com.cmwebgame.core.renderer.Renderer;
import com.cmwebgame.core.renderer.TemplateRenderer;
import com.cmwebgame.team.demo.util.DbUtils;

public class UserController {
	
	@Mapping("/user/")
	public Renderer index() throws Exception{
		List<User> users = DbUtils.queryForList("select id, name, createtime from user order by id desc");
		return new TemplateRenderer("/user/index.jsp", "users", users);
	}
	
	@Mapping("/user/display/$1")
	public Renderer display(long id) throws Exception{
		List<User> users = DbUtils.queryForList("select id, name, createtime from user u where u.id=?", id);
		if (users.isEmpty()){
			throw new IllegalArgumentException("User not found with id: " + id);
		}
		return new TemplateRenderer("/user/display.jsp", "user", users.get(0));
	}
	
	/*
	 * �����û�����
	 */
	@Mapping("/user/update/$1")
	public Renderer update(long id) throws Exception{
		List<User> users = DbUtils.queryForList("select id, name, createtime from user u where u.id=?", id);
		if (users.isEmpty()){
			throw new IllegalArgumentException("User not found with id: " + id);
		}
		return new TemplateRenderer("/user/edit.jsp", "user", users.get(0));
	}
	
	@Mapping("/user/edit")
	public String edit() throws Exception{
		HttpServletRequest request = ActionContext.getActionContext().getHttpServletRequest();
		long id = Long.parseLong(request.getParameter("id"));
		String name = request.getParameter("name");
		if (id == -1){
			//�½���
			id = DbUtils.nextId() +1;
			if (1 != DbUtils.executeUpdate("insert into user (id,name,createtime) values (?,?,?)", id,name,new Timestamp(System.currentTimeMillis()))){
				throw new SQLException("Create user failed.");
			}
		}else{
			//���£�
			if (1 != DbUtils.executeUpdate("update user set name=? where id = ? ", name,id)){
				throw new IllegalArgumentException("User not found with id: " + id);
			}
		}
		 return "redirect:"+request.getContextPath()+"/user/display/" + id;
	}
	
	@Mapping("/user/delete/$1")
    public String delete(long id) throws Exception {
		String contextPath = ActionContext.getActionContext().getHttpServletRequest().getContextPath();
        DbUtils.executeUpdate("delete from user where id=?", id);
        return "redirect:"+contextPath+"/";
    }
	
	@Mapping("/user/create")
	public Renderer create(){
		User user = new User(-1, "", null);
		return new TemplateRenderer("/user/edit.jsp","user",user);
	}
	
}
