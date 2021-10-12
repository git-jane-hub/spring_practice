<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<h1>all</h1>
	
	<!-- 익명의 사용자면 true -->
	<sec:authorize access="isAnonymous()">
		<!-- 로그인 하지 않은(익명의) 유저 -->
		<a href="/customLogin">로그인</a>
	</sec:authorize>

	<!-- 인증된 사용자면 true -->
	<sec:authorize access="isAuthenticated()">
		<!-- 로그인 한(인증된) 유저 -->		
		
		<!-- var속성을 지정해 property의 정보를 변수에 저장 -->
		<sec:authentication property="principal" var="secuInfo"/>
		memberVO : ${secuInfo.member }
		member 아이디: ${secuInfo.member.userid }
		member 이름: ${secuInfo.member.userName }
		${admin25 }
		<h3>${secuInfo.member.userName }님 환영합니다!</h3><br>
		<c:if test="${secuInfo.member.userName eq '운영자25' }">
			<h4>운영자25님 반갑습니다.</h4>
		</c:if>
		
		<a href="/customLogout">로그아웃</a>
	</sec:authorize>
	
</body>
</html>