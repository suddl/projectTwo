<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style>
.custom-center {
	display: flex;
	justify-content: center; /* 중앙 정렬 */
}
.custom-card {
	width: 20rem; /* 카드의 폭 조절 */
	margin-left: 15px; /* 이미지와 카드 사이의 간격 조절 */
	display: flex;
}
.carousel .carousel-item img {
	max-width: 100%; /* 이미지 크기 조절 */
	height: auto; /* 이미지 높이 자동 조절 */
}
.custom-nav .nav-link {
	color: white; /* 기본 글자색 */
	background-color: black; /* 기본 배경색 */
}
.custom-nav .nav-link.active {
	background-color: gray; /* 활성 탭의 배경색 */
	color: black; /* 활성 탭의 글자색 */
}
div {
	text-align: center;
}
.di-line {
	border-top: 1px solid #444444;
	margin: 30px auto;
	width: auto;
}
#cart {
	margin-left: auto;
	text-align: center;
	background-color: gray;
	color: white;
	border: none;
}
#purchase {
	text-align: center;
	background-color: black;
	color: white;
	border: none;
}
#topBtn {
	position: fixed;
	right: 0%;
	bottom: 0px;
	display: none;
	z-index: 999;
	width: 50px; /* 버튼의 너비 */
	background-size: cover; /* 이미지가 버튼 크기에 맞게 조정됨 */
	
}
.button a {
	font-size: 20px;
	display: inline-block;
	padding: 10px 20px; /* 버튼의 크기 조절 */
	background-color: pink; /* 배경색 */
	color: black; /* 글자색 */
	text-decoration: none; /* 밑줄 제거 */
	border: none; /* 테두리 제거 */
	text-align: center;
	margin: 0px;
	border-radius: 5px;
}
.button a:hover {
	/* 마우스 호버 시 배경색 변경 */
	
}
.custom-nav .col-auto {
	margin: 0 auto;
	margin-right: 5px;
	margin-left: 20px;
}
.totalPrice {
	text-align: left;
}
.di-line {
	border-top: 1px dotted #444444;
	margin: 30px auto;
	width: auto;
}
.delivery {
	font-size: 1em;
	background-color: #f0f0f0; /* 배경색 추가 */
}
#reviwImage {
	margin: 132px;
}
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
	<form
		action="<%=request.getContextPath()%>/index.jsp?group=detail&worker=detail"
		method="post" id="detail" name="detail">
		<a id="topBtn" href="#">
		<img src="../images/topBtn.jpg">
	</a>
		</a>
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
							</div>
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
								<a href="<%=request.getContextPath()%>/index.jsp?group=cart&worker=cart_page" id="cart">장바구니</a> 
								<a href="<%=request.getContextPath()%>/index.jsp?group=order&worker=order_main" id="purchase">바로구매</a>
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
			&nbsp;&nbsp;
			<ul class="nav nav-pills nav-justified custom-nav">
				<li class="nav-item"><a class="nav-link active"
					aria-current="page" href="#reviewSection" id="pd">제품리뷰</a></li>
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
			
			<p>REVIEW</p>
			
			<jsp:include page="../review/review.jsp" />
			<div id="reviewSection">
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
</script>
			<script type="text/javascript">
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
<script type="text/javascript">
    window.onload = function() { //새로고침시 제일 위로가는 코드
        window.scrollTo(0, 0);
    }
</script>
			<script
				src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
				integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
				crossorigin="anonymous">
	</script>
</body>
</html>