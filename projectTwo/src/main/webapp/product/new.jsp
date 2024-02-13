<%@page import="java.awt.JobAttributes.DefaultSelectionType"%>
<%@page import="xyz.nailro.dto.ProductDTO"%>
<%@page import="java.util.List"%>
<%@page import="xyz.nailro.dao.ProductDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%     
    int pageNum = 1;
    if (request.getParameter("pageNum") != null) {
        pageNum = Integer.parseInt(request.getParameter("pageNum"));
    }
    
    int pageSize = 12;
    if (request.getParameter("pageSize") != null) {
        pageSize = Integer.parseInt(request.getParameter("pageSize"));
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Nailro - new</title>
<link href="<%=request.getContextPath()%>/css/header.css" type="text/css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/css/product.css" type="text/css" rel="stylesheet">
</head>
<body>
<%
	List<ProductDTO> productList = ProductDAO.getDAO().selectNewProductList();
%>
	<a href = "#">
		<img class="logo" src="<%= request.getContextPath() %>/images/new_logo.jpg" alt="all"/>
	</a>
<div class="container">
	<div class="sorting">   
		<select name="정렬 방식">
			<option value="신상품순" selected>&nbsp;신상품순&nbsp;</option>
			<option value="이름순" >&nbsp;이름순&nbsp;</option>
			<option value="가격순" >&nbsp;가격순&nbsp;</option>    	
		</select>
	</div>

	<div class="prodList" id="prodList">
		<% for (ProductDTO product : productList) { 
		    String url = request.getContextPath() + "/index.jsp?group=detail&worker=detail&productNum=" + product.getProductNum();    
		%>
		    <div class="product" >
		        <a href="<%=url%>">
		            <img class="prodImage" src="<%=request.getContextPath() %>/<%=product.getProductImage()%>" alt="이미지 준비중">
		        </a>
		        <div class="prodName">
		            <a href="<%=url%>"><%=product.getProductName()%></a>
		        </div>
		        <div class="prodPrice"><%=product.getProductPrice() %></div>
		    </div>
	    <% } %>
	</div>
</div>
<script>

</script>
</body>
</html>