 <%@page import="xyz.nailro.dto.ReviewDTO"%>
<%@page import="java.util.List"%>
<%@page import="xyz.nailro.dao.ReviewDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link href="<%=request.getContextPath()%>/css/detail.css" type="text/css" rel="stylesheet">

<head>
<style>

</style>
<meta charset="UTF-8">
<title>상세페이지</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
	crossorigin="anonymous">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link href="<%=request.getContextPath()%>/css/header.css"
	type="text/css" rel="stylesheet">
</head>
<body>
<a id="topBtn" href="#"> <img src="./images/topBtn.jpg"></a>
		<form
		action="<%=request.getContextPath()%>/index.jsp?group=detail&worker=detail"
		method="post" id="detail" name="detail"></form>
		<div class="container">
			<div class="row custom-center">
				<div class="col-md-4">
					<div id="carouselExample" class="carousel slide">
						<div id="carouselExample" class="carousel slide">
							<div class="carousel-inner">
								<div class="carousel-item active">
									<img src="<%=request.getContextPath()%>/images/d_main1.jpg"
										alt="d_main" class="d-block w-100" alt="peach">
								</div>
								<div class="carousel-item">
									<img src="<%=request.getContextPath()%>/images/d_main2.jpg"
										class="d-block w-100" alt="...">
								</div>
								<div class="carousel-item">
									<img src="<%=request.getContextPath()%>/images/d_main3.jpg"
										class="d-block w-100" alt="...">
								</div>
							</div>
							<button class="carousel-control-prev" type="button"
								data-bs-target="#carouselExample" data-bs-slide="prev">
								<span class="carousel-control-prev-icon" aria-hidden="true"></span>
								<span class="visually-hidden">Previous</span>
							</button>
							<button class="carousel-control-next" type="button"
								data-bs-target="#carouselExample" data-bs-slide="next">
								<span class="carousel-control-next-icon" aria-hidden="true"></span>
								<span class="visually-hidden">Next</span>
							</button>
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="card custom-card">
						<div class="card-body">
							&nbsp;&nbsp;
							<h5 class="card-title">선라이즈 네일</h5>
							<%--값받아오기 <input type="hidden" name="productPrice" value="<%= %>">--%>
							&nbsp;&nbsp;
							<p class="price">가격 :</p>
							<%--값받아오기 <input type="hidden" name="productPrice" value="<%= %>">--%>
							<div class="di-line"></div>
							<div class="num"></div>
							<div class="row">
								<div class="col-auto">
									<label class="col-form-label">&nbsp;&nbsp;구매수량</label>
								</div>
								<div class="col-auto">
									<button type="button" id="minusBtn" onclick="countZero();">-</button>
									&nbsp;&nbsp; <span id="count1" style="display: inline-block;">1</span>&nbsp;&nbsp;
									<button type="button" id="plusBtn" onclick="countUp();">+</button>
								</div>
							</div></
							&nbsp;&nbsp;
							<!-- 총 상품 금액을 표시할 요소 -->
							<div id="totalPrice" class="totalPrice">&nbsp;총 상품 금액:</div>
							<script type="text/javascript"> 
    var unitPrice = 18000; // 상품 단가
    var count = 1; // 초기 수량
    function updateTotalPrice() {
        var totalPrice = unitPrice * count;
        document.getElementById("totalPrice").innerText = "총 상품 금액: " + totalPrice + "원";
    }
    function countUp() {
        count++;
        document.getElementById("count1").innerText = count;
        updateTotalPrice();
    }
    function countZero() {
        if (count > 1) {
            count--;
            document.getElementById("count1").innerText = count;
            updateTotalPrice();
        }
    }
    window.onload = function() {
        updateTotalPrice(); // 페이지 로딩 시 초기 총 금액 설정
    }
</script>
							&nbsp;
							<div class="button">
								<a href="#" id="cart">장바구니</a> <a href="#" id="purchase">바로구매</a>
							</div>
							&nbsp;&nbsp;
							<ul>
								<li>
							</ul>
							<tr class="delivery">
								<th scope="row">[기본배송]3,000원</th>
								<td class="delv_price">
									<div>제주 및 특수 도서 산간 지역 3,000원 추가</div>
									<div>(5만원 이상 구매 시 무료)</div>&nbsp;&nbsp;
								</td>
							</tr>
						</div>
					</div>
				</div>
			</div>
			</div>
			
			&nbsp;&nbsp;

			<ul class="nav nav-pills nav-justified custom-nav">
				<li class="nav-item"><a class="nav-link active"
					aria-current="page" href="#review" id="pd">제품리뷰</a></li>
				<li class="nav-item"><a class="nav-link" href="#d_img1" id="pd">제품상세</a></li>
				<li class="nav-item"><a class="nav-link" href="#info" id="pd">상품설명</a></li>
			</ul>
			<div>
				<img src="<%=request.getContextPath()%>/images/d_detail1.jpg"
					class="img-fluid" id="d_img1"> <img
					src="<%=request.getContextPath()%>/images/d_detail2.jpg"
					class="img-fluid" id="dedatilimg1"> <img
					src="<%=request.getContextPath()%>/images/info.jpg"
					class="img-fluid" id="info">
			</div>
			<ul class="nav nav-pills nav-justified custom-nav">
				<li class="nav-item"><a class="nav-link active"
					aria-current="page" href="#review" id="pd">제품리뷰</a></li>
				<li class="nav-item"><a class="nav-link" href="#d_img1" id="pd">제품상세</a></li>
				<li class="nav-item"><a class="nav-link" href="#info" id="pd">상품설명</a></li>
			</ul>
			<p id="review"></p>
		<%@include file="/review/review_list.jsp"%>
			<%--
			<h2>" + review.getReview_subject() + "</h2>");
        out.println("<p>" ++ "</p>");
        out.println("<img src='" + review.getReview_image() + "' alt='Review Image'/>");
			
			
			
    // 상품 ID 설정 (예시로 1번 상품)
    int productId = 1;
    ReviewDAO dao = ReviewDAO.getDAO();
    List<ReviewDTO> reviewList = dao.selectProductReviews(productId);
    for (ReviewDTO review : reviewList) {
        // 리뷰 정보를 출력합니다. 
        out.println("<h2>" + review.getReview_subject() + "</h2>");
        out.println("<p>" + review.getReview_content() + "</p>");
        out.println("<img src='" + review.getReview_image() + "' alt='ReviewImage'/>");
    }
--%>
			<%-- 데이터베이스에서 리뷰 데이터 가져오기 --%>
			<%--리뷰를 3개까지만 출력하는 용도--%>
			<%-- 
				<% for (int i = 0; i < 3; i++) { %>
				
				<div id=>
				<img src="<%=request.getContextPath()%>/images/d_detail1.jpg"
					 id="reviwImage">
				</div>
				
				<% } %>
			<%-- 	
		<% String reviewTitle = (String) request.getAttribute("reviewTitle");
    	String reviewContent = (String) request.getAttribute("reviewContent");
    	String reviewContent = (String) request.getAttribute("reviewImage");
    	%>
    	
<div>
    <h2>리뷰 제목: <%= review.reviewSubject %></h2>
    <p>리뷰 내용: <%= review.reviewContent %></p>
    <p>리뷰 내용: <%= review.reviewImage %></p>
</div>
--%>
			<%-- 버튼 선택에 따라 글씨 색 변경--%>
			<script>
    // 모든 nav-link 요소를 가져옵니다.
    const navLinks = document.querySelectorAll('.nav-link');
    navLinks.forEach(link => {
        link.addEventListener('click', function() {
            // 모든 nav-link 요소에서 active 클래스를 제거합니다.
            navLinks.forEach(l => l.classList.remove('active'));
            this.classList.add('active'); //클릭 요소만 실행
        });
    });

		//topBtn관련 js
	$(function() {
		$(window).scroll(function() {
			if ($(this).scrollTop() > 800) { // 스크롤 위치가 800px 이상일 때
				$("#topBtn").fadeIn(); // 버튼 나타남
			} else {
				$("#topBtn").fadeOut(); // 그렇지 않으면 버튼 숨김
			}s
		});
		
		$("#topBtn").click(function() {
			$('html, body').animate({
				scrollTop : 0 // 상단으로 스크롤
			}, 500);
			return false;
		});
	});

			
   
</script>
			<script
				src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
				integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
				crossorigin="anonymous">
	</script>
</body>
</html>