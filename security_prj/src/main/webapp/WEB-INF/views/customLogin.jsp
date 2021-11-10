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
	<h1>�α��� ó�� ������</h1>
	<h2><c:out value="${error }"/></h2>
	<h2><c:out value="${logout }"/></h2>
	
	<form action="/login" method="post">
		id: <input type="text" name="username" value="admin" /><br>
		pw: <input type="text" name="password" value="admin" /><br>
		�ڵ��α���: <input type="checkbox" name="remember-me" /><br>
		<input type="submit" value="LOGIN"/>
		<!-- �α��� ���� ������ ������ ��, �ش� csrf���� �������� ���θ� Ȯ��(csrf ���� ����) -->
		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
	</form>
	
	<!-- '/naverLogin'���� �����ϸ� ��Ÿ���� ���̹��α��� �� -->
	<c:if test="${url ne null }">
		<div id="naver_id_login">
			<a href="${url }"><img width="150" src="https://developers.naver.com/doc/review_201802/CK_bEFnWMeEBjXpQ5o8N_20180202_7aot50.png" /></a>
		</div>
	</c:if>
</body>
</html>