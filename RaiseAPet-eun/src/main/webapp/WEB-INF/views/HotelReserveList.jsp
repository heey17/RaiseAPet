<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>호텔 예약 리스트</title>
</head>
<body>
<div>
	<ul>
		<li><a href="hotelManagement">게시판 관리</a></li>
		<li><a href="reviewBoardList">리뷰 관리</a></li>
		<li><a href="adminMemberList">회원 관리</a></li>
		<li><a href="hotelReserveList">예약 및 결제 관리</a></li>
	</ul>
</div>
<div>
	<div style="width:30%; float:left;">
		<table>
			<tr><th><a href="hotelReserveList">호텔</a></th></tr>
			<tr><th><a href="beautyReserveList">미용</a></th></tr>
			<tr><th><a href="medicalReserveList">병원</a></th></tr>
			<tr><th><a href="goodsBuyList">용품</a></th></tr>
		</table>
	</div>
	<!-- 오른쪽 메인 화면 -->
	<div style="float : right; ">
		<c:forEach var="reserveList" items="${hotelReserveList}">
			<table style="width:100%;">
				<tr><td rowspan="6"><img src="resources/hotelFile/${reserveList.hotelRoomImage1 }" alt="호텔 사진" style="width:300px;"/></td>
					<td colspan="3">${reserveList.hotelRoomName }</td></tr>
				<tr><td colspan="3"><a onclick="goMemberView('${reserveList.hotelUserId}')">${reserveList.hotelUserId}</a></td></tr>
							<!-- 호텔 예약한 회원 정보 불러오기 -->
							<script>
								function goMemberView(userId){
									var form=document.createElement("form");
									form.setAttribute("method", "POST");
									form.setAttribute("action", "adminMemberView");
									form.setAttribute("target", "memberForm");
									
									
									var input = document.createElement('input');
									input.type="hidden";
									input.name="userId";
									input.value= userId;
									form.appendChild(input);
									
									document.body.appendChild(form);
									window.open("adminMemberView", "memberForm", "width=600, height=500");
								
									 form.submit();
								}
								</script>
				<tr><td>${reserveList.hotelCheckIn }</td>
					<td>~</td>
					<td>${reserveList.hotelCheckOut }</td></tr>
				<tr><td colspan="3">${reserveList.hotelPayment }</td></tr>
				<tr><td>${reserveList.hotelAnimalKind }</td>
					<td>/</td>
					<td>마리수</td></tr>
				<tr><td>${reserveList.hotelSpecialNote }</td></tr>
			</table>
		</c:forEach>
		<!-- 페이징 구간 -->
		<div id="paging" style="text-align : center;">
			<c:if test="${paging.page<=1 }">[이전]&nbsp;</c:if>
			<c:if test="${paging.page>1 }">
				<a href="hotelReserveList?page=${paging.page-1}">[이전]</a>&nbsp;
			</c:if> 
			<c:forEach begin="${paging.startPage}" end="${paging.endPage }" var="i" step="1">
				<c:choose>
					<c:when test="${i eq paging.page }">	
						[${i}]								
					</c:when>
					<c:otherwise>
						<a href="hotelReserveList?page=${i}">${i}</a>
					</c:otherwise>
				</c:choose>
			</c:forEach> 
			<c:if test="${paging.page>=paging.maxPage}">&nbsp;[다음]</c:if> 
			<c:if test="${paging.page<paging.maxPage}">
				&nbsp;<a href="hotelReserveList?page=${paging.page+1}">[다음]</a>
			</c:if>
		</div>
		<!-- 페이징 구간 끝 -->
	</div>
</div>
</body>
</html>