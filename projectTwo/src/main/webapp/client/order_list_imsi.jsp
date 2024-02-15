<%@page import="xyz.nailro.dto.OrderDTO"%>
<%@page import="xyz.nailro.dao.OrderDAO"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//게시글 검색 기능에 필요한 전달값(검색대상과 검색단어)을 반환받아 저장
	String search=request.getParameter("search");//검색대상
	if(search==null) {//전달값이 없는 경우 - 게시글 검색 기능을 사용하지 않은 경우
		search="";
	}
	String keywords = "";
	
	String keyword=request.getParameter("keyword");//검색단어
	if(keyword==null) {//전달값이 없는 경우
		keyword="";
	}else if(keyword.equals("상품준비중")){
		keyword= String.valueOf(1);
		keywords = "상품준비중";
	}else if(keyword.equals("배송준비중")){
		keyword= String.valueOf(2);
		keywords = "배송준비중";
	}else if(keyword.equals("배송완료")){
		keyword= String.valueOf(3);
		keywords = "배송완료";
	}else if(keyword.equals("배송중")){
		keyword= String.valueOf(4);
		keywords = "배송중";
	}else if(keyword.equals("주문취소")){
		keyword= String.valueOf(0);
		keywords = "주문취소";
	}

	//페이징 처리에 필요한 전달값(페이지번호과 게시글갯수)을 반환받아 저장
	int pageNum=1;//페이지번호- 전달값이 없는 경우 저장된 초기값 설정
	if(request.getParameter("pageNum")!=null) {//전달값이 있는 경우
		pageNum=Integer.parseInt(request.getParameter("pageNum"));
	}
	
	int pageSize=10;//게시글갯수- 전달값이 없는 경우 저장된 초기값 설정
	if(request.getParameter("pageSize")!=null) {//전달값이 있는 경우
		pageSize=Integer.parseInt(request.getParameter("pageSize"));
	}
	
	int totalOrder=OrderDAO.getDAO().selectTotalOrder(search, keyword);//검색된 게시글의 총갯수
	
	//전체 페이지의 갯수를 계산하여 저장
	int totalPage=(int)Math.ceil((double)totalOrder/pageSize);//페이지의 총갯수
 
	//전달받은 페이지번호가 비정상적인 경우
	if(pageNum<=0 || pageNum>totalPage) {
		pageNum=1;
	}
	
	//페이지번호에 대한 게시글의 시작 행번호를 계산하여 저장
	//ex) 1Page : 1, 2Page : 11, 3Page : 21, 4Page : 31, ...
	int startRow=(pageNum-1)*pageSize+1;
	
	//페이지번호에 대한 게시글의 종료 행번호를 계산하여 저장
	//ex) 1Page : 10, 2Page : 20, 3Page : 30, 4Page : 40, ...
	int endRow=pageNum*pageSize;
	
	//마지막 페이지의 게시글의 종료 행번호가 게시글의 총갯수보다 많은 경우 종료 행번호 변경
	if(endRow>totalOrder) {
		endRow=totalOrder;
	}
	
	List<OrderDTO> orderList=OrderDAO.getDAO().selectOrderReviewList(startRow, endRow, search, keyword);
	//DecimalFormat df=new DecimalFormat("###,###");

	//페이지에 출력될 게시글의 일련번호 시작값을 계산하여 저장
	// => 검색된 게시글의 총갯수가 91개인 경우 >> 1Page : 91, 2Page : 81, 3Page, 71
	int displayNum=totalOrder-(pageNum-1)*pageSize;
%>

<link href="<%=request.getContextPath()%>/css/list.css" type="text/css" rel="stylesheet">
<style>

#button {
	text-align: right;
	margin-bottom: 5px;
}
</style>

<h1>주문내역확인</h1>
<form name="orderForm" id="orderForm">
<div id="order_list">
	<%-- 검색된 게시글 총갯수 출력 --%>
	<div id="order_title">주문내역(<%=totalOrder %>개)</div>
	<div id="button">
		<button type="button" id="modifyBtn">적용</button>
	</div>
<table>
	<tr>
		<th width="100">주문번호</th>
		<th width="200">상품명</th>
		<th width="150">주문일</th>
		<th width="150">리뷰작성하러가기</th>
	</tr>
	 <% for(OrderDTO order : orderList) { %>
	<tr align="center">
		<%-- <td class="p_check"><input type="checkbox" name="check" id="check" value="<%=order.getOrderNum()%>"></td> --%>
		<td width="100">
		<%=order.getOrderNum() %>
		</td>
		<td width="120">
		<%=order.getOrderProductName() %>
		</td>
		<td width="150">
		<%=order.getOrderDate() %>
		</td>
	</tr>
	<% } %>
</table>
</div>

<%-- 페이지번호 출력 및 링크 제공 - 블럭화 처리 --%>
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
		//if(endPage>totalPage) {
		//	endPage=totalPage;
		//}
		
	%>
	
	<div id="page_list">
		<%
			String responseUrl=request.getContextPath()+"/index.jsp?group=admin&worker=order_list"
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
</form>

<form action="<%=request.getContextPath() %>/index.jsp?group=admin&worker=order_list_imsi" method="post">
	<%-- select 태그를 사용하여 검색대상을 선택해 전달 - 전달값은 반드시 컬럼명으로 설정 --%>
	
	<input type="text" name="keyword" value="<%=keywords%>" >
	<button type="submit">검색</button>
</form>

<script type="text/javascript">

$("#orderCount").change(function() {
	location.href="<%=request.getContextPath()%>/index.jsp?group=admin&worker=order_list"
		+"&pageNum=<%=pageNum%>&pageSize="+$("#orderCount").val()
		+"&search=<%=search%>&keyword=<%=keyword%>";
});

$(document).ready(function() {
	$("#allCheck").click(function() {
		if($("#allCheck").prop("checked")) {
			$("input[name=check]").prop("checked",true);
		} else { 
			$("input[name=check]").prop("checked",false);
		}
	});토스

	$("input[name=check]").click(function() {
		var total=$("input[name=check]").length;
		var checked=$("input[name=check]:checked").length;

		if(total!=checked) { 
			$("#allCheck").prop("checked",false);
		} else {
			$("#allCheck").prop("checked",true);
		}
	});
	
	$("#modifyBtn").click(function() {
		if($("input[name=check]").filter(":checked").length==0) {
			alert("변경할 주문내역을 선택하세요.");
			return;
		}
		
		if(confirm("주문처리상태를 변경 하시겠습니까?")) {
			location.href="<%=request.getContextPath()%>/index.jsp?group=admin&worker=order_modify_action"
		} else {
			return false;
		}		
		
		$("#orderForm").attr("action", "<%=request.getContextPath()%>/index.jsp?group=admin&worker=order_modify_action");
		$("#orderForm").attr("method","post");
		$("#orderForm").submit();
	});
});
</script>