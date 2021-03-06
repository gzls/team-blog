package com.cmwebgame.team.blog.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;

import com.cmwebgame.core.ActionContext;
import com.cmwebgame.core.Mapping;
import com.cmwebgame.core.renderer.Renderer;
import com.cmwebgame.core.renderer.TemplateRenderer;
import com.cmwebgame.team.blog.dao.impl.BlogDaoImpl;
import com.cmwebgame.team.blog.dao.impl.BlogTypeDaoImpl;
import com.cmwebgame.team.blog.dao.impl.TagDaoImpl;
import com.cmwebgame.team.blog.dao.impl.UserDaoImpl;
import com.cmwebgame.team.blog.entity.Blog;
import com.cmwebgame.team.blog.entity.BlogType;
import com.cmwebgame.team.blog.entity.User;
import com.cmwebgame.team.blog.util.PageBean;

public class BlogController {

	private BlogDaoImpl blogDao = new BlogDaoImpl();//暂不使用容器管理
	private UserDaoImpl userDao = new UserDaoImpl();//暂不使用容器管理
	private BlogTypeDaoImpl blogTypeDao = new BlogTypeDaoImpl();
	private TagDaoImpl tagDao = new TagDaoImpl();
	
	/**
	 * 分頁展示 url /public/$1 $1表示第幾頁，如果不是正整數  默認第一頁
	 * @param pagenum
	 * @return
	 */
	@Mapping("/public/$1")
	public Renderer blogHall(String pagenum){
		HttpServletRequest request = ActionContext.getActionContext().getHttpServletRequest();
		//當前頁
		int page = 1;
		if (StringUtils.isNumeric(pagenum)){
			page = Integer.parseInt(pagenum);
		}
		PageBean pageBean = new PageBean();
		pageBean.setPage(page);
		List<Blog> blogs = blogDao.getBlogList(pageBean);
		request.setAttribute("pageBean", pageBean);
		request.setAttribute("blogs", blogs);
		return new TemplateRenderer("/blog/blogHall.jsp");
	}
	
	
	/**
	 * 分頁展示 url /blog/$1 $1表示第幾頁，如果不是正整數  默認第一頁
	 * @param pagenum
	 * @return
	 */
	@Mapping("/blog/$1")
	public Renderer home(String pagenum) {
		HttpServletRequest request = ActionContext.getActionContext().getHttpServletRequest();
		User user = (User) request.getSession().getAttribute("user");
		if (user == null) {
			return new TemplateRenderer("/");
		}
		//當前頁
		int page = 1;
		if (StringUtils.isNumeric(pagenum)){
			page = Integer.parseInt(pagenum);
		}
		PageBean pageBean = new PageBean();
		pageBean.setPage(page);
		// 通过user id获取自身blog
		List<Blog> selfBlogs = blogDao.getBlogsByUserAndPage(user.getId(),pageBean);
		request.setAttribute("pageBean", pageBean);
		request.setAttribute("blogs", selfBlogs);
		return new TemplateRenderer("/blog/home.jsp");
	}

	@Mapping("/blog/add/")
	public Renderer add() {
		HttpServletRequest request = ActionContext.getActionContext().getHttpServletRequest();
		User user = (User) request.getSession().getAttribute("user");
		if (user == null) {
			return new TemplateRenderer("/");
		}
		if (request.getParameter("publish") != null){
			request.setAttribute("msg", "Publish blog error,Please input blog info ");
		}
		//獲取用戶對應博客類型
		List<BlogType> blogTypes = blogTypeDao.getBlogTypeList(user.getId());
		request.setAttribute("blogTypes", blogTypes);
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
		if (currentUser.getId().equals(blog.getAuthorId())){
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
			User owner = userDao.getUserByIdOrName(blog.getAuthorId());
			if (currentUser != null){
				if (currentUser.getLoginName().equals(owner.getLoginName())){
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
	@Mapping("/blog/publish/")
	public String publish() {
		HttpServletRequest request = ActionContext.getActionContext().getHttpServletRequest();
		String ctx = request.getContextPath();
		String id = request.getParameter("id");
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		String contentHtml = request.getParameter("contentHtml");
		String blogType = request.getParameter("blogType");
		User user = (User) request.getSession().getAttribute("user");
		String returnUrl = "";
		if (user == null) {
			return "redirect:" + ctx + "/";
		}

		if (StringUtils.isBlank(title) || StringUtils.isBlank(content)
				|| StringUtils.isBlank(contentHtml)
				|| StringUtils.isBlank(blogType)) {
			return "redirect:" + ctx + "/blog/add?publish=false";
		}
		//判定更新還是新增
		Blog blog = null;
		if (StringUtils.isNotBlank(id)){
			blog = blogDao.getBlogById(Long.parseLong(id));
		}
		if (blog != null) {
			blog.setTitle(title);
			blog.setContent(content);
			blog.setContentHtml(contentHtml);
			blog.setCustomType(Long.parseLong(blogType));
			blog.setAuthorId(user.getId());
			returnUrl = "redirect:" + ctx + "/blog/show/" + id;
		}else{
			blog = new Blog();
			blog.setTitle(title);
			blog.setContent(content);
			blog.setContentHtml(contentHtml);
			blog.setCustomType(Long.parseLong(blogType));
			blog.setAuthorId(user.getId());
			returnUrl = "redirect:" + ctx + "/blog/";
		}
		//发表Blog
		boolean flag = blogDao.saveOrUpdate(blog);
		System.out.println("user publish new blog result = " + flag);
		return returnUrl;
	}

	//日志编辑页面
	@Mapping("/blog/edit/$1")
	public Renderer editBlog(long id) {
		HttpServletRequest request = ActionContext.getActionContext().getHttpServletRequest();
		User currentUser = (User) request.getSession().getAttribute("user");
		Blog blog = blogDao.getBlogById(id);
		if (blog != null) {
			if (currentUser != null && currentUser.getId().equals(blog.getAuthorId())){
				//獲取用戶對應博客類型
				List<BlogType> blogTypes = blogTypeDao.getBlogTypeList(currentUser.getId());
				request.setAttribute("blogTypes", blogTypes);
				return new TemplateRenderer("/blog/editBlog.jsp", "blog", blog);
			}
			return new TemplateRenderer("/blog/editBlog.jsp", "msg", "please login");
		}
		return new TemplateRenderer("/blog/editBlog.jsp", "msg","no such blog with id : " + id);
	}

	//用户-博客类型
	@Mapping("/blog/add_category/")
	public void addBlogTypeOfUser(){
		HttpServletRequest request = ActionContext.getActionContext().getHttpServletRequest();
		HttpServletResponse response = ActionContext.getActionContext().getHttpServletResponse();
		User user = (User) request.getSession().getAttribute("user");
		String name = request.getParameter("category");//用户博客分类名称
		try {
			if (user == null) {
				response.getWriter().print("unlogin");
			}else if (StringUtils.isBlank(name)){
				response.getWriter().print("nullparam");
			}else{
				BlogType blogType = new BlogType();
				blogType.setUserId(user.getId());
				blogType.setName(name);
				//查詢用戶是否創建過此分類
				boolean result = blogDao.checkUserBlogType(blogType);
				if (result){
					response.getWriter().print("addagain");
				}else{
					int flag = blogDao.addUserBlogType(blogType);
					if (flag > 0){
						response.getWriter().print(flag);
					}else{
						response.getWriter().print("adderror");
					}
				}
			}
			response.getWriter().flush();
			response.getWriter().close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 檢查Tag是否存在。
	 * 返回信息 1：tag為空 2，已存在。0：可添加
	 */
	@Mapping("/blog/checkBlogTag")
	public void checkBlogTag(){
		HttpServletRequest request = ActionContext.getActionContext().getHttpServletRequest();
		HttpServletResponse response = ActionContext.getActionContext().getHttpServletResponse();
		String tagName = request.getParameter("tagName");
		try {
			if (StringUtils.isBlank(tagName)){
				response.getWriter().print("1");
			}else{
				boolean flag = tagDao.isExits(tagName);
				if (!flag){
					response.getWriter().print("2");
				}else{
					response.getWriter().print("0");
				}
			}
			response.getWriter().flush();
			response.getWriter().close();
		} catch (Exception e){
			e.printStackTrace();
		}
	}
}
