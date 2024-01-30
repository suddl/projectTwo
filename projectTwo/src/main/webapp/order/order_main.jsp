<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>

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
<fieldset>
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
      <th scope="col"><input type="checkbox" name="product" value="selectAll" onclick='selectAll(this)' ></th>
      <th scope="col">상품명</th>
      <th scope="col">수량</th>
      <th scope="col">가격</th>
    </tr>
  </thead>
  <%
  	
  %>
  <tbody>
    <tr>
      <th scope="row">
      <input type="checkbox" name="product" >
      </th>
      <td>이미지&nbsp;&nbsp; 상품명</td>
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
    	  
    	  checkboxes.forEach(function(checkbox) {
    		    checkbox.checked = selectAll.checked;
    		});
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


<div style="border: 1px solid black; border-radius: 20px;  width: 100%; margin:0 auto; background-color: #DCDCDC; margin-top: 50px;
padding: 30px;">
<p class="money" > 총 상품금액 </p> <span class="NumMoney"> 20,000 원</span>
 
<p class="money" > 배송비</p><span class="NumMoney" > 3,000 원</span>
<hr>

<p class="moneyALL" >총 결제 금액</p><span class="NumMoneyALL" > 23,000 원</span>

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
	
	
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">


const nonClick = document.querySelectorAll(".non-click");

function handleClick(event) {
  // div에서 모든 "click" 클래스 제거
  nonClick.forEach((e) => {
    e.classList.remove("click");
  });
  // 클릭한 div만 "click"클래스 추가
  event.target.classList.add("click");
}

nonClick.forEach((e) => {
  e.addEventListener("click", handleClick);
});





$("#postSearch").click(function() {
	new daum.Postcode({
		oncomplete: function(data) {
			$("#zipcode").val(data.zonecode);
			$("#address1").val(data.address);
		} 
	}).open();
});
</script>