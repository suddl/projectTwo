<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="xyz.nailro.dao.ReviewDAO"%>
<%@ page import="xyz.nailro.dto.ReviewDTO"%>
<%-- <%@include file="/security/login_check.jspf"%>   --%>

<%
    request.setCharacterEncoding("UTF-8");
    // 리뷰 데이터를 받아옵니다.
    String reviewSubject = request.getParameter("reviewSubject");
    String reviewContent = request.getParameter("reviewContent");
    // 이미지 처리 로직을 여기에 추가합니다. (예시 코드에서는 생략)

    ReviewDTO review = new ReviewDTO();
    review.setReview_subject(reviewSubject);
    review.setReview_content(reviewContent);
    // 이미지 정보도 여기에 추가합니다. (예시 코드에서는 생략)

    ReviewDAO dao = ReviewDAO.getDAO();
    int result = dao.insertReview(review);

    if (result > 0) {
        // 리뷰 작성 성공
        response.sendRedirect("review_list.jsp");
    } else {
        // 리뷰 작성 실패
        out.println("<script>alert('리뷰 작성에 실패했습니다.'); history.back();</script>");
    }
%>
