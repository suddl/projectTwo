<%@page import="xyz.nailro.dto.ClientDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/security/login_url.jspf"%>

<style>
.welcomeBox {
	background-image: url("/projectTwo/images/mypage_back.png");
	width:100%;
	height: 400px;
	background-repeat: no-repeat;
	margin-top: 20px;
}

.welcomeName {
	font-size: 40px;
	text-align: left;
	line-height : 400px;
	margin-left: 400px;
}

#mypageMenu {
	text-align: ceter;
	margin-top: 30px;
}

.mypageTable {
	text-align: center;
	width: 700px;
	border: 1px solid gray;
	margin: 0 auto;
	height: 400px;
	margin-bottom: 50px;
	font-size: 20px;
}

tr, td {
	border: 1px solid gray;
	width : 350px;
	
}
</style>
<h1>my page</h1>
<div class="welcomeBox">
	<div class="welcomeName">
		<% if (loginClient !=null) { %>
			<%= loginClient.getClientName()%> 님 환영합니다!
		<% } %>
	</div>
</div>
            
<!-- your table content -->
<div id="mypageMenu">
	<table class="mypageTable">
		<tr>
			<td><a href="<%=request.getContextPath()%>/index.jsp?group=client&worker=client_payment">주문내역</a></td>
			<td><a href="<%=request.getContextPath()%>/index.jsp?group=cart&worker=cart_page">장바구니</a></td>
		</tr>
		<tr>
			<td><a href="<%=request.getContextPath()%>/index.jsp?group=client&worker=password_confirm&action=modify">회원정보 수정</a></td>
			<td><a href="<%=request.getContextPath()%>/index.jsp?group=client&worker=password_confirm&action=remove">회원탈퇴</a></td>
		</tr>
		<tr>
			<td><a href="<%=request.getContextPath()%>/index.jsp?group=review&worker=review_list">내가 쓴 리뷰보기</a></td>
			<td><a href="<%=request.getContextPath()%>/index.jsp?group=moon&worker=moon_list">1:1 문의하기</a></td>
		</tr>
	</table>
</div>