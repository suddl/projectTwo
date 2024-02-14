package xyz.nailro.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import xyz.nailro.dto.OrderDTO;
import xyz.nailro.dto.ReviewDTO;

public class OrderDAO extends JdbcDAO{
	private static OrderDAO _dao;
	
	public OrderDAO() {
		// TODO Auto-generated constructor stub
	}
	
	static {
		_dao = new OrderDAO();
	}
	
	public static OrderDAO getDAO() {
		return _dao;
	}
	
	//회원정보와 주문정보를 전달받아 Orders 테이블의 행으로 삽입하고 삽입행의 갯수를 반환하는 메소드
	public int insertOrders(int nextNum, String clientNum, String proNumresult, String address1, String address2, String zipcode, String proQuanresult ) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="insert into orders values(orders_seq.nextval,?,?,?,?,?,?,?,sysdate,1)";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, nextNum);
			pstmt.setString(2, clientNum);
			pstmt.setString(3, proNumresult);
			pstmt.setString(4, address1);
			pstmt.setString(5, address2);
			pstmt.setString(6, zipcode);
			pstmt.setString(7, proQuanresult);
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]insertOrders() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	
	//혜원추가)oderNum을 받아 order 테이블의 단일행을 검색하여 orderDTO 객체를 반환하는 메소드
	public OrderDTO selectOrderByNum(int orderNum) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        OrderDTO order = null;
        try {
            con = getConnection();
            String sql = "SELECT order_num, order_client_num, order_product_num FROM orders WHERE order_num = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, orderNum);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                order = new OrderDTO ();
                order.setOrderNum(rs.getString("order_num"));
                order.setOrderClientNum(rs.getString("order_client_num"));
                order.setOrderProductNum(rs.getString("order_product_num"));
            
            }
        } catch (SQLException e) {
            System.out.println("[에러] selectReviewByNum() 메소드의 SQL 오류 = " + e.getMessage());
        } finally {
            close(con, pstmt, rs);
        }
        return order;
    }
	
	
	
	
	
	
	

}
