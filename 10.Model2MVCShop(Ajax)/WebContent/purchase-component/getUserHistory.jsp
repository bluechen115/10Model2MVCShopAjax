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
	System.out.println(purchaseList.get(1).getTranNo());
%> 

    <div class="wrapDiv">
      <button type="button" id="closeBtn" style="float:right;border:0px;background-color: #EAEAEA;">
      	<img src="data:image/png;base64,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"
      		style=" width:20px; height:20px;"/>
      </button>
      <br/>
      <p><%=userId%></p>
		<ul class="list-group">
        <li class="list-group-item d-flex justify-content-between align-items-center">
          구매완료건
          <span class="badge badge-primary badge-pill"><%=totalCount%></span>
        </li>
        
        <%for(int i=0;i<totalCount;i++){%>
        <li class="list-group-item d-flex justify-content-between align-items-center" 
        	id='userPurchaseLi' style="display: block;">
        	<%-- <span style="height: 20px; background-color: blue;"><%=purchaseList.get(i).getTranNo()%></span> --%>
        </li>
        <%}%>
        
        <li class="list-group-item d-flex justify-content-between align-items-center">
          구매취소건
          <span class="badge badge-primary badge-pill"><%=cancelCount%></span>
        </li>
        <li class="list-group-item d-flex justify-content-between align-items-center">
          미정
          <span class="badge badge-primary badge-pill">0</span>
        </li>
      </ul>
    </div>
    
    <script>
    $('#closeBtn').on('click',function(){
		$('#purchaseHistoryDiv').css('display','none');
	});
    </script>
