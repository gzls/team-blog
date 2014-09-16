<%@ page contentType="text/html; charset=utf-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <link href="${pageContext.request.contextPath }/blog.css" rel="stylesheet" type="text/css">
  <title>${user.name}</title>
</head>
<body>
  <h3>${user.name}</h3>
  <p><i>Published at ${user.createTime}</i></p>
  <p>${user.name}</p>
  <p><a href="${pageContext.request.contextPath }/user/update/${user.id}">Edit</a> | <a href="${pageContext.request.contextPath }/user/delete/${user.id}">Delete</a></p>
  <hr>
  <p><a href="${pageContext.request.contextPath }/user/create">Create New user</a> | <a href="${pageContext.request.contextPath }/">Back to Main Page</a></p>
</body>
</html>
