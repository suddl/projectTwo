<%@page import="xyz.nailro.dao.ClientDAO"%>
<%@page import="xyz.nailro.util.Utility"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/security/login_check.jspf" %>  
<%
	if(request.getMethod().equals("GET")) {
		request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?group=error&worker=error_400");
		return;
	}	
	
	String passwd=Utility.encrypt(request.getParameter("passwd"));
	
	if(!loginClient.getClientPasswd().equals(passwd)) {
		session.setAttribute("message", "입력하신 비밀번호가 맞지 않습니다.");	
		request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?group=client&worker=password_confirm&action=remove");
		return;
	}	
	
	ClientDTO client=new ClientDTO();
	client.setClientNum(loginClient.getClientNum());
	client.setClientStatus(0);//회원정보의 회원상태를 [0]으로 변경 - 탈퇴회원
	
	ClientDAO.getDAO().updateClientStatus(client);
	
	//페이지 이동
	request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?group=client&worker=client_logout_action");	
%>