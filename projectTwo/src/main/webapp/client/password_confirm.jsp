<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/security/login_check.jspf" %>  
<%
	String action=request.getParameter("action");

	//전달값이 업거나 전달값이 잘못된 경우에 대한 응답 처리 - 비정상적인 요청
	if(action==null || !action.equals("modify") && !action.equals("remove")) {
		request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?group=error&worker=error_400");
		return;
	}
	
	String message=(String)session.getAttribute("message");
	if(message==null) {
		message="";
	} else {
		session.removeAttribute("message");
	}
%>
<% if(action.equals("modify")) { %>
	<p>회원정보변경을 위해 비밀번호를 입력해 주세요.</p>
<% } else { %>
	<p>회원탈퇴를 위해 비밀번호를 입력해 주세요.</p>
<% } %>
<form method="post" id="passwordForm">
	<input type="password" name="passwd" id="passwd">
	<button type="button" id="submitBtn">입력완료</button>
</form>
<p id="message" style="color: red;"><%=message %></p>

<script type="text/javascript">
$("#passwd").focus();

$("#submitBtn").click(function() {
	if($("#passwd").val()=="") {
		$("#message").text("비밀번호를 입력해 주세요.");
		return;
	}
	
	<%-- 전달값에 의해 form 태그의 action 속성값으로 요청 JSP 문서를 구분하여 저장 --%>
	<% if(action.equals("modify")) { %>
		$("#passwordForm").attr("action", "<%=request.getContextPath()%>/index.jsp?group=client&worker=client_modify");
	<% } else { %>
		$("#passwordForm").attr("action", "<%=request.getContextPath()%>/index.jsp?group=client&worker=client_remove_action");
	<% } %>
	
	$("#passwordForm").submit();
});
</script>