<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="xyz.nailro.dao.ReviewDAO"%>
<%@ page import="xyz.nailro.dto.ReviewDTO"%>
<%-- <%@include file="/security/login_check.jspf"%> --%> 
  

<%	
 	String saveDirectory=request.getServletContext().getRealPath("/review_images");
    
	MultipartRequest multipartRequest=new MultipartRequest(request, saveDirectory
        , 20*1024*1024, "utf-8", new DefaultFileRenamePolicy());


    // 리뷰 데이터를 받아옵니다.
    String reviewSubject = multipartRequest .getParameter("review_subject");
    String reviewContent = multipartRequest.getParameter("review_content");
    
    // 이미지 처리 로직을 여기에 추가합니다. (예시 코드에서는 생략)

    ReviewDTO review = new ReviewDTO();
    review.setReviewSubject(reviewSubject);
    review.setReviewContent(reviewContent);
    //review.setReviewImage(reviewImage);
    // 이미지 정보도 여기에 추가합니다. (예시 코드에서는 생략)
	System.out.println(reviewSubject);
    
    
    
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
