<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<div class="uploadDiv">
		<!-- form �±׸� ���� ���Ͼ��ε� �ϴ°Ͱ� �ٸ����� form�±��� ����
			 action�� ���� �������� ���� ������ button�� �̺�Ʈ�� �� ���� -->
		<input type="file" name="uploadFile" multiple>
	</div>
	
	<button id="uploadBtn">Upload</button>
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script>
		$(document).ready(function(){
			// exe, sh, zip, alz�� �����ϴ� ����ǥ����
			var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
			
			// 5MB
			var maxSize = 5242880
			
			function checkExtension(fileName, fileSize){
				if(fileSize >= maxSize){
					alert("���� ������� 5MB�̸��̿��� �մϴ�.");
					return false;
				}
				// .test(): �����Ǵ� ���ڿ��� �ִ��� �˻��ϴ� �޼���
				if(regex.test(fileName)){
					alert("�ش� ������ ������ ���ε��� �� �����ϴ�.");
					return false;
				}
				return true;
			}
			
			// function(e)�� �����ִ� ��ġ���� �̺�Ʈ �ڵ鷯(�̺�Ʈ�� �߻����� �� ����� �Լ�)�� �־�������
			// �̺�Ʈ�� �߻��ϸ� �̺�Ʈ ��ü�� �����̵ǰ� �ش� ��ü�� e��� �Ķ���Ϳ� �Ҵ��
			$('#uploadBtn').on("click", function(e){
				// ��µǴ� ������ object-...?
				console.log("function(e): " + e);
				console.log("e: " + $(e));
				var formData = new FormData();
				console.log("formData: " + formData);
				var inputFile = $("input[name='uploadFile']");
				console.log("inputFile: " + inputFile);
				var files = inputFile[0].files;
				console.log("files: " + files);
				
				for(var i = 0; i < files.length; i++){
					// true�� ��ȯ�ؾ��ϴ� checkExtension�Լ��� false�� ��ȯ���� ���, 
					// �ش� �ݺ������� false�� ��ȯ�� formData�� �������� ����
					if(!checkExtension(files[i].name, files[i].size)){
						return false;
					}
					// key�� value�� �̷���� formData�� key�� value���� �߰�
					formData.append("uploadFile", files[i]);
				}
				
				$.ajax({
					url: '/uploadAjaxAction',
					processData: false,
					contentType: false,
					data: formData,
					type: 'POST', 
					success: function(result){
						alert("uploaded!");
					}
				});// end ajax
			});// end uploadBtn onclick
		});
	</script>
</body>
</html>