<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<h1>logout</h1>
	<form action="/customLogout" method="post">
		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
		<input type="submit" value="LOGOUT"/>	
	</form>
</body>
</html>