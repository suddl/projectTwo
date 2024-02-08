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
           $('.box').removeClass('cliked');
              $('#modifyButton').addClass('cliked');
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
       
        function redirectToRemove() {
           $.get('<%=request.getContextPath()%>/client/client_remove_action.jsp', function(data) {
              $('#content').html(data); 
              
           });
           
        }
       
    </script>
</head>
<style>
  .box {
    background-color: #FFDCD1;
    border: 1px solid black;
    padding: 15;
    cursor: pointer;
  }

  .box.clicked {
  }
</style>
<body> 
    <div class="container">
        <div class="row" align="center"> 
            <div style="background-color:#FFDCD1; border-radius:50px 0 50px 0; height:100px; padding:100px; text-align:center;"class="mypage">
            <% if (loginClient !=null) { %>
      
            <%= loginClient.getClientName()%> 님 환영합니다!
            <% } %>
            
    </div>
            
 <div id="mypage" style="text-align: center; margin-top: 180px;">
    <table style="width: 700px; margin: 0 auto;">
        <!-- your table content -->
 
     <tr class="chas1">
            <td class="box non-click" id="first" style="border: 1px solid black; padding: 20px;" ><a>주문내역</a></td>
            <td class="box non-click" id="second" style="border: 1px solid black; padding: 20px;" onclick="redirectToCart()">장바구니</td>
        </tr>
        <tr class="chas1" onclick="backChange(this,2)">
            <td class="box non-click" id="modifyButton" style="border: 1px solid black; padding: 20px;" onclick="redirectToClientModify()">회원정보 수정</td>
            <td class="box non-click" style="border: 1px solid black; padding: 20px;">회원 탈퇴</td>
        </tr>
        <tr class="chas1">
            <td class="box non-click" style="border: 1px solid black; padding: 20px;">게시글관리</td>
            <td class="box non-click" style="border: 1px solid black; padding: 20px;"onclick="redirectToReviewModify()">1:1문의</td>
     </tr>
       
     
  </table>
  </div>
</body>
</html>