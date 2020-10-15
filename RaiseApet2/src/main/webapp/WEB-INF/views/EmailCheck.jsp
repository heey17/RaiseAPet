<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	function emailCheck(){
		alert("이메일이 발송 되었습니다. 인증 후 로그인 해주세요");
		location.href="indexForm";
	}
</script>
</head>
<body onload="emailCheck()">

</body>
</html>