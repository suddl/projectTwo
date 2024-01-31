package xyz.nailro.dto;

public class reviewDTO {

/*
	이름                널?       유형             
----------------- -------- -------------- 
REVIEW_NUM        NOT NULL NUMBER         
REVIEW_CLIENT_NUM          NUMBER         
REVIEW_SUBJECT             VARCHAR2(500)  
REVIEW_C0NTENT             VARCHAR2(3000) 
REVIEW_ORDER_NUM           NUMBER         
REVIEW_DATE                DATE           
REVIEW_IMAGE               VARCHAR2(50)   
REVIEW_RE                  VARCHAR2(4000) 
*/
		private int review_num;
		private int review_client_num;
		private String review_name; //client 테이블의 회원이름(NAME 컬럼)을 저장하기 위한 필드 - 작성자이름
		private String review_subject;
		private String review_content;
		private int review_order_num;
		private String review_date;
		private String review_image;
		private String review_re; //답글

		public reviewDTO() {
			// TODO Auto-generated constructor stub
		}

		public int getReview_num() {
			return review_num;
		}

		public void setReview_num(int review_num) {
			this.review_num = review_num;
		}

		public int getReview_client_num() {
			return review_client_num;
		}

		public void setReview_client_num(int review_client_num) {
			this.review_client_num = review_client_num;
		}

		public String getReview_name() {
			return review_name;
		}

		public void setReview_name(String review_name) {
			this.review_name = review_name;
		}

		public String getReview_subject() {
			return review_subject;
		}

		public void setReview_subject(String review_subject) {
			this.review_subject = review_subject;
		}

		public String getReview_content() {
			return review_content;
		}

		public void setReview_content(String review_content) {
			this.review_content = review_content;
		}

		public int getReview_order_num() {
			return review_order_num;
		}

		public void setReview_order_num(int review_order_num) {
			this.review_order_num = review_order_num;
		}

		public String getReview_date() {
			return review_date;
		}

		public void setReview_date(String review_date) {
			this.review_date = review_date;
		}

		public String getReview_image() {
			return review_image;
		}

		public void setReview_image(String review_image) {
			this.review_image = review_image;
		}

		public String getReview_re() {
			return review_re;
		}

		public void setReview_re(String review_re) {
			this.review_re = review_re;
		}
		
		
		
		
}