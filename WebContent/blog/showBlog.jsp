<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>個人中心</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/boostrap/css/bootstrap.min.css" />
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-1.8.2.js" ></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/boostrap/js/bootstrap.min.js" ></script>
<style type="text/css">
</style>
</head>
<body>
<!-- 导航栏 -->
<jsp:include page="/include/include_top.jsp"></jsp:include>
<div class="container">
<div class="row">
	<div class="page-header">
	  <h1>Example page header <small>Subtext for header</small></h1>
	</div>
	<div class="col-md-3">
		<ul class="nav nav-pills nav-stacked well">
			<li class="nav-header">
				<i class="glyphicon glyphicon-home"></i> 个人中心
			</li>
			<li class="active">
				<a href="#"><i class="glyphicon glyphicon-wrench"></i> 博客管理</a>
			</li>
			<li>
				<a href="<c:url value='/blog/add' />"><i class="glyphicon glyphicon-floppy-disk"></i> 写日志</a>
			</li>
			<li>
				<a href="#">应用</a>
			</li>
			<li>
				功能列表
			</li>
			<li>
				<a href="#">资料</a>
			</li>
			<li>
				<a href="#">设置</a>
			</li>
			<li class="divider">
			</li>
		</ul>
	</div>
	<div class="col-md-9">
		<c:if test="${not empty msg  }">
			<div class="alert alert-danger" role="alert">
				<button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
				<strong>Error!</strong> ${msg }
			</div>
		</c:if>
		<ol class="breadcrumb">
		  <li><a href="#">Home</a></li>
		  <li><a href="#">Library</a></li>
		  <li class="active">Show</li>
		</ol>
		<c:if test="${not empty blog}">
			<div class="panel panel-default">
				<div class="panel-body">
					<p><b style="font-size: 30px;">${blog.title }</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i><fmt:formatDate value="${blog.time }" pattern="yyyy-MM-dd HH:mm:ss"/></i></p>
				${blog.content }
				<p style="font-size: 12px;">
					
				</p>
				<p>
					<a class="btn" href="#">編輯</a> | 
					<a class="btn" href="<c:url value='/blog/delete/${blog.id }' />">刪除</a>
				</p>
				</div>
			</div>
		</c:if>
	</div>
</div>
<!-- bottom -->
<jsp:include page="/include/include_bottom.jsp"></jsp:include>
</div>
</body>
</html>