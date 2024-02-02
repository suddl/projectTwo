<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="xyz.nailro.dao.ReviewDAO"%>
<%@ page import="xyz.nailro.dto.ReviewDTO"%>
<%@include file="/security/login_check.jspf"%>

<%
	//글번호가 전달되지 않은 경우에 대한 응답 처리 - 비정상적인 요청
	if(request.getParameter("reviewNum")==null) {
		request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?group=error&worker=error_400");
		return;
	}

	//전달값을 반환받아 저장
	int reviewNum=Integer.parseInt(request.getParameter("reviewNum"));
	String pageNum=request.getParameter("pageNum");
	String pageSize=request.getParameter("pageSize");
	String search=request.getParameter("search");
	String keyword=request.getParameter("keyword");
	
	//글번호를 전달받아 REVIEW 테이블의 단일행을 검색하여 게시글(ReviewDTO 객체)을 반환하는 
	//ReviewDAO 클래스의 메소드 호출
	ReviewDTO review=ReviewDAO.getDAO().selectReviewByNum(reviewNum);
	
	//검색된 게시글이 없는 경우에 대한 응답 처리 - 비정상적인 요청
	if(review==null) {
		request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?group=error&worker=error_400");
		return;
	}
	

	//글번호를 전달받아 REVIEW 테이블의 저장된 행의 게시글 조회수가 1 증가되도록 변경하고 
	//변경행의 갯수를 반환하는 ReviewDAO 클래스의 메소드 호출
	ReviewDAO.getDAO().updateReviewReadCount(reviewNum);
%>
<style type="text/css">
#review_detail {
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

#review_menu {
	text-align: right;
	margin: 5px;
}
</style>

<div id="review_detail">
	<h1>REVIEW</h1>
	
	<%-- 검색된 게시글 출력 --%>
	<table>
		<tr>
			<th>작성자</th>
			<td>
				<%=review.getReviewName() %>
			</td>
		</tr>
		<tr>
			<th>작성일</th>
			<td><%=review.getReviewDate() %></td> 
		</tr>  
	
		<tr>
			<th>제목</th>
			<td class="subject">
				<%=review.getReviewSubject() %>
			</td>
		</tr>
		<tr>
			<th>내용</th>
			<td class="content">
				<%=review.getReviewContent().replace("\n", "<br>")%>
				<br>
				<% if(review.getReviewImage()!=null) { %>
					<img src="<%=request.getContextPath()%>/<%=review.getReviewImage()%>" width="200">
				<% } %>
			</td>
		</tr>
	</table>
	
	<%-- 태그를 출력하여 링크 제공 --%>
	<div id="review_menu">
		<%-- 로그인 상태의 사용자 중 게시글 작성자이거나 관리자인 경우에만 태그를 출력하여 링크 제공 --%>
		<% if(loginClient!=null && (loginClient.getClientNum()==review.getReviewClientNum()
			|| loginClient.getClientStatus()==9)) { %>
			<button type="button" id="modifyBtn">글변경</button>
			<button type="button" id="removeBtn">글삭제</button>
		<% } %>
		
		<%-- 로그인 상태의 사용자인 경우에만 태그를 출력하여 링크 제공 --%>
		<% if(loginClient!=null) { %>
			<button type="button" id="replyBtn">답글쓰기</button>
		<% } %>
		
		<button type="button" id="listBtn">글목록</button>
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
		location.href="<%=request.getContextPath()%>/index.jsp?group=review&worker=review_remove_action"
			+"&reviewNum=<%=review.getReviewNum()%>&pageNum=<%=pageNum%>"
			+"&pageSize=<%=pageSize%>&search=<%=search%>&keyword=<%=keyword%>";	
	}
});


$("#listBtn").click(function() {
	location.href="<%=request.getContextPath()%>/index.jsp?group=review&worker=review_list"
		+"&pageNum=<%=pageNum%>&pageSize=<%=pageSize%>&search=<%=search%>&keyword=<%=keyword%>";	
});
</script>


<%--  혹시 몰라서 아직 안지워둠 
    int reviewId = Integer.parseInt(request.getParameter("reviewId"));
    ReviewDAO dao = ReviewDAO.getDAO();
    ReviewDTO review = dao.selectReviewByNum(reviewId);
%>

<html>
<head>
    <title>리뷰 상세보기</title>
    <!-- 여기에 필요한 CSS와 JS 파일을 포함시킬 수 있습니다 -->
</head>
<body>
    <h1>리뷰 상세보기</h1>
    <% if (review != null) { %>
        <div>
            <h2><%= review.getReviewSubject() %></h2>
            <p><%= review.getReviewContent() %></p>
            <% if (review.getReviewImage() != null && !review.getReviewImage().isEmpty()) { %>
                <img src="<%= review.getReviewImage() %>" alt="리뷰 이미지" style="max-width: 400px;">
            <% } %>
            <div>
                <a href="review_modify.jsp?reviewId=<%= review.getReviewNum() %>">수정하기</a>
                <a href="review_remove_action.jsp?reviewId=<%= review.getReviewNum() %>" onclick="return confirm('정말 삭제하시겠습니까?');">삭제하기</a>
            </div>
        </div>
    <% } else { %>
        <p>리뷰를 찾을 수 없습니다.</p>
    <% } %>
</body>
</html>
--%>
