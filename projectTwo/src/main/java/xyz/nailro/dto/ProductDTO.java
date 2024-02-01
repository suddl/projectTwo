package xyz.nailro.dto;
/*
CREATE TABLE PRODUCT (PRODUCT_NUM NUMBER PRIMARY KEY, PRODUCT_NAME VARCHAR2(100) NOT NULL, PRODUCT_IMAGE
VARCHAR2(500) NOT NULL, PRODUCT_IMAGE2 VARCHAR2(500), PRODUCT_IMAGE3 VARCHAR2(500), PRODUCT_PRICE NUMBER(10) NOT NULL,
PRODUCT_CATEGORY VARCHAR2(100) NOT NULL, PRODUCT_TYPE VARCHAR2(50));

이름               널?       유형            
---------------- -------- ------------- 
PRODUCT_NUM      NOT NULL NUMBER        
PRODUCT_NAME     NOT NULL VARCHAR2(100) 
PRODUCT_IMAGE    NOT NULL VARCHAR2(500) 
PRODUCT_IMAGE2            VARCHAR2(500) 
PRODUCT_IMAGE3            VARCHAR2(500) 
PRODUCT_PRICE    NOT NULL NUMBER(10)    
PRODUCT_CATEGORY NOT NULL VARCHAR2(100) 
PRODUCT_TYPE              VARCHAR2(50)  
*/
public class ProductDTO {
	private int productNum;
	private String productName;
	private String productImage;
	private String productImage2;
	private String productImage3;
	private int productPrice;
	private String productCategory;
	private String productType;
	
	public ProductDTO() {
		// TODO Auto-generated constructor stub
	}

	public int getProductNum() {
		return productNum;
	}

	public void setProductNum(int productNum) {
		this.productNum = productNum;
	}

	public int getProductPrice() {
		return productPrice;
	}

	public void setProductPrice(int productPrice) {
		this.productPrice = productPrice;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public String getProductImage() {
		return productImage;
	}

	public void setProductImage(String productImage) {
		this.productImage = productImage;
	}

	public String getProductImage2() {
		return productImage2;
	}

	public void setProductImage2(String productImage2) {
		this.productImage2 = productImage2;
	}

	public String getProductImage3() {
		return productImage3;
	}

	public void setProductImage3(String productImage3) {
		this.productImage3 = productImage3;
	}

	public String getProductCategory() {
		return productCategory;
	}

	public void setProductCategory(String productCategory) {
		this.productCategory = productCategory;
	}

	public String getProductType() {
		return productType;
	}

	public void setProductType(String productType) {
		this.productType = productType;
	}

	
	
}
