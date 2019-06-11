package poing.product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.util.ConnectionProvider;


public class ProductDAO {
   
   private static ProductDAO displaydao = new ProductDAO();
   public static ProductDAO getInstance() {
      return displaydao;
   }

	public ProductDAO() {}
	
	public List<ProductDTO> selectdisplay(Connection conn, int first, int end){
		StringBuffer sql = new StringBuffer();
		sql.append(" select rownum,m.tic_img,t.tic_view_price, t.tic_seq, r.rest_name,r.rest_address,t.tic_name,t.tic_type from ");
		sql.append(" ticket t join restaurant r on t.rest_seq = r.rest_seq join tic_img m on m.tic_seq = t.tic_seq where rownum between ? and ? ");
			   
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<ProductDTO> list = new ArrayList<>();
		try {
			pstmt = conn.prepareStatement(sql.toString());
			pstmt.setInt(1, first);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			ProductDTO dto = null;
			while (rs.next()) {
				dto = new ProductDTO();
				dto.setTic_seq(rs.getInt("tic_seq"));
				dto.setRest_name(rs.getString("rest_name"));
				dto.setRest_address(rs.getString("rest_address"));
				dto.setTic_name(rs.getString("tic_name"));
				dto.setTic_type(rs.getString("tic_type"));
				dto.setTic_view_price(rs.getInt("tic_view_price"));
				dto.setTic_img(rs.getString("tic_img"));
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
	
	public List<ProductDTO> sselectdisplay(Connection conn, int first, int end, int bpage){
		StringBuffer sql = new StringBuffer();
		sql.append(" select no, tic_seq, rest_name, rest_address, tic_name, tic_type, tic_view_price, rest_foodinfo, rest_line_exp ");
		sql.append(" from ( ");
		sql.append(" select rownum no, tic_seq, tic_name, rest_name, rest_address, tic_type, tic_view_price, rest_foodinfo, rest_line_exp ");
		sql.append(" from ( ");
		sql.append("  select tic_seq, tic_name, rest_name, rest_address, tic_type, tic_view_price, rest_foodinfo, rest_line_exp ");
		sql.append("  from ticket t join restaurant r on r.rest_seq = t.rest_seq  ");
		sql.append("  ) t ");
		sql.append(" ) b ");
		sql.append(" where b.no between ? and ? ");
		if(bpage == 9728) {
			sql = sql.append( " and rest_foodinfo like '%일식%' and rest_name like '%스시%' ");
		} else if (bpage == 10860) {
			sql = sql.append(" and rest_address like '%청담%' or rest_address like '%가로수%' or rest_address like '%압구정%' ");
		} else if (bpage == 10952) {
			sql = sql.append( " and rest_name like '%한우%' or rest_line_exp like '%한우%' or rest_foodinfo like '%소고기%' ");
		} else if (bpage == 9732) {
			sql = sql.append( " and rest_name like '%스테이크%' or rest_line_exp like '%스테이크%' ");
		} else if (bpage == 10948) {
			sql = sql.append( " and tic_type like '%단독%' ");
		} else if (bpage == 9752) {
			sql = sql.append( " and rest_foodinfo like '%일식%' and rest_name not like '%스시%' ");
		} else if (bpage == 9796) {
			sql = sql.append( " and rest_address like '%호텔%' ");
		} else if (bpage == 9788) {
			sql = sql.append( " and rest_foodinfo like '%이탈%' or rest_foodinfo like '%프랑%' or rest_line_exp like '%지중해%' ");
		} else if (bpage == 9740) {
			sql = sql.append(" and rest_address like '%이태원%' or rest_address like '%경리단길%' or rest_address like '%용산구%' ");
		} else if (bpage == 9792) {
			sql = sql.append(" and rest_foodinfo like '%한식%' ");
		} else if (bpage == 9760) {
			sql = sql.append(" and rest_foodinfo like '%프랑%' ");
		} else if (bpage == 9748) {
			sql = sql.append(" and rest_foodinfo like '%중식%' ");
		} else if (bpage == 9776) {
			sql = sql.append(" and rest_foodinfo like '%뷔페%' ");
		} else if (bpage == 9768) {
			sql = sql.append(" and rest_foodinfo like '%카페%' or rest_line_exp like '%브런치%' ");
		} else if (bpage == 9780) {
			sql = sql.append(" and rest_foodinfo like '%바%' or rest_foodinfo like '%술집%' ");
		} else if (bpage == 9764) {
			sql = sql.append(" and rest_foodinfo like '%컨템퍼%' ");
		}
			   
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<ProductDTO> list = new ArrayList<>();
		try {
			pstmt = conn.prepareStatement(sql.toString());
			pstmt.setInt(1, first);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			ProductDTO dto = null;
			while (rs.next()) {
				dto = new ProductDTO();
				dto.setTic_seq(rs.getInt("tic_seq"));
				dto.setRest_name(rs.getString("rest_name"));
				dto.setRest_address(rs.getString("rest_address"));
				dto.setTic_name(rs.getString("tic_name"));
				dto.setTic_type(rs.getString("tic_type"));
				dto.setTic_view_price(rs.getInt("tic_view_price"));
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

	public int getStotalCount(int bpage) {
		int total = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = ConnectionProvider.getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append(" select count(*) ");
			sql.append(" from ( ");
			sql.append(" select rownum no, tic_seq, tic_name, rest_name, rest_address, tic_type, tic_view_price, rest_foodinfo, rest_line_exp ");
			sql.append(" from ( ");
			sql.append("  select tic_seq, tic_name, rest_name, rest_address, tic_type, tic_view_price, rest_foodinfo, rest_line_exp ");
			sql.append("  from ticket t join restaurant r on r.rest_seq = t.rest_seq  ");
			sql.append("  ) t ");
			sql.append(" ) b ");
			
			if(bpage == 9728) {
				sql = sql.append( " and rest_foodinfo like '%일식%' and rest_name like '%스시%' ");
			} else if (bpage == 10860) {
				sql = sql.append(" and rest_address like '%청담%' or rest_address like '%가로수%' or rest_address like '%압구정%' ");
			} else if (bpage == 10952) {
				sql = sql.append( " and rest_name like '%한우%' or rest_line_exp like '%한우%' or rest_foodinfo like '%소고기%' ");
			} else if (bpage == 9732) {
				sql = sql.append( " and rest_name like '%스테이크%' or rest_line_exp like '%스테이크%' ");
			} else if (bpage == 10948) {
				sql = sql.append( " and tic_type like '%단독%' ");
			} else if (bpage == 9752) {
				sql = sql.append( " and rest_foodinfo like '%일식%' and rest_name not like '%스시%' ");
			} else if (bpage == 9796) {
				sql = sql.append( " and rest_address like '%호텔%' ");
			} else if (bpage == 9788) {
				sql = sql.append( " and rest_foodinfo like '%이탈%' or rest_foodinfo like '%프랑%' or rest_line_exp like '%지중해%' ");
			} else if (bpage == 9740) {
				sql = sql.append(" and rest_address like '%이태원%' or rest_address like '%경리단길%' or rest_address like '%용산구%' ");
			} else if (bpage == 9792) {
				sql = sql.append(" and rest_foodinfo like '%한식%' ");
			} else if (bpage == 9760) {
				sql = sql.append(" and rest_foodinfo like '%프랑%' ");
			} else if (bpage == 9748) {
				sql = sql.append(" and rest_foodinfo like '%중식%' ");
			} else if (bpage == 9776) {
				sql = sql.append(" and rest_foodinfo like '%뷔페%' ");
			} else if (bpage == 9768) {
				sql = sql.append(" and rest_foodinfo like '%카페%' or rest_line_exp like '%브런치%' ");
			} else if (bpage == 9780) {
				sql = sql.append(" and rest_foodinfo like '%바%' or rest_foodinfo like '%술집%' ");
			} else if (bpage == 9764) {
				sql = sql.append(" and rest_foodinfo like '%컨템퍼%' ");
			}
			
			pstmt = conn.prepareStatement(sql.toString());
			rs = pstmt.executeQuery();
			if (rs.next()) {
				total = rs.getInt(1);
			}
		} 
		 catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
				rs.close();
				pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}			
		} return total;
	}
	
	public int getTotalCount() {
		int total = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = ConnectionProvider.getConnection();
			String sql = " select count(*) from ticket ";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				total = rs.getInt(1);
			}
		} 
		 catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
				rs.close();
				pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}			
		} return total;
	}
}
