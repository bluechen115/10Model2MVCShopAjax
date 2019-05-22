<%@page import="com.model2.mvc.service.domain.Purchase"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% Map<String,Object> map = (Map<String,Object>)request.getAttribute("map");
	int totalCount = ((Integer)map.get("totalCount")).intValue();
	int cancelCount = ((Integer)map.get("cancelCount")).intValue();
	String userId = (String)map.get("userId");
	List<Purchase> purchaseList = (List<Purchase>)map.get("purchaseList");
	List<Purchase> cancelList = (List<Purchase>)map.get("cancelList");
%> 


	<link rel="stylesheet" 
			href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"/>
	<!-- Optional theme -->
	<link rel="stylesheet" 
			href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css"/>
	<!-- Latest compiled and minified JavaScript -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	
	
	<style>
		.container{width:260px;
		}
		
		.panel-title{text-align:center;
					font-size: 23px;
		}
		#purchaseUl{display: none;
		}
		#cancelUl{display:none;}
		.force-overflow {
							min-height: 172px;
		}
		.pointerLi{cursor: pointer;
		}
		
	</style>


    <div class="container" id="userHistoryDiv">
   	<div class="panel panel-primary">
		<div class="panel-heading">
			<h3 class="panel-title"><%=userId%></h3>
		</div>
			<ul class="list-group">
		        <li class="list-group-item d-flex justify-content-between align-items-center pointerLi">
		         	 구매완료건
		          <span class="badge badge-primary badge-pill"><%=totalCount%></span>
		        </li>
		        
		        <ul class="list-group" id="purchaseUl">
		        <%for(int i=0;i<totalCount;i++){%>
		        <li class="list-group-item d-flex justify-content-between align-items-center">
		        	<span style="height: 20px;">주문번호 : <%=purchaseList.get(i).getTranNo()%></span>
		        </li>
		        <%}%>
		        </ul>
		        
		        <li class="list-group-item d-flex justify-content-between align-items-center pointerLi">
		        	  구매취소건
		          <span class="badge badge-primary badge-pill"><%=cancelCount%></span>
		        </li>
		        
		        <ul class="list-group" id="cancelUl">
		        <%for(int i=0;i<cancelCount;i++){%>
		        <li class="list-group-item d-flex justify-content-between align-items-center">
		        	<span style="height: 20px;">주문번호 : <%=cancelList.get(i).getTranNo()%></span>
		        </li>
		        <%}%>
		        </ul>
		        
		        <li class="list-group-item d-flex justify-content-between align-items-center">
		       	   미정
		          <span class="badge badge-primary badge-pill">0</span>
		        </li>
	      </ul>
		</div>	
     </div> 
     

       
    <script>
    var flag = false;
    var cancelFlag = false;
    
  
    
    $('li:contains("구매완료건")').on('click',function(){
    		if(flag){
    			$('#purchaseUl').css('display','none');
    			flag = false;
    			return false;
    		}else{
	    		$('#purchaseUl').css('display','block');
	    		flag = true;
	    		return false;
    		}

    });
    
    $('li:contains("구매취소건")').on('click',function(){
    	
    		if(cancelFlag){
    			$('#cancelUl').css('display','none');
    			cancelFlag = false;
    			return false;
    		}else{
	    		$('#cancelUl').css('display','block');
	    		cancelFlag = true;
	    		return false;
    		}
    });
    
	$('.panel-title').on('mouseover',function(){
		$(this).css('cursor','pointer');
		
		$(this).on('click',function(){
			$('#userHistoryDiv').css('display','none');
		});
	});

    
    </script>
