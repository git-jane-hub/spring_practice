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
	<!-- 디버깅 -->
	글번호: ${param.pageNum }
	검색조건: ${param.searchType }
	키워드: ${param.keyword }
	<!-- 수정을 하면서 동시에 pageNum, searchType, keyword를 전달해야함 
	- 여기와 연결된 로직은 modify인데 postMapping이기 때문에 controller를 통해 데이터 전달
	param. 세개의 데이터를 모두 처리할 수 있는 SearchCriteria를 추가로 선언 -->
	<form action="/board/modify" method="post">
		<!-- 필요한 데이터를 다 보내야하기 때문에 bno를 hidden으로 작성해서 보이지 않게 전달 -->
		<input type="hidden" name="bno" value="${vo.bno }"/>
		<input type="hidden" name="pageNum" value="${param.pageNum }"/>
		<input type="hidden" name="searchType" value="${param.searchType }"/>
		<input type="hidden" name="keyword" value="${param.keyword }"/>
		글제목: <input type="text" name="title" value="${vo.title }"/><br>
		글본문: <textarea rows="10" cols="50" name="content">${vo.content }</textarea><br>
		글쓴이: <input type="text" name="writer" value="${vo.writer }" readonly/><br>
		<input type="submit" value="modify"/>
	</form>
</body>
</html>