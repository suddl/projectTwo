<%@page import="xyz.nailro.dao.MoonDAO"%>
<%@page import="xyz.nailro.dto.MoonDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	if(request.getMethod().equals("GET")) {
		request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?group=error&worker=error_400");
		return;
	}
	
	int moonNum=Integer.parseInt(request.getParameter("moonNum"));
	String pageNum=request.getParameter("pageNum");
	String pageSize=request.getParameter("pageSize");
	String search=request.getParameter("search");
	String keyword=request.getParameter("keyword");
	
	String moonRe=request.getParameter("moonRe");
	
	MoonDTO moon=new MoonDTO();
	moon.setMoonNum(moonNum);
	moon.setMoonRe(moonRe);
	
	MoonDAO.getDAO().updateReMoon(moon);
	
	request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?group=moon&worker=moon_detail&" +"&moonNum="+moonNum+"&pageNum="+pageNum+"&pageSize="+pageSize+"&search="+search+"&keyword="+keyword);
%>