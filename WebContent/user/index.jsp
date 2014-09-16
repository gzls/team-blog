<%@ page contentType="text/html; charset=utf-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <link href="${pageContext.request.contextPath }/blog.css" rel="stylesheet" type="text/css">
  <title>User</title>
</head>
<body>
  <h1>User</h1>
  <c:forEach var="user" items="${users }">
	  <h3><a href="${pageContext.request.contextPath }/user/display/${user.id}">${user.name}</a></h3>
	  <p><i>Created at ${user.createTime}</i></p>
	  <p>${user.name}</p>
	  <p><a href="${pageContext.request.contextPath }/user/update/${user.id}">Edit</a> | <a href="${pageContext.request.contextPath }/user/delete/${user.id}">Delete</a></p>
	  <hr>
  </c:forEach>
  <p><a href="${pageContext.request.contextPath }/user/create">Create New User</a></p>
</body>
</html>
