<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	function emailAgain(){
		var con = confirm("본인인증 후 로그인 하실 수 있습니다. 이메일 재발송을 원하시면 확인을 눌러주세요.");

		if(con == true){
			alert("메일 발송 되었습니다.");
			location.href="emailAgainSend";   
		}else{
			alert("본인인증 메일 확인 후 로그인 해주시기 바랍니다.");
			location.href="memberLoginForm";
		}
	}
</script>
</head>
<body onload="emailAgain()">

</body>
</html>