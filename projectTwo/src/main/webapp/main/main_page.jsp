<%@ page language="java" contentType="text/html; charset=UTF-8" 
    pageEncoding="UTF-8"%>
<%
	String url = request.getParameter("url");

	if(url!=null){
		request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?"+url);
	}

%>     
<img src="<%= request.getContextPath() %>/images/main_image.jpg" width="65%"height="600">

