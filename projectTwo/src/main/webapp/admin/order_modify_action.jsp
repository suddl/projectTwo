<%@page import="xyz.nailro.dao.OrderDAO"%>
<%@page import="xyz.nailro.dto.OrderDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="/security/admin_check.jspf" %>    
<%
	//JSP 문서를 GET 방식으로 요청한 경우에 대한 응답 처리 - 비정상적인 요청
	if (!"POST".equalsIgnoreCase(request.getMethod())) {
        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        return;
	}	

	//주문 상태 변경을 처리하는 코드
	String orderNum = request.getParameter("orderNum"); // 주문 번호
	String orderStatus = request.getParameter("orderStatus"); // 주문 상태
	
	//주문 상태를 변경합니다.
    int rows = OrderDAO.getDAO().updateOrderStatus(orderNum, orderStatus);
    
%> 
