<%@page import="xyz.nailro.dao.ClientDAO"%>
<%@page import="xyz.nailro.dto.ClientDTO"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="xyz.nailro.dto.MoonDTO"%>
<%@page import="java.util.List"%>
<%@page import="xyz.nailro.dao.MoonDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% 
	String search=request.getParameter("search");
	if(search==null) {
		search="";
	}
	
	String keyword=request.getParameter("keyword");
	if(keyword==null) {
		keyword="";
	}
	
	// 페이지 번호
	int pageNum=1;
	if(request.getParameter("pageNum")!=null) {
		pageNum=Integer.parseInt(request.getParameter("pageNum"));
	}
	
	// 게시글 갯수
	int pageSize=10;
	if(request.getParameter("pageSize")!=null) {
		pageSize=Integer.parseInt(request.getParameter("pageSize"));
	}
	
	/*
	ClientDTO loginClient=(ClientDTO)session.getAttribute("loginClient");
	
	String id = loginClient.getClientId();
	//session.setAttribute("clientId", id);
	//String loginclientId= (String)session.getAttribute("clientId");
	//System.out.println("loginclientId : " +  loginclientId );
	
	//System.out.println("id : " + id);
	*/
	ClientDTO loginClient=(ClientDTO)session.getAttribute("loginClient");
	
	int loginClientNum = loginClient.getClientNum();
	//System.out.println("id : " + loginClientNum);
	
	
	int totalMoon=MoonDAO.getDAO().selectTotalMoon(search, keyword, loginClientNum);
	
	int totalPage=(int)Math.ceil((double)totalMoon/pageSize);
	
	if(pageNum<=0 || pageNum>totalPage) {
		pageNum=1;
	}
	
	int startRow=(pageNum-1)*pageSize+1;
	
	int endRow=pageNum*pageSize;
	
	if(endRow>totalMoon) {
		endRow=totalMoon;
	}
	
	List<MoonDTO> moonList=MoonDAO.getDAO().selectMoonList(startRow, endRow, search, keyword,loginClientNum);
	

	MoonDTO clientList=(MoonDTO)session.getAttribute("loginclientId");
	
	String currentDate=new SimpleDateFormat("yyyy-MM-dd").format(new Date());
	
	int displayNum=totalMoon-(pageNum-1)*pageSize;
%>
<style type="text/css">
#moon_list {
	width: 1000px;
	margin: 0 auto;
	text-align: center;
}

#moon_title {
	font-size: 1.2em;
	font-weight: bold;
}

table {
	margin: 5px auto;
	border: 1px solid black;
	border-collapse: collapse;
}

th {
	border: 1px solid black;
	background: black;
	color: white;
}

td {
	border: 1px solid black;
	text-align: center;	
}

.subject {
	text-align: left;
	padding: 5px;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}

#moon_list a:hover {
	text-decoration: none; 
	color: blue;
	font-weight: bold;
}

.subject_hidden {
	background: black;
	color: white;
	font-size: 14px;
	border: 1px solid black;
	border-radius: 4px;
}

#page_list {
	font-size: 1.1em;
	margin: 10px;
}

#page_list a:hover {
	font-size: 1.3em;
}
</style>
<h1>1:1 문의 게시판</h1>
<div id="moon_list">
	<div id="moon_title">문의 목록<%= totalMoon %></div>
</div>