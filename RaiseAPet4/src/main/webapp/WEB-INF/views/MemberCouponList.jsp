<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쿠폰함</title>
<style>
	table{
		border-collapse: collapse;
	}
</style>
</head>
<body>
	<h1>쿠폰함</h1>
	<table border="1">
		<tr>
			<th>쿠폰 코드</th>
			<th>쿠폰 이름</th>
			<th>쿠폰 유효기간</th>
			<th>할인내용</th>
			<th>상세내용</th>
		</tr>
		
		<!-- 쿠폰함 - 쿠폰 내용 출력 할 부분 -->
		<c:choose>
			<c:when test="${not empty memberCouponList}">
				<c:forEach var="memberCouponList" items="${memberCouponList}">
					<tr>
						<td>${memberCouponList.couponCode}</td>
						<td>${memberCouponList.couponName}</td>
						<fmt:parseDate var="couponDate" value="${memberCouponList.couponDate}" pattern="YYYY-mm-dd"></fmt:parseDate>
						<fmt:formatDate var="newFormatted" value="${couponDate}" pattern="YYYY-mm-dd"/> 
						<td>${newFormatted}</td>
						<td>${memberCouponList.couponContents}</td>
						<fmt:formatNumber var="couponSale" value="${memberCouponList.couponSale}"/> 	
						<td>${couponSale}</td>
					</tr>
				</c:forEach>
			</c:when>
			
			<c:otherwise>
				<tr>
					<td colspan="5">기록이 없습니다.</td>
				</tr>
			</c:otherwise>
		</c:choose>
	</table>
</body>
</html>