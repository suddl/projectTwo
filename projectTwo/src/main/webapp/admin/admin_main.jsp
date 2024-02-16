<%@page import="xyz.nailro.dao.ProductDAO"%>
<%@page import="xyz.nailro.dto.ClientDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/security/admin_check.jspf" %>

<link href="<%=request.getContextPath()%>/css/list.css" type="text/css" rel="stylesheet">
<style>
.welcomeBox {
	background-image: url("/projectTwo/images/mypage_back.png");
	width:100%;
	height: 400px;
	background-repeat: no-repeat;
	margin-top: 20px;
}

.welcomeName {
	font-size: 23px;
	text-align: left;
	line-height : 350px;
	margin-left: 500px;
}
</style>

<div class="welcomeBox">
	<div class="welcomeName">
		<% if (loginClient !=null) { %>
			<%= loginClient.getClientName()%>자님 반갑습니다.
		<% } %>
	</div>
</div>
