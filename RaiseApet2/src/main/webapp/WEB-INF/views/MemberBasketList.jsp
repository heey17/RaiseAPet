<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니</title>
<style>
	table{
		border-collapse: collapse;
	}
</style>
<script type="text/javaScript" src="${pageContext.request.contextPath}/resources/js/jquery-3.5.1.js"></script>
<script>
	function basketDelete(goodsNum){

		console.log(goodsNum);
		
		$.ajax({
			type : "GET",
			url : "basketDelete",
			data : {"goodsNum" : goodsNum},

			// 성공 시
			success : function(data){
				if(data=="OK"){
					console.log("삭제 되었습니다.");
					location.href="memberBasketList";
				} else{ // data=="NO"
					console.log("삭제 되지 않았습니다.");
				}
			}, 

			// 실패 시
			error : function(){
				alert("장바구니 삭제 함수 통신 실패");
				}
			}); // end Ajax
	}
</script>
</head>
<body>
	<h1>장바구니</h1>
	<table border="1">
		<tr>
			<th>용품 번호</th>
			<th>용품 사진</th>
			<th>용품 이름</th>
			<th>용품 종류</th>
			<th>용품 가격</th>
			<th>용품 삭제</th>
		</tr>
		
		<!-- 용품 - 장바구니 내역 출력 부분 -->
		<c:choose>
			<c:when test="${not empty basketPagingList}">
				<c:forEach var="memberBasketList" items="${basketPagingList}">
					<tr>
						<td>${memberBasketList.goodsNum}
							<input type="hidden" id="goodsNum" value="${memberBasketList.goodsNum}">
						</td>
						<td><a href="goodsView?goodsNum=${memberBasketList.goodsNum}">${memberBasketList.goodsImage1}</a></td>
						<td>${memberBasketList.goodsName}</td>
						<td>${memberBasketList.goodsCategory}</td>
						<td>${memberBasketList.goodsPrice}</td>
						<td><button onclick="basketDelete(${memberBasketList.goodsNum})">삭제</button></td>
					</tr>
				</c:forEach>
			</c:when>
			
			<c:otherwise>
				<td colspan="6">기록이 없습니다.</td>
			</c:otherwise>
		</c:choose>
	</table>
	
	<!-- 페이징 처리 -->
	<c:if test="${paging.page <= 1}">[이전]&nbsp;</c:if>
	<c:if test="${paging.page > 1}"><a href="basketPagingList?page=${paging.page-1}">[이전]</a>&nbsp;</c:if>
	
	<c:if test="${paging.page >= paging.maxPage}">[다음]&nbsp;</c:if>
	<c:if test="${paging.page < paging.maxPage}"><a href="basketPagingList?page=${paging.page+1}">[다음]</a>&nbsp;</c:if>
	<!-- 페이징 처리 -->
</body>
</html>