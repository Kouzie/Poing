<%@page import="org.json.simple.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	JSONObject jsonObject = new JSONObject();
	jsonObject.put("status", request.getAttribute("result"));
	System.out.println(jsonObject);
%>
<%=jsonObject%>


