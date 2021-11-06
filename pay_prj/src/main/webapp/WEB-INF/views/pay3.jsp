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
	<h1>��ǰ ���</h1>
		<div class="itemSection">
	      <div class="itemCard">
	        <div class="itemTitle">
	          <h1>������� ������ĵ���� �����</h1>
	        </div>
	        <div class="itemContent">
	          <h2>��Ʃ��� ������ ����� ��ǰ�� ����</h2>
	        </div>
	        <div class="itemPrice">
	          <p data-price="100">$100</p>
	        </div>
	        <div class="itemButton">
	          <button class="orderBtn">�ֹ��ϱ�</button>
	        </div>
	      </div>
	      
	      <div class="itemCard">
	        <div class="itemTitle">
	          <h1>������ ���� Ű����</h1>
	        </div>
	        <div class="itemContent">
	          <h2>Ű���� ���� �����е带 ����</h2>
	        </div>
	        <div class="itemPrice">
	          <p data-price="200">$200</p>
	        </div>
	        <div class="itemButton">
	          <button class="orderBtn">�ֹ��ϱ�</button>
	        </div>
	      </div>

	      <div class="itemCard">
	        <div class="itemTitle">
	          <h1>49��ġ ���̹� �����</h1>
	        </div>
	        <div class="itemContent">
	          <h2>���� ��Ʈ���� ����� �ϼ��� �ñ��� ȭ��</h2>
	        </div>
	        <div class="itemPrice">
	          <p data-price="300">$300</p>
	        </div>
	        <div class="itemButton">
	          <button class="orderBtn">�ֹ��ϱ�</button>
	        </div>
	      </div>
	      
	      
	    </div>
	<script>
	// https://joshua1988.github.io/web-development/javascript/event-propagation-delegation/#%EC%9D%B4%EB%B2%A4%ED%8A%B8-%EC%9C%84%EC%9E%84---event-delegation
	let merchant_uid = "";	// �ֹ���ȣ
	let name = "";			// �ֹ���
	let amount = 0;			// �ֹ��ݾ�
	
	const btns = document.querySelectorAll(".itemButton button");
	btns.forEach(function(button){	// ���� for�� ���� ����
		button.addEventListener("click", function(event){
			date = new Date();
			merchant_uid = "order" + date.getTime;	// �ֹ���ȣ ��ġ�� �ʰ� �ۼ��ϱ� ����
			name = this.parentElement.parentElement.querySelector("h1").innerHTML;
			amount = this.parentElement.parentElement.querySelector("p").dataset.price;
			iamport();
			console.log(button);
		});
	});	

	IMP.init('imp97743578');
	function iamport(){
			IMP.request_pay({
				// KG�̴Ͻý�
				pg : 'html5_inicis',
				// ��������
				pay_method : 'card',
				// ��ǰ���� �����ϴ� �ֹ���ȣ�� ���� - �ٲ��ߵ�
				merchant_uid : merchant_uid,
				// ����â�� ������ ��ǰ�� - �ٲ��ߵ�
				name : name,
				// �ݾ� - �ٲ��ߵ�
				amount : amount,
				// ������ �̸���
				buyer_email : 'choiwodls@naver.com',
				// ������ ��ȣ
				buyer_tel : '010-1234-5678',
				// ������ �ּ�
				buyer_addr : '����Ư���� ������ �Ｚ��', 
				// ������ �����ȣ
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
							alert(name + " ������ �Ϸ�Ǿ����ϴ�.");
							console.log("�����Ϸ��")
						}
					});
				}else{
					msg = "������ �����߽��ϴ�. ";
					msg += "���� ����: " + rsp.error_msg;
					alert(msg);
				}
				*/
			});
	}
	</script>	
</body>
</html>