<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="paper.PaperStockDAO"%>
<%@ page import="paper.PaperStock"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<%
	
	request.setCharacterEncoding("UTF-8");
	String btnname = request.getParameter("btncheck");
	
	
	PaperStock paperStock = new PaperStock();
	paperStock.setSearchPaper(btnname);
	
	PaperStock paperStock = new PaperStock();
	paperStock.setSearchPaper(btnname);

	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("location.href = 'home.jsp'");
	script.println("</script>");

	
	
	
	/* 
	int result = paperStockDAO.getPaperStock_search(btnname);
	
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
		script.println("location.href = 'home.jsp'");
		script.println("</script>");
	}  */
			
	%>
</body>
</html>