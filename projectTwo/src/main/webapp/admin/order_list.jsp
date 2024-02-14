<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/security/admin_check.jspf"%>
<%
	//게시글 검색 기능에 필요한 전달값(검색대상과 검색단어)을 반환받아 저장
	String search=request.getParameter("search");//검색대상
	if(search==null) {//전달값이 없는 경우 - 게시글 검색 기능을 사용하지 않은 경우
		search="";
	}
	
	String keyword=request.getParameter("keyword");//검색단어
	if(keyword==null) {//전달값이 없는 경우
		keyword="";
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

	
	//검색정보(검색대상과 검색단어)를 전달받아 PRODUCT 테이블에 저장된 게시글 중 검색대상의 컬럼에
	//검색단어가 포함된 게시글의 갯수를 검색하여 반환하는 ProductDAO 클래스의 메서드 호출
	// => 검색 기능을 사용하지 않을 경우 PRODUCT 테이블에 저장된 모든 게시글의 갯수를 반환
	//int totalOrder=OrderDAO.getDAO().selectTotalOrder(search, keyword);//검색된 게시글의 총갯수
	
	//전체 페이지의 갯수를 계산하여 저장
	//int totalPage=(int)Math.ceil((double)totalOrder/pageSize);//페이지의 총갯수
 
	//전달받은 페이지번호가 비정상적인 경우
	//if(pageNum<=0 || pageNum>totalPage) {
	//	pageNum=1;
	//}
	
	//페이지번호에 대한 게시글의 시작 행번호를 계산하여 저장
	//ex) 1Page : 1, 2Page : 11, 3Page : 21, 4Page : 31, ...
	int startRow=(pageNum-1)*pageSize+1;
	
	//페이지번호에 대한 게시글의 종료 행번호를 계산하여 저장
	//ex) 1Page : 10, 2Page : 20, 3Page : 30, 4Page : 40, ...
	int endRow=pageNum*pageSize;
	
	//마지막 페이지의 게시글의 종료 행번호가 게시글의 총갯수보다 많은 경우 종료 행번호 변경
	//if(endRow>totalOrder) {
	//	endRow=totalOrder;
	//}
	
	//페이징 처리 관련 정보(시작 행번호와 종료 행번호)와 게시글 검색 기능 관련 정보(검색대상과
	//검색단어)를 전달받아 PRODUCT 테이블에 저장된 행을 검색하여 게시글 목록을 반환하는 ProductDAO 
	//클래스의 메소드 호출
	//List<OrderDTO> orderList=OrderDAO.getDAO().selectOrderList(startRow, endRow, search, keyword);
	DecimalFormat df=new DecimalFormat("###,###");

	//페이지에 출력될 게시글의 일련번호 시작값을 계산하여 저장
	// => 검색된 게시글의 총갯수가 91개인 경우 >> 1Page : 91, 2Page : 81, 3Page, 71
	//int displayNum=totalOrder-(pageNum-1)*pageSize;
%>

<link href="<%=request.getContextPath()%>/css/list.css" type="text/css" rel="stylesheet">
<style>

#button {
	text-align: right;
	margin-bottom: 5px;
}
</style>

<h1>주문관리</h1>
<form name="orderForm" id="orderForm">
<div id="order_list">
	<%-- 검색된 게시글 총갯수 출력 --%>
	<div id="order_title">주문목록(1개)</div>
	<div id="button">
		<button type="button" id="modifyBtn">적용</button>
	</div>
<table>
	<tr>
		<th width="50"><input type="checkbox" name="allcheck" id="allCheck" onclick="allCheck()"></th>
		<th width="100">주문번호</th>
		<th width="120">아이디</th>
		<th width="250">전화번호</th>
		<th width="200">결제방법</th>
		<th width="150">결제금액</th>
		<th width="150">주문처리상태</th>
		<th width="150">주문일</th>
	</tr>
	<tr align="center">
		<td class="p_check"><input type="checkbox" name="check" id="check" value=""></td>
		<td width="100">3000</td>
		<td width="120">abc123</td>
		<td width="250">010-1234-5678</td>
		<td width="200">신용카드</td>
		<td width="150">46,000원</td>
		<td width="150">
			<select name="orderStatus">
				<option value="1">&nbsp;상품준비중&nbsp;</option>
				<option value="2">&nbsp;배송준비중&nbsp;</option>
				<option value="3">&nbsp;배송중&nbsp;</option>
				<option value="4">&nbsp;배송완료&nbsp;</option>
				<option value="5">&nbsp;주문취소&nbsp;</option>
			</select>
		</td>
		<td width="150">2024-01-29</td>
	</tr>
	<tr>
		<td><input type="checkbox" name="order"></td>
		<td>&nbsp;&nbsp;</td>
		<td>&nbsp;&nbsp;</td>
		<td>&nbsp;&nbsp;</td>
		<td>&nbsp;&nbsp;</td>
		<td>&nbsp;&nbsp;</td>
		<td>&nbsp;&nbsp;</td>
		<td>&nbsp;&nbsp;</td>
	</tr>
	<tr>
		<td><input type="checkbox" name="order"></td>
		<td>&nbsp;&nbsp;</td>
		<td>&nbsp;&nbsp;</td>
		<td>&nbsp;&nbsp;</td>
		<td>&nbsp;&nbsp;</td>
		<td>&nbsp;&nbsp;</td>
		<td>&nbsp;&nbsp;</td>
		<td>&nbsp;&nbsp;</td>
	</tr>
	<tr>
		<td><input type="checkbox" name="order"></td>
		<td>&nbsp;&nbsp;</td>
		<td>&nbsp;&nbsp;</td>
		<td>&nbsp;&nbsp;</td>
		<td>&nbsp;&nbsp;</td>
		<td>&nbsp;&nbsp;</td>
		<td>&nbsp;&nbsp;</td>
		<td>&nbsp;&nbsp;</td>
	</tr>
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
		<%--
		 <% if(endPage!=totalPage) { %>
			<a href="<%=responseUrl%>&pageNum=<%=startPage+blockSize%>">[다음]</a>
		<% } else { %>	
			[다음]
		<% } %>
		--%>
	</div>
</form>

<form action="<%=request.getContextPath() %>/index.jsp?group=admin&worker=order_list" method="post">
	<%-- select 태그를 사용하여 검색대상을 선택해 전달 - 전달값은 반드시 컬럼명으로 설정 --%>
	<select name="search">
		<option value="order_id" <% if(search.equals("order_client_num")) { %>  selected <% } %>>&nbsp;아이디&nbsp;</option>
		<option value="order_payment" <% if(search.equals("order_pay_num")) { %>  selected <% } %>>&nbsp;결제방법&nbsp;</option>
		<option value="order_status" <% if(search.equals("order_status")) { %>  selected <% } %>>&nbsp;주문처리상태&nbsp;</option>
	</select>
	<input type="text" name="keyword" value="<%=keyword%>" >
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
	});

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
