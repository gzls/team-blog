<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath }"></c:set>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>${currentUser.loginName }的博客 - 臉書博客</title>
<link rel="stylesheet" type="text/css" href="${ctx }/resources/boostrap/css/bootstrap.min.css" />
</head>
<body>
<!-- 导航栏 -->
<jsp:include page="/include/include_top.jsp"></jsp:include>
<div class="container">
<div class="row">
	<div class="page-header">
	  <h1>${currentUser.loginName }的博客 </h1>
	  <span><a href="${ctx }/u/${currentUser.loginName }/">http://blog.cmwebgame.com/u/${currentUser.loginName }</a></span>
	</div>
	<div class="col-md-3">
		<div class="list-group">
		<c:if test="${selfLogin == true }">
	  		 <li class="list-group-item disabled">
		  	博文<span style="float: right;"><a id="manageBTypeBtn" href="javascript:void(0);">[管理]</a></span>
		  </li>
	  	</c:if>
		  <a class="list-group-item<c:if test="${empty type }"> active</c:if>" href="${ctx }/${currentUser.loginName}/bloglist/">所有博文</a>
		  <c:forEach var="blogType" items="${blogTypes }">
		  	 <a href="${ctx }/${currentUser.loginName}/bloglist/1_${blogType.id }" class="list-group-item<c:if test="${blogType.id == type }"> active</c:if>">
			  	 <span class="badge">${blogType.blogcount }</span>
			  	 ${blogType.name }
		  	 </a>
		  </c:forEach>
		  
		</div>
		
		
	</div>
	<div class="col-md-9">
		<div>
			<ul class="nav nav-pills" role="tablist">
			  <li role="presentation"><a href="${ctx }/u/${currentUser.loginName }/">首頁</a></li>
			  <li role="presentation" class="active"><a href="${ctx }/${currentUser.loginName}/bloglist/">博文目錄</a></li>
			  <li role="presentation"><a href="#">關於我</a></li>
			</ul>
		</div>
		<hr style="height:1px;border:none;border-top:1px dashed #E7E7E7;"/>
		<c:if test="${empty blogs }">
			<div class="jumbotron">
			  <h2>Hello!</h2>
			  <p>此類型下暫無相關博文。</p>
			  <c:if test="${selfLogin == true }">
			  	<p>暫無博文？點擊 <a href="<c:url value= '/blog/add/' />">發博文</a> 寫一篇屬於自己的博文。</p>
			  	<p><a href="<c:url value= '/blog/add/' />" class="btn btn-primary btn-lg" role="button">發博文</a></p>
			  </c:if>
			</div>
		</c:if>
		<c:forEach var="blog" items="${blogs }">
			<div class="well">
				<h1>
					${blog.title }
				</h1>
				<p>
					${blog.content }
				</p>
				<p style="font-size: 12px;">
					<fmt:formatDate value="${blog.publishTime }" pattern="yyyy-MM-dd HH:mm:ss"/>
				</p>
					<a class="btn" href="${ctx }/blog/show/${blog.id }">查看</a> 
					<c:if test="${selfLogin == true }">
						 |<a class="btn" href="${ctx }/blog/edit/${blog.id }">编辑</a> |
						<a class="btn" href="${ctx }/blog/delete/${blog.id }">删除</a>
					</c:if>
				<p>
				</p>
			</div>
		</c:forEach>
		<c:if test="${not empty blogs }">
			<ul class="pager">
	  		<c:choose>
		  		<c:when test="${pageBean.page == 1 }">
		  			<li class="disabled"><a>首頁</a></li>
			  		<li class="disabled"><a>上一页</a></li>
		  		</c:when>
		  		<c:otherwise>
		  			<li><a href="${ctx }/${currentUser.loginName }/bloglist/1<c:if test="${not empty type }">_${type }</c:if>">首頁</a></li>
			  		<li><a href="${ctx }/${currentUser.loginName }/bloglist/${pageBean.page - 1 }<c:if test="${not empty type }">_${type }</c:if>">上一页</a></li>
		  		</c:otherwise>
		  	</c:choose>
		  	<c:choose>
		  		<c:when test="${pageBean.page == pageBean.totalPage }">
		  			<li class="disabled"><a>下一页</a></li>
		  			<li class="disabled"><a>末頁</a></li>
		  		</c:when>
		  		<c:otherwise>
		  			<li><a href="${ctx }/${currentUser.loginName }/bloglist/${pageBean.page + 1 }<c:if test="${not empty type }">_${type }</c:if>">下一页</a></li>
		  			<li><a href="${ctx }/${currentUser.loginName }/bloglist/${pageBean.totalPage }<c:if test="${not empty type }">_${type }</c:if>">末頁</a></li>
		  		</c:otherwise>
		  	</c:choose>
		</ul>
		
		</c:if>
	</div>
</div>
<!-- bottom -->
<jsp:include page="/include/include_bottom.jsp"></jsp:include>
</div>
<!-- 管理博客類型 -->
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
             <hr style="height:1px;border:none;border-top:1px dashed #E7E7E7;"/>
             	<c:forEach var="blogType" items="${blogTypes }">
				  	<li class="list-group-item">
				  		<span id="categoryManage" style="float: right;">
				  			<a class="edit" id="categoryEdit" name="${blogType.id }" dir="${blogType.name }" href="javascript:;">編輯</a>&nbsp;
				  			<a class="delte" id="categoryDel" href="javascript:alert('正在開發...');">刪除</a>
				  		</span>
				  		<span>${blogType.name }</span>
				  	</li>
				</c:forEach>
             <hr style="height:1px;border:none;border-top:1px dashed #E7E7E7;"/>
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
		
		$("#manageBTypeBtn").click(function(){
			$("#blogTypeModal").modal();
		});
		
		$("#blogTypeModal").on('hide.bs.modal',function(){
			$("#categoryInfo").html('');
			$("#category").attr('data-content','');
			$("#category").popover('hide');
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
					   	case "addagain":
					   		$("#categoryInfo").html("你已添加過該分類");
					   		break;
				   		default:
				   			//添加成功
				   			var html = "<li class='list-group-item'><span class='badge'>0</span><a href='#'>"+category+"</a></li>";
				   			$("#listGroup").append(html);
				   			$("#categoryInfo").html("");
				   			$("#blogTypeModal").modal('hide');
					  }
				  }
			});
		});
		
		$("#categoryManage a").click(function(){
			//編輯
			if ($(this).hasClass('edit')){
				var id = $(this).attr("name");//類型ID
				var name = $(this).attr("dir");//類型名稱
				var span = $(this).parent().next();
				var isInput = span.hasClass('hasClass');
				if (isInput){
					$(this).text('編輯');
					span.removeClass('hasClass');
					span.html(name);
					return;
				}
				var input = "<input name='categoryName' type='text' value='"+name+"' /><input type='hidden' name='categoryId' value='"+name+"' />";
				span.addClass('hasClass');
				span.html(input);
				$(this).text('確定');
				
			}
		});
	});

</script>
</body>
</html>