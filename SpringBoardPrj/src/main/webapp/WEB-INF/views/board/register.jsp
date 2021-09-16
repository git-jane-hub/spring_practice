<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>게시물 입력</h1>
	<form action="/board/register" method="post">
		<input type="text" name="title" /><br>
		<input type="text" name="content" /><br>
		<input type="text" name="writer" /><br>
		<input type="submit" value="register"/>
	</form>
</body>
</html>