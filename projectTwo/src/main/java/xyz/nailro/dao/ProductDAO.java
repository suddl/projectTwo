package xyz.nailro.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import xyz.nailro.dto.ProductDTO;
 
public class ProductDAO extends JdbcDAO	{
	private static ProductDAO _dao;
	
	public ProductDAO() {
		// TODO Auto-generated constructor stub
	}
	
	static	{
		_dao=new ProductDAO();
	}
	
	public static ProductDAO getDAO()	{
		return _dao;
	}
	
	//검색정보(검색대상과 검색단어)를 전달받아 PRODUCT 테이블에 저장된 상품글 중 검색대상의 
	//컬럼에 검색단어가 포함된 상품글의 갯수를 검색하여 반환하는 메소드
	// => 검색 기능을 사용하지 않을 경우 PRODUCT 테이블에 저장된 모든 상품글의 갯수를 검색하여 반환
	public int selectTotalProduct(String search, String keyword) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int totalCount=0;
		try {
			con=getConnection();
			
			//매개변수에 저장된 값을 비교하여 접속된 DBMS 서버에 다른 SQL 명령을 전달하여 실행
			// => 동적 SQL(Dynamic SQL)
			if(keyword.equals("")) {//검색 기능을 사용하지 않은 경우
				String sql="select count(*) from product";
				pstmt=con.prepareStatement(sql);
			} else {//검색 기능을 사용한 경우
				//상품명을 검색하기 위해 PRODUCT 테이블의 행을 검색
				String sql="select count(*) from product where "+search+" like '%'||?||'%'";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, keyword);
			}
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				totalCount=rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectTotalProduct() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return totalCount;
	}
	
	//페이징 처리 관련 정보(시작 행번호와 종료 행번호)와 상품글 검색 기능 관련 정보(검색대상과
	//검색단어)를 전달받아 PRODUCT 테이블에 저장된 행을 검색하여 상품글 목록을 반환하는 메소드
	public List<ProductDTO> selectProductList(int startRow, int endRow, String search, String keyword) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<ProductDTO> productList=new ArrayList<ProductDTO>();
		try {
			con=getConnection();
			
			if(keyword.equals("")) {//검색 기능을 사용하지 않은 경우
				String sql="select * from (select rownum rn, temp.* from (select product_num"
					+ ", product_name, product_image, product_image2, product_image3"
					+ ", product_price, product_category, product_type from product) temp)"
					+ " where rn between ? and ?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, startRow);
				pstmt.setInt(2, endRow);
			} else {//검색 기능을 사용한 경우
				String sql="select * from (select rownum rn, temp.* from (select product_num"
					+ ", product_name, product_image, product_image2, product_image3"
					+ ", product_price, product_category, product_type from product "
					+ " where "+search+" like '%'||?||'%') temp) where rn between ? and ?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, keyword);
				pstmt.setInt(2, startRow);
				pstmt.setInt(3, endRow);
			}
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				ProductDTO product=new ProductDTO();
				product.setProductNum(rs.getInt("product_num"));
				product.setProductName(rs.getString("product_name"));
				product.setProductImage(rs.getString("product_image"));
				product.setProductImage2(rs.getString("product_image2"));
				product.setProductImage3(rs.getString("product_image3"));
				product.setProductPrice(rs.getInt("product_price"));
				product.setProductCategory(rs.getString("product_category"));
				product.setProductType(rs.getString("product_type"));
			
				productList.add(product);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectProductList() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return productList;
	}
	
	//PRODUCT_SEQ 시퀸스의 다음값(정수값)을 검색하여 반환하는 메소드
	public int selectProductNextNum() {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int nextNum=0;
		try {
			con=getConnection();
			
			String sql="select product_seq.nextval from dual";
			pstmt=con.prepareStatement(sql);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				nextNum=rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectProductNextNum() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return nextNum;
	}
	
	//상품글을 전달받아 RPODUCT 테이블에 행으로 삽입하고 삽입행의 갯수를 반환하는 메소드
	public int insertProduct(ProductDTO product) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="insert into product values(?,?,?,?,?,?,?,?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, product.getProductNum());
			pstmt.setString(2, product.getProductName());
			pstmt.setString(3, product.getProductImage());
			pstmt.setString(4, product.getProductImage2());
			pstmt.setString(5, product.getProductImage3());
			pstmt.setInt(6, product.getProductPrice());
			pstmt.setString(7, product.getProductCategory());
			pstmt.setString(8, product.getProductType());
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]insertProduct() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	//상품번호를 전달받아 PRODUCT 테이블의 단일행을 검색하여 상품글(ProductDTO 객체)을 반환하는 메소드
	public ProductDTO selectProductByNum(int productNum) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		ProductDTO product=null;
		try {
			con=getConnection();
			
			String sql="select product_num, product_name, product_image, product_image2"
			+", product_image3, product_price, product_category, product_type"
			+" from product where product_num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, productNum);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				product=new ProductDTO();
				product.setProductNum(rs.getInt("product_num"));
				product.setProductName(rs.getString("product_name"));
				product.setProductImage(rs.getString("product_image"));
				product.setProductImage2(rs.getString("product_image2"));
				product.setProductImage3(rs.getString("product_image3"));
				product.setProductPrice(rs.getInt("product_price"));
				product.setProductCategory(rs.getString("product_category"));
				product.setProductType(rs.getString("product_type"));
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectProductByNum() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return product;
	}
	
	//상품글을 전달받아 PRODUCT 테이블의 저장된 행의 컬럼값을 변경하고 변경행의 갯수를 반환하는 메소드
	public int updateProduct(ProductDTO product) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="update product set product_name=?, product_image=?, product_image2=?"
					+ ", product_image3=?, product_price=?, product_category=?, product_type=? where product_num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, product.getProductName());
			pstmt.setString(2, product.getProductImage());
			pstmt.setString(3, product.getProductImage2());
			pstmt.setString(4, product.getProductImage3());
			pstmt.setInt(5, product.getProductPrice());
			pstmt.setString(6, product.getProductCategory());
			pstmt.setString(7, product.getProductType());
			pstmt.setInt(8, product.getProductNum());
					
		rows=pstmt.executeUpdate();
	} catch (SQLException e) {
		System.out.println("[에러]updateProduct() 메소드의 SQL 오류 = "+e.getMessage());
	} finally {
		close(con, pstmt);
	}
	return rows;		
}
	
	//상품번호(int)를 전달받아 PRODUCT 테이블에 저장된 행을 삭제하고 삭제행의 갯수(int)를 반환하는 메소드
	public int deleteProduct(int productNum) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="delete from product where product_num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, productNum);
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]deleteProduct() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	//검색 결과
	public List<ProductDTO> searchProduct(int startRow, int endRow, String keyword, String sorted, String productType) {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    List<ProductDTO> searchProductList = new ArrayList<ProductDTO>();

	    try {
	        con = getConnection();
	        if(productType==null || productType.equals(""))	{
	        String sql="select * from (select rownum rn, temp.* from (select product_num, product_image, product_name, "
					+ "product_price from product where product_category like ? or product_type like ?"
					+ "or product_name like ? order by " + sorted + " ) temp)"
					+ " where rn between ? and ?";
	        
	        pstmt = con.prepareStatement(sql);
	        String keywd = "%" + keyword + "%";
	        pstmt.setString(1, keywd);
	        pstmt.setString(2, keywd);
	        pstmt.setString(3, keywd);
	        pstmt.setInt(4, startRow);
	        pstmt.setInt(5, endRow);
	        
	        } else {
	        String sql="select * from (select rownum rn, temp.* from (select product_num, product_image, product_name, product_type, "
					+ "product_price from product where product_category like ? or product_type like ?"						
	        		+ "or product_name like ?) temp  where product_type=?)"					
					+ " where rn between ? and ? order by " + sorted;     
		        pstmt = con.prepareStatement(sql);
		        String keywd = "%" + keyword + "%";
		        pstmt.setString(1, keywd);
		        pstmt.setString(2, keywd);
		        pstmt.setString(3, keywd);
		        pstmt.setString(4, productType);
		        pstmt.setInt(5, startRow);
		        pstmt.setInt(6, endRow);	 
	        	
	        }
	        
	        rs = pstmt.executeQuery();

	        while (rs.next()) {
	            ProductDTO product = new ProductDTO();
	            product.setProductNum(rs.getInt("product_num"));
	            product.setProductName(rs.getString("product_name"));
	            product.setProductImage(rs.getString("product_image"));
	            product.setProductPrice(rs.getInt("product_price"));
	 
	            searchProductList.add(product);
	        }

	    } catch (SQLException e) {
	        System.out.println("[에러]searchProduct() 메소드의 SQL 오류 = " + e.getMessage());
	    } finally {
	        close(con, pstmt, rs);
	    }

	    return searchProductList;
	}
	//상품 검색 결과 개수
	public int selectTotalSearchProduct(String keyword, String productType) {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    int totalCount = 0;
	    try {
	        con = getConnection();
	        if (keyword.equals("")) {
	            String sql = "SELECT COUNT(*) FROM product";
	            pstmt = con.prepareStatement(sql);
	        } else {
	            String sql = "SELECT COUNT(*) FROM product WHERE product_name LIKE ? "
	                    + "OR product_category LIKE ? OR product_type LIKE ?";
	            // 첫 번째 PreparedStatement 객체
	            pstmt = con.prepareStatement(sql);
	            String keywd = "%" + keyword + "%";
	            pstmt.setString(1, keywd);
	            pstmt.setString(2, keywd);
	            pstmt.setString(3, keywd);
	            rs = pstmt.executeQuery();
	            
	            if(productType != null) {
	                String sql2 = "SELECT COUNT(*) FROM product WHERE (product_name LIKE ? "
	                        + "OR product_category LIKE ? OR product_type LIKE ?)AND product_type = ?";
	                PreparedStatement pstmt2 = con.prepareStatement(sql2);
	                pstmt2.setString(1, keywd);
	                pstmt2.setString(2, keywd);
	                pstmt2.setString(3, keywd);
	                pstmt2.setString(4, productType);
	                ResultSet rs2 = pstmt2.executeQuery(); // 새로운 ResultSet 사용
	                if (rs2.next()) {
	                    totalCount = rs2.getInt(1); // 결과를 totalCount에 저장
	                }
	                rs2.close(); // rs2를 닫음
	            } else {
	                if (rs.next()) {
	                    totalCount = rs.getInt(1);
	                }
	            }
	        }
	    } catch (SQLException e) {
	        System.out.println("[에러]selectTotalSearchProduct() 메소드의 오류 = " + e.getMessage());
	    } finally {
	        close(con, pstmt, rs);
	    }
	    return totalCount;
	}
	
	//detail에서 각각의 사진을 받아오는 DAO
		public List<ProductDTO> selectProductDetail(int productNum) {
			 Connection con = null;
			    PreparedStatement pstmt = null;
			    ResultSet rs = null;
			    List<ProductDTO> productList = new ArrayList<ProductDTO>();

			    try {
			        con = getConnection();

			        // product_num을 선택하도록 SQL 쿼리 수정
			        String sql = "SELECT product_name,product_image,product_image2,product_image3,"
			        		+ " product_price,product_category,product_type FROM product WHERE product_num = ?";
			        pstmt = con.prepareStatement(sql);
			        pstmt.setInt(1, productNum);

			        rs = pstmt.executeQuery();

			        while (rs.next()) {
			            ProductDTO product = new ProductDTO();
			            // product_num 필드에 대한 설정 추가
			            product.setProductName(rs.getString("product_name"));
			            product.setProductImage(rs.getString("product_image"));
			            product.setProductImage2(rs.getString("product_image2"));
			            product.setProductImage3(rs.getString("product_image3"));
			            product.setProductPrice(rs.getInt("product_price"));
			            product.setProductCategory(rs.getString("product_category"));
			            product.setProductType(rs.getString("product_type"));

			            productList.add(product);
			        }
			    } catch (SQLException e) {
			        // 더 구체적인 에러 메시지 출력
			        System.err.println("[에러] selectProductByCategory() 메소드의 오류: " + e.getMessage());
			    } finally {
			        close(con, pstmt, rs);
			    }
			    return productList;
	}
		
		//상품 페이지(네일, 페디, 케어 페이징 처리)
		public int selectTotalProductByCategory(String productCategory) {
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			int totalCount=0;
			try {
				con=getConnection();
				
					String sql="select count(*) from product where product_category = ? order by product_num DESC";
					pstmt=con.prepareStatement(sql);
					pstmt.setString(1, productCategory);
				
				
				rs=pstmt.executeQuery();
				
				if(rs.next()) {
					totalCount=rs.getInt(1);
				}
			} catch (SQLException e) {
				System.out.println("[에러]selectTotalProductByCategory() 메소드의 SQL 오류 = "+e.getMessage());
			} finally {
				close(con, pstmt, rs);
			}
			return totalCount;
		}
		
		//상품 페이지(New 페이징 처리)
		public int selectTotalProductByProductNum() {
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			int totalCount=0;
			try {
				con=getConnection();
				
				String sql="select count(*) from product order by product_num DESC";
				pstmt=con.prepareStatement(sql);
				
				
				rs=pstmt.executeQuery();
				
				if(rs.next()) {
					totalCount=rs.getInt(1);
				}
			} catch (SQLException e) {
				System.out.println("[에러]selectTotalProductByProductNum() 메소드의 SQL 오류 = "+e.getMessage());
			} finally {
				close(con, pstmt, rs);
			}
			return totalCount;
		}
		
		//페이징 처리 관련 정보(네일, 페디, 케어 / 시작 행번호와 종료 행번호)
		public List<ProductDTO> selectProductListByCategory(int startRow, int endRow, String productCategory, String productType, String sorted) {
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			List<ProductDTO> productList=new ArrayList<ProductDTO>();
			try {
				con=getConnection();
				
				if(productType==null ||  productType.equals("")) {
					String sql="select * from (select rownum rn, temp.* from (select product_num, product_image, product_name, "
						+ "product_price from product  where product_category=? order by "+sorted+") temp)"
						+ " where rn between ? and ?";
					pstmt=con.prepareStatement(sql);
					pstmt.setString(1, productCategory);
					pstmt.setInt(2, startRow);
					pstmt.setInt(3, endRow);
				} else {
					String sql="select * from (select rownum rn, temp.* from (select product_num, product_image, product_name, "
							+ "product_price from product  where product_type=? order by "+sorted+") temp)"
							+ " where rn between ? and ?";
					pstmt=con.prepareStatement(sql);
					pstmt.setString(1, productType);
					pstmt.setInt(2, startRow);
					pstmt.setInt(3, endRow);
				}

				
				rs=pstmt.executeQuery();
				
				while(rs.next()) {
					ProductDTO product=new ProductDTO();
					product.setProductNum(rs.getInt("product_num"));
					product.setProductImage(rs.getString("product_image"));
					product.setProductName(rs.getString("product_name"));
					product.setProductPrice(rs.getInt("product_price"));
					
					
					productList.add(product);
				}
			} catch (SQLException e) {
				System.out.println("[에러]selectProductListByCategory() 메소드의 SQL 오류 = "+e.getMessage());
			} finally {
				close(con, pstmt, rs);
			}
			return productList;
		}

		//페이징 처리 관련 정보(new / 시작 행번호와 종료 행번호)
		public List<ProductDTO> selectProductListByProductNum(int startRow, int endRow) {
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			List<ProductDTO> productList=new ArrayList<ProductDTO>();
			try {
				con=getConnection();
				
			
					String sql="select * from (select rownum rn, temp.* from (select product_num, product_image, product_name, product_price from product order by product_num) temp)"
						+ " where rn between ? and ?";
					pstmt=con.prepareStatement(sql);
	
					pstmt.setInt(1, startRow);
					pstmt.setInt(2, endRow);

				
				
				rs=pstmt.executeQuery();
				
				while(rs.next()) {
					ProductDTO product=new ProductDTO();
					product.setProductNum(rs.getInt("product_num"));
					product.setProductImage(rs.getString("product_image"));
					product.setProductName(rs.getString("product_name"));
					product.setProductPrice(rs.getInt("product_price"));
					
					
					productList.add(product);
				}
			} catch (SQLException e) {
				System.out.println("[에러]selectProductListByProductNum() 메소드의 SQL 오류 = "+e.getMessage());
			} finally {
				close(con, pstmt, rs);
			}
			return productList;
		}
		
		//상품 페이지(new)
		public List<ProductDTO> selectNewProductList()	{
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			List<ProductDTO> newProductList=new ArrayList<ProductDTO>();
			try	{
				con=getConnection();
				
				String sql="select product_num, product_image, product_name, product_price from product order by product_num desc";
				pstmt=con.prepareStatement(sql);
				
				rs=pstmt.executeQuery();
				
			while(rs.next())	{
				ProductDTO product = new ProductDTO();
				product.setProductNum(rs.getInt("product_num"));
				product.setProductImage(rs.getString("product_image"));
				product.setProductName(rs.getString("product_name"));
				product.setProductPrice(rs.getInt("product_price"));
				
				newProductList.add(product);
				}
			}	catch (SQLException e) {
				System.out.println("[에러t]selectProductList() 메소드의 오류 =");
			}	finally	{
				close(con, pstmt, rs);
			}
			return newProductList;  
		}	

}

