<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>${currentUser.loginName }的博客 - 臉書博客</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/boostrap/css/bootstrap.min.css" />
</head>
<body>
<!-- 导航栏 -->
<jsp:include page="/include/include_top.jsp"></jsp:include>
<div class="container">
<div class="row">
	<div class="page-header">
	  <h1>${currentUser.loginName }的博客 </h1>
	  <span><a href="http://blog.cmwebgame.com/u/${currentUser.loginName }">http://blog.cmwebgame.com/u/${currentUser.loginName }</a></span>
	</div>
	<div class="col-md-2 well">
		<a href="#" class="thumbnail">
	      <img src="${pageContext.request.contextPath }/images/xiaoxin.jpg" alt="...">
	    </a>
	    <p class="text-center">${currentUser.loginName }</p>
	    <!-- <p>Introduce</p> -->
	    <p class="text-center"><fmt:formatDate value="${currentUser.createTime }" pattern="yyyy-MM-dd"/></p>
	</div>
	<div class="col-md-10">
		<div>
			<ul class="nav nav-pills" role="tablist">
			  <li role="presentation" class="active"><a href="${pageContext.request.contextPath }/u/${currentUser.loginName }">Home</a></li>
			  <li role="presentation"><a href="#">Blog</a></li>
			  <li role="presentation"><a href="#">Messages</a></li>
			  <li role="presentation"><a href="#">About me</a></li>
			</ul>
		</div>
		<hr style="height:1px;border:none;border-top:1px dashed #E7E7E7;"/>
		<c:forEach var="blog" items="${blogs }">
			<div class="well">
				<h1>
					${blog.title }
				</h1>
				<p>
					${blog.content }
				</p>
				<p style="font-size: 12px;">
					<fmt:formatDate value="${blog.publishTime }" pattern="yyyy-MM-dd HH:mm:ss"/>
				</p>
					<c:if test="${selfLogin == false }">
						<a class="btn" href="${pageContext.request.contextPath }/blog/show/${blog.id }">查看</a>
					</c:if>
					<c:if test="${selfLogin == true }">
						<a class="btn" href="${pageContext.request.contextPath }/blog/show/${blog.id }">查看</a> |
						<a class="btn" href="${pageContext.request.contextPath }/blog/edit/${blog.id }">编辑</a> |
						<a class="btn" href="${pageContext.request.contextPath }/blog/delete/${blog.id }">删除</a>
					</c:if>
				<p>
				</p>
			</div>
		</c:forEach>
		<!-- <ul class="pagination">
		  <li class="disabled"><a href="#">&laquo;</a></li>
		  <li class="active"><a href="#">1</a></li>
		  <li><a href="#">2</a></li>
		  <li><a href="#">3</a></li>
		  <li><a href="#">4</a></li>
		  <li><a href="#">5</a></li>
		  <li><a href="#">&raquo;</a></li>
		</ul> -->
	</div>
</div>
<!-- bottom -->
<jsp:include page="/include/include_bottom.jsp"></jsp:include>
</div>
</body>
</html>