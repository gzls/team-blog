<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>誰的博客 - 臉書博客</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/boostrap/css/bootstrap.min.css" />
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-1.8.2.js" ></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/boostrap/js/bootstrap.min.js" ></script>
</head>
<body>
<!-- 导航栏 -->
<jsp:include page="/include/include_top.jsp"></jsp:include>
<div class="container">
<div class="row">
	<div class="page-header">
	  <h1>Example page header <small>Subtext for header</small></h1>
	</div>
	<div class="col-md-2 well">
		<a href="#" class="thumbnail">
	      <img src="${pageContext.request.contextPath }/images/xiaoxin.jpg" alt="...">
	    </a>
	    <p>Your Name</p>
	    <p>Introduce</p>
	    <p>Join Time</p>
	</div>
	<div class="col-md-10">
		<div>
			<ul class="nav nav-pills" role="tablist">
			  <li role="presentation" class="active"><a href="#">Home</a></li>
			  <li role="presentation"><a href="#">Blog</a></li>
			  <li role="presentation"><a href="#">Messages</a></li>
			  <li role="presentation"><a href="#">Abouts me</a></li>
			</ul>
		</div>
		<hr style="height:1px;border:none;border-top:1px dashed #E7E7E7;"/>
		<div class="well">
			<h1>
				Title
			</h1>
			<p>
				Content
			</p>
			<p style="font-size: 12px;">
				yyyy-MM-dd HH:mm:ss
			</p>
			<p>
				<a class="btn" href="#">查看</a>
			</p>
		</div>
		<ul class="pagination">
		  <li class="disabled"><a href="#">&laquo;</a></li>
		  <li class="active"><a href="#">1</a></li>
		  <li><a href="#">2</a></li>
		  <li><a href="#">3</a></li>
		  <li><a href="#">4</a></li>
		  <li><a href="#">5</a></li>
		  <li><a href="#">&raquo;</a></li>
		</ul>
	</div>
</div>
<!-- bottom -->
<jsp:include page="/include/include_bottom.jsp"></jsp:include>
</div>
</body>
</html>