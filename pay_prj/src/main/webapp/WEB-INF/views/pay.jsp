<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<!-- https://github.com/iamport/ -->
<!-- https://docs.iamport.kr/sdk/javascript-sdk -->
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
	          <p data-price="100">10000원</p>
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
	          <p data-price="200">200000원</p>
	        </div>
	        <div class="itemButton">
	          <button class="orderBtn">주문하기</button>
	        </div>
	      </div>
	      
	      
	    </div>
	<script>
	
	var itemPrice = 0;
	var itemTitle = "";
	var merchant_uid = "";
	
	$(".itemSection").on("click", ".orderBtn", function(){
		itemPrice = $(this).parent().siblings(".itemPrice").children().attr("data-price");
		itemTitle = $(this).parent().siblings(".itemTitle").children().text();
		d = new Date();
		merchant_uid = "order" + d.getTime();
		iamport();
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
					name : itemTitle,
					// 금액 - 바뀌어야됨
					amount : itemPrice,
					// 구매자 이메일
					buyer_email : 'iamport@siot.do',
					// 구매자 번호
					buyer_tel : '010-1234-5678',
					// 구매자 주소
					buyer_addr : '서울특별시 강남구 삼성동', 
					// 구매자 우편번호
					buyer_postcode : '12345',
				}, function(rsp){
					let msg;
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
				});
		}
	</script>
	
</body>
</html>