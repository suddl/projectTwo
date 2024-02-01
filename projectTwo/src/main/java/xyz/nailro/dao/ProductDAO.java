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
	
	//네일(숏) 버튼용
	public List<ProductDTO> selectNailShortType()	{
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<ProductDTO> shortTypeList=new ArrayList<ProductDTO>();
		try	{
			con=getConnection();
			
			String sql="select product_image, product_name, product_price from product where product_type = ? order by product_num desc";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, "short");
			
		
			rs=pstmt.executeQuery();
				
			while(rs.next())	{
				ProductDTO product = new ProductDTO();
				product.setProduct_image(rs.getString("product_image"));
				product.setProduct_name(rs.getString("product_name"));
				product.setProduct_price(rs.getInt("product_price"));		
		
				shortTypeList.add(product);
			}
			
		} catch (SQLException e)	{
			System.out.println("[에러]selectNailShortType() 메소드의 SQL 오류 ="+e.getMessage());
		} finally	{
			close(con, pstmt, rs);
		}
		return shortTypeList;
	}

	//네일(롱) 버튼용
	public List<ProductDTO> selectNailLongType()	{
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<ProductDTO> longTypeList=new ArrayList<ProductDTO>();
		try	{
			con=getConnection();
			
			String sql="select product_image, product_name, product_price from product where product_type = ? order by product_num desc";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, "long");
			
		
			rs=pstmt.executeQuery();
				
			while(rs.next())	{
				ProductDTO product = new ProductDTO();
				product.setProduct_image(rs.getString("product_image"));
				product.setProduct_name(rs.getString("product_name"));
				product.setProduct_price(rs.getInt("product_price"));		
		
				longTypeList.add(product);
			}
			
		} catch (SQLException e)	{
			System.out.println("[에러]selectNailLongType() 메소드의 SQL 오류 ="+e.getMessage());
		} finally	{
			close(con, pstmt, rs);
		}
		return longTypeList;
	}
	
	//네일(파츠) 버튼용
	public List<ProductDTO> selectNailPartsType()	{
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<ProductDTO> partsTypeList=new ArrayList<ProductDTO>();
		try	{
			con=getConnection();
			
			String sql="select product_image, product_name, product_price from product where product_type = ? order by product_num desc";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, "parts");
			
		
			rs=pstmt.executeQuery();
				
			while(rs.next())	{
				ProductDTO product = new ProductDTO();
				product.setProduct_image(rs.getString("product_image"));
				product.setProduct_name(rs.getString("product_name"));
				product.setProduct_price(rs.getInt("product_price"));		
		
				partsTypeList.add(product);
			}
			
		} catch (SQLException e)	{
			System.out.println("[에러]selectNailPartsType() 메소드의 SQL 오류 ="+e.getMessage());
		} finally	{
			close(con, pstmt, rs);
		}
		return partsTypeList;
	}
	
	//네일(풀컬러) 버튼용
	public List<ProductDTO> selectFullcolorType()	{
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<ProductDTO> fullcolorTypeList=new ArrayList<ProductDTO>();
		try	{
			con=getConnection();
			
			String sql="select product_image, product_name, product_price from product where product_type = ? order by product_num desc";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, "fullcolor");
			
		
			rs=pstmt.executeQuery();
				
			while(rs.next())	{
				ProductDTO product = new ProductDTO();
				product.setProduct_image(rs.getString("product_image"));
				product.setProduct_name(rs.getString("product_name"));
				product.setProduct_price(rs.getInt("product_price"));		
		
				fullcolorTypeList.add(product);
			}
			
		} catch (SQLException e)	{
			System.out.println("[에러]selectNailFullcolorType() 메소드의 SQL 오류 ="+e.getMessage());
		} finally	{
			close(con, pstmt, rs);
		}
		return fullcolorTypeList;
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
	
	//상품 페이지(네일)
	public List<ProductDTO> selectNailList()	{
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<ProductDTO> nailList=new ArrayList<ProductDTO>();
		try	{
			con=getConnection();
			
			String sql="select product_image, product_name, product_price from product where product_category = ? order by product_num desc";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, "nail");
			
			rs=pstmt.executeQuery();
			
		while(rs.next())	{
			ProductDTO product = new ProductDTO();
			product.setProduct_image(rs.getString("product_image"));
			product.setProduct_name(rs.getString("product_name"));
			product.setProduct_price(rs.getInt("product_price"));
			
			nailList.add(product);
			}
		}	catch (SQLException e) {
			System.out.println("[에러]selectNailList() 메소드의 오류 =");
		}	finally	{
			close(con, pstmt, rs);
		}
		return nailList;
	}

	//상품 페이지(페디)
	public List<ProductDTO> selectPediList()	{
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<ProductDTO> pediList=new ArrayList<ProductDTO>();
		try	{
			con=getConnection();
			
			String sql="select product_image, product_name, product_price from product where product_category = ? order by product_num desc";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, "pedi");
			
			rs=pstmt.executeQuery();
			
		while(rs.next())	{
			ProductDTO product = new ProductDTO();
			product.setProduct_image(rs.getString("product_image"));
			product.setProduct_name(rs.getString("product_name"));
			product.setProduct_price(rs.getInt("product_price"));
			
			pediList.add(product);
			}
		}	catch (SQLException e) {
			System.out.println("[에러]selectNailList() 메소드의 오류 =");
		}	finally	{
			close(con, pstmt, rs);
		}
		return pediList;
	}

	//상품 페이지(케어&툴)
	public List<ProductDTO> careList()	{
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<ProductDTO> careList=new ArrayList<ProductDTO>();
		try	{
			con=getConnection();
			
			String sql="select product_image, product_name, product_price from product where product_category = ? order by product_num desc";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, "nail");
			
			rs=pstmt.executeQuery();
			
		while(rs.next())	{
			ProductDTO product = new ProductDTO();
			product.setProduct_image(rs.getString("product_image"));
			product.setProduct_name(rs.getString("product_name"));
			product.setProduct_price(rs.getInt("product_price"));
			
			careList.add(product);
			}
		}	catch (SQLException e) {
			System.out.println("[에러]selectNailList() 메소드의 오류 =");
		}	finally	{
			close(con, pstmt, rs);
		}
		return careList;
	}
	
}