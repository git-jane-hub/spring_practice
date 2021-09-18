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
<script>
	/* controller에서 success라는 이름으로 전달된 자료가 있는지 확인
	 * remove 로직을 통해 redirect 되었을 때, success 데이터가 전달됨
	 */	

	const del = "${del}";
	const bno = "${bno}"
	if(del === "del"){
		alert(bno + "번 게시글이 삭제되었습니다.");
	}

	const result = "${result}";
	if(result != ""){
		alert(result + "번 게시글이 작성되었습니다.")
	}
</script>
<body>
	<h2 class="text text-warning">게시물 목록</h2>
	<form>
		<input type="text" name="keyword" value="${keyword }" placeholder="검색어를 입력하세요"/>
		<input type="submit" value="search"/>
	</form>
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
				<td><a href="/board/get?bno=${list.bno }">${list.title }</a></td>
				<td>${list.content }</td>
				<td>${list.writer }</td>
				<td>${list.regdate }</td>
				<td>${list.updatedate }</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<a href="/board/register"><button>글작성</button></a>
</body>
</html>