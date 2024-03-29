<%@page import="xyz.nailro.dao.ReviewDAO"%>
<%@page import="xyz.nailro.dto.ReviewDTO"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- 글번호를 전달받아 REVIEW 테이블에 저장된 행(게시글)의 상태를 [0]으로 변경하여 삭제 
처리하고 [/review/review_list.jsp] 문서를 요청할 수 있는 URL 주소를 전달하여 응답하는 JSP 문서 --%>
<%-- => [/review/review_list.jsp] 문서에게 페이지번호, 게시글갯수, 검색대상, 검색단어 전달 --%>
<%-- => 로그인 상태의 사용자 중 게시글 작성자이거나 관리자인 경우에만 요청 가능한 JSP 문서 --%>

<%@include file="/security/login_check.jspf" %> 
<% 

	if (request.getParameter("reviewNum") == null) {
		request.setAttribute("returnUrl", request.getContextPath() + "/index.jsp?group=error&worker=error_400");
		return;
	}

	// 전달값을 반환받아 저장
	int reviewNum = Integer.parseInt(request.getParameter("reviewNum"));
	String pageNum = request.getParameter("pageNum");
	String pageSize = request.getParameter("pageSize");
	String search = request.getParameter("search");
	String keyword = request.getParameter("keyword");

	// 글번호를 전달받아 REVIEW 테이블의 단일행을 검색하여 게시글(ReviewDTO 객체)을 반환
	ReviewDTO review= ReviewDAO.getDAO().selectReviewByNum(reviewNum);

	// 검색된 게시글이 없는 경우에 대한 응답 처리 - 비정상적인 요청
	if (review == null) {
		request.setAttribute("returnUrl", request.getContextPath() + "/index.jsp?group=error&worker=error_400");
		return;
	}

	 //로그인 상태의 사용자가 게시글 작성자 및 관리자가 아닌 경우에 대한 응답 처리 - 비정상적인 요청
	 if(loginClient.getClientNum()!=review.getReviewClientNum() && loginClient.getClientStatus()!=9) {
		request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?group=error&worker=error_400");
		return;
	  }

	

	// 리뷰삭제 DAO 호출
	ReviewDAO.getDAO().deleteReviewByNum(reviewNum);
	if (review.getReviewImage() != null) {// 리뷰 이미지 파일이 있는 경우
		// 서버 디렉토리에서 삭제 처리될 게시글의 리뷰 이미지 파일을 삭제 처리
		new File(request.getServletContext().getRealPath(review.getReviewImage())).delete();
		
	}
%>
	
<% 
	// 페이지 이동 - 검색 및 페이징 처리 관련 값 전달
	request.setAttribute("returnUrl", request.getContextPath() + "/index.jsp?group=review&worker=review_list"
	+ "&pageNum=" + pageNum + "&pageSize=" + pageSize + "&search=" + search + "&keyword=" + keyword);
%>
