<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style type="text/css">
table {
	margin: 5px auto;
	border: 1px solid lightgray;
	border-collapse: collapse;
}

h1{
	text-align : center; 
	margin-bottom: 30px;
	font-size: 35px;
}

th {
	border: 1px solid lightgray;
	background: lightgray;
	color: black;
	height: 40px;
}

td {
	border: 1px solid lightgray;
	text-align: center;	
	height: 40px;
}

button {
	margin: 10px auto;
	padding: 5px;
	width: 70px;
	background-color: lightgray;
	color: black;
	font-size: 15px;
	cursor: pointer;
	font-weight: bold;
	border-width: thin;
}

#modifyBtn {
	margin: 10px auto;
	padding: 5px;
	width: 50px;
	height: 35px;
	background-color: lightgray;
	color: black;
	font-size: 15px;
	cursor: pointer;
	font-weight: bold;
	border-width: thin;
}

#page_list {
	font-size: 1.1em;
	margin: 10px;
}

button + button {
	margin-left: 10px;
	margin-bottom: 50px;
}

#page_list a:hover {
	font-size: 1.3em;
}
</style>

<h1>상품관리</h1>
<table>
	<tr>
		<th width="50"><input type="checkbox" name="product" value="selectAll" onclick='selectAll(this)'></th>
		<th width="100">상품번호</th>
		<th width="170">이미지</th>
		<th width="250">상품명</th>
		<th width="200">카테고리</th>
		<th width="150">세부사항</th>
		<th width="150">가격</th>
		<th width="100">수정</th>
	</tr>
	<tr>
		<td><input type="checkbox" name="product"></td>
		<td>1000</td>
		<td>이미지</td>
		<td>선라이즈네일</td>
		<td>네일</td>
		<td>롱</td>
		<td>20,000원</td>
		<td><button type="button" id="modifyBtn">수정</button></td>
	</tr>
	<tr>
		<td><input type="checkbox" name="product"></td>
		<td>1001</td>
		<td>이미지</td>
		<td>슈가프렌치네일</td>
		<td>네일</td>
		<td>숏</td>
		<td>18,000원</td>
		<td><button type="button" id="modifyBtn">수정</button></td>
	</tr>
	<tr>
		<td><input type="checkbox" name="product"></td>
		<td>&nbsp;&nbsp;</td>
		<td>&nbsp;&nbsp;</td>
		<td>&nbsp;&nbsp;</td>
		<td>&nbsp;&nbsp;</td>
		<td>&nbsp;&nbsp;</td>
		<td>&nbsp;&nbsp;</td>
		<td>&nbsp;&nbsp;</td>
	</tr>
	<tr>
		<td><input type="checkbox" name="product"></td>
		<td>&nbsp;&nbsp;</td>
		<td>&nbsp;&nbsp;</td>
		<td>&nbsp;&nbsp;</td>
		<td>&nbsp;&nbsp;</td>
		<td>&nbsp;&nbsp;</td>
		<td>&nbsp;&nbsp;</td>
		<td>&nbsp;&nbsp;</td>
	</tr>
	<tr>
		<td><input type="checkbox" name="product"></td>
		<td>&nbsp;&nbsp;</td>
		<td>&nbsp;&nbsp;</td>
		<td>&nbsp;&nbsp;</td>
		<td>&nbsp;&nbsp;</td>
		<td>&nbsp;&nbsp;</td>
		<td>&nbsp;&nbsp;</td>
		<td>&nbsp;&nbsp;</td>
	</tr>
</table>
<button type="button" id="removeBtn">삭제</button>
<button type="button" id="addBtn">등록</button>
<form action="<%=request.getContextPath() %>/index.jsp?group=admin&worker=product_list" method="post">
	<%-- select 태그를 사용하여 검색대상을 선택해 전달 - 전달값은 반드시 컬럼명으로 설정 --%>
	<select name="search">
		<option value="product_name" >&nbsp;상품명&nbsp;</option>
		<option value="product_category" >&nbsp;카테고리&nbsp;</option>
	</select>
	<input type="text" name="keyword" value="" >
	<button type="submit">검색</button>
</form>

<script type="text/javascript">
$("#modifyBtn").click(function() {
	location.href="<%=request.getContextPath()%>/index.jsp?group=admin&worker=product_modify"
});

$("#addBtn").click(function() {
	location.href="<%=request.getContextPath()%>/index.jsp?group=admin&worker=product_add"
});

$("#removeBtn").click(function() {
	location.href="<%=request.getContextPath()%>/index.jsp?group=admin&worker=product_remove_action"
});
</script>
