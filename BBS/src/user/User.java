package user;

public class User {

	//DB와 JSP 연결 
	//한 명의 회원 데이터를 다룰 수 있는 데이터베이스 및 자바 빈즈 완성.
	//하나의 데이터를 구현하고 관리하는 기법을 JSP에서 구현하는 것이 '자바 빈즈'이다. 
	private String userID;
	private String userPassword;
	private String userName;
	private String userGender;
	private String userEmail;
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getUserPassword() {
		return userPassword;
	}
	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserGender() {
		return userGender;
	}
	public void setUserGender(String userGender) {
		this.userGender = userGender;
	}
	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	
	
	
	
}
