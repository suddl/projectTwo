package xyz.nailro.dto;

public class PaymentDTO {
	private String ClientNum;
	private String PaymentMoney;
	private String PaymentMethod;
	
	public PaymentDTO() {
		// TODO Auto-generated constructor stub
	}

	public String getClientNum() {
		return ClientNum;
	}

	public void setClientNum(String clientNum) {
		ClientNum = clientNum;
	}

	public String getPaymentMoney() {
		return PaymentMoney;
	}

	public void setPaymentMoney(String paymentMoney) {
		PaymentMoney = paymentMoney;
	}

	public String getPaymentMethod() {
		return PaymentMethod;
	}

	public void setPaymentMethod(String paymentMethod) {
		PaymentMethod = paymentMethod;
	}
	
	
	
}
