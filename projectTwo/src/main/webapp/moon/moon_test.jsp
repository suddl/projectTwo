<%@page import="xyz.nailro.dao.MoonDAO"%>
<%@page import="xyz.nailro.dto.MoonDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	MoonDTO moon=new MoonDTO();
	for(int i=1;i<=30;i++) {
		int nextNum=MoonDAO.getDAO().selectMoonNextNum();
		moon.setMoonNum(nextNum);//글번호 변경
		moon.setMoonClientNum(5);//회원번호 변경
		moon.setMoonTitle("테스트-"+i);//제목 변경
		moon.setMoonContent("게시글 테스트 - "+i);//내용 변경
		moon.setMoonStatus(1);
	
		
		MoonDAO.getDAO().insertMoon(moon);
	}
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP</title>
</head>
<body>
	<h1>500개의 테스트 게시글을 삽입 하였습니다.</h1>
</body>
</html>