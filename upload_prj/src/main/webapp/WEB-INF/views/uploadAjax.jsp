<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<h1>Upload with Ajax</h1>
	<div class="uploadDiv">
		<input type="file" name="uploadFile" multiple />
	</div>
	<button id="uploadBtn">Upload</button>
<script>
	// ���� ǥ���� regular expression - ���ε� �� �� �ִ� Ȯ���� ����
	$(document).ready(function(){
		// ������ �̸� ���̴� �������, 4���� Ȯ���ڴ� ����
		var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
		var maxSize = 5242880;	// 5MB
		
		function checkExtension(fileName, fileSize){
			// ���� ������(5MB �̻��̸�)
			if(fileSize >= maxSize){
				alert("���� ����� �ʰ��Ǿ����ϴ�.(5MB �̸�)")
				return false;
			}
			// ���� Ȯ����
			if(regex.test(fileName)){
				alert("�ش� ������ ������ ���ε� �� �� �����ϴ�.(exe/sh/zip/alz ����)")
				return false;
			}
			return true;
		}

		$("#uploadBtn").on("click", function(e){
			// ÷�������� ���� �ڷ��� FormData
			// ajax�� �����ư�� ������ �� �����͸� ���� ��ΰ� ���� ������ �� ���� ���� ����� input�±��� ������ ä��
			var formData = new FormData();
			
			// input�±��� ������ ����
			var inputFile = $("input[name='uploadFile']");
			console.log(inputFile);
			
			// input�±��� file�� �ش��ϴ� ������ ������ ����
			var files = inputFile[0].files;
			console.log(files);
			
			// ���� ���ε带 �����ϱ� �� ���� ũ��� Ȯ���� ���� ����
			for(var i = 0; i < files.length; i++){
				if(!checkExtension(files[i].name, files[i].size)){
					return false;
				}
				formData.append("uploadFile", files[i]);
			}
			
			// �񵿱� ��û�� ���� ajax
			$.ajax({
				url: '/uploadAjaxAction',
				processData: false,
				contentType: false,
				data:formData,
				type: 'POST',
				success: function(result){
					// alertâ�� �ȶ�
					alert("Uploaded");
				}
			});// ajax
		});
	});
</script>
</body>
</html>