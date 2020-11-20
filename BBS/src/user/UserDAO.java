package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
//데이터 접근 객체
//이 페이지에서의 로그인 시도 이후 loginAction 페이지로 넘어감 
public class UserDAO {

	//DAO는 데이터베이스 접근 객체.
	private Connection conn; //DB 접근하게 해주는 객체 
	private PreparedStatement pstmt;
	private ResultSet rs; // 어떤 정보 담을 수 있는 객체 
	
	//생성자 -> 하나의 객체를 만들었을 때 자동으로 DB 연결 되도록 
	public UserDAO() {
		try {
			//port 번호 다르면 connection이 안됨. 
			String dbURL = "jdbc:mysql://localhost:3310/BBS?characterEncoding=UTF-8&serverTimezone=UTC&useSSL=false"; //내 컴퓨터주소의 3306포트의 BBS데이터베이스에 접속 
			String dbID = "root";
			String dbPassword = "gayong4021";
			Class.forName("com.mysql.cj.jdbc.Driver");//mysql Driver 찾을 수 있게 
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);// 접속 완료되면 conn 객체 안에 접속된 정보가 담김.
		} catch (Exception e) {
			e.printStackTrace();//오류가 뭔지 출력 
		}
	}
	
	public int login(String userID, String userPassword) {
		String SQL = "select userPassword from user where userID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);//DB에 SQL 문 주입 
			pstmt.setString(1, userID); //해킹방어, ?자리에 userID 삽입 
			rs = pstmt.executeQuery();//rs에 실행한 결과를 넣어줌 
			if(rs.next()) {
				//결과가 존재한다면 실행됨 
				if(rs.getString(1).equals(userPassword)) {
					return 1;//로그인 성공 -> 함수 강제 종료 
				}
				else {
					return 0;//비밀번호 불일치 
				}
			}
			//그렇지 않다면 
			return -1;//아이디가 없음. 
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -2;//데이터베이스 오류 
	}
	
	public int join(User user) {
		String SQL = "INSERT INTO USER (userID, userPassword, userName, userGender, userEmail) VALUES (?,?,?,?,?)";//불필요한 띄어쓰기->에러
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserGender());
			pstmt.setString(5, user.getUserEmail()); //sql문 채워넣기 
			return pstmt.executeUpdate();//실행한 결과로 반영된 레코드 건수 반환 
			
		} catch (Exception e) {
			
		}
		return -1;//데이터베이스 오류
	}
}
