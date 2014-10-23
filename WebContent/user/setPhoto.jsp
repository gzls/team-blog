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
			<li>
				<a  href="#"><i class="glyphicon glyphicon-wrench"></i> 日誌管理</a>
			</li>
			<li>
				<a href="<c:url value='/blog/add' />"><i class="glyphicon glyphicon-floppy-disk"></i> 写日志</a>
			</li>
			<!-- <li>
				<a href="#">应用</a>
			</li> -->
			<li>
				<i class="glyphicon glyphicon-cog"></i> 功能列表
			</li>
			<li class="active">
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
		  <li class="active">Photo</li>
		</ol>
		
		<div class="panel panel-success">
			<div class="panel-heading">
				头像
			</div>
			<div class="panel-body">
			   <div class="row">
			   		<div class="col-md-3">
			   			<a href="#" class="thumbnail">
					      <img src="${ctx }/images/xiaoxin.jpg" alt="...">
					    </a>
			   		</div>
			   		<div class="col-md-9">
			        	<form method="post" name="uploadForm" id="uploadForm" action="${ctx }/set/photo/upload" enctype="multipart/form-data">
			        		<div class="input-group" style="width: 400px;">
						      <input type="text" name="uploadFile" id="uploadFile" class="form-control">
						      <span class="input-group-btn">
						        <button id="show" class="btn btn-default" type="button">浏览 ...</button>
						      </span>
						    	<div id="tips" style="float: right;padding-left: 2px;color: #808080"></div>
						    </div>
						    <div style="display: none;">
						    	<input type="file" name="photoFile" id="photoFile">
						    </div>
			        	</form>
					    <p style="color: #808080">请选择jpg、gif格式，小于2M的图片</p>
					    <p><input type="button" id="uploadBtn" class="btn btn-primary btn-sm" value="保&nbsp;存" /></p>
			   		</div>
			   </div>       
			</div>
		</div>
				
	</div>
</div>
<!-- bottom -->
<jsp:include page="/include/include_bottom.jsp"></jsp:include>
</div>
<script type="text/javascript">
	$(document).ready(function(){
		$("#show").click(function(){
			$("#photoFile").trigger('click');
		});
		$("#photoFile").change(function(){
			$("#uploadFile").val($("#photoFile").val());
		});
		$("#uploadBtn").click(function(){
			var img = $("#uploadFile").val();
			if ($("#uploadFile").val() == ''){
				$("#tips").html("请选择图片");
				return;
			}
			//var suffix = img.substring(img.lastIndexOf(".") + 1);//图片后缀名
			//严重图片是否符合格式
			var test = /^.*?\.(gif|jpg|jpeg)$/;
			if (!test.test(img.toLowerCase())){
				$("#tips").html("请选择jpg、gif格式图片");
				return;
			}
			$("#tips").html('');
			//提交
			//$("#uploadForm").submit();
		});
	});
</script>
</body>
</html>