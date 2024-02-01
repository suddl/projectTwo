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
	
	//네일 버튼용
	public List<ProductDTO> selectNailType(String product_type)	{
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<ProductDTO> nailTypeList=new ArrayList<ProductDTO>();
		try	{
			con=getConnection();
			
			String sql="select product_image, product_name, product_price from product where product_type = ? order by product_num desc";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, "product_type");
			
		
			rs=pstmt.executeQuery();
				
			while(rs.next())	{
				ProductDTO type = new ProductDTO();
				type.setProduct_image(rs.getString("product_image"));
				type.setProduct_name(rs.getString("product_name"));
				type.setProduct_price(rs.getInt("product_price"));		
		
				nailTypeList.add(type);
			}
			
		} catch (SQLException e)	{
			System.out.println("[에러]selectNailType() 메소드의 SQL 오류 ="+e.getMessage());
		} finally	{
			close(con, pstmt, rs);
		}
		return nailTypeList;
	}
	
	//상품 검색 결과
	public List<ProductDTO> searchProduct(String search, String keyword)	{
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<ProductDTO> searchProductList=new ArrayList<ProductDTO>();
		try	{
			con=getConnection();
			if(keyword.equals(""))	{
				System.out.println("검색어를 입력해주세요");
			}	else	{
				String sql="select product_image, product_name, product_price from product where "+search+"like '%'||?||'%' order by product_num desc";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, keyword);
			}
			rs=pstmt.executeQuery();
			while(rs.next())	{
				ProductDTO product = new ProductDTO();
				product.setProduct_image(rs.getString("product_image"));
				product.setProduct_name(rs.getString("product_name"));
				product.setProduct_price(rs.getInt("product_price"));	
				
				searchProductList.add(product);
			}
		}	catch (SQLException e)	{
			System.out.println("[에러]searchProduct() 메소드의 오류 ="+e.getMessage());
		}	finally	{
			close(con, pstmt, rs);
		}
		return searchProductList;
	}
	
	//상품 검색 결과 개수
	public int selectTotalSearchProduct(String search, String keyword)	{
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int totalCount=0;
		try	{
			con=getConnection();
			if(keyword.equals(""))	{
				System.out.println("검색어를 입력해주세요");
			} else	{
				String sql="select count(*) from product where"+search+"like '%'||?||'%'";
				
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, keyword);
			}
			
			rs=pstmt.executeQuery();
			
			if(rs.next())	{
				totalCount=rs.getInt(1);
			}
		}	catch (SQLException e)	{
			System.out.println("[에러]selectTotalSearchProduct() 메소드의 오류 = "+e.getMessage());
		}	finally	{
			close(con, pstmt, rs);
		}
		return totalCount;
	}
	
	//상품 페이지(new)
	public List<ProductDTO> selectNewProductList()	{
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<ProductDTO> newProductList=new ArrayList<ProductDTO>();
		try	{
			con=getConnection();
			
			String sql="select product_image, product_name, product_price from product order by product_num desc";
			pstmt=con.prepareStatement(sql);
			
			rs=pstmt.executeQuery();
			
		while(rs.next())	{
			ProductDTO product = new ProductDTO();
			product.setProduct_image(rs.getString("product_image"));
			product.setProduct_name(rs.getString("product_name"));
			product.setProduct_price(rs.getInt("product_price"));
			
			newProductList.add(product);
			}
		}	catch (SQLException e) {
			System.out.println("[에러]selectNailList() 메소드의 오류 =");
		}	finally	{
			close(con, pstmt, rs);
		}
		return newProductList;
	}
	
	//상품 페이지(네일, 페디, 케어)
	public List<ProductDTO> selectProductByCategory(String category)	{
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<ProductDTO> productList=new ArrayList<ProductDTO>();
		try	{
			con=getConnection();
			
			String sql="select product_image, product_name, product_price from product where product_category = ? order by product_num desc";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, "product_category");
			
			rs=pstmt.executeQuery();
			
			while(rs.next())	{
			ProductDTO product = new ProductDTO();
			product.setProduct_image(rs.getString("product_image"));
			product.setProduct_name(rs.getString("product_name"));
			product.setProduct_price(rs.getInt("product_price"));
			
			productList.add(product);
			}
		}	catch (SQLException e) {
			System.out.println("[에러]selectNailList() 메소드의 오류 =");
		}	finally	{
			close(con, pstmt, rs);
		}
		return productList;
	}	
}