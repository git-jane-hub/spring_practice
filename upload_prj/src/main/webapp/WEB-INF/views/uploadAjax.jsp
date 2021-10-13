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
	// 정규 표현식 regular expression - 업로드 할 수 있는 확장자 제한
	$(document).ready(function(){
		// 파일의 이름 길이는 상관업고, 4개의 확장자는 제한
		var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
		var maxSize = 5242880;	// 5MB
		
		function checkExtension(fileName, fileSize){
			// 파일 사이즈(5MB 이상이면)
			if(fileSize >= maxSize){
				alert("파일 사이즈가 초과되었습니다.(5MB 미만)")
				return false;
			}
			// 파일 확장자
			if(regex.test(fileName)){
				alert("해당 종류의 파일은 업로드 할 수 없습니다.(exe/sh/zip/alz 제외)")
				return false;
			}
			return true;
		}

		$("#uploadBtn").on("click", function(e){
			// 첨부파일을 위한 자료형 FormData
			// ajax는 제출버튼을 눌렀을 때 데이터를 보낼 경로가 없기 때문에 빈 폼을 먼저 만들고 input태그의 정보를 채움
			var formData = new FormData();
			
			// input태그의 정보를 저장
			var inputFile = $("input[name='uploadFile']");
			console.log(inputFile);
			
			// input태그의 file에 해당하는 정보만 변수에 저장
			var files = inputFile[0].files;
			console.log(files);
			
			// 파일 업로드를 진행하기 전 파일 크기와 확장자 먼저 검증
			for(var i = 0; i < files.length; i++){
				if(!checkExtension(files[i].name, files[i].size)){
					return false;
				}
				formData.append("uploadFile", files[i]);
			}
			
			// 비동기 요청을 위한 ajax
			$.ajax({
				url: '/uploadAjaxAction',
				processData: false,
				contentType: false,
				data:formData,
				type: 'POST',
				success: function(result){
					// alert창이 안뜸
					alert("Uploaded");
				}
			});// ajax
		});
	});
</script>
</body>
</html>