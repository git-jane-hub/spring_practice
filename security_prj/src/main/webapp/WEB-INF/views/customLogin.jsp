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
	<h1>로그인 처리 페이지</h1>
	<h2><c:out value="${error }"/></h2>
	<h2><c:out value="${logout }"/></h2>
	
	<form action="/login" method="post">
		id: <input type="text" name="username" value="admin" /><br>
		pw: <input type="text" name="password" value="admin" /><br>
		자동로그인: <input type="checkbox" name="remember-me" /><br>
		<input type="submit" value="LOGIN"/>
		<!-- 로그인 이후 로직을 실행할 때, 해당 csrf값도 동일한지 여부를 확인(csrf 공격 방지) -->
		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
	</form>
	
	<!-- '/naverLogin'으로 접근하면 나타나는 네이버로그인 탭 -->
	<c:if test="${url ne null }">
		<div id="naver_id_login">
			<a href="${url }"><img width="150" src="https://developers.naver.com/doc/review_201802/CK_bEFnWMeEBjXpQ5o8N_20180202_7aot50.png" /></a>
		</div>
	</c:if>
</body>
</html>