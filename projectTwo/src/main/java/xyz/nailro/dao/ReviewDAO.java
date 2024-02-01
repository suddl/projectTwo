package xyz.nailro.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.jasper.tagplugins.jstl.core.Catch;

import xyz.nailro.dto.ReviewDTO;

public class ReviewDAO extends JdbcDAO{
		private static ReviewDAO _dao;
		
		private ReviewDAO() {
			// TODO Auto-generated constructor stub
		}
		
		static {
			_dao=new ReviewDAO();		
		}
		
		public static ReviewDAO getDAO() {
			return _dao;
		}
		//detail.jsp하단에 review를 출력하는 메소드
		public List<ReviewDTO> selectProductReviews(int productId) {
		    Connection con = null;
		    PreparedStatement pstmt = null;
		    ResultSet rs = null;
		    List<ReviewDTO> reviews = new ArrayList<>();

		    try {
		        con = getConnection();
		        String sql = "SELECT review_subject, review_content, review_image FROM review WHERE review_order_num = ?";
		        pstmt = con.prepareStatement(sql);
		        pstmt.setInt(1, productId);

		        rs = pstmt.executeQuery();
		        while (rs.next()) {
		            ReviewDTO review = new ReviewDTO();
		            review.setReview_subject(rs.getString("review_subject"));
		            review.setReview_content(rs.getString("review_content"));
		            review.setReview_image(rs.getString("review_image"));
		            reviews.add(review);
		        }
		    } catch (SQLException e) {
		        System.out.println("[에러] selectProductReviews() 메소드의 SQL 오류 = " + e.getMessage());
		    } finally {
		        close(con, pstmt, rs);
		    }
		    return reviews;
		}
		
		//검색정보(검색대상과 검색단어)를 전달받아 REVIEW 테이블에 저장된 게시글 중 검색대상의 
		//컬럼에 검색단어가 포함된 게시글의 갯수를 검색하여 반환하는 메소드
		// => 검색 기능을 사용하지 않을 경우 REVIEW 테이블에 저장된 모든 게시글의 갯수를 검색하여 반환
		public int selectTotalReview(String search, String keyword) {
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			int totalCount=0;
			try {
				con=getConnection();
				
				//매개변수에 저장된 값을 비교하여 접속된 DBMS 서버에 다른 SQL 명령을 전달하여 실행
				// => 동적 SQL(Dynamic SQL)
			
				

			} catch (SQLException e) {
				System.out.println("[에러]selectTotalReview() 메소드의 SQL 오류 = "+e.getMessage());
			} finally {
				close(con, pstmt, rs);
			}
			return totalCount;
		}
		
		//페이징 처리 관련 정보(시작 행번호와 종료 행번호)와 게시글 검색 기능 관련 정보(검색대상과
		//검색단어)를 전달받아 REVIEW 테이블에 저장된 행을 검색하여 게시글 목록을 반환하는 메소드
		public List<ReviewDTO> selectReviewList(int startRow, int endRow, String search, String keyword) {
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			List<ReviewDTO> reviewList=new ArrayList<ReviewDTO>();
			try {
				con=getConnection();
				
				if(keyword.equals("")) {//검색 기능을 사용하지 않은 경우
					String sql="select * from (select rownum rn, temp.* from (select review_num"
							+ ", review_client_num, review_name,review_subject,reveiw_content,"
							+ "reveiw_content,review_date,review_image,review_re from review join client"
							+ "on review_client_num=client_num order by review_num desc) temp)"
							+"where rn between? and ?";
					pstmt=con.prepareStatement(sql);
					pstmt.setInt(1, startRow);
					pstmt.setInt(2, endRow);
				} else {//검색 기능을 사용한 경우
					String sql="select * from (select rownum rn, temp.* from (select review_num"
							+ ", review_client_num, review_name,review_subject,reveiw_content,"
							+ "reveiw_content,review_date,review_image,review_re from review join client"
							+ "on review_client_num=client_num where "+search+"like '%'||?||'%'"
							+ "and review_date=1 order by review_date desc, review_date)temp)"
							+ " where rn between ? and ?";
					pstmt=con.prepareStatement(sql);
					pstmt.setString(1, keyword);
					pstmt.setInt(2, startRow);
					pstmt.setInt(3, endRow);
				}
				
				rs=pstmt.executeQuery();
				
				while(rs.next()) {
					ReviewDTO review=new ReviewDTO();
					review.setReview_num(rs.getInt("review_num"));
					review.setReview_client_num(rs.getInt("review_client_num"));
					review.setReview_name(rs.getString("review_name"));
					review.setReview_subject(rs.getString("review_subject"));
					review.setReview_content(rs.getString("review_content"));
					review.setReview_order_num(rs.getInt("review_order_num"));
					review.setReview_date(rs.getString("review_date"));
					review.setReview_image(rs.getString("review_image"));
					review.setReview_re(rs.getString("review_re"));
							
					reviewList.add(review);
				}
			} catch (SQLException e) {
				System.out.println("[에러]selectReviewList() 메소드의 SQL 오류 = "+e.getMessage());
			} finally {
				close(con, pstmt, rs);
			}
			return reviewList;
		}
		
		//REVIEW_SEQ 시퀸스의 다음값(정수값)을 검색하여 반환하는 메소드
		public int selectReivewNextNum() {
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			int nextNum=0;
			try {
				con=getConnection();
				
				String sql="select review_seq.nextval from dual";
				pstmt=con.prepareStatement(sql);
				
				rs=pstmt.executeQuery();
				
				if(rs.next()) {
					nextNum=rs.getInt(1);
				}
			} catch (SQLException e) {
				System.out.println("[에러]selectReivewNextNum() 메소드의 SQL 오류 = "+e.getMessage());
			} finally {
				close(con, pstmt, rs);
			}
			return nextNum;
		}
		
		//게시글을 전달받아 REVIEW 테이블에 행으로 삽입하고 삽입행의 갯수를 반환하는 메소드
		public int insertReview(ReviewDTO review) {
			Connection con=null;
			PreparedStatement pstmt=null;
			int rows=0;
			try {
				con=getConnection();
				
				String sql="insert into review values(?,?,?,?,?,?,sysdate,?,?)";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, review.getReview_num());
				pstmt.setInt(2, review.getReview_client_num());
				pstmt.setString(3, review.getReview_name());
				pstmt.setString(4, review.getReview_subject());
				pstmt.setString(5, review.getReview_content());
				pstmt.setInt(6, review.getReview_order_num());
				pstmt.setString(7, review.getReview_date());
				pstmt.setString(8, review.getReview_image());
				pstmt.setString(9, review.getReview_re());
				
				rows=pstmt.executeUpdate();
			} catch (SQLException e) {
				System.out.println("[에러]insertReview() 메소드의 SQL 오류 = "+e.getMessage());
			} finally {
				close(con, pstmt);
			}
			return rows;
		}
		
		//부모글 관련 정보를 전달받아 REVIEW 테이블에 저장된 행에서 REVIEW_REF 컬럼값과 REVIEW_RESTEP
		//컬럼값을 비교하여 REVIEW_RESTEP 컬럼값이 1 증가되도록 변경하고 변경행의 갯수를 반환하는 메소드
		/*
		public int updateReviewReStep(int ref, int restep) {
			Connection con=null;
			PreparedStatement pstmt=null;
			int rows=0;
			try {
				con=getConnection();
				
				String sql="update review set review_restep=review_restep+1"
						+ " where review_ref=? and review_restep>?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, ref);
				pstmt.setInt(2, restep);
							
				rows=pstmt.executeUpdate();
			} catch (SQLException e) {
				System.out.println("[에러]updateReviewReStep() 메소드의 SQL 오류 = "+e.getMessage());
			} finally {
				close(con, pstmt);
			}
			return rows;
		}
		*/
		
		//글번호를 전달받아 REVIEW 테이블의 단일행을 검색하여 게시글(ReviewDTO 객체)을 반환하는 메소드
		public ReviewDTO selectReviewByNum(int reviewNum) {
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			ReviewDTO review=null;
			try {
				con=getConnection();
				
				String sql="select review_num,review_client_num,review_name,review_subject"
				+",review_content,review_order_num,review_date,review_image,review_re"
				+" from review join client on review.review_client_num=client.client_num" 
				+" where review_num=? and review_client_num <>0";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, reviewNum);
				
				rs=pstmt.executeQuery();
				
				if(rs.next()) {
					review=new ReviewDTO();
					review.setReview_num(rs.getInt("review_num"));
					review.setReview_client_num(rs.getInt("review_client_num"));
					review.setReview_name(rs.getString("review_name"));
					review.setReview_subject(rs.getString("review_subject"));
					review.setReview_content(rs.getString("review_content"));
					review.setReview_order_num(rs.getInt("review_order_num"));
					review.setReview_date(rs.getString("review_date"));
					review.setReview_image(rs.getString("review_image"));
					review.setReview_re(rs.getString("review_re"));
				}
			} catch (SQLException e) {
				System.out.println("[에러]selectReviewByNum() 메소드의 SQL 오류 = "+e.getMessage());
			} finally {
				close(con, pstmt, rs);
			}
			return review;
		}
		
		//글번호를 전달받아 REVIEW 테이블의 저장된 행의 게시글 조회수가 1 증가되도록 변경하고 
		//변경행의 갯수를 반환하는 메소드
		public int updateReviewReadCount(int reviewNum) {
			Connection con=null;
			PreparedStatement pstmt=null;
			int rows=0;
			try {
				con=getConnection();
				
				String sql="update review set review_readcount=review_readcount+1"
						+ " where review_num=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, reviewNum);
							
				rows=pstmt.executeUpdate();
			} catch (SQLException e) {
				System.out.println("[에러]updateReviewReadCount() 메소드의 SQL 오류 = "+e.getMessage());
			} finally {
				close(con, pstmt);
			}
			return rows;
		}
		
		//게시글을 전달받아 REVIEW 테이블의 저장된 행의 컬럼값을 변경하고 변경행의 갯수를 반환하는 메소드
		public int updateReview(ReviewDTO review) {
			Connection con=null;
			PreparedStatement pstmt=null;
			int rows=0;
			try {
				con=getConnection();
				
				//사용자가 이미지 파일을 입력하지 않은 경우 - 이미지 파일 미변경(기존 이미지 파일 사용)
				if(review.getReview_image()==null) {
					String sql="update review set review_subject=?,review_content=?"
							+ ",review_date=sysdate where review_num=?";
					pstmt=con.prepareStatement(sql);
					pstmt.setString(1, review.getReview_subject());
					pstmt.setString(2, review.getReview_content());
					pstmt.setInt(3, review.getReview_num());
				} else {//사용자가 이미지 파일을 입력하지 않은 경우 - 이미지 파일 변경
					String sql="update review set review_subject=?,review_content=?,review_image=?"
							+ ",review_date=sysdate where review_num=?";
					pstmt=con.prepareStatement(sql);
					pstmt.setString(1, review.getReview_subject());
					pstmt.setString(2, review.getReview_content());
					pstmt.setString(3, review.getReview_image());
					pstmt.setInt(4, review.getReview_num());
				}			
					
				rows=pstmt.executeUpdate();
			} catch (SQLException e) {
				System.out.println("[에러]updateReview() 메소드의 SQL 오류 = "+e.getMessage());
			} finally {
				close(con, pstmt);
			}
			return rows;		
		}
	}

