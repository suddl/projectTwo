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
	ReviewDAO.getDAO().DeleteReviewByNum(reviewNum);
	if (review.getReviewImage() != null) {// 리뷰 이미지 파일이 있는 경우
		// 서버 디렉토리에서 삭제 처리될 게시글의 리뷰 이미지 파일을 삭제 처리
		new File(request.getServletContext().getRealPath(review.getReviewImage())).delete();
		
	}
	out.println("alert('리뷰가 삭제되었습니다! 메인페이지로 돌아갑니다.');");
	
	
	/*
    // 리뷰 삭제 로직을 수행하는 서버 측 코드
    try {
        // 리뷰 삭제 DAO 호출
        ReviewDAO.getDAO().DeleteReviewByNum(reviewNum);
        if (review.getReviewImage() != null) {
            // 서버 디렉토리에서 삭제 처리될 게시글의 리뷰 이미지 파일을 삭제 처리
            new File(request.getServletContext().getRealPath(review.getReviewImage())).delete();
        }

        // 리뷰 삭제 성공 후 클라이언트 측에 JavaScript 코드를 통해 알림 메시지를 보여주고 이전 페이지로 돌아가는 로직
        out.println("<script type='text/javascript'>");
        out.println("alert('리뷰가 삭제되었습니다! 메인페이지로 돌아갑니다.');");
        out.println("history.go(1);"); // 이전 페이지로 돌아갑니다.
        out.println("</script>");
    } catch (Exception e) {
        // 예외 처리 로직 (예외가 발생한 경우)
        out.println("<script type='text/javascript'>");
        out.println("alert('리뷰 삭제 중 오류가 발생했습니다. 다시 시도해주세요.');");
        out.println("history.back(-1);");
        out.println("</script>");
    }
	*/



	
	
	
	// 페이지 이동 - 검색 및 페이징 처리 관련 값 전달
	request.setAttribute("returnUrl", request.getContextPath() + "/index.jsp?group=review&worker=review_list"
	+ "&pageNum=" + pageNum + "&pageSize=" + pageSize + "&search=" + search + "&keyword=" + keyword);
	

%>
