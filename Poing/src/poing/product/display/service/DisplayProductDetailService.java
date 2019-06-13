package poing.product.display.service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.json.simple.JSONArray;

import com.util.ConnectionProvider;

import poing.product.ProductDTO;
import poing.product.ProductDetailDAO;
import poing.product.QuestionDAO;
import poing.product.QuestionDTO;
import poing.product.RefundTicketDTO;
import poing.product.ReplyDAO;
import poing.product.ReplyDTO;
import poing.product.PointHistoryDTO;


public class DisplayProductDetailService {
	
	public List<ProductDTO> selectRestPhotoImg(int tic_seq) {
		ProductDetailDAO dao = new ProductDetailDAO();		
		try (Connection conn = ConnectionProvider.getConnection()){	
			List<ProductDTO> list = dao.selectRestPhotoImg(conn, tic_seq);
			
			return list;
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
	
	public boolean updateTotalmoney(String totalmoney, int id) {
		ProductDetailDAO dao = new ProductDetailDAO();		
		boolean result = true;
		try (Connection conn = ConnectionProvider.getConnection()){	
			result = dao.updateTotalmoney(conn, totalmoney, id);
			
			return result;
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
	
	public ProductDTO selectProductDetail(int tic_seq) {
		try (Connection conn = ConnectionProvider.getConnection()){	
			ProductDTO dto = ProductDetailDAO.selectProductDetail(conn, tic_seq);
			
			return dto;
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
	
	public PointHistoryDTO selectRownum() {
		boolean result2 = true;
		try (Connection conn = ConnectionProvider.getConnection()){	
			PointHistoryDTO rtdto = ProductDetailDAO.selectRownum(conn);
			
			return rtdto;
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
	
	public List<PointHistoryDTO> PointHistory() {
		PointHistoryDTO rtdto = new PointHistoryDTO();
		boolean result2 = true;
		try (Connection conn = ConnectionProvider.getConnection()){	
			List<PointHistoryDTO> list3 = ProductDetailDAO.PointHistory(conn);
			
			return list3;
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
	
	public List<RefundTicketDTO> selectRefund_tic() {
		RefundTicketDTO rtdto = new RefundTicketDTO();
		boolean result2 = true;
		try (Connection conn = ConnectionProvider.getConnection()){	
			List<RefundTicketDTO> list2 = ProductDetailDAO.selectRefund_tic(conn);
			
			return list2;
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
	public int insertCart(int m_no, String c_date, int party_size, String message,ArrayList<Integer> ids,ArrayList<Integer> counts) {
		ProductDetailDAO dao = ProductDetailDAO.getInstance();		
		boolean result1 = false;
		try (Connection conn = ConnectionProvider.getConnection()){	
//			conn.setAutoCommit(false);
			int cart_seq = dao.insertCart(conn, m_no, c_date, party_size, message);
//			 conn.commit();
			return cart_seq;
			/*			if (cart_seq>=1 && result1 == true) {
				return true;
			}else {
				return false;
			}*/
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
	
	public boolean updatePayCart(int reserva_tic_seq, int m_no, String totalmoney) {
		ProductDetailDAO dao = new ProductDetailDAO();		
		boolean result2 = true;
		try (Connection conn = ConnectionProvider.getConnection()){	
			 result2 = dao.updatePayCart(conn, reserva_tic_seq, m_no, totalmoney);
			 
			 return result2;
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
	
	public boolean updateState(int reserva_tic_seq) {
		ProductDetailDAO dao = new ProductDetailDAO();		
		boolean result3 = true;
		try (Connection conn = ConnectionProvider.getConnection()){	
			result3 = dao.updateState(conn, reserva_tic_seq);
			
			return result3;
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
	

   public boolean insertTotalCart(int cart_seq,ArrayList<Integer> ids,ArrayList<Integer> counts) {
      ProductDetailDAO dao = ProductDetailDAO.getInstance();      
      boolean result = false;
      try (Connection conn = ConnectionProvider.getConnection()) {   
          result = dao.insertTotalCart(conn, cart_seq, ids, counts);
         if (result == true) {
            return true;
         }else {
            return false;
         }
      } catch (SQLException e) {
         throw new RuntimeException(e);
      }
   }
   
   public ProductDTO selectCartId(int cart_seq) {
      ProductDetailDAO dao = ProductDetailDAO.getInstance();
      try (Connection conn = ConnectionProvider.getConnection()) {
         ProductDTO dto = dao.selectCartId(conn, cart_seq);
         conn.close();
         // 로그 처리
         // 
         //
         return dto;
      } catch (SQLException e) {
         throw new RuntimeException(e);
      }
   }
   

	public ProductDTO select(int tic_seq) {
		ProductDetailDAO dao = ProductDetailDAO.getInstance();		
		try (Connection conn = ConnectionProvider.getConnection()) {			
			ProductDTO dto = dao.selectdisplay(conn, tic_seq);
			conn.close();
			// 로그 처리
			// 
			//
			return dto;
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	public ProductDTO select(int tic_seq, int member_num) {
		ProductDetailDAO dao = ProductDetailDAO.getInstance();		
		try (Connection conn = ConnectionProvider.getConnection()) {			
			ProductDTO dto = dao.selectdisplay(conn, tic_seq, member_num);
			conn.close();
			// 로그 처리
			// 
			//
			return dto;
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
	
	public ArrayList<QuestionDTO> select_question(int p_num,int memberID) {
		System.out.println("select_question");
		QuestionDAO qdao = QuestionDAO.getInstance();
		Connection conn = null;
		ArrayList<QuestionDTO> list_question = null;
		try {
			conn = ConnectionProvider.getConnection();
			list_question = qdao.selectDisplay(conn);
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return list_question;
	}// select_question
	
	public ArrayList<ReplyDTO> select_reply(int p_num,int memberID) {
		System.out.println("select_question");
		ReplyDAO rdao = ReplyDAO.getInstance();
		Connection conn = null;
		ArrayList<ReplyDTO> list_reply = null;
		try {
			conn = ConnectionProvider.getConnection();
			list_reply = rdao.selectDisplay(conn, memberID);
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return list_reply;
	}// select_question
	
}// class
