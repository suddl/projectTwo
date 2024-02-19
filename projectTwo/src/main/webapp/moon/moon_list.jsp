<%@page import="xyz.nailro.dao.ClientDAO"%>
<%@page import="xyz.nailro.dto.ClientDTO"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="xyz.nailro.dto.MoonDTO"%>
<%@page import="java.util.List"%>
<%@page import="xyz.nailro.dao.MoonDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%@include file="/security/login_url.jspf"%>
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
	
	
	int loginClientNum = loginClient.getClientNum();
	
	int totalMoon=0;
	
	if(loginClient.getClientStatus()==9) {
		totalMoon=MoonDAO.getDAO().selectTotalAllMoon(search, keyword);
	} else {
		totalMoon=MoonDAO.getDAO().selectTotalMoon(search, keyword, loginClientNum);
	}
	
	int totalPage=(int)Math.ceil((double)totalMoon/pageSize);
	
	if(pageNum<=0 || pageNum>totalPage) {
		pageNum=1;
	}
	
	int startRow=(pageNum-1)*pageSize+1;
	
	int endRow=pageNum*pageSize;
	
	if(endRow>totalMoon) {
		endRow=totalMoon;
	}
	
	List<MoonDTO> moonList=null;
	
	if(loginClient.getClientStatus()==9) {
		moonList=MoonDAO.getDAO().selectAllMoonList(startRow, endRow, search, keyword);
	} else {
		moonList=MoonDAO.getDAO().selectMoonList(startRow, endRow, search, keyword,loginClientNum);
	}
	

	//MoonDTO clientList=(MoonDTO)session.getAttribute("loginclientId");
	
	String currentDate=new SimpleDateFormat("yyyy-MM-dd").format(new Date());
	
	int displayNum=totalMoon-(pageNum-1)*pageSize;
%>
<link href="<%=request.getContextPath()%>/css/list.css" type="text/css" rel="stylesheet">
<a href="<%=request.getContextPath()%>/index.jsp?group=moon&worker=moon_list"><h1>1:1 문의하기</h1></a>
<div id="moon_list">
	<div id="moon_title">문의 목록(<%= totalMoon %>개)</div>
	
	<div id="writeBtn">
		<% if(loginClient!=null && loginClient.getClientStatus()==1) { %>
			<button type="button" id="writeBtn">글쓰기</button> 
		<% } %>
	</div>
	<table class="moon_list">
		<tr>
			<th width="100">글번호</th>
			<th width="500">제목</th>
			<th width="100">작성자</th>
			<th width="200">작성일</th>
			<th width="100">답변여부</th>
		</tr>
		
		<% if(totalMoon==0) { %>
		<tr>
			<td colspan="5">검색된 게시글이 없습니다.</td>
		</tr>
		<% } else { %>
			<% for(MoonDTO moon : moonList) { %>
			<tr>
				<td><%=displayNum %></td>
				<% displayNum--; %>
				
				<td class="subject">
					<%
						String url=request.getContextPath()+"/index.jsp?group=moon&worker=moon_detail&moonNum="+moon.getMoonNum()
						+"&pageNum="+pageNum+"&pageSize="+pageSize +"&search="+search+"&keyword="+keyword;
					%>
					<% if(moon.getMoonStatus()==1){ %>
					<a href="<%=url %>"><%= moon.getMoonTitle() %></a>
					<% } else if(moon.getMoonStatus()==0){ %>
						<span class="subject_hidden">삭제글</span>
						게시글 작성자 또는 관리자에 의해 삭제된 게시글입니다.
					<% } %>
				</td>
				<td><%= moon.getMoonName() %></td>
				<td>
					<% if(currentDate.equals(moon.getMoonDate().substring(0, 10))) { %>
							<%=moon.getMoonDate().substring(11) %>
					<% } else { %>
							<%=moon.getMoonDate() %>
					<% } %>
				</td>
				<td>
				<% if(moon.getMoonRe()==null) { %>
					미답변
				<% } else {%>
					답변완료
				<% } %>
				</td>
			</tr>
			<% } %>
		<% } %>
	</table>
	
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
			String responseUrl=request.getContextPath()+"/index.jsp?group=moon&worker=moon_list"
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
	<form action="<%=request.getContextPath() %>/index.jsp?group=moon&worker=moon_list" method="post">
		<select name="search">
			<option value="moon_title" <% if(search.equals("moon_title")) { %>  selected <% } %>>&nbsp;제목&nbsp;</option>
			<option value="moon_content" <% if(search.equals("moon_content")) { %>  selected <% } %>>&nbsp;내용&nbsp;</option>
		</select>
		<input type="text" name="keyword" value="<%=keyword%>">
		<button type="submit">검색</button>
	</form>
</div>

<script type="text/javascript">
$("#writeBtn").click(function() {
	location.href="<%=request.getContextPath()%>/index.jsp?group=moon&worker=moon_write";	
});
</script>