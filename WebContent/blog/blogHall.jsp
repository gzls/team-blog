<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath }" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>博客大廳</title>
<link rel="stylesheet" type="text/css" href="${ctx }/resources/boostrap/css/bootstrap.min.css" />
<style type="text/css">
.hall-name{
	color:#af9d83;
	font-family:"Microsoft YaHei";
}
.hall-name:HOVER{
	color:#996633;
	text-decoration: none;
}
.hall-title{
	color:#000;
	font-family:"Microsoft YaHei";
	padding-left: 5px;
}
.hall-title:HOVER{
	color: #FF3300;
	text-decoration: none;
}
.tag-info{
	color:#996633;
	text-decoration: none;
	margin-right: 5px;
}
.tag-info:HOVER{
	color:#af9d83;
	text-decoration: none;
}
a{
	text-decoration: none;
}
small {
	font-size: 12px;
	line-height: 30px;
	padding-right: 5px;
}
.f1{
	float: left;
	margin-right: 15px;
}
.f2{
	overflow: hidden;
}
.f2 h3{
	font-size: 18px;
	line-height: 20px;
	font-weight: 400;
	white-space: nowrap;
}
.f2 h3 a {
	color:#000;
}
.f2 h3 a:HOVER {
	color:#996633;
	text-decoration: none;
}
.f2 p a {
	color:#b2b2b2;
}
.f2 p a:HOVER {
	color:#333;
	text-decoration: none;
}
.tital-tag{
font-size:18px;
}
.ftags{
	font-size: 18px;
	margin-right: 10px;
	white-space: nowrap;
	color: #996633;
}
.ftags:HOVER {
	color: #996633;
	text-decoration: none;
}
.unlogin h3{
	font: 400 28px/32px 'Microsoft Yahei','微软雅黑','Simhei','黑体';
	color: #333;
}
</style>
</head>
<body>
<!-- 导航栏 -->
<jsp:include page="/include/include_top.jsp"></jsp:include>
<div class="container">
<div class="row">
	<div class="page-header">
	  <h2>欢迎使用育駿博客 </h2>
	</div>
	<div class="col-md-8">
		<ul class="nav nav-tabs" role="tablist">
		  <li role="presentation" class="active"><a href="#">Home</a></li>
		</ul>
		<br>
		<!-- 最新博客 -->
		<c:forEach var="blog" items="${blogs }">
			<div class="panel panel-default">
			  <div class="panel-body">
			    <div class="col-xs-2 col-sm-2">
			    	 <a href="${ctx }/" class="thumbnail">
				      <img src="${ctx }/images/xiaoxin.jpg" alt="...">
				    </a>
			    </div>
			    <div class="col-sm-10">
			    	<h4><a href="#" class="hall-name">博主名字</a>&nbsp;<a href="${ctx }/blog/show/${blog.id}" class="hall-title">${blog.title }</a></h4>
			    	<p class="text-muted">${blog.content }</p>
			    	<p>
			    		<small><fmt:formatDate value="${blog.publishTime }" pattern="yyyy-MM-dd hh:mm:ss" /></small>
			    		<small>标签：<a href="#" class="tag-info">Java</a><a href="#" class="tag-info">交流</a></small>
			    	</p>
			    </div>
			  </div>
			</div>
		</c:forEach>
		<!-- 分页Tag -->
		<c:if test="${not empty blogs }">
			<ul class="pager">
		  		<c:choose>
			  		<c:when test="${pageBean.page == 1 }">
			  			<li class="disabled"><a>首頁</a></li>
				  		<li class="disabled"><a>上一页</a></li>
			  		</c:when>
			  		<c:otherwise>
			  			<li><a href="${ctx }/public/1">首頁</a></li>
				  		<li><a href="${ctx }/public/${pageBean.page - 1 }">上一页</a></li>
			  		</c:otherwise>
			  	</c:choose>
			  	<c:choose>
			  		<c:when test="${pageBean.page == pageBean.totalPage }">
			  			<li class="disabled"><a>下一页</a></li>
			  			<li class="disabled"><a>末頁</a></li>
			  		</c:when>
			  		<c:otherwise>
			  			<li><a href="${ctx }/public/${pageBean.page + 1 }">下一页</a></li>
			  			<li><a href="${ctx }/public/${pageBean.totalPage }">末頁</a></li>
			  		</c:otherwise>
			  	</c:choose>
			</ul>
		</c:if>
	</div>
	<!-- right -->
	<div class="col-md-4">
		<div class="panel panel-default">
		  <div class="panel-body">
		  <c:if test="${empty user }">
		  	<div class="unlogin">
		  		<h3 class="text-center">育駿博友，欢迎您！</h3>
		  		<p class="text-center">
		  			<button id="unLoginBtn" type="button" class="btn btn-link">登 錄</button>
		  		</p>
		  	</div>
		  </c:if>
		  <!-- Login -->
		  	<c:if test="${not empty user }">
	  		<div class="logined">
		  		<div class="f1">
			  		<a href="${ctx }/u/${user.loginName}">
				      <img width="80px;" height="80px;" src="${ctx }/images/xiaoxin.jpg" alt="...">
				    </a>
			  	</div>
			  	<div class="f2">
			  		<h3>
			  			<a href="${ctx }/u/${user.loginName}">${user.loginName }</a>
			  		</h3>
			  		<p><a class="blog-logout" href="${ctx }/logout">退出</a></p>
			  	</div>
			  	<hr>
			  	<p>
				  <a href="${ctx }/blog/add" type="button" class="btn btn-primary">发博客</a>
				  <a type="button" class="btn btn-default">写日志</a>
				</p>
		  	</div>
		  	</c:if>
			<hr>
			<div>
				<h2><span class="tital-tag">标签</span></h2>
				<p>
					<a href="#" class="ftags">Java</a>
				</p>
			</div>
		  </div>
	 	</div>
	</div>
</div>
<!-- bottom -->
<jsp:include page="/include/include_bottom.jsp"></jsp:include>
</div>
<script type="text/javascript">
	$(document).ready(function(){
		$("#unLoginBtn").click(function(){
			$("#username").focus();
			$("#username").attr("data-content","请输入用户名或邮箱");
			$("#username").popover("show");
		});
	});
</script>
</body>
</html>