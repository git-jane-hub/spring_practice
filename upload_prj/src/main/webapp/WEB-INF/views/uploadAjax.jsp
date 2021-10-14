<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<meta charset="EUC-KR">
<title>Insert title here</title>
<style>
	.uploadResult{
		width: 100%;
		background-color: gray;
	}
	.uploadResult ul{
		display: flex;
		flex-flow: row;
		justify-content:center;
		align-items: center;
	}
	.uploadResult ul li{
		list-style: none;
		padding: 10px;
	}
	.uploadResult ul li img{
		width: 20px;
	}
</style>
</head>
<body>
	<h1>Upload with Ajax</h1>
	<div class="uploadDiv">
		<input type="file" name="uploadFile" multiple />
	</div>
	
	<!-- ��� ������ ���ε�Ǿ����� ����� ������ ���� �ʰ� Ȯ�� -->
	<div class="uploadResult">
		<ul>
			<!-- ���ε�� ���� ����� ���� �ڸ� -->
		</ul>
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

		// ���ε��ϰ��� ���� ������ �ʱ�ȭ��Ű�� ���� �̸� ����ִ� .uploadDiv�� clone()
		var cloneObj = $(".uploadDiv").clone();
		
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
			
			console.log(formData);
			
			// �񵿱� ��û�� ���� ajax
			$.ajax({
				url: '/uploadAjaxAction',
				processData: false,
				contentType: false,
				data:formData,
				type: 'POST',
				dataType: 'json',	// �Է½� json���� �Է����� ������ xml �������� ���
				success: function(result){
					// ���ε��� ���� ������ �ܼ�â�� ��µǴ��� �α� ���
					console.log(result);
					showUploadedFile(result);
					//alert("Uploaded");
					
					// ������ ���ε��ϰ� �� uploadDiv�� �ҷ����鼭 ��Ͽ��� ������� ó��
					$(".uploadDiv").html(cloneObj.html());
				}
			});// ajax
		});
		
		var uploadResult = $(".uploadResult ul");
		// �̰� object�� ��µ� -..?
		console.log("uploadResult Ȯ��: " + uploadResult);
		
		function showUploadedFile(uploadResultArr){
			var str = "";
			
			// ���� for���� ����� .each(), i�� �ε�����ȣ(0, 1, 2, ...), obj �׸� ���� ������ ��� json
			// ***obj �ȳ��� -������ؾߵ� ***
			$(uploadResultArr).each(function(i, obj){
				//console.log("i Ȯ��: " + i);
				//console.log("obj Ȯ��: " + obj);
				//str += "<li>" + obj.fileName + "</li>";
				
				// �̹����� �ƴ϶�� ÷�������� ��Ÿ���� + ���ϸ�
				if(!obj.image){
					var fileCallPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);
					str += "<li>"
						+ "<a href='/download?fileName="+ fileCallPath +"'>"
						+ "<img src='/resources/attachicon.jpg'>"
						+ obj.fileName +"</a>"
						+ "<span data-file=\'" + fileCallPath + "\' data-type='file'> [X] </span>"	// ���ε� ����
						+ "</li>";
				// �̹����� �´ٸ� ���ϸ�
				}else{
					//str += "<li>" + obj.fileName + "</li>";
					// ���� ���ε�� ���� ������ �̿��ؼ� �̹����� ������� ��� ��µǵ��� ó�� - ����� �ּҸ� ��û�ϰ� �����
					// encodURIComponent�� ��� ���������� ���Ǵ� ȣ���ȣ - IE��
					var fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
					
					var fileCallPath2 = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);
					
					console.log(fileCallPath);
					// img�� src�� /display�� ȣ�� - �̹����� �ٿ������ ������� �ٿ�ε�� -> fileCallPath2�� ������ ����� �־���
					str += "<li>"
						+ "<a href='/download?fileName="+ fileCallPath2 +"'>"
						+ "<img src='/display?fileName="+ fileCallPath + "'>" 
						+ obj.fileName + "</a>"
						+ "<span data-file=\'" + fileCallPath + "\' data-type='image'> [X] </span>"	// ���ε� ����
						+ "</li>";
				}
			});
			uploadResult.append(str);
		}// end showUploadedFile
		
		$(".uploadResult").on("click", "span", function(e){
			// �̰� object�� ��µ� -..?
			console.log("e: " + $(e));
			console.log("this: " + $(this));
			// span�� ������ ������ ����� ���ϸ�
			var targetFile = $(this).data("file");
			console.log("targetFile: " + targetFile);
			
			// ������ ������ Ÿ��, image or file.. 
			var type = $(this).data("type");
			console.log("type: " + type);
			// this���� ���� ����� li�±׸� ��������, �̰� object�� ��µ� -...?
			var targetLi = $(this).closest("li");
			console.log("targetLi: " + targetLi);
			
			$.ajax({
				url: '/deleteFile',
				data: {fileName: targetFile, type: type},
				dataType: 'text',
				type: 'POST',
				success: function(result){
					console.log("result: " + result);
					alert(result);
					targetLi.remove();
				}
			});// end ajax
		});// click span
	});
</script>
</body>
</html>