package com.cmwebgame.team.blog.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;

import com.cmwebgame.core.ActionContext;
import com.cmwebgame.core.Mapping;
import com.cmwebgame.core.MultipartHttpServletRequest;
import com.cmwebgame.core.renderer.Renderer;
import com.cmwebgame.core.renderer.TemplateRenderer;
import com.cmwebgame.team.blog.dao.impl.BlogDaoImpl;
import com.cmwebgame.team.blog.dao.impl.GroupDaoImpl;
import com.cmwebgame.team.blog.dao.impl.UserDaoImpl;
import com.cmwebgame.team.blog.entity.Blog;
import com.cmwebgame.team.blog.entity.Group;
import com.cmwebgame.team.blog.entity.User;
import com.cmwebgame.team.blog.entity.UserGroupRole;
import com.cmwebgame.team.blog.util.MD5;

public class UserController {
	
	private UserDaoImpl userDao = new UserDaoImpl();//暂不使用容器管理
	private BlogDaoImpl blogDao = new BlogDaoImpl();//暂不使用容器管理
	private GroupDaoImpl groupDao = new GroupDaoImpl();
	
	@Mapping("/login")
	public String login(){
		HttpServletRequest request = ActionContext.getActionContext().getHttpServletRequest();
		String ctx = request.getContextPath();
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		
		if (StringUtils.isBlank(username) || StringUtils.isBlank(password)){
			return "redirect:"+ctx+"/loginError";
		}
		
		User user = userDao.login(username,password);
		if (user != null){
			request.getSession().setAttribute("user", user);
			return "redirect:"+ctx+"/blog";
		}
		return "redirect:"+ctx+"/loginError";
	}
	
	@Mapping("/loginError")
	public Renderer loginError() {
		return new TemplateRenderer("/login.jsp", "msg", "Incorrect username or password.");
	}
	
	//註冊頁面
	@Mapping("/register")
	public Renderer register(){
		HttpServletRequest request = ActionContext.getActionContext().getHttpServletRequest();
		if (request.getParameter("signup") != null){
			request.setAttribute("msg", "註冊失敗，請檢查註冊信息。");
		}
		List<Group> groups = groupDao.getGroupList();
		return new TemplateRenderer("/user/register.jsp","groups",groups);
	}
	
	//註冊
	@Mapping("/join")
	public String join(){
		HttpServletRequest request = ActionContext.getActionContext().getHttpServletRequest();
		String ctx = request.getContextPath();
		String username = request.getParameter("username");
		String nickname = request.getParameter("nickname");
		String password = request.getParameter("password");
		String email = request.getParameter("email");
		String group = request.getParameter("group");
		
		if (StringUtils.isBlank(username) || StringUtils.isBlank(password)
				|| StringUtils.isBlank(email) || StringUtils.isBlank(nickname)
				|| StringUtils.isBlank(group)) {
			return "redirect:"+ctx+"/register?signup=error";
		}
		
		//insert
		User user = new User();
		user.setLoginName(username);
		user.setNickName(nickname);
		user.setPassword(MD5.crypt(password));//暂不加密密码
		user.setEmail(email);
		int id = userDao.insertUser(user);//新增后，返回用户数据库ID值
		if (id > 0){
			user.setId(new Long(id));
			request.getSession().setAttribute("user", user);
			//更新用户组信息
			UserGroupRole ugr = new UserGroupRole();
			ugr.setUid(user.getId());
			ugr.setGroupId(Long.parseLong(group));
			userDao.insertUserGroupRole(ugr);
		}
		return "redirect:"+ctx+"/blog";
	}
	
	// 注销退出
	@Mapping("/logout")
	public String logout() {
		HttpServletRequest request = ActionContext.getActionContext().getHttpServletRequest();
		if (request.getSession().getAttribute("user") != null){
			request.getSession().removeAttribute("user");
		}
		return "redirect:"+request.getContextPath() +"/";
	}
	
	// 提供头部导航栏异步登录
	@Mapping("/ajaxLogin")
	public void ajaxLogin() throws IOException {
		HttpServletRequest request = ActionContext.getActionContext().getHttpServletRequest();
		HttpServletResponse response = ActionContext.getActionContext().getHttpServletResponse();
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		if (StringUtils.isBlank(username) || StringUtils.isBlank(password)) {
			response.getWriter().print("1");
		} else {
			User user = userDao.login(username,password);
			if (user != null){
				request.getSession().setAttribute("user", user);
				response.getWriter().print("0");
			}else{
				response.getWriter().print("1");
			}
		}
		response.getWriter().flush();
		response.getWriter().close();
	}

	//检测用户名或邮箱是否被注册
	@Mapping("/checkJoin")
	public void checkJoin() throws IOException{
		HttpServletRequest request = ActionContext.getActionContext().getHttpServletRequest();
		HttpServletResponse response = ActionContext.getActionContext().getHttpServletResponse();
		String username = request.getParameter("username");
		String email = request.getParameter("email");
		boolean result = false;
		if (StringUtils.isNotBlank(username)){
			result = userDao.getUserByNameOrEmail(username, null);
		}
		if (StringUtils.isNotBlank(email)){
			result = userDao.getUserByNameOrEmail(null, email);
		}
		if (result){
			response.getWriter().print("false");
		}else{
			response.getWriter().print("true");
		}
		response.getWriter().flush();
	}
	
	@Mapping("/u/$1")
	public Renderer userHome(String name) {
		HttpServletRequest request = ActionContext.getActionContext().getHttpServletRequest();
		//获取当前登录用户
		User loginUser = (User) request.getSession().getAttribute("user");
		//获取当前访问的用户对象
		User currentUser = userDao.getUserByIdOrName(name);
		if (currentUser == null) {
			return new TemplateRenderer("/user/noSuchUser.jsp");
		}
		//获取当前访问用户的日志信息。
		List<Blog> blogs = blogDao.getBlogsByUser(currentUser.getId());
		boolean selfLogin = false;
		if (loginUser != null && currentUser.getLoginName().equals(loginUser.getLoginName())){
			selfLogin = true;
		}
		request.setAttribute("blogs", blogs);
		request.setAttribute("currentUser", currentUser);//当前访问用户
		request.setAttribute("selfLogin", selfLogin);
		return new TemplateRenderer("/blog/userHome.jsp");
	}

	@Mapping("/user/changePwd")
	public void changePwd(){
		HttpServletRequest request = ActionContext.getActionContext().getHttpServletRequest();
		HttpServletResponse response = ActionContext.getActionContext().getHttpServletResponse();
		//获取当前登录用户
		User user = (User) request.getSession().getAttribute("user");
		String password = request.getParameter("oldpassword");
		String newPassword = request.getParameter("newpassword");
		String passwordCfm = request.getParameter("passwordcfm");
		try {
			if (user == null){
				response.getWriter().print("1");//当前用户未登录
			}else if (!MD5.crypt(password).equals(user.getPassword())){
				response.getWriter().print("2");//原密码不正确
			}else if (!newPassword.equals(passwordCfm)){
				response.getWriter().print("3");//新密码不一致
			}else{
				//修改新密码
				user.setPassword(MD5.crypt(newPassword));
				boolean flag = userDao.changerPwd(user);
				if (flag){
					System.out.println("user : " + user.getLoginName() +" change password");
					response.getWriter().print("0");//密码修改成功
				}
			}
			response.getWriter().flush();
		} catch (Exception e){
			e.printStackTrace();
		}
	}

	@Mapping("/set/photo")
	public Renderer setPhoto(){
		HttpServletRequest request = ActionContext.getActionContext().getHttpServletRequest();
		User user = (User) request.getSession().getAttribute("user");
		if (user == null) return new TemplateRenderer("/");
		return new TemplateRenderer("/user/setPhoto.jsp");
	}
	
	@Mapping("/set/photo/upload")
	public void uploadPhoto() throws Exception{
		HttpServletRequest request = ActionContext.getActionContext().getHttpServletRequest();
		if (request instanceof MultipartHttpServletRequest){
			MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
			String name = multipartRequest.getFileName("photoFile");
			System.out.println("上传的图片名字 ： " + name);
		}
		throw new IOException("");
	}
	
}
