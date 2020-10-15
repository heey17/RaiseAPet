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
					console.log("성공");
					location.href="memberMyPage";
				}else{
					console.log("실패");
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
				<button onclick="location.href='eventList'">이벤트</button>
				<button onclick="location.href='Beauty'">미용</button>
				<button onclick="location.href='Medical'">병원</button>
				<a onclick="window.open('http://pf.kakao.com/_BxlJxlK/chat','kakaochatbot','width=500, height=700, menubar=no, status=no, toolbar=no');"><img src="https://developers.kakao.com/assets/img/about/logos/channel/consult_small_yellow_pc.png" alt="카카오톡 채널 1:1 채팅 버튼" title="카카오톡 채널 1:1 채팅 버튼"></a>
			</c:when>
		
			<c:otherwise>
				<button onclick="location.href='memberLoginForm'">로그인</button>&nbsp;
				<button onclick="location.href='memberJoinForm'">회원가입</button>
				<button onclick="location.href='eventList'">이벤트</button>
				<button onclick="location.href='Beauty'">미용</button>
				<button onclick="location.href='Medical'">병원</button>
				<br><br>
				<a href="naverjoin"><img width="223" src="resources/img/naver_join.png"></a><br>
				<a href="https://kauth.kakao.com/oauth/authorize?client_id=964cb0d4419ff73c619b3139a1a93c8f&redirect_uri=http://localhost:9094/project/join&response_type=code">
				<img width="223" src="resources/img/kakao_login_large_narrow.png"></a>
				<a onclick="window.open('http://pf.kakao.com/_BxlJxlK/chat','kakaochatbot','width=500, height=700, menubar=no, status=no, toolbar=no');"><img src="https://developers.kakao.com/assets/img/about/logos/channel/consult_small_yellow_pc.png" alt="카카오톡 채널 1:1 채팅 버튼" title="카카오톡 채널 1:1 채팅 버튼"></a>

			</c:otherwise>
		</c:choose>
	</div>
</body>
</html>

