<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="xyz.nailro.dao.ReviewDAO"%>
<%@ page import="xyz.nailro.dto.ReviewDTO"%>
<%-- <%@include file="/security/login_check.jspf"%> --%> 
  

<%	
//JSP 문서를 GET 방식으로 요청한 경우에 대한 응답 처리 - 비정상적인 요청
	if(request.getMethod().equals("GET")) {
		request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?group=error&worker=error_400");
		return;
	}
 
	//전달파일을 저장할 서버 디렉토리의 파일 시스템 경로를 반환받아 저장
	//String saveDirectory=application.getRealPath("/review_images");
	String saveDirectory=request.getServletContext().getRealPath("/review_images");
	//System.out.println("saveDirectory = "+saveDirectory);
	
	//MultipartRequest 객체 생성 - 모든 전달파일을 서버 디렉터리에 저장되도록 자동 업로드 처리
	// => cos.jar 라이브러리 파일을 프로젝트에 빌드 처리해야만 MultipartRequest 클래스 사용 가능
	MultipartRequest multipartRequest=new MultipartRequest(request, saveDirectory
			, 20*1024*1024, "utf-8", new DefaultFileRenamePolicy());
	

    // 리뷰 데이터를 받아옵니다.
    String reviewSubject = multipartRequest.getParameter("review_subject");
    String reviewContent = multipartRequest.getParameter("review_content");
    String reviewRating = multipartRequest.getParameter("review_rating");
    // 이미지 처리 로직을 여기에 추가합니다. (예시 코드에서는 생략)

    ReviewDTO review = new ReviewDTO();
    review.setReviewSubject(reviewSubject);
    review.setReviewContent(reviewContent);
    review.setReviewRating(reviewRating);
    review.setReviewOrderNum(43);  // 임시로 임의의값을 넣은 것임
    review.setReviewClientNum(4);
    review.setReviewProductNum(56);
    //review.setReviewImage(reviewImage);
    // 이미지 정보도 여기에 추가합니다. (예시 코드에서는 생략)
	System.out.println(reviewSubject);
	System.out.println(reviewContent);
	System.out.println(reviewRating);
	
    
    
    
    
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
