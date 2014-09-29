<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>個人中心</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/boostrap/css/bootstrap.min.css" />
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-1.8.2.js" ></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/boostrap/js/bootstrap.min.js" ></script>
</head>
<body>
<!-- 导航栏 -->
<jsp:include page="/include/include_top.jsp"></jsp:include>
<div class="container">
	<div class="error-container">
<div class="well">
<h1 class="grey lighter smaller">
	<span class="blue bigger-125">
		<i class="icon-sitemap"></i>
		404
	</span>
	Page Not Found
</h1>

<hr>
<h3 class="lighter smaller">We looked everywhere but we couldn't find it!</h3>
	<hr>
</div>
</div>
<!-- bottom -->
<jsp:include page="/include/include_bottom.jsp"></jsp:include>
</div>
</body>
</html>