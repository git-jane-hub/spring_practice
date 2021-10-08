<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<h1>login</h1>
	<h2><c:out value="${error }"/></h2>
	<h2><c:out value="${logout }"/></h2>
	
	<form action="/login" method="post">
		ID: <input type="text" name="username" value="admin" /><br>
		PW: <input type="text" name="password" value="admin" /><br>
		<input type="submit" value="LOGIN" />
		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
	</form>
</body>
</html>