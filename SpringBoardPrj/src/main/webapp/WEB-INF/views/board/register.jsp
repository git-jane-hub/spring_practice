<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
	<h1>게시물 입력</h1>
	<form action="/board/register" method="post">
		글제목: <input type="text" name="title" placeholder="title"/><br>
		글본문: <textarea rows="10" cols="50" name="content" placeholder="content" ></textarea><br>
		글쓴이: <input type="text" name="writer" placeholder="writer"/><br>
		<input type="submit" value="register" id="submitBtn"/>
	</form>
	
	<hr>
	<h2>첨부파일</h2>
		<!-- 파일 업로드 -->
	<div class="uploadDiv">
		<input type="file" name="uploadFile" multiple />
	</div>
	<!-- 어떠한 파일이 업로드되었는지 목록을 폴더에 들어가지 않고 확인 -->
	<div class="uploadResult">
		<ul>
			<!-- 업로드된 파일 목록이 들어가는 자리 -->
		</ul>
	</div>
	<button id="uploadBtn">Upload</button>	
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
// 파일 업로드
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

	// 업로드하고나서 파일 선택을 초기화시키기 위해 미리 비어있는 .uploadDiv를 clone()
	var cloneObj = $(".uploadDiv").clone();
	
	$("#uploadBtn").on("click", function(e){
		// 첨부파일을 위한 자료형 FormData
		// ajax는 제출버튼을 눌렀을 때 데이터를 보낼 경로가 없기 때문에 빈 폼을 먼저 만들고 input태그의 정보를 채움
		var formData = new FormData();
		console.log("e: " + $(e));
		console.log("formData: " + formData);
		// input태그의 정보를 저장
		var inputFile = $("input[name='uploadFile']");
		console.log("inputFile: " + inputFile);
		
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
		
		console.log(formData);
		
		// 비동기 요청을 위한 ajax
		$.ajax({
			url: '/uploadAjaxAction',
			processData: false,
			contentType: false,
			data:formData,
			type: 'POST',
			dataType: 'json',	// 입력시 json으로 입력하지 않으면 xml 형식으로 출력
			success: function(result){
				// 업로드한 파일 내역이 콘솔창에 출력되는지 로그 출력
				console.log(result);
				showUploadedFile(result);
				//alert("Uploaded");
				
				// 파일을 업로드하고 빈 uploadDiv를 불러오면서 목록에서 사라지게 처리
				$(".uploadDiv").html(cloneObj.html());
			}
		});// ajax
	});
	
	var uploadResult = $(".uploadResult ul");
	// 이거 object로 출력됨 -..?
	console.log("uploadResult 확인: " + uploadResult);
	
	function showUploadedFile(uploadResultArr){
		var str = "";
		
		// 향상된 for문과 비슷한 .each(), i는 인덱스번호(0, 1, 2, ...), obj 그림 파일 정보가 담긴 json
		// ***obj 안나옴 -디버깅해야됨 ***
		$(uploadResultArr).each(function(i, obj){
			//console.log("i 확인: " + i);
			//console.log("obj 확인: " + obj);
			//str += "<li>" + obj.fileName + "</li>";
			
			// 이미지가 아니라면 첨부파일을 나타내고 + 파일명(obj에는 컬럼명이 들어감)
			if(!obj.image){
				var fileCallPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);
				str += "<li "
					+ "data-path='" + obj.uploadPath + "' data-uuid='" + obj.uuid
					+ "' data-filename='" + obj.fileName + "' data-type='" + obj.image
					+ "'><a href='/download?fileName="+ fileCallPath +"'>"
					+ "<img src='/resources/attachicon.jpg'>"
					+ obj.fileName +"</a>"
					+ "<span data-file=\'" + fileCallPath + "\' data-type='file'> [X] </span>"	// 업로드 삭제
					+ "</li>";
			// 이미지가 맞다면 파일명만
			}else{
				//str += "<li>" + obj.fileName + "</li>";
				// 파일 업로드시 받은 정보를 이용해서 이미지는 썸네일이 대신 출력되도록 처리 - 썸네일 주소를 요청하게 만들기
				// encodURIComponent는 모든 브라우저에서 통용되는 호출부호 - IE용
				var fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
				
				var fileCallPath2 = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);
				
				console.log(fileCallPath);
				// img의 src가 /display를 호출 - 이미지를 다운받으면 썸네일이 다운로드됨 -> fileCallPath2를 변수로 만들어 넣어줌
				str += "<li "
					+ "data-path='" + obj.uploadPath + "' data-uuid='" + obj.uuid
					+ "' data-filename='" + obj.fileName + "' data-type='" + obj.image
					+ "'><a href='/download?fileName="+ fileCallPath2 +"'>"
					+ "<img src='/display?fileName="+ fileCallPath + "'>" 
					+ obj.fileName + "</a>"
					+ "<span data-file=\'" + fileCallPath + "\' data-type='image'> [X] </span>"	// 업로드 삭제
					+ "</li>";
			}
		});
		uploadResult.append(str);
	}// end showUploadedFile
	
	$(".uploadResult").on("click", "span", function(e){
		// 이거 object로 출력됨 -..?
		console.log("e: " + $(e));
		console.log("this: " + $(this));
		// span을 누르면 삭제될 대상의 파일명
		var targetFile = $(this).data("file");
		console.log("targetFile: " + targetFile);
		
		// 삭제될 파일의 타입, image or file.. 
		var type = $(this).data("type");
		console.log("type: " + type);
		// this에서 가장 가까운 li태그를 가져오기, 이거 object로 출력됨 -...?
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
	
	$("#submitBtn").on("click", function(e){
		// 클릭된 요소의 동작을 중지(submitBtn의 제출기능을 먼저 차단)
		// 업로드된 파일의 정보를 게시글의 정보와 함께 전달해야하는데, 글쓰기가 완료되어야 파일이 몇개 첨부될지 알 수 있음
		e.preventDefault();
		
		// 위 form에 업로드된 그림요소들에 대한 정보를 추가하기위해 먼저 form에 대한 정보를 가져오기(input type=hidden을 추가하기 위함)
		var formObj = $("form");
		console.log("formObj: " + formObj);
		
		// img_tbl에 insert되는데 필요한 데이터를 작성할 str 변수
		var str = "";
		
		// .uploadResult 내부에 들어간 파일정보를 얻어와서 formObj에 넣어줌
		// .uploadResult > ul > li 의 파일정보가 여러개일 경우, 반복문을 통해 넣어줌
		$(".uploadResult ul li").each(function(i, obj){
			var imgInfo = $(obj);
			console.log("obj: " + $(obj));
			// name은 BoardVO 내부의 BoardAttchVO 변수명과 같아야 함
			str += "<input type='hidden' name='attachList[" + i + "].fileName'"
			//  + " value='" + imgInfo.attr("data-filename") + "'>" 과 같음
				+ " value='" + imgInfo.data("filename") + "'>"
				+ "<input type='hidden' name='attachList[" + i + "].uuid'"
				+ " value='" + imgInfo.data("uuid") + "'>"
				+ "<input type='hidden' name='attachList[" + i + "].uploadPath'"
				+ " value='" + imgInfo.data("path") + "'>"
				+ "<input type='hidden' name='attachList[" + i + "].image'"
				+ " value='" + imgInfo.data("type") + "'>"
		});
		
		// 반복이 끝나면, formObj에 위 태그들을 추가하고 제출
		formObj.append(str);
		// 문자열 없이 콘솔 출력해야됨
		//console.log("파일정보를 포함한 formObj: " + $(formObj));
		console.log($(formObj));
		// 제출
		formObj.submit();
	});// end submitBtn onclick
});
</script>
</body>
</html>