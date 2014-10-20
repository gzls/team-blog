<%@ page isELIgnored="false"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-1.8.2.js" ></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery.form.js" ></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/boostrap/js/bootstrap.min.js" ></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/boostrap/js/tooltip.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/boostrap/js/popover.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/validate/jquery.validate.js" ></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/validate/messages_cn.js" ></script>
<div style="padding-bottom: 40px;">
<nav class="navbar navbar-default navbar-fixed-top" role="navigation">
  <div class="navbar-header">
     <a id="aboutBlog" class="navbar-brand" href="#">广州脸书团队博客</a>
  </div>
  <div>
  	<c:if test="${not empty user }">
     <ul class="nav navbar-nav">
		 <!-- <li><a><img src="${ctx }/images/xiaoxin.jpg" width="22px" height="22px;" class="img-circle"></a></li> -->
        <li class="dropdown">
        	<a href="#" class="dropdown-toggle" data-toggle="dropdown">${user.username }&nbsp;<b class="caret"></b></a>
        	<ul class="dropdown-menu">
        	   <li><a href="<c:url value='/u/${user.id }' />">我的博客</a></li>
              <li><a href="<c:url value='/blog' />">博客管理</a></li>
              <li><a id="changePwd" href="javascript:;">修改密码</a></li>
               <li class="divider"></li>
              <li><a href="<c:url value='/blog/add' />">写博客</a></li>
              <li class="divider"></li>
              <li><a href="${pageContext.request.contextPath }/logout">退出</a></li>
           </ul>
        </li>
        <li><a href="<c:url value='/blog' />">個人中心</a></li>
        <li><a href="<c:url value='/blog/add' />">写博客</a></li>
        <!-- <li><a href="#">後台管理</a></li> -->
     </ul>
  	</c:if>
    <c:if test="${empty user }">
    	<!-- 未登录 -->
     	<div style="float: right;">
     		<form class="navbar-form navbar-left" role="login">
			  <div class="form-group">
			    <input type="text" id="username" name="username" class="form-control" placeholder="Username or Email" data-container="body" data-trigger="manual" data-toggle="popover" data-placement="bottom" data-content="">
			  </div>
			  <div class="form-group">
			    <input type="password" id="password" name="password" class="form-control" placeholder="password"data-container="body" data-trigger="manual" data-toggle="popover" data-placement="bottom" data-content="">
			  </div>
			  <button id="navLogin" type="button" class="btn btn-primary">Sign in</button>
			  <a href="${pageContext.request.contextPath }/register" class="btn btn-success" role="button">Sign up</a>
			</form>
     	</div>
    </c:if>
   </div>
	</nav>
</div>
<!-- about blog -->
<div class="modal fade" id="aboutModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
   <div class="modal-dialog">
      <div class="modal-content">
         <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" 
               aria-hidden="true">×
            </button>
            <h4 class="modal-title" id="myModalLabel">
               	关于广州脸书团队Blog
            </h4>
         </div>
         <div class="modal-body">
	         <h2>Team-Blog</h2>
	         v-1.0<br/><br/>
	         <b>广州市脸书信息科技有限公司</b>
	         <br/><br/>
	         Team-Blog诞生于广州脸书。嘿嘿<!-- 我们是一群积极向上的男青年，致力于让我们有一个更加开放、活泼的工作交流平台 -->。
            <br/><br/>
                                    这听起来很有趣吧? (按下 ESC 按钮退出)
         </div>
         <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
         </div>
      </div>
   </div>
</div>
<!-- change pwd dialog -->
<div class="modal fade" id="pwdModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
   <div class="modal-dialog">
      <div class="modal-content">
         <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            <h4 class="modal-title" id="myModalLabel">
               	修改密码
            </h4>
         </div>
         <div class="modal-body">
	         <form id="changePwdForm" name="changePwdForm" class="form-horizontal" role="form">
			  <div class="form-group">
			    <label for="inputEmail3" class="col-sm-3 control-label">原密码</label>
			    <div class="col-sm-5">
			      <input type="password" class="form-control" name="oldpassword" id="oldpassword" placeholder="Old password" data-container="body" data-trigger="manual" data-toggle="popover" data-placement="right"  >
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="inputPassword3" class="col-sm-3 control-label">新密码</label>
			    <div class="col-sm-5">
			      <input type="password" class="form-control" name="newpassword" id="newpassword" placeholder="New password" data-container="body" data-trigger="manual" data-toggle="popover" data-placement="right"  >
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="inputPassword3" class="col-sm-3 control-label">确认新密码</label>
			    <div class="col-sm-5">
			      <input type="password" class="form-control" name="passwordcfm" id="passwordcfm" placeholder="Confirm new password" data-container="body" data-trigger="manual" data-toggle="popover" data-placement="right"  >
			    </div>
			  </div>
			  <div class="form-group">
			    <div class="col-sm-offset-3 col-sm-10">
			      <button type="button" id="changPwdBtn" class="btn btn-success">修 改</button>
			    </div>
			  </div>
			</form>
			<p id="changeTip" style="font-style: red;" class="text-center"></p>
         </div>
         <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
         </div>
      </div>
   </div>
</div>
<script type="text/javascript">
$(document).ready(function(){
	 var e;
	//註冊validate函數
	$("#changePwdForm").validate({
		rules : {
			oldpassword : {
				required : true,
				minlength : 6
			},
			newpassword : {
				required : true,
				minlength : 6
			},
			passwordcfm : {
				required : true,
				minlength : 6,
				equalTo : "#newpassword"
			}
		},
		messages : {
			oldpassword : {
				required : "请输入旧密码",
				minlength : "密码至少为6位"
			},
			newpassword : {
				required : "请输入新密码",
				minlength : "新密码至少为6位"
			},
			passwordcfm : {
				required : "请确认新密码",
				minlength : "确认密码至少为6位",
				equalTo : "两次密码不一致"
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
$("#changePwd").click(function(){
	   $('#pwdModal').modal({
	      	keyboard: true
	   });
 });
 $('#pwdModal').on('hide.bs.modal',function(){
	  $("#changeTip").html('');
	  $("#changePwdForm")[0].reset();
	  $("#oldpassword").popover('hide');
	  $("#newpassword").popover('hide');
	  $("#passwordcfm").popover('hide');
 });
	  
 $("#aboutBlog").click(function(){
  $('#aboutModal').modal({
     	keyboard: true
  });
 });

 $("#navLogin").click(function(){
	 var username = $.trim($("#username").val());
	 if (username == ''){
		 $("#username").attr("data-content","请输入用户名或邮箱");
		 $("#username").popover('show');
		 return;
	 }else{
		 $("#username").attr("data-content",'');
		 $("#username").popover('hide');
	 }
	 var password = $.trim($("#password").val());
	 if (password == ''){
		 $("#password").attr("data-content","请输入密码");
		 $("#password").popover('show');
		 return;
	 }else{
		 $("#password").attr("data-content",'');
		 $("#password").popover('hide');
	 }
	 //提交
	 $.ajax({
		 url : "${pageContext.request.contextPath }/ajaxLogin",
		 data : {"username":username,"password":password},
		 type : "POST",
		 dataType : 'text',
		 cache : false,
		 success : function(data,textStatus){
			 if (data === "0"){
				 document.location.reload();
			 }else{
				 alert("登录失败，请检查用户名或密码");
			 }
		 },
		 error : function(XMLHttpRequest, textStatus, errorThrown){
			 alert(textStatus);
		 }
	 });
 });
 
 $("#changPwdBtn").click(function(){
	  if ($("#changePwdForm").valid()){
		  $("#changePwdForm").ajaxSubmit({
			  url : "${pageContext.request.contextPath }/changePwd",
			  type : "POST",
			  dataType : "text",
			  clearForm : true,
			  resetForm : true,
			  success : function(data){
				  switch (data){
				   	case "0":
				   		$("#changeTip").html("密码修改成功");
				   		break;
				   	case "1":
				   		$("#changeTip").html("请先登录，再进行该操作");
				   		break;
				   	case "2":
				   		$("#changeTip").html("原密码有误，密码修改失败");
				   		break;
				   	case "3":
				   		$("#changeTip").html("新密码与确认密码不一致");
				   		break;
			   		default:
			   			$("#changeTip").html("密码修改失败");
				  }
			  }
		  });
	  }
 });
 
});
</script>