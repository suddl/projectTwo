<%@page import="xyz.nailro.dao.ProductDAO"%>
<%@page import="xyz.nailro.dto.ProductDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 글번호를 전달받아 REVIEW 테이블의 저장된 행(게시글)을 검색하여 입력태그의 입력값으로
출력하고 변경값을 입력받기 위한 JSP 문서 --%>
<%-- => 로그인 상태의 사용자 중 게시글 작성자이거나 관리자인 경우에만 요청 가능한 JSP 문서 --%>    
<%-- => [글변경] 태그를 클릭한 경우 [/review/review_modify_action.jsp] 문서를 요청하여 페이지 이동 - 입력값(게시글) 전달 --%>

<%-- 비로그인 상태의 사용자가 JSP 문서를 요청한 경우 에러페이지로 이동되도록 응답 처리 --%>
<%@include file="/security/admin_check.jspf" %>    
<%

	//전달값을 반환받아 저장
	int productNum=Integer.parseInt(request.getParameter("productNum"));
	String pageNum=request.getParameter("pageNum");
	String pageSize=request.getParameter("pageSize");
	String search=request.getParameter("search");
	String keyword=request.getParameter("keyword");
	
	//글번호를 전달받아 REVIEW 테이블의 단일행을 검색하여 게시글(ReviewDTO 객체)을 반환하는 
	//ReviewDAO 클래스의 메소드 호출
	ProductDTO product=ProductDAO.getDAO().selectProductByNum(productNum);
	
	//검색된 게시글이 없는 경우에 대한 응답 처리 - 비정상적인 요청
	if(product==null) {
		request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?group=error&worker=error_400");
		return;
	}	
%>

<link href="<%=request.getContextPath()%>/css/header.css" type="text/css" rel="stylesheet">
<style>
#product_modify {
	width: 800px;
	margin: 0 auto;
}
	
h1{
	text-align : center; 
	margin-bottom: 30px;
	font-size: 35px;
}

table {
	margin: 10px auto;
	border: 1px solid lightgray;
	border-collapse: collapse;
}

th, td {
	border: 1px solid lightgray;
	padding: 5px;	
}

th {
	width: 150px;
	background: #FFDCE1;
	color: black;
	font-size: 18px;
}

td {
	width: 650px;
	text-align : left; 
}

#button {
	padding: 20px;
	border: none;
	background: white;
}

#product_menu {
	text-align: right;
	margin: 5px;
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
						value="<%=product.getProductName()%>">
			</td>					
		</tr>	
		<tr>
			<th>가격</th>
			<td>
				<input type="text" name="productPrice" id="productPrice" size="30"
						value="<%=product.getProductPrice()%>">원
			</td>					
		</tr>	
		<tr>
			<th>카테고리</th>
			<td>
			<select name="productCategory" >
				<option value="Nail"<% if(product.getProductCategory().equals("Nail")) {%>selected<%}%>>네일</option>
				<option value="Pedi"<% if(product.getProductCategory().equals("Pedi")) {%>selected<%}%>>페디</option>
				<option value="CareTool"<% if(product.getProductCategory().equals("CareTool")) {%>selected<%}%>>케어&툴</option>
			</select>
			</td>
		</tr>			
		<tr>
			<th>세부사항</th>
			<td>
				<input type="radio" name="productType" value="Long"<% if(product.getProductType().equals("Long")) {%>checked<%}%>> 롱
				<input type="radio" name="productType" value="Short"<% if(product.getProductType().equals("Short")) {%>checked<%}%>> 숏
				<input type="radio" name="productType" value="Parts"<% if(product.getProductType().equals("Parts")) {%>checked<%}%>> 파츠
				<input type="radio" name="productType" value="FullColor"<% if(product.getProductType().equals("FullColor")) {%>checked<%}%>> 풀컬러
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
	<div id="product_menu">
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

$("#listBtn").click(function() {
	location.href="<%=request.getContextPath()%>/index.jsp?group=admin&worker=product_list"
		+"&productNum=<%=product.getProductNum()%>&pageNum=<%=pageNum%>"
		+"&pageSize=<%=pageSize%>&keyword=<%=keyword%>";	
});

$("#cancelBtn").click(function() {
	location.href="<%=request.getContextPath()%>/index.jsp?group=admin&worker=product_detail"
		+"&productNum=<%=product.getProductNum()%>&pageNum=<%=pageNum%>"
		+"&pageSize=<%=pageSize%>&keyword=<%=keyword%>";	
});

</script>
