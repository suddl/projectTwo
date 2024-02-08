<%@page import="xyz.nailro.dao.FaqDAO"%>
<%@page import="xyz.nailro.dto.FaqDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/security/admin_check.jspf" %>    
<%
	//글번호가 전달되지 않은 경우에 대한 응답 처리 - 비정상적인 요청
	if(request.getParameter("faqNum")==null)	{
		request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?group=error&worker=error_400");
		return;	
	}
	
	//전달값을 반환받아 저장
	int faqNum=Integer.parseInt(request.getParameter("faqNum"));
	String pageNum=request.getParameter("pageNum");
	String pageSize=request.getParameter("pageSize");
	String faqCategory=request.getParameter("faqCategory");
	String keyword=request.getParameter("keyword");
	
	//글번호를 전달받아 faq 테이블의 단일행 검색, 게시글(faqDTO 객체)을 반환하는 faqDAO 메소드 호출
	FaqDTO faq=FaqDAO.getDAO().selectFaqByNum(faqNum);
	
	//검색된 게시글이 없는 경우에 대한 응답 처리 - 비정상적인 요청
	if(faq==null)	{
		request.setAttribute("retrunUrl", request.getContextPath()+"/index.jsp?group=error&worker=error_400");
		return;
	}
	
	//로그인 상태자가 관리자가 아닌 경우에 대한 응답처리 - 비정상
	if(loginClient.getClientStatus()!=9)	{
		request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?group=error&worker=error_400");
		return;
	}
%>

<link href="<%=request.getContextPath()%>/css/write.css" type="text/css" rel="stylesheet">
<h1>FAQ 작성</h1>

<form action="<%=request.getContextPath()%>/index.jsp?group=admin&worker=faq_modify_action" method="post" id="faqForm">
	<input type="hidden" name="faqNum" value="<%=faqNum %>">
	<input type="hidden" name="pageNum" value="<%=pageNum %>">
	<input type="hidden" name="pageSize" value="<%=pageSize %>">
	<input type="hidden" name="pageSize" value="<%=faqCategory %>">
	<input type="hidden" name="keyword" value="<%=keyword %>">
	<table>
		<tr>
			<th>제목</th>
			<td>
				<input type="text" name="faqSubject" id="faqSubject" size="40"
					value="<%=faq.getFaqSubject()%>">
			</td>					
		</tr>
		<tr> 
			<th>카테고리</th> 
			<td>
				<select name="faqCategory">
					<option value="배송"<% if(faq.getFaqCategory().equals("배송관련")) {%>selected<%}%>>배송관련</option>
					<option value="제품"<% if(faq.getFaqCategory().equals("제품관련")) {%>selected<%}%>>제품관련</option>				
					<option value="회원"<% if(faq.getFaqCategory().equals("회원관련")) {%>selected<%}%>>회원관련</option>				
					<option value="주문"<% if(faq.getFaqCategory().equals("주문/결제")) {%>selected<%}%>>주문/결제</option>				
					<option value="교환"<% if(faq.getFaqCategory().equals("교환/반품")) {%>selected<%}%>>교환/반품</option>				
					<option value="기타"<% if(faq.getFaqCategory().equals("기타")) {%>selected<%}%>>기타</option>				
				</select>
			</td>
		</tr>	
		<tr>
			<th>내용</th>
			<td>
				<textarea rows="7" cols="60" name="faqContent" id="faqContent"><%=faq.getFaqContent()%></textarea>
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
$("#faqSubject").focus();

$("#faqForm").submit(function() {
	if($("#faqSubject").val()=="") {
		$("#message").text("제목을 입력해 주세요.");
		$("#faqSubject").focus();
		return false;
	}
	
	if($("#faqContent").val()=="") {
		$("#message").text("내용을 입력해 주세요.");
		$("#faqContent").focus();
		return false;
	}
});

$("#resetBtn").click(function() {
	$("#faqSubject").focus();
	$("#message").text("");
});
</script>
	