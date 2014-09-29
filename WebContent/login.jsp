<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Login</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/boostrap/css/bootstrap.min.css" />
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-1.8.2.js" ></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/boostrap/js/bootstrap.min.js" ></script>
<style type="text/css">
	.log {
	     position:absolute;  
	     top:50%;            
	     left:50%;
	     margin:-100px 0 0 -150px;     
	     z-index:99;                           
     }
</style>
</head>
<body style="background-color: #EEEEEE;">
 <div class="container">
    <div class="panel panel-primary log" style="width: 300px;">
    		<div class="panel-heading">
      <h3 class="panel-title">登&nbsp;录</h3>
   </div>
   <div class="panel-body">
   	<div id="alertInfo" style="display: none;" class="alert alert-warning">
	   <strong>Warning!</strong>
	   <i id="alertMsg"> </i>
	</div>
 	<form id="loginForm" action="<c:url value='/blog/login' />" method="post" name="loginForm" class="bs-example bs-example-form">
	 <div class="input-group">
         <span class="input-group-addon glyphicon glyphicon-user"></span>
         <input type="text" name="username" id="username" class="form-control" placeholder="username">
      </div>
      <br/>
      <div class="input-group">
         <span class="input-group-addon glyphicon glyphicon-lock"></span>
         <input type="password" name="password" id="password" class="form-control" placeholder="password">
      </div>
      <br/>
      <div class="input-group">
	      <button id="loginButton" type="button" class="btn btn-default">Sign in</button>
	  </div>
	  <br/>
	  <c:if test="${not empty msg }">
	  	<div class="alert alert-danger" role="alert">
			<button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
			<strong>Error!</strong> ${msg }
		</div>
	  </c:if>
 	</form>
   </div>
</div>
 </div>
<script type="text/javascript">
	$(document).ready(function(){
		$("#loginButton").click(function(){
			var username = $.trim($("#username").val());
			if (username == ''){
				$("#alertInfo").show();
				$("#alertMsg").text("请输入用户名");
				return;
			}
			var password = $.trim($("#password").val());
			if (password == ''){
				$("#alertInfo").show();
				$("#alertMsg").text("请输入密码");
				return;
			}
			//提交
			$("#alertInfo").hide();
			$("#loginForm").submit();
		});
	});
</script>
</body>
</html>