<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String jsonData = "{ \"status\" : "+request.getAttribute("result") + 
						", \"error\" : {\"message\" : \""+ request.getAttribute("error") +"\"}"
					 +"}";
	System.out.println(jsonData);
%>
<%=jsonData%>
