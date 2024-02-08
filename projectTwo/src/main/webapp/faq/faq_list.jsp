<%@page import="java.sql.ClientInfoStatus"%>
<%@page import="xyz.nailro.dto.ClientDTO"%>
<%@page import="xyz.nailro.dao.FaqDAO"%>
<%@page import="xyz.nailro.dto.FaqDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//게시글 검색에 필요한 검색단어를 반환받아 저장
	String keyword=request.getParameter("keyword");
	if(keyword==null)	{
		keyword="";
	}
	
	int pageNum=1;
	if(request.getParameter("pageNum")!=null)	{	//전달값 없을때 초기값 설정
		pageNum=Integer.parseInt(request.getParameter("pageNum"));
	}
	
	//페이징 처리에 필요한 전달값(페이지 번호, 게시글 갯수)울 반환받아 저장
	int pageSize=10;
	if(request.getParameter("pageSize")!=null)	{	//전달값 없을때 초기값 설정
		pageSize=Integer.parseInt(request.getParameter("pageSize"));
	}
	
	//검색 단어를 받아 FAQ 테이블에 저장된 게시글 중 검색 단어가 포함된 게시글의 개수를 반환
	int totalFaq=FaqDAO.getDAO().selectTotalFaq(keyword);
	
	//전체 페이지의 총갯수를 계산하여 저장
	int totalPage=(int)Math.ceil((double)totalFaq/pageSize);
	
	//전달받은 페이지번호가 비정상적인 경우
	if(pageNum<=0 || pageNum>totalPage)	{
		pageNum=1;
	}
	
	//페이지 번호에 대한 게시글의 시작 행번호를 계산하여 전달
	int startRow=(pageNum-1)*pageSize+1;
	
	//페이지 번호에 대한 게시글의 종료 행번호를 계산하여 전달
	int endRow=pageNum*pageSize;
	
	//마지막 페이지의 게시글 종료 행번호가 게시글의 총갯수보다 많은 경우 종료 행번호 변경
	if(endRow>totalFaq)	{
		endRow=totalFaq;
	}
	
	//페이징 처리 관련 정보(시작 행번호, 종료 행번호, 검색단어)를 전달받아 FAQ 테이블에 저장된 행을 
	//검색하여 게시글 목록을 반환하여 FaqDAO 클래스의 메소드 호출
	List<FaqDTO> faqList=FaqDAO.getDAO().selectFaqList(startRow, endRow, keyword);
	
	//session 객체에 저장된 권한 관련 속성값을 반환받아 저장
	// => 관리자 권한의 사용자에게만 글쓰기 권한 제공
	ClientDTO loginClient=(ClientDTO)session.getAttribute("loginClient");
	
	//페이지에 출력될 게시글의 일련번호 시작값을 계산하여 저장
	int displayNum=totalFaq-(pageNum-1)*pageSize;
%>
<link href="<%=request.getContextPath()%>/css/moon_list.css" type="text/css" rel="stylesheet">



<h1>FAQ</h1>
<div id="faq_list">
	<%-- 검색된 게시글 총갯수 출력 --%>
	<div id="faq_title">자주 묻는 질문(<%= totalFaq %>개)</div>

<%-- Faq 목록 출력 --%>
	<table>
	<tr>
		<th width="100">글번호</th>
		<th width="300">카테고리</th>
		<th width="700">제목</th>
		</tr>
	<% if(totalFaq==0)	{	//검색된 게시글 없는 경우 %>
	<tr>
		<td colspan="4">검색된 게시글이 없습니다.</td>
	</tr>
	<% } else {	//검색된 게시글이 있는 경우 %>
	<% for(FaqDTO faq : faqList) { %>
	<tr>
		<%-- Faq 번호 --%>
		<td><%=displayNum %></td>
		<% displayNum--; %>
		
		<%-- Faq 카테고리 --%>
		<td><%=faq.getFaqCategory() %></td>
		
		<%-- Faq 제목 --%>
		<td class="subject">
			<%
			String url=request.getContextPath()+"/index.jsp?group=faq&worker=faq_detail"
					+"&faqNum="+faq.getFaqNum()+"&pageNum="+pageNum+"&pageSize="+pageSize
					+"&keyword="+keyword;
			%>
		<a href="<%=url%>"><%=faq.getFaqSubject() %></a>
		</td>
	</tr>		
	
	<% } %>
<% } %>	
	</table>
</div>
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
			String responseUrl=request.getContextPath()+"/index.jsp?group=admin&worker=faq_list"
					+"&pageSize="+pageSize+"&keyword="+keyword;
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
	<form action="<%=request.getContextPath() %>/index.jsp?group=admin&worker=faq_list" method="post">
		<%-- select 태그를 사용하여 검색대상을 선택해 전달 - 전달값은 반드시 컬럼명으로 설정 --%>
		<input type="text" name="keyword" value="<%=keyword%>">
		<button type="submit">검색</button>
	</form>


<script type="text/javascript">

 
$("#writeBtn").click(function() {
	location.href="<%=request.getContextPath()%>/index.jsp?group=admin&worker=faq_write";
});
</script>
