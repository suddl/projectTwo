<%@page import="xyz.nailro.dao.CartDAO"%>
<%@page import="xyz.nailro.dto.CartDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<link href="<%=request.getContextPath()%>/css/header.css" type="text/css" rel="stylesheet">
<style type="text/css">
fieldset {
	text-align: left;
	margin: 10px auto;
	width: 1100px;
}

legend {
	font-size: 1.2em; 
}

 label {
	width: 150px;
	text-align: right;
	float: left;
	margin-right: 10px;
}

ul li {
	list-style-type: none;
	margin: 15px 0;
}


.error {
	color: red;
	position: relative;
	left: 160px;
	display: none;
}

#idCheck, #postSearch {
	font-size: 12px;
	font-weight: bold;
	cursor: pointer;
	margin-left: 10px;
	padding: 2px 10px;
	border: 1px solid black;
}

#idCheck:hover, #postSearch:hover {
	background: black;
	color: white;
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

.selected-td {
   background-color: black; /* 변경할 배경색 */
   color: white;
 }
 
 .non-click {
  background-color: white;
}

.click {
  background-color: black;
  color: white;
}

#FinishCash{
width: 500px;
height: 50px;
background-color: black;
color: white;
position: fixed;
bottom: 0px;
left: 35%;
text-align: center;
vertical-align: middle;
font-size: x-large;
padding: 5px;
}

</style>
<%@include file="/security/login_url.jspf"%>
<%
/*
	String proNum = request.getParameter("proNum");
	String proQun = request.getParameter("proQun");
	//String[] name = request.getParameterValues("selectedItems");
System.out.println("전달값품번="+proNum);
System.out.println("전달값수량="+proQun);
*/
	
	

%>
<fieldset>
<form action="<%=request.getContextPath() %>/index.jsp?group=order&worker=order_main"
   method="post" id="orderForm" name="orderForm" >
	<h3 style="text-align: center;">주문 고객 정보</h3>
	<ul>
		<li>
			<label for="name">이름</label>
			<input type="text" name="name" id="name">
			<div id="nameMsg" class="error">이름을 입력해 주세요.</div>
		</li>
		<li>
			<label>우편번호</label>
			<input type="text" name="zipcode" id="zipcode" size="7" readonly="readonly">
			<span id="postSearch">우편번호 검색</span>
			<div id="zipcodeMsg" class="error">우편번호를 입력해 주세요.</div>
		</li>
		<li>
			<label for="address1">기본주소</label>
			<input type="text" name="address1" id="address1" size="50" readonly="readonly">
			<div id="address1Msg" class="error">기본주소를 입력해 주세요.</div>
		</li>
		<li>
			<label for="address2">상세주소</label>
			<input type="text" name="address2" id="address2" size="50" >
			<div id="address2Msg" class="error">상세주소를 입력해 주세요.</div>
		</li>
		<li>
			<label for="mobile2">전화번호</label>
			<select name="mobile1">
				<option value="010" selected>&nbsp;010&nbsp;</option>
				<option value="011">&nbsp;011&nbsp;</option>
				<option value="016">&nbsp;016&nbsp;</option>
				<option value="017">&nbsp;017&nbsp;</option>
				<option value="018">&nbsp;018&nbsp;</option>
				<option value="019">&nbsp;019&nbsp;</option>
			</select>
			- <input type="text" name="mobile2" id="mobile2" size="4" maxlength="4">
			- <input type="text" name="mobile3" id="mobile3" size="4" maxlength="4">
			<div id="mobileMsg" class="error">전화번호를 입력해 입력해 주세요.</div>
			<div id="mobileRegMsg" class="error">전화번호는 3~4 자리의 숫자로만 입력해 주세요.</div>
		</li>
		<li>
			<label for="email">이메일</label>
			<input type="text" name="email" id="email">
			<div id="emailMsg" class="error">이메일을 입력해 주세요.</div>
			<div id="emailRegMsg" class="error">입력한 이메일이 형식에 맞지 않습니다.</div>
		</li>
	</ul>
	
	<label>배송요청사항</label>
	<select name="CustomOrder" style="width: 500px; margin-bottom: 30px;">
			<option value="1" selected>&nbsp;부재 시 경비실에 맡겨주세요.&nbsp;</option>
			<option value="2">&nbsp;배송전에 미리 연락바랍니다.&nbsp;</option>
			<option value="3">&nbsp;부재 시 문앞에 놓아주세요.&nbsp;</option>
			<option value="4">&nbsp;빠른배송부탁드립니다.&nbsp;</option>
			<option value="5">&nbsp;택배함에 보관해주세요&nbsp;</option>
	</select>
	<hr>
	<h3 style="text-align: center; margin-bottom: 30px; margin-top: 30px;">주문 상품</h3>
	
	<table class="table" >
  <thead>
  
    <tr>
      <th scope="col" style="text-align: center">상품명</th>
      <th scope="col">수량</th>
      <th scope="col">가격</th>
    </tr>
  </thead>
  <%
  	//상품수량들
	String proQun = request.getParameter("proQun");
	//회원번호 저장
    int CNum = loginClient.getClientNum();
  	//상품번호들
	String proNum = request.getParameter("proNum");
	//System.out.println("전달값품번="+proNum);
	//System.out.println("전달값수량="+proQun);
	
    
		String[] proNumResult = proNum.split(",");
		String[] proQunResult = proQun.split(",");
		
      //System.out.println("주소"+request.getContextPath());//주소/projectTwo

      String proQunFN = null;
      int total = 0;
  %>
  <tbody>
  
  
      <%for(int i = 0; i<proNumResult.length; i++) { 
      //System.out.println("하나씩구분하여저장"+proNumResult[i]);
      
      //proNumResult의 i번쨰 숫자를 정수로 변환
      int proNums = Integer.parseInt(proNumResult[i]); 
      CartDTO cartDTO =  CartDAO.getDAO().selectCheckCart(proNums, CNum);
      //itemTotal 변수에 수량과 상품가격을 곱해서 상품의 최종가격을 저장
      int itemTotal = Integer.parseInt(cartDTO.getCartProductPrice()) * Integer.parseInt(proQunResult[i]);
      //각 상품의 최종가격을 변수에 더하여 저장하면 총 상품금액을 알 수 있다.
      total += itemTotal;
      %>
    <tr class="hang">
      <%--이미지 및 상품명 --%>
      <td><img src="<%=request.getContextPath()%><%=cartDTO.getCartProductImages()%>" width="150" height="100">
       <%=cartDTO.getCartProductName() %></td>
      <%--수량 --%>
      <td>
      <%=proQunResult[i] %> 개
      </td>
      <%--가격 --%>
      <td id="EndCash"><%= String.format("%,d", itemTotal) %> 원&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      	<button type="button" class="bi bi-x-lg delete-btn">
           <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-x-lg" viewBox="0 0 16 16">
                <path d="M2.146 2.854a.5.5 0 1 1 .708-.708L8 7.293l5.146-5.147a.5.5 0 0 1 .708.708L8.707 8l5.147 5.146a.5.5 0 0 1-.708.708L8 8.707l-5.146 5.147a.5.5 0 0 1-.708-.708L7.293 8 2.146 2.854Z"/>
           </svg>
        </button> 
	</td>
    </tr>
    <% } %>
  </tbody>
</table>


<div style="border: 1px solid black; border-radius: 20px;  width: 100%; margin:0 auto; background-color: #DCDCDC; margin-top: 50px;
padding: 30px;">
<p class="money" > 총 상품금액 </p>
 <span class="NumMoney" id="totalAmount"><%= String.format("%,d", total) %>원 </span>
 
 
<p class="money" > 배송비</p>
	<span class="NumMoney" id="delivery" >
	<%--최초 화면출력시 배송비 출력 --%>
	<% if(total>=50000){ %> 
		0 원
<% 	}else{ %>
		3,000 원
	<% } %>
	</span> 
<hr>

<p class="moneyALL" >총 결제 금액</p><span class="NumMoneyALL" id="totalpayment"><%= String.format("%,d", total) %>원 </span>

  <%-- 결제방법 선택 --%>
</div>
<br>
<hr>
<br>
<div class="form-check">
  <input class="form-check-input" type="radio" name="exampleRadios" id="exampleRadios1" value="option1" checked>
  <label class="form-check-label" for="exampleRadios1">결제수단</label>
  </div>
  
  <div id="cash">
  <table style="width: 700px;" >
  	<tr class="chas1">
  		<td class="box non-click" id="first" style="border: 1px solid black; padding: 20px; text-align: center;" ><a >페이코</a></td>
  		<td class="box non-click" id="second" style="border: 1px solid black; padding: 20px; text-align: center;">카카오페이</td>
  	</tr>
  	<tr class="chas1" onclick="backChange(this,2)">
  		<td class="box non-click" style="border: 1px solid black; padding: 20px; text-align: center;">토스</td>
  		<td class="box non-click" style="border: 1px solid black; padding: 20px; text-align: center;">신용카드 결제</td>
  	</tr>
  	<tr class="chas1">
  		<td  class="box non-click" style="border: 1px solid black; padding: 20px; text-align: center;">네이버페이</td>
  		<td class="box non-click" style="border: 1px solid black; padding: 20px; text-align: center;">가상계좌</td>
  	</tr>
  	<tr class="chas1">
  		<td class="box non-click" style="border: 1px solid black; padding: 20px; text-align: center;">휴대폰 결제</td>
  	</tr>
  	
  	
  </table>
  </div>
	
	<div id="FinishCash">결제하기</div>
	</fieldset>
	</form>
	
	
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">

//x버튼 클릭시 해당 행 삭제
	  $(document).ready(function() {
          $(document).on('click', '.delete-btn', function() {
              // 현재 버튼이 속한 가장 가까운 tr 행을 찾아서 
              var row = $(this).closest('tr');
              //삭제
              row.remove();
              
            // 삭제된 상품 가격을 차감
            //id가 EndCash인 행을 찾아 0~9까지를 제외한 나머지를 빈문자열로 대체하여 숫자를
            //제외한 나머지를 제거 후 정수로 변환
            var itemTotal = parseInt(row.find("#EndCash").text().replace(/[^0-9]/g, ''));
              
            //총상품금액을 정수로 변환, 숫자를 제외한 나머지 문자 삭제
            var currentTotal = parseInt($('#totalAmount').text().replace(/[^0-9]/g, ''));
            var newTotal = currentTotal - itemTotal;;
            
            //toLocaleString()을 통해 숫자사이에 ,을 찍어 쉽게 구분 10000-> 10,000
              $('#totalAmount').text(newTotal.toLocaleString() + '원');
              
              // 총 구매금액이 50000원을 넘는 경우 배송비는 0원, 그렇지 않으면 3000원
              var shippingFee = newTotal > 50000 ? 0 : 3000;
				
              $("#delivery").text(shippingFee.toLocaleString()+"원");
              // 배송비 적용하여 결제금액 갱신
              var finalTotal = newTotal + shippingFee;
              $("#totalpayment").text(finalTotal.toLocaleString() + '원');
          });
      });

</script>