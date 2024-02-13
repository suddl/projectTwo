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
    int totalProduct=ProductDAO.getDAO().selectTotalProductByCategory("Nail");
    
    int totalPage=(int)Math.ceil((double)totalProduct/pageSize);

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
	if(endRow>totalProduct) {
		endRow=totalProduct;
	}
	
	List<ProductDTO> productList=ProductDAO.getDAO().selectProductListByCategory(startRow, endRow, "Nail");
	
	int displayNum=totalProduct-(pageNum-1)*pageSize;
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
            displayNum--;
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
		if(endPage>totalPage) {
			endPage=totalPage;
		}
		
	%>
	
	<div id="page_list">
		<%
			String responseUrl=request.getContextPath()+"/index.jsp?group=product&worker=nail"
					+"&pageSize="+pageSize;
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