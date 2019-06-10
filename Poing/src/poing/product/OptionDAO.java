package poing.product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.util.ConnectionProvider;

public class OptionDAO {
	
	private static OptionDAO displaydao = new OptionDAO();
	public static OptionDAO getInstance() {
		return displaydao;
	}

	public OptionDAO() {}
	
	public ArrayList<OptionDTO> selectoption(Connection conn, int p_num){
		StringBuffer sql = new StringBuffer();
		sql.append(" select * from p_option where p_num = ? ");
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<OptionDTO> pp = new ArrayList<>();
		try {
			pstmt = conn.prepareStatement(sql.toString());
			pstmt.setInt(1, p_num);
			rs = pstmt.executeQuery();
			OptionDTO op = null;
			while (rs.next()) {
				op = new OptionDTO();
				op.setOp_seq(rs.getInt("op_seq"));
				op.setP_num(rs.getInt("p_num"));
				op.setOp_name(rs.getString("op_name"));
				op.setOp_price(rs.getInt("op_price"));
				op.setOp_min_cnt(rs.getInt("op_min_cnt"));
				op.setOp_max_cnt(rs.getInt("op_max_cnt"));
				pp.add(op);
				
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
		return pp;	
	}
	
	public int getTotalCount(int p_num) {
		int total = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = ConnectionProvider.getConnection();
			String sql = " select count(*) from p_option where p_num = ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, p_num);
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