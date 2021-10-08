<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<h1>로그아웃 처리 페이지</h1>
	<form action="/customLogout" method="post">
		<!-- 해당 페이지를 통해서만 로그아웃이 이루어지도록 하고 form 에는 항상 _csrf token 작성 -->
		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
		<input type="submit" value="LOGOUT" />
	</form>
</body>
</html>