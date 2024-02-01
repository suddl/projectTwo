<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="xyz.nailro.dao.ReviewDAO"%>
<%@ page import="xyz.nailro.dto.ReviewDTO"%>
<%-- <%@include file="/security/login_check.jspf"%> --%>

<%
    int reviewId = Integer.parseInt(request.getParameter("reviewId"));
    ReviewDAO dao = ReviewDAO.getDAO();
    ReviewDTO review = dao.selectReviewByNum(reviewId);
%>

<html>
<head>
    <title>리뷰 상세보기</title>
    <!-- 여기에 필요한 CSS와 JS 파일을 포함시킬 수 있습니다 -->
</head>
<body>
    <h1>리뷰 상세보기</h1>
    <% if (review != null) { %>
        <div>
            <h2><%= review.getReviewSubject() %></h2>
            <p><%= review.getReviewContent() %></p>
            <% if (review.getReviewImage() != null && !review.getReviewImage().isEmpty()) { %>
                <img src="<%= review.getReviewImage() %>" alt="리뷰 이미지" style="max-width: 400px;">
            <% } %>
            <div>
                <a href="review_modify.jsp?reviewId=<%= review.getReviewNum() %>">수정하기</a>
                <a href="review_remove_action.jsp?reviewId=<%= review.getReviewNum() %>" onclick="return confirm('정말 삭제하시겠습니까?');">삭제하기</a>
            </div>
        </div>
    <% } else { %>
        <p>리뷰를 찾을 수 없습니다.</p>
    <% } %>
</body>
</html>
