<%@page import="xyz.nailro.dao.CartDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@include file="/security/login_url.jspf"%>

<%	
	int rows = 0;	

	int CNum = loginClient.getClientNum();
	
	//getParameterValues 메소드로 받은 다수의 객체를 배열로 받는다 
	String[] productArray = request.getParameterValues("selectedItemsInput");
	
	for(String pro : productArray){
		if(pro.equals("")){//배열의 내용이 빈문자열이라면
		//System.out.println("없다");
			
		}else{//배열의 문자열이 비어있지 않다면
			
		//System.out.println("있다="+ pro);
		String[] result = pro.split(",");
		
			for(int i=0; i<result.length; i++){
				//System.out.println(result[i]);
				int productNum = Integer.parseInt(result[i]);
				
				 rows=CartDAO.getDAO().deleteCartInProduct(productNum, CNum);
				
					}	
		}
	}

	
	request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?group=cart&worker=cart_page");
	
%>
