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
<%@include file="/security/login_url.jspf"%>
<%  
	String search=request.getParameter("search");
	if(search==null) {
		search="";
	}
	
	String keyword=request.getParameter("keyword");
	if(keyword==null) {
		keyword="";
	}
	
	// 페이지 번호
	int pageNum=1;
	if(request.getParameter("pageNum")!=null) {
		pageNum=Integer.parseInt(request.getParameter("pageNum"));
	}
	
	// 게시글 갯수
	int pageSize=10;
	if(request.getParameter("pageSize")!=null) {
		pageSize=Integer.parseInt(request.getParameter("pageSize"));
	}
	
	int loginClientNum = loginClient.getClientNum();
	
	int totalrPayReview=0;
	
	totalrPayReview=OrderDAO.getDAO().selectTotalOrderReview(search, keyword, loginClientNum);
	
	int totalPage=(int)Math.ceil((double)totalrPayReview/pageSize);
	
	if(pageNum<=0 || pageNum>totalPage) {
		pageNum=1;
	}
	
	int startRow=(pageNum-1)*pageSize+1;
	
	int endRow=pageNum*pageSize;
	
	if(endRow>totalrPayReview) {
		endRow=totalrPayReview;
	}
	
	//주문내역 조회 
	List<OrderDTO> orderList=OrderDAO.getDAO().selectOrderReviewList(startRow, endRow, search, keyword);
    
    int displayNum=totalrPayReview-(pageNum-1)*pageSize;
    
%>
<link href="<%=request.getContextPath()%>/css/clientPayment.css" type="text/css" rel="stylesheet">
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
						    <button type="button" onclick="writeReview(<%=order.getOrderProductNum()%>,<%=order.getOrderNum()%>);">리뷰 작성</button>
	                    </td>
	                </tr>
	            <% } %>
	        </tbody>
	    </table>
</div>


<script type="text/javascript">
function writeReview(productNum, orderNum) {
	location.href="<%=request.getContextPath()%>/index.jsp?group=review&worker=review_write"
		+"&productNum="+productNum+"&orderNum="+orderNum+"&pageNum=<%=pageNum%>"
		+"&pageSize=<%=pageSize%>&keyword=<%=keyword%>";	
} 
</script>