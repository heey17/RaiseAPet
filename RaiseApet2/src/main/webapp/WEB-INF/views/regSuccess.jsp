<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	var x = 5;

	setInterval(function(){
		x--;
	}, 1000);

	setTimeout(function(){
		alert("페이지가 이동 됩니다.");
		location.href="${pageContext.request.contextPath}/";
	}, 5000)
</script>
</head>
<body>
<div style="margin: 100px;">
		<a><img src="${pageContext.request.contextPath}/img/로고.png" style="height: 80px; margin-left: 10px;" /></a> <br>
		<br>
		<h3>안녕하세요, ${param.userId} 님</h3>
		<br>
		<p>환영합니다!</p>
		<br>
		<p>회원가입이 정상적으로 이루어 졌습니다.</p>
		<br>
		<p>로그인 하시면 홈페이지 내의 모든 서비스를 이용하실 수 있습니다.</p>
		<br> <a href="${pageContext.request.contextPath}/">로그인 페이지로 이동하기</a>
		<br>
		<h4>5초 후 자동으로 로그인 페이지로 이동 됩니다.</h4>
	</div>
</body>
</html>