<%@page import="java.sql.ClientInfoStatus"%>
<%@page import="xyz.nailro.dao.FaqDAO"%>
<%@page import="xyz.nailro.dto.FaqDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	
	//글번호를 전달받아 faq 테이블의 단일행을 검색하여 게시글(faqDTO 객체)을 반환하는 faqDAO의 메소드
	FaqDTO faq=FaqDAO.getDAO().selectFaqByNum(faqNum);
	
	//검색된 게시글이 없는 경우에 대한 응답 처리 - 비정상적인 요청
	if(faq==null) {
		request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?group=error&worker=error_400");
		return;
	}
%>
<style type="text/css">
#faq_detail {
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

#faq_menu {
	text-align: right;
	margin: 5px;
}
</style>

<div id="faq_detail">
	<h1>FAQ</h1>
	
	<table>
		<tr>
			<th>제목</th>
			<td class = "subject">
			<%=faq.getFaqSubject() %>
			</td>
		</tr>
		<tr>
			<th>카테고리</th>
			<td class = "category">
			<%=faq.getFaqCategory() %>
			</td>
		</tr>
			<tr>
			<th>내용</th>
			<td class = "content">
			<%=faq.getFaqContent() %>
			</td>
		</tr>
	</table>
	
	<div id="faq_menu">
		<%
		int clientStatus=9;
		
		if(clientStatus==9)	{ %>
			<button type="button" id="modifyBtn">글변경</button>
			<button type="button" id="removeBtn">글삭제</button>			
		<% }%>
	</div>
</div>

<script type="text/javascript">
$("#modifyBtn").click(function() {
	location.href="<%=request.getContextPath()%>/index.jsp?group=admin&worker=faq_modify"
		+"&faqNum=<%=faq.getFaqNum()%>&pageNum=<%=pageNum%>"
		+"&pageSize=<%=pageSize%>&keyword=<%=keyword%>";	
});

$("#removeBtn").click(function() {
	if(confirm("게시글을 정말로 삭제 하시겠습니까?")) {
		location.href="<%=request.getContextPath()%>/index.jsp?group=admin&worker=admin_remove_action"
			+"&faqNum=<%=faq.getFaqNum()%>&pageNum=<%=pageNum%>"
			+"&pageSize=<%=pageSize%>&keyword=<%=keyword%>";	
	}
});
</script>