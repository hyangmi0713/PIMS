<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="paper.PaperStockDAO"%>
<%@ page import="paper.PaperStock"%>
<%@ page import="project.ProjectDAO"%>
<%@ page import="project.Project"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>
	<%
	String partNo = request.getParameter("partNo");
	String paperlistName = request.getParameter("paperlistName");
		
	PaperStockDAO paperStockDAO = new PaperStockDAO();
	ProjectDAO projectDAO = new ProjectDAO();
	
	int result = paperStockDAO.stockEct(partNo, paperlistName);
	boolean delProject = paperStockDAO.delProject(paperlistName);
	int delProjectResult = projectDAO.projectDel(paperlistName);
	
	if (result == -1) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('재고 이관에 실패하였습니다. 관리자에게 문의해주세요.')");
		script.println("history.back()");
		script.println("</script>");
	}
	else {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('재고 이관이 완료되었습니다.')");
		script.println("location.href = 'manageProject.jsp'");
		script.println("</script>");
	}
	%>
</body>
</html>