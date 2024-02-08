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
<link href="<%=request.getContextPath()%>/css/detail.css" type="text/css" rel="stylesheet">
<div id="detail">
	<h1>1:1 문의하기</h1>
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
	<table>
		<tr>
			<th>답변</th>
			<td class="re">
			<% if(moon.getMoonRe()==null) {%>
			답변이 없습니다.			
			<%	}else { %>
			<%=moon.getMoonRe() %>
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
			<% if(moon.getMoonRe()==null) { %>
			<button type="button" id="replyBtn">답글쓰기</button>
			<% } %>
			<% if(moon.getMoonRe()!=null) { %>
			<button type="button" id="replyModifyBtn">답글수정하기</button>
			<% } %>
			<button type="button" id="replyRemoveBtn">답글삭제하기</button>
		<% } %>
	</div>
</div>
<script type="text/javascript">
$("#modifyBtn").click(function() {
	location.href="<%=request.getContextPath()%>/index.jsp?group=moon&worker=moon_modify"
		+"&moonNum=<%=moon.getMoonNum()%>&pageNum=<%=pageNum%>"
		+"&pageSize=<%=pageSize%>&search=<%=search%>&keyword=<%=keyword%>";	

});

$("#removeBtn").click(function() {
	if(confirm("게시글을 정말로 삭제 하시겠습니까?")) {
		location.href="<%=request.getContextPath()%>/index.jsp?group=moon&worker=moon_remove_action&&moonNum=<%=moon.getMoonNum()%>&pageNum=<%=pageNum%>"
			+"&pageSize=<%=pageSize%>&search=<%=search%>&keyword=<%=keyword%>";	
	}
});

$("#listBtn").click(function() {
	location.href="<%=request.getContextPath()%>/index.jsp?group=moon&worker=moon_list"
		+"&pageNum=<%=pageNum%>&pageSize=<%=pageSize%>&search=<%=search%>&keyword=<%=keyword%>";	
});

$("#replyBtn").click(function() {
	location.href="<%=request.getContextPath()%>/index.jsp?group=moon&worker=moon_re"
		+"&moonNum=<%=moon.getMoonNum()%>&pageNum=<%=pageNum%>"
		+"&pageSize=<%=pageSize%>&search=<%=search%>&keyword=<%=keyword%>";	
});

$("#replyRemoveBtn").click(function() {
	location.href="<%=request.getContextPath()%>/index.jsp?group=moon&worker=moon_reremove"
		+"&moonNum=<%=moon.getMoonNum()%>&pageNum=<%=pageNum%>"
		+"&pageSize=<%=pageSize%>&search=<%=search%>&keyword=<%=keyword%>";	
});

$("#replyModifyBtn").click(function() {
	location.href="<%=request.getContextPath()%>/index.jsp?group=moon&worker=moon_re"
		+"&moonNum=<%=moon.getMoonNum()%>&pageNum=<%=pageNum%>"
		+"&pageSize=<%=pageSize%>&search=<%=search%>&keyword=<%=keyword%>";	
});

</script>

