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
    <title>Nailro - care</title>
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
		
        .prodList {
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

        .prodImage {
            width: 100%;
            height: auto;
            max-height: 200px;
            object-fit: cover;
        }

        .product a {
            text-decoration: none;
            color: #333;
        }

        .prodName {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .prodPrice {
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
		
    .prodType {
        display: flex;
        gap: 60px; /* 원하는 간격 설정 */
        justify-content: flex-start; /* 버튼을 왼쪽으로 정렬 */
        margin-bottom: 30px; /* 간격을 위해 아래에 여분의 여백 추가 */
        margin-left: 10px;
    }

    .prodType button {
        padding: 15px 30px; /* 원하는 버튼 크기 설정 */
        font-size: 16px; /* 원하는 폰트 크기 설정 */
    }		
    </style>
</head>
<body>
<%
	List<ProductDTO> productList = ProductDAO.getDAO().selectProductByCategory("CareTool");
%>
    <div class="container">

    	<div class="sorting">
    	<select name="정렬 방식">
    		<option value="신상품순  " selected>&nbsp;신상품순&nbsp;</option>
    		<option value="이름순" >&nbsp;이름순&nbsp;</option>
    		<option value="가격순" >&nbsp;가격순&nbsp;</option>    	
    	</select>
    	</div>
</div>

    <div class="prodList" id="prodList">
        <% for (ProductDTO product : productList) { 
            String url = request.getContextPath() + "/index.jsp?group=detail&worker=detail"
                    + "&productNum=" + product.getProductNum();    
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
<script>

</script>
</body>
</html>