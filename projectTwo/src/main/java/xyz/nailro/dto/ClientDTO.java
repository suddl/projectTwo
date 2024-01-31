package xyz.nailro.dto;
/*
 * --------------- -------- ------------- 
CLIENT_NUM      NOT NULL NUMBER        
CLIENT_ID                VARCHAR2(50)  
CLIENT_PASSWD            VARCHAR2(50)  
CLIENT_NAME              VARCHAR2(30)  
CLIENT_PHONE             VARCHAR2(50)  
CLIENT_EMAIL             VARCHAR2(50)  
CLIENT_ADDRESS1          VARCHAR2(200) 
CLIENT_ADDRESS2          VARCHAR2(100) 
CLIENT_ZIPCODE           VARCHAR2(20)  
CLIENT_STATUS            NUMBER(10)    
 */

public class ClientDTO {
	private int clientNum;
	private String clientId;
	private String clientPasswd;
	private String clientName;
	private String clientPhone;
	private String clientEmail;
	private String clientAddress1;
	private String clientAddress2;
	private String clientZipcode;
	private int clientStatus;
	
	public ClientDTO() {
		// TODO Auto-generated constructor stub
	}

	public int getClientNum() {
		return clientNum;
	}

	public void setClientNum(int clientNum) {
		this.clientNum = clientNum;
	}

	public String getClientId() {
		return clientId;
	}

	public void setClientId(String clientId) {
		this.clientId = clientId;
	}

	public String getClientPasswd() {
		return clientPasswd;
	}

	public void setClientPasswd(String clientPasswd) {
		this.clientPasswd = clientPasswd;
	}

	public String getClientName() {
		return clientName;
	}

	public void setClientName(String clientName) {
		this.clientName = clientName;
	}

	public String getClientPhone() {
		return clientPhone;
	}

	public void setClientPhone(String clientPhone) {
		this.clientPhone = clientPhone;
	}

	public String getClientEmail() {
		return clientEmail;
	}

	public void setClientEmail(String clientEmail) {
		this.clientEmail = clientEmail;
	}

	public String getClientAddress1() {
		return clientAddress1;
	}

	public void setClientAddress1(String clientAddress1) {
		this.clientAddress1 = clientAddress1;
	}

	public String getClientAddress2() {
		return clientAddress2;
	}

	public void setClientAddress2(String clientAddress2) {
		this.clientAddress2 = clientAddress2;
	}

	public String getClientZipcode() {
		return clientZipcode;
	}

	public void setClientZipcode(String clientZipcode) {
		this.clientZipcode = clientZipcode;
	}

	public int getClientStatus() {
		return clientStatus;
	}

	public void setClientStatus(int clientStatus) {
		this.clientStatus = clientStatus;
	}
	
	
}
