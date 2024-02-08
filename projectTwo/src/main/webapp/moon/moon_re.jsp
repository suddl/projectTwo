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
<link href="<%=request.getContextPath()%>/css/moon_detail.css" type="text/css" rel="stylesheet">
<div id="moon_re">
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
	<hr>
	<form action="<%=request.getContextPath() %>/index.jsp?group=moon&worker=moon_re_action" method="post" id="moonReForm">
	<input type="hidden" name="moonNum" value="<%=moonNum %>">
	<input type="hidden" name="pageNum" value="<%=pageNum %>">
	<input type="hidden" name="pageSize" value="<%=pageSize %>">
	<input type="hidden" name="search" value="<%=search %>">
	<input type="hidden" name="keyword" value="<%=keyword %>">
	<table>
		<tr>
			<th>답변</th>
			<td class="moonRe">
				<% if(moon.getMoonRe()==null) { %>
				<textarea rows="7" cols="60" name="moonRe" id="moonRe"></textarea>				
				<% } else{ %>
				<textarea rows="7" cols="60" name="moonRe" id="moonRe"><%= moon.getMoonRe() %></textarea>
				<% } %>
			</td>
		</tr>
		<tr>
			<th  id="button" colspan="2">
				<button type="submit">글저장</button>
				<button type="reset" id="resetBtn">다시쓰기</button>
			</th>
		</tr>
	</table>
	</form>
</div>

<div id="message" style="color: red;"></div>
<script type="text/javascript">
if($("#moonRe").val()=="") {
	document.getElementById("moonRe").value='';
}
$("#moonRe").focus();

$("#moonReForm").submit(function() {
	if($("#moonRe").val()=="") {
		$("#message").text("내용을 입력해 주세요.");
		$("#moonRe").focus();
		return false;
	}
});

$("#resetBtn").click(function() {
	$("#moonRe").text("");
	$("#moonRe").focus();
	$("#message").text("");
});
</script>