<%@page import="xyz.nailro.dao.ProductDAO"%>
<%@page import="xyz.nailro.dto.ProductDTO"%>
<%@page import="xyz.nailro.dto.ReviewDTO"%>
<%@page import="java.util.List"%>
<%@page import="xyz.nailro.dao.ReviewDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<% 
   int productNum = Integer.parseInt(request.getParameter("productNum"));
   ProductDTO product = ProductDAO.getDAO().selectProductByNum(productNum);
   
   
   int productReview = Integer.parseInt(request.getParameter("productNum"));
	List<ReviewDTO> reviewList = ReviewDAO.getDAO().selectProductReviewsForProduct(productReview);
%>
<head>
<style>
.review-table {
	width: 80%;
	margin: 0 auto;
	border-collapse: collapse;
}
.review-table td,
.review-table th {
	border: 1px solid #ddd;
	padding: 8px;
}
.review-table .rating,
.review-table .date {
	width: 15%;
}
.review-table .subject {
	width: 50%;
	height: 20%
}
.review-table .review-content {
	text-align: conter;
}
.review-table img {
	max-width: 100px;
	height: auto;
}
#ratingSubjectDate {
	background-color: #E2E2E2;
}
</style>
<meta charset="UTF-8">
<title>상세페이지</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
<link href="<%=request.getContextPath()%>/css/detail.css" type="text/css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link href="<%=request.getContextPath()%>/css/header.css" type="text/css" rel="stylesheet">
</head>
<body>
<a id="topBtn" href="#"><img src="./images/topBtn.jpg"></a>
<form action="<%=request.getContextPath()%>/index.jsp" method="get"  id="detail" name="detail">
     <input type="hidden" name="group" value="cart">
      <input type="hidden" name="worker" value="cartIn_action">
     <input type="hidden" name="productNum" id="productNum" value="<%=productNum %>">
     <div class="container">
        <div class="row custom-center">
           <div class="col-md-4">
              <div id="carouselExample" class="carousel slide">
                 <div id="carouselExample" class="carousel slide">
                    <div class="carousel-inner">
                       <div class="carousel-item active">
                          <img src="<%=request.getContextPath() %><%=product.getProductImage() %>" alt="d_main" class="d-block w-100" alt="peach">
                       </div>
                       <div class="carousel-item">
                          <img src="<%=request.getContextPath() %><%=product.getProductImage2() %>" class="d-block w-100" alt="...">
                       </div>
                    </div>
                    <button class="carousel-control-prev" type="button" data-bs-target="#carouselExample" data-bs-slide="prev">
                       <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                       <span class="visually-hidden">Previous</span>
                    </button>
                    <button class="carousel-control-next" type="button" data-bs-target="#carouselExample" data-bs-slide="next">
                       <span class="carousel-control-next-icon" aria-hidden="true"></span>
                       <span class="visually-hidden">Next</span>
                    </button>
                 </div>
              </div>
           </div>
		<div class="col-md-4">
			<div class="card custom-card">
                 <div class="card-body">
                    <h5 class="card-title"><%=product.getProductName()%></h5>
                    &nbsp;&nbsp;
                     <p class="price">가격 : <%=product.getProductPrice()%>원</p>
                     <div class="di-line"></div>
                     <div class="priceCount">
						<div class="col-auto">
						   구매수량 : 
						   <button type="button" id="minusBtn" onclick="countZero();">-</button>&nbsp;&nbsp;
							<%-- 여기서는 화면에 출력해주고 --%>
							<span id="count1" name="count1" style="display: inline-block;" value="1">  </span>&nbsp;&nbsp;
							<%-- 여기서는 데이터를 action에 넘긴다 --%>
							<input type="hidden" name ="counting" id="countHidden" value="1">
							<button type="button" id="plusBtn" onclick="countUp();">+</button>
						</div>
                    </div>
                    <div id="totalPrice" class="totalPrice">&nbsp;&nbsp;총 상품 금액:</div> 
   					&nbsp;&nbsp; &nbsp;&nbsp;
					<div class="button-container d-flex justify-content-around mt-3">
				    	<button type="submit" id="cartBtn" class="btn btn-secondary">장바구니 담기</button>
				    	<a href="<%=request.getContextPath()%>/index.jsp?group=order&worker=order_main" class="btn btn-success" id="purchase">바로구매</a>
					</div>
		    		&nbsp;&nbsp;
		    		<div class="infodeli">
					[기본배송]3,000원<br>
				    제주 및 특수 도서 산간 지역 3,000원 추가<br>
				    (5만원 이상 구매 시 무료)&nbsp;&nbsp;
				    </div>
				</div>
              </div>
		</div>
		</div>
	</div>
</form>
&nbsp;&nbsp;
<!-- 
<ul class="nav nav-pills nav-justified custom-nav" id="proDetail">
   <li class="nav-item"><a class="nav-link active" aria-current="page" href="#proDetail" id="pd" style="backgroud:gray;">제품상세</a></li>
   <li class="nav-item"><a class="nav-link" href="#proInfo" id="pd">상품설명</a></li>
   <li class="nav-item"><a class="nav-link"  href="#proReview" id="pd">제품리뷰</a></li>
</ul>
<img src="<%=request.getContextPath() %><%=product.getProductImage3() %>" class="img-fluid" id="dedatilimg1"> 
<ul class="nav nav-pills nav-justified custom-nav"  id="proInfo">
   <li class="nav-item"><a class="nav-link" href="#proDetail" id="pd">제품상세</a></li>
   <li class="nav-item"><a class="nav-link active" aria-current="page" href="#proInfo" id="pd">상품설명</a></li>
   <li class="nav-item"><a class="nav-link" href="#proReview" id="pd">제품리뷰</a></li>
</ul>
<img src="<%=request.getContextPath()%>/images/info.jpg" class="img-fluid" id="info">
<ul class="nav nav-pills nav-justified custom-nav"  id="proReview">
   <li class="nav-item"><a class="nav-link" href="#proDetail" id="pd">제품상세</a></li>
   <li class="nav-item"><a class="nav-link" href="#proInfo" id="pd">상품설명</a></li>
   <li class="nav-item"><a class="nav-link active" aria-current="page" href="#proReview" id="pd">제품리뷰</a></li>
</ul>
 -->
 
 <ul class="proDetail" id="proDetail">
   <li class="item-1"><a class="protitle" href="#proDetail" id="pd">제품상세</a></li>
   <li class="item-1"><a class="proto" href="#proInfo" id="pd" style="color:white;">상품설명</a></li>
   <li class="item-1"><a class="proto" href="#review" id="pd" style="color:white;">제품리뷰</a></li>
</ul>
<img src="<%=request.getContextPath() %><%=product.getProductImage3() %>" class="img-fluid" id="dedatilimg1"> 
<ul class="proInfo"  id="proInfo">
   <li class="item-2"><a class="proto" href="#proDetail" id="pd"  style="color:white;">제품상세</a></li>
   <li class="item-2"><a class="protitle" href="#proInfo" id="pd">상품설명</a></li>
   <li class="item-2"><a class="proto" href="#review" id="pd" style="color:white;">제품리뷰</a></li>
</ul>
<img src="<%=request.getContextPath()%>/images/info.jpg" class="img-fluid" id="info">
<ul class="proReview"  id="proReview">
   <li class="item-3"><a class="proto" href="#proDetail" id="pd" style="color:white;">제품상세</a></li>
   <li class="item-3"><a class="proto" href="#proInfo" id="pd" style="color:white;">상품설명</a></li>
   <li class="item-3"><a class="protitle"  href="#review" id="pd">제품리뷰</a></li>
</ul>
 
<h2 id="review" >REVIEW</h2>
<% if(reviewList != null && !reviewList.isEmpty()) { %>
    <table class="review-table">
        <% int count = 0; %>
        <% for(ReviewDTO review : reviewList) { %>
            <% count++; %>
            <tbody <% if(count > 3) { %>class="additional-reviews" style="display: none;"<% } %>>
                <tr id="ratingSubjectDate">
                    <td class="rating">평점: <%= review.getReviewRating() %></td>
                    <td class="subject">제목 : <%= review.getReviewSubject() %></td>
                    <td class="date"><%= review.getReviewDate() %></td>
                </tr>
                <tr>
                    <td colspan="3" class="review-content">
                        <p><%= review.getReviewContent() %></p>
                        <% if(review.getReviewImage() != null && !review.getReviewImage().isEmpty()) { %>
                            <img src="<%= request.getContextPath() + "/" + review.getReviewImage() %>" alt="리뷰 이미지">
                        <% } %>
                    </td>
                </tr>
            </tbody>
        <% } %>
    </table>
    <% if(count > 3) { %>
        <button id="showMore">더보기</button>
    <% } %>
<% } else { %>
    <p>이 제품에 대한 리뷰가 없습니다.</p>
<% } %>
<%-- 버튼 선택에 따라 글씨 색 변경--%>
<script type="text/javascript">
var count = 1; // 초기 수량
//제품상세,제품리뷰 바에서 클릭시 색상 변경되는 코드
// 모든 nav-link 요소를 가져옵니다.
const navLinks = document.querySelectorAll('.nav-link');
navLinks.forEach(link => {
    link.addEventListener('click', function() {
        // 모든 nav-link 요소에서 active 클래스를 제거합니다.
        navLinks.forEach(l => l.classList.remove('active'));
        this.classList.add('active'); //클릭 요소만 실행
    });
});
//총상품금액 코드
var unitPrice = <%=product.getProductPrice()%>; // 상품 단가
document.getElementById("count1").innerText = count;//초기수량 출력
function updateTotalPrice() {
    var totalPrice = unitPrice * count;
    document.getElementById("totalPrice").innerText = "총 상품 금액: " + new Intl.NumberFormat('en-US').format(totalPrice)+ "원";
}
function countUp() {
    count++;
    //화면에 나오는 출력값 변경
    document.getElementById("count1").innerText = count;
    //action으로 데이터 넘기는 히든필드 값 변경
    document.getElementById("countHidden").value = count;
    
    updateTotalPrice();
}
function countZero() {
    if (count > 1) {
        count--;
        document.getElementById("count1").innerText = count;
        document.getElementById("count1").value = count;
        updateTotalPrice();
    }
}
window.onload = function() {
    updateTotalPrice(); // 페이지 로딩 시 초기 총 금액 설정
}
//topBtn관련 js
$(function() {
   $(window).scroll(function() {
      if ($(this).scrollTop() > 800) { // 스크롤 위치가 800px 이상일 때
         $("#topBtn").fadeIn(); // 버튼 나타남
      } else {
         $("#topBtn").fadeOut(); // 그렇지 않으면 버튼 숨김
      }
   });
   
   $("#topBtn").click(function() {
      $('html, body').animate({
         scrollTop : 0 // 상단으로 스크롤
      }, 500);
      return false;
   });
});
 //detail 하단 리뷰 더보기
 document.getElementById("showMore").addEventListener("click", function() {
       var additionalReviews = document.querySelectorAll(".additional-reviews");
       for(var i = 0; i < additionalReviews.length; i++) {
           additionalReviews[i].style.display = ""; // 추가 리뷰 보이기
       }
       this.style.display = "none"; // "더보기" 버튼 숨기기
   });
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
</body>
</html>