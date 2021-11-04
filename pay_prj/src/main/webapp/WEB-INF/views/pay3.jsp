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
	          <h2>헬창을 위한 근육보충제</h2>
	        </div>
	        <div class="itemContent">
	          <h2>맛없지만 단백질 보충이 됩니다.</h2>
	        </div>
	        <div class="itemPrice">
	          <p data-price="40000">40000원</p>
	        </div>
	        <div class="itemButton">
	          <button class="orderBtn">주문하기</button>
	        </div>
	      </div>
	      
	      <div class="itemCard">
	        <div class="itemTitle">
	          <h2>개발자를 위한 키보드</h2>
	        </div>
	        <div class="itemContent">
	          <h2>타건감이 죽여주는 키보드</h2>
	        </div>
	        <div class="itemPrice">
	          <p data-price="200000">200000원</p>
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
			name = this.parentElement.parentElement.querySelector("h2").innerHTML;
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
				buyer_email : 'iamport@siot.do',
				// 구매자 번호
				buyer_tel : '010-1234-5678',
				// 구매자 주소
				buyer_addr : '서울특별시 강남구 삼성동', 
				// 구매자 우편번호
				buyer_postcode : '12345',
			}, function(rsp){
				console.log(rsp);
				// 결제 성공시 처리할 내역
				let msg;
				if(rsp.success){
					msg = '결제가 완료되었습니다.';
					msg += '고유 ID: ' + rsp.imp_uid;
					msg += '상점 거래 ID: ' + rsp.merchant_uid;
					msg += '결제 금액: ' + rsp.paid_amount;
					msg += '카드 승인번호: ' + rsp.apply_num;
				// 결제 실패시 처리할 내역
				}else{
					msg = '결제에 실패했습니다.';
					msg += '에러내용: ' + rsp.error_msg;
				}
				alert(msg);
			});
	}
	iamport();
	</script>	
</body>
</html>