package com.cmwebgame.team.blog.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;

import com.cmwebgame.core.ActionContext;
import com.cmwebgame.core.Mapping;
import com.cmwebgame.core.renderer.Renderer;
import com.cmwebgame.core.renderer.TemplateRenderer;
import com.cmwebgame.team.blog.dao.impl.BlogDaoImpl;
import com.cmwebgame.team.blog.dao.impl.UserDaoImpl;
import com.cmwebgame.team.blog.entity.Blog;
import com.cmwebgame.team.blog.entity.User;

public class BlogController {

	private BlogDaoImpl blogDao = new BlogDaoImpl();//暂不使用容器管理
	private UserDaoImpl userDao = new UserDaoImpl();//暂不使用容器管理
	
	@Mapping("/blog/")
	public Renderer home() {
		HttpServletRequest request = ActionContext.getActionContext().getHttpServletRequest();
		User user = (User) request.getSession().getAttribute("user");
		if (user == null) {
			return new TemplateRenderer("/");
		}
		// 通过user id获取自身blog
		List<Blog> selfBlogs = blogDao.getBlogsByUser(user.getId());
		return new TemplateRenderer("/blog/home.jsp", "blogs", selfBlogs);
	}

	@Mapping("/blog/add")
	public Renderer add() {
		HttpServletRequest request = ActionContext.getActionContext().getHttpServletRequest();
		User user = (User) request.getSession().getAttribute("user");
		if (user == null) {
			return new TemplateRenderer("/");
		}
		if (request.getParameter("publish") != null){
			request.setAttribute("msg", "Publish blog error,Please input blog info ");
		}
		return new TemplateRenderer("/blog/newBlog.jsp");
	}

	@Mapping("/blog/delete/$1")
	public String delete(long id) {
		HttpServletRequest request = ActionContext.getActionContext().getHttpServletRequest();
		String ctx = request.getContextPath();
		User currentUser = (User) request.getSession().getAttribute("user");
		if (currentUser == null) {
			return "redirect:" + ctx + "/";
		}
		//判断是否是自身Blog
		boolean flag = false;
		Blog blog = blogDao.getBlogById(id);
		if (currentUser.getId().equals(blog.getUserId())){
			//删除
			flag = blogDao.deleteBlogById(id);
		}
		System.out.println("delete : " + flag);
		return "redirect:" + ctx + "/blog/";
	}
	
	/**
	 * 展示blog
	 * @param id
	 * @return
	 */
	@Mapping("/blog/show/$1")
	public Renderer show(long id) {
		HttpServletRequest request = ActionContext.getActionContext().getHttpServletRequest();
		User currentUser = (User) request.getSession().getAttribute("user");
		boolean isCurrent = false;
		Blog blog = blogDao.getBlogById(id);
		if (blog != null) {
			//获取日志拥有人
			User owner = userDao.getUserByIdOrName(blog.getUserId());
			if (currentUser != null){
				if (currentUser.getUsername().equals(owner.getUsername())){
					isCurrent = true;
				}
			}
			request.setAttribute("blog", blog);
			request.setAttribute("owner", owner);
			request.setAttribute("isCurrent", isCurrent);
			return new TemplateRenderer("/blog/showBlog.jsp");
		}
		return new TemplateRenderer("/blog/showBlog.jsp", "msg","no such blog with id : " + id);
	}

	/**
	 * 發表新博客
	 */
	@Mapping("/blog/publish")
	public String publish() {
		HttpServletRequest request = ActionContext.getActionContext().getHttpServletRequest();
		String ctx = request.getContextPath();
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		String contentHtml = request.getParameter("contentHtml");

		User user = (User) request.getSession().getAttribute("user");
		if (user == null) {
			return "redirect:" + ctx + "/";
		}

		if (StringUtils.isBlank(title) || StringUtils.isBlank(content) || StringUtils.isBlank(contentHtml)) {
			return "redirect:" + ctx + "/blog/add?publish=false";
		}
		//发表Blog
		Blog blog = new Blog();
		blog.setTitle(title);
		blog.setContent(content);
		blog.setContentHtml(contentHtml);
		blog.setUserId(user.getId());
		boolean flag = blogDao.insert(blog);
		System.out.println("insert : " + flag);
		return "redirect:" + ctx + "/blog/";
	}

	/**
	 * 更新日志
	 */
	@Mapping("/blog/update")
	public String updateBlog() {
		HttpServletRequest request = ActionContext.getActionContext().getHttpServletRequest();
		long id = Long.parseLong(request.getParameter("id"));
		String content = request.getParameter("content");
		String title = request.getParameter("title");
		String contentHtml = request.getParameter("contentHtml");
		Blog blog = blogDao.getBlogById(id);
		if (blog != null) {
			blog.setTitle(title);
			blog.setContent(content);
			blog.setContentHtml(contentHtml);
			boolean flag = blogDao.modifyBlogById(blog);
			System.out.println("update : " + flag);
		}
		String returnUrl = request.getContextPath() + "/blog/show/" + id;
		return "redirect:" + returnUrl;
	}
	
	//日志编辑页面
	@Mapping("/blog/edit/$1")
	public Renderer editBlog(long id) {
		HttpServletRequest request = ActionContext.getActionContext().getHttpServletRequest();
		User currentUser = (User) request.getSession().getAttribute("user");
		Blog blog = blogDao.getBlogById(id);
		if (blog != null) {
			if (currentUser != null && currentUser.getId().equals(blog.getUserId())){
				return new TemplateRenderer("/blog/editBlog.jsp", "blog", blog);
			}
			return new TemplateRenderer("/blog/editBlog.jsp", "msg", "please login");
		}
		return new TemplateRenderer("/blog/editBlog.jsp", "msg","no such blog with id : " + id);
	}

	// 用戶blog主頁
}
