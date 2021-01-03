<%@page buffer="100kb"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="user.User"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.net.URLEncoder"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPassword" />

<!DOCTYPE html>
<html>

<head>

</head>


<body>
	<%
	String menId = null;
	
	if(session.getAttribute("menId") != null) {
		menId = (String) session.getAttribute("menId");
	}
	
	UserDAO userDAO = new UserDAO();
	
	int result = userDAO.login(user.getUserID(), user.getUserPassword());
	
	if (result == 1){
		session.setAttribute("menId", user.getUserID()); 
		
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = 'home.jsp'");
		script.println("</script>");
	}
	
	else if (result == 0)
	{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('비밀번호가 올바르지 않습니다.')");
		script.println("history.back()");
		script.println("</script>");
	}
	
	else if (result == -1)
	{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('아이디가 올바르지 않습니다.')");
		script.println("history.back()");
		script.println("</script>");
	}
	else if (result == -2)
	{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('데이터 베이스 오류')");
		script.println("history.back()");
		script.println("</script>");
	}
	else if (result == 2)
	{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('아이디를 입력하세요.')");
		script.println("history.back()");
		script.println("</script>");
	}
%>
</body>
</html>


