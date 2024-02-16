<%@page import="xyz.nailro.dao.ClientDAO"%>
<%@page import="xyz.nailro.dto.ClientDTO"%>
<%@page import="xyz.nailro.util.Utility"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 이름과 아이디를 전달받아 MEMBER 테이블에 저장된 행의 비밀번호를 검색하여 검색 결과를 전달하여 응답하는 JSP 문서 --%>    
<%
	//JSP 문서를 GET 방식으로 요청한 경우에 대한 응답 처리 - 비정상적인 요청
	if(request.getMethod().equals("GET")) {
		request.setAttribute("returnURL", request.getContextPath()+"/main_page/main?group=error&worker=error_400");
		return;
	}
	
	String newPasswordOne=Utility.newPassword();
	
	String newPasswd= Utility.encrypt(newPasswordOne);

	
	//전달값을 반환받아 저장
	String name=request.getParameter("name");
	String id=request.getParameter("id");
	String email=request.getParameter("email");
	
	//MemberDTO 객체를 생성하여 전달값으로 필드값 변경
	ClientDTO client=new ClientDTO();
	client.setClientPasswd(newPasswd);
	client.setClientName(name);
	client.setClientId(id);
	client.setClientEmail((email));
	
	//회원정보를 전달받아 client 테이블에 비밀번호 변경  
	//ClientDAO 클래스의 메소드 호출
	int passwd=ClientDAO.getDAO().updateClientPassword(client);		
%>

<h1>임시비밀번호 발급</h1>
<% if(passwd!=0) {//검색결과가 있는 경우 %>
	<p style="font-size: 1.5em;"><%=name %>님의 새로운 비밀번호는 [<%=newPasswordOne %>]입니다.</p>
<% } else {//검색결과가 없는 경우 %>
	<p style="font-size: 1.5em;">입력하신 정보를 찾을 수 없습니다.</p>
<% } %>

<a href="<%=request.getContextPath()%>/index.jsp?group=client&worker=client_login">
	<button type="submit" >로그인하기</button>
</a>


