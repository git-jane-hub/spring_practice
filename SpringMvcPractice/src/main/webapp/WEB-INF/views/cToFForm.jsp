<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>섭씨를 화씨로</h2>
	<form action="/cToF" method="post">
		<input type="number" name="c" placeholder="섭씨를 입력하세요"/>
		<input type="submit" value="화씨로 변환"/>
	</form>
</body>
</html>