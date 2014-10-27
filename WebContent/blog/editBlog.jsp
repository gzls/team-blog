<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath }" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>博客</title>
<link rel="stylesheet" type="text/css" href="${ctx }/resources/boostrap/css/bootstrap.min.css" />
<script type="text/javascript" src="${ctx }/resources/ckeditor/ckeditor.js"></script>
<style type="text/css">
</style>
</head>
<body style="background-color: #E7E7E7;">
<!-- 导航栏 -->
<jsp:include page="/include/include_top.jsp"></jsp:include>
<div class="container">
<div class="row">
	<div class="page-header">
	  <h1>${user.loginName }的博客 </h1>
	</div>
	<div class="col-md-12">
		<c:if test="${not empty msg  }">
			<div class="alert alert-danger" role="alert">
				<button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
				<strong>Error!</strong> ${msg }
			</div>
		</c:if>
		<c:if test="${not empty blog}">
			<div class="panel panel-default">
			 	<form id="submitForm" action="${ctx }/blog/publish/" method="post">
			 	  <div class="panel-heading">
					<div class="input-group">
					  <span class="input-group-addon">博客標題</span>
					  <input id="title" name="title" value="${blog.title }" type="text" class="form-control">
					  <input id="id" name="id" value="${blog.id }" type="hidden" />
					</div>
			 	  </div>
				  <div class="panel-body">
				    <textarea id="content" name="content">${blog.content }</textarea>
				    <input type="hidden" value="${blog.contentHtml }" name="contentHtml" id="contentHtml" />
				  </div>
				  <div class="panel-body">
					<div class="input-group">
						<span class="input-group-addon">分类：</span>
					  	<select id="blogType" name="blogType" class="form-control" style="width: 170px;">
					  		<c:forEach var="blogType" items="${blogTypes }">
						  		<option value="${blogType.id }">${blogType.name }</option>
					  		</c:forEach>
					  	</select>
					  	<button id="addBlogTypeBtn" type="button" class="btn btn-link">添加分类</button>
					</div>
				  </div>
			 	</form>
			</div>
			<div style="text-align: center;">
				<button id="updateBtn" type="button" class="btn btn-success">保存更改</button>
				<a id="cancel" class="btn btn-default">取消</a>
			</div>
		</c:if>
	</div>
</div>
<!-- bottom -->
<jsp:include page="/include/include_bottom.jsp"></jsp:include>
</div>
<div class="modal fade" id="alertModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
   <div class="modal-dialog">
      <div class="modal-content">
         <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" 
               aria-hidden="true">×
            </button>
            <h4 class="modal-title" id="myModalLabel">
               	提示
            </h4>
         </div>
         <div class="modal-body">
             <p id="alertInfo">
             </p>
             (按下 ESC 按钮退出)
         </div>
         <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
         </div>
      </div>
   </div>
</div>
<div class="modal fade bs-example-modal-sm" id="blogTypeModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
   <div class="modal-dialog">
      <div class="modal-content">
         <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" 
               aria-hidden="true">×
            </button>
            <h4 class="modal-title" id="myModalLabel">
               	添加博客分类
            </h4>
         </div>
         <div class="modal-body">
             <form id="categoryForm" name="categoryForm" class="form-horizontal" role="form">
	             <div class="form-group">
				    <div class="col-sm-12">
				      	分类名称：<input type="text" class="form-control" id="category" name="category"  data-container="body" data-trigger="manual" data-toggle="popover" data-placement="bottom" >
				    </div>
				  </div>
				  <p id="categoryInfo">
             	  </p>
             </form>
             
         </div>
         <div class="modal-footer">
            <button type="button" id="categorySubmitBtn" class="btn btn-primary">确定</button>
            <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
         </div>
      </div>
   </div>
</div>
<script type="text/javascript">
	$(document).ready(function(){
		//初始化編輯器
		CKEDITOR.replace('content',{skin:'moono',language:'zh-cn'});
		$("#updateBtn").click(function(){
			var title = $.trim($("#title").val());
			if (title == ''){
				$("#alertModal").modal();
				$("#alertInfo").text("請錄入標題");
				return;
			}
			var content = CKEDITOR.instances.content.getData();//ckeditor編輯框里(帶html標籤)內容
			var text = CKEDITOR.instances.content.document.getBody().getText();//純文本內容
			if (content == ''){
				$("#alertModal").modal();
				$("#alertInfo").text("請錄入內容");
				return;
			}else{
				//存儲純文本
				$("#contentHtml").val(text);
			}
			$("#alertInfo").text('');
			$("#submitForm").submit();
		});
		
		$("#addBlogTypeBtn").click(function(){
			$("#blogTypeModal").modal();
		});
		
		$("#categorySubmitBtn").click(function(){
			var category = $.trim($("#category").val());
			if (category == ''){
				$("#category").attr('data-content',"请填写分类名称");
				$("#category").popover('show');
				return;
			}
			//异步提交表单
			$("#categoryForm").ajaxSubmit({
				url : "${ctx }/blog/add_category/",
				  type : "POST",
				  dataType : "text",
				  clearForm : true,
				  resetForm : true,
				  success : function(data){
					  switch (data){
					   	case "unlogin":
					   		$("#categoryInfo").html("请先登录，再进行该操作");
					   		break;
					   	case "nullparam":
					   		$("#categoryInfo").html("请输入博客分类名称");
					   		break;
					   	case "adderror":
					   		$("#categoryInfo").html("博客分类添加失败");
					   		break;
				   		default:
				   			//添加成功
				   			var select = $("#blogType");
				   			select.append("<option selected='selected' value='"+data+"'>"+category+"</option>");
				   			$("#categoryInfo").html("");
				   			$("#blogTypeModal").modal('hide');
					  }
				  }
			});
		});
		$("#blogTypeModal").on('hide.bs.modal',function(){
			$("#categoryInfo").html('');
			$("#category").attr('data-content','');
			$("#category").popover('hide');
		});
		
		$("#cancel").click(function(){
			$("#cancel").attr("href","<c:url value='/blog' />");
		});
	});
</script>
</body>
</html>