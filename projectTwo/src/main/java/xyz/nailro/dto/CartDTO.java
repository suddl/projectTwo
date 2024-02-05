package xyz.nailro.dto;

public class CartDTO {
	private int cartId;
	private int goodsNo;
	private String goodsName;
	private String goodsPrice;
	private int surang;
	
	public CartDTO() {
		// TODO Auto-generated constructor stub
	}

	public int getCartId() {
		return cartId;
	}

	public void setCartId(int cartId) {
		this.cartId = cartId;
	}

	public int getGoodsNo() {
		return goodsNo;
	}

	public void setGoodsNo(int goodsNo) {
		this.goodsNo = goodsNo;
	}

	public String getGoodsName() {
		return goodsName;
	}

	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
	}

	public String getGoodsPrice() {
		return goodsPrice;
	}

	public void setGoodsPrice(String goodsPrice) {
		this.goodsPrice = goodsPrice;
	}

	public int getSurang() {
		return surang;
	}

	public void setSurang(int surang) {
		this.surang = surang;
	}
	
	
}
