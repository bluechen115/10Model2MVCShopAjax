<%@page import="com.model2.mvc.common.Page"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<html>
<head>
<title class="pageTitle">��ǰ �����ȸ</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>

<script type="text/javascript">
function fncGetList(currentPage) {
	document.getElementById('currentPage').value=currentPage;
	document.detailForm.submit();
}
function fncFindProductList(){
	document.detailForm.submit();
}
function fncSortingList(orderType){
	document.getElementById('orderType').value=orderType;
	document.detailForm.submit();
}
function fncSortingByUser(pageSize){
	document.getElementById('pageSize').value=pageSize;
	document.detailForm.submit();
}

$(function(){
	$("td:contains('���λ�ǰ����')").on('click',function(){
		var href = "/product/getProduct?boardNo=${discount.discountBoard}";
		if(${param.menu=="search"}){
			href = href + "&menu=search";
		}
		else if(${param.menu=="manage"}){
			href = href + "&menu=manage";
		}
		self.location = href;
	});
});


/* $(function(){
	$('.boardTitle').on('click',function(){
		var no = $(this).parent().children('.boardNo').text();
		var href = "/product/getProduct?boardNo="+no;
		if(${param.menu=='search'}){
			href = href + "&menu=search";
		}
		else if(${param.menu=='manage'}){
			href = href + "&menu=manage";
		}
		self.location = href;
	});
});
 */
$(function(){
	$('.boardTitle').on('click',function(){
		var no = $(this).parent().children('.boardNo').text();
		var href = "/product/json/getProduct"+"/"+no;
		var menu = "${param.menu}";
		if(menu=='search'){
			href = href + "/search";
		}
		else if(menu=='manage'){
			href = href + "/manage";
		}
		
		$.ajax({
			url:href,
			method:"GET",
			dataType:"json",
			headers : {
				"Accept" : "application/json",
				"Content-Type" : "application/json"
			},
			success:function(JsonData,status){
				 var dispalyValue = "<h3 id='tempDisplayValue'>"+
										"������ : "+JsonData.productBoard.title+"<br/>"+
										"��ǰ�� : "+JsonData.product.prodName+"<br/>"+
										"������ : "+JsonData.productBoard.boardDetail+"<br/>"+
										"��ȸ�� : "+JsonData.productBoard.viewCount+"<br/>"+
										"���� ���� : "+JsonData.productBoard.quantity+"<br/>"+
										"�������� : "+JsonData.product.manuDate+"<br/>"+
										"���� : "+JsonData.product.resultPrice+
									"</h3>";
									
				$('#tempDisplayValue').remove();
				$('#'+no+'').html(dispalyValue);
			}
		});
	});	
});

$(function(){
	$('td:contains("�ֱٵ�ϼ�")').on('click',function(){
		fncSortingList('1');
	});
	
	$('td:contains("���ݳ�����")').on('click',function(){
		fncSortingList('2');
	});
	
	$('td:contains("���ݳ�����")').on('click',function(){
		fncSortingList('3');
	});
});

$(function(){
	$('.ct_btn01:contains("�˻�")').on('click',function(){
		$('form').attr("method","post").attr("action","/product/listProduct").submit();
	});
})

$(function() {
	$('.pageSelector').on('change',function(){
		$('.ct_btn01:contains("�˻�")').trigger('click');
	});
});





</script>
</head>

<body bgcolor="#ffffff" text="#000000">


<div style="width:98%; margin-left:10px;">

<form name="detailForm" class="listForm">

<input type="hidden" id="HddnDiscountBoardNo" name="HddnDiscountBoardNo" value="${discount.discountBoard}"/>

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif" width="15" height="37"/>
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">
						<c:if test="${param.menu=='search'}">
							��ǰ �����ȸ
						</c:if>
						<c:if test="${param.menu=='manage'}">
							��ǰ ����
						</c:if>
									
					</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="/images/ct_ttl_img03.gif" width="12" height="37"/>
		</td>
	</tr>
</table>


<input type='hidden' id="orderType" name='orderType' value="${search.orderType}"/>
<div style="float:right; width:750px;">
<table border="0" cellspacing="0" cellpadding="0" style=" margin-top:10px;">
	<tr>
		<td>
				���λ�ǰ����&nbsp;&nbsp;
		</td>
		<td>
		<select name="pageSize" class="pageSelector">
			<c:forEach var="i" begin="1" end="10">
			<option value="${i}" ${i==resultPage.pageSize ? "selected":""}>${i}</option>
			</c:forEach>
		</select>���� ����&nbsp;&nbsp;&nbsp;
		</td>
		<td style="width:70px;"><p style="cursor:pointer">�ֱٵ�ϼ�</p></td>
		<td style="width:70px;"><p>���ݳ�����</p></td>
		<td style="width:70px;"><p>���ݳ�����</p></td>
		<td>
			<select id="searchCondition" name="searchCondition" class="ct_input_g" style="width:80px">
				
				<c:if test="${!empty search.searchCondition}">
				<c:choose>
					<c:when test="${sessionScope.user.userId == 'admin'}">					
					<option value="0" ${!empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>�۹�ȣ</option>
					</c:when>					
				</c:choose>
					<option value="1" ${!empty search.searchCondition && search.searchCondition==1 ? "selected":""}>������</option>
					<option value="2" ${!empty search.searchCondition && search.searchCondition==2 ? "selected":""}>�۳���</option>
				</c:if>
			
				<c:if test="${empty search.searchCondition}">
				<c:choose>
					<c:when test="${sessionScope.user.userId == 'admin' }">
					<option value="" >--����--</option>
					</c:when>
				</c:choose>
					<option value="0" >�۹�ȣ</option>
					<option value="1" >������</option>
					<option value="2" >�۳���</option>
				</c:if>
			</select>
			<input type="text" id="searchKeyword" name="searchKeyword"  class="ct_input_g" style="width:200px; height:19px" 
				value="${!empty search.searchKeyword ? search.searchKeyword:''}"
			/>
		</td>
	
		
		<td align="right" width="70">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23">
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
						<!-- <a href="javascript:fncFindProductList();">�˻�</a> -->
						�˻�
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23">
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</div>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td colspan="11" >��ü ${resultPage.totalCount} �Ǽ�, ���� ${resultPage.currentPage} ������</td>		
	</tr>
	<tr>
		<td class="ct_list_b" width="100">�۹�ȣ</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">����</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">����</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">�����</td>	
		<td class="ct_line02"></td>
		<td class="ct_list_b">�������</td>	
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>
	
	<c:set var="i" value="0"/>
	<c:forEach var="productBoard" items="${list}" >
	<c:set var="i" value="${i+1}"/>
	<tr class="ct_list_pop" >
		<td align="center" class="boardNo">${productBoard.boardNo}</td>
		<td id="prodTitleTd"></td>
				<td class="boardTitle">${productBoard.title}</td>
		<td></td>
		<td align="left">${productBoard.prodPrice}
			<c:if test="${productBoard.boardNo == discount.discountBoard}">
			<img src="https://static1.squarespace.com/static/513f57ebe4b0970eaf232dec/t/5654b2eae4b05e28e38285cd/1448391403995/" 
											style="height:20px;width:20px;">
			</c:if>
		</td>
		<td></td>
		<td align="left">${productBoard.boardRegDate}</td>
		<td></td>
		<td align="left">
			${productBoard.quantity > 0 ? '�Ǹ���':'�������'}		
		</td>	
	</tr>
	<tr>
		<td id="${productBoard.boardNo}" colspan="11" bgcolor="D6D7D6" height="1"></td>
	</tr>	
	</c:forEach>
	
	
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="center">
		<input type="hidden" id="menu" name="menu" value="${param.menu}"/>
		<input type="hidden" id="currentPage" name="currentPage" value="${search.currentPage}"/>
		<jsp:include page="../common/pageNavigator.jsp"/>
    	</td>
	</tr>
</table>
<!--  ������ Navigator �� -->

</form>

</div>
</body>


</html>