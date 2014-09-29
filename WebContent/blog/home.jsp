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
.footer{
	text-align: center;
}
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
			<li>
				<a href="#"><i class="glyphicon glyphicon-wrench"></i> 日誌管理</a>
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
		<ol class="breadcrumb">
		  <li><a href="#">Home</a></li>
		  <li><a href="#">Library</a></li>
		  <li class="active">Data</li>
		</ol>
		<c:forEach var="blog" items="${blogs }">
			<div class="well">
				<h1>
					${blog.value.title }
				</h1>
				<p>
					${blog.value.contentText }
				</p>
				<p style="font-size: 12px;">
					<fmt:formatDate value="${blog.value.time }" pattern="yyyy-MM-dd HH:mm:ss"/>
				</p>
				<p>
					<a class="btn" href="<c:url value='/blog/show/${blog.value.id }' />">查看</a> | 
					<a class="btn" href="#">編輯</a> | 
					<a class="btn" href="<c:url value='/blog/delete/${blog.value.id }' />">刪除</a>
				</p>
			</div>
		</c:forEach>
		<c:if test="${empty blogs }">
			<div class="jumbotron">
			  <h2>Hello!</h2>
			  <p>沒博客？快去<a href="<c:url value= '/blog/add' />">寫博客</a>吧</p>
			  <p><a href="<c:url value= '/blog/add' />" class="btn btn-primary btn-lg" role="button">寫博客</a></p>
			</div>
		</c:if>
		<c:if test="${not empty blogs }">
			<ul class="pagination">
			  <li class="disabled"><a href="#">&laquo;</a></li>
			  <li class="active"><a href="#">1</a></li>
			  <li><a href="#">2</a></li>
			  <li><a href="#">3</a></li>
			  <li><a href="#">4</a></li>
			  <li><a href="#">5</a></li>
			  <li><a href="#">&raquo;</a></li>
			</ul>
		</c:if>
	</div>
</div>
<!-- bottom -->
<jsp:include page="/include/include_bottom.jsp"></jsp:include>
</div>
</body>
</html>