<%@page import="java.text.DecimalFormat"%>
<%@page import="xyz.nailro.dto.ProductDTO"%>
<%@page import="java.util.List"%>
<%@page import="xyz.nailro.dao.ProductDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/security/admin_check.jspf"%>
<%
   String search=request.getParameter("search");
   if(search==null) {
      search="";
   }
   
   String keyword=request.getParameter("keyword");
   if(keyword==null)	{
	  keyword="";
	}

   //페이징 처리에 필요한 전달값(페이지번호과 게시글갯수)을 반환받아 저장
   int pageNum=1;//페이지번호- 전달값이 없는 경우 저장된 초기값 설정
   if(request.getParameter("pageNum")!=null) {//전달값이 있는 경우
      pageNum=Integer.parseInt(request.getParameter("pageNum"));
   }
   
   int pageSize=10;//게시글갯수- 전달값이 없는 경우 저장된 초기값 설정
   if(request.getParameter("pageSize")!=null) {//전달값이 있는 경우
      pageSize=Integer.parseInt(request.getParameter("pageSize"));
   }

   
   //검색정보(검색대상과 검색단어)를 전달받아 PRODUCT 테이블에 저장된 게시글 중 검색대상의 컬럼에
   //검색단어가 포함된 게시글의 갯수를 검색하여 반환하는 ProductDAO 클래스의 메서드 호출
   // => 검색 기능을 사용하지 않을 경우 PRODUCT 테이블에 저장된 모든 게시글의 갯수를 반환
   int totalProduct=ProductDAO.getDAO().selectTotalProduct(search, keyword);//검색된 게시글의 총갯수
   
   //전체 페이지의 갯수를 계산하여 저장
   int totalPage=(int)Math.ceil((double)totalProduct/pageSize);//페이지의 총갯수
 
   //전달받은 페이지번호가 비정상적인 경우
   if(pageNum<=0 || pageNum>totalPage) {
      pageNum=1;
   }
   
   //페이지번호에 대한 게시글의 시작 행번호를 계산하여 저장
   //ex) 1Page : 1, 2Page : 11, 3Page : 21, 4Page : 31, ...
   int startRow=(pageNum-1)*pageSize+1;
   
   //페이지번호에 대한 게시글의 종료 행번호를 계산하여 저장
   //ex) 1Page : 10, 2Page : 20, 3Page : 30, 4Page : 40, ...
   int endRow=pageNum*pageSize;
   
   //마지막 페이지의 게시글의 종료 행번호가 게시글의 총갯수보다 많은 경우 종료 행번호 변경
   if(endRow>totalProduct) {
      endRow=totalProduct;
   }
   
   //페이징 처리 관련 정보(시작 행번호와 종료 행번호)와 게시글 검색 기능 관련 정보(검색대상과
   //검색단어)를 전달받아 PRODUCT 테이블에 저장된 행을 검색하여 게시글 목록을 반환하는 ProductDAO 
   //클래스의 메소드 호출
   List<ProductDTO> productList=ProductDAO.getDAO().selectProductList(startRow, endRow, search, keyword);
   DecimalFormat df=new DecimalFormat("###,###");

   //페이지에 출력될 게시글의 일련번호 시작값을 계산하여 저장
   // => 검색된 게시글의 총갯수가 91개인 경우 >> 1Page : 91, 2Page : 81, 3Page, 71
   int displayNum=totalProduct-(pageNum-1)*pageSize;
%>
<link href="<%=request.getContextPath()%>/css/list.css" type="text/css" rel="stylesheet">
<style>

#button {
   text-align: right;
   margin-bottom: 5px;
}

#search {
   margin-bottom: 30px;
}
</style>

<h1>상품관리</h1>
<form name="productForm" id="productForm">
<div id="product_list">
   <%-- 검색된 게시글 총갯수 출력 --%>
   <div id="product_title">상품목록(<%=totalProduct %>개)</div>
   <div id="button">
      <button type="button" id="removeBtn">삭제</button>&nbsp;
      <button type="button" id="addBtn">등록</button>
   </div>
   
<table>
   <tr>
      <th width="50"><input type="checkbox" name="allCheck" id="allCheck" onclick="allCheck()"></th>   
      <th width="100">상품번호</th>
      <th width="170">이미지</th>
      <th width="250">상품명</th>
      <th width="200">카테고리</th>
      <th width="150">세부사항</th>
      <th width="150">가격</th>
   </tr>
   
   <%-- List 객체의 요소(ProductDTO 객체)를 차례대로 제공받아 저장하여 처리하기 위한 반복문 --%>
   <% for(ProductDTO product : productList) { %>
   <tr align="center">
      <td class="p_check"><input type="checkbox" name="check" id="check" value="<%=product.getProductNum()%>"></td>
      <td width="100">
      	<% if(product.getProductCategory().equals("Nail")) { %>
			<%=product.getProductCategory().substring(0, 1) %><%=product.getProductType().substring(0, 1) %><%=product.getProductNum() %>
		<% } else if(product.getProductCategory().equals("Pedi")) { %>
			<%=product.getProductCategory().substring(0, 1) %><%=product.getProductNum() %>
		<% } else if(product.getProductCategory().equals("CareTool")) { %>
			<%=product.getProductCategory().substring(0, 1) %><%=product.getProductNum() %>
		<% } %>
      </td>
      <td class="content">
      <% if(product.getProductImage()!=null) { %>
         <img src="<%=request.getContextPath() %><%= product.getProductImage()%>" width="170" height="100">
         <% } %>
      </td>
      <td width="250">
      <%
         String url=request.getContextPath()+"/index.jsp?group=admin&worker=product_detail"
         +"&productNum="+product.getProductNum()+"&pageNum="+pageNum+"&pageSize="+pageSize
         +"&search="+search+"&keyword="+keyword;
      %>
      <a href="<%=url%>"><%=product.getProductName() %></a>
      </td>
      <td width="200"><%=product.getProductCategory() %></td>
      <td width="150">
      <% if(product.getProductType()==null) { %>
         -
      <% } else { %>
         <%=product.getProductType() %>
      <% } %>
      </td>
      <td width="150"><%=df.format(product.getProductPrice()) %>원</td>
   </tr>
   <% } %>
</table>

   <%-- 페이지번호 출력 및 링크 제공 - 블럭화 처리 --%>
   <%
      //하나의 페이지블럭에 출력될 페이지번호의 갯수 설정
      int blockSize=5;
   
      //페이지블럭에 출력될 시작 페이지번호를 계산하여 저장
      //ex)1Block : 1, 2Block : 6, 3Block : 11, 4Block : 16,...
      int startPage=(pageNum-1)/blockSize*blockSize+1;
              
      //페이지블럭에 출력될 종료 페이지번호를 계산하여 저장
      //ex)1Block : 5, 2Block : 10, 3Block : 15, 4Block : 20,...
      int endPage=startPage+blockSize-1;
      
      //종료 페이지번호가 페이지 총갯수보다 큰 경우 종료 페이지번호 변경 
      if(endPage>totalPage) {
         endPage=totalPage;
      }
      
   %>
   
   <div id="page_list">
      <%
         String responseUrl=request.getContextPath()+"/index.jsp?group=admin&worker=product_list"
               +"&pageSize="+pageSize+"&search="+search+"&keyword="+keyword;
      %>
   
      <%-- 이전 페이지블럭이 있는 경우에만 링크 제공 --%>
      <% if(startPage>blockSize) { %>
         
         <a href="<%=responseUrl%>&pageNum=<%=startPage-blockSize%>">[이전]</a>
      <% } else { %>   
         [이전]
      <% } %>
      
      <% for(int i=startPage;i<=endPage;i++) { %>
         <%-- 요청 페이지번호와 출력된 페이지번호가 같지 않은 경우에만 링크 제공 --%>
         <% if(pageNum != i) { %>
            <a href="<%=responseUrl%>&pageNum=<%=i%>">[<%=i %>]</a>
         <% } else { %>
            [<%=i %>]
         <% } %>
      <% } %>
      
      <%-- 다음 페이지블럭이 있는 경우에만 링크 제공 --%>
      <% if(endPage!=totalPage) { %>
         <a href="<%=responseUrl%>&pageNum=<%=startPage+blockSize%>">[다음]</a>
      <% } else { %>   
         [다음]
      <% } %>
   </div>
</div>
</form>

<form action="<%=request.getContextPath() %>/index.jsp?group=admin&worker=product_list" method="post">
   <%-- select 태그를 사용하여 검색대상을 선택해 전달 - 전달값은 반드시 컬럼명으로 설정 --%>
   <div id="search">
   <select name="search">
      <option value="product_name" <% if(search.equals("product_name")) { %>  selected <% } %>>&nbsp;상품명&nbsp;</option>
      <option value="product_category" <% if(search.equals("product_category")) { %>  selected <% } %>>&nbsp;카테고리&nbsp;</option>
   </select>
   <input type="text" name="keyword" value="<%=keyword%>" >
   <button type="submit">검색</button>
   </div>
</form>

<script type="text/javascript">

$("#productCount").change(function() {
   location.href="<%=request.getContextPath()%>/index.jsp?group=admin&worker=product_list"
      +"&pageNum=<%=pageNum%>&pageSize="+$("#productCount").val()
      +"&search=<%=search%>&keyword=<%=keyword%>";
});

$("#addBtn").click(function() {
   location.href="<%=request.getContextPath()%>/index.jsp?group=admin&worker=product_add";
});

$(document).ready(function() {
   $("#allCheck").click(function() {
      if($("#allCheck").prop("checked")) {
         $("input[name=check]").prop("checked",true);
      } else { 
         $("input[name=check]").prop("checked",false);
      }
   });

   $("input[name=check]").click(function() {
      var total=$("input[name=check]").length;
      var checked=$("input[name=check]:checked").length;

      if(total!=checked) { 
         $("#allCheck").prop("checked",false);
      } else {
         $("#allCheck").prop("checked",true);
      }
   });
      
   $("#removeBtn").click(function() {
      if($("input[name=check]").filter(":checked").length==0) {
         alert("삭제할 상품을 선택하세요.");
         return;
      }

      if(confirm("상품을 삭제 하시겠습니까?")) {
         location.href="<%=request.getContextPath()%>/index.jsp?group=admin&worker=product_remove_action"
      } else {
         return false;
      }      

   $("#productForm").attr("action", "<%=request.getContextPath()%>/index.jsp?group=admin&worker=product_remove_action");
   $("#productForm").attr("method","post");
   $("#productForm").submit();
   });
});
</script>
