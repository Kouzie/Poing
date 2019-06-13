package poing.rest;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import poing.product.ProductDTO;

public class RestDetailDAO {

	private static RestDetailDAO displaydao = new RestDetailDAO();
	public static RestDetailDAO getInstance() {
		return displaydao;
	}

	public RestDetailDAO() {}

	public RestListDTO selectdisplay(Connection conn, int rest_seq) throws SQLException{
		System.out.println("restDetailDAO");
		String sql = "select * from p_restaurant where rest_seq=?";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<RestListDTO> list = new ArrayList<>();
		RestListDTO dto = null;
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, rest_seq);
		rs = pstmt.executeQuery();

		dto = new RestListDTO();
		rs.next();
		
		dto.setRest_seq(rs.getInt("rest_seq"));
		dto.setRest_name(rs.getString("rest_name"));
		dto.setRest_tel(rs.getString("rest_tel"));
		dto.setRest_hour(rs.getString("rest_hour"));
		dto.setRest_menu(rs.getString("rest_menu"));
		dto.setRest_reservation_cnt(rs.getInt("rest_reservation_cnt"));
		dto.setRest_review_cnt(rs.getInt("rest_review_cnt"));
		dto.setRest_view_cnt(rs.getInt("rest_view_cnt"));
		dto.setRest_starpoint(rs.getDouble("rest_starpoint"));
		dto.setRest_loc(rs.getString("rest_loc"));

		/*dto.setRest_tic_code(rs.getInt("p_code"));*/

		dto.setRest_tic_code(rs.getInt("p_num"));

		dto.setRest_line_exp(rs.getString("rest_line_exp"));
		dto.setRest_alchol(rs.getString("rest_alchol"));
		dto.setRest_parking_yn(rs.getString("rest_parking_yn"));
		dto.setRest_add_info(rs.getString("rest_add_info"));
		dto.setRest_budget_type(rs.getString("rest_budget_type"));
		dto.setRest_table_type(rs.getString("rest_table_type"));
		dto.setRest_food_type(rs.getString("rest_food_type"));

		pstmt.close();
		rs.close();
		return dto;	
	}

	public RestListDTO selectdisplay(Connection conn, int rest_seq, int m_no) throws SQLException {
		
		System.out.println("restDetailDAO");
		String sql = "select distinct a.* , b.m_no from p_restaurant a left join (select * from pick where m_no = ?) b on a.rest_seq = b.rest_no " + 
				     "where rest_seq= ?";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<RestListDTO> list = new ArrayList<>();
		RestListDTO dto = null;
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, m_no);
		pstmt.setInt(2, rest_seq);
		rs = pstmt.executeQuery();

		dto = new RestListDTO();
		rs.next();
		
		dto.setRest_seq(rs.getInt("rest_seq"));
		dto.setRest_name(rs.getString("rest_name"));
		dto.setRest_tel(rs.getString("rest_tel"));
		dto.setRest_hour(rs.getString("rest_hour"));
		dto.setRest_menu(rs.getString("rest_menu"));
		dto.setRest_reservation_cnt(rs.getInt("rest_reservation_cnt"));
		dto.setRest_review_cnt(rs.getInt("rest_review_cnt"));
		dto.setRest_view_cnt(rs.getInt("rest_view_cnt"));
		dto.setRest_starpoint(rs.getDouble("rest_starpoint"));
		dto.setRest_loc(rs.getString("rest_loc"));
		/*dto.setRest_tic_code(rs.getInt("p_code"));*/

		dto.setRest_tic_code(rs.getInt("p_num"));

		dto.setRest_line_exp(rs.getString("rest_line_exp"));
		dto.setRest_alchol(rs.getString("rest_alchol"));
		dto.setRest_parking_yn(rs.getString("rest_parking_yn"));
		dto.setRest_add_info(rs.getString("rest_add_info"));
		dto.setRest_budget_type(rs.getString("rest_budget_type"));
		dto.setRest_table_type(rs.getString("rest_table_type"));
		dto.setRest_food_type(rs.getString("rest_food_type"));
		dto.setRest_fav(rs.getInt("m_no")>0?1:0);  //찜하기 추적

		pstmt.close();
		rs.close();
		return dto;	
	}
	
	public static List<ProductDTO> selectRestProductOPtion(Connection conn, int rest_seq) {
		String sql = " select o.tic_option_seq, o.tic_op_name, o.tic_original_price, o.tic_dc_price from tic_option o join ticket t on o.tic_seq = t.tic_seq join restaurant r on r.rest_seq = t.rest_seq where t.rest_seq = ? ";

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ProductDTO dto = null;
		ArrayList<ProductDTO> list = new ArrayList<>();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, rest_seq);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				dto = new ProductDTO();
				dto.setTic_option_seq(rs.getInt("tic_option_seq"));
				dto.setTic_op_name(rs.getString("tic_op_name"));
				dto.setTic_original_price(rs.getInt("tic_original_price"));
				dto.setTic_dc_price(rs.getInt("tic_dc_price"));
				list.add(dto);
			}
			

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				pstmt.close();
				rs.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return list;
	}

}
