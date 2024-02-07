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
<%	
	String keyword=request.getParameter("keyword");
	if(keyword==null)	{
		keyword="";
	}
%>   
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
    
    p {
  font-size: 30px;
  font-weight: bold;
  text-align: center;
  margin-top: 60px;
}
 
    </style>
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
        <div class="product-list">
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