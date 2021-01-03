<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%
	String id = request.getParameter("id");
	UserDAO dao = new UserDAO();
	int re = dao.idOverlapCheck(id);
%>
<%=re%>