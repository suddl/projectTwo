<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 관리자로부터 상품글을 입력받기 위한 JSP 문서 --%>
<%-- => 관리자만 요청 가능한 JSP 문서 --%>
<%-- => [등록] 태그를 클릭한 경우 [/admin/product_add_action.jsp] 문서를 요청하여 페이지 
이동 - 입력값(게시글) 전달 --%>
<%@include file="/security/admin_check.jspf"%>
<%
	//전달값을 반환받아 저장 - 전달값이 없는 경우 변수에 초기값 저장
	String pageNum="1", pageSize="10", search="", keyword="";
%>
<link href="<%=request.getContextPath()%>/css/product_add.css" type="text/css" rel="stylesheet">

<%-- 파일(리뷰 이미지)을 입력받아 전달하기 위해 form 태그의 enctype 속성값을 반드시 [multipart/form-date]로 설정 --%>
<form action="<%=request.getContextPath()%>/index.jsp?group=admin&worker=product_add_action"
	method="post" enctype="multipart/form-data" id="productForm">
	<input type="hidden" name="pageNum" value="<%=pageNum %>">
	<input type="hidden" name="pageSize" value="<%=pageSize %>">
	<input type="hidden" name="search" value="<%=search %>">
	<input type="hidden" name="keyword" value="<%=keyword %>">

<div id="product_add">
	<h1>상품등록</h1>
	<table>
		<tr>
			<th >상품명</th>
			<td>
				<input type="text" name="productName" id="productName" size="30">
			</td>					
		</tr>	
		<tr>
			<th>가격</th>
			<td>
				<input type="text" name="productPrice" id="productPrice" size="30" 
					 maxlength="10"> 원 
			</td>					
		</tr>
		<tr>
			<th>카테고리</th>
			<td>
			<select name="productCategory" id="productCategory" onchange="productChange(this)">
				<option value="">--선택--</option>
				<option value="Nail">네일</option>
				<option value="Pedi">페디</option>
				<option value="CareTool">케어&툴</option>
			</select>
			</td>
		</tr>			
		<tr>
			<th>세부사항</th>
			<td>
				<select name="productType" id="productType" >
				<option value="">--선택--</option>
			</select>
			</td>
		</tr>
		<tr>
			<th>상품대표이미지</th>
			<td>
				<input type="file" name="productImage" id="productImage">
			</td>
		</tr>
		<tr>
			<th>상품상세이미지1</th>
			<td>
				<input type="file" name="productImage2" id="productImage2">
			</td>
		</tr>
		<tr>
			<th>상품상세이미지2</th>
			<td>
				<input type="file" name="productImage3" id="productImage3">
			</td>
		</tr>
	</table>
	<div id="product_menu">
	<button type="button" id="cancelBtn">취소</button>&nbsp;
	<button type="submit">등록</button>
	</div>
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
		$("#message").text("상품가격을 입력해 주세요.");
		$("#productPrice").focus();
		return false;
	}
	
	if($("#productImage").val()=="") {
		$("#message").text("상품대표이미지를 입력해 주세요.");
		$("#productImage").focus();
		return false;
	}
	
	if($("#productImage2").val()=="") {
		$("#message").text("상품상세이미지1을 입력해 주세요.");
		$("#productImage2").focus();
		return false;
	}

	if($("#productImage3").val()=="") {
		$("#message").text("상품상세이미지2를 입력해 주세요.");
		$("#productImage3").focus();
		return false;
	}
});

function productChange(e) {
	var Nail_n = ["롱", "숏", "파츠", "풀컬러"];
	var Pedi_p = ["--선택--"];
	var CareTool_c = ["--선택--"];
	var Select_s = ["--선택--"];
	var target = document.getElementById("productType");
	
	if(e.value == "Nail") var d = Nail_n;
	else if(e.value == "Pedi") var d = Pedi_p;
	else if(e.value == "CareTool") var d = CareTool_c;
	else if(e.value == "") var d = Select_s;
	
	target.options.length = 0;
	
	for (x in d) {
	var opt = document.createElement("option");
	opt.value = d[x];
	opt.innerHTML = d[x];
	target.appendChild(opt);
	}
}
	
$("#cancelBtn").click(function() {
	location.href="<%=request.getContextPath()%>/index.jsp?group=admin&worker=product_list"
});

</script>
