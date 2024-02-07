 <%@page import="xyz.nailro.dto.ClientDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	ClientDTO loginClient=(ClientDTO)session.getAttribute("loginClient");
%>
<div id="profile" >
<% if(loginClient==null) { %>
	<a href="<%=request.getContextPath()%>/index.jsp?group=client&worker=client_login">로그인</a>&nbsp;&nbsp;
	<a href="<%=request.getContextPath()%>/index.jsp?group=client&worker=client_terms">회원가입</a>&nbsp;&nbsp;
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
	<div class="menu">
		<ul>
			<li><a href="<%=request.getContextPath() %>/index.jsp?group=product&worker=new">new</a></li>
			<li><a href="<%=request.getContextPath() %>/index.jsp?group=product&worker=nail">nail</a></li>
			<li><a href="<%=request.getContextPath() %>/index.jsp?group=product&worker=pedi">pedi</a></li>
			<li><a href="<%=request.getContextPath() %>/index.jsp?group=product&worker=care">care&tool</a></li>
			<li><a href="<%=request.getContextPath() %>/index.jsp?group=product&worker=faq">FAQ</a></li>
		</ul>
	</div>
	<div class="menu2">
		<ul>
			<li>
				<form  class="search-bar" action="<%=request.getContextPath()%>/index.jsp?group=product&worker=searchProduct" method="post">
					<input type="search" name="search" id="keyword" placeholder="검색어를 입력하세요.">
					<button class="search-btn" type="submit">
						<img src="<%=request.getContextPath() %>/images/ham_search.png" style="width: 10px;"/>
					</button>
				</form>
			</li>
			<li><a href="<%=request.getContextPath()%>/index.jsp?group=cart&worker=cart_page""><img src="<%=request.getContextPath() %>/images/shopping_cart.png" style="width: 20px; margin-left: 50px"/></a>
			<li><a href="#"><img src="<%=request.getContextPath() %>/images/mypage.png" style="width: 20px; margin-left: 20px"/></a>
		</ul>
	</div>	 
	
</div>

