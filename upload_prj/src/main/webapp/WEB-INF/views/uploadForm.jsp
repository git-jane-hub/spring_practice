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
		enctype="multipart/form-data"><!-- 일반적으로 문자열 데이터를 전송하는 것과 달리 파일을 전송해야하기 때문에 추가 -->
		<input type="file" name="uploadFile" multiple /><!-- 파일 여러개를 업로드할 수 있는 multiple -->
		<button>Upload</button>
	</form>

</body>
</html>