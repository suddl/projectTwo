
<%@page import="java.util.List"%>
<%@page import="xyz.nailro.dto.CartDTO"%>
<%@page import="xyz.nailro.dao.CartDAO"%>
<%@page import="xyz.nailro.dto.OrderDTO"%>
<%@page import="xyz.nailro.dao.OrderDAO"%>
<%@page import="xyz.nailro.dto.ClientDTO"%>
<%@page import="xyz.nailro.dao.ClientDAO"%>
<%@page import="xyz.nailro.dto.ProductDTO"%>
<%@page import="xyz.nailro.dao.ProductDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%  
	String clientNum = "ClientNum"; 
	int startRow = 1; 
	int endRow = 10; 
	String search = "order_date"; 
	String keyword = ""; 
	
	//주문내역 조회 
	List<OrderDTO> orderList=OrderDAO.getDAO().selectOrderList(startRow, endRow, search, keyword);
    request.setAttribute("orderList", orderList);
    
  //session 객체에 저장된 권한 관련 속성값을 반환받아 저장
 // => 로그인 상태의 사용자에게만 글쓰기 권한 제공
 // => 게시글이 비밀글인 경우 로그인 상태의 사용자가 게시글 작성자이거나 관리자인 경우에만 권한 제공
 ClientDTO loginmember=(ClientDTO)session.getAttribute("loginClient");
%>
    <!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<style> 
.table{
width: 80%;
margin: 0 auto;

}

h1{
text-align : center; 
margin-bottom: 50px;
}

#MinBtn{
display: inline-block; 
 width: 30px;
 text-align: center; 
 font-weight: bold;
 border: 1px solid gray;
 
}

#PlusBtn{
display: inline-block; 
 width: 30px;
 text-align: center; 
 font-weight: bold;
 border: 1px solid gray;
 
}

.money{
display: inline-block;
font-size: 17px;
font-weight: normal;
}

.NumMoney{
 text-align: right;
 display: inline-block;
 width: 100%; 
 font-size: 17px;
font-weight: normal;
}

.moneyALL{
display: inline-block;
font-size: 17px;
font-weight: bold;
} 

.NumMoneyALL{
 text-align: right;
 display: inline-block;
 width: 100%; 
 font-size: 17px;
font-weight: 800;
}

table{
border: 1px solid #DCDCDC;
}

#BuyBtn {
   margin: 0 auto;
   width: 200px;
   background-color: black;
   color: white;
   font-size: 20px;
   cursor: pointer;
   font-weight: bold;
   border-radius: 10px;
   
}

#ProductList{
	width: 60%;
}
</style>
<div class="clientpayment">
    <h2>주문내역</h2>
	
    <table class="table" style="margin: 0 auto; width: 80%;">
        <thead>
            <tr>
                <th width="100">주문번호</th>
                <th width="500">상품명</th>
                <th width="100">총금액</th>
                <th width="200">주문일</th>
                <th width="100">리뷰 작성</th>
            </tr>
        </thead>
        <tbody>
             <% for(OrderDTO order : orderList) { %>
                <tr>
                  <td><%=order.getOrderNum()%></td>
                <td><%=order.getOrderProductName()%></td>
                    <td><%=order.getOrderPayPrice()%></td>
                    <td><%=order.getOrderDate()%></td>
                    <td>
                 <form action="review_write.jsp" method="POST">
    	<input type="hidden" name="orderNum" value="${order.orderNum}" />
    	<input type="hidden" name="orderProductNum" value="${order.orderProductNum}" />
    	<button type="submit">리뷰 작성</button>
				</form>
                    </td>
                </tr>
            <% } %>
        </tbody>
    </table>
</div>