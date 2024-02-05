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
    <style>
        body {
           font-family: 'Hahmlet', serif;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
		
        .product-list {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-around;
        }

        .product {
            box-sizing: border-box;
            width: calc(25% - 20px);
            margin: 10px;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            background-color: white;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .product img {
            width: 100%;
            height: auto;
            max-height: 200px;
            object-fit: cover;
        }

        .product a {
            text-decoration: none;
            color: #333;
        }

        .product-name {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .product-price {
            font-size: 16px;
            font-weight: bold;
            color: #007bff;
        }

        .product:hover {
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        .sorting	{
            display: flex;
            justify-content: flex-end;
		}
		
		select[name="정렬 방식"]	{
			margin-right: 10px;
		}
		
    .filter-buttons {
        display: flex;
        gap: 60px; /* 원하는 간격 설정 */
        justify-content: flex-start; /* 버튼을 왼쪽으로 정렬 */
        margin-bottom: 30px; /* 간격을 위해 아래에 여분의 여백 추가 */
        margin-left: 10px;
    }

    .filter-buttons button {
        padding: 15px 30px; /* 원하는 버튼 크기 설정 */
        font-size: 16px; /* 원하는 폰트 크기 설정 */
    }		
    </style>
</head>
<body>
<%
	List<ProductDTO> productList = ProductDAO.getDAO().selectProductByCategory("Nail");
%>
    <div class="container">

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

    <div class="product-list">
        <% for (ProductDTO product : productList) { 
            String url = request.getContextPath() + "/index.jsp?group=detail&worker=detail"
                    + "&productNum=" + product.getProductNum() + "&productImage=" + product.getProductImage()
                    + "&productName=" + product.getProductName() + "&productPrice=" + product.getProductPrice();        
        %>
        <div class="product" data-product-type="<%=product.getProductType()%>">
            <a href="<%=url%>">
                <img class="product-image" src="<%=request.getContextPath() %>/<%=product.getProductImage()%>" alt="이미지 준비중">
            </a>
            <div class="product-name">
                <a href="<%=url%>"><%=product.getProductName()%></a>
            </div>
            <div class="product-price"><%=product.getProductPrice() %></div>
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