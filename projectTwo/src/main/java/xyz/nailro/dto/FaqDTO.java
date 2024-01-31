package xyz.nailro.dto;
/*
CREATE TABLE FAQ(FAQ_NUM NUMBER PRIMARY KEY, FAQ_SUBJECT VARCHAR2(500) NOT NULL
		, FAQ_CONTENT VARCHAR2(4000) NOT NULL, FAQ_CATEGORY VARCHAR2(100) NOT NULL); 

CREATE SEQUENCE FAQ_SEQ; 
*/

/*
이름           널?       유형             
------------ -------- -------------- 
FAQ_NUM      NOT NULL NUMBER         
FAQ_SUBJECT  NOT NULL VARCHAR2(500)  
FAQ_CONTENT  NOT NULL VARCHAR2(4000) 
FAQ_CATEGORY NOT NULL VARCHAR2(100)  
*/
public class FaqDTO {
	private int faqNum;
	private String faqSubject;
	private String faqContent;
	private String faqCategory;

	public FaqDTO() {
		// TODO Auto-generated constructor stub
	}

	public int getFaqNum() {
		return faqNum;
	}

	public void setFaqNum(int faqNum) {
		this.faqNum = faqNum;
	}

	public String getFaqSubject() {
		return faqSubject;
	}

	public void setFaqSubject(String faqSubject) {
		this.faqSubject = faqSubject;
	}

	public String getFaqContent() {
		return faqContent;
	}

	public void setFaqContent(String faqContent) {
		this.faqContent = faqContent;
	}

	public String getFaqCategory() {
		return faqCategory;
	}

	public void setFaqCategory(String faqCategory) {
		this.faqCategory = faqCategory;
	}
}
