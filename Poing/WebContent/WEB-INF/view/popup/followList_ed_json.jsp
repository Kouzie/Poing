<%@page import="poing.member.MemberDTO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.util.ConnectionProvider"%>
<%@page import="java.sql.Connection"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<% 
JSONObject jsonObject = new JSONObject();
JSONObject data = new JSONObject();
jsonObject.put("status", true);
jsonObject.put("data", data);

JSONArray follows = new JSONArray();
data.put("follows", follows);

JSONObject meta = new JSONObject();
meta.put("page", 1);
meta.put("per_page", 14);
meta.put("followed_count", request.getParameter("followed_count"));
jsonObject.put("meta", meta);

JSONObject followed = null;
try {
	StringBuffer sql = new StringBuffer();
	sql.append( "WITH temp AS(  ");
	sql.append( "    SELECT * FROM member ");
	sql.append( "    WHERE M_seq IN ( SELECT following_seq FROM follow WHERE follower_seq = ?) ");
	sql.append( ") ");
	sql.append( "SELECT temp.M_seq fer_no, temp.m_name fer_name, temp.m_img fer_img,  ");
	sql.append( "(SELECT COUNT(*) FROM review WHERE rev_m_seq = temp.M_seq) revcnt, ");
	sql.append( "(SELECT COUNT(*) FROM follow WHERE following_seq = temp.M_seq) fer_edcnt, ");
	sql.append( "(SELECT COUNT(*) FROM follow WHERE following_seq = temp.M_seq AND follower_seq = ?) amIfollow ");
	sql.append( "FROM temp ");
	
	int m_seq = -1;
	MemberDTO authUser = (MemberDTO) session.getAttribute("authUser");
	if(authUser!=null)
		m_seq = authUser.getM_seq();
	Connection conn = ConnectionProvider.getConnection();
	PreparedStatement pstmt = conn.prepareStatement(sql.toString());
	pstmt.setString(1, request.getParameter("id"));
	pstmt.setInt(2, m_seq);
	ResultSet rs = pstmt.executeQuery();
	while(rs.next()) {
		followed = new JSONObject();
		followed.put("object_id", null);
		followed.put("id", rs.getInt("fer_no"));
		followed.put("web_name", rs.getString("fer_name"));
		followed.put("profile_image", rs.getString("fer_img"));
		followed.put("follow_state", rs.getInt("amIfollow")==0?false:true);
		followed.put("follower_count", rs.getInt("fer_edcnt"));
		followed.put("review_count", rs.getInt("revcnt"));
		JSONObject temp = new JSONObject();
		temp.put("followed", followed);
		follows.add(temp);
	}
	conn.close();
}
catch (Exception e) {
	jsonObject.put("status", false);

	e.printStackTrace();
}
%>
<%= jsonObject %>
