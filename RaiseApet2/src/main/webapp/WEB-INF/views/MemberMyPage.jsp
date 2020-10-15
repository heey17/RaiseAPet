<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<style>
	table{
		border-collapse: collapse;
	}
</style>
<script type="text/javaScript" src="${pageContext.request.contextPath}/resources/js/jquery-3.5.1.js"></script>
<!-- 수정 페이지 비밀번호 확인 start -->
<script>
	function modifyPwCheck(){
		var passConfirm = prompt('비밀번호를 입력하세요');
		console.log('passConfirm : ' + passConfirm);

		$.ajax({
			type : "POST",
			url : "modifyPwCheck",
			data : {"passConfirm" : passConfirm},

			// 성공 시
			success : function(data){
				if(data=="OK"){
					location.href="memberModifyForm";
				}else{
					alert('비밀번호가 일치하지 않습니다.');
				}
			},

			// 실패 시
			error : function(){
				alert('modifyPwCheck 함수 통신 실패');
				}
		});
	} 
</script>
<!-- 수정 페이지 비밀번호 확인 end -->

<!-- 탈퇴 페이지 비밀번호 확인 start -->
<script>
	function deletePwCheck(){
		var passConfirm = prompt('비밀번호를 입력하세요');
		console.log('passConfirm : ' + passConfirm);

		$.ajax({
			type : "POST",
			url : "deletePwCheck",
			data : {"passConfirm" : passConfirm},

			// 성공 시
			success : function(data){
				if(data=="OK"){
					alert('탈퇴 되었습니다.');
					location.href="memberDelete";
				}else{
					alert('비밀번호가 일치하지 않습니다.');
				}
			},

			// 실패 시
			error : function(){
				alert('deletePwCheck 함수 통신 실패');
				}
		});
	} 
</script>
<!-- 탈퇴 페이지 비밀번호 확인 end -->

<!-- 로그아웃 start -->
<script>
	function memberLogout(){
		alert("로그아웃 되었습니다.")
		location.href="memberLogout";
	}
</script>
<!-- 로그아웃 end -->
</head>
<body>
	<div>
		<!-- 프로필 -->
		<img src="resources/memberFile/${sessionScope.loginUser.userImage}"/><br>
		<!-- 이미지 태그를 사용해서 src에 파일 경로를 설정하고 이름을 설정하면 뜸. -->
	
		<!-- 수정 -->
		<button onclick="modifyPwCheck()">수정</button>&nbsp;
		<!-- 탈퇴 -->
		<button onclick="deletePwCheck()">탈퇴</button><br>
	
		<!-- 회원 정보 띄우기 -->
		아이디 : ${sessionScope.loginUser.userId}<br>
		이름 : ${sessionScope.loginUser.userName}<br>
		생년월일 : ${sessionScope.loginUser.userBirth}<br>
		성별 : ${sessionScope.loginUser.userGender}<br>
		주소 : ${sessionScope.loginUser.userAddress}<br>
		이메일 : ${sessionScope.loginUser.userEmail}<br>
		전화번호 : ${sessionScope.loginUser.userPhone}<br>
		포인트 : ${sessionScope.loginUser.userPoint}<br>
		<a id="popUpBtnCoupon">쿠폰함</a>[${sessionScope.couponCount}]<br><br>
	
		<!-- 결제내역 -->
		<button id="popUpBtnPayment">결제내역</button>&nbsp;
		<!-- 문의내역 -->
		<button id="popUpBtnAsk">문의내역</button>&nbsp;
		<!-- 장바구니 -->
		<button id="popUpBtnBasket">장바구니</button>&nbsp;
		<!-- 리뷰내역 -->
		<button id="popUpBtnReview">리뷰내역</button>&nbsp;<br>
	
		<!-- 메인으로 이동 -->
		<button onclick="location.href='indexForm'">메인</button>
	</div>
</body>
<!-- 팝업창 띄우기 start -->
<script>
	var popUpBtnPayment = document.getElementById("popUpBtnPayment");
	var popUpBtnAsk = document.getElementById("popUpBtnAsk");
	var popUpBtnBasket = document.getElementById("popUpBtnBasket");
	var popUpBtnReview = document.getElementById("popUpBtnReview");
	var popUpBtnCoupon = document.getElementById("popUpBtnCoupon");
	var mywindow;

	var popupX = (window.screen.width / 2) - (750 / 2);
	// &nbsp; 만들 팝업창 좌우 크기의 1/2 만큼 보정값으로 빼주었음
	
	var popupY= (window.screen.height /2) - (1000 / 2);
	// &nbsp; 만들 팝업창 상하 크기의 1/2 만큼 보정값으로 빼주었음

	// 결제내역
	popUpBtnPayment.addEventListener("click", function(){
		mywindow = window.open("memberPaymentList", "mywindow", "width=1000, height=750, left=" + popupX + ", top=" + popupY);
	});

	// 문의내역
	popUpBtnAsk.addEventListener("click", function(){
		mywindow = window.open("memberAskList", "mywindow", "width=1000, height=750, left=" + popupX + ", top=" + popupY);
	});
	
	// 장바구니
	popUpBtnBasket.addEventListener("click", function(){
		mywindow = window.open("memberBasketList", "mywindow", "width=1000, height=750, left=" + popupX + ", top=" + popupY);
	});

	// 리뷰내역
	popUpBtnReview.addEventListener("click", function(){
		mywindow = window.open("memberReviewList", "mywindow", "width=1000, height=750, left=" + popupX + ", top=" + popupY);
	});

	// 쿠폰내역
	popUpBtnCoupon.addEventListener("click", function(){
		mywindow = window.open("memberCouponList", "mywindow", "width=1000, height=750, left=" + popupX + ", top=" + popupY);
	});
</script>
<!-- 팝업창 띄우기 end -->
</html>