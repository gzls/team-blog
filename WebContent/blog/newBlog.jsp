<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>發表博客</title>
<link rel="stylesheet" type="text/css" href="${ctx }/resources/boostrap/css/bootstrap.min.css" />
<script type="text/javascript" src="${ctx }/resources/ckeditor/ckeditor.js"></script>
</head>
<body style="background-color: #E7E7E7;">
<!-- 导航栏 -->
<jsp:include page="/include/include_top.jsp"></jsp:include>
<div class="container">
	<div class="page-header">
	  <h1>${user.username }的博客 </h1>
	</div>
	<div class="panel panel-default">
 	<form id="submitForm" action="${ctx }/blog/publish" method="post">
 	  <div class="panel-heading">
		<div class="input-group">
		  <span class="input-group-addon">博客標題</span>
		  <input id="title" name="title" type="text" class="form-control"/>
		</div>
 	  </div>
	  <div class="panel-body">
	    <textarea id="content" name="content"></textarea>
	    <input type="hidden" name="contentHtml" id="contentHtml" />
	  </div>
 	</form>
</div>
<c:if test="${not empty msg }">
<div class="alert alert-danger" role="alert">
	<button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
	<strong>Error!</strong> ${msg }
</div>
</c:if>
<div style="text-align: center;">
	<button id="public" type="button" class="btn btn-primary">發表</button>
	<a id="cancel" class="btn btn-default">取消</a>
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
<script type="text/javascript">
	$(document).ready(function(){
		//初始化編輯器
		CKEDITOR.replace('content',{skin:'moono',language:'zh-cn'});
		$("#public").click(function(){
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
		$("#cancel").click(function(){
			$("#cancel").attr("href","<c:url value='/blog' />");
		});
	});
</script>
</body>
</html>