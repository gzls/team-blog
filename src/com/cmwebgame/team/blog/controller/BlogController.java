package com.cmwebgame.team.blog.controller;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.cmwebgame.core.ActionContext;
import com.cmwebgame.core.Mapping;
import com.cmwebgame.core.renderer.Renderer;
import com.cmwebgame.core.renderer.TemplateRenderer;
import com.cmwebgame.team.blog.entity.Blog;

public class BlogController {
	
	private List<Blog> blogs = new ArrayList<Blog>();
	private Map<Long, Blog> blogsMap = new HashMap<Long, Blog>();
	
	@Mapping("/blog/")
	public Renderer home(){
		HttpServletRequest request = ActionContext.getActionContext().getHttpServletRequest();
		String msg = request.getParameter("msg");
		if (msg != null && !"".equals(msg)){
			System.out.println(msg);
			request.setAttribute("msg", "delete blog error,blog id : "+msg+"doesn't exist");
		}
		return new TemplateRenderer("/blog/home.jsp","blogs",blogsMap);
	}
	@Mapping("/blog/login")
	public String login(){
		HttpServletRequest request = ActionContext.getActionContext().getHttpServletRequest();
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		if ((username !=  null && !"".equals(username)) && (password != null && !"".equals(password))){
			request.getSession().setAttribute("username", username);
			return "redirect:../blog/";
		}
		return "redirect:"+request.getContextPath()+"/loginError";
	}
	@Mapping("/loginError")
	public Renderer loginError(){
		return new TemplateRenderer("/login.jsp","msg","login error");
	}
	
	@Mapping("/blog/add")
	public Renderer add(){
		return new TemplateRenderer("/blog/newBlog.jsp");
	}
	@Mapping("/blog/delete/$1")
	public String delete(long id){
		Blog blog = blogsMap.get(id);
		if (blog != null){
			blogsMap.remove(blog.getId());
			return "redirect:../";
		}
		return "redirect:../";
	}
	@Mapping("/blog/show/$1")
	public Renderer show(long id){
		Blog blog = blogsMap.get(id);
		if (blog != null){
			return new TemplateRenderer("/blog/showBlog.jsp","blog",blog);
		}
		return new TemplateRenderer("/blog/showBlog.jsp","msg","no such blog with id : " + id);
	}
	
	/**
	 * 發表新博客
	 */
	@Mapping("/blog/newblog")
	public String newBlog(){
		HttpServletRequest request = ActionContext.getActionContext().getHttpServletRequest();
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		String contentText = request.getParameter("contentText");
		if (title == null && "".equals(title)){
			System.out.println("not access return");
			return "redirect:../blog/add";
		}
		Blog blog = new Blog(System.currentTimeMillis(),title,content,contentText,new Timestamp(System.currentTimeMillis()));
		blogs.add(blog);
		blogsMap.put(blog.getId(), blog);
		return "redirect:../blog/";
	}
	
	//用戶blog主頁
	@Mapping("/userhome/$1")
	public Renderer userHome(String username){
		if (username == null && "".equals(username)){
			return null;
		}
		return new TemplateRenderer("/blog/userHome.jsp");
	}
}
