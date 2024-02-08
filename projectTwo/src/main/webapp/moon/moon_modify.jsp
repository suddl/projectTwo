<%@page import="xyz.nailro.dao.MoonDAO"%>
<%@page import="xyz.nailro.dto.MoonDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="/security/login_check.jspf" %>
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
	
	if(loginClient.getClientNum()!=moon.getMoonClientNum() && loginClient.getClientStatus()!=9) {
		request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?group=error&worker=error_400");
		return;
	}
	String moonTitle=request.getParameter("moonTitle");
%>
<link href="<%=request.getContextPath()%>/css/moon_write.css" type="text/css" rel="stylesheet">
<h1>게시글변경</h1>
<form action="<%=request.getContextPath()%>/index.jsp?group=moon&worker=moon_modify_action" method="post" enctype="multipart/form-data" id="moonForm">
	<input type="hidden" name="moonNum" value="<%=moonNum %>">
	<input type="hidden" name="pageNum" value="<%=pageNum %>">
	<input type="hidden" name="pageSize" value="<%=pageSize %>">
	<input type="hidden" name="search" value="<%=search %>">
	<input type="hidden" name="keyword" value="<%=keyword %>">
	<table>
		<tr>
			<th>제목</th> 
			<td>
				<select name="moonTitle">
					<option value="상품" <% if(moon.getMoonTitle().equals("상품 문의입니다.")) { %> selected <% } %>>상품 문의입니다.</option>
					<option value="배송" <% if(moon.getMoonTitle().equals("배송 문의입니다.")) { %> selected <% } %>>배송 문의입니다.</option>
					<option value="교환&취소&반품" <% if(moon.getMoonTitle().equals("교환&취소&반품 문의입니다.")) { %> selected <% } %>>교환&취소&반품 문의입니다.</option>
					<option value="불량" <% if(moon.getMoonTitle().equals("불량 문의입니다.")) { %> selected <% } %>>불량 문의입니다.</option>
					<option value="기타" <% if(moon.getMoonTitle().equals("기타 문의입니다.")) { %> selected <% } %>>기타 문의입니다.</option>
				</select>
				<% System.out.println("moon.getMoonTitle() =" + moon.getMoonTitle()); %>
			</td>
		</tr>
		<tr>
			<th>내용</th>
			<td>
				<textarea rows="7" cols="60" name="moonContent" id="moonContent"><%=moon.getMoonContent() %></textarea>
			</td>
		</tr>	
		<tr>
			<th>이미지파일</th>
			<td>
				<input type="file" name="moonImage"><br><br>
				<% if(moon.getMoonImage()!=null) { %>
					<div style="color: red;">이미지를 변경할 경우에만 파일을 입력해 주세요.</div>
					<img src="<%=request.getContextPath()%>/<%=moon.getMoonImage()%>" width="200">
				<% } %>
			</td>
		</tr>
		<tr>
			<th colspan="2">
				<button type="submit">글변경</button>
				<button type="reset" id="resetBtn">다시쓰기</button>
			</th>
		</tr>
	</table>
</form>
<div id="message" style="color: red;"></div>

<script type="text/javascript">
$("#moonContent").focus();

$("#moonForm").submit(function() {
	
	if($("#moonContent").val()=="") {
		$("#message").text("내용을 입력해 주세요.");
		$("#moonContent").focus();
		return false;
	}
});

$("#resetBtn").click(function() {
	$("#moonContent").focus();
	$("#message").text("");
});
</script>