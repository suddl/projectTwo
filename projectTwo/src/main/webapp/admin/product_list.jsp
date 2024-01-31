<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<link href="<%=request.getContextPath()%>/css/header.css" type="text/css" rel="stylesheet">
<style>
.table{
width: 80%;
margin: 0 auto;

}

h1{
text-align : center; 
margin-bottom: 30px;
font-size: 35px;
}

table{
border: 1px solid #DCDCDC;
}

#addBtn {
	margin: 0 auto;
	padding: 5px;
	width: 500px;
	background-color: black;
	color: white;
	font-size: 20px;
	cursor: pointer;
	font-weight: bold;
	border-radius: 10px;
	
}

</style>

</head>
<body>
<h1>상품관리</h1>

<table class="table" >
  <thead>
    <tr>
      <th scope="col" width="50"><input type="checkbox" name="product" value="selectAll" onclick='selectAll(this)' ></th>
      <th scope="col" width="100">상품번호</th>
      <th scope="col" width="150">상품이미지</th>
      <th scope="col" width="150">상품명</th>
      <th scope="col" width="150">카테고리</th>
      <th scope="col" width="150">세부사항</th>
      <th scope="col" width="100">가격</th>
      <th scope="col" width="150">관리</th>
    </tr>
  </thead>

  <form action="<%=request.getContextPath() %>/index.jsp?group=admin&worker=product_add"
   method="post" id="productForm" name="productForm" >
  <tbody>
    <tr>
      <th scope="row">
      <input type="checkbox" name="product" >
      </th>
      <td>10,000 원</td>
    </tr>
    
     <tr>
      <th scope="row">
      <input type="checkbox" name="product" >
      </th>
      <td>이미지&nbsp;&nbsp; 상품명</td>
      <td>
      
  	
      <script type="text/javascript">
      	//전체선택
      	function selectAll(selectAll)  {
    	  const checkboxes = document.getElementsByName('product');
    	  
    	  checkboxes.forEach((checkbox) => {
    	    checkbox.checked =  selectAll.checked;
    	  })
    	  
    	}
      	
      </script>
      
      </td>
      <td>10,000 원</td>
    </tr>
 
 
  </tbody>
</table>

<%-- <div style="margin:0 auto; text-align: center; margin-top: 30px">
<button type="button" class="btn btn-secondary"  >삭제</button>&nbsp;&nbsp;&nbsp; --%>
<%-- <div id="BuyBtn" style="display: inline-block;" 
 >구매하기</div>--%>
<div style="margin:0 auto; text-align: center; margin-top: 20px">
 <button type="submit" id="removeBtn" style="background-color:black; color: white; 
 border-radius: 5px; width: 60px; height: 35px;  ">삭제</button>
 <button type="submit" id="addBtn" style="background-color:black; color: white; 
 border-radius: 5px; width: 60px; height: 35px;  ">등록</button>
</div>
</form>


</body>
</html>