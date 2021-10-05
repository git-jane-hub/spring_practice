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
	<!-- ����� �ԷµǴ� â -->
	<div>
		<div>
			REPLYER <input type="text" name="replyer" id="newReplyWriter"/>
		</div>
		<div>
			REPLY <input type="text" name="reply" id="newReply"/>
		</div>
		<button id="replyAddBtn">ADD REPLY</button>
	</div>
	
	<!-- ����� ��ȸ�Ǵ� ��� -->
	<ul id="replies">

	</ul>
	
	<!-- modal -->
	<div id="modDiv" style="display:none;">
		<div class="modal-title"></div>
		<div>
			<input type="text" id="replytext"/>
		</div>
		<div>
			<button type="button" id="replyModBtn">����</button>
			<button type="button" id="replyDelBtn">����</button>
			<button type="button" id="closeBtn">�ݱ�</button>
		</div>
	</div>
	
	<!-- jquery -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script type="text/javascript">
		// ����� ��ȸ�� �Խù� ��ȣ�� �Է�
		var bno = 10790;
		// ���� ���̱� ������ �Լ��� ���� ó��
		function getAllList(){
			// $.getJSON(url, �Լ�): ���������� �����͸� ������ ��û�ؼ� ������ �� �� ��� 
			$.getJSON("/replies/all/" + bno, function(data){
				// str ���� ���ο� ���� ���·� HTML �ڵ带 �ۼ�
				var str = "";
				// data ������ ���� JSON �������� ����
				console.log(data.length);
				/*
				�Ʒ� �ڵ带 �ݺ������� ó��
					str = "<li>123</li>";
					// #replies �� ul �±� ���ο� str�� ����(ul > li)
					$(#replies).html(str);
				*/
				// test
				// str = "<li><a href='https://naver.com'>move to naver</a></li><li><a href='http://google.com'>move to google</a\></li>"
				// $(data).each(): ���� for���� ������ ��, JSON �����͸� ������ ������·� ���
				$(data).each(function(){
					// console.log(this);							// ��� �ϳ��� ����
					// console.log(this.rno + "/" + this.reply);	// ��� ��ȣ + ��� ����
					// console.log("-----");
					// data-rno: rno�� ����
					str += "<li data-rno = '" + this.rno + "' class = 'replyLi' >" + this.rno + " : " + this.reply + " <button>����/����</button></li>";
				});
				$("#replies").html(str);
			});
		}
		getAllList();
		
		// ��� �ۼ�
		$("#replyAddBtn").on("click", function(){
			// �� input �±׿� �ִ� �۾���, ������ value���� ������ ����
			var replyer = $("#newReplyWriter").val();
			var reply = $("#newReply").val();
			// �����
			console.log(reply);
			console.log(replyer);
			console.log("click event �߻�")
			// $.ajax(): �������� �Էµ� � �ڷḦ ������ ������ �� ���
			$.ajax({
				type : 'post',
				url : '/replies',
				headers : {
					"Content-Type" : "application/json",
					"X-HTTP-Method-Override" : "POST"
				},
				dataType : 'text',
				// YARC�� payload â�� �ԷµǴ� �����͸� �ۼ�
				data : JSON.stringify({
					// ������ �÷��� : �ش� �Լ� ������ ������
					bno : bno,
					replyer : replyer,
					reply : reply
				}),
				// Controller�� �ۼ��� 'SUCCESS' ���ڿ��� ��ȯ�� ��� �߻��ϴ� �Լ�
				success : function(result){
					if(result == 'SUCCESS'){
						alert("��� �Ϸ�");
						// ����� �ۼ��Ѵ� ��ư�� ������ ������ �Ǿ���ϱ� ������ 'SUCCESS'�� ��ȯ�� �� ��� ����� ��ȸ
						getAllList();
					}
				}
			});
		});
		/* ����/����(button) ��ü�� onclick event�� �ɱ����� ��ü�� �����ϴ� �±׿��� ���� ���� ����
		 * body �±׵� ��ư�� ��ü�� ���������� ul �±�(#replies)�� ������ �� ����
		 * ������ �� ���� �Ķ���� 3��: .on("click", "������ �±ױ��� ��ҵ�", function(){���๮})
		 */
		 
		// ��� ����/������ ���� ��ư ����
		// �̺�Ʈ ����
		$("#replies").on("click", ".replyLi button", function(){
			var replyLi = $(this).parent();
			// .attr("�Ӽ���"): �ش� �Ӽ��� ��
			var rno = replyLi.attr("data-rno");
			var reply = replyLi.text();	// li �±� �۾��� ������
			
			// Ŭ�� ��ư�� �ش��ϴ� ��۹�ȣ+������ ������������ �����
			console.log(rno + ":" + reply);
			
			// modal â�� ���� �ֵ��� ����
			$(".modal-title").html(rno);	// modal ��� ��� ��ȣ
			$("#replytext").val(reply);	// modal ����â ��� ����
			$("#modDiv").show("slow");		// â�� �ִϸ��̼� ȿ��
		});
		
		// ��� ����(rno, reply �ʿ�)
		$("#replyModBtn").on("click", function(){
			var rno = $(".modal-title").html();
			// ������ �ʿ��� ���� ������ #replytext�� value ������ ��������
			var reply = $("#replytext").val();
			$.ajax({
				type : 'put',
				url : '/replies/' + rno,
				headers : {
					"Content-Type" : "application/json",
					"X-HTTP-Method-Override" : "PUT"
				},
				// ���������� reply�� �ʿ���ϱ� ������ �ۼ�
				dataType : 'text',
				data : JSON.stringify({reply:reply}),
				success : function(result){
					if(result === "SUCCESS"){
						alert(rno + "�� ����� �����Ǿ����ϴ�.");
						$("#modDiv").hide("slow");
						getAllList();
					}
				}
			});
		});
		
		// ��� ����(rno �ʿ�)
		$("#replyDelBtn").on("click", function(){
			// ������ �ʿ��� ��۹�ȣ�� modal-title�� ���뿡�� ������
			var rno = $(".modal-title").html();
			console.log(rno);
			$.ajax({
				// �ʿ��� ����- rno, url, ȣ��Ÿ��, ���� ������- ����
				type : 'delete',
				url : '/replies/' + rno,
				// ������ ���޿� �����ϸ�, �Ʒ� �Լ��� ����
				success : function(result){
					if(result === 'SUCCESS'){
						alert(rno + "�� ���� �����Ǿ����ϴ�.");
						// ���â hide()�� �ݱ�
						$("#modDiv").hide("slow");
						// ��� ��� ����
						getAllList();
					}
				}
			});
		});
	</script>
</body>
</html>


