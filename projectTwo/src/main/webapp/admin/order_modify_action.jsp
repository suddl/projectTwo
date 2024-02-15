<%@page import="java.io.File"%>
<%@page import="xyz.nailro.dao.OrderDAO"%>
<%@page import="xyz.nailro.dto.OrderDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="/security/admin_check.jspf" %>    
<%
	//JSP 문서를 GET 방식으로 요청한 경우에 대한 응답 처리 - 비정상적인 요청
	if(request.getMethod().equals("GET")) {
		request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?group=error&worker=error_400");
		return;
	}	

	String[] check=request.getParameterValues("check");
	
	if (check != null) {
   	 	for (String orderNumStr : check) {
        	int orderNum = Integer.parseInt(orderNumStr);
        	OrderDAO.getDAO().updateOrderStatus(orderNum);
   		}
	}
		
	//페이지 이동 - 검색 및 페이징 처리 관련 값 전달
	request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?group=admin&worker=order_list");
%>
