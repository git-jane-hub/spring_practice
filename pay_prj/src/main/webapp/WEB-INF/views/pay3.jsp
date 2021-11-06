<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<!-- https://github.com/iamport/ -->
<!-- https://docs.iamport.kr/sdk/javascript-sdk
	https://docs.iamport.kr/implementation/payment -->
<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!-- iamport.payment.js -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<title>Insert title here</title>
</head>
<body>
	<h1>상품 목록</h1>
		<div class="itemSection">
	      <div class="itemCard">
	        <div class="itemTitle">
	          <h1>블루투스 노이즈캔슬링 헤드폰</h1>
	        </div>
	        <div class="itemContent">
	          <h2>스튜디오 원음에 가까운 고품질 사운드</h2>
	        </div>
	        <div class="itemPrice">
	          <p data-price="100">$100</p>
	        </div>
	        <div class="itemButton">
	          <button class="orderBtn">주문하기</button>
	        </div>
	      </div>
	      
	      <div class="itemCard">
	        <div class="itemTitle">
	          <h1>저소음 적축 키보드</h1>
	        </div>
	        <div class="itemContent">
	          <h2>키보드 내부 흡음패드를 장착</h2>
	        </div>
	        <div class="itemPrice">
	          <p data-price="200">$200</p>
	        </div>
	        <div class="itemButton">
	          <button class="orderBtn">주문하기</button>
	        </div>
	      </div>

	      <div class="itemCard">
	        <div class="itemTitle">
	          <h1>49인치 게이밍 모니터</h1>
	        </div>
	        <div class="itemContent">
	          <h2>퀀텀 매트릭스 기술로 완성한 궁극의 화질</h2>
	        </div>
	        <div class="itemPrice">
	          <p data-price="300">$300</p>
	        </div>
	        <div class="itemButton">
	          <button class="orderBtn">주문하기</button>
	        </div>
	      </div>
	      
	      
	    </div>
	<script>
	// https://joshua1988.github.io/web-development/javascript/event-propagation-delegation/#%EC%9D%B4%EB%B2%A4%ED%8A%B8-%EC%9C%84%EC%9E%84---event-delegation
	let merchant_uid = "";	// 주문번호
	let name = "";			// 주문명
	let amount = 0;			// 주문금액
	
	const btns = document.querySelectorAll(".itemButton button");
	btns.forEach(function(button){	// 향상된 for문 같은 역할
		button.addEventListener("click", function(event){
			date = new Date();
			merchant_uid = "order" + date.getTime;	// 주문번호 겹치지 않게 작성하기 위함
			name = this.parentElement.parentElement.querySelector("h1").innerHTML;
			amount = this.parentElement.parentElement.querySelector("p").dataset.price;
			iamport();
			console.log(button);
		});
	});	

	IMP.init('imp97743578');
	function iamport(){
			IMP.request_pay({
				// KG이니시스
				pg : 'html5_inicis',
				// 결제수단
				pay_method : 'card',
				// 상품에서 관리하는 주문번호를 전달 - 바뀌어야됨
				merchant_uid : merchant_uid,
				// 결제창에 삽입할 상품명 - 바뀌어야됨
				name : name,
				// 금액 - 바뀌어야됨
				amount : amount,
				// 구매자 이메일
				buyer_email : 'choiwodls@naver.com',
				// 구매자 번호
				buyer_tel : '010-1234-5678',
				// 구매자 주소
				buyer_addr : '서울특별시 강남구 삼성동', 
				// 구매자 우편번호
				buyer_postcode : '12345',
			}, function(rsp){
				let msg;
				/*
				if(rsp.success){
					$.ajax({
						type: 'post',
						url: '/order',
						headers: {
							"Content-Type":"application/json",
							"X-HTTP-Method-Override":"POST"
						},
						dataType: "text",
						data: JSON.stringify({
							merchant_uid: merchant_uid,
							itemName: name,
							amount: amount
						}),
						success: function(){
							alert(name + " 결제가 완료되었습니다.");
							console.log("결제완료됨")
						}
					});
				}else{
					msg = "결제에 실패했습니다. ";
					msg += "실패 사유: " + rsp.error_msg;
					alert(msg);
				}
				*/
			});
	}
	</script>	
</body>
</html>