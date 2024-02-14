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


String productNum = request.getParameter("productNum");


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
<%-- 폼시작00000000000000000000000000000000000000000000000000000000 --%>
  <form action="<%=request.getContextPath() %>/index.jsp?group=cart&worker=cart_remove_action"
   method="post" id="hangForm" name="hangForm" >
    <input type="hidden" name="url" id="url2">
    <input type="hidden" name="WChoice" id="WChoice" value=""/>
   
   
<div width="60%">
<table class="table table-hover" id="ProductList">
  <thead>
    <tr>
      <th ><input type="checkbox" name="productAll" id="selectAllCheckbox" onclick='selectAll(this)' checked>  전체선택</th> 
      <th >상품명</th>
      <th >수량</th>
      <th >가격</th>
    </tr>
  </thead>
  
  <%-- 상품목록 출력 --%>
  <%for(int i=0; i<cartDTOs.size();i++) { %>
       <input type="hidden" name="selectedItemsInput" id="selectedItemsInput"  />
       <input type="hidden" name="selectedItemsInputQuan" id="selectedItemsInputQuan"  />
  <tr class="hang" id="hang("+<%=i %>+")" >
  	
  
  	
  	<%-- 체크박스 --%>
    <th width="10%"><input type="checkbox" name="productOne"  id="productOne" value="<%=cartDTOs.get(i).getCartProduct() %>" onclick="selectOnly(this)" checked></th>
    
  	<%-- 이미지 --%>
     <th width="30%"><img src="<%=request.getContextPath()%><%=cartDTOs.get(i).getCartProductImages()%>"  width="150" height="100" > 
     <%=cartDTOs.get(i).getCartProductName() %></th>
  	<input type="hidden" id="productNum" name="productNum" value="<%=cartDTOs.get(i).getCartProduct() %>">
     
     <%-- 수량 --%>
     <th >
     <button type="button" class="minusBtn" onclick="countDown(<%=i%>);">-</button>&nbsp;&nbsp;
    <input type="text" id="cartQuantity<%=i%>" name="cartQuantity" style="width:30px;" readonly="readonly" value="<%=cartDTOs.get(i).getCartQuantity()%>"> 개
    <button type="button" class="plusBtn" onclick="countUp(<%=i%>);">+</button>
     
     </th>
     
     
     <%
     total += Integer.parseInt(cartDTOs.get(i).getCartProductPrice()) * Integer.parseInt(cartDTOs.get(i).getCartQuantity());
     
	String priceP = String.format("%,d",Integer.parseInt(cartDTOs.get(i).getCartProductPrice()) * Integer.parseInt(cartDTOs.get(i).getCartQuantity())); 
      %>
		     
		<input type="hidden" id="Cash2<%=i%>" name="" value="<%= cartDTOs.get(i).getCartProductPrice()%>">
     <th id="Cash<%=i%>"><%=priceP %>원</th>
  
     
     
  </tr>
  <% } %>
</table>

</div>
</form>

<%-- 선택삭제버튼--------------------------------------------------------------------------- --%>
<button type="button" id="GoRemove" style="margin-right: 1050px;" value="">선택삭제</button>

<%-- 선택삭제버튼--------------------------------------------------------------------------- --%>

<div style="border: 1px solid black; border-radius: 20px;  width: 30%; margin:0 auto; background-color: #DCDCDC; margin-top:30px;
padding: 30px;">
<p class="money" >총 상품금액 </p> <span id="NumMoney">  <%=String.format("%,d", total)%> 원</span><br>
 
<p class="money" > 배송비</p> <span id="transMoney" >
 <% if(total>=50000){ %> 
		0 
<% 	}else{ %>
		3,000
	<% } %>
 
 </span> 원
<hr>

<%-- 결제금액 출력 --%>
<p class="moneyALL" id="moneyALL">총 결제 금액</p><span id="NumMoneyALL" >
<% if(total>=50000){ %>
		<%=String.format("%,d", total)%> 원
<% 	}else{ %>
		<%=String.format("%,d", (total+3000))%> 원
	<% } %>
</span>

</div>

<%-- 쇼핑계속하기 및 구매하기 버튼 출력 --%>

<div style="text-align: center; margin: 0 auto;">
<button type="button"><a href="<%=request.getContextPath()%>
/index.jsp?group=main&worker=main_page&productNum="  >쇼핑계속하기</a></button>&nbsp;&nbsp;&nbsp;

<button type="button" id="GoOrder" style="margint: 1050px;" value="">구매하기</button>&nbsp;&nbsp;&nbsp;

 <%-- 구매하기 버튼 클릭시 현재 수정된 제품의 수량을 장바구니 테이블에 다시 저장
 DAO는 update로 만들고 회원번호와 상품번호를 전달받아 수량을 수정 그리고 구매하기 --%>
</div>


<%-- 스크립트 시작 --%>

<script>

var totalAmount = 0;



//체크박스 클릭 이벤트 핸들러
document.getElementsByName('productOne').forEach(function (checkbox, index) {
    checkbox.addEventListener('click', function () {
        var countInput = document.getElementById("cartQuantity" + index);
        var unitPriceElement = document.getElementById("Cash2" + index);

        var count = parseInt(countInput.value);
        var unitPrice = parseInt(unitPriceElement.value.replace(/[^\d]/g, ''));
        
        if (checkbox.checked) {
            totalAmount += unitPrice * count;
        } else {
            totalAmount -= unitPrice * count;
        }
        
     // 각 상품의 가격 업데이트
        updateTotalPrice(index);

        var totalAmountElement = document.getElementById("NumMoney");
        totalAmountElement.innerText = new Intl.NumberFormat('en-US').format(totalAmount) + "원";

        if (totalAmount > 50000) {
            document.getElementById("transMoney").innerHTML = "0";
            var AlltotalMoney = document.getElementById("NumMoneyALL");
            AlltotalMoney.innerText = new Intl.NumberFormat('en-US').format(totalAmount) + "원";
        } else {
            document.getElementById("transMoney").innerHTML = "3,000";
            var AlltotalMoney = document.getElementById("NumMoneyALL");
            AlltotalMoney.innerText = new Intl.NumberFormat('en-US').format(totalAmount + 3000) + "원";
        }
    });
});




function updateTotalPrice(index) {
	//수량 변수에 저장
	var countInput = document.getElementById("cartQuantity" + index);
	//상품가격 변수에 저장
    var unitPriceElement = document.getElementById("Cash2" + index);
    
    // 수량 입력 필드와 상품 가격 엘리먼트가 존재하는지 확인
    if (countInput && unitPriceElement) {
	
	//문자열인 수량을 정수로 변환하여 저장
	var count = parseInt(countInput.value);
	//정규표현식을 통해 숫자를 제외한 나머지를 빈문자열''을 통해제거
	var unitPrice = parseInt(unitPriceElement.value.replace(/[^\d]/g, ''));
    
    var totalPrice = unitPrice * count;
    document.getElementById("Cash"+index).innerText = new Intl.NumberFormat('en-US').format(totalPrice) + "원";
    //unitPriceElement.innerText = new Intl.NumberFormat('en-US').format(totalPrice) + "원";
    updateTotalPurchaseAmount(); // 총 결제 금액을 업데이트하는 함수 호출
	
    }
}

function countUp(index) {
	//i번째 수량을 변수에 저장
    var countInput = document.getElementById("cartQuantity" + index);
	//저장된 문자열을 정수로 변환
    count = parseInt(countInput.value);
	//1증가
    count++;
	//i번째 수량의 값을 증가된 값 대입
    countInput.value = count;
    updateTotalPrice(index);
}

function countDown(index) {
    var countInput = document.getElementById("cartQuantity" + index);
    count = parseInt(countInput.value);
    if (count > 1) {
        count--;
        countInput.value = count;
        updateTotalPrice(index);
    }
}


function updateTotalPurchaseAmount() {
	   totalAmount = 0;
	    var checkboxes = document.getElementsByName('productOne');
	    
	    
	    
	    for (var i = 0; i < checkboxes.length; i++) {
	        if (checkboxes[i].checked) {
	            var countInput = document.getElementById("cartQuantity" + i);
	            var unitPriceElement = document.getElementById("Cash2" + i);
	            
	            var count = parseInt(countInput.value);
	            var unitPrice = parseInt(unitPriceElement.value.replace(/[^\d]/g, ''));
	            
	            totalAmount += unitPrice * count;
	        }
	    }
	    
	    var totalAmountElement = document.getElementById("NumMoney");
	    totalAmountElement.innerText = new Intl.NumberFormat('en-US').format(totalAmount) + "원";
	    
	    
	    if(totalAmount>50000 || totalAmount===0){
			 document.getElementById("transMoney").innerHTML = "0";
			 var AlltotalMoney = document.getElementById("NumMoneyALL");
			 AlltotalMoney.innerText = new Intl.NumberFormat('en-US').format(totalAmount) + "원";
		}else{
			 document.getElementById("transMoney").innerHTML = "3,000";
			 var AlltotalMoney = document.getElementById("NumMoneyALL");
			 AlltotalMoney.innerText = new Intl.NumberFormat('en-US').format(totalAmount+3000) + "원";
		}
	    
	    
	}



//전체선택체크박스를 클릭하면 해당 엘리먼트가 source에 대입
function selectAll(source) {
	//개별체크박스의 이름을 가져와 변수에 저장
    var checkboxOnes = document.getElementsByName('productOne');
    //반복문을 통해 생성된 이름이 같은 여러개의 체크박스들의 길이만큼 반복
    for (var i = 0; i < checkboxOnes.length; i++) {
		//i번째 체크박스의 상태를 최초 선택한체크박스 엘리먼트의 체크된상태로 바꾼다
        checkboxOnes[i].checked = source.checked;
        updateTotalPrice(i); // 각 상품의 가격 업데이트

    }
}




function selectOnly(source) {
	
	//전체선택체크박스를 변수에 저장
    var selectAllCheckbox = document.getElementById('selectAllCheckbox');
    //선택한 체크박스가 체크된 상태라면
    if (source.checked) {
		//true를 변수에 저장
        let allChecked = true;
		//개별체크박스의 객체를 변수에 저장
        var checkboxes = document.getElementsByName('productOne');
		
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

    var checkboxIndex = parseInt(source.id.replace("productOne", ""));
    updateTotalPrice(checkboxIndex); // 선택된 상품의 가격 업데이트
}


	
//체크선택삭제-------------------------------------------------------------------
$("#GoRemove").click(function () {
	//배열변수를 선언
	
	 var selectedItems = [];
		//id로 선택된 체크박스중 체크된것은 this를 통해 그 태그의 val을
		//배열인 selectedItems 변수에 each 함수를 통해 반복해서 넣는다. 
	    $("#productOne:checked").each(function() {
	        selectedItems.push($(this).val( ));
	    });

	    // 수집한 값이 있는지 확인 후 처리
	    if (selectedItems.length > 0) {
	        // 선택된 상품 목록을 hidden 필드에 저장
	        $("#selectedItemsInput").val(selectedItems.join());
	        $("#WChoice").val(1);
			
	        // 폼 제출
	        $("#hangForm").submit();
 } else {
     alert("삭제할 상품을 선택하세요.");
 }
	    
	    
	    
});

//주문하기 페이지로 값 전달-------------------------------------------------------------------
$("#GoOrder").click(function () {
	//배열변수를 선언
	
          var quantities = [];
	 var selectedItems = [];
	 
		//id로 선택된 체크박스중 체크된것은 this를 통해 그 태그의 val을
		//배열인 selectedItems 변수에 each 함수를 통해 반복해서 넣는다. 
	    $("#productOne:checked").each(function() {
	        selectedItems.push($(this).val( ));
	    });
		
		for(i=0; i<selectedItems.length; i++){

            // 해당 상품의 수량을 가져와 quantities 배열에 추가

            var quantity = $("#cartQuantity" + i).val();
            quantities.push(quantity);
	        
		}
	    // 수집한 값이 있는지 확인 후 처리
	    if (selectedItems.length > 0) {
	        // 선택된 상품 목록을 hidden 필드에 저장
	        $("#selectedItemsInput").val(selectedItems.join());
	        
	        $("#selectedItemsInputQuan").val(quantities.join());
	
	        
	        // 폼 제출
	        $("#WChoice").val(2);
	        $("#hangForm").submit();
	        
 } else {
     alert("삭제할 상품을 선택하세요.");
 }
	    
	    
	    
});


    </script>

</body>
</html>