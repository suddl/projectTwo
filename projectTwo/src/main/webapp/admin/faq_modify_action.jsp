<%@page import="xyz.nailro.dao.FaqDAO"%>
<%@page import="xyz.nailro.dto.FaqDTO"%>
<%@page import="xyz.nailro.util.Utility"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/security/admin_check.jspf" %>    
<%
	if(request.getMethod().equals("GET"))	{
		request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?group=error&worker=error_400");
		return;
	}	
	
	//전달값을 반환받아 저장
	int faqNum=Integer.parseInt(request.getParameter("faqNum"));
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
	
	//faqDTO 객체를 생성하여 전달값으로 필드값 변경
	FaqDTO faq=new FaqDTO();
	faq.setFaqNum(faqNum);
	faq.setFaqCategory(faqCategory);
	faq.setFaqSubject(faqSubject); 
	faq.setFaqContent(faqContent);
	
	//게시글을 전달받아 faq 테이블의 저장된 행의 컬럼값을 변경하고 변경행의 갯수를 반환하는 faqDAO 클래스의 메소드 호출
	FaqDAO.getDAO().updateFaq(faq);
	
	//페이지 이동
	request.setAttribute("returnUrl", request.getContentType()+"/index.jsp?group=admin&worker=faq_detail"
		+"&faqNum="+faqNum+"&pageNum="+pageNum+"&pageSize="+pageSize+"&keyword="+keyword);	
	%>