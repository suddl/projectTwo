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
	if(request.getMethod().equals("GET")) {
		request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?group=error&worker=error_400");
		return;
	}
 
	String saveDirectory=request.getServletContext().getRealPath("/review_images");
	
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
	
	int orderNum = Integer.parseInt(multipartRequest.getParameter("orderNum"));
	int productNum = Integer.parseInt(multipartRequest.getParameter("productNum"));
	   
    ReviewDTO review = new ReviewDTO();
    review.setReviewOrderNum(orderNum);  
    review.setReviewProductNum(productNum);
    review.setReviewSubject(reviewSubject);
    review.setReviewContent(reviewContent);
    review.setReviewRating(reviewRating);
    review.setReviewClientNum(loginClient.getClientNum());
    review.setReviewImage(reviewImage);
	
	ReviewDAO.getDAO().insertReview(review);

    request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?group=review&worker=review_list");

%>
