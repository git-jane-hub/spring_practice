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
	          <h2>��â�� ���� ����������</h2>
	        </div>
	        <div class="itemContent">
	          <h2>�������� �ܹ��� ������ �˴ϴ�.</h2>
	        </div>
	        <div class="itemPrice">
	          <p data-price="40000">40000��</p>
	        </div>
	        <div class="itemButton">
	          <button class="orderBtn">�ֹ��ϱ�</button>
	        </div>
	      </div>
	      
	      <div class="itemCard">
	        <div class="itemTitle">
	          <h2>�����ڸ� ���� Ű����</h2>
	        </div>
	        <div class="itemContent">
	          <h2>Ÿ�ǰ��� �׿��ִ� Ű����</h2>
	        </div>
	        <div class="itemPrice">
	          <p data-price="200000">200000��</p>
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
			name = this.parentElement.parentElement.querySelector("h2").innerHTML;
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
				buyer_email : 'iamport@siot.do',
				// ������ ��ȣ
				buyer_tel : '010-1234-5678',
				// ������ �ּ�
				buyer_addr : '����Ư���� ������ �Ｚ��', 
				// ������ ������ȣ
				buyer_postcode : '12345',
			}, function(rsp){
				console.log(rsp);
				// ���� ������ ó���� ����
				let msg;
				if(rsp.success){
					msg = '������ �Ϸ�Ǿ����ϴ�.';
					msg += '���� ID: ' + rsp.imp_uid;
					msg += '���� �ŷ� ID: ' + rsp.merchant_uid;
					msg += '���� �ݾ�: ' + rsp.paid_amount;
					msg += 'ī�� ���ι�ȣ: ' + rsp.apply_num;
				// ���� ���н� ó���� ����
				}else{
					msg = '������ �����߽��ϴ�.';
					msg += '��������: ' + rsp.error_msg;
				}
				alert(msg);
			});
	}
	iamport();
	</script>	
</body>
</html>