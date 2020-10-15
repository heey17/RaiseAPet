<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결제내역</title>
<style>
	table{
		border-collapse: collapse;
	}
</style>

<script>
	function paymentDelete(){
		var con = confirm("정말로 취소 하시겠습니까?");
		if(con == true){
			alert("관리자가 확인 후 연락 드리겠습니다.");
		}
	}
</script>
</head>
<body>
	<h1>결제내역</h1>
	<!-- 호텔 -->
	<fieldset>
		<legend>호텔</legend>
		<table border="1">
			<tr>
				<th>예약자</th>
				<th>핸드폰 번호</th>
				<th>체크인</th>
				<th>체크아웃</th>
				<th>동물 종류</th>
				<th>특이사항</th>
				<th>결제방식</th>
				<th>취소</th>
				<th>리뷰</th>
			</tr>
			
			<!-- 호텔 - 결제내역 출력 할 부분 -->
			<c:choose>
				<c:when test="${not empty hotelPagingList}">
					<c:forEach var="hotelPaymentList" items="${hotelPagingList}">
						<tr>
							<td>${hotelPaymentList.hotelUserName}</td>
							<td>${hotelPaymentList.hotelUserPhone}</td>
							<td>${hotelPaymentList.hotelCheckIn}</td>
							<td>${hotelPaymentList.hotelCheckOut}</td>
							<td>${hotelPaymentList.hotelAnimalKind}</td>
							<td>${hotelPaymentList.hotelSpecialNote}</td>
							<td>${hotelPaymentList.hotelPayment}</td>
							<td><button onclick="paymentDelete()">취소</button></td>
							<td><button onclick="reviewWriteForm?code=${hotelPaymentList.hotelCode}&userId=${hotelPaymentList.hotelUserId}">리뷰쓰기</button></td>
						</tr>
					</c:forEach>
				</c:when>
				
				<c:otherwise>
					<tr>
						<td colspan="9">기록이 없습니다.</td>
					</tr>
				</c:otherwise>
			</c:choose>
		</table>
				
		<!-- 페이징 처리 -->
		<c:if test="${hotelPaging.page <= 1}">[이전]&nbsp;</c:if>
		<c:if test="${hotelPaging.page > 1}"><a href="paymentPagingList?hotelPage=${hotelPaging.page-1}">[이전]</a>&nbsp;</c:if>
			
		<c:if test="${hotelPaging.page >= hotelPaging.maxPage}">[다음]&nbsp;</c:if>
		<c:if test="${hotelPaging.page < hotelPaging.maxPage}"><a href="paymentPagingList?hotelPage=${hotelPaging.page+1}">[다음]</a>&nbsp;</c:if>
		<!-- 페이징 처리 -->
	</fieldset>
	
	<!-- 병원 -->
	<fieldset>
		<legend>병원</legend>
		<table border="1">
			<tr>
				<th>예약 날짜</th>
				<th>예약 시간</th>
				<th>동물 종류</th>
				<th>동물 나이</th>
				<th>특이사항</th>
				<th>진료의사</th>
				<th>결제방식</th>
				<th>가격</th>
				<th>적립 포인트</th>
				<th>취소</th>
				<th>리뷰</th>
			</tr>
			
			<!-- 병원 - 결제내역 출력 할 부분 -->
			<c:choose>
				<c:when test="${not empty medicalPagingList}">
					<c:forEach var="medicalPaymentList" items="${medicalPagingList}">
						<tr>
							<td>${medicalPaymentList.medicalReserveDate}</td>
							<td>${medicalPaymentList.medicalReserveTime}</td>
							<td>${medicalPaymentList.medicalReserveAnimalKind}</td>
							<td>${medicalPaymentList.medicalReserveAnimalAge}</td>
							<td>${medicalPaymentList.medicalReserveAnimalNote}</td>
							<td>${medicalPaymentList.medicalReserveDoctor}</td>
							<td>${medicalPaymentList.medicalReservePayment}</td>
							<td>${medicalPaymentList.medicalReservePrice}</td>
							<td>${medicalPaymentList.medicalReservePoint}</td>
							<td><button onclick="paymentDelete()">취소</button></td>
							<td><button onclick="reviewWriteForm?code=${medicalPaymentList.medicalReserveDoctor}&userId=${medicalPaymentList.medicalReserveUserId}">리뷰쓰기</button></td>
						</tr>
					</c:forEach>
				</c:when>
				
				<c:otherwise>
					<tr>
						<td colspan="12">기록이 없습니다.</td>
					</tr>
				</c:otherwise>
			</c:choose>
		</table>	
		
		<!-- 페이징 처리 -->
		<c:if test="${medicalPaging.page <= 1}">[이전]&nbsp;</c:if>
		<c:if test="${medicalPaging.page > 1}"><a href="paymentPagingList?medicalPage=${medicalPaging.page-1}">[이전]</a>&nbsp;</c:if>
			
		<c:if test="${medicalPaging.page >= medicalPaging.maxPage}">[다음]&nbsp;</c:if>
		<c:if test="${medicalPaging.page < medicalPaging.maxPage}"><a href="paymentPagingList?medicalPage=${medicalPaging.page+1}">[다음]</a>&nbsp;</c:if>
		<!-- 페이징 처리 -->
	</fieldset>
	
	<!-- 미용 -->
	<fieldset>
		<legend>미용</legend>
		<table border="1">
			<tr>
				<th>예약 날짜</th>
				<th>예약 시간</th>
				<th>동물 종류</th>
				<th>동물 나이</th>
				<th>특이사항</th>
				<th>예약 디자인</th>
				<th>결제방식</th>
				<th>가격</th>
				<th>적립 포인트</th>
				<th>취소</th>
				<th>리뷰</th>
			</tr>
				
			<!-- 미용 - 결제내역 출력 할 부분 -->	
			<c:choose>
				<c:when test="${not empty beautyPagingList}">
					<c:forEach var="beautyPaymentList" items="${beautyPagingList}">
						<tr>
							<td>${beautyPaymentList.beautyReserveDate}</td>
							<td>${beautyPaymentList.beautyReserveTime}</td>
							<td>${beautyPaymentList.beautyReserveAnimalKind}</td>
							<td>${beautyPaymentList.beautyReserveAnimalAge}</td>
							<td>${beautyPaymentList.beautyReserveAnimalNote}</td>
							<td>${beautyPaymentList.beautyReserveSubject}</td>
							<td>${beautyPaymentList.beautyReservePayment}</td>
							<td>${beautyPaymentList.beautyReservePrice}</td>
							<td>${beautyPaymentList.beautyReservePoint}</td>
							<td><button onclick="paymentDelete()">취소</button></td>
							<td><button onclick="reviewWriteForm?code=${beautyPaymentList.beautyReserveDesigner}&userId=${beautyPaymentList.beautyReserveUserName}">리뷰쓰기</button></td>
						</tr>
					</c:forEach>
				</c:when>
				
				<c:otherwise>
					<tr>
						<td colspan="11">기록이 없습니다.</td>
					</tr>
				</c:otherwise>
			</c:choose>
		</table>
				
		<!-- 페이징 처리 -->
		<c:if test="${beautyPaging.page <= 1}">[이전]&nbsp;</c:if>
		<c:if test="${beautyPaging.page > 1}"><a href="paymentPagingList?beautyPage=${beautyPaging.page-1}">[이전]</a>&nbsp;</c:if>
			
		<c:if test="${beautyPaging.page >= beautyPaging.maxPage}">[다음]&nbsp;</c:if>
		<c:if test="${beautyPaging.page < beautyPaging.maxPage}"><a href="paymentPagingList?beautyPage=${beautyPaging.page+1}">[다음]</a>&nbsp;</c:if>
		<!-- 페이징 처리 -->
	</fieldset>
	
	<!-- 용품 -->
	<fieldset>
		<legend>용품</legend>
		<table border="1">
			<tr>
				<th>용품 코드</th>
				<th>용품 사진</th>
				<th>용품 이름</th>
				<th>용품 종류</th>
				<th>용품 구매 개수</th>
				<th>배송 할 배송지</th>
				<th>배송현황</th>
				<th>결제방식</th>
				<th>가격</th>
				<th>적립 포인트</th>
				<th>취소</th>
				<th>리뷰쓰기</th>
			</tr>
			
			<!-- 용품 - 결제내역 출력 할 부분 -->
			<c:choose>
				<c:when test="${not empty goodsPagingList}">
					<c:forEach var="goodsPaymentList" items="${goodsPagingList}">
						<tr>
							<td>${goodsPaymentList.buyGoodsNum}</td>
							<td><a href="goodsView?goodsNum=${goodsPaymentList.buyGoodsNum}">${goodsPaymentList.goodsImage1}</a></td>
							<td>${goodsPaymentList.goodsName}</td>
							<td>${goodsPaymentList.goodsCategory}</td>
							<td>${goodsPaymentList.buyCount}</td>
							<td>${goodsPaymentList.buyAddress}</td>
							<td>${goodsPaymentList.buyDelevery}</td>
							<td>${goodsPaymentList.buyPayment}</td>
							<td>${goodsPaymentList.goodsPrice}</td>
							<td>${goodsPaymentList.goodsPoint}</td>
							<td><button onclick="paymentDelete()">취소</button></td>
							<td><button onclick="reviewWriteForm?num=${goodsPaymentList.buyGoodsNum}&userId=${goodsPaymentList.buyUserId}">리뷰쓰기</button></td>
						</tr>
					</c:forEach>
				</c:when>
				
				<c:otherwise>
					<tr>
						<td colspan="12">기록이 없습니다.</td>
					</tr>
				</c:otherwise>
			</c:choose>
		</table>
				
		<!-- 페이징 처리 -->
		<c:if test="${goodsPaging.page <= 1}">[이전]&nbsp;</c:if>
		<c:if test="${goodsPaging.page > 1}"><a href="paymentPagingList?goodsPage=${goodsPaging.page-1}">[이전]</a>&nbsp;</c:if>
			
		<c:if test="${goodsPaging.page >= goodsPaging.maxPage}">[다음]&nbsp;</c:if>
		<c:if test="${goodsPaging.page < goodsPaging.maxPage}"><a href="paymentPagingList?goodsPage=${goodsPaging.page+1}">[다음]</a>&nbsp;</c:if>
		<!-- 페이징 처리 -->
	</fieldset>
</body>
</html>