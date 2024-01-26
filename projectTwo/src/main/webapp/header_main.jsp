<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<div id="profile" >
	<a href="<%=request.getContextPath()%>/index.jsp?group=client&worker=client_login">로그인</a>&nbsp;&nbsp;
	<a href="<%=request.getContextPath()%>/index.jsp?group=client&worker=client_join">회원가입</a>&nbsp;&nbsp;
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
			<li><a href="#"><img src="<%=request.getContextPath() %>/images/shopping_cart.png" style="width: 20px; margin-left: 20px"/></a>
			<li><a href="#"><img src="<%=request.getContextPath() %>/images/mypage.png" style="width: 20px; margin-left: 20px"/></a>
		</ul>
	</div>
	
	
</div>

