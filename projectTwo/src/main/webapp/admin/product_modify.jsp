<%@page import="xyz.nailro.dao.ProductDAO"%>
<%@page import="xyz.nailro.dto.ProductDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/security/admin_check.jspf" %>    
<%
	//전달값을 반환받아 저장
	int productNum=Integer.parseInt(request.getParameter("productNum"));
	String pageNum=request.getParameter("pageNum");
	String pageSize=request.getParameter("pageSize");
	String search=request.getParameter("search");
	String keyword=request.getParameter("keyword");
	
	ProductDTO product=ProductDAO.getDAO().selectProductByNum(productNum);
	
	//검색된 게시글이 없는 경우에 대한 응답 처리 - 비정상적인 요청
	if(product==null) {
		request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?group=error&worker=error_400");
		return;
	}	
%>

<link href="<%=request.getContextPath()%>/css/product_add.css" type="text/css" rel="stylesheet">
<style>
#product_me {
	text-align: right;
	margin: 5px;
}

input:invalid {
	border-color: red;    /* 값이 유효하지 않다면, border색을 red로 지정한다 */
	background-color: #ffefef;
}

input:valid {
	border-color: #b8d8d8; /* 값이 유효하다면, border색을 #b8d8d8로 지정한다 */
	background-color: #e9f0fd;
}

</style>
<form action="<%=request.getContextPath()%>/index.jsp?group=admin&worker=product_modify_action"
	method="post" enctype="multipart/form-data" id="productForm">
	<input type="hidden" name="productNum" value="<%=productNum %>">
	<input type="hidden" name="pageNum" value="<%=pageNum %>">
	<input type="hidden" name="pageSize" value="<%=pageSize %>">
	<input type="hidden" name="search" value="<%=search %>">
	<input type="hidden" name="keyword" value="<%=keyword %>">
	<input type="hidden" name="currentProductImage" value="<%=product.getProductImage()%>">
	<input type="hidden" name="currentProductImage2" value="<%=product.getProductImage2()%>">
	<input type="hidden" name="currentProductImage3" value="<%=product.getProductImage3()%>">

<div id="product_modify">
	<h1>상품수정</h1>
	<table>
		<tr>
			<th>상품명</th>
			<td>
				<input type="text" name="productName" id="productName" size="30"
					value="<%=product.getProductName()%>" required>
			</td>					
		</tr>	
		<tr>
			<th>가격</th>
			<td>
				<input type="text" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" name="productPrice" id="productPrice" size="30"
					value="<%=product.getProductPrice()%>" required> 원
			</td>					
		</tr>	
		<tr>
			<th>카테고리</th>
			<td>
				<select name="productCategory" id="productCategory" onchange="productChange(this)">
					<option value="Nail"<% if(product.getProductCategory().equals("Nail")) {%>selected<%}%>>네일</option>
					<option value="Pedi"<% if(product.getProductCategory().equals("Pedi")) {%>selected<%}%>>페디</option>
					<option value="CareTool"<% if(product.getProductCategory().equals("CareTool")) {%>selected<%}%>>케어&툴</option>
				</select>
			</td>
		</tr>			
		<tr>
			<th>세부사항</th>
			<td>
				<select name="productType" id="productType">
				<% if(product.getProductType()!=null) { %>
						<option value="Long"<% if("Long".equals(product.getProductType())) {%>selected<%}%>>롱</option>	
						<option value="Short"<% if("Short".equals(product.getProductType())) {%>selected<%}%>>숏</option>	
						<option value="Parts"<% if("Parts".equals(product.getProductType())) {%>selected<%}%>>파츠</option>	
						<option value="FullColor"<% if("FullColor".equals(product.getProductType())) {%>selected<%}%>>풀컬러</option>	
				<% } else { %>
						<option value=""<% if("".equals(product.getProductType())) {%>selected<%}%>>--선택--</option>
				<% } %>	
				</select>
			</td>
		</tr>			
		<tr>
			<th>상품대표이미지</th>
			<td>
				<input type="file" name="productImage" id="productImage">
				<% if(product.getProductImage()!=null) { %>
						<div style="color: red;">이미지를 변경할 경우에만 파일을 입력해 주세요.</div>
						<img src="<%=request.getContextPath()%><%=product.getProductImage()%>" width="200"><br><br>
				<% } %>
			</td>
		</tr>
		<tr>
			<th>상품상세이미지1</th>
			<td>
				<input type="file" name="productImage2" id="productImage2">
				<% if(product.getProductImage2()!=null) { %>
						<div style="color: red;">이미지를 변경할 경우에만 파일을 입력해 주세요.</div>
						<img src="<%=request.getContextPath()%><%=product.getProductImage2()%>" width="200"><br><br>
				<% } %>
			</td>
		</tr>
		<tr>
			<th>상품상세이미지2</th>
			<td>
				<input type="file" name="productImage3" id="productImage3">
				<% if(product.getProductImage3()!=null) { %>
						<div style="color: red;">이미지를 변경할 경우에만 파일을 입력해 주세요.</div>
						<img src="<%=request.getContextPath()%><%=product.getProductImage3()%>" width="200"><br><br>
				<% } %>
			</td>
		</tr>
	</table>
	<div id="product_me">
		<button type="button" id="listBtn">목록</button>&nbsp;
		<button type="button" id="cancelBtn">취소</button>&nbsp;
		<button type="submit">수정</button>
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
		$("#message").text("가격을 입력해 주세요.");
		$("#productPrice").focus();
		return false;
	}
});

function getselect() {
    var select = document.getElementById('productCategory');
    var option = select.options[select.selectedIndex];

    document.getElementById('value').value = option.value;
    document.getElementById('text').value = option.text;
}

function productChange(e) {
	var Nail_n = ["롱", "숏", "파츠", "풀컬러"];
	var Pedi_p = ["--선택--"];
	var CareTool_c = ["--선택--"];
	var target = document.getElementById("productType");
	
	if(e.value == "Nail") var d = Nail_n;
	else if(e.value == "Pedi") var d = Pedi_p;
	else if(e.value == "CareTool") var d = CareTool_c;
	
	target.options.length = 0;
	
	for (x in d) {
		var opt = document.createElement("option");
		opt.value = d[x];
		opt.innerHTML = d[x];
		target.appendChild(opt);
	}
}

$("#listBtn").click(function() {
	location.href="<%=request.getContextPath()%>/index.jsp?group=admin&worker=product_list"
		+"&pageNum=<%=pageNum%>&pageSize=<%=pageSize%>&search=<%=search%>&keyword=<%=keyword%>";
});

$("#cancelBtn").click(function() {
	location.href="<%=request.getContextPath()%>/index.jsp?group=admin&worker=product_detail"
		+"&productNum=<%=product.getProductNum()%>&pageNum=<%=pageNum%>"
		+"&pageSize=<%=pageSize%>&search=<%=search%>&keyword=<%=keyword%>";	
});
</script>