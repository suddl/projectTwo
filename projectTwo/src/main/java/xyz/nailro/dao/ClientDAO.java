package xyz.nailro.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import xyz.nailro.dto.ClientDTO;



public class ClientDAO extends JdbcDAO{
	private static ClientDAO _dao;
	
	public ClientDAO() {
	// TODO Auto-generated constructor stub
	
	}	
	static {
		_dao=new ClientDAO();
	}
	
	public static ClientDAO getDAO() {
		return _dao;
	}
	
	//아이디를 전달받아 MEMBER 테이블에 저장된 단일행을 검색하여 회원정보를 반환하는 메소드
		public ClientDTO selectClientById(String id) {
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			ClientDTO client=null;
			try {
				con=getConnection();
				
				String sql="select client_num,client_id,client_passwd,client_name,client_phone"
						+ ",client_email, client_address1,client_address2,client_zipcode"
						+ ",client_status from client where client_id=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, id);
				
				rs=pstmt.executeQuery();
				
				if(rs.next()) {
					client=new ClientDTO();
					client.setClientNum(rs.getInt("client_num"));
					client.setClientId(rs.getString("client_id"));
					client.setClientPasswd(rs.getString("client_passwd"));
					client.setClientName(rs.getString("client_name"));
					client.setClientPhone(rs.getString("client_phone"));
					client.setClientEmail(rs.getString("client_email"));
					client.setClientAddress1(rs.getString("client_address1"));
					client.setClientAddress2(rs.getString("client_address2"));
					client.setClientZipcode(rs.getString("client_zipcode"));
					client.setClientStatus(rs.getInt("client_status"));
				}
			} catch (SQLException e) {
				System.out.println("[에러]selectClientById() 메소드의 SQL 오류 = "+e.getMessage());
			} finally {
				close(con, pstmt, rs);
			}
			return client;
		}
		
		//회원번호를 전달받아 MEMBER 테이블에 저장된 행을 검색하여 회원정보를 반환하는 메소드
		public ClientDTO selectClientByNum(int clientNum) {
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			ClientDTO client=null;
			try {
				con=getConnection();
				
				String sql="select client_num,client_id,client_passwd,client_name,client_phone,client_email,"
						+"client_address1,client_address2,client_zipcode"
						+ ",client_status from client where client_num=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, clientNum);
				
				rs=pstmt.executeQuery();
				
				if(rs.next()) {
					client=new ClientDTO();
					client.setClientNum(rs.getInt("client_num"));
					client.setClientId(rs.getString("client_id"));
					client.setClientPasswd(rs.getString("client_passwd"));
					client.setClientName(rs.getString("client_name"));
					client.setClientPhone(rs.getString("client_phone"));
					client.setClientEmail(rs.getString("client_email"));
					client.setClientAddress1(rs.getString("client_address1"));
					client.setClientAddress2(rs.getString("client_address2"));
					client.setClientZipcode(rs.getString("client_zipcode"));
					client.setClientStatus(rs.getInt("client_status"));
				}
			} catch (SQLException e) {
				System.out.println("[에러]selectClientByNum() 메소드의 SQL 오류 = "+e.getMessage());
			} finally {
				close(con, pstmt, rs);
			}
			return client;
		}
		
		//회원정보를 전달받아 MEMBER 테이블의 행으로 삽입하고 삽입행의 갯수를 반환하는 메소드
		public int insertClient(ClientDTO client) {
			Connection con=null;
			PreparedStatement pstmt=null;
			int rows=0;
			try {
				con=getConnection();
				
				String sql="insert into client values(CLIENT_SEQ.nextval,?,?,?,?,?,?,?,?,1)";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, client.getClientId());
				pstmt.setString(2, client.getClientPasswd());
				pstmt.setString(3, client.getClientName());
				pstmt.setString(4, client.getClientPhone());
				pstmt.setString(5, client.getClientEmail());
				pstmt.setString(6, client.getClientAddress1());
				pstmt.setString(7, client.getClientAddress2());
				pstmt.setString(8, client.getClientZipcode());
				
				rows=pstmt.executeUpdate();
			} catch (SQLException e) {
				System.out.println("[에러]insertClient() 메소드의 SQL 오류 = "+e.getMessage());
			} finally {
				close(con, pstmt);
			}
			return rows;
		}
		//회원정보를 전달받아 Client 테이블에 저장된 행을 변경하고 변경행의 갯수를 반환하는 메소드 
		public String selectClientId(ClientDTO client) {
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			String id=null;
			try {
				con=getConnection();
				
				String sql="select client_id from client where client_name=? and client_email=?";
				
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, client.getClientName());
				pstmt.setString(2, client.getClientEmail());
				
				rs=pstmt.executeQuery();
				
				if(rs.next()) {
					id=rs.getString(1);
				}
			} catch (SQLException e) {
				System.out.println("[에러]selectClientById() 메소드의 SQL 오류 = "+e.getMessage());
			} finally {
				close(con, pstmt, rs);
			}
			return id;
		}
		
		//회원정보를 전달받아 MEMBER 테이블에 저장된 행의 회원상태를 변경하고 변경행의 갯수를 반환하는 메소드
		public int updateClientStatus(ClientDTO client) {
			Connection con=null;
			PreparedStatement pstmt=null;
			int rows=0;
			try {
				con=getConnection();
				
				String sql="update client set client_status=? where client_num=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, client.getClientStatus());
				pstmt.setInt(2, client.getClientNum());
				
				rows=pstmt.executeUpdate();
			} catch (SQLException e) {
				System.out.println("[에러]updateClientStatus() 메소드의 SQL 오류 = "+e.getMessage());
			} finally {
				close(con, pstmt);
			}
			return rows;
		}

		//회원정보를 전달받아 Client 테이블에 저장된 행을 변경하고 변경행의 갯수를 반환하는 메소드
		public int updateClient(ClientDTO clinet) {
			Connection con=null;
			PreparedStatement pstmt=null;
			int rows=0;
			try {
				con=getConnection();
				
				String sql="update client set client_passwd=?,client_name=?,client_email=?,client_phone=?,client_zipcode=?"
						+ ",client_address1=?,client_address2=? where client_num=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, clinet.getClientPasswd());
				pstmt.setString(2, clinet.getClientName());
				pstmt.setString(3, clinet.getClientEmail());
				pstmt.setString(4, clinet.getClientPhone());
				pstmt.setString(5, clinet.getClientZipcode());
				pstmt.setString(6, clinet.getClientAddress1());
				pstmt.setString(7, clinet.getClientAddress2());
				pstmt.setInt(8, clinet.getClientNum());
				
				rows=pstmt.executeUpdate();
			} catch (SQLException e) {
				System.out.println("[에러]updateClient() 메소드의 SQL 오류 = "+e.getMessage());
			} finally {
				close(con, pstmt);
			}
			return rows;
		}
	}
 	
	