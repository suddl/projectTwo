<%@page import="org.apache.catalina.authenticator.SavedRequest"%>
<%@page import="xyz.nailro.dto.FaqDTO"%>
<%@page import="xyz.nailro.dao.FaqDAO"%>
<%@page import="xyz.nailro.util.Utility"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/security/admin_check.jspf"%>
<%
	//JSP 문서를 GET 방식으로 요청한 경우에 대한 응답 처리 - 비정상적인 요청
	if(request.getMethod().equals("GET")) {
		request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?group=error&worker=error_400");
		return;
	}
	
	String pageNum=request.getParameter("pageNum");
	String pageSize=request.getParameter("pageSize");
	String search=request.getParameter("keyword");
	
	String faqCategory=request.getParameter("faqCategory");
	String faqSubject=Utility.escapeTag(request.getParameter("faqSubject"));
	String keyword=request.getParameter("keyword");
	
	if(faqCategory.equals("배송")){
		faqCategory="배송관련";
	} else if(faqCategory.equals("제품")){
		faqCategory="제품관련";
	} else if(faqCategory.equals("회원")){
		faqCategory="회원관련";
	} else if(faqCategory.equals("주문")){
		faqCategory="주문/결제";
	} else if(faqCategory.equals("교환")){
		faqCategory="교환/반품";
	} else if(faqCategory.equals("기타")){
		faqCategory="기타";
	}
	
	String faqContent=Utility.escapeTag(request.getParameter("faqContent"));
	
	int nextNum=FaqDAO.getDAO().selectFaqNextNum();
	
	//faqDTO 객체를 생성하여 전달값으로 필드값 변경
	FaqDTO faq=new FaqDTO();
	faq.setFaqNum(nextNum);
	faq.setFaqCategory(faqCategory);
	faq.setFaqSubject(faqSubject);
	faq.setFaqContent(faqContent);
	
	//게시글을 전달받아 faq 테이블의 행으로 삽입하고 삽입행의 갯수를 반환하는 faqDAO 클래스의 메소드 호출
	FaqDAO.getDAO().insertFaq(faq);
	
	//페이지 이동
	request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?group=admin&worker=faq_list"
		+"&pageNum="+pageNum+"&pageSize="+pageSize+"&keyword="+keyword);
	