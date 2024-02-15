package xyz.nailro.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

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
	
	//검색정보(검색대상과 검색단어)를 전달받아 Orders 테이블에 저장된 주문내역 중 검색대상의 
	//컬럼에 검색단어가 포함된 주문내역의 갯수를 검색하여 반환하는 메소드
	public int selectTotalOrder(String search, String keyword) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int totalCount=0;
		try {
			con=getConnection();
			
			if(keyword.equals("")) {//검색 기능을 사용하지 않은 경우
				String sql="select count(*) from orders";
				pstmt=con.prepareStatement(sql);
			} else {//검색 기능을 사용한 경우
				String sql="select count(*) from orders left join client on order_client_num=client_num"
						+ " left join payment on order_client_num=pay_client_num where "+search+" like '%'||?||'%'";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, keyword);
			}
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				totalCount=rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectTotalOrder() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return totalCount;
	}
	
	//페이징 처리 관련 정보(시작 행번호와 종료 행번호)와 상품글 검색 기능 관련 정보(검색대상과
	//검색단어)를 전달받아 Orders 테이블에 저장된 행을 검색하여 상품글 목록을 반환하는 메소드
	public List<OrderDTO> selectOrderList(int startRow, int endRow, String search, String keyword) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<OrderDTO> orderList=new ArrayList<OrderDTO>();
		
		try {
			con=getConnection();
			
			if(keyword.equals("")) {//검색 기능을 사용하지 않은 경우
				String sql= "select * from (select rownum rn, temp.* from (select order_num, client_id"
						+ ", pay_num, product_name, order_quntity, client_phone, pay_price, pay_method, order_status, order_date from orders"
						+ " join payment on order_pay_num=pay_num join client on order_client_num=client_num join"
						+ " product on order_product_num=product_num order by order_num desc) temp) where rn between ? and ?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, startRow);
				pstmt.setInt(2, endRow);
			} else {//검색 기능을 사용한 경우
				String sql ="select * from (select rownum rn, temp.* from (select order_num, client_id"
						+ ", pay_num, product_name, order_quntity, client_phone, pay_price, pay_method, order_status, order_date from orders"
						+ " join payment on order_pay_num=pay_num join client on order_client_num=client_num join"
						+ " product on order_product_num=product_num"
						+ " where " + search + " like '%'||?||'%' order by order_num desc) temp)"
						+ " where rn between ? and ?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, keyword);
				pstmt.setInt(2, startRow);
				pstmt.setInt(3, endRow);
			}
			
			rs=pstmt.executeQuery();
			  
			while(rs.next()) {
				OrderDTO order=new OrderDTO();
				order.setOrderNum(rs.getString("order_num"));  
				order.setOrderId(rs.getString("client_id"));
				order.setOrderPayNum(rs.getInt("pay_num"));
				order.setOrderProductName(rs.getString("product_name"));
				order.setOrderQuntity(rs.getString("order_quntity"));
				order.setOrderPhone(rs.getString("client_phone"));
				order.setOrderPayPrice(rs.getString("pay_price"));
				order.setOrderPayMethod(rs.getString("pay_method"));
				order.setOrderDate(rs.getString("order_date"));
				order.setOrderStatus(rs.getString("order_status"));
	
				orderList.add(order);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectOrderList() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return orderList;
	}


	public List<OrderDTO> selectOrderReviewList(int startRow, int endRow, String search, String keyword) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<OrderDTO> orderReviewList=new ArrayList<OrderDTO>();
		
		try {
			con=getConnection();
			
			if(keyword.equals("")) {//검색 기능을 사용하지 않은 경우
				String sql= "select * from (select rownum rn, temp.* from (select order_num, order_pay_num, product_name"
						+ " ,order_client_num, order_product_num, order_date, pay_price from orders"
						+ "  join client on order_client_num=client_num  join product on order_product_num=product_num"
						+ " join payment on pay_client_num=client_num order by order_num desc) temp) where rn between ? and ?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, startRow);
				pstmt.setInt(2, endRow);
			} else {//검색 기능을 사용한 경우
				String sql ="select * from (select rownum rn, temp.* from (select order_num, order_pay_num"
						+ ", order_client_num, order_product_num, order_date, pay_price from orders"
						+ " join client on order_client_num=client_num join product on order_product_num=product_num"
						+ " join payment on pay_client_num=client_num where " + search + " like '%'||?||'%' order by order_num desc) temp)"
						+ " where rn between ? and ?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, keyword);
				pstmt.setInt(2, startRow);
				pstmt.setInt(3, endRow);
			}
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				OrderDTO order=new OrderDTO();
				order.setOrderNum(rs.getString("order_num"));
				order.setOrderPayNum(rs.getInt("order_pay_num"));
				order.setOrderProductName(rs.getString("product_name"));
				order.setOrderClientNum(rs.getString("order_client_num"));
				order.setOrderProductNum(rs.getString("order_product_num"));
				order.setOrderDate(rs.getString("order_date"));
				order.setOrderPayPrice(rs.getString("pay_price"));
	
				orderReviewList.add(order);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectOrderList() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return orderReviewList;
	}
		
	
	public int selectTotalOrderReview(String search, String keyword, int loginClientNum) {
		Connection con= null;
		PreparedStatement pstmt= null;
		ResultSet rs= null;
		int totalCount=0;
		try {
			con=getConnection();
			
			if(keyword.equals("")) {	// 검색기능을 사용하지 않은 경우
				String sql="select count(*) from payment where pay_client_num =?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, loginClientNum);
			} else {
				String sql = "select count(*) from payment join client on pay_client_num=client_num where pay_client_num =? and "+search+" like '%'||?||'%' ";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, loginClientNum);
				pstmt.setString(2, keyword);
			}
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				totalCount=rs.getInt(1);
			}
			
		} catch (SQLException e) {
			System.out.println("[에러]selectTotalOrderReview() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return totalCount;
	}
		
}