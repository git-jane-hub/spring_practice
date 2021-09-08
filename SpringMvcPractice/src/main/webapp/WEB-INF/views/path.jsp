<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>현재 ${page} 페이지 조회중</h1>
	
	<c:if test="${page < 100 }">
		<h2>초반부 입니다.</h2>
	</c:if>
	<c:if test="${page >= 100 && page < 200 }">
		<h2>중반부 입니다.</h2>
	</c:if>
	<c:if test="${page >= 200 }">
		<h2>후반부 입니다.</h2>
	</c:if>
</body>
</html>