 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<div id="profile" >
	<a href="<%=request.getContextPath()%>/index.jsp?group=main&worker=main_page">쇼핑몰</a>&nbsp;&nbsp;
	<a href="<%=request.getContextPath()%>/index.jsp?group=client&worker=client_logout_action">로그아웃</a>&nbsp;&nbsp;
</div>
<div id ="par">
	<div id="logo">
		<a href="<%=request.getContextPath()%>/index.jsp?group=admin&worker=admin_main"><img src="<%=request.getContextPath() %>/images/logo.jpg" style="width: 200px; vertical-align:middle;" /></a>
	</div>		
	<div class="menu">
		<ul>
			<li><a href="<%=request.getContextPath()%>/index.jsp?group=admin&worker=product_list">상품관리</a></li>
			<li><a href="<%=request.getContextPath()%>/index.jsp?group=admin&worker=order_list">주문관리</a></li>
			<li><a href="<%=request.getContextPath()%>/index.jsp?group=moon&worker=moon_list">1:1문의관리</a></li>
			<li><a href="#">FAQ관리</a></li>
		</ul>
	</div>
</div>

