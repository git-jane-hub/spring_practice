<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- spring security 관련 태그 라이브러리 -->
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<h1>접근에 실패했습니다.</h1>
	<!-- 403 error가 발생했을 때 뜨는 메시지? -->
	<h2><c:out value="${SPRING_SECURITY_403_EXCEPTION.getMessage() }"/></h2>
	<h2><c:out value="${errorMessage }"/></h2>
</body>
</html>