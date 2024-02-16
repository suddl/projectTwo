<%--<%@page import="xyz.nailro.dao.ClientDAO"--%>
<%@page import="xyz.nailro.dao.ClientDAO"%>
<%@page import="xyz.nailro.util.Utility"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 회원정보를 전달받아 Client 테이블에 저장된 행을 변경하고 [/member/member_mypage.jsp]
문서를 요청하기 위한 URL 주소를 전달하여 응답하는 JSP 문서 --%> 
<%-- => 로그인 상태의 사용자만 요청 가능한 JSP 문서 --%>
<%@include file="/security/login_check.jspf" %>  
<% 
	//JSP 문서를 GET 방식으로 요청한 경우에 대한 응답 처리 - 비정상적인 요청
	if(request.getMethod().equals("GET")) {
		request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?group=error&worker=error_400");
		return;
	}

	//전달값을 반환받아 저장
	int ClientNum=Integer.parseInt(request.getParameter("ClientNum"));
	String id=request.getParameter("id");
	String passwd=request.getParameter("passwd");
	if(passwd==null || passwd.equals("")) {//전달값(비밀번호)이 없는 경우
		//현재 로그인 사용자의 비밀번호를 변수에 저장 - 기존 비밀번호 유지
		passwd=loginClient.getClientPasswd();
	} else {//전달값(비밀번호)이 있는 경우
		//전달값을 암호화 처리하여 변수에 저장 - 전달된 비밀번호로 변경
		passwd=Utility.encrypt(passwd);
	}
	String name=request.getParameter("name");
	String email=request.getParameter("email");
	String mobile=request.getParameter("mobile1")+"-"+request.getParameter("mobile2")
		+"-"+request.getParameter("mobile3");
	String zipcode=request.getParameter("zipcode");
	String address1=request.getParameter("address1");
	String address2=request.getParameter("address2");
	
	//rs=pstmt.executQuery();
	//if(rs.next()){
	//MemberDTO 객체를 생성하여 전달값으로 필드값 변경
	ClientDTO client=new ClientDTO();
	client.setClientNum(ClientNum);
	client.setClientId(id);
	client.setClientPasswd(passwd);
	client.setClientName(name);
	client.setClientPhone(mobile);
	client.setClientEmail(email);
	client.setClientAddress1(address1);
	client.setClientAddress2(address2);
	client.setClientZipcode(zipcode);
	
	//회원정보를 전달받아 MEMBER 테이블에 저장된 행을 변경하고 변경행의 갯수를 반환하는 
	//MemberDAO 클래스의 메소드 호출
	ClientDAO.getDAO().updateClient(client);
	
	//session 객체에 저장된 권한 관련 속성값(회원정보 - MemberDTO 객체) 변경
	session.setAttribute("loginClient", ClientDAO.getDAO().selectClientByNum(ClientNum));
	
	//페이지 이동
	request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?group=client&worker=client_mypage");
	
%>