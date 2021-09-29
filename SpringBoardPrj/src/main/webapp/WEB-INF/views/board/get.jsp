<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
<script>
	const modi = "${modi}";
	const bno = "${bno}"
	if(modi === "modi"){
		alert(bno + "번 게시글이 수정되었습니다.");
	}
</script>
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
				<th>글본문</th>
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
	<%-- pageNum, searchType, keyword 를 파라미터로 전달받기 위한 디버깅 
	 EL의 ${param.파라미터명}을 이용하면 확인 가능
	 controller내부에서 get 파라미터에 SearchType을 선언해서 선언해도 되지만
	 파라미터에서만 사용할 데이터이기 때문에 get.jsp에서만 사용할 수 있도록 EL을 사용 --%>
	글번호: ${param.pageNum }
	검색조건: ${param.searchType }
	키워드: ${param.keyword }
	<a href="/board/list?pageNum=${param.pageNum }&searchType=${param.searchType}&keyword=${param.keyword}"><button>글목록</button></a>
	<form action="/board/boardmodify" method="post">
		<input type="hidden" name="bno" value="${boardvo.bno }"/>
		<input type="hidden" name="pageNum" value="${param.pageNum }"/>
		<input type="hidden" name="searchType" value="${param.searchType }"/>
		<input type="hidden" name="keyword" value="${param.keyword }"/>
		<input type="submit" value="글수정"/>
	</form>
	<form action="/board/remove" method="post">
		<input type="hidden" name="bno" value="${boardvo.bno }"/>
		<input type="submit" value="글삭제"/>
	</form>
</body>
</html>