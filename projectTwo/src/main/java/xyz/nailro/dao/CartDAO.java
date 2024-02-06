package xyz.nailro.dao;

import java.sql.Connection;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import xyz.nailro.dto.ClientDTO;
import xyz.nailro.dto.CartDTO;


public class CartDAO extends JdbcDAO{
	private static CartDAO _dao;
	
	private CartDAO() {
		
	}
	
	static {
		_dao=new CartDAO();
	}
	
	public static CartDAO getDAO() {
		return _dao;
	}
	
	//cart 테이블의 저장된 모든 행을 검색하여 카트목록 반환하는 메소드
	
	public List<CartDTO> selectCartList(int ClientNum){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs=null;
		List<CartDTO> cartList = new ArrayList<CartDTO>();
		
		try {
			con = getConnection();
			
			String sql = "select car_num, cart_quantity, cart_product, cart_client_num,"
					+ "product_name, product_price,client_id,client_name, client_phone, client_email, "
					+ "client_address1,client_address2, client_zipcode from client join cart"
					+ " on cart_client_num=client_num join product"
					+ " on cart_product=product_num where client_num=?"
					+ " order by car_num";
			
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, ClientNum);
			rs = pstmt.executeQuery();
			
			
			while(rs.next()) {
				CartDTO cart = new CartDTO();
				cart.setCarNum(String.valueOf(rs.getInt("car_num")));
				cart.setCartQuantity(String.valueOf(rs.getInt("cart_quantity")));
				cart.setCartProduct(String.valueOf(rs.getInt("cart_product")));
				cart.setCartClientNum(String.valueOf(rs.getInt("cart_client_num")));
				cart.setCartProductName(rs.getString("product_name"));
				cart.setCartProductPrice(String.valueOf(rs.getInt("product_price")));
				cart.setClientId(rs.getString("client_id"));
				cart.setClientName(rs.getString("client_name"));
				cart.setClientPhone(rs.getString("client_phone"));
				cart.setClientEmail(rs.getString("client_email"));
				cart.setClientAddress1(rs.getString("client_address1"));
				cart.setClientAddress2(rs.getString("client_address2"));
				cart.setClientZipCode(rs.getString("client_zipcode"));
				
				
				cartList.add(cart);
			}
					
			
		} catch (SQLException e) {
			System.out.println("selectCartList 에러"+ e.getMessage());
		}finally {
			close(con, pstmt, rs);
		}
		
		return cartList;
	}
	

	//회원정보를 전달받아 MEMBER 테이블의 행으로 삽입하고 삽입행의 갯수를 반환하는 메소드
	public int insertCart(int quantity, int ProducNum, int CNum ) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="insert into cart values(cart_SEQ.nextval,?,?,?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, quantity);
			pstmt.setInt(2, ProducNum);
			pstmt.setInt(3, CNum);
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]insertCart() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
}
