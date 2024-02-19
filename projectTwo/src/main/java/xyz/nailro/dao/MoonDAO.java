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
				String sql="select count(*) from moon where moon_client_num =?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, moonClientNum);
			} else {
				String sql = "select count(*) from moon join client on moon_client_num=client_num where moon_client_num =? and "+search+" like '%'||?||'%' and  moon_status=1";
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
	
	public int selectTotalAllMoon(String search, String keyword) {
		Connection con= null;
		PreparedStatement pstmt= null;
		ResultSet rs= null;
		int totalCount=0;
		try {
			con=getConnection();
			
			if(keyword.equals("")) {	// 검색기능을 사용하지 않은 경우
				String sql="select count(*) from moon";
				pstmt=con.prepareStatement(sql);
			} else {
				String sql = "select count(*) from moon join client on moon_client_num=client_num where "+search+" like '%'||?||'%' and  moon_status=1";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, keyword);
			}
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				totalCount=rs.getInt(1);
			}
			
		} catch (SQLException e) {
			System.out.println("[에러]selectTotalAllMoon() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return totalCount;
	}
	
	// 페이징 처리 관련 정보와 게시글 검색 기능 관련 정보를 전달받아 moon 테이블에 저장된 행을 검색하여 게시글 목록 반환
	public List<MoonDTO> selectMoonList(int startRow, int endRow, String search, String keyword, int moonClientNum) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<MoonDTO> moonList=new ArrayList<MoonDTO>();
		try {
			con= getConnection();
			
			if(keyword.equals("")) {
				String sql ="select * from (select rownum rn, temp.* from (select moon_num, moon_client_num,client_name, moon_title,moon_content,"
						+ " moon_date, moon_re, moon_image, moon_status from moon"
						+ " join client on moon_client_num=client_num where moon_client_num =? order by moon_num desc) temp) where rn between ? and ? ";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, moonClientNum);
				pstmt.setInt(2, startRow);
				pstmt.setInt(3, endRow);
			} else {
				String sql ="select * from (select rownum rn, temp.* from (select moon_num, moon_client_num,client_name, moon_title,moon_content,"
						+ " moon_date, moon_re, moon_image, moon_status from moon join client on  moon_client_num=client_num where " + search + " like '%'||?||'%' and moon_status =1 and  moon_client_num =? order by moon_num) temp) where rn between ? and ?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, keyword);
				pstmt.setInt(2, moonClientNum);
				pstmt.setInt(3, startRow);
				pstmt.setInt(4, endRow);
			}
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				MoonDTO moon=new MoonDTO();
				moon.setMoonNum(rs.getInt("moon_num"));
				moon.setMoonClientNum(rs.getInt("moon_client_num"));
				moon.setMoonName(rs.getString("client_name"));
				moon.setMoonTitle(rs.getString("moon_title"));
				moon.setMoonContent(rs.getString("moon_content"));
				moon.setMoonDate(rs.getString("moon_date"));
				moon.setMoonRe(rs.getString("moon_re"));
				moon.setMoonImage(rs.getString("moon_image"));
				moon.setMoonStatus(rs.getInt("moon_status"));
				
				moonList.add(moon);
			}
			
		} catch (SQLException e) {
			System.out.println("[에러]selectMoonList() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return moonList;
	}
	
	public List<MoonDTO> selectAllMoonList(int startRow, int endRow, String search, String keyword) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<MoonDTO> moonList=new ArrayList<MoonDTO>();
		try {
			con= getConnection();
			
			if(keyword.equals("")) {
				String sql ="select * from (select rownum rn, temp.* from (select moon_num"
						+ ", moon_client_num,client_name, moon_title,moon_content, moon_date, moon_re, moon_image, moon_status from moon"
						+ " join client on moon_client_num=client_num order by moon_num desc) temp) where rn between ? and ? ";
				pstmt=con.prepareStatement(sql);
				//pstmt.setInt(1, moonClientNum);
				pstmt.setInt(1, startRow);
				pstmt.setInt(2, endRow);
			} else {
				String sql ="select * from (select rownum rn, temp.* from (select moon_num"
						+ ", moon_client_num,client_name, moon_title,moon_content, moon_date, moon_re, moon_image, moon_status from moon"
						+ " join client on  moon_client_num=client_num "
						+ " where " + search + " like '%'||?||'%' and moon_status =1 order by moon_date desc) temp)"
						+ " where rn between ? and ?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, keyword);
				pstmt.setInt(2, startRow);
				pstmt.setInt(3, endRow);
			}
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				MoonDTO moon=new MoonDTO();
				moon.setMoonNum(rs.getInt("moon_num"));
				moon.setMoonClientNum(rs.getInt("moon_client_num"));
				moon.setMoonName(rs.getString("client_name"));
				moon.setMoonTitle(rs.getString("moon_title"));
				moon.setMoonContent(rs.getString("moon_content"));
				moon.setMoonDate(rs.getString("moon_date"));
				moon.setMoonRe(rs.getString("moon_re"));
				moon.setMoonImage(rs.getString("moon_image"));
				moon.setMoonStatus(rs.getInt("moon_status"));
				
				moonList.add(moon);
			}
			
		} catch (SQLException e) {
			System.out.println("[에러]selectAllMoonList() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return moonList;
	}
	
	public int selectMoonNextNum() {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int nextNum=0;
		try {
			con= getConnection();
			
			String sql="select moon_seq.nextval from dual";
			pstmt= con.prepareStatement(sql);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				nextNum=rs.getInt(1);
			}
		}catch (SQLException e) {
			System.out.println("[에러]selectMoonNextNum() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return nextNum;
	}
	
	public int insertMoon(MoonDTO moon) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			String sql="insert into moon values(?,?,?,?,sysdate,null,?,?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, moon.getMoonNum());
			pstmt.setInt(2, moon.getMoonClientNum());
			pstmt.setString(3, moon.getMoonTitle());
			pstmt.setString(4, moon.getMoonContent());
			pstmt.setString(5, moon.getMoonImage());
			pstmt.setInt(6, moon.getMoonStatus());
			
			rows=pstmt.executeUpdate();
		}catch (SQLException e) {
			System.out.println("[에러]insertMoon() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	public MoonDTO selectMoonByNum(int moonNum) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		MoonDTO moon=null;
		try {
			con=getConnection();
			String sql="select moon_num, moon_client_num,client_name moon_name, moon_title,moon_content, "
					+ "moon_date, moon_re, moon_image from moon join client on moon.moon_client_num=client.client_num "
					+ "where moon_num =?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, moonNum);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				moon=new MoonDTO();
				moon.setMoonNum(rs.getInt("moon_num"));
				moon.setMoonClientNum(rs.getInt("moon_client_num"));
				moon.setMoonName(rs.getString("moon_name"));
				moon.setMoonTitle(rs.getString("moon_title"));
				moon.setMoonContent(rs.getString("moon_content"));
				moon.setMoonDate(rs.getString("moon_date"));
				moon.setMoonRe(rs.getString("moon_re"));
				moon.setMoonImage(rs.getString("moon_image"));
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectMoonByNum() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return moon;
	}
	
	public int updateMoon(MoonDTO moon) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();

			if(moon.getMoonImage()==null) {
				String sql= "update moon set moon_title=?, moon_content=?, moon_status=?, moon_date=sysdate where moon_num=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, moon.getMoonTitle());
				pstmt.setString(2, moon.getMoonContent());
				pstmt.setInt(3, moon.getMoonStatus());
				pstmt.setInt(4, moon.getMoonNum());
				
			} else {
				String sql= "update moon set moon_title=?, moon_content=?, moon_image=?, moon_status=?, moon_date=sysdate where moon_num=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, moon.getMoonTitle());
				pstmt.setString(2, moon.getMoonContent());
				pstmt.setString(3, moon.getMoonImage());
				pstmt.setInt(4, moon.getMoonStatus());
				pstmt.setInt(5, moon.getMoonNum());
			}
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]updateMoon() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;		
	}
	
	public int updateReMoon(MoonDTO moon) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();

			if(moon.getMoonImage()==null) {
				String sql= "update moon set moon_re=? where moon_num=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, moon.getMoonRe());
				pstmt.setInt(2, moon.getMoonNum());
				
			} else {
				String sql= "update moon set moon_re=? where moon_num=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, moon.getMoonRe());
				pstmt.setInt(2, moon.getMoonNum());
			}
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]updateReMoon() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;		
	}
	
	public int updateReNullMoon(MoonDTO moon) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();

			if(moon.getMoonImage()==null) {
				String sql= "update moon set moon_re=null where moon_num=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, moon.getMoonNum());
				
			} else {
				String sql= "update moon set moon_re=null where moon_num=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, moon.getMoonNum());
			}
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]updateReNullMoon() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;		
	}
}
