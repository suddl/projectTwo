<%@page import="xyz.nailro.dao.OrderDAO"%>
<%@page import="xyz.nailro.dao.PaymentDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
System.out.println(rowss+"행 결제 삽입완료");

//바로구매에서 접근 구별하기 위한 값
String DirectComple = request.getParameter("DirectComple");

//주문테이블에 필요한것
//주문번호(시퀀스),결제번호(결제테이블참조),회원번호(회원테이블참조),
//주문 상품번호(상품테이블참조),주문상세주소1,
//주문상세주소2,주문우편주소,주문수량,주문날짜,주문상태
String proNums = null;
String proQuans = null;
int rows = 0;

//1.주문번호 시퀀스
//3.회원번호 -> clientNum; o


//5.주문상세주소1o
String address1 = request.getParameter("address1");
//System.out.println(address1);


//6.주문상세주소2o
String address2 = request.getParameter("address2");
//System.out.println(address2);

//7.주문우편주소o
String zipcode = request.getParameter("zipcode");
//System.out.println(zipcode);


//장바구니에서 구매페이지로 이동시 실행
if(DirectComple==null){

//4.주문상품번호 o
String[] productNum = request.getParameterValues("productNum");

for(String pro : productNum){
	proNums=pro;
}

//8.주문수량 o
String[] productQuan = request.getParameterValues("productQuan"); 
for(String pros : productQuan){
	proQuans=pros;
}

String[] proNumresult = proNums.split(",");
String[] proQuanresult = proQuans.split(",");
for(int i=0; i<proNumresult.length; i++){
	rows += OrderDAO.getDAO().insertOrders(nextNum, clientNum, proNumresult[i], address1, address2, zipcode, proQuanresult[i]);
	
}
System.out.println(rows+"행 주문삽입완료");
	}else{//바로구매로 구매페이지 이동시 실행
	
//4.주문상품번호 o
	String productNum = request.getParameter("productNum");
//8.주문수량 o
	String productQuan = request.getParameter("productQuan");


	rows += OrderDAO.getDAO().insertOrders(nextNum, clientNum, productNum, address1, address2, zipcode, productQuan);
	
System.out.println(rows+"행 주문삽입완료");
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
<h1> 결제가 완료되었습니다.</h1>
<button><a href="<%=request.getContextPath()%>/index.jsp?group=main&worker=main_page">홈으로</a></button>
<button>주문내역</button>
