<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
</head>
<body>
	<h2 class="text text-success">게시글 상세 페이지</h2>
	<!-- 테이블 작성하기전에 ${vo }를 작성해서 내용이 잘 전달되어왔는지 확인 -->
	<table class="table table-hover">
			<tr>
				<th>글번호</th>
				<td>${boardvo.bno }</td>
			</tr>
			<tr>
				<th>글제목</th>
				<td>${boardvo.title }</td>
			</tr>
			<tr>
				<th>본문</th>
				<td>${boardvo.content }</td>
			</tr>
			<tr>
				<th>글쓴이</th>
				<td>${boardvo.writer }</td>
			</tr>
			<tr>
				<th>작성일</th>
				<td>${boardvo.regdate }</td>
			</tr>
			<tr>
				<th>수정일</th>
				<td>${boardvo.updatedate }</td>
			</tr>
	</table>
	<a href="/board/list">리스트로 이동</a>
</body>
</html>