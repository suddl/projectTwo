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
<title>Nailro - Nail</title>
<link href="<%=request.getContextPath()%>/css/header.css" type="text/css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/css/product.css" type="text/css" rel="stylesheet">
</head>
<body>
<%
	List<ProductDTO> productList = ProductDAO.getDAO().selectProductByCategory("Nail");
%>
<a href = "#">
	<img class="logo" src="<%= request.getContextPath() %>/images/nailLogo.jpg" alt="nail"/>
</a>
<div class="container">
	<div class="sorting">
		<select name="정렬 방식">
			<option value="신상품순" selected>&nbsp;신상품순&nbsp;</option>
			<option value="이름순" >&nbsp;이름순&nbsp;</option>
			<option value="가격순" >&nbsp;가격순&nbsp;</option>    	
		</select>
	</div>
	<div class="filter-buttons" id="filterButtons">
  		<button data-product-type="All">전체</button>
  		<button data-product-type="Short">숏</button>
  		<button data-product-type="Long">롱</button>
  		<button data-product-type="Parts">파츠</button>
  		<button data-product-type="FullColor">풀컬러</button>
	</div>

  	<div class="prodList">
    <%-- 제품 이미지 클릭시 제품 상세 페이지로 넘길 값(productNum, productImage, productName, productPrice  --%>
        <% for (ProductDTO product : productList) { 
            String url = request.getContextPath() + "/index.jsp?group=detail&worker=detail"
                    + "&productNum=" + product.getProductNum();  
        %>
        <div class="product" data-product-type="<%=product.getProductType()%>">
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
var sortType = '신상품순'; // 초기 정렬 방식 설정

// 초기에는 모든 제품을 표시
displayProducts("all");

// 필터 버튼 클릭 이벤트 핸들러
$('#filterButtons button').on('click', function() {
    var productType = $(this).data('product-type');
    displayProducts(productType);
});

// 화면에 필터된 제품들을 출력
function displayProducts(productType) {
    var productListContainer = $('.product-list');
    
    if (productType === 'all') {
        productListContainer.find('.product').show();
    } else {
        productListContainer.find('.product').hide();
        productListContainer.find('.product[data-product-type="' + productType + '"]').show();
    }

    sortProducts(); // 필터링 후 정렬 적용
}

$('select[name="정렬 방식"]').on('change', function() {
    sortType = $(this).val();
    displayProducts(getActiveFilterType());
    sortProducts();
});

// 가격순 정렬 토글 기능 추가
function sortProducts() {
    var productListContainer = $('.product-list');
    var products = productListContainer.find('.product');

    // 정렬 기준에 따라 배열 정렬
    products.sort(function(a, b) {
        var aValue, bValue;

        if (sortType === '신상품순') {
            aValue = parseInt($(a).data('product-num'));
            bValue = parseInt($(b).data('product-num'));
        } else if (sortType === '이름순') {
            aValue = $(a).find('.product-name a').text();
            bValue = $(b).find('.product-name a').text();
        } else if (sortType === '가격순') {
            aValue = parseFloat($(a).find('.product-price').text().replace(',', ''));
            bValue = parseFloat($(b).find('.product-price').text().replace(',', ''));
        }

        if (sortType === '신상품순') {
            // 신상품은 product_num을 기준으로 내림차순 정렬
            return bValue - aValue;
        } else {
            // 나머지 정렬은 오름차순 정렬
            if (aValue > bValue) return 1;
            else if (aValue < bValue) return -1;
            else return 0;
        }
    });

    // 정렬된 배열을 화면에 적용
    productListContainer.empty().append(products);
}
</script>
</body>
</html>