<%@page import="xyz.nailro.dao.ClientDAO"%>
<%@page import="xyz.nailro.dto.ClientDTO"%>
<%@page import="xyz.nailro.util.Utility"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 인증정보를 전달받아 MEMBER 테이블에 저장된 회원정보와 비교하여 인증이 성공한 경우 권한
 부여 후 [/main/main_page.jsp] 문서를 요청할 수 있는 URL 주소를 전달하여 응답하는 JSP 문서 --%>
<%-- => 로그인 처리 : 인증을 사용해 권한을 제공받는 명령  --%>
 <%-- => 전달받은 URL 주소가 있는 경우 메인 페이지 대신 요청 JSP 문서를 요청할 수 있는  URL 주소 전달 --%>
<%-- => 인증이 실패한 경우 [/member/member_login.jsp] 문서를 요청할 수 있는 URL 주소를 전달   --%>
<%
	//JSP 문서를 GET 방식으로 요청한 경우에 대한 응답 처리 - 비정상적인 요청
	if(request.getMethod().equals("GET")) {
		//요청 JSP 문서에서 URL 주소를 전달하므로 페이지 이동 불가능
		//response.sendRedirect(request.getContextPath()+"/error/error_400.jsp");
		//return;
		request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?group=error&worker=error_400");//이걸 재요청할수있게 URL 주소 포함, 스레드가 다시 인덱스로감, 거기서 리퀘스트에 저장된 값을 가지고 센드 리다이렉트 할수있다.리다이렉트하면 클라이언트가 아닌 index로 간다. 
		return;//스레드가 돌아간다.
	}


	//전달값을 반환받아 저장
	String id = request.getParameter("id");
	String passwd= Utility.encrypt(request.getParameter("passwd"));//비밀번호 암호화 처리, 이미 멤버테이블에 암호화 되어있기 때문에 비교하려면 암호화해서 저장처리해야한다.
	
	String url = request.getParameter("url");
	if(url==null){
		url="";	
	}
	
	//아이디를 전달받아 MEMBER 테이블에 저장된 단일행을 검색하여 MemberDTO 객체로 반환하는
	//MemberDAO 클래스의 메소드 호출
	ClientDTO client = ClientDAO.getDAO().selectClientById(id);//반환값이 null일 수 있다. 회원정보가 없을 수 있기 때문이다(아이디를 잘못 쳤을수도).
	
	//검색된 회원정보가 없거나 검색된 회원정보의 비밀번호가 전달된
	//비밀번호와 같지 않은 경우 또는 탈퇴회원인 경우 인증 실패
	if(client==null || !client.getClientPasswd().equals(passwd) || client.getClientStatus()==0) {
		session.setAttribute("message", "진짜로 아이디 및 비밀번호를 잘못 입력했습니다. 입력하신 내용을 다시 확인해주세요");
		session.setAttribute("id", id);
		request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?group=clientr&worker=client_login&url=");//한번 로그인 실패한 후 로그인하면 메인페이지로 이동 
		return;		
	}
	
	
	//인증 성공 - 로그인 처리 : 권한 관련 정보가 저장된 객체를 session 객체의 속성값으로 저장
	//=> session 객체에 로그인 사용자의 정보(회원정보 - MemberDTO 객체)를 속성값으로 저장
	//=> 로그아웃시 session 객체에 저장된 속성값 삭제 - 브라우저가 종료되면 속성값 자동 삭제(새로운 세션이 바인딩 되기 때문)
	//session.setAttribute("loginMemberNum", member.getMemberNum());//회원번호만 저장 이걸 권장
	session.setAttribute("loginClient", ClientDAO.getDAO().selectClientByNum(client.getClientNum()));//회원정보가 변경될때마다 세션에 저장된 속성값을 바꿔줘야하기 떄문에 회원번호로 저장하는것을 권장
	
	if(url.equals("")){//전달받은 URL 주소가 없는 경우 - 메인 페이지로 이동
	request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?group=main&worker=main_page");
	}else {//전달받은 URL 주소가 있는 경우 - URL 주소의 JSP 문서로 이동
		request.setAttribute("returnUrl", url);
		
	}
	
%>