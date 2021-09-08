<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>bmi 계산기</h2>
	<form action="/bmi" method="post">
		<input type="number" name="height" placeholder="키(cm)"/>
		<input type="number" name="weight" placeholder="몸무게(kg)"/>
		<input type="submit" value="bmi 계산"/>
	</form>
</body>
</html>