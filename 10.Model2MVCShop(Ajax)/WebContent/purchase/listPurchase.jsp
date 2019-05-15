<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<title class="pageTitle">���� �����ȸ</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

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
								<td width="93%" class="ct_ttl01">${user.role eq 'admin' ? "��ǰ��۰���":"���� �����ȸ"}</td>
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
					<td colspan="11">��ü ${resultPage.totalCount} �Ǽ�, ����
						${resultPage.currentPage} ������</td>
				</tr>
				<tr></tr>
				<tr>
					<td class="ct_list_b" width="100">No</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="150">��ǰ��ȣ</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="150">��ǰ��</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="150">ȸ��ID</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="150">ȸ����</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b">��ȭ��ȣ</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b">�����Ȳ</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b">��������</td>
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
						<td align="left">
							<a href="/user/getUser?userId=${user.userId}">${purchase.buyer.userId}</a>
						</td>
						<td></td>
			
						<td align="left">${purchase.buyer.userName}</td>
						<td></td>

						<td align="left">${purchase.buyer.phone}</td>
						<td></td>
						<td align="left">���� 
						
						<c:forEach items="${map.codeList}" var="code">
							<c:if test="${purchase.tranCode eq code.code}">
								${code.codeName}
							</c:if>
						</c:forEach>
						���� �Դϴ�.
						</td>
						<td></td>
						
						<td align="left">
						<c:choose>
							<c:when test="${user.role == 'admin'}">
								<c:if test="${purchase.tranCode=='2'}">
								<a href="/purchase/updateTranCode?tranNo=${purchase.tranNo}&tranCode=3">��ǰ�߼�</a>
								</c:if>
							</c:when>
							<c:otherwise>
								<c:if test="${purchase.tranCode=='3'}">
									<a href="/purchase/updateTranCode?tranNo=${purchase.tranNo}&tranCode=4">���ǵ���</a>
								</c:if>
								<c:if test="${purchase.tranCode=='2'}">
									<a href="/purchase/cancelPurchase?tranNo=${purchase.tranNo}&tranCode=5">�������</a>
								</c:if>	
							</c:otherwise>
						</c:choose>
						</td>
					</tr>
					
					<c:set var="i" value="${i+1}" />
				</c:forEach>

				<tr>
					<td colspan="15" bgcolor="D6D7D6" height="1"></td>
				</tr>

			</table>

			<table width="100%" border="0" cellspacing="0" cellpadding="0"
				style="margin-top: 10px;">
				<tr>
					<td align="center">
					<input type="hidden" id="currentPage" name="currentPage" value="${search.currentPage}"/>
						<jsp:include page="../common/pageNavigator.jsp" /></td>
				</tr>
			</table>

			<!--  ������ Navigator �� -->
		</form>

	</div>

</body>
</html>