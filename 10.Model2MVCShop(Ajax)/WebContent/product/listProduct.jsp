<%@page import="com.model2.mvc.common.Page"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<html>

<head>
<title class="pageTitle">상품 목록조회</title>

  
  <link rel="stylesheet" href="/css/admin.css" type="text/css">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <link rel="stylesheet" href="/resources/demos/style.css">
  
  <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>



	<style type="text/css">
	#divLangSelect {position:absolute; 
					width:205px;
					height:205px;
					top:5px;
					right:5px;  
					display:none; 
					opacity:0.97;
					} 
	</style>


  <script type="text/javascript">

	var clickFlag = false;
	var slideFlag = false;
	var availableTags = [];

	
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
		$("td:contains('할인상품보기')").on('click',function(){
			var href = "/product/getProduct?boardNo=${discount.discountBoard}";
			var menu = "${param.menu}";
			if(menu=="search"){
				href = href + "&menu=search";
			}
			else if(menu=="manage"){
				href = href + "&menu=manage";
			}
			self.location = href;
		});
	
	
		$('.boardTitle').on('click', function(e){
			e.stopImmediatePropagation();
			clickFlag = true;
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
					 var dispalyValue = 
						 				"<div id='displayDiv'>"+
						 				"<h3 id='tempDisplayValue'>"+
											"글제목 : "+JsonData.productBoard.title+"<br/>"+
											"상품명 : "+JsonData.product.prodName+"<br/>"+
											"상세정보 : "+JsonData.productBoard.boardDetail+"<br/>"+
											"조회수 : "+JsonData.productBoard.viewCount+"<br/>"+
											"남은 수량 : "+JsonData.productBoard.quantity+"<br/>"+
											"제조일자 : "+JsonData.product.manuDate+"<br/>"+
											"가격 : "+JsonData.product.resultPrice+
										"</h3> "+"<div id='closeBtnDiv' style='float:right; margin-top:1px;'><button type='button' id='closeBtn'>X</button></div></div>";
										
					$('#displayDiv').remove();
					$('#'+no+'').html(dispalyValue);
					
					$('#closeBtn').on('click',function(){
						$('#'+no+'').empty();
						clickFlag = false;
					});
				}
			});
		});	
		
	
		
	
	
	
		$('td:contains("최근등록순")').on('click',function(){
			fncSortingList('1');
		});
		
		$('td:contains("가격높은순")').on('click',function(){
			fncSortingList('2');
		});
		
		$('td:contains("가격낮은순")').on('click',function(){
			fncSortingList('3');
		});
	
	
	
		$('.ct_btn01:contains("검색")').on('click',function(){
			$('form').attr("method","post").attr("action","/product/listProduct").submit();
		});
	
	
	
		$('.pageSelector').on('change',function(){
			$('.ct_btn01:contains("검색")').trigger('click');
		});
	
		
		 $('.boardTitle').on('mouseover',function(e){
				var divTop = $(this).position().top+20;
				var divLeft = $(this).position().left+80;
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
						data:"json",
						headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						},
						success:function(JsonData,status){
							  	var displayValue = "<div id='displayValue'>"+
							 						" <img src='/images/uploadFiles/"+JsonData.product.fileName+"' style='width:200px;height:200px;'/>"+
							 						"</div>";
							 $('#displayValue').remove();
							  $('#divLangSelect').html(displayValue); 
						}
					});
					
				if(!clickFlag){
					timer = setTimeout(function(){
						
						$('#divLangSelect').css({
							"top":divTop,
							"left":divLeft,
							"position":"absolute"
						}).show();
					},1200);
				}
			}).on('mouseleave',function(){
				$('#divLangSelect').css('display','none');	
				clearTimeout(timer);
			});
	})
		

	
	$(function(){
			setInterval(function(){
				$('#divLangSelect').css('display','none');	
			},3500);
	
	
			$('#searchKeyword').on('keyup',function(){
				var conditionFlag = $('#searchCondition').val();
				var searchKeyword = $(this).val();
				var param = {"searchKeyword":searchKeyword};
				var values=[];
				
				
				if(conditionFlag == '1'){
					
					$.ajax({
						url:"/product/json/getProductBoardTitle/",
						method:"POST",
						
						contentType: "application/json",
						data:param,
						dataType:"json",
						success:function(data){
							availableTags = data;
													
						},
						error:function(){
							alert("에러");
						}
					});	
					
					$('#searchKeyword').autocomplete({
					      source: availableTags
					});
					
				}
				
			});
			
			
	});

	
	


</script>

</head>

<body bgcolor="#ffffff" text="#000000">


<div style="width:98%; margin-left:10px;">

<form name="detailForm" class="listForm">

<!-- 레이어드 div -->

<div id="divLangSelect"  >
 	 <div id='displayValue'>내용 없음</div>
</div>




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
							상품 목록조회
						</c:if>
						<c:if test="${param.menu=='manage'}">
							상품 관리
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
<div style="float:right; width:800px;">
<table border="0" cellspacing="0" cellpadding="0" style=" margin-top:10px; width:790px;">
	<tr>
		<td>
				할인상품보기&nbsp;&nbsp;
		</td>
		<td>
		<select name="pageSize" class="pageSelector">
			<c:forEach var="i" begin="1" end="10">
			<option value="${i}" ${i==resultPage.pageSize ? "selected":""}>${i}</option>
			</c:forEach>
		</select>개씩 보기&nbsp;&nbsp;&nbsp;
		</td>
		<td style="width:70px;"><p style="cursor:pointer">최근등록순</p></td>
		<td style="width:70px;"><p>가격높은순</p></td>
		<td style="width:70px;"><p>가격낮은순</p></td>
		<td>
			<select id="searchCondition" name="searchCondition" class="ct_input_g" style="width:80px">
				
				<c:if test="${!empty search.searchCondition}">
				<c:choose>
					<c:when test="${sessionScope.user.userId == 'admin'}">					
					<option value="0" ${!empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>글번호</option>
					</c:when>					
				</c:choose>
					<option value="1" ${!empty search.searchCondition && search.searchCondition==1 ? "selected":""}>글제목</option>
					<option value="2" ${!empty search.searchCondition && search.searchCondition==2 ? "selected":""}>글내용</option>
				</c:if>
			
				<c:if test="${empty search.searchCondition}">
				<c:choose>
					<c:when test="${sessionScope.user.userId == 'admin' }">
					<option value="" >--선택--</option>
					</c:when>
				</c:choose>
					<option value="0" >글번호</option>
					<option value="1" >글제목</option>
					<option value="2" >글내용</option>
				</c:if>
			</select>
			
			<input type="text" id="searchKeyword" name="searchKeyword"  class="ct_input_g" style="width:200px; height:19px" 
				value="${!empty search.searchKeyword ? search.searchKeyword:''}"/>
		</td>
	
		
		<td align="right" width="70">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23">
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
						<!-- <a href="javascript:fncFindProductList();">검색</a> -->
						검색
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

<div id="ListTblDiv">
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td colspan="11" >전체 ${resultPage.totalCount} 건수, 현재 ${resultPage.currentPage} 페이지</td>		
	</tr>
	<tr>
		<td class="ct_list_b" width="100">글번호</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">제목</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">가격</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">등록일</td>	
		<td class="ct_line02"></td>
		<td class="ct_list_b">현재상태</td>	
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
			${productBoard.quantity > 0 ? '판매중':'재고없음'}		
		</td>	
	</tr>
	<tr>
		<td id="${productBoard.boardNo}" colspan="11" bgcolor="D6D7D6" height="1"></td>
	</tr>	
	</c:forEach>
	
	
</table>
</div>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="center">
		<input type="hidden" id="menu" name="menu" value="${param.menu}"/>
		<input type="hidden" id="currentPage" name="currentPage" value="${search.currentPage}"/>
		<jsp:include page="../common/pageNavigator.jsp"/>
    	</td>
	</tr>
</table>
<!--  페이지 Navigator 끝 -->

</form>

</div>
</body>



</html>
