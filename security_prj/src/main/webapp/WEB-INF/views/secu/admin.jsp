<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- 보안정보 확인하는 태그라이브러리 -->
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<h1>admin</h1>
	
	<h2>다양한 페이지 정보</h2>
	<!-- 태그라이브러리 설정으로 principal은 UserDetailsService에서 인증 정보를 가져옴
		 인증 정보를 principal이라는 명칭으로 표현, principal 내부에 인증과 관련된 정보가 담겨있음 -->
	<p>principal: <sec:authentication property="principal"/></p>
	<!-- 스프링 시큐리티의 User를 상속해서 생성한 CustomUser에서 멤버변수로 MemberVO를 선언하고,
		 getter를 만들었기 때문에 principal.member를 표현식에 적으면 .getMember()를 호출하는 것과 같음 -->
	<p>MemberVO: <sec:authentication property="principal.member"/></p>
	<p>사용자의 이름: <sec:authentication property="principal.member.userName"/></p>
	<!-- *** 가장 많이씀, 해당 사용자의 자격을 확인 *** -->
	<p>사용자의 아이디: <sec:authentication property="principal.member.userid"/></p>
	<p>사용자의 권한 목록: <sec:authentication property="principal.member.authList"/></p>
	<hr>
	<!-- csrf token을 사용하기 위해 form이 작성된 logout 페이지로 이동 -->
	<a href="/customLogout">로그아웃 페이지로 이동</a>
</body>
</html>