<%@page buffer="100kb"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="user.User"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.net.URLEncoder"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="findPWuserID" />
<jsp:setProperty name="user" property="findPWuserName" />
<jsp:setProperty name="user" property="findPWuserPart" />

<!DOCTYPE html>
<html>

<head>

</head>


<body>
	<%
	if (user.getFindPWuserID()==null || user.getFindPWuserName()==null || user.getFindPWuserPart()==null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('아이디, 이름, 담당을 모두 입력하세요.')");
		script.println("history.back()");
		script.println("</script>");
	}
	else {
		UserDAO userDAO = new UserDAO();
		String result = userDAO.findpw(user.getFindPWuserID(), user.getFindPWuserName(), user.getFindPWuserPart());
		
		if (result == "-1")
		{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('일치하는 정보가 없습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else 
		{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호는 "+result+" 입니다.')");
			script.println("window.close();");
			script.println("</script>");
		}
	}
%>
</body>
</html>


