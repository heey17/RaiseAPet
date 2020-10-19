<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결제내역</title>
<style>
	table, tr, td, th{
		border-collapse: collapse;
		margin: 0 auto;
		border-width : medium;
		border : 1px solid #474747;
		table-layout: fixed;
		/* 
			테이블의 크기 지정 및 고정 시켜야 할 경우에 사용한다
			td에서 문자열을 자르거나 숨길 수 있다.
		 */
		border-color: gray;
	}
	
	.img{
		height: 80px;
		width: 80px;
		margin-right: 10px;
		margin-left: 10px;
	}
	
	th{
		background-color: #f1d2fc;
	}
	
	.all{
		text-align: center;
		margin : 0 auto;
		width : -33%
	}	
	
	fieldset{
		border-top: 1px solid;
		border-left: none;
		border-right: none;
		border-bottom: none;
		border-color: #c886d1;
		top: 1%;
		position: relative;
	}
	
	legend{
		padding-left: 1%;
		padding-right: 1%;
		font-size: 18px;
	}
	
	header{
		margin-top: 1%
	}
	
	.btn{
		margin-top: 5px;
		margin-bottom: 5px;
		font-size: 15px;
		width: 70px;
		height: 20px;
		border: none;
		background-color: #f3d4ff;
		border-radius: 12px;
	}
</style>
<!-- ///////////////////////////////////////////// CSS ////////////////////////////////////////////// -->
<script type="text/javaScript" src="${pageContext.request.contextPath}/resources/js/jquery-3.5.1.js"></script>
<!-- ///////////////////////////////////////////// script ////////////////////////////////////////////// -->
</head>
<header>
	<div style="height:100%;  width:11.8%; margin:0 auto;">
		<a class="logo" style=" height: 100%; padding:0;">
			<img src="resources/images/logo.png" alt="Logo Image" style="float:center; height : 110px;">
		</a>
	</div>		
</header>
<body>
	<div class="all">
	
	<!-- 호텔 -->
	<div id="hotelForm">
	<fieldset>
		<legend>[호텔]</legend>
		<table border="1" style="width: 1250px">
			<tr>
				<th>예약자</th>
				<th>전화번호</th>
				<th>체크인</th>
				<th>체크아웃</th>
				<th>동물 종류</th>
				<th>특이사항</th>
				<th>결제방식</th>
				<th>가격</th>
				<th>포인트</th>
				<th>R&P</th>
			</tr>
			
			<!-- 호텔 - 결제내역 출력 할 부분 -->
			<c:choose>
				<c:when test="${not empty hotelPagingList}">
					<c:forEach var="hotelPaymentList" items="${hotelPagingList}">
						<tr>
							<td>${hotelPaymentList.hotelUserName}</td>
							<td>${hotelPaymentList.hotelUserPhone}</td>
							
							<fmt:parseDate var="parsedDateCheckIn" value="${hotelPaymentList.hotelCheckIn}" pattern="yyyy-MM-dd HH:mm"></fmt:parseDate>
							<fmt:formatDate var="newFormattedDateCheckIn" value="${parsedDateCheckIn}" pattern="yyyy-MM-dd HH:mm"/> 
							<td>${newFormattedDateCheckIn}</td>

							<fmt:parseDate var="parsedDateCheckOut" value="${hotelPaymentList.hotelCheckOut}" pattern="yyyy-MM-dd HH:mm"></fmt:parseDate>
							<fmt:formatDate var="newFormattedDateCheckOut" value="${parsedDateCheckOut}" pattern="yyyy-MM-dd HH:mm"/> 
							<td>${newFormattedDateCheckOut}</td>
							
							<td>${hotelPaymentList.hotelAnimalKind}</td>
							<td>${hotelPaymentList.hotelSpecialNote}</td>
							<td>${hotelPaymentList.hotelPayment}</td>
							<!-- 추가 -->
							<td>${hotelPaymentList.hotelReservePrice}원</td>
							<fmt:formatNumber var="hotelPayment_point" value="${hotelPaymentList.hotelReservePrice * 0.05}"/> 	
							<td>${hotelPayment_point}</td>
							<td>
							<button class="btn" onclick="location.href='reviewWriteForm?code=${hotelPaymentList.hotelCode}&reviewKind=${hotelPaymentList.kind}'">리뷰</button></td>
						</tr>
					</c:forEach>
				</c:when>
				
				<c:otherwise>
					<tr style="height: 100px">
						<td colspan="10">기록이 없습니다.</td>
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
	</div>
	
	<!-- 병원 -->
	<div id="medicalForm">
	<fieldset>
		<legend>[병원]</legend>
		<table border="1" style="width: 1250px">
			<tr>
				<th>예약 날짜</th>
				<th>예약 시간</th>
				<th>동물 종류</th>
				<th>동물 나이</th>
				<th>특이사항</th>
				<th>진료의사</th>
				<th>결제방식</th>
				<th>가격</th>
				<th>포인트</th>
				<th>R&P</th>
			</tr>
			
			<!-- 병원 - 결제내역 출력 할 부분 -->
			<c:choose>
				<c:when test="${not empty medicalPagingList}">
					<c:forEach var="medicalPaymentList" items="${medicalPagingList}">
						<tr>
							<fmt:parseDate var="medicalReserveDate" value="${medicalPaymentList.medicalReserveDate}" pattern="yyyy-MM-dd"></fmt:parseDate>
							<fmt:formatDate var="newFormattedDate" value="${medicalReserveDate}" pattern="yyyy-MM-dd"/> 
							<td>${newFormattedDate}</td>
					
							<td>${medicalPaymentList.medicalReserveTime}</td>
							
							<td>${medicalPaymentList.medicalReserveAnimalKind}</td>
							<td>${medicalPaymentList.medicalReserveAnimalAge}</td>
							<td>${medicalPaymentList.medicalReserveAnimalNote}</td>
							<td>${medicalPaymentList.medicalReserveDoctor}</td>
							<td>${medicalPaymentList.medicalReservePayment}</td>
							<td>${medicalPaymentList.medicalReservePrice}원</td>
							<fmt:formatNumber var="medicalPayment_point" value="${medicalPaymentList.medicalReservePrice * 0.05}"/> 	
							<td>${medicalPayment_point}</td>
							<td>
							<button class="btn" onclick="location.href='reviewWriteForm?code=${medicalPaymentList.medicalReserveDoctor}&reviewKind=${medicalPaymentList.kind}'">리뷰</button></td>
						</tr>
					</c:forEach>
				</c:when>
				
				<c:otherwise>
					<tr style="height: 100px">
						<td colspan="10">기록이 없습니다.</td>
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
	</div>
	
	<!-- 미용 -->
	<div id="beautyForm">
	<fieldset>
		<legend>[미용]</legend>
		<table border="1" style="width: 1250px">
			<tr>
				<th>예약 날짜</th>
				<th>예약 시간</th>
				<th>동물 종류</th>
				<th>동물 나이</th>
				<th>특이사항</th>
				<th>예약 디자인</th>
				<th>결제방식</th>
				<th>가격</th>
				<th>포인트</th>
				<th>R&P</th>
			</tr>
				
			<!-- 미용 - 결제내역 출력 할 부분 -->	
			<c:choose>
				<c:when test="${not empty beautyPagingList}">
					<c:forEach var="beautyPaymentList" items="${beautyPagingList}">
						<tr>
							<fmt:parseDate var="beautyReserveDate" value="${beautyPaymentList.beautyReserveDate}" pattern="yyyy-MM-dd"></fmt:parseDate>
							<fmt:formatDate var="newFormattedDate" value="${beautyReserveDate}" pattern="yyyy-MM-dd"/> 
							<td>${newFormattedDate}</td>
	
							<td>${beautyPaymentList.beautyReserveTime}</td>
							
							<td>${beautyPaymentList.beautyReserveAnimalKind}</td>
							<td>${beautyPaymentList.beautyReserveAnimalAge}</td>
							<td>${beautyPaymentList.beautyReserveAnimalNote}</td>
							<td>${beautyPaymentList.beautyReserveSubject}</td>
							<td>${beautyPaymentList.beautyReservePayment}</td>
							<td>${beautyPaymentList.beautyReservePrice}원</td>
							<fmt:formatNumber var="beautyPayment_point" value="${beautyPaymentList.beautyReservePrice * 0.05}"/> 	
							<td>${beautyPayment_point}</td>
							<td>
							<button class="btn" onclick="location.href='reviewWriteForm?code=${beautyPaymentList.beautyReserveDesigner}&reviewKind=${beautyPaymentList.kind}'">리뷰</button></td>
						</tr>
					</c:forEach>
				</c:when>
				
				<c:otherwise>
					<tr style="height: 100px">
						<td colspan="10">기록이 없습니다.</td>
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
	</div>
	
	<!-- 용품 -->
	<div id="goodsForm">
	<fieldset>
		<legend>[용품]</legend>
		<table border="1" style="width: 1250px">
			<tr>
				<th>용품 코드</th>
				<th>용품 사진</th>
				<th>용품 이름</th>
				<th>용품 종류</th>
				<th>용품 갯수</th>
				<th>배송지</th>
				<th>배송현황</th>
				<th>결제방식</th>
				<th>가격</th>
				<th>포인트</th>
				<th>R&P</th>
			</tr>
			
			<!-- 용품 - 결제내역 출력 할 부분 -->
			<c:choose>
				<c:when test="${not empty goodsPagingList}">
					<c:forEach var="goodsPaymentList" items="${goodsPagingList}">
						<tr>
							<td>${goodsPaymentList.buyGoodsNum}</td>
							<td><a href="goodsView?goodsNum=${goodsPaymentList.buyGoodsNum}">
							<img class="img" style="margin-left: 15%" src="resources/goodsFile/${goodsPaymentList.goodsImage1}"/></a></td>
							<td>${goodsPaymentList.goodsName}</td>
							<td>${goodsPaymentList.goodsCategory}</td>
							<td>${goodsPaymentList.buyCount}</td>
							<td style="width: 50px">${goodsPaymentList.buyAddress}</td>
							<td>${goodsPaymentList.buyDelevery}</td>
							<td>${goodsPaymentList.buyPayment}</td>
							<fmt:formatNumber var="buyPrice" value="${goodsPaymentList.buyPrice + 2500}"/> 	
							<td>${buyPrice}원</td>
							<fmt:formatNumber var="goodsPayment_point" value="${(goodsPaymentList.buyPrice + 2500) * 0.05}"/> 	
							<td>${goodsPayment_point}</td>
							<td>
							<button class="btn" onclick="location.href='reviewWriteForm?num=${goodsPaymentList.buyGoodsNum}&reviewKind=${goodsPaymentList.kind}'">리뷰</button>
							</td>
						</tr>
					</c:forEach>
				</c:when>
				
				<c:otherwise>
					<tr style="width:100px;">
						<td colspan="11">기록이 없습니다.</td>
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
	</div>
	</div>
</body>
<!-- ///////////////////////////////////////////// body ////////////////////////////////////////////// -->
</html>