
<%@page import="xyz.nailro.dao.ProductDAO"%>
<%@page import="xyz.nailro.dao.OrderDAO"%>
<%@page import="xyz.nailro.dto.OrderDTO"%>
<%@page import="xyz.nailro.dto.ProductDTO"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="xyz.nailro.dao.ReviewDAO"%>
<%@ page import="xyz.nailro.dto.ReviewDTO"%>
 <%@include file="/security/login_check.jspf"%> 
  

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
	
	
	  
	String pageNum=multipartRequest.getParameter("pageNum");
	String pageSize=multipartRequest.getParameter("pageSize");
	String search=multipartRequest.getParameter("search");
	String keyword=multipartRequest.getParameter("keyword");
	
    // 리뷰 데이터를 받아옵니다.
    String reviewSubject = multipartRequest.getParameter("review_subject");
    String reviewContent = multipartRequest.getParameter("review_content");
    String reviewRating = multipartRequest.getParameter("review_rating");
    String reviewImage=null;
	if(multipartRequest.getFilesystemName("review_image")!=null) {//업로드 파일이 있는 경우	
		reviewImage="/review_images/"+multipartRequest.getFilesystemName("review_image");
	}
	
	int nextNum=ReviewDAO.getDAO().selectReviewNextNum();
	
	String reviewIp=request.getRemoteAddr();

	/*
	 // 어떻게 orderNum과 product.Num을 가져올지 의문
	 int orderReview = Integer.parseInt(request.getParameter("orderNum"));
	  OrderDTO order = OrderDAO.getDAO().selectOrderByNum(orderReview);
	   
	  int productNum = Integer.parseInt(request.getParameter("productNum"));
	   ProductDTO product = ProductDAO.getDAO().selectProductByNum(productNum);
	*/
	   
    ReviewDTO review = new ReviewDTO();
    review.setReviewSubject(reviewSubject);
    review.setReviewContent(reviewContent);
    review.setReviewRating(reviewRating);
    //review.setReviewOrderNum(Integer.parseInt(order.getOrderNum()));  
    review.setReviewOrderNum(73); // 임시로 임의의값을 넣은 것
    review.setReviewClientNum(loginClient.getClientNum());
    //review.setReviewProductNum(product.getProductNum());
    review.setReviewProductNum(58);
    review.setReviewImage(reviewImage);
	System.out.println(reviewSubject);
	System.out.println(reviewContent);
	System.out.println(reviewRating);
	

    
	  ReviewDAO dao = ReviewDAO.getDAO();
	    int result = dao.insertReview(review);

	    if (result > 0) {
	        // 리뷰 작성 성공
	    	request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?group=review&worker=review_list");
	    } else {
	        // 리뷰 작성 실패
	        out.println("<script>alert('리뷰 작성에 실패했습니다.'); history.back();</script>");
	    }


	    
    		
%>
