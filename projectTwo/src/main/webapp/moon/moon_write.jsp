<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/security/login_check.jspf"%>

<%
	String pageNum="1", pageSize="10", search="", keyword="";
%>
	
<style type="text/css">
table {
	margin: 0 auto;
}

th {
	width: 100px;
	font-weight: bold;
}

td {
	text-align: left;
}
</style>
