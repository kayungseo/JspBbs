package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
//������ ���� ��ü
//�� ������������ �α��� �õ� ���� loginAction �������� �Ѿ 
public class UserDAO {

	//DAO�� �����ͺ��̽� ���� ��ü.
	private Connection conn; //DB �����ϰ� ���ִ� ��ü 
	private PreparedStatement pstmt;
	private ResultSet rs; // � ���� ���� �� �ִ� ��ü 
	
	//������ -> �ϳ��� ��ü�� ������� �� �ڵ����� DB ���� �ǵ��� 
	public UserDAO() {
		try {
			//port ��ȣ �ٸ��� connection�� �ȵ�. 
			String dbURL = "jdbc:mysql://localhost:3310/BBS?characterEncoding=UTF-8&serverTimezone=UTC&useSSL=false"; //�� ��ǻ���ּ��� 3306��Ʈ�� BBS�����ͺ��̽��� ���� 
			String dbID = "root";
			String dbPassword = "gayong4021";
			Class.forName("com.mysql.cj.jdbc.Driver");//mysql Driver ã�� �� �ְ� 
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);// ���� �Ϸ�Ǹ� conn ��ü �ȿ� ���ӵ� ������ ���.
		} catch (Exception e) {
			e.printStackTrace();//������ ���� ��� 
		}
	}
	
	public int login(String userID, String userPassword) {
		String SQL = "select userPassword from user where userID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);//DB�� SQL �� ���� 
			pstmt.setString(1, userID); //��ŷ���, ?�ڸ��� userID ���� 
			rs = pstmt.executeQuery();//rs�� ������ ����� �־��� 
			if(rs.next()) {
				//����� �����Ѵٸ� ����� 
				if(rs.getString(1).equals(userPassword)) {
					return 1;//�α��� ���� -> �Լ� ���� ���� 
				}
				else {
					return 0;//��й�ȣ ����ġ 
				}
			}
			//�׷��� �ʴٸ� 
			return -1;//���̵� ����. 
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -2;//�����ͺ��̽� ���� 
	}
	
	public int join(User user) {
		String SQL = "INSERT INTO USER (userID, userPassword, userName, userGender, userEmail) VALUES (?,?,?,?,?)";//���ʿ��� ����->����
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserGender());
			pstmt.setString(5, user.getUserEmail()); //sql�� ä���ֱ� 
			return pstmt.executeUpdate();//������ ����� �ݿ��� ���ڵ� �Ǽ� ��ȯ 
			
		} catch (Exception e) {
			
		}
		return -1;//�����ͺ��̽� ����
	}
}
