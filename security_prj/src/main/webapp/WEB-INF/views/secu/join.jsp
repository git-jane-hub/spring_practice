<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<h1>회원가입</h1>
	<form action="/secu/join" method="post">
		<select name="auth">
			<option value="" disabled>-권한을 선택하세요.-</option>
			<option value="ROLE_USER">준회원</option>
			<option value="ROLE_MEMBER">정회원</option>
			<option value="ROLE_ADMIN">운영자</option>
		</select>
		<input type="text" name="userid" placeholder="ID" />
		<input type="password" name="userpw" placeholder="PASSWORD" />
		<input type="text" name="username" placeholder="nickname" />
		<input type="submit" value="회원가입" />
	</form>
</body>
</html>