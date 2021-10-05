<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
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
</head>
<body>
	<h2>Ajax Test</h2>
	<!-- 댓글이 입력되는 창 -->
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
	<ul id="replies">

	</ul>
	
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
	
	<!-- jquery -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script type="text/javascript">
		// 댓글을 조회할 게시물 번호를 입력
		var bno = 10790;
		// 자주 쓰이기 때문에 함수로 묶어 처리
		function getAllList(){
			// $.getJSON(url, 함수): 페이지에서 데이터를 서버에 요청해서 가지고 올 때 사용 
			$.getJSON("/replies/all/" + bno, function(data){
				// str 변수 내부에 문자 형태로 HTML 코드를 작성
				var str = "";
				// data 변수가 얻어온 JSON 데이터의 집합
				console.log(data.length);
				/*
				아래 코드를 반복문으로 처리
					str = "<li>123</li>";
					// #replies 인 ul 태그 내부에 str을 삽입(ul > li)
					$(#replies).html(str);
				*/
				// test
				// str = "<li><a href='https://naver.com'>move to naver</a></li><li><a href='http://google.com'>move to google</a\></li>"
				// $(data).each(): 향상된 for문의 역할을 함, JSON 데이터를 가져와 댓글형태로 출력
				$(data).each(function(){
					// console.log(this);							// 댓글 하나의 정보
					// console.log(this.rno + "/" + this.reply);	// 댓글 번호 + 댓글 내용
					// console.log("-----");
					// data-rno: rno로 정렬
					str += "<li data-rno = '" + this.rno + "' class = 'replyLi' >" + this.rno + " : " + this.reply + " <button>수정/삭제</button></li>";
				});
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
			var reply = replyLi.text();	// li 태그 글씨만 가져옴
			
			// 클릭 버튼에 해당하는 댓글번호+본문이 가져와지는지 디버깅
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
	</script>
</body>
</html>


