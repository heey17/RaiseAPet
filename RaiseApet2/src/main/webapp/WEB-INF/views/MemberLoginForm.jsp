<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<style>
	table{
		border-collapse: collapse;
	}
</style>
<script type="text/javaScript" src="${pageContext.request.contextPath}/resources/js/jquery-3.5.1.js"></script>
<script>

// 아이디 중복 확인
function loginCheck(){

	var userId = document.getElementById("userId").value;
	console.log("1 : " + userId);
	var userPw = document.getElementById("userPw").value;
	console.log("2 : " + userPw);

	var confirmLoginCheck = document.getElementById("confirmLogin");

	$.ajax({
		type : "POST",
		url : "loginCheck",
		data : {"userId" : userId, "userPw" : userPw},

		// 성공 시
		success : function(data){
			if(data=="OK"){
				memberLogin.submit();
				
			} else{ // data=="NO"
				confirmLoginCheck.style.color = "#ff0000";
				confirmLoginCheck.innerHTML = "로그인에 실패했습니다. 다시 시도 해주세요.";
			}
		}, 

		// 실패 시
		error : function(){
			alert("idOverlap 함수 통신 실패");
			}
		}); // end Ajax
	} // end idOverlap
</script>
</head>
<body>
	<form action="memberLogin" method="POST" name="memberLogin" id="memberLogin">
		<input type="text" name="userId" id="userId" placeholder="아이디" required="required"><br>
		<input type="password" name="userPw" id="userPw" placeholder="비밀번호" required="required"><br>
	</form>
	<button onclick="loginCheck()">로그인</button><br>
	<span id="confirmLogin"></span><br>
	
	<!-- SNS 계정으로 로그인 하기 start -->
	<a href="naverLogin"><img width="223" src="resources/img/naver_login.PNG"></a><br>
	<a href="https://kauth.kakao.com/oauth/authorize?client_id=964cb0d4419ff73c619b3139a1a93c8f&redirect_uri=http://localhost:9094/project/login&response_type=code">
	<img width="223" src="resources/img/kakao_account_login_btn_large_narrow.png"></a><br>
	<!-- SNS 계정으로 로그인 하기 end -->
	
	<button onclick="location.href='memberJoinForm'">회원가입</button>&nbsp;
	<button onclick="location.href='memberFindForm'">아이디/비밀번호 찾기</button>&nbsp;
	<button onclick="location.href='indexForm'">메인</button><br>
</body>
</html>