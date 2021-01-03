<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.util.*"%>
<%@ page import="pm_inventory.Pm_inventoryDAO"%>
<%@ page import="pm_inventory.Pm_inventory"%>
<%@ page import="paper.PaperStockDAO"%>
<%@ page import="paper.PaperStock"%>
<%@ page import="part.PartDAO"%>
<%@ page import="part.Part"%>
<%@ page import="project.ProjectDAO"%>
<%@ page import="project.Project"%>
<%@ page import="stock.Stock"%>
<%@ page import="stock.StockDAO"%>
<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>

<body>
<%
	List<String> expaper = new ArrayList<String>();

	String length = request.getParameter("length");
	for(int i=0; i<Integer.parseInt(length); i++ ) {
		expaper.add(request.getParameter("expaperInput"+i));
	}
	
	String department = request.getParameter("department");
	String userName = request.getParameter("username");
	
	Pm_inventoryDAO pm_inventoryDAO = new Pm_inventoryDAO();
	StockDAO paperStockDAO = new StockDAO();
	
	PartDAO partListDAO = new PartDAO();
	ArrayList<Part> getPartList = partListDAO.allPartList();
	
	ProjectDAO projectDAO = new ProjectDAO();
	ArrayList<Project> getProjectList = projectDAO.allPartProjectList1();
	
	int result = pm_inventoryDAO.addIncomeInput(expaper, department, userName);
	//int resultPaperStock = paperStockDAO.updatePaperStock(expaper);
	
	if (result == -1)
	{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('등록에 실패하였습니다. 관리자에게 문의하세요.')");
		script.println("location.href='income.jsp'");
		script.println("</script>");
	}
	else 
	{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('등록이 완료되었습니다.')");
		script.println("location.href='income.jsp'");
		script.println("</script>");
	}
%>
</body>s
</html>


