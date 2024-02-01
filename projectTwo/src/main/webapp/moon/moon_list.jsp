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
	

	//MoonDTO clientList=(MoonDTO)session.getAttribute("loginclientId");
	
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
	
	<div style="text-align: right;">
		<% if(loginClient!=null) { %>
			<button type="button" id="writeBtn">글쓰기</button>
		<% } %>
	</div>
	<table>
		<tr>
			<th>글번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>작성여부</th>
		</tr>
		
		<% if(totalMoon==0) { %>
		<tr>
			<td colspan="5">검색된 게시글이 없습니다.</td>
		</tr>
		<% } else { %>
			<% System.out.println("moonList.size()= " + moonList.size()); %>
			<% for(MoonDTO moon : moonList) { %>
			<tr>
				<td><%=displayNum %></td>
				<% displayNum--; %>
				
				<td class="subject">
					<%
						String url=request.getContextPath()+"/index.jsp?group=moon&work=moon_detail&moonNum="+moon.getMoonNum()
						+"&pageNum="+pageNum+"&pageSize="+pageSize +"&search="+search+"&keyword="+keyword;
					%>
					<a href="<%=url %>"><%= moon.getMoonTitle() %></a>
				</td>
				<td><%= moon.getMoonName() %></td>
				
				<td>
				<% if(moon.getMoonRe()==null) { %>
					미답변
				<% } else {%>
					답변완료
				<% } %>
				</td>
				<td>
					<% if(currentDate.equals(moon.getMoonDate().substring(0, 10))) { %>
							<%=moon.getMoonDate().substring(11) %>
					<% } else { %>
							<%=moon.getMoonDate() %>
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
	
</div>