<%@page import="java.util.List"%>
<%@page import="xyz.nailro.dto.CartDTO"%>
<%@page import="xyz.nailro.dao.CartDAO"%>
<%@page import="xyz.nailro.dto.OrderDTO"%>
<%@page import="xyz.nailro.dao.OrderDAO"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    List<OrderDTO> orderList = (List<OrderDTO>)request.getAttribute("orderList");
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
<div class="center-align">
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
                <td><%=order.getOrderProductNum()%></td>
                    <td><%=order.getOrderPayPrice()%></td>
                    <td><%=order.getOrderDate()%></td>
                    <td>
                        <form action="<%=request.getContextPath()%>/review_write.jsp" method="POST">
                            <input type="hidden" name="orderNum" value="<%=order.getOrderNum()%>" />
                            <input type="hidden" name="orderProductNum" value="<%=order.getOrderProductNum()%>" />
                            <button type="submit">리뷰 작성</button>
                        </form>
                    </td>
                </tr>
            <% } %>
        </tbody>
    </table>
</div>