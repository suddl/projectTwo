<%@page import="xyz.nailro.dao.CartDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@include file="/security/login_url.jspf"%>

<%	
	int rows = 0;	

	int CNum = loginClient.getClientNum();
	
	 String[] productArray = request.getParameterValues("selectedItemsInput");

	for(String pro : productArray){
		if(pro.equals("")){
		System.out.println("없다");
			
		}else{
			
		System.out.println("있다="+ pro);
		String[] result = pro.split(",");
		
			for(int i=0; i<result.length; i++){
				System.out.println(result[i]);
				int productNum = Integer.parseInt(result[i]);
				
				 rows=CartDAO.getDAO().deleteCartInProduct(productNum, CNum);
				
					}	
		}
	}

	
	request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?group=cart&worker=cart_page");
	
%>
