<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style type="text/css">
fieldset {
	text-align: center;
	margin: 10px auto;
	width: 900px;
	border: 1px solid lightgray;
}

h1{
	text-align : center; 
	margin-bottom: 30px;
	font-size: 35px;
}

table {
	margin: 0 auto;
}

th {
	text-align: left;
	width: 120px;
	font-weight: bold;
	padding-top: 20px;
	padding-bottom: 20px;
}

td {
	text-align: left;
	word-spacing: 5px;
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

button + button {
	margin-left: 10px;
}

button:hover {
	color: white;
	background-color: black;
}

.error {
	color: red;
	position: relative;
	left: 160px;
	display: none;
}

</style>

<%-- 파일(리뷰 이미지)을 입력받아 전달하기 위해 form 태그의 enctype 속성값을 반드시 [multipart/form-date]로 설정 --%>
<form action="<%=request.getContextPath()%>/index.jsp?group=admin&worker=product_modify_action"
	method="post" enctype="multipart/form-data" id="productForm">
<h1>상품수정</h1>
<fieldset>
	<table>
		<tr>
			<th>상품명</th>
			<td>
				<input type="text" name="productName" id="productName" size="30">
			</td>					
		</tr>	
		<tr>
			<th>가격</th>
			<td>
				<input type="text" name="productPrice" id="productPrice" size="30">
			</td>					
		</tr>	
		<tr>
			<th>카테고리</th>
			<td>
			<select name="productCategory">
				<option value="nail">&nbsp;네일&nbsp;&nbsp;</option>
				<option value="pedi">&nbsp;페디&nbsp;&nbsp;</option>
				<option value="careTool">&nbsp;케어&툴&nbsp;&nbsp;</option>
			</select>
			</td>
		</tr>			
		<tr>
			<th>세부사항</th>
			<td>
				<input type='radio' name='productType' value="long"> 롱
				<input type='radio' name='productType' value="short"> 숏
				<input type='radio' name='productType' value="parts"> 파츠
				<input type='radio' name='productType' value="fullColor"> 풀컬러
			</td>
		</tr>			
		<tr>
			<th>상품이미지</th>
			<td>
				<input type="file" name="productImage">
			</td>
		</tr>
		<tr>
			<th>상품상세이미지</th>
			<td>
				<input type="file" name="productImage2">
			</td>
		</tr>
		<tr>
			<th>상품상세이미지</th>
			<td>
				<input type="file" name="productImage3">
			</td>
		</tr>
	</table>
</fieldset>	
	<button type="button" id="listBtn">목록</button>
	<button type="button" id="cancelBtn">취소</button>
	<button type="submit">수정</button>
</form>
<div id="message" style="color: red;"></div>

<script type="text/javascript">
$("#productName").focus();

$("#productForm").submit(function() {
	if($("#productName").val()=="") {
		$("#message").text("상품명을 입력해 주세요.");
		$("#productName").focus();
		return false;
	}
	
	if($("#productPrice").val()=="") {
		$("#message").text("가격을 입력해 주세요.");
		$("#productPrice").focus();
		return false;
	}
});

$("#listBtn").click(function() {
	location.href="<%=request.getContextPath()%>/index.jsp?group=admin&worker=product_list"
});

$("#cancelBtn").click(function() {
	location.href="<%=request.getContextPath()%>/index.jsp?group=admin&worker=product_list"
});
</script>