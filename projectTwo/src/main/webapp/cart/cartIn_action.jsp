<%@page import="xyz.nailro.dao.CartDAO"%>
<%@page import="xyz.nailro.dao.ClientDAO"%>
<%@page import="xyz.nailro.dto.ClientDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@include file="/security/login_url.jspf" %>
    
<%
    //상품번호
    String pn = request.getParameter("productNum");
    int pNum = Integer.parseInt(pn );
    //System.out.println(pn);

    //담긴 수량
    String cot = request.getParameter("counting");
    int cott = Integer.parseInt(cot );
    //System.out.println(cot);

    //회원번호
    int Num = loginClient.getClientNum();
    //System.out.println("회원번호="+Num);

    CartDAO.getDAO().insertCart(cott, pNum, Num);


    request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?group=cart&worker=cart_page");
    %>
hi