<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<table border="1">
		<tr>
			<th>글번호</th>
			<td>${vo.bno }</td>
		</tr>
		<tr>
			<th>글제목</th>
			<td>${vo.title }</td>
		</tr>
		<tr>
			<th>글본문</th>
			<td>${vo.content }</td>
		</tr>
		<tr>
			<th>글쓴이</th>
			<td>${vo.writer }</td>
		</tr>
		<tr>
			<th>작성일</th>
			<td>${vo.regdate }</td>
		</tr>
		<tr>
			<th>수정일</th>
			<td>${vo.updatedate }</td>
		</tr>
	</table>
	<a href="/board/list"><button>글목록 </button></a>
	<form action="/board/modifyform?bno=${vo.bno }" method="post">
		<input type="submit" value="글수정"/>
	</form>
	<form>
		<input type="submit" value="글삭제"/>
	</form>
	
</body>
</html>