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
    int pageNum = 1;
    if (request.getParameter("pageNum") != null) {
        pageNum = Integer.parseInt(request.getParameter("pageNum"));
    }
    
    int pageSize = 12;
    if (request.getParameter("pageSize") != null) {
        pageSize = Integer.parseInt(request.getParameter("pageSize"));
    }
    
    int totalProduct=ProductDAO.getDAO().selectTotalSearchProduct(keyword);
    
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
                List<ProductDTO> searchResults = ProductDAO.getDAO().searchProduct(startRow, endRow, keyword);
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
                                 <img class="prodImage" src="<%=request.getContextPath() %>/<%=product.getProductImage()%>" alt="Product Image">
                             </a>
                             <div class="prodName">
                                 <a href="<%=url%>"><%=product.getProductName()%></a>
                             </div>
                             <div class="prodPrice" id="prodPrice"><%=product.getProductPrice()%>원</div>
                         </div>
             <%
                     }
                 }
             %>
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
</script>
</body>
</html>