<%@page import="com.cmwebgame.team.blog.entity.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	User user = (User)request.getSession().getAttribute("user");
	if (user != null){
		response.sendRedirect(request.getContextPath()+"/blog/");
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>登錄</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/boostrap/css/bootstrap.min.css" />
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-1.8.2.js" ></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/boostrap/js/bootstrap.min.js" ></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/boostrap/js/tooltip.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/boostrap/js/popover.js"></script>
<style type="text/css">
	body {
	  padding-top: 40px;
	  padding-bottom: 40px;
	  background-color: #eee;
	}
	
	.form-signin {
	  max-width: 330px;
	  padding: 15px;
	  margin: 0 auto;
	}
	.form-signin .form-signin-heading,
	.form-signin .checkbox {
	  margin-bottom: 10px;
	}
	.form-signin .checkbox {
	  font-weight: normal;
	}
	.form-signin .form-control {
	  position: relative;
	  height: auto;
	  -webkit-box-sizing: border-box;
	     -moz-box-sizing: border-box;
	          box-sizing: border-box;
	  padding: 10px;
	  font-size: 16px;
	}
	.form-signin .form-control:focus {
	  z-index: 2;
	}
	.form-signin input[type="email"] {
	  margin-bottom: -1px;
	  border-bottom-right-radius: 0;
	  border-bottom-left-radius: 0;
	}
	.form-signin input[type="password"] {
	  margin-bottom: 10px;
	  border-top-left-radius: 0;
	  border-top-right-radius: 0;
	}
</style>
</head>
<body>
 <div class="container">
 	<p class="text-right"><a href="${pageContext.request.contextPath }/register">Sign up</a></p>
 	<form id="loginForm" action="${pageContext.request.contextPath }/login" method="post" name="loginForm" class="form-signin" role="form">
        <h2 class="form-signin-heading">Please sign in</h2>
        <input type="text" name="username" id="username" class="form-control" placeholder="Username or Email" data-container="body" data-trigger="manual" data-toggle="popover" data-placement="right" data-content="" />
        <input type="password" name="password" id="password" class="form-control" placeholder="Password" data-container="body" data-trigger="manual" data-toggle="popover" data-placement="right" data-content="" >
        <!-- <div class="checkbox">
          <label>
            <input type="checkbox" value="remember-me"> Remember me
          </label>
        </div> -->
        <button id="loginBtn" class="btn btn-lg btn-primary btn-block" type="button">Sign in</button>
	  <br/>
 	</form>
	  <c:if test="${not empty msg }">
	  	<div class="alert alert-danger" role="alert">
			<button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
			<strong>Error!</strong> ${msg }
		</div>
	  </c:if>
 	<!-- bottom -->
<jsp:include page="/include/include_bottom.jsp"></jsp:include>
   </div>
<script type="text/javascript">
	$(document).ready(function(){
		$("#loginBtn").click(function(){
			var username = $.trim($("#username").val());
			if (username == ''){
				 $("#username").attr("data-content","请输入用户名");
				 $("#username").popover('show');
				return;
			}else{
				$("#username").popover('hide');
			}
			var password = $.trim($("#password").val());
			if (password == ''){
				 $("#password").attr("data-content","请输入密码");
				 $("#password").popover('show');
				return;
			}else{
				$("#password").popover('hide');
			}
			//提交
			$("#loginForm").submit();
		});
	});
</script>
</body>
</html>