<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<h1>ȸ������</h1>
	<form action="/secu/join" method="post">
		<select name="auth">
			<option value="" disabled>-������ �����ϼ���.-</option>
			<option value="ROLE_USER">��ȸ��</option>
			<option value="ROLE_MEMBER">��ȸ��</option>
			<option value="ROLE_ADMIN">���</option>
		</select>
		<input type="text" name="userid" placeholder="ID" />
		<input type="password" name="userpw" placeholder="PASSWORD" />
		<input type="text" name="username" placeholder="nickname" />
		<input type="submit" value="ȸ������" />
	</form>
</body>
</html>