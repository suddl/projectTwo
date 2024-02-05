package xyz.nailro.dto;
//CREATE TABLE CART (CAR_NUM NUMBER PRIMARY KEY, CART_QUANTITY NUMBER NOT NULL, CART_PRODUCT NUMBER
//REFERENCES PRODUCT(PRODUCT_NUM), CART_CLIENT_NUM NUMBER REFERENCES CLIENT(CLIENT_NUM));

/*CREATE TABLE CLIENT (CLIENT_NUM NUMBER PRIMARY KEY, CLIENT_ID VARCHAR2(50) NOT NULL,
CLIENT_PASSWD VARCHAR2(100) NOT NULL, CLIENT_NAME VARCHAR2(30) NOT NULL,
CLIENT_PHONE VARCHAR2(50) NOT NULL, CLIENT_EMAIL VARCHAR2(50) NOT NULL, 
CLIENT_ADDRESS1 VARCHAR2(200),CLIENT_ADDRESS2 VARCHAR2(100), CLIENT_ZIPCODE VARCHAR2(20),
CLIENT_STATUS NUMBER(10) NOT NULL );
*/
public class CartDTO {
	private String CarNum;//장바구니 번호
	private String CarQuantity;//담긴수량
	private String CarProduct;//장바구니 담긴 상품번호
	private String CartClientNum;//장바구니 회원번호 FK

	private String ClientId; 
	private String ClientName; 
	private String ClientPhone; 
	private String ClientEmail; 
	private String ClientAddress1; 
	private String ClientAddress2; 
	private String ClientZipCode;
	
	public CartDTO() {
		// TODO Auto-generated constructor stub
	}

	public String getCarNum() {
		return CarNum;
	}

	public void setCarNum(String carNum) {
		CarNum = carNum;
	}

	public String getCarQuantity() {
		return CarQuantity;
	}

	public void setCarQuantity(String carQuantity) {
		CarQuantity = carQuantity;
	}

	public String getCarProduct() {
		return CarProduct;
	}

	public void setCarProduct(String carProduct) {
		CarProduct = carProduct;
	}

	public String getCarClientNum() {
		return CartClientNum;
	}

	public void setCarClientNum(String carClientNum) {
		CartClientNum = carClientNum;
	}

	public String getClientId() {
		return ClientId;
	}

	public void setClientId(String clientId) {
		ClientId = clientId;
	}

	public String getClientName() {
		return ClientName;
	}

	public void setClientName(String clientName) {
		ClientName = clientName;
	}

	public String getClientPhone() {
		return ClientPhone;
	}

	public void setClientPhone(String clientPhone) {
		ClientPhone = clientPhone;
	}

	public String getClientEmail() {
		return ClientEmail;
	}

	public void setClientEmail(String clientEmail) {
		ClientEmail = clientEmail;
	}

	public String getClientAddress1() {
		return ClientAddress1;
	}

	public void setClientAddress1(String clientAddress1) {
		ClientAddress1 = clientAddress1;
	}

	public String getClientAddress2() {
		return ClientAddress2;
	}

	public void setClientAddress2(String clientAddress2) {
		ClientAddress2 = clientAddress2;
	}

	public String getClientZipCode() {
		return ClientZipCode;
	}

	public void setClientZipCode(String clientZipCode) {
		ClientZipCode = clientZipCode;
	}
	
	
	
	
}
