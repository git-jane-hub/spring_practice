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
		<p>�����Ϸ��� �������� ���ٱ����� ���� ������ �źεǾ����ϴ�.</p>
		<p>���� �̿뿡 ������ ��� �˼��մϴ�.</p>
	</div>
	<div>
		<a href="#"><button>����������</button></a>
		<a href="#"><button>Ȩ����</button></a>
	</div>
</body>
</html>