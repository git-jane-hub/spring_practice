<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<h1>접근 실패!</h1>
	<h2><c:out value="${SPRING_SECURITY_403_EXCEPTION.getMessage() }" /></h2>
	<h2><c:out value="${errorMessage }" /></h2>
</body>
</html>