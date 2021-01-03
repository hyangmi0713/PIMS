<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="paper.PaperStockDAO"%>
<%@ page import="paper.PaperStock"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>
	<%
	String paperListEditNo = request.getParameter("paperListEditNo");
	String paperListEditSize = request.getParameter("paperListEditSize");
	String paperListEditKind = request.getParameter("paperListEditKind");
	String paperListEditGram = request.getParameter("paperListEditGram");
	
	PaperStockDAO paperStockDAO = new PaperStockDAO();
	int result = paperStockDAO.paperListEdit(paperListEditNo, paperListEditSize, paperListEditKind, paperListEditGram);
	
	if (result == -1) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('수정에 실패하였습니다. 관리자에게 문의해주세요.')");
		script.println("history.back()");
		script.println("</script>");
	}
	else {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('수정이 완료되었습니다.')");
		script.println("location.href = 'admin.jsp'");
		script.println("</script>");
	} 
	%>
</body>
</html>