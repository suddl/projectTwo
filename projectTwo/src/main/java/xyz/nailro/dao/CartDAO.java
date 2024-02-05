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
	/*
	public List<cartDTO> selectCarttList(){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs=null;
		List<cartDTO> cartList = new ArrayList<cartDTO>();
		
		try {
			con = getConnection();
			
			String sql = "select cart_id, goods_no, goods_name, goods_price, surang from goods join cart"
					+ " on goods_name=Ingoods_name; order by goods_no";
			
			pstmt=con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				cartDTO cart = new cartDTO();
				cart=new cartDTO();
				cart.setCartId(rs.getInt("cart_id"));
				cart.setGoodsNo(rs.getInt("goods_no"));
				cart.setGoodsName(rs.getString("goods_name"));
				cart.setGoodsPrice(rs.getString("goods_price"));
				cart.setSurang(rs.getInt("surang"));
				
				cartList.add(cart);
			}
					
			
		} catch (SQLException e) {
			// TODO: handle exception
		}finally {
			
		}
		
		return cartList;
	}
	*/

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
