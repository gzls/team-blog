<%@ page contentType="text/html; charset=utf-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <link href="${pageContext.request.contextPath }/blog.css" rel="stylesheet" type="text/css">
  <title>
  <c:choose>
  	<c:when test="${user.id == -1 }">
  		Create User
  	</c:when>
  	<c:otherwise>
  		Edit User
  	</c:otherwise>
  </c:choose>
  </title>
</head>
<body>
  <h1>
	 <c:choose>
	  	<c:when test="${user.id == -1 }">
	  		Create User
	  	</c:when>
	  	<c:otherwise>
	  		Edit User
	  	</c:otherwise>
	  </c:choose>
  </h1>
  <form name="edit" action="${pageContext.request.contextPath }/user/edit" method="post">
  <table width="360" border="0" cellpadding="3" cellspacing="0">
  <tr>
    <td width="80" align="right">Name:</td>
    <td width="268"><input name="name" value="${user.name}" type="text" maxlength="50" style="width:100%"></td>
  </tr>
  <tr>
    <td><input name="id" type="hidden" value="${user.id}"></td>
    <td><input name="submit" type="submit" value="提交"></td>
  </tr>
  </table>
  </form>
</body>
</html>
