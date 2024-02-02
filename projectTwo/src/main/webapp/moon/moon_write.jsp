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
<form action="<%=request.getContextPath() %>/index.jsp?group=moon&worker=moon_write_action" method="post" enctype="multipart/form-data" id="moonFoem">
	<input type="hidden" name="pageNum" value="<%=pageNum %>">
	<input type="hidden" name="pageSize" value="<%=pageSize %>">
	<input type="hidden" name="search" value="<%=search %>">
	<input type="hidden" name="keyword" value="<%=keyword %>">
	<table>
		<tr>
			<th>제목</th>
			<td>
				<select id="moonTitle">
					<option value="상품 문의입니다.">상품 문의입니다.</option>
					<option value="배송 문의입니다.">배송 문의입니다.</option>
					<option value="교환&취소&반품 문의입니다.">교환&취소&반품 문의입니다.</option>
					<option value="불량 문의입니다.">불량 문의입니다.</option>
					<option value="기타 문의입니다.">기타 문의입니다.</option>
				</select>
			</td>
		</tr>
		<tr>
			<th>내용</th>
			<td>
				<textarea rows="7" cols="60" name="moonContent" id="moonwContent"></textarea>
			</td>
		</tr>
		<tr>
			<th>이미지파일</th>
			<td>
				<input type="file" name="moonImage">
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
$("#moonSubject").focus();

$("#moonForm").submit(function() {
	if($("#moonTitle").val()=="") {
		$("#message").text("제목을 입력해 주세요.");
		$("#moonTitle").focus();
		return false;
	}
	
	if($("#moonContent").val()=="") {
		$("#message").text("내용을 입력해 주세요.");
		$("#moonContent").focus();
		return false;
	}
});

$("#resetBtn").click(function() {
	$("#moonSubject").focus();
	$("#message").text("");
});
</script>
