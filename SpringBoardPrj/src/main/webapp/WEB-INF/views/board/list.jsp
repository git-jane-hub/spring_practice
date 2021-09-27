<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
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
	<!-- pagination
		버튼을 상황에 맞게 출력하기 위해 c태그 라이브러리의 조건식을 활용 -->
	<nav aria-label="...">
	  <ul class="pagination justify-content-center">
	  	<!-- 이전 페이지 버튼 - btnMaker의 prev가 true 일때만 출력 -->
	  	<c:if test="${btnMaker.prev }">
		    <li class="page-item">
		    <!-- 이전 페이지 버튼을 누르면 현재 보고있는 페이지의 시작페이지보다 하나더 작게 -->
		      <a class="page-link" href="/board/list?pageNum=${btnMaker.startPage - 1 }">Previous</a>
		    </li>
	    </c:if>
	    <!-- 번호 버튼 -->
	    <c:forEach var="pageNum" begin="${btnMaker.startPage }" end="${btnMaker.endPage }">
	    	<!-- 현재 페이지는 active로 표시 -->
		 <!-- <c:if test="${btnMaker.cri.pageNum == pageNum }">
		    <li class="page-item active" aria-current="page">
		    	<a class="page-link" href="/board/list?pageNum=${pageNum }">${pageNum }</a>
		    </li>
		    </c:if>
		    <c:if test="${btnMaker.cri.pageNum != pageNum }">
		    </c:if>
		    <li class="page-item">
		      <a class="page-link" href="/board/list?pageNum=${pageNum }">${pageNum }</a>
		    </li>-->
		    <!-- c:if 사용하지 않고 class 속성 내부에 삼항연산자를 사용해 작성 -->
		    <li class="page-item ${btnMaker.cri.pageNum == pageNum ? 'active' : '' }">
		      <a class="page-link" href="/board/list?pageNum=${pageNum }">${pageNum }</a>
		    </li>
		    
	   </c:forEach>
	    <!-- 다음 페이지 버튼 -->
	    <c:if test="${btnMaker.next }">
		    <li class="page-item">
		      <a class="page-link" href="/board/list?pageNum=${btnMaker.endPage + 1 }">Next</a>
		    </li>
	    </c:if>
	  </ul>
	</nav>
	<a href="/board/register"><button>글작성</button></a>
	<!-- 디버깅 -->
	${btnMaker }
	<div class="modal" id="myModal" tabindex="-1">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title">글 작성 완료</h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	        <p>${bno }번 글 작성을 완료했습니다.</p>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
	      </div>
	    </div>
	  </div>
	</div>
<!-- Bootstrap Bundle with Popper - 부트스트랩 용 js 파일도 임포트  -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ" crossorigin="anonymous"></script>
    <script>
	/* controller에서 success라는 이름으로 전달된 자료가 있는지 확인
	 * remove 로직을 통해 redirect 되었을 때, success 데이터가 전달됨
	 */	
		var result = "${success}";
		var bno = "${bno}";
		// modal 사용을 위한 변수 선언
		var myModal = new bootstrap.Modal(document.getElementById('myModal'), focus);
		if(result === "remove"){
			alert(bno + "번 게시글이 삭제되었습니다.");
		}else if(result === "register"){
			myModal.show();
		}
	</script>
</body>
</html>