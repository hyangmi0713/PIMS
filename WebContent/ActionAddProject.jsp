<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="paper.PaperStockDAO"%>
<%@ page import="paper.PaperStock"%>
<%@ page import="project.Project"%>
<%@ page import="project.ProjectDAO"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>
	<%
	String projectName = request.getParameter("projectName");
	String projectPart[] = request.getParameterValues("projectPart");
	
	ProjectDAO projectDAO = new ProjectDAO();
	int result = projectDAO.projectAdd(projectName, projectPart);
	
	ArrayList<Project> projectInfo = new ArrayList<Project>();
	projectInfo = projectDAO.allProjectList();
	
	String createRowName = null;
	boolean createRowResult = true;
	int createRowDefaultResult = 0;
	int changePaperListName = 0;
	
	for (int i=0; i<projectInfo.size(); i++) {
		if(projectInfo.get(i).getProjectPartNo() == 1 ) {
			createRowName = "paper_list_quantity_sys_"+projectInfo.get(i).getProjectNo();
		}
		else if(projectInfo.get(i).getProjectPartNo() == 2 ) {
			createRowName = "paper_list_quantity_dev_"+projectInfo.get(i).getProjectNo();
		}
		else if(projectInfo.get(i).getProjectPartNo() == 3 ) {
			createRowName = "paper_list_quantity_cer_"+projectInfo.get(i).getProjectNo();
		}
		else if(projectInfo.get(i).getProjectPartNo() == 4 ) {
			createRowName = "paper_list_quantity_mec_"+projectInfo.get(i).getProjectNo();
		}
		else {
			createRowName = "paper_list_quantity_"+projectInfo.get(i).getProjectPartNo()+"_"+projectInfo.get(i).getProjectNo();
		}
		
		createRowResult = projectDAO.createRow(createRowName);
		createRowDefaultResult = projectDAO.createRowDefault(createRowName);
		
		changePaperListName = projectDAO.changePaperlistName(createRowName, projectInfo.get(i).getProjectNo());
	}
	
	if (result == -1 || changePaperListName == -1) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('프로젝트 추가에 실패하였습니다. 관리자에게 문의해주세요.')");
		script.println("history.back()");
		script.println("</script>");
	}
	else {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('프로젝트 추가가 완료되었습니다.')");
		script.println("location.href = 'manageProject.jsp'");
		script.println("</script>");
	} 
	%>
</body>
</html>