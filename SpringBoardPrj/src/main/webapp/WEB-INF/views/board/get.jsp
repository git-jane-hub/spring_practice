<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
<style>
	#modDiv{
		width: 300px;
		height: 100px;
		background-color: green;
		position: absolute;
		top: 50%;
		left: 50%;
		margin-top: -5px;
		margin-left: -150px;
		padding: 10px;
		z-index: 1000;
	}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
	var modi = "${modi}";
	var bno = "${bno}"
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
	키워드: ${param.keyword }<br>
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
	</form><br>
	<div class="row">
		<h2 class="text text-success">댓글</h2>
		<!-- 댓글 입력 -->
		<div>
			<div>
				REPLYER <input type="text" name="replyer" id="newReplyWriter"/>
			</div>
			<div>
				REPLY <input type="text" name="reply" id="newReply"/>
			</div>
			<button id="replyAddBtn">ADD REPLY</button>
		</div>
		<!-- 댓글이 조회되는 목록 -->
		<div id="replies">
	
		</div>
	</div>
	
	
	<!-- modal -->
	<div id="modDiv" style="display:none;">
		<div class="modal-title"></div>
		<div>
			<input type="text" id="replytext"/>
		</div>
		<div>
			<button type="button" id="replyModBtn">수정</button>
			<button type="button" id="replyDelBtn">삭제</button>
			<button type="button" id="closeBtn">닫기</button>
		</div>
	</div>
</body>
<script type="text/javascript">
	var bno = ${boardvo.bno};	// var로 작성해서 재선언가능 - 나중에 로직 수정해야됨
	function getAllList(){
		$.getJSON("/replies/all/" + bno, function(data){
			var str = "";
			console.log(data.length);
			$(data).each(function(){
				// update된 시간 정보를 받아옴
				var timestamp = this.updatedate;
				// date는 UNIX로 시간표시
				var date = new Date(timestamp);
				// UNIX로 표시된 date를 형식화해서 출력(format)
				var formattedTime = "게시일: " + date.getFullYear()	// 년도
									+ "/" + (date.getMonth() + 1)	// 월은 0부터 시작
									+ "/" + date.getDate()			// 일
									+ " " + date.getHours()			// 시간
									+ ":" + date.getMinutes()		// 분
									+ ":" + date.getSeconds();		// 초
				str += "<div data-rno = '" 
					+ this.rno + "' class = 'replyLi' ><strong>@ "
					+ this.replyer + " </strong>"
					+ formattedTime + "<br>"
					+ "<div class='reply'>" 
					+ this.reply + " </div>"
					+ "<button class='btn btn-dark'>수정/삭제</button></div>";
			});
			console.log("getalllist 로직확인: " + str);
			$("#replies").html(str);
		});
	}
	getAllList();
	
	// 댓글 작성
	$("#replyAddBtn").on("click", function(){
		// 각 input 태그에 있던 글쓴이, 본문의 value값을 변수에 저장
		var replyer = $("#newReplyWriter").val();
		var reply = $("#newReply").val();
		// 디버깅
		console.log(reply);
		console.log(replyer);
		console.log("click event 발생")
		// $.ajax(): 페이지에 입력된 어떤 자료를 서버에 전송할 때 사용
		$.ajax({
			type : 'post',
			url : '/replies',
			headers : {
				"Content-Type" : "application/json",
				"X-HTTP-Method-Override" : "POST"
			},
			dataType : 'text',
			// YARC의 payload 창에 입력되는 데이터를 작성
			data : JSON.stringify({
				// 쿼리문 컬럼명 : 해당 함수 내부의 변수명
				bno : bno,
				replyer : replyer,
				reply : reply
			}),
			// Controller에 작성된 'SUCCESS' 문자열이 반환될 경우 발생하는 함수
			success : function(result){
				if(result == 'SUCCESS'){
					alert("등록 완료");
					// 댓글을 작성한는 버튼을 누르면 갱신이 되어야하기 때문에 'SUCCESS'가 반환될 때 댓글 목록을 조회
					getAllList();
					// 댓글 작성이 완료되면 input 내부 칸을 초기화 시켜줌
					$("#newReplyWriter").val("");
					$("#newReply").val("");
				}
			}
		});
	});
	
	/* 수정/삭제(button) 전체에 onclick event를 걸기위해 전체를 포함하는 태그에서 가장 작은 범위
	 * body 태그도 버튼의 전체를 포함하지만 ul 태그(#replies)가 범위가 더 적음
	 * 위임을 할 때는 파라미터 3개: .on("click", "목적지 태그까지 요소들", function(){실행문})
	 */
	// 댓글 수정/삭제를 위한 버튼 생성
	// 이벤트 위임
	$("#replies").on("click", ".replyLi button", function(){
		var replyLi = $(this).parent();
		// .attr("속성명"): 해당 속성의 값
		var rno = replyLi.attr("data-rno");
		// button의 부모(replyLi)의 자식(.reply) div.reply의 내부 텍스트 얻기
		// var reply = $(this).parent().children(".reply").text();
		// button의 형제 중 .reply의 내부텍스트
		var reply = $(this).siblings(".reply").text();
		// 클릭 버튼에 해당하는 댓글번호+본문이 가져와지는지 디버깅
		console.log($(this).siblings(".reply"));
		console.log(rno + ":" + reply);
		
		// modal 창을 띄울수 있도록 수정
		$(".modal-title").html(rno);	// modal 상단 댓글 번호
		$("#replytext").val(reply);	// modal 수정창 댓글 본문
		$("#modDiv").show("slow");		// 창에 애니메이션 효과
	});
	
	// 댓글 수정(rno, reply 필요)
	$("#replyModBtn").on("click", function(){
		var rno = $(".modal-title").html();
		// 수정에 필요한 본문 내용은 #replytext의 value 값으로 가져오기
		var reply = $("#replytext").val();
		$.ajax({
			type : 'put',
			url : '/replies/' + rno,
			headers : {
				"Content-Type" : "application/json",
				"X-HTTP-Method-Override" : "PUT"
			},
			// 쿼리문에서 reply를 필요로하기 때문에 작성
			dataType : 'text',
			data : JSON.stringify({reply:reply}),
			success : function(result){
				if(result === "SUCCESS"){
					alert(rno + "번 댓글이 수정되었습니다.");
					$("#modDiv").hide("slow");
					getAllList();
				}
			}
		});
	});
	
	// 댓글 삭제(rno 필요)
	$("#replyDelBtn").on("click", function(){
		// 삭제에 필요한 댓글번호는 modal-title의 내용에서 가져옴
		var rno = $(".modal-title").html();
		console.log(rno);
		$.ajax({
			// 필요한 정보- rno, url, 호출타입, 전달 데이터- 없음
			type : 'delete',
			url : '/replies/' + rno,
			// 데이터 전달에 성공하면, 아래 함수를 실행
			success : function(result){
				if(result === 'SUCCESS'){
					alert(rno + "번 글이 삭제되었습니다.");
					// 모달창 hide()로 닫기
					$("#modDiv").hide("slow");
					// 댓글 목록 갱신
					getAllList();
				}
			}
		});
	});
	
	// modal 창닫기
	$("#closeBtn").on("click", function(){
		$("#modDiv").hide("fast");
	});
</script>
</html>