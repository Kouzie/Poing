package poing.review.display.service;

import java.sql.Connection;
import java.util.List;

import com.util.ConnectionProvider;

import poing.review.ReviewDAO;
import poing.review.ReviewDTO;

public class DisplayReviewService {
	public List<ReviewDTO> select(){
		System.out.println("DisplayReviewService");
		ReviewDAO dao = ReviewDAO.getInstance();
		Connection conn = null;
		try {
				conn = ConnectionProvider.getConnection();
			List<ReviewDTO> list = dao.selectdisplay(conn);
			
			return list;
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
		
	}//List
}//class