<%@page import="xyz.nailro.dao.ProductDAO"%>
<%@page import="java.util.List"%>
<%@page import="xyz.nailro.dto.ProductDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" 
    pageEncoding="UTF-8"%>
<%
	String url = request.getParameter("url");

	if(url!=null){
		request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?"+url);
	}
	
	List<ProductDTO> productList = ProductDAO.getDAO().selectNewProductList();
	
%>     
<img src="<%= request.getContextPath() %>/images/main_image.jpg" width="65%"height="600">
<br>
<div>
	<h2>이달의 신상품</h2>
</div>
<div class="prodList" id="prodList">
	<% for (int i=0; i<6; i++) { 
	    ProductDTO product= productList.get(i);
	    String productUrl = request.getContextPath() + "/index.jsp?group=detail&worker=detail&productNum=" + product.getProductNum();
	%>
	    <div class="product" >
	        <a href="<%=productUrl%>">
	            <img class="prodImage" src="<%=request.getContextPath() %>/<%=product.getProductImage()%>" alt="이미지 준비중">
	        </a>
	        <div class="prodName">
	            <a href="<%=productUrl%>"><%=product.getProductName()%></a>
	        </div>
	        <div class="prodPrice"><%=product.getProductPrice() %></div>
	    </div>
    <% } %>
	</div>