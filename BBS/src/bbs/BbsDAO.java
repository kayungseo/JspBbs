package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
//������ ���� ��ü
//���� DB�� �����ϰ� �����͸� ���� �� �ֵ��� �ϴ� Ŭ���� 
public class BbsDAO {

	//DAO�� �����ͺ��̽� ���� ��ü.
	private Connection conn; //DB �����ϰ� ���ִ� ��ü 
	//�� �޼ҵ峢�� �����ͺ��̽� ���ٿ� ������ �Ͼ�� �ʰ� �ϱ� ���� preparedStatment�� ���� 
	private ResultSet rs; // � ���� ���� �� �ִ� ��ü 
	
	//������ -> �ϳ��� ��ü�� ������� �� �ڵ����� DB ���� �ǵ��� 
	public BbsDAO() {
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
	
	//method1
	public String getDate() {
		//����ð� ������, �Խ��� �ۼ��� ���� �����ð� �־��ִ� ���� 
		String SQL = "select now()";//����ð� �������� mysql ���� 
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);//SQL�� ���� �غ� �ܰ��.
			rs=pstmt.executeQuery();//������ ���� ��� ������
			if(rs.next()) { //����� �ִ� ��� 
				return rs.getString(1);//���(���� �ð�) ��ȯ
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return "";
	}
	
	//method2
	public int getNext() {
		String SQL = "select bbsID from bbs order by bbsID desc";//�������� ���� �� ������
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);//SQL�� ���� �غ� �ܰ��.
			rs=pstmt.executeQuery();//������ ���� ��� ������-select ���� ���� 
			if(rs.next()) { //����� �ִ� ��� 
				return rs.getInt(1) + 1;//���� �Խñ� ��ȣ ��ȯ 
			}
			return 1;//ó�� �Խù��� ��� 
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	//method3
	public int write(String bbsTitle, String userID, String bbsContent) {
		String SQL = "insert into bbs values (?,?,?,?,?,?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);//SQL�� ���� �غ� �ܰ��.
			pstmt.setInt(1, getNext());
			pstmt.setString(2, bbsTitle);
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, bbsContent);
			pstmt.setInt(6, 1);
			return pstmt.executeUpdate();//insert�� ��� ���� ����, int Ÿ���� 0�̻��� ���(1) ��ȯ  
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;//insert ������ ��� 
	}
	
	//method4
	public ArrayList<Bbs> getList(int pageNumber){//�۾��⸦ �ϸ� �Է��� ������ �����ͺ��̽��� ���� �����. �׷��� ���Ե� ������ �Խ��� ��Ͽ��� �����ֱ� ���� DB���� �ش� �����͸� ������. 
		String SQL = "select * from bbs where bbsID < ? and bbsAvailable = 1 order by bbsID desc limit 10"; 
		ArrayList<Bbs> list = new ArrayList<Bbs>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);//SQL�� ���� �غ� �ܰ��.
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs=pstmt.executeQuery();//������ ���� ��� ������-select ���� ���� 
			while(rs.next()) { 
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				list.add(bbs);//list�� �ش� �ν��Ͻ��� ��Ƽ�, 
			} 
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;//��ȯ 
	}
	
	public boolean nextPage(int pageNumber) {//����¡ ó�� ���� 
		String SQL = "select * from bbs where bbsID < ? and bbsAvailable = 1";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);//SQL�� ���� �غ� �ܰ��.
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs=pstmt.executeQuery();//������ ���� ��� ������-select ���� ���� 
			if(rs.next()) { //����� �ִ� ��� 
				return true; 
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public Bbs getBbs(int bbsID) { // �ϳ��� �� ���� �ҷ����� �Լ� 
		String SQL = "select * from bbs where bbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);//SQL�� ���� �غ� �ܰ��.
			pstmt.setInt(1, bbsID);
			rs=pstmt.executeQuery();//������ ���� ��� ������-select ���� ���� 
			if(rs.next()) { //����� �ִ� ��� 
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				return bbs;
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int update(int bbsID, String bbsTitle, String bbsContent) {
		String SQL = "update bbs set bbsTitle=?, bbsContent=? where bbsID=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);//SQL�� ���� �غ� �ܰ��.
			pstmt.setString(1, bbsTitle);
			pstmt.setString(2, bbsContent);
			pstmt.setInt(3, bbsID);
		
			return pstmt.executeUpdate();//insert�� ��� ���� ����, int Ÿ���� 0�̻��� ���(1) ��ȯ  
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;//�����ͺ��̽� update ������ ��� 
	}
	
	public int delete(int bbsID) { //parameter : � ������ �� �� �ֵ���  bbsID�� �Ѵ�. 
		String SQL = "update bbs set bbsAvailable = 0 where bbsID=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);//SQL�� ���� �غ� �ܰ��
			pstmt.setInt(1, bbsID);
			return pstmt.executeUpdate();//insert�� ��� ���� ����, int Ÿ���� 0�̻��� ���(1) ��ȯ  
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;//�����ͺ��̽� update ������ ���  
	}
	
}
	
	
	