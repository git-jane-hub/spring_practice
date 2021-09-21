<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 작성</title>
</head>
<body>
	<form action="/board/register" method="post">
		글제목: <input type="text" name="title" placeholder="Please input title"/><br>
		글본문: <textarea cols="50" rows="10" name="content"></textarea><br>
		글쓴이: <input type="text" name="writer" placeholder="Please input writer"/><br>
		<input  type="submit" value="register"/><br>
	</form>
</body>
</html>