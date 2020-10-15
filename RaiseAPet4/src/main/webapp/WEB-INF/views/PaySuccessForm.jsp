<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결제 성공 페이지</title>
<style>	
	.all{
		text-align : center;
		margin : 19% 40% 5% 40%;
		padding : 20px 20px 20px 20px;
		border: 1px solid #c886d1
	}
</style>
<!-- 타이머 설정 -->
<script>
	var x = 5;
	var msg = document.getElementById("count");

    setInterval(function(){
        x--;
        msg.innerHTML = x;
    }, 1000);
    
    setTimeout(function(){
        window.close();
    }, 3000)
</script>
</head>
<body>
	<div class="all">
		<small><span id="count">3초 후 페이지가 종료 됩니다.</span></small><br>
		결제 성공 했습니다.<br>
		마이페이지 - 결제내역에서 확인 가능합니다.<br>
		이용 해주셔서 감사합니다.<br>
	</div>
</body>
</html>