<!-- 
	DATE : 2020-10-7
	NAME : 오은희
	DESCRIPTION : project9
	VERSION : 3.6
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인</title> 
<!-- 로그아웃 start -->
<script>
	function memberLogout(){
		alert("로그아웃 되었습니다.");
		location.href="memberLogout";
	}
</script>
<!-- 로그아웃 end -->
<script type="text/javaScript" src="${pageContext.request.contextPath}/resources/js/jquery-3.5.1.js"></script>
<!-- 쿠폰함 갯수 start -->
<script>
	function couponCount(){

		$.ajax({
			type : "POST",
			url : "couponCount",

			// 성공 시
			success : function(data){
				if(data=="OK"){
					location.href="memberMyPage";
				}else{
					
				}
			},

			// 실패 시
			error : function(){
				alert('modifyPwCheck 함수 통신 실패');
				}
		});
	}
</script>
<!-- 쿠폰함 갯수 end -->
</head>
<body>	
	<div>
		<c:choose>
			<c:when test="${not empty sessionScope.loginUser}">
				<p>${sessionScope.loginUser.userId}님 환영합니다.</p>&nbsp;
				<button onclick="memberLogout()">로그아웃</button>&nbsp;
				<button onclick="couponCount()">마이페이지</button>
			</c:when>
		
			<c:otherwise>  
				<button onclick="location.href='memberLoginForm'">로그인</button>&nbsp;
				<button onclick="location.href='memberJoinForm'">회원가입</button>
			</c:otherwise>
		</c:choose>
	</div>
</body>
</html>

