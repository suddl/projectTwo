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
    <script>
        function redirectToReviewWrite() {
            window.location.href = '<%=request.getContextPath()%>/review/review_write.jsp';
        }
    </script>
    <meta charset="UTF-8">
    <title>Nailro</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link href="<%=request.getContextPath()%>/css/header.css" type="text/css" rel="stylesheet">
</head>
<body>
    <div class="container">
        <div class="row" align="center"> 
            <div class="mypage">
            <% if (loginClient !=null) { %>
            <%= loginClient.getClientName()%> 님 환영합니다!
            <% } %>
                
                <button>1:1 문의하기</button> 
                <button onclick="redirectToReviewWrite()" href="<%=request.getContextPath() %>/index.jsp?group=review&worker=review_write">리뷰 쓰기</button>
            </div>
            
            <div class="mybuttons" style="margin-top: 4cm;>
            <!-- Move these buttons below the "리뷰 쓰기" button -->
            <button class="btn btn-1g" style="background-color: #FFDCE1;">장바구니</button> 
            <button class="btn btn-1g" style="background-color: #FFDCE1;">회원정보</button>
            </div>
            
            <div class="button-group" style="margin-top: 2cm;">
            <button class="btn btn-1g" style="background-color: #FFDCE1;">게시글관리</button>
            <button class="btn btn-1g" style="background-color: #FFDCE1;">주문내역</button>
            </div>
            
            <div id="content">
                <% 
                    String returnUrl = (String)request.getAttribute("returnUrl");
                    if (returnUrl == null) {
                        response.sendRedirect(returnUrl);
                        return;
                    }
                %>
            </div>
        </div>
    </div>
    <div id="header"></div>
    <div id="content"></div>
    <div id="footer"></div>
</body>
</html>