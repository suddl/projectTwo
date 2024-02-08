<%@page import="xyz.nailro.dto.ClientDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<% 
    //session 객체에 저장된 권한 관련 속성값을 MemberDTO 객체로 반환받아 저장
    ClientDTO loginClient=(ClientDTO)session.getAttribute("loginClient");

    //비로그인 상태의 사용자가 JSP 문서를 요청한 경우에 대한 응답 - 비정상적인 요청
    if(loginClient==null) {
        request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?group=error&worker=error_400");
        return;
    } 
%>

<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script>
    function redirectToReviewWrite() {
        $.get('<%=request.getContextPath()%>/review/review_write.jsp', function(data) {
            $('#content').html(data); // Update the content area
        });
    }
        function redirectToCart() {
        	$.get('<%=request.getContextPath()%>/cart/cart_page.jsp', function(data) {
        		$('#content').html(data);
        	});
        }
        function redirectToClientModify() {
        	$.get('<%=request.getContextPath()%>/client/client_modify.jsp', function(data) {
        		$('#content').html(data);
        	});
        }
        function redirectToReviewModify() {
        	   $.get('<%=request.getContextPath()%>/moon/moon_list.jsp', function(data) {
        	      $('#content').html(data); // Update the content area
        	   }).fail(function() {
        	      console.error('Failed to load content for 1:1 문의하기.');
        	   });
        	}
       
    </script>
</head>
<body>
    <div class="container">
        <div class="row" align="center"> 
            <div style="background-color:#FFDCD1; height:100px; padding:100px; text-align:left;"class="mypage">
            <% if (loginClient !=null) { %>
            <%= loginClient.getClientName()%> 님 환영합니다!
            <% } %>
                
                <input type="button" value="1:1 문의하기" style="float:right;" onclick="redirectToReviewModify()"/>
                
                <input type="button" value="리뷰 쓰기" style="float:right;" onclick="redirectToReviewWrite()"/>
            </div>
            
            <div class="mybuttons" style="margin-top: 4cm;">
            <!-- Move these buttons below the "리뷰 쓰기" button -->
          <input type="button" value="장바구니" style="background-color: #FFDCD1; border: none; color: black;" onclick="redirectToCart()" class="btn btn-primary">
            <input type="button" value="회원정보" style="background-color: #FFDCD1; border: none; color: black;" onclick="redirectToClientModify()" class="btn btn-primary">
            
            </div>
            
            <div class="button-group" style="margin-top: 2cm;">
            <button class="btn btn-1g" style="background-color: #FFDCE1;">게시글관리</button>
            <button class="btn btn-1g" style="background-color: #FFDCE1;">주문내역</button>
            </div>
        </div>
    </div>
 
</body>
</html>