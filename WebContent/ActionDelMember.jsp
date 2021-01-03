<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="user.User" %>
<%@ page import="user.UserDAO" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>
	<%
	String selectDelID = request.getParameter("selectDelID");
	
	UserDAO userListDAO = new UserDAO();
	int result = userListDAO.memberDel(selectDelID);
	
	if (result == -1) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('회원 삭제에 실패하였습니다. 관리자에게 문의해주세요.')");
		script.println("history.back()");
		script.println("</script>");
	}
	else {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('회원 삭제가 완료되었습니다.')");
		script.println("location.href = 'admin.jsp'");
		script.println("</script>");
	}
	%>
</body>
</html>