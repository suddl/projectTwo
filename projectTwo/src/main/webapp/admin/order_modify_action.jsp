<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.io.File"%>
<%@page import="xyz.nailro.dao.OrderDAO"%>
<%@page import="xyz.nailro.dto.OrderDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="/security/admin_check.jspf" %>    
<%
	//JSP 문서를 GET 방식으로 요청한 경우에 대한 응답 처리 - 비정상적인 요청
	if(request.getMethod().equals("GET")) {
		request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?group=error&worker=error_400");
		return;
	}	

	//선택된 주문 번호를 배열로 받아옴
	String[] selectedOrderNums=request.getParameterValues("check");
	
	// 만약 선택된 주문이 없으면 예외처리
	if (selectedOrderNums != null || selectedOrderNums.length == 0) {
		out.println("변경할 주문이 선택되지 않았습니다.");
        return;
    }
	
	// 선택된 주문들의 상태를 변경하기 위해 OrderDTO 리스트 생성
	List<OrderDTO> ordersToUpdate = new ArrayList<>();
	
	for (String orderNum : selectedOrderNums) {
		// 각 주문 번호로 OrderDTO 생성하여 리스트에 추가
        OrderDTO order = new OrderDTO();
        order.setOrderNum(orderNum);	
        // 변경된 주문 상태는 select 태그의 name 속성을 이용하여 받음
		String orderStatus = request.getParameter("orderStatus_" + orderNum);
      	order.setOrderStatus(orderStatus);
      	ordersToUpdate.add(order);
	}
      	
	// 주문 상태 변경 후 결과를 받아올 리스트 생성
    List<String> results = new ArrayList<>();
	
 	// 주문 상태 변경 처리
    for (OrderDTO order : ordersToUpdate) {
        int rowsUpdated = OrderDAO.getDAO().updateOrderStatus(order);
        // 변경된 주문 상태에 따라 결과 리스트에 메시지 추가
        if (rowsUpdated > 0) {
            results.add("주문 번호 " + order.getOrderNum() + "의 주문 상태가 변경되었습니다.");
        } else {
            results.add("주문 번호 " + order.getOrderNum() + "의 주문 상태 변경에 실패했습니다.");
        }
    }
   
    // 결과 출력
    for (String result : results) {
        out.println(result + "<br>");
    }
 	
	//페이지 이동 - 검색 및 페이징 처리 관련 값 전달
	request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?group=admin&worker=order_list");
%>
