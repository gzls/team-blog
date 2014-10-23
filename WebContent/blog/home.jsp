<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath }" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>個人中心</title>
<link rel="stylesheet" type="text/css" href="${ctx }/resources/boostrap/css/bootstrap.min.css" />
</head>
<body>
<!-- 导航栏 -->
<jsp:include page="/include/include_top.jsp"></jsp:include>
<div class="container">
<div class="row">
	<div class="page-header">
	  <h2>${user.loginName }的博客 </h2>
	</div>
	<div class="col-md-3">
		<ul class="nav nav-pills nav-stacked well">
			<li class="nav-header">
				<i class="glyphicon glyphicon-home"></i> 个人中心
			</li>
			<li  class="active">
				<a  href="#"><i class="glyphicon glyphicon-wrench"></i> 博客管理</a>
			</li>
			<li>
				<a href="<c:url value='/blog/add' />"><i class="glyphicon glyphicon-floppy-disk"></i> 写博客</a>
			</li>
			<!-- <li>
				<a href="#">应用</a>
			</li> -->
			<li>
				<i class="glyphicon glyphicon-cog"></i> 功能列表
			</li>
			<li>
				<a href="${ctx }/set/photo"><i class="glyphicon glyphicon-picture"></i> 修改头像</a>
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
		  <li><a href="${ctx }/blog">Home</a></li>
		  <li class="active">個人中心</li>
		</ol>
		<c:forEach var="blog" items="${blogs }">
			<div class="well">
				<h1>
					${blog.title }
				</h1>
				<p>
					${blog.contentHtml }
				</p>
				<p style="font-size: 12px;">
					<fmt:formatDate value="${blog.publishTime }" pattern="yyyy-MM-dd HH:mm:ss"/>
				</p>
				<p>
					<a class="btn" href="${ctx }/blog/show/${blog.id }">查看</a> | 
					<a class="btn" href="${ctx }/blog/edit/${blog.id }">編輯</a> | 
					<a class="btn" id="deleteBtn" href="${ctx }/blog/delete/${blog.id }">刪除</a>
				</p>
			</div>
		</c:forEach>
		<c:if test="${empty blogs }">
			<div class="jumbotron">
			  <h2>Hello!</h2>
			  <p>暫無博客？點擊 <a href="<c:url value= '/blog/add' />">發博客</a> 寫一篇屬於自己的博客。</p>
			  <p><a href="<c:url value= '/blog/add' />" class="btn btn-primary btn-lg" role="button">發博客</a></p>
			</div>
		</c:if>
		<%-- <c:if test="${not empty blogs }">
			<ul class="pagination">
			  <li class="disabled"><a href="#">&laquo;</a></li>
			  <li class="active"><a href="#">1</a></li>
			  <li><a href="#">2</a></li>
			  <li><a href="#">3</a></li>
			  <li><a href="#">4</a></li>
			  <li><a href="#">5</a></li>
			  <li><a href="#">&raquo;</a></li>
			</ul>
		</c:if> --%>
	</div>
</div>
<!-- bottom -->
<jsp:include page="/include/include_bottom.jsp"></jsp:include>
</div>
<script type="text/javascript">
	$(document).ready(function(){
		$("#deleteBtn").click(function(){
			if (!confirm("删除将无法恢复，是否删除？")){
				return false;
			}
		});
	});
</script>
</body>
</html>