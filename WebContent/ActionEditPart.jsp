<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.*" %>
<%@ page import="part.Part" %>
<%@ page import="part.PartDAO" %>
<%@ page import="project.Project" %>
<%@ page import="project.ProjectDAO" %>
<%@ page import="paper.PaperStock" %>
<%@ page import="paper.PaperStockDAO" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>
	<%
	String partName = request.getParameter("partName");
	int getPartListNum = Integer.parseInt(request.getParameter("getPartListNum"));
	String partDel[] = request.getParameterValues("partDel");
	
	List<String> paperEditNo = new ArrayList<String>();
	List<String> paperEditName = new ArrayList<String>();
	for (int i=0; i<getPartListNum; i++) {
		paperEditNo.add(request.getParameter("editPartNo"+i));
		paperEditName.add(request.getParameter("editPartName"+i));
	}
	
	int resultADD = 0;
	int resultADDectPart = 0;
	int resultDEL = 0;
	PartDAO partListDAO = new PartDAO();
	ProjectDAO projectListDAO = new ProjectDAO();
	PaperStockDAO paperStockDAO = new PaperStockDAO();
	
	int resultUPDATE = partListDAO.updatePartInfo(paperEditName, paperEditNo);
	
	String createRowName = null;
	boolean createRowResult = true;
	int changePaperListName = 0;
	int createRowDefaultResult = 0;
	
	ArrayList<Project> projectInfo = new ArrayList<Project>();
		
	if (partName!="") {
		resultADD = partListDAO.addPart(partName);
		
		int partNum = 0;
		partNum = partListDAO.selPartNo(partName);
		
		resultADDectPart = projectListDAO.projectAddEct("기타", Integer.toString(partNum));
		
		projectInfo = projectListDAO.allProjectList();

		if(partNum == 1 ) {
			createRowName = "paper_list_quantity_sys_"+projectInfo.get(0).getProjectNo();
		}
		else if(partNum == 2 ) {
			createRowName = "paper_list_quantity_dev_"+projectInfo.get(0).getProjectNo();
		}
		else if(partNum == 3 ) {
			createRowName = "paper_list_quantity_cer_"+projectInfo.get(0).getProjectNo();
		}
		else if(partNum == 4 ) {
			createRowName = "paper_list_quantity_mec_"+projectInfo.get(0).getProjectNo();
		}
		else {
			createRowName = "paper_list_quantity_"+projectInfo.get(0).getProjectPartNo()+"_"+projectInfo.get(0).getProjectNo();
		}
		
		createRowResult = projectListDAO.createRow(createRowName);
		createRowDefaultResult = projectListDAO.createRowDefault(createRowName);
		changePaperListName = projectListDAO.changePaperlistName(createRowName, projectInfo.get(0).getProjectNo());
		
	}
	
	if(partDel != null) {
		int plusResult = 0;
		boolean delRowResult = true;
		
		for (int i=0; i<partDel.length; i++) {
			resultDEL = partListDAO.delPart(partDel[i]);
			plusResult = paperStockDAO.delPartDevPlus(projectListDAO.getDelPartColName(partDel[i]));
			delRowResult = paperStockDAO.delRow(projectListDAO.getDelPartColName(partDel[i]));
		}
	}	
	
	if (resultUPDATE == -1 || resultADD == -1 || resultDEL == -1) {
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
		script.println("location.href = 'manageProject.jsp'");
		script.println("</script>");
	}
	%>
</body>
</html>