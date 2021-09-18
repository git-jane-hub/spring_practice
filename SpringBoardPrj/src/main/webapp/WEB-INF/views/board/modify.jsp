<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>게시물 수정</h1>
	<form action="/board/modify" method="post">
		<!-- 필요한 데이터를 다 보내야하기 때문에 bno를 hidden으로 작성해서 보이지 않게 전달 -->
		<input type="hidden" name="bno" value="${vo.bno }"/>
		글제목: <input type="text" name="title" value="${vo.title }"/><br>
		글본문: <textarea rows="10" cols="50" name="content">${vo.content }</textarea><br>
		글쓴이: <input type="text" name="writer" value="${vo.writer }" readonly/><br>
		<input type="submit" value="modify"/>
	</form>
</body>
</html>