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
	          <p data-price="100">10000��</p>
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
	          <p data-price="200">200000��</p>
	        </div>
	        <div class="itemButton">
	          <button class="orderBtn">�ֹ��ϱ�</button>
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
					// KG�̴Ͻý�
					pg : 'html5_inicis',
					// ��������
					pay_method : 'card',
					// ��ǰ���� �����ϴ� �ֹ���ȣ�� ���� - �ٲ��ߵ�
					merchant_uid : merchant_uid,
					// ����â�� ������ ��ǰ�� - �ٲ��ߵ�
					name : itemTitle,
					// �ݾ� - �ٲ��ߵ�
					amount : itemPrice,
					// ������ �̸���
					buyer_email : 'iamport@siot.do',
					// ������ ��ȣ
					buyer_tel : '010-1234-5678',
					// ������ �ּ�
					buyer_addr : '����Ư���� ������ �Ｚ��', 
					// ������ �����ȣ
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
								alert(name + " ������ �Ϸ�Ǿ����ϴ�.");
								console.log("�����Ϸ��")
							}
						});
					}else{
						msg = "������ �����߽��ϴ�. ";
						msg += "���� ����: " + rsp.error_msg;
						alert(msg);
					}
				});
		}
	</script>
	
</body>
</html>