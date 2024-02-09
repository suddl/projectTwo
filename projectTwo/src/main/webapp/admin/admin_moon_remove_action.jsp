<%@page import="java.io.File"%>
<%@page import="xyz.nailro.dao.MoonDAO"%>
<%@page import="xyz.nailro.dto.MoonDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="/security/login_check.jspf" %>    

<%
	if(request.getParameter("moonNum")==null) {
		request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?group=error&worker=error_400");
		return;
	}

	int moonNum=Integer.parseInt(request.getParameter("moonNum"));
	String pageNum=request.getParameter("pageNum");
	String pageSize=request.getParameter("pageSize");
	String search=request.getParameter("search");
	String keyword=request.getParameter("keyword");
	
	MoonDTO moon=MoonDAO.getDAO().selectMoonByNum(moonNum);
	
	if(moon==null) {
		request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?group=error&worker=error_400");
		return;
	}
	
	if(loginClient.getClientNum()!=moon.getMoonClientNum() && loginClient.getClientStatus()!=9) {
		request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?group=error&worker=error_400");
		return;
	}
	
	moon.setMoonStatus(0);
	
	MoonDAO.getDAO().updateMoon(moon);
	if(moon.getMoonImage()!=null) {
		new File(request.getServletContext().getRealPath(moon.getMoonImage())).delete();
	}
	
	request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?group=admin&worker=admin_moon_list"
			+"&pageNum="+pageNum+"&pageSize="+pageSize+"&search="+search+"&keyword="+keyword);
%>