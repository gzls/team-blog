<%@ page contentType="text/html; charset=utf-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<title>註冊</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/boostrap/css/bootstrap.min.css" />
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-1.8.2.js" ></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/boostrap/js/bootstrap.min.js" ></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/boostrap/js/tooltip.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/boostrap/js/popover.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/validate/jquery.validate.js" ></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/validate/messages_cn.js" ></script>
<style type="text/css">
body {
  padding-top: 40px;
  padding-bottom: 40px;
  background-color: #eee;
}

.form-signup {
  max-width: 330px;
  padding: 15px;
  margin: 0 auto;
}
.form-signup .form-signup-heading,
.form-signup .checkbox {
  margin-bottom: 10px;
}
.form-signup .checkbox {
  font-weight: normal;
}
.form-signup .form-control {
  position: relative;
  height: auto;
  -webkit-box-sizing: border-box;
     -moz-box-sizing: border-box;
          box-sizing: border-box;
  padding: 10px;
  font-size: 16px;
}
.form-signup .form-control:focus {
  z-index: 2;
}
.form-signup input[type="email"] {
  margin-bottom: -1px;
  border-bottom-right-radius: 0;
  border-bottom-left-radius: 0;
}
.form-signup input[type="password"] {
  margin-bottom: 10px;
  border-top-left-radius: 0;
  border-top-right-radius: 0;
}
</style>
</head>
<body>
 <div class="container">
 	<p class="text-right"><a href="${pageContext.request.contextPath }/">Sign in</a></p>
 	<form id="joinForm" action="${pageContext.request.contextPath }/join" method="post" name="joinForm" class="form-signup" role="form">
        <h2 class="form-signup-heading">Please sign up</h2>
        <!-- <div class="input-group">
		  <span class="input-group-addon glyphicon glyphicon-user"></span>
		</div>
        
        <div class="input-group">
		  <span class="input-group-addon glyphicon glyphicon-envelope"></span>
		</div>
		<div class="input-group">
			<span class="input-group-addon glyphicon glyphicon-lock"></span>
		</div> -->
	    <input type="text" name="username" id="username" class="form-control" placeholder="Pick a username" data-container="body" data-trigger="manual" data-toggle="popover" data-placement="right" data-content="" >
        <input type="text" name="email" id="email" class="form-control" placeholder="Your email" data-container="body" data-trigger="manual" data-toggle="popover" data-placement="right" data-content="" >
	    <input type="password" name="password" id="password" class="form-control" placeholder="Create a password" data-container="body" data-trigger="manual" data-toggle="popover" data-placement="right" data-content="" />
       	<button id="joinBtn" class="btn btn-lg btn-success btn-block" type="button">Sign up</button>
	  <br/>
	  <c:if test="${not empty msg }">
	  	<div class="alert alert-danger" role="alert">
			<button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
			<strong>Error!</strong> ${msg }
		</div>
	  </c:if>
 	</form>
 	<div id="tester"></div>
 	<!-- bottom -->
	<jsp:include page="/include/include_bottom.jsp"></jsp:include>
   </div>
   <script type="text/javascript">
   		$(document).ready(function(){
   			var e;
   			jQuery.validator.addMethod("isUserName", function(value, element) {
   				return this.optional(element) || /^\w{3,15}$/.test(value);
   			}, "請修正帳號");
   			//註冊validate函數
   			$("#joinForm").validate({
   				rules : {
   					username : {
   						required : true,
   						rangelength :[3,15],
   						isUserName : true,
   						remote : "${pageContext.request.contextPath }/checkJoin"
   					},
   					password : {
   						required : true,
   						minlength : 6
   					},
   					email : {
   						required : true,
   						email : true,
   						remote : "${pageContext.request.contextPath }/checkJoin"
   					}
   					
   				},
   				messages : {
   					username : {
   						required : "请输入用户名",
   						rangelength : "用户名长度为3-15位",
   						isUserName : "用户名格式有误",
   						remote : "用户名已存在"
   					},
   					password : {
   						required : "请输入密码",
   						minlength : "密码至少为6位"
   					},
   					email : {
   						required : "请输入Email地址",
   						email : "请输入正确格式的Email地址",
   						remote : "Email已被注册"
   					}
   				},
   				errorPlacement: function(error, element) {
   					e = element.attr('id');
   					$("#"+e).attr("data-content",error.html());
   					$("#"+e).popover('show');
   				},
   				success: function(label) {
   					$("#"+e).popover('hide');
   				}
   			});
   			$("#joinBtn").click(function(){
   				if ($("#joinForm").valid()){
   					document.getElementById("joinForm").submit();
   				}
   			});
   		});
   </script>
</body>
</html>