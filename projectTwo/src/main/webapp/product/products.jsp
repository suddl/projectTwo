<%@page import="java.awt.JobAttributes.DefaultSelectionType"%>
<%@page import="xyz.nailro.dto.ProductDTO"%>
<%@page import="java.util.List"%>
<%@page import="xyz.nailro.dao.ProductDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%  
	String category=request.getParameter("category");
	
    int pageNum = 1;
    if (request.getParameter("pageNum") != null) {
        pageNum = Integer.parseInt(request.getParameter("pageNum"));
    }
    
    int pageSize = 12;
    if (request.getParameter("pageSize") != null) {
        pageSize = Integer.parseInt(request.getParameter("pageSize"));
    }
    int totalProduct=ProductDAO.getDAO().selectTotalProductByCategory(category);
    
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
	
	List<ProductDTO> productList=ProductDAO.getDAO().selectProductListByCategory(startRow, endRow, category); 
	
	ProductDTO prod= new ProductDTO();
	
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

<img class="logo" src="<%= request.getContextPath() %>/images/<%=category%>Logo.jpg"/>

<div class="container">
<div class="sorting">
    <p>
       <a href="#" id="sortByRecent">신상품순</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;
       <a href="#" id="sortByName">이름순</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;
       <a href="#" id="sortByPriceAsc">낮은가격순</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;
       <a href="#" id="sortByPriceDesc">높은가격순</a>   
   </p>
</div>	<div class="filter-buttons" id="filterButtons">
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
            <div class="prodPrice" id="prodPrice"><%=product.getProductPrice()%>원</div>
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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
//클래스 이름이 "prodPrice"인 모든 요소를 가져옵니다.
var prodPrices = document.querySelectorAll(".prodPrice");

// 각 요소에 대해 반복합니다.
prodPrices.forEach(function(prodPriceElement) {
    // 요소의 텍스트를 가져옵니다.
    var prodPriceText = prodPriceElement.innerText;
    
    // 텍스트에서 숫자 부분을 추출하고 숫자로 변환합니다.
    var prodPrice = parseFloat(prodPriceText.replace(/[^0-9.-]+/g,""));
    
    // 숫자를 포맷하고 "원"을 추가하여 다시 텍스트로 설정합니다.
    var formattedPrice = new Intl.NumberFormat('en-US').format(prodPrice) + "원";
    prodPriceElement.innerText = formattedPrice;
});

var productList = document.getElementById()

//최신순 정렬 함수
document.getElementById('sortByRecent').addEventListener('click', function(event) {
    event.preventDefault(); // 링크 기본 동작 방지
    sortByRecent();
    console.log("sortByRecent 호출됨");
});

// 이름순 정렬 함수
document.getElementById('sortByName').addEventListener('click', function(event) {
    event.preventDefault(); // 링크 기본 동작 방지
    sortByName();
});

// 낮은가격순 정렬 함수
document.getElementById('sortByPriceAsc').addEventListener('click', function(event) {
    event.preventDefault(); // 링크 기본 동작 방지
    sortByPriceAsc();
});

// 높은가격순 정렬 함수
document.getElementById('sortByPriceDesc').addEventListener('click', function(event) {
    event.preventDefault(); // 링크 기본 동작 방지
    sortByPriceDesc();
});

//최신순 정렬 함수
function sortByRecent() {
    console.log("sortByRecent 호출됨");
    productList.sort(function(a, b) {
        return new Date(b.registerDate) - new Date(a.registerDate);
    });
    renderProductList(productList);
}

// 이름순 정렬 함수
function sortByName() {
    console.log("sortByName 호출됨");
    productList.sort(function(a, b) {
        return a.productName.localeCompare(b.productName);
    });
    renderProductList(productList);
}

// 낮은가격순 정렬 함수
function sortByPriceAsc() {
    console.log("sortByPriceAsc 호출됨");
    productList.sort(function(a, b) {
        return a.productPrice - b.productPrice;
    });
    renderProductList(productList);
}

// 높은가격순 정렬 함수
function sortByPriceDesc() {
    console.log("sortByPriceDesc 호출됨");
    productList.sort(function(a, b) {
        return b.productPrice - a.productPrice;
    });
    renderProductList(productList);
}

// 정렬된 결과를 페이지에 보여주는 함수
function renderProductList(productList) {
    // productList를 순회하며 각 제품 정보를 페이지에 출력
    var prodListDiv = document.querySelector('.prodList');
    prodListDiv.innerHTML = ''; // 이전에 출력된 내용 지우기
    productList.forEach(function(product) {
        // 올바른 URL 생성
         var url = '/index.jsp?group=product&worker=products&category=' + category + '&productNum=' + product.productNum;
        var productDiv = document.createElement('div');
        productDiv.className = 'product';
        productDiv.setAttribute('data-product-type', product.productType);
        productDiv.innerHTML = `
            <a href="${url}">
                <img class="prodImage" src="${product.productImage}" alt="이미지 준비중">
            </a>
            <div class="prodName">
                <a href="${url}">${product.productName}</a>
            </div>
            <div class="prodPrice">${product.productPrice}원</div>
        `;
        prodListDiv.appendChild(productDiv);
    });
}
</script>
</body>
</html>