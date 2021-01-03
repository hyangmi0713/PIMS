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
		
	String paperName = multipartRequest.getParameter("paperName");
	String paperSize = multipartRequest.getParameter("paperSize");
	String paperKind = multipartRequest.getParameter("paperKind");
	String paperGram = multipartRequest.getParameter("paperGram");
	
	String paperBuNo = multipartRequest.getParameter("paperBuNo");
	String paperPack = multipartRequest.getParameter("paperPack");
	String paperBox = multipartRequest.getParameter("paperBox");
	String paperCost = multipartRequest.getParameter("paperCost");
	String paperMinimum = multipartRequest.getParameter("paperMinimum");
	
	String paperDelivery = multipartRequest.getParameter("paperDelivery");
	String paperVender = multipartRequest.getParameter("paperVender");
	String paperNote = multipartRequest.getParameter("paperNote");
	
	String paperPosition [] = new String [20];
	String lastPaperPosition = "";
	
	for (int i=0; i<20; i++) {
		String tempPosition = "position" + i;
		paperPosition[i] = multipartRequest.getParameter(tempPosition);
		
		if(paperPosition[i] != null) {
			lastPaperPosition = lastPaperPosition + paperPosition[i];
		}
	}
	
	String fileName = null;
	String fileRealName = null;
	
	Enumeration fileNames = multipartRequest.getFileNames();
	while(fileNames.hasMoreElements()) {
		String parameter = (String) fileNames.nextElement();			
		fileName = multipartRequest.getOriginalFileName(parameter);
		fileRealName = multipartRequest.getFilesystemName(parameter);
	}
	
	PaperStockDAO paperStockDAO = new PaperStockDAO();
	PaperinfoDAO paperinfoDAO = new PaperinfoDAO();
	int result = paperStockDAO.paperListAdd(paperSize, paperKind, paperGram);
	int paperNo = paperStockDAO.getPaperNo(paperSize, paperKind, paperGram);
	int paperAddResult = paperinfoDAO.addPaperInfo(paperNo, paperName, paperSize, paperKind, paperGram, fileRealName, fileName, lastPaperPosition,
			paperBuNo, paperPack, paperBox, paperCost, paperMinimum, paperDelivery, paperVender, paperNote);
	
	if (result == -1) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('용지 종류 추가에 실패하였습니다. 관리자에게 문의해주세요.')");
		script.println("history.back()");
		script.println("</script>");
	}
	else {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('용지 종류 추가가 완료되었습니다.')");
		script.println("location.href = 'managePaper.jsp'");
		script.println("</script>");
	} 
	%>
</body>
</html>