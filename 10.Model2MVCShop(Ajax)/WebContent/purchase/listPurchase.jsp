<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<title class="pageTitle">구매 목록조회</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<style type="text/css">
 #purchaseHistoryDiv{ 
 						position: absolute;
 						left:50%;
 						right:50%;
 						margin:0 auto;
 						margin-left: -250px;
 						margin-top: -350px;
 						padding: 2px;
 }

</style>

<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
<script  src="https://code.jquery.com/jquery-2.2.4.min.js"></script>

<script type="text/javascript">
	function fncGetPurchaseList(currentPage) {
		var str = "/purchase/listPurchase?";
		str = str + "currentPage=" + currentPage;
		location.href = str;
	}
	function fncGetList(currentPage) {
		document.getElementById("currentPage").value = currentPage;
		document.detailForm.submit();
	}
	

</script>
</head>

<body bgcolor="#ffffff" text="#000000">

	<div style="width: 98%; margin-left: 10px;">

		<form name="detailForm" class="listForm" action="/purchase/listPurchase" method="post">

			<table width="100%" height="37" border="0" cellpadding="0"
				cellspacing="0">
				<tr>
					<td width="15" height="37"><img src="/images/ct_ttl_img01.gif"
						width="15" height="37"></td>
					<td background="/images/ct_ttl_img02.gif" width="100%"
						style="padding-left: 10px;">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="93%" class="ct_ttl01">${user.role eq 'admin' ? "상품배송관리":"구매 목록조회"}</td>
							</tr>
						</table>
					</td>
					<td width="12" height="37"><img src="/images/ct_ttl_img03.gif"
						width="12" height="37"></td>
				</tr>
			</table>

			<table width="100%" border="0" cellspacing="0" cellpadding="0"
				style="margin-top: 10px;">
				<tr>
					<td colspan="11">전체 ${resultPage.totalCount} 건수, 현재
						${resultPage.currentPage} 페이지</td>
				</tr>
				<tr>
					<td class="ct_list_b" width="100">No</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="150">상품번호</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="150">상품명</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="150">회원ID</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="150">회원명</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b">전화번호</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b">배송현황</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b">정보수정</td>
				</tr>
				<tr>
					<td colspan="15" bgcolor="808285" height="1"></td>
				</tr>


				<c:set var="i" value="0" />
				<c:forEach var="purchase" items="${map.purchaseList}">
					<tr class="ct_list_pop">
						<td align="center">
							<a href="/purchase/getPurchase?tranNo=${purchase.tranNo}">${i+1}</a>
						</td>
						<td></td>
						<td align="left">${purchase.purchaseProd.prodNo}</td>
						<td></td>
						<td align="left">${purchase.purchaseProd.prodName}</td>
						<td></td>
						<td align="left"  class='userIdClass' >
							<p style="text-align: center; margin-top: 12px; cursor: pointer;">${purchase.buyer.userId}</p>
						</td>
						<td></td>
			
						<td align="left">${purchase.buyer.userName}</td>
						<td></td>

						<td align="left">${purchase.buyer.phone}</td>
						<td></td>
						<td align="left">현재 
						
						<c:forEach items="${map.codeList}" var="code">
							<c:if test="${purchase.tranCode eq code.code}">
								${code.codeName}
							</c:if>
						</c:forEach>
						상태 입니다.
						</td>
						<td></td>
						
						<td align="left">
						<c:choose>
							<c:when test="${user.role == 'admin'}">
								<c:if test="${purchase.tranCode=='2'}">
								<a href="/purchase/updateTranCode?tranNo=${purchase.tranNo}&tranCode=3">물품발송</a>
								</c:if>
							</c:when>
							<c:otherwise>
								<c:if test="${purchase.tranCode=='3'}">
									<a href="/purchase/updateTranCode?tranNo=${purchase.tranNo}&tranCode=4">물건도착</a>
								</c:if>
								<c:if test="${purchase.tranCode=='2'}">
									<a href="/purchase/cancelPurchase?tranNo=${purchase.tranNo}&tranCode=5">구매취소</a>
								</c:if>	
							</c:otherwise>
						</c:choose>
						</td>
					</tr>
					
				<tr>
					<td colspan="15" bgcolor="D6D7D6" height="1"></td>
				</tr>
					
					<c:set var="i" value="${i+1}" />
				</c:forEach>


			</table>

			<table width="100%" border="0" cellspacing="0" cellpadding="0"
				style="margin-top: 10px;">
				<tr>
					<td align="center">
					<input type="hidden" id="currentPage" name="currentPage" value="${search.currentPage}"/>
						<jsp:include page="../common/pageNavigator.jsp" /></td>
				</tr>
			</table>

			<!--  페이지 Navigator 끝 -->
		</form>
		
	<!-- 구매이력 -->
	<div class="purchaseHistoryDiv" id='purchaseHistoryDiv'>
		
	</div>

	</div>


</body>

<script type="text/javascript">
	
	$('.userIdClass').on('click',function(){
		var userId = $(this).text().trim();
		$('#purchaseHistoryDiv').css('display','block');
		$.ajax({
			url:"/purchase/json/getPurchaseUserHistory/"+userId,
			method:"GET",
			data:"text",
			success:function(data,status){
				 $('#purchaseHistoryDiv').html(data);
			},
			error:function(){
				alert('error');
			}
			
		});
	});
	

	

</script>
</html>