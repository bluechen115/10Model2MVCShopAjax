<%@page import="com.model2.mvc.service.domain.Product"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">



<html>
<head>

<link rel="stylesheet" href="/css/admin.css" type="text/css">
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>

<title>��ǰ����ȸ</title>
</head>

<body bgcolor="#ffffff" text="#000000">

<form id="detailForm" >

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37"><img src="/images/ct_ttl_img01.gif"	width="15" height="37"></td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">��ǰ����ȸ</td>
					<td width="20%" align="right">&nbsp;</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="/images/ct_ttl_img03.gif"  width="12" height="37"/>
		</td>
	</tr>
</table>

<input type="hidden" id="boardNo" name="boardNo" value="${productBoard.boardNo}"/>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 13px;">
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">
			�Խñ۹�ȣ <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="105">${productBoard.boardNo}</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">
			������ <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">${productBoard.title}</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">
			��ǰ�� <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">${product.prodName}</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">
			������ <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">${productBoard.boardDetail}</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	
	<tr>
		<td width="104" class="ct_write">
			��ȸ�� <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">${productBoard.viewCount}</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	
	<tr>
		<td width="104" class="ct_write">
			��ǰ�̹��� <img 	src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
			
		</td>
			
		<td bgcolor="D6D6D6" width="1">
		</td>
		<td class="ct_write01">
		<img 	src=  "/images/uploadFiles/${product.fileName}"/> 
		</td>
	</tr>
	
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">���� ����</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">${productBoard.quantity}</td>
	</tr>
	
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">��������</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">${product.manuDate}</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">����
			<c:if test="${productBoard.boardNo == discount.discountBoard}">
			<img src="https://static1.squarespace.com/static/513f57ebe4b0970eaf232dec/t/5654b2eae4b05e28e38285cd/1448391403995/" 
											style="height:20px;width:20px;">
			</c:if>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
					
			<c:choose>
				<c:when test="${productBoard.boardNo == discount.discountBoard}">
						<td class="ct_write01"><strike>${product.price}</strike>
						&nbsp;&nbsp;
						${product.resultPrice}
						</td>
				</c:when>
				<c:when test="${purchaseCount % 4 == 0 && user.userId != 'admin' }">
						<td class="ct_write01"><strike>${product.price}</strike>
						&nbsp;&nbsp;
						${product.resultPrice}
						</td>
				</c:when>
				<c:otherwise>
					<td class="ct_write01">${product.resultPrice}</td>
				</c:otherwise>
			</c:choose> 
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">�������</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">${productBoard.boardRegDate}</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;">
	<tr>
		<td width="53%"></td>
		<td align="right">

		<table border="0" cellspacing="0" cellpadding="0">
		<tr>
		

			<c:choose>
				<c:when test="${user.userId eq 'admin'}">
				</c:when>
				<c:when test="${productBoard.quantity > 0}">
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23">
						</td>
						<td background="/images/ct_btnbg02.gif" class="purchaseBtn" style="padding-top: 3px;">
						<%-- <a href="/purchase/addPurchaseView?boardNo=${productBoard.boardNo}">����</a> --%>
						����
						</td>
						<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23">
						</td>
						<td width="30"></td>
				</c:when>
			</c:choose>
			
			
				<td width="17" height="23">
					<img src="/images/ct_btnbg01.gif" width="17" height="23">
				</td>
				<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">
					<!-- <a href="javascript:history.go(-1)">����</a> -->
					����
				</td>
				<td width="14" height="23">
					<img src="/images/ct_btnbg03.gif" width="14" height="23">
				</td>
			</tr>
			
		</table>

		</td>
	</tr>
</table>
</form>

</body>

<script type="text/javascript">
	$('.purchaseBtn').on('click',function(){
		/* var href = "/purchase/addPurchaseView?boardNo=${productBoard.boardNo}";
		self.location = href; */

		$('#detailForm').attr("method","post").attr("action","/purchase/addPurchaseView").submit();
	});
	
	$('.ct_btn01').on('click',function(){
		history.go(-1);
	});
</script>


</html>