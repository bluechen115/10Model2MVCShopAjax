<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% Map<String,Object> map = (Map<String,Object>)request.getAttribute("map");
	int totalCount = ((Integer)map.get("totalCount")).intValue();
	int cancelCount = ((Integer)map.get("cancelCount")).intValue();
	String userId = (String)map.get("userId");
%> 

    <div class="wrapDiv">
      <p><%=userId%></p>
		<ul class="list-group">
        <li class="list-group-item d-flex justify-content-between align-items-center">
          구매완료건
          <span class="badge badge-primary badge-pill"><%=totalCount%></span>
        </li>
        <li id='userPurchaseLi' style="display: none;">
        	<span style="height: 20px; background-color: blue;">ddddd</span>
        </li>
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
