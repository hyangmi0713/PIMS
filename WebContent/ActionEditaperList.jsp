<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.io.File" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.io.IOException" %>
<%@page import="java.util.*"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="paper.PaperStockDAO"%>
<%@ page import="paper.PaperStock"%>
<%@ page import="paperinfo.PaperinfoDAO"%>
<%@ page import="paperinfo.Paperinfo"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>
	<%
	String directory = application.getRealPath("/paperImage/");
	int maxSize = 1024*1024*1024;
	String encoding = "UTF-8";
	
	MultipartRequest multipartRequest = new MultipartRequest(request, directory, maxSize, encoding, new DefaultFileRenamePolicy());
		
	int paperNo = Integer.parseInt(multipartRequest.getParameter("paperNoEdit"));
	String paperName = multipartRequest.getParameter("paperNameEdit");
	String paperSize = multipartRequest.getParameter("paperSizeEdit");
	String paperKind = multipartRequest.getParameter("paperKindEdit");
	String paperGram = multipartRequest.getParameter("paperGramEdit");
	
	String paperBuNo = multipartRequest.getParameter("paperBuNoEdit");
	String paperPack = multipartRequest.getParameter("paperPackEdit");
	String paperBox = multipartRequest.getParameter("paperBoxEdit");
	String paperCost = multipartRequest.getParameter("paperCostEdit");
	String paperMinimum = multipartRequest.getParameter("paperMinimumEdit");
	
	String paperDelivery = multipartRequest.getParameter("paperDeliveryEdit");
	String paperVender = multipartRequest.getParameter("paperVenderEdit");
	String paperNote = multipartRequest.getParameter("paperNoteEdit");
	
	int fileChangeFlag = Integer.parseInt(multipartRequest.getParameter("fileChangeFlag"));
	String realfilenameChangeFlag = multipartRequest.getParameter("realfilenameChangeFlag");
	String fileNameChangeFlag = multipartRequest.getParameter("fileNameChangeFlag");
		
	String paperPosition [] = new String [20];
	String lastPaperPosition = "";
	
	for (int i=0; i<20; i++) {
		String tempPosition = "position" + i + "Edit";
		paperPosition[i] = multipartRequest.getParameter(tempPosition);
		
		if(paperPosition[i] != null) {
			lastPaperPosition = lastPaperPosition + paperPosition[i];
		}
	}
		
	String fileName = null;
	String fileRealName = null;
	
	if(fileChangeFlag==0) {
		fileName = fileNameChangeFlag;
		fileRealName = realfilenameChangeFlag;
	}
	else {
		Enumeration fileNames = multipartRequest.getFileNames();
		while(fileNames.hasMoreElements()) {
			String parameter = (String) fileNames.nextElement();			
			fileName = multipartRequest.getOriginalFileName(parameter);
			fileRealName = multipartRequest.getFilesystemName(parameter);
		}
	}
	
	/* PaperStockDAO paperStockDAO = new PaperStockDAO(); */
	PaperinfoDAO paperinfoDAO = new PaperinfoDAO();
	/* int result = paperStockDAO.paperListAdd(paperSize, paperKind, paperGram);
	int paperNo = paperStockDAO.getPaperNo(paperSize, paperKind, paperGram); */
	int paperAddResult = paperinfoDAO.editPaperInfo(paperNo, paperName, paperSize, paperKind, paperGram, fileRealName, fileName, lastPaperPosition,
			paperBuNo, paperPack, paperBox, paperCost, paperMinimum, paperDelivery, paperVender, paperNote);
	
	if (paperAddResult == -1) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('용지 종류 수정에 실패하였습니다. 관리자에게 문의해주세요.')");
		script.println("history.back()");
		script.println("</script>");
	}
	else {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('용지 종류 수정이 완료되었습니다.')");
		script.println("location.href = 'managePaper.jsp'");
		script.println("</script>");
	} 
	%>
</body>
</html>