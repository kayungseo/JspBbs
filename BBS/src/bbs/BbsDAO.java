package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
//데이터 접근 객체
//실제 DB에 접근하고 데이터를 빼올 수 있도록 하는 클래스 
public class BbsDAO {

	//DAO는 데이터베이스 접근 객체.
	private Connection conn; //DB 접근하게 해주는 객체 
	//각 메소드끼리 데이터베이스 접근에 마찰이 일어나지 않게 하기 위해 preparedStatment는 지움 
	private ResultSet rs; // 어떤 정보 담을 수 있는 객체 
	
	//생성자 -> 하나의 객체를 만들었을 때 자동으로 DB 연결 되도록 
	public BbsDAO() {
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
	
	//method1
	public String getDate() {
		//현재시간 가져와, 게시판 작성시 현재 서버시간 넣어주는 역할 
		String SQL = "select now()";//현재시간 가져오는 mysql 문장 
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);//SQL을 실행 준비 단계로.
			rs=pstmt.executeQuery();//쿼리문 실행 결과 가져옴
			if(rs.next()) { //결과가 있는 경우 
				return rs.getString(1);//결과(현재 시간) 반환
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return "";
	}
	
	//method2
	public int getNext() {
		String SQL = "select bbsID from bbs order by bbsID desc";//마지막에 쓰인 글 가져옴
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);//SQL을 실행 준비 단계로.
			rs=pstmt.executeQuery();//쿼리문 실행 결과 가져옴-select 구문 사용시 
			if(rs.next()) { //결과가 있는 경우 
				return rs.getInt(1) + 1;//다음 게시글 번호 반환 
			}
			return 1;//처음 게시물인 경우 
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	//method3
	public int write(String bbsTitle, String userID, String bbsContent) {
		String SQL = "insert into bbs values (?,?,?,?,?,?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);//SQL을 실행 준비 단계로.
			pstmt.setInt(1, getNext());
			pstmt.setString(2, bbsTitle);
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, bbsContent);
			pstmt.setInt(6, 1);
			return pstmt.executeUpdate();//insert의 경우 성공 수행, int 타입의 0이상의 결과(1) 반환  
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;//insert 오류의 경우 
	}
	
	//method4
	public ArrayList<Bbs> getList(int pageNumber){//글쓰기를 하면 입력한 내용이 데이터베이스에 먼저 저장됨. 그렇게 삽입된 내용을 게시판 목록에서 보여주기 위해 DB에서 해당 데이터를 가져옴. 
		String SQL = "select * from bbs where bbsID < ? and bbsAvailable = 1 order by bbsID desc limit 10"; 
		ArrayList<Bbs> list = new ArrayList<Bbs>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);//SQL을 실행 준비 단계로.
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs=pstmt.executeQuery();//쿼리문 실행 결과 가져옴-select 구문 사용시 
			while(rs.next()) { 
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				list.add(bbs);//list에 해당 인스턴스를 담아서, 
			} 
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;//반환 
	}
	
	public boolean nextPage(int pageNumber) {//페이징 처리 위해 
		String SQL = "select * from bbs where bbsID < ? and bbsAvailable = 1";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);//SQL을 실행 준비 단계로.
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs=pstmt.executeQuery();//쿼리문 실행 결과 가져옴-select 구문 사용시 
			if(rs.next()) { //결과가 있는 경우 
				return true; 
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public Bbs getBbs(int bbsID) { // 하나의 글 내용 불러오는 함수 
		String SQL = "select * from bbs where bbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);//SQL을 실행 준비 단계로.
			pstmt.setInt(1, bbsID);
			rs=pstmt.executeQuery();//쿼리문 실행 결과 가져옴-select 구문 사용시 
			if(rs.next()) { //결과가 있는 경우 
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
			PreparedStatement pstmt = conn.prepareStatement(SQL);//SQL을 실행 준비 단계로.
			pstmt.setString(1, bbsTitle);
			pstmt.setString(2, bbsContent);
			pstmt.setInt(3, bbsID);
		
			return pstmt.executeUpdate();//insert의 경우 성공 수행, int 타입의 0이상의 결과(1) 반환  
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;//데이터베이스 update 오류의 경우 
	}
	
	public int delete(int bbsID) { //parameter : 어떤 글인지 알 수 있도록  bbsID로 한다. 
		String SQL = "update bbs set bbsAvailable = 0 where bbsID=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);//SQL을 실행 준비 단계로
			pstmt.setInt(1, bbsID);
			return pstmt.executeUpdate();//insert의 경우 성공 수행, int 타입의 0이상의 결과(1) 반환  
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;//데이터베이스 update 오류의 경우  
	}
	
}
	
	
	