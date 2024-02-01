<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%--
	//session 객체에 저장된 권한 관련 속성값을 MemberDTO 객체로 반환받아 저장
	MemberDTO loginMember=(MemberDTO)session.getAttribute("loginMember");
	
	//비로그인 상태의 사용자가 JSP 문서를 요청한 경우에 대한 응답 - 비정상적인 요청
	if(loginMember==null) {
		request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?group=error&worker=error_400");
		return;
	}
--%>

<div id="header_main">
		<jsp:include page="/header_main.jsp"></jsp:include>
	</div> 
	
	 <div class="mypage">
	 박민아 님 환영합니다! <button>1:1 문의하기 </button> <button>리뷰 쓰기 </button>
	 </div>
	 
<%
	request.setCharacterEncoding("utf-8");
	
	String group=request.getParameter("group");
	if(group==null) {
		group="main";
	}
	
%>
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Nailro</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link href="<%=request.getContextPath()%>/css/header.css" type="text/css" rel="stylesheet">
</head>
<body>
	<div id="header">
		
	</div>
	
	<div id="content">
		
		<% 
			String returnUrl=(String)request.getAttribute("returnUrl");
			if(returnUrl!=null) { 		
				response.sendRedirect(returnUrl);
				return;
			} 
		%>
	</div>
	
	<div id="footer">
		<jsp:include page="/footer.jsp"></jsp:include>
	</div> 
</body>
</html>