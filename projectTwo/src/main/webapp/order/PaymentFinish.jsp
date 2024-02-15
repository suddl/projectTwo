<%@page import="xyz.nailro.dao.CartDAO"%>
<%@page import="xyz.nailro.dao.OrderDAO"%>
<%@page import="xyz.nailro.dao.PaymentDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link href="<%=request.getContextPath()%>/css/Payment.css" type="text/css" rel="stylesheet">
    
<%


//결제테이블에 필요한것
//결제번호(시퀀스),주문자회원번호(회원테이블참조),결제금액,결제수단

//--------------결제테이블 필요값---------
//회원번호
String clientNum = request.getParameter("clientNum");
//System.out.println(clientNum);
//결제금액
String finalMoney =  request.getParameter("finalMoney");
//String ffMoney = String.format("%,d", finalMoney);
//System.out.println(ffMoney);
//결제수단
String checkedPayment =  request.getParameter("checkedPayment");
//System.out.println(checkedPayment);
//------------------------------------------------
//2.결제번호 시퀀스 다음값을 변수에 저장 o
int nextNum = PaymentDAO.getDAO().selectPaymentNextNum(); 

//결제테이블에 데이터 삽입
int rowss = PaymentDAO.getDAO().insertPayment(nextNum, clientNum, finalMoney, checkedPayment);
//System.out.println(rowss+"행 바로결제 삽입완료");

//바로구매에서 접근 구별하기 위한 값
String DirectComple = request.getParameter("DirectComple");

//주문테이블에 필요한것
//주문번호(시퀀스),결제번호(결제테이블참조),회원번호(회원테이블참조),
//주문 상품번호(상품테이블참조),주문상세주소1,
//주문상세주소2,주문우편주소,주문수량,주문날짜,주문상태
int rows = 0;
int delrows = 0;

//1.주문번호 시퀀스
//3.회원번호 -> clientNum; 


//5.주문상세주소1
String address1 = request.getParameter("address1");
//System.out.println(address1);


//6.주문상세주소2
String address2 = request.getParameter("address2");
//System.out.println(address2);

//7.주문우편주소
String zipcode = request.getParameter("zipcode");
//System.out.println(zipcode);


//장바구니에서 구매페이지로 이동시 실행
if(DirectComple==null){

//주문상품번호 
String[] productNum = request.getParameterValues("productNum");

//주문수량 
String[] productQuan = request.getParameterValues("productQuan"); 


for(int i=0; i<productNum.length; i++){
	rows += OrderDAO.getDAO().insertOrders(nextNum, clientNum, productNum[i], address1, address2, zipcode, productQuan[i]);
	
	
	delrows+=CartDAO.getDAO().deleteCartInProduct(Integer.parseInt(productNum[i]), Integer.parseInt(clientNum));
	
}
//System.out.println(delrows+"행 장바구니삭제완료");
//System.out.println(rows+"행 주문삽입완료");
	}else{//바로구매로 구매페이지 이동시 실행
	
//4.주문상품번호 o
	String productNum = request.getParameter("productNum");
//8.주문수량 o
	String productQuan = request.getParameter("productQuan");


	rows += OrderDAO.getDAO().insertOrders(nextNum, clientNum, productNum, address1, address2, zipcode, productQuan);
//System.out.println(rows+"행 바로주문삽입완료");
//System.out.println(rows+"행 주문삽입완료");
}


//9.주문날짜 -> sysdate o
//10.주문상태-> 1 o

/*
//회원이름
String name =  request.getParameter("name");
//System.out.println(name);


//전달받은 상품이름목록
String[] array = request.getParameterValues("productName");
for(String productName : array){
//System.out.println(arrays);

}
*/



%>
<svg xmlns="http://www.w3.org/2000/svg" width="180" height="180" fill="currentColor" class="bi bi-bag-check" viewBox="0 0 16 16">
  <path fill-rule="evenodd" d="M10.854 8.146a.5.5 0 0 1 0 .708l-3 3a.5.5 0 0 1-.708 0l-1.5-1.5a.5.5 0 0 1 .708-.708L7.5 10.793l2.646-2.647a.5.5 0 0 1 .708 0z"/>
  <path d="M8 1a2.5 2.5 0 0 1 2.5 2.5V4h-5v-.5A2.5 2.5 0 0 1 8 1zm3.5 3v-.5a3.5 3.5 0 1 0-7 0V4H1v10a2 2 0 0 0 2 2h10a2 2 0 0 0 2-2V4h-3.5zM2 5h12v9a1 1 0 0 1-1 1H3a1 1 0 0 1-1-1V5z"/>
</svg>
<h1> 결제 완료!</h1>
<a href="<%=request.getContextPath()%>/index.jsp?group=main&worker=main_page"><button class="PayBtn">홈으로</button></a>
<button class="PayBtn OrderBtn">주문내역</button>














