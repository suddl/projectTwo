<%@page import="xyz.nailro.dto.ClientDTO"%>
<%@page import="xyz.nailro.dao.MoonDAO"%>
<%@page import="xyz.nailro.dto.MoonDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	if(request.getParameter("moonNum")==null) {
		request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?group=error&worker=error_400");
		return;
	}

	int moonNum=Integer.parseInt(request.getParameter("moonNum"));
	String pageNum=request.getParameter("pageNum");
	String pageSize=request.getParameter("pageSize");
	String search=request.getParameter("search");
	String keyword=request.getParameter("keyword");
	
	MoonDTO moon=MoonDAO.getDAO().selectMoonByNum(moonNum);
	
	if(moon==null) {
		request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?group=error&worker=error_400");
		return;
	}
	
	ClientDTO loginClient =(ClientDTO)session.getAttribute("loginClient");
	
%>
<style type="text/css">
#moon_detail {
	width: 500px;
	margin: 0 auto;
}

table {
	border: 1px solid black;
	border-collapse: collapse;
}

th, td {
	border: 1px solid black;
	padding: 5px;	
}

th {
	width: 100px;
	background: black;
	color: white;
}

td {
	width: 400px;
}

.subject, .content {
	text-align: left;
}

.content {
	height: 300px;
	vertical-align: middle;
	
}

#moon_menu {
	text-align: right;
	margin: 5px;
}
</style>
<div id="moon_detail">
	<h1>1:1 문의</h1>
	<table>
		<tr>
			<th>제목</th>
			<td><%= moon.getMoonTitle() %></td>
		</tr>
		<tr>
			<th>작성일</th>
			<td><%= moon.getMoonDate() %></td>
		</tr>
		<tr>
			<th>내용</th>
			<td class="content">
				<%=moon.getMoonContent().replace("\n", "<br>") %>
				<br>
				<% if(moon.getMoonImage()!=null) { %>
					<img src="<%=request.getContextPath() %>/<%= moon.getMoonImage()%>" width="200">
				<% } %>
			</td>
		</tr>
	</table>
	
	<div id="moon_menu">
		<% if(loginClient!=null && (loginClient.getClientNum()==moon.getMoonClientNum())) { %>
			<button type="button" id="modifyBtn">글변경</button>
			<button type="button" id="removeBtn">글삭제</button>
		<% } %>
		
		<button type="button" id="listBtn">글목록</button>
		
		<% if(loginClient!=null && (loginClient.getClientStatus()==9)) { %>
			<button type="button" id="replyBtn">답글쓰기</button>
		<% } %>
	</div>
</div>
