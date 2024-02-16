<%@page import="xyz.nailro.dao.ReviewDAO"%>
<%@page import="xyz.nailro.dto.ReviewDTO"%>
<%@page import="xyz.nailro.dto.ClientDTO"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	if(request.getParameter("reviewNum")==null) {
		request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?group=error&worker=error_400");
		return;
	}
	 
	int reviewNum=Integer.parseInt(request.getParameter("reviewNum"));
	String pageNum=request.getParameter("pageNum");
	String pageSize=request.getParameter("pageSize");
	String search=request.getParameter("search");
	String keyword=request.getParameter("keyword");
	
	ReviewDTO review=ReviewDAO.getDAO().selectReviewByNum(reviewNum);
	
	if(review==null) {
		request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?group=error&worker=error_400");
		return;
	}
	
	ClientDTO loginClient =(ClientDTO)session.getAttribute("loginClient");
	
%>
<style type="text/css">
#review_detail {
	width: 800px;
	margin: 0 auto;
}

table {
	border-collapse: collapse;
}

th, td {
	border: 1px solid lightgray;
	padding: 5px;
}

th {
	width: 150px;
	background: #FFDCE1;
	color: black;
	font-size: 18px;
}

td {
	width: 650px;
}

.subject, .content {
	text-align: left;
}

.content {
	height: 300px;
	vertical-align: middle;
	padding-left: 15px;
	
}


#review_title {
	font-size:2em;
	font-weight: bold;
	color: pink;
}
</style>
<div id="review_detail">
	<h1>REVIEW</h1>
	<table>
		<tr>
			<th>제목</th>
			<td><%= review.getReviewSubject() %></td>
		</tr>
		<tr>
			<th>작성일</th>
			<td><%= review.getReviewDate() %></td>
		</tr>
		<tr>
			<th>별점</th>
			<td><%= review.getReviewRating()%></td>
		</tr>
		<tr>
			<th>내용</th>
			<td class="content">
				<%=review.getReviewContent().replace("\n", "<br>") %>
				<br>
				<% if(review.getReviewImage()!=null) { %>
					<img src="<%=request.getContextPath() %>/<%=review.getReviewImage()%>" width="200">
				<% } %>
			</td>
		</tr>
	</table>
	
	<div id="review_menu">
		<% if(loginClient!=null && (loginClient.getClientNum()==review.getReviewClientNum())) { %>
			<button type="button" id="modifyBtn">리뷰변경</button>
			<button type="button" id="removeBtn">리뷰삭제</button>
			<button type="button" id="listBtn">리뷰목록</button>  
		<% } %>
			
				
		<button type="button" id="backBtn" onclick="history.back()">뒤로가기</button>
		
		<% if(loginClient!=null && (loginClient.getClientStatus()==9)) { %>
			<button type="button" id="replyBtn">답글쓰기</button>
		<% } %>
	</div>
</div>
<script type="text/javascript">
$("#modifyBtn").click(function() {
	location.href="<%=request.getContextPath()%>/index.jsp?group=review&worker=review_modify"
		+"&reviewNum=<%=review.getReviewNum()%>&pageNum=<%=pageNum%>"
		+"&pageSize=<%=pageSize%>&search=<%=search%>&keyword=<%=keyword%>";	

});

$("#removeBtn").click(function() {
	if(confirm("게시글을 정말로 삭제 하시겠습니까?")) {
		location.href="<%=request.getContextPath()%>/index.jsp?group=review&worker=review_remove_action&&reviewNum=<%=review.getReviewNum()%>&pageNum=<%=pageNum%>"
			+"&pageSize=<%=pageSize%>&search=<%=search%>&keyword=<%=keyword%>";	
	}
});

$("#listBtn").click(function() {
	location.href="<%=request.getContextPath()%>/index.jsp?group=review&worker=review_list"
		+"&pageNum=<%=pageNum%>&pageSize=<%=pageSize%>&search=<%=search%>&keyword=<%=keyword%>";	
});

$("#mainBtn").click(function() {
	location.href="<%=request.getContextPath()%>/index.jsp?group=product&worker=nail"
		+"&pageNum=<%=pageNum%>&pageSize=<%=pageSize%>&search=<%=search%>&keyword=<%=keyword%>";	
});


</script>

