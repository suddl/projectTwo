<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style type="text/css">
fieldset {
	text-align: center;
	margin: 10px auto;
	width: 1100px;
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
	width: 100px;
	font-weight: bold;
	margin-top: 30px;
}

td {
	text-align: left;
	
}
</style>

<%-- 파일(리뷰 이미지)을 입력받아 전달하기 위해 form 태그의 enctype 속성값을 반드시 [multipart/form-date]로 설정 --%>
<form action="<%=request.getContextPath()%>/index.jsp?group=admin&worker=product_add_action"
	method="post" enctype="multipart/form-data" id="productForm">
<h1>상품등록</h1>
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
				<option value=""></option>
				<option value="nail">네일</option>
				<option value="pedi">페디</option>
				<option value="careTool">케어&툴</option>
			</select>
			</td>
		</tr>			
		<tr>
			<th>세부사항</th>
			<td>
				롱<input type='radio' name='productType' value="long">
				숏<input type='radio' name='productType' value="short">
				파츠<input type='radio' name='productType' value="parts">
				풀컬러<input type='radio' name='productType' value="fullColor">
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

		<tr>
		</tr>
	</table>
</fieldset>	
<div>
	<button type="button" id="listBtn">목록</button>
	<button type="button" onclick="location.href='<%=request.getContextPath()%>/index.jsp?group=admin&worker=product_list';">취소</button>
	<button type="submit">등록</button>
</div>
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

	if($("#productCategory").val()=="") {
		$("#message").text("카테고리를 선택해 주세요.");
		return false;
	}
	
	if($("#productType").val()=="") {
		$("#message").text("세부사항을 선택해 주세요.");
		$("#productType").focus();
		return false;
	}
	
	if($("#productImage").val()=="") {
		$("#message").text("이미지를 첨부해 주세요.");
		$("#productImage").focus();
		return false;
	}
	
});

$("#listBtn").click(function() {
	location.href="<%=request.getContextPath()%>/index.jsp?group=review&worker=review_list"
});
</script>