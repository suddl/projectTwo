<%@page import="java.util.List"%>
<%@page import="xyz.nailro.dto.CartDTO"%>
<%@page import="xyz.nailro.dao.CartDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
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

#ProductList{
	width: 60%;
}

</style>

<%@include file="/security/login_url.jspf"%>

<%
//회원번호
int Num = loginClient.getClientNum();
//System.out.println("회원번호="+Num);

List<CartDTO> cartDTOs = CartDAO.getDAO().selectCartList(Num);
//System.out.println("dto객체="+cartDTOs.size());


request.setCharacterEncoding("utf-8");

//상세페이지에서 히든으로 상품아이디 값을 받아오기
//String productNum = request.getParameter("productNum");
//String quantity = request.getParameter("quantity");

//받아온 상품값으로 DAO를 이용해 해당 상품 정보를 찾아 장바구니id 생성 후 같이 저장
//String sangpumId = request.getParameter("inputValue");

//총 상품계산금액
int total = 0; 

%> 



<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<link href="<%=request.getContextPath()%>/css/header.css" type="text/css" rel="stylesheet">

</head>
<body>
<h1>장바구니</h1>

<div width="60%">
<table class="table table-hover" id="ProductList">
  <thead>
    <tr>
    <div style="margin-right: 1120px; ">전체선택</div>
      <th ><input type="checkbox" name="productAll" id="selectAllCheckbox" onclick='selectAll(this)' ></th>
      <th >상품명</th>
      <th >수량</th>
      <th >가격</th>
    </tr>
  </thead>
  
  <form action="<%=request.getContextPath() %>/index.jsp?group=order&worker=order_main"
   method="post" id="orderForm" name="orderForm" >
  
  <%for(CartDTO carts : cartDTOs) { %>
  <tr>
  	<%-- 체크박스 --%>
    <th width="10%"><input type="checkbox" name="productOne"  class="ckb" onclick='selectOnly(this)' ></th>
    
  	<%-- 이미지 --%>
     <th width="30%"><img src="<%=request.getContextPath()%><%=carts.getCartProductImages()%>" width="150" height="100"> <%=carts.getCartProductName() %></th>
     
     <%-- 수량 --%>
     <th ><%=carts.getCartQuantity() %>개</th>
     
     <%
     total += Integer.parseInt(carts.getCartProductPrice()) * Integer.parseInt(carts.getCartQuantity());
     	String priceP = String.format("%,d",Integer.parseInt(carts.getCartProductPrice()) * Integer.parseInt(carts.getCartQuantity())); 
      %>
		     
     <th ><%=priceP %>원</th>
  
  </tr>
  <% } %>
</table>
</div>

<div style="border: 1px solid black; border-radius: 20px;  width: 30%; margin:0 auto; background-color: #DCDCDC; margin-top:30px;
padding: 30px;">
<p class="money" > 총 상품금액 </p> <span class="NumMoney"> <%=String.format("%,d", total)%> 원</span>
 
<p class="money" > 배송비</p><span class="NumMoney" >
 <% if(total>=50000){ %> 
		0 원
<% 	}else{ %>
		3,000원
	<% } %>
 
 </span>
<hr>

<p class="moneyALL" >총 결제 금액</p><span class="NumMoneyALL" >
<% if(total>=50000){ %>
		<%=String.format("%,d", total)%> 원
<% 	}else{ %>
		<%=String.format("%,d", (total+3000))%> 원
	<% } %>
</span>

</div>

<div style="margin:0 auto; text-align: center; margin-top: 30px">
<button type="button" class="btn btn-secondary"  >쇼핑계속하기</button>&nbsp;&nbsp;&nbsp;
<%-- <div id="BuyBtn" style="display: inline-block;" 
 >구매하기</div>--%>
 <button type="submit" style="background-color:black; color: white; 
 border-radius: 5px; width: 120px; height: 40px;  ">구매하기</button>
</div>
</form>
<script>
//전체선택체크박스를 클릭하면 해당 엘리먼트가 source에 대입
function selectAll(source) {
	//개별체크박스의 이름을 가져와 변수에 저장
    var checkboxOnes = document.getElementsByName('productOne');
    //반복문을 통해 생성된 이름이 같은 여러개의 체크박스들의 길이만큼 반복
    for (var i = 0; i < checkboxOnes.length; i++) {
		//i번째 체크박스의 상태를 최초 선택한체크박스 엘리먼트의 체크된상태로 바꾼다
        checkboxOnes[i].checked = source.checked;
    }
}

	/*
const checkboxes = document.querySelectorAll(.chk);
const totalCnt = checkboxes.length;
const checkedCnt = document.querySelectorAll('.chk:cheked').length;
for(i=0; i<totalCntl i++)

if(totalCnt == checkedCnt){
	document.querySelector('#selectAllCheckbox').checked=true;
	
}else{
	document.querySelector('#selectAllCheckbox').checked=false;
}
	*/

function selectOnly(source) {
	
	
	//전체선택체크박스를 변수에 저장
    let selectAllCheckbox = document.getElementById('selectAllCheckbox');
    //선택한 체크박스가 체크된 상태라면
    if (source.checked) {
		//true를 변수에 저장
        let allChecked = true;
		//개별체크박스의 객체를 변수에 저장
        let checkboxes = document.getElementsByName('productOne');
		
		//화면에 나타나는 체크박스의 수 만큼 반복문을 실행
        for (let i = 0; i < checkboxes.length; i++) {
			//체크박스가 체크되지 않은 상태라면
            if (!checkboxes[i].checked) {//!checkboxes[i].checked => 개별체크박스의 상태가 체크되어있지 않다면
                //전체선택변수에 false를 저장하고
            	allChecked = false;
            	//반복문을 종료
                break;
            }
        }
		//개별체크박스의 체크가 전부 되어있다면 allCheck에 true가 저장되어 
		//전체 체크박스가 체크 될것이다.
        selectAllCheckbox.checked = allChecked;
    } else {
		//선택한 개별체크박스가 체크해제 된다면 전체체크박스의 체크상태 또한 해제된다.
        selectAllCheckbox.checked = false;
    }
}
    </script>

</body>
</html>