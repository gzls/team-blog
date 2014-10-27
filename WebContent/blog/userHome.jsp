<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath }"></c:set>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>${currentUser.loginName }的博客 - 臉書博客</title>
<link rel="stylesheet" type="text/css" href="${ctx }/resources/boostrap/css/bootstrap.min.css" />
</head>
<body>
<!-- 导航栏 -->
<jsp:include page="/include/include_top.jsp"></jsp:include>
<div class="container">
<div class="row">
	<div class="page-header">
	  <h1>${currentUser.loginName }的博客 </h1>
	  <span><a href="http://blog.cmwebgame.com/u/${currentUser.loginName }/">http://blog.cmwebgame.com/u/${currentUser.loginName }</a></span>
	</div>
	<div class="col-md-2 well">
		<a href="#" class="thumbnail">
	      <img src="${ctx }/images/xiaoxin.jpg" alt="...">
	    </a>
	    <p class="text-center">${currentUser.loginName }</p>
	    <!-- <p>Introduce</p> -->
	    <p class="text-center"><fmt:formatDate value="${currentUser.createTime }" pattern="yyyy-MM-dd"/></p>
	</div>
	<div class="col-md-10">
		<div>
			<ul class="nav nav-pills" role="tablist">
			  <li role="presentation" class="active"><a href="${ctx }/u/${currentUser.loginName }/">首頁</a></li>
			  <li role="presentation"><a href="${ctx }/${currentUser.loginName}/bloglist/">博文目錄</a></li>
			  <li role="presentation"><a href="#">關於我</a></li>
			</ul>
		</div>
		<hr style="height:1px;border:none;border-top:1px dashed #E7E7E7;"/>
		<c:if test="${empty blogs }">
			<div class="jumbotron">
			  <h2>Hello!</h2>
			  <p>用戶暫未發佈任何博文。</p>
			  <c:if test="${selfLogin == true }">
			  	<p>暫無博文？點擊 <a href="<c:url value= '/blog/add/' />">發博文</a> 寫一篇屬於自己的博文。</p>
			  	<p><a href="<c:url value= '/blog/add/' />" class="btn btn-primary btn-lg" role="button">發博文</a></p>
			  </c:if>
			</div>
		</c:if>
		
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
					<a class="btn" href="${ctx }/blog/show/${blog.id }">查看</a>
					<c:if test="${selfLogin == true }">
						 |<a class="btn" href="${ctx }/blog/edit/${blog.id }">编辑</a> |
						<a class="btn" href="${ctx }/blog/delete/${blog.id }">删除</a>
					</c:if>
				<p>
				</p>
			</div>
		</c:forEach>
		
		
		
		<c:if test="${not empty blogs }">
			<ul class="pager">
		  		<c:choose>
			  		<c:when test="${pageBean.page == 1 }">
			  			<li class="disabled"><a>首頁</a></li>
				  		<li class="disabled"><a>上一页</a></li>
			  		</c:when>
			  		<c:otherwise>
			  			<li><a href="${ctx }/u/${currentUser.loginName }/1">首頁</a></li>
				  		<li><a href="${ctx }/u/${currentUser.loginName }/${pageBean.page - 1 }">上一页</a></li>
			  		</c:otherwise>
			  	</c:choose>
			  	<c:choose>
			  		<c:when test="${pageBean.page == pageBean.totalPage }">
			  			<li class="disabled"><a>下一页</a></li>
			  			<li class="disabled"><a>末頁</a></li>
			  		</c:when>
			  		<c:otherwise>
			  			<li><a href="${ctx }/u/${currentUser.loginName }/${pageBean.page + 1 }">下一页</a></li>
			  			<li><a href="${ctx }/u/${currentUser.loginName }/${pageBean.totalPage }">末頁</a></li>
			  		</c:otherwise>
			  	</c:choose>
			</ul>
		</c:if>
	</div>
</div>
<!-- bottom -->
<jsp:include page="/include/include_bottom.jsp"></jsp:include>
</div>
</body>
</html>