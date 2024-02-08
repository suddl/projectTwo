<%@ page import="java.util.List" %>
<%@ page import="xyz.nailro.dto.ProductDTO" %>
<%@ page import="xyz.nailro.dao.ProductDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Nailro - Search Product</title>
<link href="<%=request.getContextPath()%>/css/header.css" type="text/css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/css/product.css" type="text/css" rel="stylesheet">
<%	
	String keyword=request.getParameter("keyword");
	if(keyword==null)	{
		keyword="";
	}
%>   
</head>
<body>
    <div class="container">
        <h2>검색 결과</h2>
    	<div class="sorting">
    	<select name="정렬 방식">
    		<option value="신상품순" selected>&nbsp;신상품순&nbsp;</option>
    		<option value="이름순" >&nbsp;이름순&nbsp;</option>
    		<option value="가격순" >&nbsp;가격순&nbsp;</option>    	
    	</select>
    	</div>
    	
		<div class="filter-buttons" id="filterButtons">
    		<button data-product-type="short">숏</button>
    		<button data-product-type="long">롱</button>
    		<button data-product-type="parts">파츠</button>
    		<button data-product-type="fullColor">풀컬러</button>
    		<button data-product-type="all">전체</button>
		</div>
        <div class="prodList">
            <%
                List<ProductDTO> searchResults = ProductDAO.getDAO().searchProduct(keyword);
                if (searchResults.isEmpty()) { 
            %>
         	<p>검색 결과가 없습니다.</p>
            <%
                } else {
                     for (ProductDTO product : searchResults) {
                         String url = request.getContextPath() + "/index.jsp?group=detail&worker=detail"
                                 + "&productNum=" + product.getProductNum();
            %>
                         <div class="product">
                             <a href="<%=url%>">
                                 <img class="product-image" src="<%=request.getContextPath() %>/images/<%=product.getProductImage()%>" alt="Product Image">
                             </a>
                             <div class="product-name">
                                 <a href="<%=url%>"><%=product.getProductName()%></a>
                             </div>
                             <div class="product-price"><%=product.getProductPrice() %></div>
                         </div>
             <%
                     }
                 }
             %>
         </div>
	</div>
 <script>

</script>
</body>
</html>