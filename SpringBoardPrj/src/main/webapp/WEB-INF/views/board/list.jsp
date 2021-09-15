<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	<h2 class="text text-warning">게시물 목록</h2>
	<table class="table table-hover">
		<thead>
			<tr>
				<th>No</th>
				<th>글제목</th>
				<th>본문</th>
				<th>글쓴이</th>
				<th>등록일</th>
				<th>수정일</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${list }" var="list">
			<tr>
				<td>${list.bno }</td>
				<td>${list.title }</td>
				<td>${list.content }</td>
				<td>${list.writer }</td>
				<td>${list.regdate }</td>
				<td>${list.updatedate }</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
</body>
</html>