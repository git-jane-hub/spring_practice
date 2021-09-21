<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 목록</title>
</head>
<body>
	<table border="1">
		<tr>
			<th>글번호</th>
			<th>글제목</th>
			<th>글본문</th>
			<th>글쓴이</th>
			<th>작성일</th>
			<th>수정일</th>
		</tr>
		<c:forEach items="${board }" var="board">
		<tr>
			<td>${board.bno }</td>
			<td><a href="/board/detail?bno=${board.bno }">${board.title }</a></td>
			<td>${board.content }</td>
			<td>${board.writer }</td>
			<td>${board.regdate }</td>
			<td>${board.updatedate }</td>
		</tr>
		</c:forEach>
	</table>
	<a href="/board/register"><button>글작성</button></a>
</body>
</html>