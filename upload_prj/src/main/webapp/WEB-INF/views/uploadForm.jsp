<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<form action="uploadFormAction" method="post" 
		enctype="multipart/form-data"><!-- �Ϲ������� ���ڿ� �����͸� �����ϴ� �Ͱ� �޸� ������ �����ؾ��ϱ� ������ �߰� -->
		<input type="file" name="uploadFile" multiple /><!-- ���� �������� ���ε��� �� �ִ� multiple -->
		<button>Upload</button>
	</form>

</body>
</html>