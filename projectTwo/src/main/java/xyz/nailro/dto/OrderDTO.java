package xyz.nailro.dto;

import xyz.nailro.dao.JdbcDAO;


/**
CREATE TABLE ORDERS(
	ORDER_NUM NUMBER PRIMARY KEY, -주문번호(시퀀스)
	ORDER_PAY_NUM NUMBER REFERENCES PAYMENT(PAY_NUM), - 결제번호(결제테이블참조)
	ORDER_CLIENT_NUM NUMBER REFERENCES CLIENT(CLIENT_NUM), - 회원번호(회원테이블참조)
	ORDER_PRODUCT_NUM NUMBER REFERENCES PRODUCT(PRODUCT_NUM), - 주문 상품번호(상품테이블참조)
	ORDER_ADDRESS1 VARCHAR2(100) NOT NULL,
	ORDER_ADDRESS2 VARCHAR2(100) NOT NULL,
	ORDER_ZIPCODE VARCHAR2(50) NOT NULL,
	ORDER_QUNTITY NUMBER NOT NULL,
	ORDER_DATE DATE NOT NULL,
	ORDER_STATUS NUMBER NOT NULL);
	
	//주문테이블에 필요한것
	//주문번호(시퀀스),결제번호(결제테이블참조),회원번호(회원테이블참조),
	//주문 상품번호(상품테이블참조),주문상세주소1,
	//주문상세주소2,주문우편주소,주문수량,주문날짜,주문상태
	
 */
public class OrderDTO {
	private String OrderNum;//주문번호
	private int OrderPayNum;//결제번호
	private String OrderClientNum;
	private String OrderProductNum;
	private String OrderAddress1;
	private String OrderAddress2;
	private String OrderZipCode;
	private String OrderQuntity;
	private String OrderDate;
	private String OrderStatus;
	
	public OrderDTO() {
		// TODO Auto-generated constructor stub
	}

	public String getOrderNum() {
		return OrderNum;
	}

	public void setOrderNum(String orderNum) {
		OrderNum = orderNum;
	}

	public int getOrderPayNum() {
		return OrderPayNum;
	}

	public void setOrderPayNum(int orderPayNum) {
		OrderPayNum = orderPayNum;
	}

	public String getOrderClientNum() {
		return OrderClientNum;
	}

	public void setOrderClientNum(String orderClientNum) {
		OrderClientNum = orderClientNum;
	}

	public String getOrderProductNum() {
		return OrderProductNum;
	}

	public void setOrderProductNum(String orderProductNum) {
		OrderProductNum = orderProductNum;
	}

	public String getOrderAddress1() {
		return OrderAddress1;
	}

	public void setOrderAddress1(String orderAddress1) {
		OrderAddress1 = orderAddress1;
	}

	public String getOrderAddress2() {
		return OrderAddress2;
	}

	public void setOrderAddress2(String orderAddress2) {
		OrderAddress2 = orderAddress2;
	}

	public String getOrderZipCode() {
		return OrderZipCode;
	}

	public void setOrderZipCode(String orderZipCode) {
		OrderZipCode = orderZipCode;
	}

	public String getOrderQuntity() {
		return OrderQuntity;
	}

	public void setOrderQuntity(String orderQuntity) {
		OrderQuntity = orderQuntity;
	}

	public String getOrderDate() {
		return OrderDate;
	}

	public void setOrderDate(String orderDate) {
		OrderDate = orderDate;
	}

	public String getOrderStatus() {
		return OrderStatus;
	}

	public void setOrderStatus(String orderStatus) {
		OrderStatus = orderStatus;
	}
	
	
	
	
	
	
	
	
}
