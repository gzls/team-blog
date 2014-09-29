<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style type="text/css">
.footer{
	text-align: center;
}
</style>
<hr/>
<div class="footer">
  <div class="container">
    <p>CopyRight &copy; 2014-201? 广州脸书信息技术有限公司 blog.cmwebgame.com , All Rights Reserved</p>
  </div>
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
	         Team-Blog诞生于广州脸书。我们是一群积极向上的男青年，致力于让我们有一个更加开放、活泼的工作交流平台。
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