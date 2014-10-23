<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>${blog.title } - ${owner.loginName }</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/boostrap/css/bootstrap.min.css" />
<style type="text/css">
</style>
</head>
<body>
<!-- 导航栏 -->
<jsp:include page="/include/include_top.jsp"></jsp:include>
<div class="container">
<div class="row">
	<c:if test="${not empty owner}">
		<div class="page-header">
		  <h1>${owner.loginName }的博客 </h1>
		  <span><a href="http://blog.cmwebgame.com/u/${owner.loginName }">http://blog.cmwebgame.com/u/${owner.loginName }</a></span>
		</div>
		<div class="col-md-2 well">
			<a href="#" class="thumbnail">
		      <img src="${pageContext.request.contextPath }/images/xiaoxin.jpg" alt="...">
		    </a>
		    <p class="text-center">${owner.loginName }</p>
		    <!-- <p>Introduce</p> -->
		    <p class="text-center"><fmt:formatDate value="${owner.createTime }" pattern="yyyy-MM-dd"></fmt:formatDate></p>
		</div>
	</c:if>
	<div class="col-md-10">
		<c:if test="${not empty owner }">
			<div>
				<ul class="nav nav-pills" role="tablist">
				  <li role="presentation"><a href="${pageContext.request.contextPath }/u/${owner.loginName }">Home</a></li>
				  <li role="presentation" class="active"><a href="#">Blog</a></li>
				  <li role="presentation"><a href="#">Messages</a></li>
				  <li role="presentation"><a href="#">About me</a></li>
				</ul>
			</div>
		</c:if>
		<hr style="height:1px;border:none;border-top:1px dashed #E7E7E7;"/>
		<c:if test="${not empty msg  }">
			<div class="alert alert-danger" role="alert">
				<button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
				<strong>Error!</strong> ${msg }
			</div>
		</c:if>
		<c:if test="${not empty blog}">
			<div class="panel panel-default">
				<div class="panel-body">
					<p><b style="font-size: 30px;">${blog.title }</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i><fmt:formatDate value="${blog.publishTime }" pattern="yyyy-MM-dd HH:mm:ss"/></i></p>
				${blog.content }
				<p style="font-size: 12px;">
				</p>
				<c:if test="${isCurrent == true }">
					<p>
						<a class="btn" href="<c:url value='/blog/edit/${blog.id }' />">編輯</a> | 
						<a class="btn" id="deleteBtn" href="<c:url value='/blog/delete/${blog.id }' />">刪除</a>
					</p>
					<script type="text/javascript">
						$(document).ready(function(){
							$("#deleteBtn").click(function(){
								if (!confirm("删除将无法恢复，是否删除？")){
									return false;
								}
							});
						});
					</script>
				</c:if>
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