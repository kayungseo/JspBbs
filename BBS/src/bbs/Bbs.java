package bbs;

/*
 * 자바 빈즈 클래스로서,
 * 하나의 게시글 정보를 담을 수 있는 인스턴스 틀로서
 * 사실상 DB 테이블과 흡사한 구조를 가짐 
 * 전반적인 게시글 하나를 다룰 수 있도록 한다. 
 * 
 * mysql에서 bbs 라는 테이블 만든 후 해당 자바 빈즈만들면 게시판 데이터베이스 구축 끝. 
 * */
 
public class Bbs {
	private int bbsID;
	private String bbsTitle;
	private String userID;
	private String bbsDate;
	private String bbsContent;
	private int bbsAvailable;
	
	public int getBbsID() {
		return bbsID;
	}
	public void setBbsID(int bbsID) {
		this.bbsID = bbsID;
	}
	public String getBbsTitle() {
		return bbsTitle;
	}
	public void setBbsTitle(String bbsTitle) {
		this.bbsTitle = bbsTitle;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getBbsDate() {
		return bbsDate;
	}
	public void setBbsDate(String bbsDate) {
		this.bbsDate = bbsDate;
	}
	public String getBbsContent() {
		return bbsContent;
	}
	public void setBbsContent(String bbsContent) {
		this.bbsContent = bbsContent;
	}
	public int getBbsAvailable() {
		return bbsAvailable;
	}
	public void setBbsAvailable(int bbsAvailable) {
		this.bbsAvailable = bbsAvailable;
	}
	
}
