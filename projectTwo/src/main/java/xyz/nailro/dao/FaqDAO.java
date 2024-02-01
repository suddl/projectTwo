package xyz.nailro.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import xyz.nailro.dto.FaqDTO;

public class FaqDAO extends JdbcDAO {
	private static FaqDAO _dao;
	
	private FaqDAO() {
		// TODO Auto-generated constructor stub
	}
	
	static {
		_dao=new FaqDAO();		
	}
	
	public static FaqDAO getDAO() {
		return _dao;
	}
	
	//검색정보(검색대상과 검색단어)를 전달받아 FAQ 테이블에 저장된 게시글 중 검색대상의 
	//컬럼에 검색단어가 포함된 게시글의 갯수를 검색하여 반환하는 메소드
	// => 검색 기능을 사용하지 않을 경우 FAQ 테이블에 저장된 모든 게시글의 갯수를 검색하여 반환
	public int selectTotalFaq(String search, String keyword) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int totalCount=0;
		try {
			con=getConnection();
			
			//매개변수에 저장된 값을 비교하여 접속된 DBMS 서버에 다른 SQL 명령을 전달하여 실행
			// => 동적 SQL(Dynamic SQL)
			if(keyword.equals("")) {//검색 기능을 사용하지 않은 경우
				String sql="select count(*) from faq";
				pstmt=con.prepareStatement(sql);
			} else {//검색 기능을 사용한 경우
				//게시글 제목을 검색하기 위해 REVIEW 테이블과 MEMBER 테이블의 행을 결합하여 검색
				String sql="select count(*) from faq where "+search+" like '%'||?||'%'";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, keyword);
			}
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				totalCount=rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectTotalFaq() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return totalCount;
	}
	
	//페이징 처리 관련 정보(시작 행번호와 종료 행번호)와 게시글 검색 기능 관련 정보(검색대상과
	//검색단어)를 전달받아 FAQ 테이블에 저장된 행을 검색하여 게시글 목록을 반환하는 메소드
	public List<FaqDTO> selectFaqList(int startRow, int endRow, String search, String keyword) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<FaqDTO> faqList=new ArrayList<FaqDTO>();
		try {
			con=getConnection();
			
			if(keyword.equals("")) {//검색 기능을 사용하지 않은 경우
				String sql="select * from (select rownum rn, temp.* from (select faq_num"
					+ ", faq_subject, faq_content, faq_category from faq) temp)"
					+ " where rn between ? and ?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, startRow);
				pstmt.setInt(2, endRow);
			} else {//검색 기능을 사용한 경우
				String sql="select * from (select rownum rn, temp.* from (select faq_num"
					+ ", faq_subject, faq_content, faq_category from faq where "+search
					+" like '%'||?||'%') temp) where rn between ? and ?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, keyword);
				pstmt.setInt(2, startRow);
				pstmt.setInt(3, endRow);
			}
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				FaqDTO faq=new FaqDTO();
				faq.setFaqNum(rs.getInt("faq_num"));
				faq.setFaqSubject(rs.getString("faq_subject"));
				faq.setFaqContent(rs.getString("faq_content"));
				faq.setFaqCategory(rs.getString("faq_category"));
				
				faqList.add(faq);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectFaqList() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return faqList;
	}
	
	//FAQ_SEQ 시퀸스의 다음값(정수값)을 검색하여 반환하는 메소드
	public int selectFaqNextNum() {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int nextNum=0;
		try {
			con=getConnection();
			
			String sql="select faq_seq.nextval from dual";
			pstmt=con.prepareStatement(sql);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				nextNum=rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectFaqNextNum() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return nextNum;
	}
	
	//게시글을 전달받아 FAQ 테이블에 행으로 삽입하고 삽입행의 갯수를 반환하는 메소드
	public int insertFaq(FaqDTO faq) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="insert into faq values(?,?,?,?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, faq.getFaqNum());
			pstmt.setString(2, faq.getFaqSubject());
			pstmt.setString(3, faq.getFaqContent());
			pstmt.setString(4, faq.getFaqCategory());
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]insertFaq() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	
	//글번호를 전달받아 FAQ 테이블의 단일행을 검색하여 게시글(FaqDTO 객체)을 반환하는 메소드
	public FaqDTO selectFaqByNum(int faqNum) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		FaqDTO faq=null;
		try {
			con=getConnection();
			
			String sql="select faq_num, faq_subject, faq_content, faq_category"
			+" from faq where faq_num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, faqNum);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				faq=new FaqDTO();
				faq.setFaqNum(rs.getInt("faq_num"));
				faq.setFaqSubject(rs.getString("faq_subject"));
				faq.setFaqContent(rs.getString("faq_content"));
				faq.setFaqCategory(rs.getString("faq_category"));
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectFaqByNum() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return faq;
	}
}