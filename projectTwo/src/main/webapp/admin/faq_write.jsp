<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/security/admin_check.jspf"%>
<%	
	//전달값을 반환받아 저장 - 없는 경우 변수에 초기값 저장
	String pageNum="1", pageSize="10", faqCategory="", keyword="";
%>
<link href="<%=request.getContextPath()%>/css/write.css" type="text/css" rel="stylesheet">
<h1>FAQ 작성</h1>
<form action="<%=request.getContextPath()%>/index.jsp?group=admin&worker=faq_write_action"
	method="post" enctype="application/x-www-form-urlencoded" id="faqForm">
	<input type="hidden" name="pageNum" value="<%=pageNum %>">
	<input type="hidden" name="pageSize" value="<%=pageSize %>">
	<input type="hidden" name="pageSize" value="<%=faqCategory %>">
	<input type="hidden" name="keyword" value="<%=keyword %>">
	<table>
		<tr>
			<th>제목</th>
			<td>
				<input type="text" name="faqSubject" id="faqSubject" size="40">
			</td>					
		</tr>
		<tr> 
			<th>카테고리</th> 
			<td>
				<select name="faqCategory">
					<option value="배송">배송관련</option>
					<option value="제품">제품관련</option>
					<option value="회원">회원관련</option>
					<option value="주문">주문/결제</option>
					<option value="교환">교환/반품</option>
					<option value="기타">기타</option>
				</select>
			</td>
		</tr>	
		<tr>
			<th>내용</th>
			<td>
				<textarea rows="7" cols="60" name="faqContent" id="faqContent"></textarea>
			</td>
		</tr>
		<tr>				
			<th colspan="2">
				<button type="submit">글저장</button>
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
