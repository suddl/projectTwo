<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%

request.setCharacterEncoding("utf-8");

//상세페이지에서 히든으로 상품아이디 값을 받아오기
String sangpumId = request.getParameter("inputValue");

//받아온 상품값으로 DAO를 이용해 해당 상품 정보를 찾아 장바구니id 생성 후 같이 저장



%>
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
margin-bottom: 50px;
}

#MinBtn{
display: inline-block; 
 width: 30px;
 text-align: center; 
 font-weight: bold;
 border: 1px solid gray;
 
}

#PlusBtn{
display: inline-block; 
 width: 30px;
 text-align: center; 
 font-weight: bold;
 border: 1px solid gray;
 
}

.money{
display: inline-block;
font-size: 17px;
font-weight: normal;
}

.NumMoney{
 text-align: right;
 display: inline-block;
 width: 100%; 
 font-size: 17px;
font-weight: normal;
}

.moneyALL{
display: inline-block;
font-size: 17px;
font-weight: bold;
} 

.NumMoneyALL{
 text-align: right;
 display: inline-block;
 width: 100%; 
 font-size: 17px;
font-weight: 800;
}

table{
border: 1px solid #DCDCDC;
}

#BuyBtn {
	margin: 0 auto;
	padding: 5px;
	width: 200px;
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
<h1>장바구니</h1>

<table class="table" >
  <thead>
  
    <tr>
      <th scope="col"><input type="checkbox" name="product" value="selectAll" onclick='selectAll(this)' ></th>
      <th scope="col">상품명</th>
      <th scope="col">수량</th>
      <th scope="col">가격</th>
    </tr>
  </thead>
  <%
  	
  %>
  <form action="<%=request.getContextPath() %>/index.jsp?group=order&worker=order_main"
   method="post" id="orderForm" name="orderForm" >
  <tbody>
    <tr>
      <th scope="row">
      <input type="checkbox" name="product" >
      </th>
      <td>이미지&nbsp;&nbsp; <%=sangpumId %></td>
      <td>
      <div>
      <button id="MinBtn" onclick="countZero();">-</button>
  	<p id="count1" style="display: inline-block;">1</p>
      <button id="PlusBtn" onclick="countUp();">+</button>
  	</div>
      <script type="text/javascript">
          var count=1;

          var countUp=function(){
              count=count+1;
              document.querySelector("#count1").innerText=count;
          };
          
          //0이하로 안내려가는 버튼
          var countZero=function(){
          	if(count>1){
          	count=count-1;
          	document.querySelector("#count1").innerText=count;
          	}
          	
          };
      </script>
      
      </td>
      <td>10,000 원</td>
    </tr>
    
     <tr>
      <th scope="row">
      <input type="checkbox" name="product" >
      </th>
      <td>이미지&nbsp;&nbsp; 상품명</td>
      <td>
      <div>
      <button id="MinBtn" onclick="countZero2();">-</button><%-- 메소드명끝에 상품no 넣기 --%>
  	<p id="count2" style="display: inline-block;">1</p>
      <button id="PlusBtn" onclick="countUp2();">+</button>
  	</div>
  	
      <script type="text/javascript">
      	//전체선택
      	function selectAll(selectAll)  {
    	  const checkboxes = document.getElementsByName('product');
    	  
    	  checkboxes.forEach((checkbox) => {
    	    checkbox.checked =  selectAll.checked;
    	  })
    	  
    	}
      
      	
          var count2=1;

          var countUp2=function(){
              count2=count2+1;
              document.querySelector("#count2").innerText=count2;
          };
          
          //0이하로 안내려가는 버튼
          var countZero2=function(){
          	if(count2>1){
          	count2=count2-1;
          	document.querySelector("#count2").innerText=count2;
          	}
          	
          };
      </script>
      
      </td>
      <td>10,000 원</td>
    </tr>
 
 
  </tbody>
</table>

<div style="border: 1px solid black; border-radius: 20px;  width: 30%; margin:0 auto; background-color: #DCDCDC; margin-top:30px;
padding: 30px;">
<p class="money" > 총 상품금액 </p> <span class="NumMoney"> 20,000 원</span>
 
<p class="money" > 배송비</p><span class="NumMoney" > 3,000 원</span>
<hr>

<p class="moneyALL" >총 결제 금액</p><span class="NumMoneyALL" > 23,000 원</span>

</div>

<div style="margin:0 auto; text-align: center; margin-top: 30px">
<button type="button" class="btn btn-secondary"  >쇼핑계속하기</button>&nbsp;&nbsp;&nbsp;
<%-- <div id="BuyBtn" style="display: inline-block;" 
 >구매하기</div>--%>
 <button type="submit" style="background-color:black; color: white; 
 border-radius: 5px; width: 120px; height: 40px;  ">구매하기</button>
</div>
</form>


</body>
</html>