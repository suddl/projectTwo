<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Nailro - Nail</title>
    <link href="<%=request.getContextPath()%>/css/style.css" type="text/css" rel="stylesheet">
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
    </style>
</head>
<body>
    <div class="container">
        <div class="product-list">
            <div class="product">
                <a href="<%=request.getContextPath() %>/index.jsp?group=detail&worker=detail">
                    <img class="product-image" src="<%=request.getContextPath() %>/images/peachstonenail.jpg" alt="이미지 준비중">
                </a>
                <div class="product-name">
                    <a href="<%=request.getContextPath() %>/index.jsp?group=detail&worker=detail">피치 스톤 네일</a>
                </div>
                <div class="product-price">13,440원</div>
            </div>
            
                        <div class="product">
            	<a href="<%=request.getContextPath() %>/index.jsp?group=detail&worker=detail">
        		<img class="product-image" src="<%=request.getContextPath() %>/images/hellosunrisenail.jpg" alt="이미지 준비중"></a>
                <div class="product-name">
                <a href="<%=request.getContextPath() %>/index.jsp?group=detail&worker=detail">헬로 선라이즈 네일</a></div>
                <div class="product-price">11,840원</div>
            </div>

            
            <div class="product">
            	<a href="<%=request.getContextPath() %>/index.jsp?group=detail&worker=detail">
        		<img class="product-image" src="<%=request.getContextPath() %>/images/glowblushnail.jpg" alt="이미지 준비중"></a>
                <div class="product-name">
                <a href="<%=request.getContextPath() %>/index.jsp?group=detail&worker=detail">글로우 블러쉬 네일</a></div>
                <div class="product-price">15,120원</div>
            </div>
        
            
            <div class="product">
            	<a href="<%=request.getContextPath() %>/index.jsp?group=detail&worker=detail">
        		<img class="product-image" src="<%=request.getContextPath() %>/images/sugafrenchnail.jpg" alt="이미지 준비중"></a>
                <div class="product-name">
                <a href="<%=request.getContextPath() %>/index.jsp?group=detail&worker=detail">슈가 프렌치 네일</a></div>
                <div class="product-price">13,320원</div>
		</div>
	</div>
</div>
</body>
</html>