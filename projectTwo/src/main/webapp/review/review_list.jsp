<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="xyz.nailro.dto.ClientDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="xyz.nailro.dao.ReviewDAO"%>
<%@ page import="xyz.nailro.dto.ReviewDTO"%>


<%
//게시글 검색 기능에 필요한 전달값(검색대상과 검색단어)을 반환받아 저장
String search=request.getParameter("search");//검색대상
if(search==null) {//전달값이 없는 경우 - 게시글 검색 기능을 사용하지 않은 경우
	search="";
}

String keyword=request.getParameter("keyword");//검색단어
if(keyword==null) {//전달값이 없는 경우
	keyword="";
}

//페이징 처리에 필요한 전달값(페이지번호과 게시글갯수)을 반환받아 저장
int pageNum=1;//페이지번호- 전달값이 없는 경우 저장된 초기값 설정
if(request.getParameter("pageNum")!=null) {//전달값이 있는 경우
	pageNum=Integer.parseInt(request.getParameter("pageNum"));
}

int pageSize=10;//게시글갯수- 전달값이 없는 경우 저장된 초기값 설정
if(request.getParameter("pageSize")!=null) {//전달값이 있는 경우
	pageSize=Integer.parseInt(request.getParameter("pageSize"));
}

//검색정보(검색대상과 검색단어)를 전달받아 REVIEW 테이블에 저장된 게시글 중 검색대상의 컬럼에
//검색단어가 포함된 게시글의 갯수를 검색하여 반환하는 ReviewDAO 클래스의 메서드 호출
// => 검색 기능을 사용하지 않을 경우 REVIEW 테이블에 저장된 모든 게시글의 갯수를 반환
int totalReview=ReviewDAO.getDAO().selectTotalReview(search, keyword);//검색된 게시글의 총갯수

//전체 페이지의 총갯수를 계산하여 저장
//int totalPage=totalReview/pageSize+totalReview%pageSize==0?0:1;
int totalPage=(int)Math.ceil((double)totalReview/pageSize);//페이지의 총갯수

//전달받은 페이지번호가 비정상적인 경우
if(pageNum<=0 || pageNum>totalPage) {
	pageNum=1;
}

//페이지번호에 대한 게시글의 시작 행번호를 계산하여 저장
//ex) 1Page : 1, 2Page : 11, 3Page : 21, 4Page : 31, ...
int startRow=(pageNum-1)*pageSize+1;

//페이지번호에 대한 게시글의 종료 행번호를 계산하여 저장
//ex) 1Page : 10, 2Page : 20, 3Page : 30, 4Page : 40, ...
int endRow=pageNum*pageSize;

//마지막 페이지의 게시글의 종료 행번호가 게시글의 총갯수보다 많은 경우 종료 행번호 변경
if(endRow>totalReview) {
	endRow=totalReview;
}

//페이징 처리 관련 정보(시작 행번호와 종료 행번호)와 게시글 검색 기능 관련 정보(검색대상과
//검색단어)를 전달받아 REVIEW 테이블에 저장된 행을 검색하여 게시글 목록을 반환하는 ReviewDAO 
//클래스의 메소드 호출
List<ReviewDTO> reviewList=ReviewDAO.getDAO().selectReviewList(startRow, endRow, search, keyword);

//session 객체에 저장된 권한 관련 속성값을 반환받아 저장
// => 로그인 상태의 사용자에게만 글쓰기 권한 제공
// => 게시글이 비밀글인 경우 로그인 상태의 사용자가 게시글 작성자이거나 관리자인 경우에만 권한 제공
ClientDTO loginMember=(ClientDTO)session.getAttribute("loginMember");

//서버 시스템의 현재 날짜를 제공받아 저장
// => 게시글 작성날짜와 비교하여 게시글 작성날짜를 다르게 출력되도록 응답 처리
String currentDate=new SimpleDateFormat("yyyy-MM-dd").format(new Date());

//페이지에 출력될 게시글의 일련번호 시작값을 계산하여 저장
// => 검색된 게시글의 총갯수가 91개인 경우 >> 1Page : 91, 2Page : 81, 3Page, 71
int displayNum=totalReview-(pageNum-1)*pageSize;
%>

<html>
<head>
<title>리뷰 목록</title>
<style type="text/css">
#review_list {
	width: 1000px;
	margin: 0 auto;
	text-align: center;
}

#review_title {
	font-size:2em;
	font-weight: bold;
	color: pink;
}

table {
	margin: 5px auto;
	border: 1px solid black;
	border-collapse: collapse;
}

th {
	border: 1px solid black;
	background-color: pink ;
	color: blakc;
	text-align: center;
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

#review_list a:hover {
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
</head>
<body>
<form  action="<%=request.getContextPath() %>/index.jsp?group=review&worker=review_wirter_action" 
	method="post" id="reviewForm" name="review">
	<%-- <input type="hidden" name="url" value="<%=url %>"> --%>
<div id="review_list">
	<%-- 검색된 게시글 총갯수 출력 --%>
	<div id="review_title">REVIEW(<%=totalReview %>)</div>
	
	<div style="text-align: right;">
		게시글갯수 : 
		<select id="reviewCount">
			<option value="10" <% if(pageSize==10) { %> selected <% } %>>&nbsp;10개&nbsp;</option>	
			<option value="20" <% if(pageSize==20) { %> selected <% } %>>&nbsp;20개&nbsp;</option>	
			<option value="50" <% if(pageSize==50) { %> selected <% } %>>&nbsp;50개&nbsp;</option>	
			<option value="100" <% if(pageSize==100) { %> selected <% } %>>&nbsp;100개&nbsp;</option>	
		</select>
		&nbsp;&nbsp;&nbsp;
	
	<%-- 게시글 목록 출력 --%>
	<table>
		<tr>
			<th width="100">글번호</th>
			<th width="500">제목</th>
			<th width="100">작성자</th>
			<th width="200">작성일</th>
		</tr>
		
		<% if(totalReview==0) {//검색된 게시글이 없는 경우 %>
			<tr>
				<td colspan="5">검색된 게시글이 없습니다.</td>
			</tr>
		<% } else {//검색된 게시글이 있는 경우 %>
			<%-- List 객체의 요소(ReviewDTO 객체)를 차례대로 제공받아 저장하여 처리하기 위한 반복문 --%>
			<% for(ReviewDTO review : reviewList) { %>
			<tr>
				<%-- 게시글의 글번호가 아닌 게시글의 일련번호 출력 --%>
				<td><%=displayNum %></td>
				<% displayNum--; %><%-- 게시글 일련번호를 1씩 감소하여 저장 --%>
				
				<%-- 제목 출력 --%>
				<td class="subject">
					
					<%-- 게시글 상태를 비교하여 제목과 링크를 구분해 응답 처리 --%>
					<%
						String url=request.getContextPath()+"/index.jsp?group=review&worker=review_detail"
							+"&reviewNum="+review.getReviewNum()+"&pageNum="+pageNum+"&pageSize="+pageSize
							+"&search="+search+"&keyword="+keyword;
					%>
								
					<%-- 작성자(회원이름) 출력 --%>
					<td><%=review.getReviewName() %></td>
								
					<%-- 조회수 출력 --%>
					<td><%=review.getReviewRating() %></td>
								
					<%-- 작성일 출력 : 오늘 작성된 게시글인 경우 시간만 출력하고 오늘 작성된
					게시글이 아닌 경우 날짜와 시간 출력 --%>	
					<td>
						<%-- 오늘 작성된 게시글인 경우 --%>
						<% if(currentDate.equals(review.getReviewDate().substring(0, 10))) { %>
							<%=review.getReviewDate().substring(11) %>
						<% } else { %>
							<%=review.getReviewDate() %>
						<% } %>
					</td>		
				
			
			</tr>
				
			<% } %>
		<% } %>
	</table>
	</div>
	</form>
	
	<%-- 페이지번호 출력 및 링크 제공 - 블럭화 처리 --%>
	<%
		//하나의 페이지블럭에 출력될 페이지번호의 갯수 설정
		int blockSize=5;
	
		//페이지블럭에 출력될 시작 페이지번호를 계산하여 저장
		//ex)1Block : 1, 2Block : 6, 3Block : 11, 4Block : 16,...
		int startPage=(pageNum-1)/blockSize*blockSize+1;
		        
		//페이지블럭에 출력될 종료 페이지번호를 계산하여 저장
		//ex)1Block : 5, 2Block : 10, 3Block : 15, 4Block : 20,...
		int endPage=startPage+blockSize-1;
		
		//종료 페이지번호가 페이지 총갯수보다 큰 경우 종료 페이지번호 변경 
		if(endPage>totalPage) {
			endPage=totalPage;
		}
		
	%>
	
	<div id="page_list">
		<%
			String responseUrl=request.getContextPath()+"/index.jsp?group=review&worker=review_list"
					+"&pageSize="+pageSize+"&search="+search+"&keyword="+keyword;
		%>
	
		<%-- 이전 페이지블럭이 있는 경우에만 링크 제공 --%>
		<% if(startPage>blockSize) { %>
			<a href="<%=responseUrl%>&pageNum=<%=startPage-blockSize%>">[이전]</a>
		<% } else { %>	
			[이전]
		<% } %>
		
		<% for(int i=startPage;i<=endPage;i++) { %>
			<%-- 요청 페이지번호와 출력된 페이지번호가 같지 않은 경우에만 링크 제공 --%>
			<% if(pageNum != i) { %>
				<a href="<%=responseUrl%>&pageNum=<%=i%>">[<%=i %>]</a>
			<% } else { %>
				[<%=i %>]
			<% } %>
		<% } %>
		
		<%-- 다음 페이지블럭이 있는 경우에만 링크 제공 --%>
		<% if(endPage!=totalPage) { %>
			<a href="<%=responseUrl%>&pageNum=<%=startPage+blockSize%>">[다음]</a>
		<% } else { %>	
			[다음]
		<% } %>
	</div>
	
	<%-- 사용자로부터 검색 관련 정보를 입력받기 위한 태그 출력 --%>
	<form action="<%=request.getContextPath() %>/index.jsp?group=review&worker=review_list" method="post">
		<%-- select 태그를 사용하여 검색대상을 선택해 전달 - 전달값은 반드시 컬럼명으로 설정 --%>
		<select name="search">
			<option value="name" <% if(search.equals("name")) { %>  selected <% } %>>&nbsp;작성자&nbsp;</option>
			<option value="review_subject" <% if(search.equals("review_subject")) { %>  selected <% } %>>&nbsp;제목&nbsp;</option>
			<option value="review_content" <% if(search.equals("review_content")) { %>  selected <% } %>>&nbsp;내용&nbsp;</option>
		</select>
		<input type="text" name="keyword" value="<%=keyword%>">
		<button type="submit">검색</button>
	</form>
</div>

<script type="text/javascript">
$("#reviewCount").change(function() {
	//alert($("#reviewCount").val());
	location.href="<%=request.getContextPath()%>/index.jsp?group=review&worker=review_list"
		+"&pageNum=<%=pageNum%>&pageSize="+$("#reviewCount").val()
		+"&search=<%=search%>&keyword=<%=keyword%>";
});


</script>




<%-- 
    <h1>리뷰 목록</h1>
    <div>
        <% if(reviews != null && !reviews.isEmpty()) { %>
            <% for(ReviewDTO review : reviews) { %>
                <div>
                    <h2><%= review.getReviewSubject() %></h2>
                    <p><%= review.getReviewContent() %></p>
                    <% if (review.getReviewImage() != null && !review.getReviewImage().isEmpty()) { %>
                        <img src="<%= review.getReviewImage() %>" alt="리뷰 이미지" style="max-width: 200px;">
                    <% } %>
                    <a href="review_detail.jsp?reviewId=<%= review.getReviewNum() %>">상세보기</a>
                </div>
            <% } %>
        <% } else { %>
            <p>리뷰가 없습니다.</p>
        <% } %>
    </div>
</body>
--%>
</html>
