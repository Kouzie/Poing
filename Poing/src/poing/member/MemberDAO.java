package poing.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import poing.rest.RestListDTO;
import poing.rest.RestReserveDTO;
import poing.news_notice.NewsDTO;
import poing.news_notice.NoticeDTO;
import poing.rest.RestTimlineReserveDTO;

import poing.product.ProductDTO;
import poing.product.PointHistoryDTO;

public class MemberDAO {
	
	public static int selectID(Connection conn, String email) {
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT m_no FROM member ");
		sql.append("WHERE m_email = ? ");
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			pstmt = conn.prepareStatement(sql.toString());
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();
			if(rs.next())
			{
				return rs.getInt("m_no");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return 0;
	}
	//회원 정보 검색
	public MemberDTO selectById(Connection conn, int memberID) throws SQLException{
		MemberDTO mdto = null;
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT * FROM member WHERE m_no = ?");
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		pstmt = conn.prepareStatement(sql.toString());
		pstmt.setInt(1, memberID);

		rs = pstmt.executeQuery();
		if (rs.next()) {
			mdto = new MemberDTO(rs);
		}
		return mdto;
	}
	
	
	
	public static boolean insertReserve_tic(Connection conn, int p_num, int m_no, int cart_seq){
		boolean result1 = false;
		StringBuffer sql = new StringBuffer();
		sql.append(" insert into reserve_tic (reserva_tic_seq, p_num, m_no, cart_seq, p_state)values (reserva_tic_seq.nextval, ?, ?, ?,'결제완료') ");
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement(sql.toString());
			pstmt.setInt(1, p_num);
			pstmt.setInt(2, m_no);
			pstmt.setInt(3, cart_seq);
			//
			 
			result1 = pstmt.executeUpdate()==0? false:true;
			// 
			pstmt.close();
			conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result1;
	}
	
	public static boolean chargePoint(Connection conn,int chargePoint, int m_no){
		boolean result1 = false;
		StringBuffer sql = new StringBuffer();
		sql.append(" update member set rp_seq= rp_seq+? where m_no = ? ");
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;
		try {
			pstmt = conn.prepareStatement(sql.toString());
			pstmt.setInt(1, chargePoint);
			pstmt.setInt(2, m_no);
			//
			result1 = pstmt.executeUpdate()==0? false:true;
			
			if(result1) {
				String sql2 ="insert into pointUseHistory (pointUseHistory_seq, m_no, eventSysdate, useContent, pointRecord) values (pointUseHistory_seq.nextval,?,sysdate,'포인트를 충전했습니다.',?)";
				pstmt2 = conn.prepareStatement(sql2);
				pstmt2.setInt(1, m_no);
				pstmt2.setInt(2, chargePoint);
				boolean result2 = pstmt2.executeUpdate()==0? false:true;
				System.out.println("chargePoint");
			}
			// 
			pstmt.close();
			pstmt2.close();
			conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result1;
	}
	
	
	public static boolean selectRp_seq(Connection conn, int m_no,int rp_seq,int totalmoney, String m_email){
		System.out.println("진입성공");
		System.out.println("rp_seq="+rp_seq);
		System.out.println("totalmoney="+totalmoney);
		System.out.println("m_email="+m_email);
		boolean result2 = false;
		StringBuffer sql = new StringBuffer();
		sql.append(" update member set rp_seq = ? - ? where m_email = ? ");
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;
		try {
			pstmt = conn.prepareStatement(sql.toString());
			pstmt.setInt(1, rp_seq);
			pstmt.setInt(2, totalmoney);
			pstmt.setString(3, m_email);
			 
			result2 = pstmt.executeUpdate()==0? false:true;
			if(result2) {
				String sql2 ="insert into pointUseHistory (pointUseHistory_seq, m_no, eventSysdate, useContent, pointRecord) values (pointUseHistory_seq.nextval,?,sysdate,'결제 포인트를 차감했습니다.',?)";
				pstmt2 = conn.prepareStatement(sql2);
				pstmt2.setInt(1, m_no);
				pstmt2.setInt(2, totalmoney);
				boolean result3 = pstmt2.executeUpdate()==0? false:true;
				System.out.println("selectRp_seq");
			}
			
			pstmt.close();
			conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result2;
	}
	
	
	public static boolean insertMember(Connection conn, MemberDTO mdto) {
		boolean result = false;
		StringBuffer sql = new StringBuffer();
		sql.append(" INSERT INTO member ");
		sql.append(" (              m_no, m_name, m_birth, m_gen, m_email, m_level, m_pw, m_nickname, rp_seq) VALUES");
		sql.append(" (seq_member.nextval,      ?,       ?,     ?,       ?,       ?,    ?,          ?,      ?) ");	
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
		pstmt = conn.prepareStatement(sql.toString());
		pstmt.setString(1, mdto.getM_name());
		pstmt.setString(2, mdto.getM_birth().toString());
		pstmt.setInt(3, mdto.getM_gen());
		pstmt.setString(4, mdto.getM_email());
		pstmt.setInt(5, mdto.getM_level());
		pstmt.setString(6, mdto.getM_pw());
		pstmt.setString(7, mdto.getM_name());
		pstmt.setInt(8, mdto.getRp_seq());
		result = pstmt.executeUpdate()==1?true:false;
		}catch (Exception e) {
			// TODO: handle exception
		}
		//입력성공시 true, 실패시 false반환
		return result;
	} // getFollowCnt

	public static int[] getFollowCnt(Connection conn, int memberID) throws SQLException {
		int[] result = new int[2];
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" (SELECT COUNT(*) FROM follow WHERE follower_seq = ?) edcnt, ");
		sql.append(" (SELECT COUNT(*) FROM follow WHERE following_seq = ?) ercnt ");
		sql.append(" FROM dual ");

		PreparedStatement pstmt;
		pstmt = conn.prepareStatement(sql.toString());
		pstmt.setInt(1, memberID);
		pstmt.setInt(2, memberID);
		ResultSet rs = pstmt.executeQuery();
		if ( rs.next() ) {
			result[0] = rs.getInt("edcnt");
			result[1] = rs.getInt("ercnt");
		}		
		return result;
	} //getFollowCnt
	public boolean deleteFollower(Connection conn, int myId, int fid) throws SQLException {
		StringBuffer sql = new StringBuffer();
		sql.append(" DELETE FROM follow ");
		sql.append(" WHERE follower_seq = ? AND following_seq = ? ");
		PreparedStatement pstmt = conn.prepareStatement(sql.toString());
		pstmt.setInt(1, myId);
		pstmt.setInt(2, fid);
		boolean result = pstmt.executeUpdate()==0 ? false : true;


		return result;
	} //deleteFollower
	public boolean insertFollower(Connection conn, int myId, int fid) throws SQLException {
		StringBuffer sql = new StringBuffer();
		sql.append(" INSERT INTO follow (follow_seq, follower_seq, following_seq) ");
		sql.append(" VALUES(follow_seq.nextval, ?, ?) ");

		PreparedStatement pstmt = conn.prepareStatement(sql.toString());
		pstmt.setInt(1, myId);
		pstmt.setInt(2, fid);
		boolean result = pstmt.executeUpdate()==0 ? false : true;
		return result;
	} // insertFollower
	public boolean updateProfileImage(Connection conn, int m_no, String filePath) throws SQLException {
		int result = 0;
		StringBuffer sql = new StringBuffer();
		sql.append(" UPDATE member SET m_img = ?");
		sql.append(" WHERE m_no = ? ");

		PreparedStatement pstmt = conn.prepareStatement(sql.toString());
		pstmt.setString(1, filePath);
		pstmt.setInt(2, m_no);
		result = pstmt.executeUpdate();
		return result==0?false:true;
	}//updateProfileImage

	public ArrayList<RestTimlineReserveDTO> getReserveRest(Connection conn, int memberID) throws SQLException {

		String sql = "select * from rest_reserve a join p_restaurant b on a.rest_no = b.rest_seq where a.m_num =? ";
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		ArrayList<RestTimlineReserveDTO> list = new ArrayList<>();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, memberID);
			rs = pstmt.executeQuery();
			RestTimlineReserveDTO dto = null;
			while (rs.next()) {
				dto = new RestTimlineReserveDTO();
				dto.setR_reserve_seq(  rs.getInt("R_RESERVE_NUM") );
				dto.setR_reserve_date( rs.getDate("R_RESERVE_DATE").toString()  );
				dto.setR_reserve_hour(  rs.getString("R_RESERVE_HOUR") );
				dto.setR_reserve_name( rs.getString("r_reserve_name") ); 
				dto.setR_reserve_request(  rs.getString("r_reserve_request") );
				dto.setRest_seq( rs.getInt("rest_no") );
				dto.setR_reserve_status( rs.getInt("R_RESERVE_STATUS") );
				dto.setR_reserve_numofpeople(rs.getInt("R_RESERVE_NUM_OF_PEOPLE"));
				dto.setRest_name(rs.getString("rest_name"));
				list.add(dto);
			}// while
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				pstmt.close();
				rs.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}//catch
		}// finally	
		return list;		
	}

	public boolean updateWebName(Connection conn, int memberID, String webName) throws SQLException {
		//이름 변경
		boolean result = false;
		StringBuffer sql = new StringBuffer();
		sql.append(" UPDATE member SET m_name = ?");
		sql.append(" WHERER m_no = ? ");
		PreparedStatement pstmt = conn.prepareStatement(sql.toString());
		pstmt.setString(1, webName);
		pstmt.setInt(2, memberID);
		result = pstmt.executeUpdate()==0?false:true;
		return result;
	}
	
	public boolean updateName(Connection conn, int memberID, String name) throws SQLException {
		//예약자명 변경
		boolean result = false;
		StringBuffer sql = new StringBuffer();
		sql.append(" UPDATE member SET m_nickname = ?");
		sql.append(" WHERER m_no = ? ");
		PreparedStatement pstmt = conn.prepareStatement(sql.toString());
		pstmt.setString(1, name);
		pstmt.setInt(2, memberID);
		result = pstmt.executeUpdate()==0?false:true;
		return result;
	}

	public boolean updateSelfIntro(Connection conn, int memberID, String selfIntro) throws SQLException {
		//예약자명 변경
		boolean result = false;
		StringBuffer sql = new StringBuffer();
		sql.append(" UPDATE member SET m_name = ?");
		sql.append(" WHERER m_no = ? ");
		PreparedStatement pstmt = conn.prepareStatement(sql.toString());
		pstmt.setString(1, selfIntro);
		pstmt.setInt(2, memberID);
		result = pstmt.executeUpdate()==0?false:true;
		return result;
	}

	public ArrayList<NewsDTO> getNewsList(Connection conn, int memberID) throws SQLException {

		StringBuffer sql = new StringBuffer();

		sql.append(" select * ");
		sql.append(" from news  ");
		sql.append(" where news_m_no = ? ") ;

		PreparedStatement pstmt = null;
		ResultSet rs = null;

		ArrayList<NewsDTO> list = new ArrayList<>();
		try {
			pstmt = conn.prepareStatement(sql.toString());
			pstmt.setInt(1, memberID);
			rs = pstmt.executeQuery();
			NewsDTO dto = null;

			while (rs.next()) {
				dto = new NewsDTO();
				dto.setNews_m_name(rs.getString("news_m_name"));
				dto.setNews_no(rs.getInt("news_no"));
				dto.setNews_content(rs.getString("news_content"));
				dto.setNews_wtime(rs.getDate("news_wtime"));
				dto.setNews_img(rs.getString("news_img"));
				dto.setNews_m_no(rs.getInt("news_m_no"));
				list.add(dto);

			}// while
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				pstmt.close();
				rs.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}//catch
		}// finally	
		return list;		
	}// getNewsList
	
	public ArrayList<NoticeDTO> getNoticeList(Connection conn, int memberID){
		System.out.println("notice DAO");
		StringBuffer sql = new StringBuffer();
		
		sql.append(" select * from notice where notice_m_no = ? ");
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		ArrayList<NoticeDTO> list = new ArrayList<>();
		
		
		try {
			pstmt = conn.prepareStatement(sql.toString());
			pstmt.setInt(1, memberID);
			rs = pstmt.executeQuery();
			NoticeDTO ndto = null;
			
			while(rs.next()) {
				ndto = new NoticeDTO();
				ndto.setNotice_no(rs.getInt("notice_no"));
				ndto.setNotice_content(rs.getString("notice_content"));
				ndto.setNotice_wtime(rs.getDate("notice_wtime"));
				ndto.setNotice_img(rs.getString("notice_img"));
				ndto.setNotice_type(rs.getInt("notice_type"));
				ndto.setNotice_m_no(rs.getInt("notice_m_no"));
				list.add(ndto);
			}// while
			rs.close();
			pstmt.close();
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}// catch
		
		return list;
	}// displayNotice


}// class

