<%-- 바로구매를 클릭시 이동하는 주문페이지 --%>
<%@page import="java.util.List"%>
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
//회원번호
int Num = loginClient.getClientNum();
//System.out.println("회원번호="+Num);

CartDTO cartDTOs = CartDAO.getDAO().selectClientInfo(Num);
//System.out.println("dto객체="+cartDTOs.size());
	

%>
<ul>
  <li>
    <input type="checkbox" id="usedAddress" name="useAddress" checked>
    <label for="usedAddress">기존 주소 사용</label>
  </li>
  <li>
    <input type="checkbox" id="newAddress" name="useAddress">
    <label for="newAddress">새로운 배송지</label>
  </li>
</ul>

<fieldset>
<form action="<%=request.getContextPath() %>/index.jsp?group=order&worker=PaymentFinish"
   method="post" id="orderForm" name="orderForm" >
   <input type="hidden" name="clientNum" value="<%= Num %>">
	<h3 style="text-align: center;">주문 고객 정보</h3>
	<ul>
		<li>
			<label for="name">이름</label>
			<input type="text" name="name" id="name" value="<%=cartDTOs.getClientName()%>">
			<div id="nameMsg" class="error">이름을 입력해 주세요.</div>
		</li>
		<li>
			<label>우편번호</label>
			<input type="text" name="zipcode" id="zipcode" size="7" readonly="readonly" value="<%=cartDTOs.getClientZipCode()%>">
			<span id="postSearch">우편번호 검색</span>
			<div id="zipcodeMsg" class="error">우편번호를 입력해 주세요.</div>
		</li>
		<li>
			<label for="address1">기본주소</label>
			<input type="text" name="address1" id="address1" size="50" readonly="readonly" value="<%=cartDTOs.getClientAddress1()%>">
			<div id="address1Msg" class="error">기본주소를 입력해 주세요.</div>
		</li>
		<li>
			<label for="address2">상세주소</label>
			<input type="text" name="address2" id="address2" size="50" value="<%=cartDTOs.getClientAddress2()%>">
			<div id="address2Msg" class="error">상세주소를 입력해 주세요.</div>
		</li>
		<li>
			<label for="mobile2">전화번호</label>
			<input type="text" name="mobile2" id="mobile2" size="13" maxlength="13" value="<%=cartDTOs.getClientPhone()%>">
			<div id="mobileMsg" class="error">전화번호를 입력해 입력해 주세요.</div>
			<div id="mobileRegMsg" class="error">전화번호는 3~4 자리의 숫자로만 입력해 주세요.</div>
		</li>
		<li>
			<label for="email">이메일</label>
			<input type="text" name="email" id="email" value="<%=cartDTOs.getClientEmail()%>">
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
  	//상품명
  	String DirproductName = request.getParameter("DirproductName");
  
  	//상품수량
	String ReceiveCarQuantity = request.getParameter("ReceiveCarQuantity");
	
  	//상품금액
	String DirtotalPrice = request.getParameter("DirtotalPrice");
  	

  	//상품사진
	String DirImage = request.getParameter("DirImage");
	
  	//상품번호
  	String productNum = request.getParameter("productNum");
  	
  	
  	
  	
  %>
  <tbody>
  
  
    -
    <tr class="hang">
      <input type="hidden" name="DirectComple" value="1"><%-- direct확인 --%>
    
    
      <%--이미지 및 상품명 --%>
      <td><img src="<%= DirImage%>" width="150" height="100">
      <%= DirproductName %>
      
      <%-- 상품번호 --%>
      <input type="hidden" name="productNum" value="<%= productNum %>"><%-- 상품번호 --%>
      
      <%--수량 --%>
      <td>
      <%=ReceiveCarQuantity%> 개
      </td>
       <input type="hidden" name="productQuan" value="<%=ReceiveCarQuantity%>"><%-- 수량 --%>
      <%--가격 --%>
      <td id="EndCash"><%= DirtotalPrice %> 원&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      	<button type="button" class="delete-btn" style="background-color: white; border: none;" >
           <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-trash3" viewBox="0 0 16 16">
 			 <path d="M6.5 1h3a.5.5 0 0 1 .5.5v1H6v-1a.5.5 0 0 1 .5-.5ZM11 2.5v-1A1.5 1.5 0 0 0 9.5 0h-3A1.5 1.5 0 0 0 5 1.5v1H2.506a.58.58 0 0 0-.01 0H1.5a.5.5 0 0 0 0 1h.538l.853 10.66A2 2 0 0 0 4.885 16h6.23a2 2 0 0 0 1.994-1.84l.853-10.66h.538a.5.5 0 0 0 0-1h-.995a.59.59 0 0 0-.01 0H11Zm1.958 1-.846 10.58a1 1 0 0 1-.997.92h-6.23a1 1 0 0 1-.997-.92L3.042 3.5h9.916Zm-7.487 1a.5.5 0 0 1 .528.47l.5 8.5a.5.5 0 0 1-.998.06L5 5.03a.5.5 0 0 1 .47-.53Zm5.058 0a.5.5 0 0 1 .47.53l-.5 8.5a.5.5 0 1 1-.998-.06l.5-8.5a.5.5 0 0 1 .528-.47ZM8 4.5a.5.5 0 0 1 .5.5v8.5a.5.5 0 0 1-1 0V5a.5.5 0 0 1 .5-.5Z"/>
			</svg>
        </button> 
	</td>
    </tr>
  </tbody>
</table>


<div style="border: 1px solid black; border-radius: 20px;  width: 100%; margin:0 auto; background-color: #DCDCDC; margin-top: 50px;
padding: 30px;">
<p class="money" > 총 상품금액 </p>
 <span class="NumMoney" id="totalAmount"><%=  DirtotalPrice %>원 </span>
 
 
<p class="money" > 배송비</p>
	<span class="NumMoney" id="delivery" >
	<%--최초 화면출력시 배송비 출력 --%>
	<% 
	
	String newStringValue = DirtotalPrice.replaceAll("[@$,^]", "");
	
	int DirtotalPricess =Integer.parseInt(newStringValue); 
	
	if(DirtotalPricess>=50000){ %> 
		0 원
<% 	}else{ %>
		3,000 원
	<% } %>
	</span> 
<hr>

<p class="moneyALL" >총 결제 금액</p><span class="NumMoneyALL" id="totalpayment"><%= DirtotalPrice %>원 </span>
<input type="hidden" name="finalMoney" id="finalMoney" value="<%= DirtotalPrice %>">
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
  <input type="checkbox" id="method1" name="payments" onclick='checkOnlyOne(this)' value="페이코">&nbsp;&nbsp페이코</input><br>
  <input type="checkbox" id="method2" name="payments" onclick='checkOnlyOne(this)' value="토스">&nbsp;&nbsp;토스</input><br>
  <input type="checkbox" id="method3" name="payments" onclick='checkOnlyOne(this)' value="카카오페이">&nbsp;&nbsp;카카오페이</input><br>
  <input type="checkbox" id="method4" name="payments" onclick='checkOnlyOne(this)' value="네이버페이">&nbsp;&nbsp;네이버페이</input><br>
  <input type="checkbox" id="method5" name="payments" onclick='checkOnlyOne(this)' value="신용카드 결제">&nbsp;&nbsp;신용카드 결제</input><br>
  <input type="checkbox" id="method6" name="payments" onclick='checkOnlyOne(this)' value="가상계좌">&nbsp;&nbsp;가상계좌</input><br>
  <input type="checkbox" id="method7" name="payments" onclick='checkOnlyOne(this)' value="휴대폰 결제" checked>&nbsp;&nbsp;휴대폰결제</input><br>
  <input type="hidden" id="checkedPayment" name="checkedPayment" value="휴대폰 결제">
  </div>
	
	<button type="submit" id="FinishCash">결제하기</button>
	
	</form>
	</fieldset>
	
	
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">

//결제수단 체크하나만 될 수있도록
function checkOnlyOne(element) {
	  
	  const checkboxes 
	      = document.getElementsByName("payments");
	  
	  
	  for (let i = 0; i < checkboxes.length; i++) {
  			checkboxes[i].checked = false;
		}
	  
	  element.checked = true;
	  
	  
	 
	  
	  let result = element.checked ? element.value : "";
	  $("#checkedPayment").val(result);
	  
	}

$(document).ready(function() {
    // "기존주소" 체크박스 클릭 이벤트
    //on함수를 이용해 change 함수와 연결
    //change 함수를 통해 $("#usedAddress") 즉 체크박스의 값이 변화가 생기면
    // 등록한 콜백함수 실행
    $("#usedAddress").on("change", function() {
	//is함수를 사용하여 선택한 체크박스가 체크된 상태인지 확인한다.
	//$(this)의 속성값이 (":checked") 체크된 상태인지 결과는 true와 false로 반환
      if ($(this).is(":checked")) {
    	   // "기존 주소" 사용 체크되면 "새로운 배송지" 체크 해제
    	   //checked 속성이 프로퍼티이기 때문에, jQuery에서 속성을 조작할땐 prop 사용 
    	   //attr 사용 불가는 아님 하지만 사용했을시 한쪽 체크박스가 해제될때 해제가 안될 수 있다
    	   //즉 동기화되지 않을 수 있다.
          $("#newAddress").prop("checked", false);
    	  
        // 체크되었을 때 기존 주소 정보를 입력 폼에 설정
        $("#name").val("<%=cartDTOs.getClientName()%>");
        $("#zipcode").val("<%=cartDTOs.getClientZipCode()%>");
        $("#address1").val("<%=cartDTOs.getClientAddress1()%>");
        $("#address2").val("<%=cartDTOs.getClientAddress2()%>");
        $("#mobile2").val("<%=cartDTOs.getClientPhone()%>");
        $("#email").val("<%=cartDTOs.getClientEmail()%>");
      } else {
        // 체크가 해제되었을 때 입력 폼 초기화
        $("#name, #zipcode, #address1, #address2, #mobile2, #email").val("");
      }
    });

    // "새로운 배송지" 체크박스 클릭 이벤트
    $("#newAddress").on("change", function() {
	//새로운배송지의 체크박스가 체크 된 상태라면
      if ($(this).is(":checked")) {
    	//"기존 주소" 체크 해제
          $("#usedAddress").prop("checked", false);
        // 체크되었을 때 입력 폼 초기화
        $("#name, #zipcode, #address1, #address2, #mobile2, #email").val("");
      }
    });
    
    
    
    
  });



//x버튼 클릭시 해당 행 삭제
	  $(document).ready(function() {
          $(document).on("click", ".delete-btn", function() {
              // 현재 버튼이 속한 가장 가까운 tr 행을 찾아서 
              var row = $(this).closest("tr");
              //삭제
              row.remove();
              
            // 삭제된 상품 가격을 차감
            //id가 EndCash인 행을 찾아 0~9까지를 제외한 나머지를 빈문자열로 대체하여 숫자를
            //제외한 나머지를 제거 후 정수로 변환
            var itemTotal = parseInt(row.find("#EndCash").text().replace(/[^0-9]/g, ""));
              
            //총상품금액을 정수로 변환, 숫자를 제외한 나머지 문자 삭제
            var currentTotal = parseInt($("#totalAmount").text().replace(/[^0-9]/g, ""));
            var newTotal = currentTotal - itemTotal;;
            
            //toLocaleString()을 통해 숫자사이에 ,을 찍어 쉽게 구분 10000-> 10,000
              $("#totalAmount").text(newTotal.toLocaleString() + "원");
              
              // 총 구매금액이 50000원을 넘는 경우 배송비는 0원, 그렇지 않으면 3000원
              var shippingFee = newTotal > 50000 ? 0 : 3000;
				
              $("#delivery").text(shippingFee.toLocaleString()+"원");
              // 배송비 적용하여 결제금액 갱신
              var finalTotal = newTotal + shippingFee;
              $("#totalpayment").text(finalTotal.toLocaleString() + "원");
              $("#finalMoney").val(finalTotal);
          });
      });

</script>