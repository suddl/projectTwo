<%@page import="xyz.nailro.dao.FaqDAO"%>
<%@page import="xyz.nailro.dto.FaqDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/security/admin_check.jspf" %>   
<%
	//글번호가 전달되지 않은 경우에 대한 응답 처리 - 비정상적인 요청
	if(request.getParameter("faqNum")==null) {
		request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?group=error&worker=error_400");
		return;
	}
	
	//전달값을 반환받아 저장
	int faqNum=Integer.parseInt(request.getParameter("faqNum"));
	String pageNum=request.getParameter("pageNum");
	String pageSize=request.getParameter("pageSize");
	String keyword=request.getParameter("keyword");
	
	//글번호를 전달받아 faq 테이블의 단일행을 검색하여 게시글(FaqDTO 객체)을 반환하는 
	//FaqDAO 클래스의 메소드 호출
	FaqDTO faq=FaqDAO.getDAO().selectFaqByNum(faqNum);
	
	//검색된 게시글이 없는 경우에 대한 응답 처리 - 비정상적인 요청
	if(faq==null) {
		request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?group=error&worker=error_400");
		return;
	}	
	
	//관리자가 아닌 경우에 대한 응답 처리 - 비정상적인 요청
	if(loginClient.getClientStatus()!=9) {
		request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?group=error&worker=error_400");
		return;
	}
	FaqDAO.getDAO().updateFaq(faq);
	
	//페이지 이동 - 검색 및 페이징 처리 관련 값 전달
	request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?group=admin&worker=admin_faq_list"
		+"&pageNum="+pageNum+"&pageSize="+pageSize+"&keyword="+keyword);	
%> 