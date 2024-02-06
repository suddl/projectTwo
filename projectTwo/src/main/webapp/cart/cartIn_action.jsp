<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="xyz.nailro.dao.CartDAO"%>
<%@page import="xyz.nailro.dao.ClientDAO"%>
<%@page import="xyz.nailro.dto.ClientDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@include file="/security/login_url.jspf" %>
    
<%
	//String saveDirectory=request.getServletContext().getRealPath("/images");
    
	//MultipartRequest multipartRequest = new MultipartRequest(request, saveDirectory, 20*1024*1024,"utf-8", new DefaultFileRenamePolicy());

	//상품번호
    /*
    String pn = request.getParameter("productNum");
    int pNum = Integer.parseInt(pn );
    //담긴 수량
    String cot = request.getParameter("counting");
    int cott = Integer.parseInt(cot );
    System.out.println(cot);
    */
    
    
	//상품번호
	String pN = request.getParameter("productNum");
    int producNum = Integer.parseInt(pN);
    //System.out.println("상품번호="+pN);

    //담긴 수량
	String cot = request.getParameter("counting");
    int carQuantity = Integer.parseInt(cot);
    System.out.println(cot);


    //회원번호
    int Num = loginClient.getClientNum();
    System.out.println("회원번호="+Num);

    //장바구니 테이블에 상품정보 삽입
    CartDAO.getDAO().insertCart(carQuantity, producNum, Num);
    
    
    


    request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?group=cart&worker=cart_page");
    %>
hi