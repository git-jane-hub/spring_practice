<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- �������� Ȯ���ϴ� �±׶��̺귯�� -->
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<h1>admin</h1>
	
	<h2>�پ��� ������ ����</h2>
	<!-- �±׶��̺귯�� �������� principal�� UserDetailsService���� ���� ������ ������
		 ���� ������ principal�̶�� ��Ī���� ǥ��, principal ���ο� ������ ���õ� ������ ������� -->
	<p>principal: <sec:authentication property="principal"/></p>
	<!-- ������ ��ť��Ƽ�� User�� ����ؼ� ������ CustomUser���� ��������� MemberVO�� �����ϰ�,
		 getter�� ������� ������ principal.member�� ǥ���Ŀ� ������ .getMember()�� ȣ���ϴ� �Ͱ� ���� -->
	<p>MemberVO: <sec:authentication property="principal.member"/></p>
	<p>������� �̸�: <sec:authentication property="principal.member.userName"/></p>
	<!-- *** ���� ���̾�, �ش� ������� �ڰ��� Ȯ�� *** -->
	<p>������� ���̵�: <sec:authentication property="principal.member.userid"/></p>
	<p>������� ���� ���: <sec:authentication property="principal.member.authList"/></p>
	<hr>
	<!-- csrf token�� ����ϱ� ���� form�� �ۼ��� logout �������� �̵� -->
	<a href="/customLogout">�α׾ƿ� �������� �̵�</a>
</body>
</html>