<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>脸书博客-分享知识</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/boostrap/css/bootstrap.min.css" />
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-1.8.2.js" ></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/boostrap/js/bootstrap.min.js" ></script>
</head>
<body>
<!-- 导航栏 -->
<div style="padding-bottom: 40px;">
<nav class="navbar navbar-default navbar-fixed-top" role="navigation">
 <div class="navbar-header">
    <a id="aboutBlog" class="navbar-brand" href="#">广州脸书团队博客</a>
 </div>
</nav>
</div>
<div class="container">
	<div class="error-container" style="padding-top: 30px;">
<div class="well" style="height: 350px;">
<div style="padding-top: 70px;">
<p class="text-center">抱歉，该用户暂无开通博客</p>
<p class="text-center"><a href="${pageContext.request.contextPath }/blog/">返回我的博客</a></p>
</div>
</div>
</div>
<!-- bottom -->
<jsp:include page="/include/include_bottom.jsp"></jsp:include>
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
<script type="text/javascript">
$(document).ready(function(){
	  $("#aboutBlog").click(function(){
	   $('#aboutModal').modal({
	      	keyboard: true
	   });
	  });
});
</script>
</body>
</html>