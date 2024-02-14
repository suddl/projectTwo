package xyz.nailro.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
/**
 CREATE TABLE PAYMENT(
	PAY_NUM NUMBER PRIMARY KEY,
	PAY_CLIENT_NUM NUMBER REFERENCES CLIENT(CLIENT_NUM),
	PAY_PRICE NUMBER NOT NULL,
	PAY_METHOD VARCHAR2(50) NOT NULL);
 */
public class PaymentDAO extends JdbcDAO{
	private static PaymentDAO  _dao;
	
	private PaymentDAO() {
		
	}
	
	static {
		_dao=new PaymentDAO();
	}
	
	public static PaymentDAO  getDAO() {
		return _dao;
	}
	
	
	//회원번호를 전달받아 결제테이블의 행으로 삽입하고 삽입행의 갯수를 반환하는 메소드
	public int insertPayment(int nextNum, String clientNum, String finalMoney, String checkedPayment ) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="insert into payment values(?,?,?,?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, nextNum);
			pstmt.setString(2, clientNum);
			pstmt.setString(3, finalMoney);
			pstmt.setString(4, checkedPayment);
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]insertPayment() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	
	//REVIEW_SEQ 시퀸스의 다음값(정수값)을 검색하여 반환하는 메소드
	public int selectPaymentNextNum() {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int nextNum=0;
		try {
			con=getConnection();
			
			String sql="select payment_seq.nextval from dual";
			pstmt=con.prepareStatement(sql);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				nextNum=rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectPaymentNextNum() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return nextNum;
	}
	
	
	
	

}
