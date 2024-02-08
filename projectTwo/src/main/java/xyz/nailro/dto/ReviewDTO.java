package xyz.nailro.dto;

public class ReviewDTO {

/*
이름                 널?       유형             
------------------ -------- -------------- 
REVIEW_NUM         NOT NULL NUMBER         
REVIEW_CLIENT_NUM           NUMBER         
REVIEW_SUBJECT     NOT NULL VARCHAR2(500)  
REVIEW_CONTENT     NOT NULL VARCHAR2(3000) 
REVIEW_ORDER_NUM            NUMBER         
REVIEW_DATE                 DATE           
REVIEW_IMAGE                VARCHAR2(50)   
REVIEW_RE                   VARCHAR2(4000) 
REVIEW_RATING               VARCHAR2(20)   
REVIEW_PRODUCT_NUM          NUMBER   
*/
		private int reviewNum;
		private int reviewClientNum;
		private String reviewName; //client 테이블의 회원이름(NAME 컬럼)을 저장하기 위한 필드 - 작성자이름
		private String reviewSubject;
		private String reviewContent;
		private int reviewOrderNum;
		private String reviewDate;
		private String reviewImage;
		private String reviewRe; //답글
		private String reviewRating;
		private int reviewProductNum;

		public ReviewDTO() {
			// TODO Auto-generated constructor stub
		}

		public int getReviewNum() {
			return reviewNum;
		}

		public void setReviewNum(int reviewNum) {
			this.reviewNum = reviewNum;
		}

		public int getReviewClientNum() {
			return reviewClientNum;
		}

		public void setReviewClientNum(int reviewClientNum) {
			this.reviewClientNum = reviewClientNum;
		}

		public String getReviewName() {
			return reviewName;
		}

		public void setReviewName(String reviewName) {
			this.reviewName = reviewName;
		}

		public String getReviewSubject() {
			return reviewSubject;
		}

		public void setReviewSubject(String reviewSubject) {
			this.reviewSubject = reviewSubject;
		}

		public String getReviewContent() {
			return reviewContent;
		}

		public void setReviewContent(String reviewContent) {
			this.reviewContent = reviewContent;
		}

		public int getReviewOrderNum() {
			return reviewOrderNum;
		}

		public void setReviewOrderNum(int reviewOrderNum) {
			this.reviewOrderNum = reviewOrderNum;
		}

		public String getReviewDate() {
			return reviewDate;
		}

		public void setReviewDate(String reviewDate) {
			this.reviewDate = reviewDate;
		}

		public String getReviewImage() {
			return reviewImage;
		}

		public void setReviewImage(String reviewImage) {
			this.reviewImage = reviewImage;
		}

		public String getReviewRe() {
			return reviewRe;
		}

		public void setReviewRe(String reviewRe) {
			this.reviewRe = reviewRe;
		}

		public String getReviewRating() {
			return reviewRating;
		}

		public void setReviewRating(String reviewRating) {
			this.reviewRating = reviewRating;
		}

		public int getReviewProductNum() {
			return reviewProductNum;
		}

		public void setReviewProductNum(int reviewProductNum) {
			this.reviewProductNum = reviewProductNum;
		}

		
}