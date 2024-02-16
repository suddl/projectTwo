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
                <th width="400">상품</th>
                <th width="100">수량</th>
                <th width="100">주문총금액</th>
                <th width="200">주문일</th>
                <th width="200">배송상태</th>
                <th width="100">리뷰 작성</th>
            </tr>
        </thead>
        <tbody>
             <% for(OrderDTO order : orderList) { %>
                <tr>
					<td><%=order.getOrderNum()%></td>
					<td><%=order.getOrderProductName()%></td>
					<td><%=order.getOrderQuntity() %></td>
					<%  //System.out.println("order.getOrderQuntity() = " + order.getOrderQuntity()); %>
					<td><%=order.getOrderPayPrice()%></td>
					<td><%=order.getOrderDate()%></td>
					<td><%=order.getOrderStatus()%></td>
					<td>
					    <button type="button" onclick="writeReview(<%=order.getOrderProductNum()%>,<%=order.getOrderNum()%>);">리뷰 작성</button>
                    </td>
                </tr>
            <% } %>
        </tbody>
    </table>
	    
	<%
		//하나의 페이지블럭에 출력될 페이지번호의 갯수 설정
		int blockSize=5;
	
		//페이지블럭에 출력될 시작 페이지번호를 계산하여 저장
		//ex)1Block : 1, 2Block : 6, 3Block : 11, 4Block : 16,...
		int startPage=(pageNum-1)/blockSize*blockSize+1;
		        
		//페이지블럭에 출력될 종료 페이지번호를 계산하여 저장
		//ex)1Block : 5, 2Block : 10, 3Block : 15, 4Block : 20,...
		int endPage=startPage+blockSize-1;
		
		//종료 페이지번호가 페이지 총갯수보다 큰 경우 종료 페이지번호 변경 
		if(endPage>totalPage) {
			endPage=totalPage;
		}
	%>
	
	<div id="page_list">
		<%
			String responseUrl=request.getContextPath()+"/index.jsp?group=client&worker=client_payment"
					+"&pageSize="+pageSize+"&search="+search+"&keyword="+keyword;
		%>
	
		<%-- 이전 페이지블럭이 있는 경우에만 링크 제공 --%>
		<% if(startPage>blockSize) { %>
			<a href="<%=responseUrl%>&pageNum=<%=startPage-blockSize%>">[이전]</a>
		<% } else { %>	
			[이전]
		<% } %>
		
		<% for(int i=startPage;i<=endPage;i++) { %>
			<%-- 요청 페이지번호와 출력된 페이지번호가 같지 않은 경우에만 링크 제공 --%>
			<% if(pageNum != i) { %>
				<a href="<%=responseUrl%>&pageNum=<%=i%>">[<%=i %>]</a>
			<% } else { %>
				[<%=i %>]
			<% } %>
		<% } %>
		
		<%-- 다음 페이지블럭이 있는 경우에만 링크 제공 --%>
		<% if(endPage!=totalPage) { %>
			<a href="<%=responseUrl%>&pageNum=<%=startPage+blockSize%>">[다음]</a>
		<% } else { %>	
			[다음]
		<% } %>
	</div>
	<form action="<%=request.getContextPath() %>/index.jsp?group=client&worker=client_payment" method="post">
		<select name="search">
			<option value="product_name" <% if(search.equals("product_name")) { %>  selected <% } %>>&nbsp;상품명&nbsp;</option>
		</select>
		<input type="text" name="keyword" value="<%=keyword%>">
		<button type="submit">검색</button>
	</form>
</div>


<script type="text/javascript">
function writeReview(productNum, orderNum) {
	location.href="<%=request.getContextPath()%>/index.jsp?group=review&worker=review_write"
		+"&productNum="+productNum+"&orderNum="+orderNum+"&pageNum=<%=pageNum%>"
		+"&pageSize=<%=pageSize%>&keyword=<%=keyword%>";	
} 
</script>