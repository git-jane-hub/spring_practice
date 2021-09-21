<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="/board/modify" method="post">
		글번호: <input type="text" name="bno" value="${vo.bno }" readonly/><br>
		글제목: <input type="text" name="title" value="${vo.title }" placeholder="Please input title"/><br>
		글본문: <textarea cols="50" rows="10" name="content" >${vo.content }</textarea><br>
		글쓴이: <input type="text" name="writer" value="${vo.writer }" placeholder="Please input writer"/><br>
		<input  type="submit" value="modify"/><br>
	</form>
</body>
</html>