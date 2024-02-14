<%@page import="xyz.nailro.dao.CartDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@include file="/security/login_url.jspf"%>

<%	
	//System.out.println(request.getParameter("WChoice"));
	
  	String choice =  request.getParameter("WChoice");
	int CNum = loginClient.getClientNum();
	
	String proNum = null;
	String proQun = null;
	
	//전달값이 1인 경우 삭제기능
  	if(choice.equals("1")){
	int rows = 0;	

	
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
		System.out.println("정상삭제");
	//전달값이 2인 경우 수량 변경 후 주문 페이지로 이동
  	}else if(choice.equals("2")){
		//System.out.println("여기가 값전달부분 시작----------");
		
		
		//전달받은 상품 번호
		String[] productArray = request.getParameterValues("selectedItemsInput");
		for(String pro : productArray){
			if(!pro.equals("")){
			//System.out.println("상품번호="+pro );
			//변수에 상품번호들 저장
			proNum=pro;
			}else{
				
			}
		}
		
		String[] selectedItemsInputQuan = request.getParameterValues("selectedItemsInputQuan");
		for(String Quan : selectedItemsInputQuan ){
			if(!Quan.equals("")){
			//위에부터 순서대로 아래로 내려온다
			//System.out.println("상품수량="+Quan );
			proQun=Quan;
			}else{
				
			}
		}
		
  	
		//System.out.println(proNum);
		//System.out.println("전달전수량"+proQun);
			//배열로 저장 ,로 구분해서
			String[] proNumResult = proNum.split(",");
			String[] proQunResult = proQun.split(",");
			
		for(int i=0; i<proNumResult.length; i++){
				int proNumFinish = Integer.parseInt(proNumResult[i]);
				int proQunFinish = Integer.parseInt(proQunResult[i]);
				//제품번호의 갯수만큼 반복시키며 변수에 저장되어있는 배열을 하나씩 꺼내 테이블의 수량을 수정하는 메소드 실행
		CartDAO.getDAO().updateOrderCartQuantity(proQunFinish, CNum, proNumFinish);
		}
		
	request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?group=order&worker=order_main&proNum="+proNum+"&proQun="+proQun);
  	}
  	
%>












