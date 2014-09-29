<%@ page isELIgnored="false"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div style="padding-bottom: 60px;">
<nav class="navbar navbar-default navbar-fixed-top" role="navigation">
  <div class="navbar-header">
     <a id="aboutBlog" class="navbar-brand" href="#">广州脸书团队博客</a>
  </div>
  <div>
     <ul class="nav navbar-nav">
 			 <!-- <li><a><img src="${ctx }/images/xiaoxin.jpg" width="22px" height="22px;" class="img-circle"></a></li> -->
	         <li class="dropdown">
	         	<a href="#" class="dropdown-toggle" data-toggle="dropdown">${username }<b class="caret"></b></a>
	         	<ul class="dropdown-menu">
	               <li><a href="<c:url value='/blog' />">日志管理</a></li>
	               <li><a href="#">修改密码</a></li>
	                <li class="divider"></li>
	               <li><a href="<c:url value='/blog/add' />">写日志</a></li>
	               <li class="divider"></li>
	               <li><a href="#">退出</a></li>
	            </ul>
	         </li>
	         <li><a href="<c:url value='/blog' />">個人中心</a></li>
	         <li><a href="<c:url value='/blog/add' />">写日志</a></li>
	         <li><a href="#">後台管理</a></li>
	      </ul>
	   </div>
	</nav>
</div>