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
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link href="<%=request.getContextPath()%>/css/header.css" type="text/css" rel="stylesheet">
</head>
<body>
	<div id="header">
		<jsp:include page="/header_main.jsp"></jsp:include>
	</div>
	
	<div id="content">
		<jsp:include page="<%=contentFilePath %>"/>
	</div>
	
	<div id="footer">
		<jsp:include page="/footer.jsp"></jsp:include>
	</div>
</body>
</html>