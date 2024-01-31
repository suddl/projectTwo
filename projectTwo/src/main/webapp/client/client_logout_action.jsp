<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
session.removeAttribute("loginClient");

request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?group=main&worker=main_page");

%>