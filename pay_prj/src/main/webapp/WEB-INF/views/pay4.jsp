<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<!-- jQuery -->
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<!-- iamport.payment.js -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<title>Insert title here</title>
</head>
<body>
    <div class="itemList">
      <div class="itemDetail">
        <div class="itemTitle">
          <h1>TITLE1</h1>
          <h2>DETAIL1</h2>
          <div class="price" data-price="100">$100</div>
          <div class="itemButton">
            <button class="btn">ORDER</button>
          </div>
        </div>
      </div>
      <div class="itemDetail">
        <div class="itemTitle">
          <h1>TITLE2</h1>
          <h2>DETAIL2</h2>
          <div class="price" data-price="200">$200</div>
          <div class="itemButton">
            <button class="btn">ORDER</button>
          </div>
        </div>
      </div>
      <div class="itemDetail">
        <div class="itemTitle">
          <h1>TITLE3</h1>
          <h2>DETAIL3</h2>
          <div class="price" data-price="300">$300</div>
          <div class="itemButton">
            <button class="btn">ORDER</button>
          </div>
        </div>
      </div>
    </div>
    <script>
    	let merchant_uid = "";
    	let name = "";
    	let amount = 0;
    	const btns = document.querySelectorAll(".itemButton button");
    	btns.forEach(function(button){
    		button.addEventListener("click", function(event){
    			date = new Date();
				merchant_uid = "order_" + date.getDate();
    			name = this.parentElement.parentElement.children[0].innerHTML;
    			amount = this.parentElement.parentElement.children[2].dataset.price;
    			requestPay();
    		});
    	});
    	
    
    	function requestPay(){
    		IMP.init("imp97743578");	// 이거 먼저 호출해야됨 - 판매자코드
    		IMP.request_pay({
    			  pg: "html5_inicis",
    	          pay_method: "card",
    	          // 변경
    	          merchant_uid: merchant_uid,
    	          // 변경
    	          name: name,
    	          // 변경
    	          amount: amount,
    	          buyer_email: "gildong@gmail.com",
    	          buyer_name: "홍길동",
    	          buyer_tel: "010-4242-4242",
    	          buyer_addr: "서울특별시 강남구 신사동",
    	          buyer_postcode: "01181"
    	      }, function (rsp) { // callback
    	    	  let msg;
    	          if (rsp.success) {
    	              // 결제 성공 시 로직
    	              msg = '결제에 성공했습니다.' + '\n';
    	              msg += '고유 ID: ' + rsp.imp_uid + '\n';
    	              msg += '상점 거래 ID: ' + rsp.merchant_uid + '\n';
    	              msg += '결제 금액: ' + rsp.paid_amount + '\n';
    	              msg += '카드 승인번호: ' + rsp.apply_num;
    	          } else {
    	              // 결제 실패 시 로직
    	        	  msg = '결제에 실패했습니다.\n';
    	        	  msg += '실패 사유: ' + rsp.error_msg + '.';    	              
    	          }
    	          alert(msg);
    	      });
    	}
    </script>
</body>
</html>