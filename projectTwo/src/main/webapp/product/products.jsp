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

<a href = "#">
	<img class="logo" src="<%= request.getContextPath() %>/images/<%=category%>Logo.jpg"/>
</a>
<div class="container">
	<div class="sorting">
		<p>
<a href="javascript:recent)">신상품순</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;
<a href="javascript:name">이름순</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;
<a href="javascript:pricelist">낮은가격순</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;
<a href="javascript:pricelistdesc">높은가격순</a></p>		
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
            <div class="prodPrice"><%=product.getProductPrice()%>원</div>
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
	var productPrice = <%=prod.getProductPrice()%>;
	function.settingPrice()	{
	document.getElementById("productPrice").innerText=new Intl.NumberFormat('en-US').format(productPrice);
	}
</script>
</body>
</html>