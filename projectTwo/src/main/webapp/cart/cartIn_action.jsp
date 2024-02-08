<%@page import="xyz.nailro.dto.CartDTO"%>
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
    
    //String url = request.getParameter("url");
    //System.out.println("전달쿼리값="+url);
    
    
	//상품번호
	String pN = request.getParameter("productNum");
    int productNum = Integer.parseInt(pN);
    System.out.println("상품번호="+pN);

    //담긴 수량
	String cot = request.getParameter("counting");
    int ReceiveCarQuantity = Integer.parseInt(cot);
    //System.out.println(cot);


    //회원번호
    int Num = loginClient.getClientNum();
    //System.out.println("회원번호="+Num);
	
    /*
    CartDTO cartdto = (CartDTO)CartDAO.getDAO().selectCartList(Num);
    int inCartClientNum =Integer.parseInt(cartdto.getCartClientNum());//저장되어있는 회원 번호
    int inCartProductNum = Integer.parseInt(cartdto.getCartProduct());//저장되어있는 상품번호
    System.out.println(inCartProductNum );
    if(){
    	
    	
    }else{
    
    //장바구니 테이블에 상품정보 삽입
    CartDAO.getDAO().insertCart(carQuantity, producNum, Num);
    	
    }
	*/
	
	//회원번호와 상품번호를 조회
	if(CartDAO.getDAO().selectQuantityCart(productNum, Num)==null){
	//해당상품번호와 회원번호가 없다면 장바구니 테이블에 상품정보 삽입
    CartDAO.getDAO().insertCart(ReceiveCarQuantity, productNum, Num);
		
	}else{//해당상품정보와 회원번호가 있다면 수량만 증가
	int InCartQuantity = Integer.parseInt(CartDAO.getDAO().selectQuantityCart(productNum, Num));
    //System.out.println("현재담긴 수량="+surang);
	CartDAO.getDAO().updateCartQuantity(Num, productNum, InCartQuantity, ReceiveCarQuantity);
		
	}
	
	
	
	
    
    
    
    


    request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?group=cart&worker=cart_page");
    %>
hi