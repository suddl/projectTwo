<%@page import="xyz.nailro.dto.ClientDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	ClientDTO loginClient = (ClientDTO)session.getAttribute("loginClient");
	//System.out.println(loginClient);
%>
<div id="profile" >
	<% if(loginClient==null) { %>
	<a href="<%=request.getContextPath()%>/index.jsp?group=client&worker=client_login">로그인</a>&nbsp;&nbsp;
	<a href="<%=request.getContextPath()%>/index.jsp?group=client&worker=client_join">회원가입</a>&nbsp;&nbsp;
	<% } else { %>
		<span style="font-weight: bold;">[<%=loginClient.getClientName()%>]</span>님, 환영합니다. 
	<a href="<%=request.getContextPath()%>/index.jsp?group=client&worker=client_logout_action">로그아웃</a>&nbsp;&nbsp;
	<a href="<%=request.getContextPath()%>/index.jsp?group=client&worker=client_mypage">내정보</a>&nbsp;&nbsp;
	<% if(loginClient.getClientStatus()==9) {//로그인 사용자가 관리자인 경우 %>
		<a href="<%=request.getContextPath()%>/index.jsp?group=admin&worker=admin_main">관리자</a>&nbsp;&nbsp;
	<% } %>
		
	<% } %>
	
</div>
<div id ="par">
	<div id="logo">
		<a href="<%=request.getContextPath()%>/index.jsp"><img src="<%=request.getContextPath() %>/images/logo.jpg" style="width: 200px; vertical-align:middle;" /></a>
	</div>		
	<div id="menu">
		<ul>
			<li><a href="#">new</a></li>
			<li><a href="#">nail</a></li>
			<li><a href="#">pedi</a></li>
			<li><a href="#">care&tool</a></li>
			<li><a href="#">FAQ</a></li>
			<li><a href="#"><img src="<%=request.getContextPath() %>/images/ham_search.png" style="width: 20px; margin-left: 10px"/></a>
			<li><a href="<%=request.getContextPath()%>/index.jsp?group=cart&worker=CARTPAGE"><img src="<%=request.getContextPath() %>/images/shopping_cart.png" style="width: 20px; margin-left: 20px"/></a>
			<li><a href="#"><img src="<%=request.getContextPath() %>/images/mypage.png" style="width: 20px; margin-left: 20px"/></a>
		</ul>
	</div>
	
	
</div>

