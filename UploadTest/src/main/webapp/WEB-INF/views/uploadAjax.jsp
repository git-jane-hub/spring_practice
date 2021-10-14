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
		<!-- form 태그를 통해 파일업로드 하는것과 다른것은 form태그의 유무
			 action을 통한 목적지가 없기 때문에 button에 이벤트를 걸 예정 -->
		<input type="file" name="uploadFile" multiple>
	</div>
	
	<button id="uploadBtn">Upload</button>
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script>
		$(document).ready(function(){
			// exe, sh, zip, alz를 제한하는 정규표현식
			var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
			
			// 5MB
			var maxSize = 5242880
			
			function checkExtension(fileName, fileSize){
				if(fileSize >= maxSize){
					alert("파일 사이즈는 5MB미만이여야 합니다.");
					return false;
				}
				// .test(): 대응되는 문자열이 있는지 검사하는 메서드
				if(regex.test(fileName)){
					alert("해당 종류의 파일은 업로드할 수 없습니다.");
					return false;
				}
				return true;
			}
			
			// function(e)가 쓰여있는 위치에는 이벤트 핸들러(이벤트가 발생했을 때 실행될 함수)가 주어져야함
			// 이벤트가 발생하면 이벤트 객체가 생성이되고 해당 객체는 e라는 파라미터에 할당됨
			$('#uploadBtn').on("click", function(e){
				// 출력되는 내용이 object-...?
				console.log("function(e): " + e);
				console.log("e: " + $(e));
				var formData = new FormData();
				console.log("formData: " + formData);
				var inputFile = $("input[name='uploadFile']");
				console.log("inputFile: " + inputFile);
				var files = inputFile[0].files;
				console.log("files: " + files);
				
				for(var i = 0; i < files.length; i++){
					// true를 반환해야하는 checkExtension함수가 false를 반환했을 경우, 
					// 해당 반복문에서 false를 반환해 formData에 저장하지 않음
					if(!checkExtension(files[i].name, files[i].size)){
						return false;
					}
					// key와 value로 이루어진 formData에 key와 value값을 추가
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