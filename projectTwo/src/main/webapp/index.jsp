<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("utf-8");
	
	String group=request.getParameter("group");
	if(group==null) {
		group="main";
	}
	
	String worker = request.getParameter("worker");
	if(worker==null) {
		worker="main_page";
	}
	
	String contentFilePath="/"+group+"/"+worker+".jsp";
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link href="<%=request.getContextPath()%>/css/header.css" type="text/css" rel="stylesheet">
</head>
<body>
	<div id="header">
		<jsp:include page="/header_main.jsp"></jsp:include>
	</div>
	
	<div id="content">
		<jsp:include page="<%=contentFilePath %>"/>
		<%
			String returnUrl=(String)request.getAttribute("returnUrl");
			if(returnUrl != null)  {
				response.sendRedirect(returnUrl);
				return;
			}
			%>
	</div>
	
	<div id="footer">
		<jsp:include page="/footer.jsp"></jsp:include>
	</div>
</body>
</html>