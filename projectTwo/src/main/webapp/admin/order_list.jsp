<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link href="<%=request.getContextPath()%>/css/header.css" type="text/css" rel="stylesheet">
<style>
table {
	margin: 5px auto;
	border: 1px solid black;
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

#page_list {
	font-size: 1.1em;
	margin: 10px;
}

#page_list a:hover {
	font-size: 1.3em;
}
</style>

<h1>주문관리</h1>
<table>
	<tr>
		<th width="50"><input type="checkbox" name="order" value="selectAll" onclick='selectAll(this)'></th>
		<th width="100">주문번호</th>
		<th width="120">아이디</th>
		<th width="250">전화번호</th>
		<th width="200">결제방법</th>
		<th width="150">결제금액</th>
		<th width="150">주문처리상태</th>
		<th width="150">주문일</th>
	</tr>
	<tr>
		<td><input type="checkbox" name="order"></td>
		<td>3000</td>
		<td>abc123</td>
		<td>010-1234-5678</td>
		<td>신용카드</td>
		<td>46,000원</td>
		<td>
			<select name="orderStatus">
				<option value="nail">&nbsp;상품준비중&nbsp;</option>
				<option value="pedi">&nbsp;배송준비중&nbsp;</option>
				<option value="pedi">&nbsp;배송중&nbsp;</option>
				<option value="pedi">&nbsp;배송완료&nbsp;</option>
				<option value="careTool">&nbsp;주문취소&nbsp;</option>
			</select>
		</td>
		<td>2024-01-29</td>
	</tr>
	<tr>
		<td><input type="checkbox" name="order"></td>
		<td>3001</td>
		<td>xyz456</td>
		<td>010-2345-1235</td>
		<td>계좌이체</td>
		<td>50,000원</td>
		<td>
			<select name="orderStatus">
				<option value="nail">&nbsp;상품준비중&nbsp;</option>
				<option value="pedi">&nbsp;배송준비중&nbsp;</option>
				<option value="pedi">&nbsp;배송중&nbsp;</option>
				<option value="pedi">&nbsp;배송완료&nbsp;</option>
				<option value="careTool">&nbsp;주문취소&nbsp;</option>
			</select>
		</td>
		<td>2024-01-30</td>
	</tr>
	<tr>
		<td><input type="checkbox" name="order"></td>
		<td>&nbsp;&nbsp;</td>
		<td>&nbsp;&nbsp;</td>
		<td>&nbsp;&nbsp;</td>
		<td>&nbsp;&nbsp;</td>
		<td>&nbsp;&nbsp;</td>
		<td>&nbsp;&nbsp;</td>
		<td>&nbsp;&nbsp;</td>
	</tr>
	<tr>
		<td><input type="checkbox" name="order"></td>
		<td>&nbsp;&nbsp;</td>
		<td>&nbsp;&nbsp;</td>
		<td>&nbsp;&nbsp;</td>
		<td>&nbsp;&nbsp;</td>
		<td>&nbsp;&nbsp;</td>
		<td>&nbsp;&nbsp;</td>
		<td>&nbsp;&nbsp;</td>
	</tr>
	<tr>
		<td><input type="checkbox" name="order"></td>
		<td>&nbsp;&nbsp;</td>
		<td>&nbsp;&nbsp;</td>
		<td>&nbsp;&nbsp;</td>
		<td>&nbsp;&nbsp;</td>
		<td>&nbsp;&nbsp;</td>
		<td>&nbsp;&nbsp;</td>
		<td>&nbsp;&nbsp;</td>
	</tr>
</table>
<button type="button" id="applyBtn">적용</button>
<form action="<%=request.getContextPath() %>/index.jsp?group=admin&worker=order_list" method="post">
	<%-- select 태그를 사용하여 검색대상을 선택해 전달 - 전달값은 반드시 컬럼명으로 설정 --%>
	<select name="search">
		<option value="order_client" >&nbsp;아이디&nbsp;</option>
	</select>
	<input type="text" name="keyword" value="" >
	<button type="submit">검색</button>
</form>
</div>

<script type="text/javascript">
$("#applyBtn").click(function() {
	location.href="<%=request.getContextPath()%>/index.jsp?group=admin&worker=order_modify_action"
});
</script>
