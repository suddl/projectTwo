<%@page import="java.io.File"%>
<%@page import="xyz.nailro.dao.ProductDAO"%>
<%@page import="xyz.nailro.dto.ProductDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 상품번호를 전달받아 RRODUCT 테이블에 저장된 행(게시글)의 상태를 [0]으로 변경하여 삭제 
처리하고 [/admin/product_list.jsp] 문서를 요청할 수 있는 URL 주소를 전달하여 응답하는 JSP 문서 --%>    
<%-- => [/admin/product_list.jsp] 문서에게 페이지번호, 게시글갯수, 검색대상, 검색단어 전달 --%>
<%-- => 로그인 상태의 사용자 중 게시글 작성자이거나 관리자인 경우에만 요청 가능한 JSP 문서 --%>    

<%@include file="/security/admin_check.jspf" %>    
<%
	//JSP 문서를 GET 방식으로 요청한 경우에 대한 응답 처리 - 비정상적인 요청
	if(request.getMethod().equals("GET")) {
		request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?group=error&worker=error_400");
		return;
	}	

	//전달값을 반환받아 저장
	String[] checkp=request.getParameterValues("checkp");
	
	for(String productNum:checkp) {
		ProductDAO.getDAO().deleteProduct(productNum);
	}
	
	//페이지 이동 - 검색 및 페이징 처리 관련 값 전달
	request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?group=admin&worker=product_list");	
%>

