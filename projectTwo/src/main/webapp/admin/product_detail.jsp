<%@page import="java.text.DecimalFormat"%>
<%@page import="xyz.nailro.dao.ProductDAO"%>
<%@page import="xyz.nailro.dto.ProductDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/security/admin_check.jspf"%>
<%
	//글번호가 전달되지 않은 경우에 대한 응답 처리 - 비정상적인 요청
	if(request.getParameter("productNum")==null) {
		request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?group=error&worker=error_400");
		return;
	}

	//전달값을 반환받아 저장
	int productNum=Integer.parseInt(request.getParameter("productNum"));
	String pageNum=request.getParameter("pageNum");
	String pageSize=request.getParameter("pageSize");
	String search=request.getParameter("search");
	String keyword=request.getParameter("keyword");
	
	ProductDTO product=ProductDAO.getDAO().selectProductByNum(productNum);
	DecimalFormat df=new DecimalFormat("###,###");
	//검색된 게시글이 없는 경우에 대한 응답 처리 - 비정상적인 요청
	if(product==null) {
		request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?group=error&worker=error_400");
		return;
	}
%>
<link href="<%=request.getContextPath()%>/css/adminProduct.css" type="text/css" rel="stylesheet">

<div id="product_detail">
	<h1>상품정보</h1>
	<table>
		<tr>
			<th>상품명</th>
			<td><%=product.getProductName() %></td>					
		</tr>	
		<tr>
			<th>가격</th>
			<td><%=df.format(product.getProductPrice()) %>원 </td>					
		</tr>	
		<tr>
			<th>카테고리</th>
			<td><%=product.getProductCategory() %></td>
		</tr>			
		<tr>
			<th>세부사항</th>
			<td width="150">
			<% if(product.getProductType()==null) { %>
				-
			<% } else { %>
				<%=product.getProductType() %>
			<% } %>
			</td>
		</tr>
		<tr>
			<th>상품대표이미지</th>
			<td>
			<% if(product.getProductImage()!=null) { %>
					<img src="<%=request.getContextPath()%><%=product.getProductImage()%>" width="200">
			<% } %>
			</td>
		</tr>
		<tr>
			<th>상품상세이미지1</th>
			<td>
			<% if(product.getProductImage2()!=null) { %>
					<img src="<%=request.getContextPath()%><%=product.getProductImage2()%>" width="200">
			<% } %>
			</td>
		</tr>
		<tr>
			<th>상품상세이미지2</th>
			<td>
			<% if(product.getProductImage3()!=null) { %>
					<img src="<%=request.getContextPath()%><%=product.getProductImage3()%>" width="200">
			<% } %>
			</td>
		</tr>
	</table>
	
	<div id="product_menu">
		<button type="button" id="listBtn">목록</button>&nbsp;
		<button type="button" id="modifyBtn">수정</button>
	</div>
</div>

<script type="text/javascript">
$("#modifyBtn").click(function() {
	location.href="<%=request.getContextPath()%>/index.jsp?group=admin&worker=product_modify"
		+"&productNum=<%=product.getProductNum()%>&pageNum=<%=pageNum%>"
		+"&pageSize=<%=pageSize%>&search=<%=search%>&keyword=<%=keyword%>";	
});

$("#listBtn").click(function() {
	location.href="<%=request.getContextPath()%>/index.jsp?group=admin&worker=product_list"
		+"&pageNum=<%=pageNum%>&pageSize=<%=pageSize%>&search=<%=search%>&keyword=<%=keyword%>";	
});

</script>