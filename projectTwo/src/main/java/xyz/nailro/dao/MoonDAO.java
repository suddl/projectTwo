package xyz.nailro.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import xyz.nailro.dto.MoonDTO;

public class MoonDAO extends JdbcDAO {
	private static MoonDAO _dao;
	
	public MoonDAO() {
		// TODO Auto-generated constructor stub
	}
	
	static {
		_dao = new MoonDAO();
	}
	
	public static MoonDAO getDAO() {
		return _dao;
	}
	
	// 검색정보(검색대상과 검색단어)를 전달받아 moon 테이블에 저장된 게시글 중 검색대상의 컬럼에 검색단어가
	// 포함된 게시글의 갯수를 검색하여 반환하는 메소드
	// => 검색 기능을 사용하지 않을 경우 moon 테이블에 저장된 모든 게시글의 갯수를 검색해 반환
	public int selectTotalMoon(String search, String keyword, int moonClientNum) {
		Connection con= null;
		PreparedStatement pstmt= null;
		ResultSet rs= null;
		int totalCount=0;
		try {
			con=getConnection();
			
			if(keyword.equals("")) {	// 검색기능을 사용하지 않은 경우
				String sql="select count(*) from moon where moon_client_name=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, moonClientNum);
			} else {
				String sql = "select count(*) from moon join member on moon_client_num=member_num"
						+ "where moon_client_name=? " + search + "like '%'||?||'%' ";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, moonClientNum);
				pstmt.setString(2, keyword);
			}
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				totalCount=rs.getInt(1);
			}
			
		} catch (SQLException e) {
			System.out.println("[에러]selectTotalMoon() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return totalCount;
	}
	
	// 페이징 처리 관련 정보와 게시글 검색 기능 관련 정보를 전달받아 moon 테이블에 저장된 행을 검색하여 게시글 목록 반환
	public List<MoonDTO> selectMoonList(int startRow, int endRow, String search, String keyword) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<MoonDTO> moonList=new ArrayList<MoonDTO>();
		try {
			con= getConnection();
			
			if(keyword.equals("")) {
				String sql ="select * from (select rownum rn, temp.* from (select moon_num"
						+ ", moon_member, moon_title, moon_date, moon_status from moon join member where rn between ? and ?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, startRow);
				pstmt.setInt(2, endRow);
			} else {
				String sql ="select * from (select rownum rn, temp.* from (select moon_num"
						+ ", moon_member, moon_title, moon_date, moon_status from moon join member on moon_member=member_num "
						+ " where " + search + "like '%'||?||'%' moon_status <> 3 order by moon_num) temp)"
						+ " where rn between ? and ?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, keyword);
				pstmt.setInt(2, startRow);
				pstmt.setInt(3, endRow);
			}
			
		} catch (SQLException e) {
			System.out.println("[에러]selectMoonList() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return moonList;
	}
}
