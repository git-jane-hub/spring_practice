<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<h1>�α׾ƿ� ó�� ������</h1>
	<form action="/customLogout" method="post">
		<!-- �ش� �������� ���ؼ��� �α׾ƿ��� �̷�������� �ϰ� form ���� �׻� _csrf token �ۼ� -->
		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
		<input type="submit" value="LOGOUT" />
	</form>
</body>
</html>