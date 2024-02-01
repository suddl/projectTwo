<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="xyz.nailro.dao.ReviewDAO"%>
<%@ page import="xyz.nailro.dto.ReviewDTO"%>
<%-- <%@include file="/security/login_check.jspf"%> --%>

<%
    //수정필요오
    int productId = 1; // 실제 상황에 맞게 변경 필요

    ReviewDAO dao = ReviewDAO.getDAO();
    List<ReviewDTO> reviews = dao.selectProductReviews(productId);
%>

<html>
<head>
    <title>리뷰 목록</title>
<style type="text/css">
div {
	margin: 200px;
	padding: 100px;
}
</style>
</head>
<body>
    <h1>리뷰 목록</h1>
    <div>
        <% if(reviews != null && !reviews.isEmpty()) { %>
            <% for(ReviewDTO review : reviews) { %>
                <div>
                    <h2><%= review.getReviewSubject() %></h2>
                    <p><%= review.getReviewContent() %></p>
                    <% if (review.getReviewImage() != null && !review.getReviewImage().isEmpty()) { %>
                        <img src="<%= review.getReviewImage() %>" alt="리뷰 이미지" style="max-width: 200px;">
                    <% } %>
                    <a href="review_detail.jsp?reviewId=<%= review.getReviewNum() %>">상세보기</a>
                </div>
            <% } %>
        <% } else { %>
            <p>리뷰가 없습니다.</p>
        <% } %>
    </div>
</body>
</html>
