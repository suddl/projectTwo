package xyz.nailro.dto;

/*
	CREATE TABLE MOON(MOON_NUM NUMBER PRIMARY KEY, MOON_CLIENT_NUM NUMBER CONSTRAINT MOON_CLIENT_FK REFERENCES MEMBER(MEMBER_NUM), 
	MOON_TITLE VARCHAR2(300), MOON_CONTENT VARCHAR2(4000), MOON_DATE DATE, MOON_RE VARCHAR2(4000), MOON_IMAGE VARCHAR2(100));

    
	create sequence moon_seq;
  
		이름              널?       유형             
	--------------- -------- -------------- 
	MOON_NUM        NOT NULL NUMBER         
	MOON_CLIENT_NUM          NUMBER         
	MOON_TITLE               VARCHAR2(300)  
	MOON_CONTENT             VARCHAR2(4000) 
	MOON_DATE                DATE           
	MOON_RE                  VARCHAR2(4000) 
	MOON_IMAGE               VARCHAR2(100)

*/

public class MoonDTO {
	private int moonNum;
	private int moonClientNum;
	private String moonName; // 작성자이름
	private String moonTitle;
	private String moonContent;
	private String moonImage;
	private String moonDate;
	private String moonRe;
	
	public MoonDTO() {
		// TODO Auto-generated constructor stub
	}

	public int getMoonNum() {
		return moonNum;
	}

	public void setMoonNum(int moonNum) {
		this.moonNum = moonNum;
	}

	public int getMoonClientNum() {
		return moonClientNum;
	}

	public void setMoonClientNum(int moonClientNum) {
		this.moonClientNum = moonClientNum;
	}

	public String getMoonName() {
		return moonName;
	}

	public void setMoonName(String moonName) {
		this.moonName = moonName;
	}

	public String getMoonTitle() {
		return moonTitle;
	}

	public void setMoonTitle(String moonTitle) {
		this.moonTitle = moonTitle;
	}

	public String getMoonContent() {
		return moonContent;
	}

	public void setMoonContent(String moonContent) {
		this.moonContent = moonContent;
	}

	public String getMoonImage() {
		return moonImage;
	}

	public void setMoonImage(String moonImage) {
		this.moonImage = moonImage;
	}

	public String getMoonDate() {
		return moonDate;
	}

	public void setMoonDate(String moonDate) {
		this.moonDate = moonDate;
	}

	public String getMoonRe() {
		return moonRe;
	}

	public void setMoonRe(String moonRe) {
		this.moonRe = moonRe;
	}

	
}
