package xyz.nailro.dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import xyz.nailro.dto.ReviewDTO;
public class ReviewDAO extends JdbcDAO {
    private static ReviewDAO _dao;
    private ReviewDAO() {
        // 생성자 내용 필요시 작성
    }
    static {
        _dao = new ReviewDAO();
    }
    public static ReviewDAO getDAO() {
        return _dao;
    }
    // detail.jsp 하단에 review를 출력하는 메소드
    public List<ReviewDTO> selectProductReviews(int productId) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<ReviewDTO> reviews = new ArrayList<>();
        try {
            con = getConnection();
            String sql = "SELECT review_num, review_client_num, review_subject, review_content, review_order_num, review_date,"
            		+ " review_image, review_status, review_rating,review_product_num FROM review WHERE review_order_num = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, productId);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                ReviewDTO review = new ReviewDTO();
                review.setReviewNum(rs.getInt("review_num"));
                review.setReviewClientNum(rs.getInt("review_client_num"));
                review.setReviewSubject(rs.getString("review_subject"));
                review.setReviewContent(rs.getString("review_content"));
                review.setReviewOrderNum(rs.getInt("review_order_num"));
                review.setReviewDate(rs.getString("review_date"));
                review.setReviewImage(rs.getString("review_image"));
                review.setReviewStatus(rs.getInt("review_status"));
                review.setReviewRating(rs.getString("review_rating")); // 새로 추가된 필드 설정
                review.setReviewProductNum(rs.getInt("review_product_num"));
                
                reviews.add(review);
            }
        } catch (SQLException e) {
            System.out.println("[에러] selectProductReviews() 메소드의 SQL 오류 = " + e.getMessage());
        } finally {
            close(con, pstmt, rs);
        }
        return reviews;
    }
    // 검색정보(검색대상과 검색단어)를 전달받아 REVIEW 테이블에 저장된 게시글 중 검색대상의 컬럼에 검색단어가 포함된 게시글의 갯수를 검색하여 반환하는 메소드
    public int selectTotalReview(String search, String keyword, int clientNum) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int totalCount = 0;
        try {
            con = getConnection();
            if (keyword.equals("")) {
                String sql = "SELECT count(*) FROM review where review_client_num =?";
                pstmt = con.prepareStatement(sql);
                pstmt.setInt(1, clientNum);
            } else {
                String sql = "SELECT count(*) FROM review WHERE review_client_num =?" + search + " LIKE '%' || ? || '%'";
                pstmt = con.prepareStatement(sql);
                pstmt.setInt(1, clientNum);
                pstmt.setString(2, keyword);
            }
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                totalCount = rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("[에러] selectTotalReview() 메소드의 SQL 오류 = " + e.getMessage());
        } finally {
            close(con, pstmt, rs);
        }
        return totalCount;
    }
    
    // REVIEW_SEQ 시퀸스의 다음값(정수값)을 검색하여 반환하는 메소드
    public int selectReviewNextNum() {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int nextNum = 0;
        try {
            con = getConnection();
            String sql = "SELECT review_seq.nextval FROM dual";
            pstmt = con.prepareStatement(sql);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                nextNum = rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("[에러] selectReviewNextNum() 메소드의 SQL 오류 = " + e.getMessage());
        } finally {
            close(con, pstmt, rs);
        }
        return nextNum;
    }
    // 게시글을 전달받아 REVIEW 테이블에 행으로 삽입하고 삽입행의 갯수를 반환하는 메소드
    public int insertReview(ReviewDTO review) {
        Connection con = null;
        PreparedStatement pstmt = null;
        int rows = 0;
        try {
            con = getConnection();
            String sql = "INSERT INTO review VALUES (review_seq.nextval, ?, ?, ?, ?, SYSDATE, ?, 1, ?,?)";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, review.getReviewClientNum());
            pstmt.setString(2, review.getReviewSubject());
            pstmt.setString(3, review.getReviewContent());
            pstmt.setInt(4, review.getReviewOrderNum());
            pstmt.setString(5, review.getReviewImage());
            pstmt.setString(6, review.getReviewRating());
            pstmt.setInt(7, review.getReviewProductNum());
            rows = pstmt.executeUpdate();
        } catch (SQLException e) {
            System.out.println("[에러] insertReview() 메소드의 SQL 오류 = " + e.getMessage());
        } finally {
            close(con, pstmt);
        }
        return rows;
    }
    // 글번호를 전달받아 REVIEW 테이블의 단일행을 검색하여 게시글(ReviewDTO 객체)을 반환하는 메소드
    public ReviewDTO selectReviewByNum(int reviewNum) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        ReviewDTO review = null;
        try {
            con = getConnection();
            String sql = "SELECT review_num, review_client_num, review_subject, review_content, review_order_num, review_date, review_image, "
            		+ "review_status, review_rating,review_product_num FROM review WHERE review_num = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, reviewNum);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                review = new ReviewDTO();
                review.setReviewNum(rs.getInt("review_num"));
                review.setReviewClientNum(rs.getInt("review_client_num"));
                review.setReviewSubject(rs.getString("review_subject"));
                review.setReviewContent(rs.getString("review_content"));
                review.setReviewOrderNum(rs.getInt("review_order_num"));
                review.setReviewDate(rs.getString("review_date"));
                review.setReviewImage(rs.getString("review_image"));
                review.setReviewStatus(rs.getInt("review_status"));
                review.setReviewRating(rs.getString("review_rating")); // 새로 추가된 필드 설정
                review.setReviewProductNum(rs.getInt("review_product_num"));
            }
        } catch (SQLException e) {
            System.out.println("[에러] selectReviewByNum() 메소드의 SQL 오류 = " + e.getMessage());
        } finally {
            close(con, pstmt, rs);
        }
        return review;
    }
    // 게시글을 전달받아 REVIEW 테이블의 저장된 행의 컬럼값을 변경하고 변경행의 갯수를 반환하는 메소드
    public int updateReview(ReviewDTO review) {
        Connection con = null;
        PreparedStatement pstmt = null;
        int rows = 0;
        try {
            con = getConnection();
            String sql;
            if (review.getReviewImage() == null) {
                sql = "UPDATE review SET review_subject = ?, review_content = ?, review_date = SYSDATE, review_rating = ? WHERE review_num = ?";
                pstmt = con.prepareStatement(sql);
                pstmt.setString(1, review.getReviewSubject());
                pstmt.setString(2, review.getReviewContent());
                pstmt.setString(3, review.getReviewRating());
                pstmt.setInt(4, review.getReviewNum());
            } else {
                sql = "UPDATE review SET review_subject = ?, review_content = ?, review_image = ?, review_date = SYSDATE, review_rating = ? WHERE review_num = ?";
                pstmt = con.prepareStatement(sql);
                pstmt.setString(1, review.getReviewSubject());
                pstmt.setString(2, review.getReviewContent());
                pstmt.setString(3, review.getReviewImage());
                pstmt.setString(4, review.getReviewRating());
                pstmt.setInt(5, review.getReviewNum());
            }
            rows = pstmt.executeUpdate();
        } catch (SQLException e) {
            System.out.println("[에러] updateReview() 메소드의 SQL 오류 = " + e.getMessage());
        } finally {
            close(con, pstmt);
        }
        return rows;
    }
    
    
    //리뷰삭제 DAO
    public int deleteReviewByNum (int reviewNum) {
        Connection con = null;
        PreparedStatement pstmt = null;
        int rows = 0;
        try {
            con = getConnection();
            String sql = "delete from review where review_num = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, reviewNum);
           
            rows = pstmt.executeUpdate();
        } catch (SQLException e) {
            System.out.println("[에러] 리뷰삭제() 메소드의 SQL 오류 = " + e.getMessage());
        } finally {
            close(con, pstmt);
        }
        return rows;
    }
    
    //detail페이지에서 하단에 productNum으로 관련 review만 출력하는 dao
    public List<ReviewDTO> selectProductReviewsForProduct(int productNum) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<ReviewDTO> reviewList = new ArrayList<ReviewDTO>();
        try {
            con = getConnection();
            String sql = "SELECT review.review_num, review.review_client_num, client.client_name, " +
                        "review.review_subject, review.review_content, review.review_date, review.review_image, " +
                        "review.review_status, review.review_rating, review.review_product_num " +
                        "FROM review INNER JOIN client ON review.review_client_num = client.client_num " +
                        "WHERE review.review_product_num = ? " +
                        "ORDER BY review.review_num DESC";
            
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, productNum);
            
            rs = pstmt.executeQuery();
            while (rs.next()) {
                ReviewDTO review = new ReviewDTO();
                review.setReviewNum(rs.getInt("review_num"));
                review.setReviewClientNum(rs.getInt("review_client_num"));
                review.setReviewName(rs.getString("client_name")); // client_name 컬럼을 reviewName 필드에 설정
                review.setReviewSubject(rs.getString("review_subject"));
                review.setReviewContent(rs.getString("review_content"));
                review.setReviewDate(rs.getString("review_date"));
                review.setReviewImage(rs.getString("review_image"));
                review.setReviewStatus(rs.getInt("review_status"));
                review.setReviewRating(rs.getString("review_rating"));
                review.setReviewProductNum(rs.getInt("review_product_num"));
                reviewList.add(review);
            } 
        } catch (SQLException e) {
            System.out.println("[에러] selectProductReviewsForProduct 메소드의 SQL 오류 = " + e.getMessage());
        } finally {
            close(con, pstmt, rs);
        }
        return reviewList;
    }

    //review_list 페이지에서 내가 작성한 리뷰만 불러오는 dao
    public List<ReviewDTO> selectReviewListByClientNum(int startRow, int endRow, String search, String keyword, int clientNum) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<ReviewDTO> reviewList = new ArrayList<ReviewDTO>();
        try {
            con = getConnection();
            String sql = "";
            if (keyword.equals("")) {
                sql = "SELECT * FROM (SELECT ROWNUM rn, r.* FROM (SELECT review.review_num, review.review_client_num, client.client_name, "
                        + "review.review_subject, review.review_content, review.review_date, review.review_image, "
                        + "review.review_status, review.review_rating, review.review_product_num "
                        + "FROM review INNER JOIN client ON review.review_client_num = client.client_num WHERE review.review_client_num = ? "
                        + "ORDER BY review.review_num DESC) r) WHERE rn BETWEEN ? AND ?";
                pstmt = con.prepareStatement(sql);
                pstmt.setInt(1, clientNum);
                pstmt.setInt(2, startRow);
                pstmt.setInt(3, endRow);
            } else {
                sql = "SELECT * FROM (SELECT ROWNUM rn, r.* FROM (SELECT review.review_num, review.review_client_num,"
                        + " client.client_name, review.review_subject, review.review_content, review.review_date, "
                        + "review.review_image, review.review_status, review.review_rating, review.review_product_num "
                        + "FROM review INNER JOIN client ON review.review_client_num = client.client_num "
                        + "WHERE review.review_client_num = ? AND " + search + " LIKE '%' || ? || '%' "
                        + "ORDER BY review.review_date DESC, review.review_num DESC) r) WHERE rn BETWEEN ? AND ?";
                pstmt = con.prepareStatement(sql);
                pstmt.setInt(1, clientNum);
                pstmt.setString(2, keyword);
                pstmt.setInt(3, startRow);
                pstmt.setInt(4, endRow);
            }
            
            rs = pstmt.executeQuery();
            while (rs.next()) {
                ReviewDTO review = new ReviewDTO();
                review.setReviewNum(rs.getInt("review_num"));
                review.setReviewClientNum(rs.getInt("review_client_num"));
                review.setReviewName(rs.getString("client_name")); // client_name 컬럼을 reviewName 필드에 설정
                review.setReviewSubject(rs.getString("review_subject"));
                review.setReviewContent(rs.getString("review_content"));
                review.setReviewDate(rs.getString("review_date"));
                review.setReviewImage(rs.getString("review_image"));
                review.setReviewStatus(rs.getInt("review_status"));
                review.setReviewRating(rs.getString("review_rating"));
                review.setReviewProductNum(rs.getInt("review_product_num"));
                reviewList.add(review);
            }
        } catch (SQLException e) {
            System.out.println("[에러] selectReviewListByClientNum() 메소드의 SQL 오류 = " + e.getMessage());
        } finally {
            close(con, pstmt, rs);
        }
        return reviewList;
    }

    
    }