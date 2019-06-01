package poing.review.update.service;

import java.sql.Connection;
import java.sql.SQLException;

import com.util.ConnectionProvider;

import poing.review.ReviewDAO;

public class UpdateCommentService {
	ReviewDAO reviewDAO = new ReviewDAO();

	public int updateReview(int rev_no, String content, int m_no) throws SQLException {
		int result = 0;
		Connection conn = null;
		conn = ConnectionProvider.getConnection();
		result = reviewDAO.updateReview(conn, rev_no, content);
		return result;
	}
}