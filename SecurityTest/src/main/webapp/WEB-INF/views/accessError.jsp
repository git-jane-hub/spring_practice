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
	<div>
		<i class="fas fa-exclamation-triangle"></i>
		<h1><c:out value="${errorMessage }"/></h1>
		<p>연결하려는 페이지에 접근권한이 없어 접근이 거부되었습니다.</p>
		<p>서비스 이용에 불편을 드려 죄송합니다.</p>
	</div>
	<div>
		<a href="#"><button>이전페이지</button></a>
		<a href="#"><button>홈으로</button></a>
	</div>
</body>
</html>