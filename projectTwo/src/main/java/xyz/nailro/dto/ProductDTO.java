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
	private int product_num;
	private int product_price;
	private String product_name;
	private String product_image;
	private String product_image2;
	private String product_image3;
	private String product_category;
	private String product_type;
	
	public ProductDTO() {
		// TODO Auto-generated constructor stub
	}

	public int getProduct_num() {
		return product_num;
	}

	public void setProduct_num(int product_num) {
		this.product_num = product_num;
	}

	public int getProduct_price() {
		return product_price;
	}

	public void setProduct_price(int product_price) {
		this.product_price = product_price;
	}

	public String getProduct_name() {
		return product_name;
	}

	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}

	public String getProduct_image() {
		return product_image;
	}

	public void setProduct_image(String product_image) {
		this.product_image = product_image;
	}

	public String getProduct_image2() {
		return product_image2;
	}

	public void setProduct_image2(String product_image2) {
		this.product_image2 = product_image2;
	}

	public String getProduct_image3() {
		return product_image3;
	}

	public void setProduct_image3(String product_image3) {
		this.product_image3 = product_image3;
	}

	public String getProduct_category() {
		return product_category;
	}

	public void setProduct_category(String product_category) {
		this.product_category = product_category;
	}

	public String getProduct_type() {
		return product_type;
	}

	public void setProduct_type(String product_type) {
		this.product_type = product_type;
	}
	
	
}
