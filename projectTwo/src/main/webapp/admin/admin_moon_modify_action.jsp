<%@page import="xyz.nailro.dto.MoonDTO"%>
<%@page import="java.io.File"%>
<%@page import="xyz.nailro.dao.MoonDAO"%>
<%@page import="xyz.nailro.util.Utility"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/security/login_check.jspf" %>    

<%
	if(request.getMethod().equals("GET")) {
		request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?group=error&worker=error_400");
		return;
	}

	
	String saveDirectory=request.getServletContext().getRealPath("/moon_images");
	
	MultipartRequest multipartRequest = new MultipartRequest(request, saveDirectory, 20*1024*1024,"utf-8", new DefaultFileRenamePolicy());
	
	int moonNum=Integer.parseInt(multipartRequest.getParameter("moonNum"));
	String pageNum=multipartRequest.getParameter("pageNum");
	String pageSize=multipartRequest.getParameter("pageSize");
	String search=multipartRequest.getParameter("search");
	String keyword=multipartRequest.getParameter("keyword");
	
	String moonTitle=multipartRequest.getParameter("moonTitle");
	if(moonTitle.equals("상품")){
		moonTitle="상품 문의입니다.";
	} else if(moonTitle.equals("배송")){
		moonTitle="배송 문의입니다.";
	} else if(moonTitle.equals("교환&취소&반품")){
		moonTitle="교환&취소&반품 문의입니다.";
	} else if(moonTitle.equals("불량")){
		moonTitle="불량 문의입니다.";
	} else if(moonTitle.equals("기타")){
		moonTitle="기타 문의입니다.";
	}
	
	int moonStatus=1;
	
	String moonContent=Utility.escapeTag(multipartRequest.getParameter("moonContent"));
	
	String moonImage=multipartRequest.getFilesystemName("moonImage");
	if(moonImage!=null) {
		moonImage="/moon_images/"+moonImage;
		
		String removeMoonImage=MoonDAO.getDAO().selectMoonByNum(moonNum).getMoonImage();
		if(removeMoonImage!=null) {
			new File(saveDirectory, removeMoonImage.substring("/moon_images/".length())).delete();
		}
	}
	
	MoonDTO moon=new MoonDTO();
	moon.setMoonNum(moonNum);
	moon.setMoonTitle(moonTitle);
	moon.setMoonContent(moonContent);
	moon.setMoonImage(moonImage);
	moon.setMoonStatus(moonStatus);
	
	MoonDAO.getDAO().updateMoon(moon);
	
	request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?group=admin&worker=admin_moon_detail"
			+"&moonNum="+moonNum+"&pageNum="+pageNum+"&pageSize="+pageSize+"&search="+search+"&keyword="+keyword);
%>
