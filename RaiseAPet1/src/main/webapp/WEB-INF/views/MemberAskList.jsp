<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의내역</title>
<style>
	table{
		border-collapse: collapse;
	}
</style>
</head>
<body>
	<h1>문의내역</h1>
	<table border="1">
		<tr>
			<th>용품 고유 번호</th>
			<th>문의글 번호</th>
			<th>문의글 내용</th>
			<th>비밀글 여부</th>
			<th>문의글 답변</th>
		</tr>
		
		<!-- 문의 - 문의내역 출력 할 부분 -->
		<c:choose>
			<c:when test="${not empty askPagingList}">
				<c:forEach var="memberAskList" items="${askPagingList}">
					<tr>
						<td>${memberAskList.askGoodsNum}</td>
						<td>${memberAskList.askNum}</td>
						<td><a href="goodsView?goodsNum=${memberAskList.askGoodsNum}">${memberAskList.askContents}</a></td>
						<td>${memberAskList.askSecret}</td>
						<td>${memberAskList.askAnswer}</td>
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
	
	<!-- 페이징 처리 -->
	<c:if test="${paging.page <= 1}">[이전]&nbsp;</c:if>
	<c:if test="${paging.page > 1}"><a href="askPagingList?page=${paging.page-1}">[이전]</a>&nbsp;</c:if>
	
	<c:if test="${paging.page >= paging.maxPage}">[다음]&nbsp;</c:if>
	<c:if test="${paging.page < paging.maxPage}"><a href="askPagingList?page=${paging.page+1}">[다음]</a>&nbsp;</c:if>
	<!-- 페이징 처리 -->
</body>
</html>