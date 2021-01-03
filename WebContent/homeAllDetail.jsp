<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<meta http-equiv="X-UA-Compatible" content="IE=11">
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.*, java.text.*"  %>
<%@ page import="paper.PaperStock"%>
<%@ page import="paper.PaperStockDAO"%>
<%@ page import="stock.Stock" %>
<%@ page import="stock.StockDAO" %>
<%@ page import="part.PartDAO"%>
<%@ page import="part.Part"%>
<%@ page import="project.ProjectDAO" %>
<%@ page import="project.Project" %>
<%@ page import="paperinfo.PaperinfoDAO" %>
<%@ page import="paperinfo.Paperinfo" %>
<%@ page import="java.sql.*"%>

<%
	response.setHeader("Cache-Control","no-cache");
	response.setHeader("Cache-Control","no-store");
	response.setDateHeader("Expires", 0);
	response.setHeader("Pragma","no-cache");	
	
	request.setCharacterEncoding("UTF-8"); 
	
	String menId = null;
	
	if(session.getAttribute("menId") != null) {
		menId = (String) session.getAttribute("menId");
	}
	
	if(menId == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('올바르지 않은 접근입니다.')");
		script.println("location.href = 'index.jsp'");
		script.println("</script>");
	}
%>
<%
	StockDAO stockDAO = new StockDAO();
	ArrayList<Stock> getStockDAO = stockDAO.selStockTable();
	
	PaperinfoDAO paperinfoDAO = new PaperinfoDAO();
	ArrayList<Paperinfo> selPaperTable = new ArrayList<Paperinfo>();
	selPaperTable = paperinfoDAO.allPaperinfo();
	
	PartDAO partDAO = new PartDAO();
	ArrayList<Part> selPartTable = new ArrayList<Part>();
	selPartTable = partDAO.allPartList();
	
	ProjectDAO projectDAO = new ProjectDAO();
	ArrayList<Project> selProjectTable = new ArrayList<Project>();
	selProjectTable = projectDAO.allPartProjectList();
	
	ArrayList<String> totalStackTable = new ArrayList<>();
	
	for(int i=0; i<getStockDAO.size(); i++){
		for(int j=0; j<selPaperTable.size(); j++) {
			if(getStockDAO.get(i).getStockPaperNo() == selPaperTable.get(j).getPinfo_no()) {
				totalStackTable.add(selPaperTable.get(j).getPinfo_size());
				totalStackTable.add(selPaperTable.get(j).getPinfo_kind());
				totalStackTable.add(selPaperTable.get(j).getPinfo_gram());
				totalStackTable.add(selPaperTable.get(j).getPinfo_name());
			}
		}
		
		for(int k=0; k<selPartTable.size(); k++) {
			if(getStockDAO.get(i).getStockPartNo() == selPartTable.get(k).getPartNo()) {
				totalStackTable.add(selPartTable.get(k).getPartName());
			}
		}
		
		for(int l=0; l<selProjectTable.size(); l++) {
			if(getStockDAO.get(i).getStockProjectNo() == selProjectTable.get(l).getProjectNo()) {
				totalStackTable.add(selProjectTable.get(l).getProjectName());
			}
		}
		
		totalStackTable.add(Integer.toString(getStockDAO.get(i).getStockPaperStock()));
	}	
%>

<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width", intial-scale="1">
<title>Canon 용지 재고 관리 프로그램</title>
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/PIMS.css">
<script src="//netdna.bootstrapcdn.com/bootstrap/3.1.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<script src="css/Chart.min.js" type="text/javascript"></script>
<script src="css/utils.js" type="text/javascript"></script>
<script src="css_cmh/jquery.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>


<style>
	body {
	  margin: 0;
	  padding: 0;
	}
	
	.flex-container {
		display: flex;
		margin: auto;
		width: 100%;
	}
	
	.flex-container .flex-item {
		height: 100%;
		display: flex;
		align-items: center;
		justify-content: center;
	}
	
	.flex-container #b {
		border-left: none;
		border-right: none;
		width: 1324px;
	}
	/* The Modal (background) */
	.searchModal {
		display: none; /* Hidden by default */
		position: fixed; /* Stay in place */
		z-index: 10; /* Sit on top */
		left: 0;
		top: 0;
		width: 100%; /* Full width */
		height: 100%; /* Full height */
		overflow: auto; /* Enable scroll if needed */
		background-color: rgb(0, 0, 0); /* Fallback color */
		background-color: rgba(0, 0, 0, 0.4); /* Black w/ opacity */
	}
	/* Modal Content/Box */
	.search-modal-content {
		background-color: #fefefe;
		margin: 15% auto; /* 15% from the top and centered */
		padding: 20px;
		border: 1px solid #888;
		width: 1300px; /* Could be more or less, depending on screen size */
	}
	
	table.type10 {
	    border-collapse: collapse;
	    text-align: left;
	    line-height: 1.5;
	    border-top: 1px solid #ccc;
	    border-bottom: 1px solid #ccc;
	    margin: 20px 10px;
	}
	table.type10 thead th {
	    padding: 10px;
	    font-weight: bold;
	    vertical-align: top;
	    color: #fff;
	    background: #db8e8c;
	    margin: 20px 10px;
	}
	table.type10 tbody th {
	   padding: 10px;
	}
	table.type10 td {
	   padding: 10px;
	    vertical-align: top;
	}
	table.type10 .even {
	    background: #f9f6f1;
	}
</style>
</head>

<body>	
<table width="98%" class="type10" style="font-size:10pt;">
	<thead>
		<tr>
			<th scope="cols" style="text-align:center;" width="50">No.</th>
			<th scope="cols" style="text-align:center;">용지이름</th>
			<th scope="cols" style="text-align:center;">용지사이즈</th>
			<th scope="cols" style="text-align:center;">용지종류</th>
			<th scope="cols" style="text-align:center;">용지평량</th>									
			<th scope="cols" style="text-align:center;">소속부서</th>
			<th scope="cols" style="text-align:center;">소속프로젝트</th>
			<th scope="cols" style="text-align:center;">재고</th>
		</tr>
	</thead>
	<tbody>
		<%
		int j=1;
		for (int i=0; i<totalStackTable.size(); i+=7) {
			if(j%2 != 0) {
		%>
				<tr class="first">
					<td style="text-align:center;"><%=j %></td>
					<td ><%=totalStackTable.get(i+3).toString() %></td>
					<td style="text-align:center;"><%=totalStackTable.get(i).toString() %></td>
					<td style="text-align:center;"><%=totalStackTable.get(i+1).toString() %></td>
					<td style="text-align:center;"><%=totalStackTable.get(i+2).toString() %></td>
					<td style="text-align:center;"><%=totalStackTable.get(i+4).toString() %></td>
					<td style="text-align:center;"><%=totalStackTable.get(i+5).toString() %></td>
					<td style="text-align:center;"><%=totalStackTable.get(i+6).toString() %> Pack</td>
				</tr>
		<%
				j++;
			}
			else {
		%>
				<tr class="first">
					<td class="even" style="text-align:center;"><%=j %></td>
					<td class="even" ><%=totalStackTable.get(i+3).toString() %></td>
					<td class="even" style="text-align:center;"><%=totalStackTable.get(i).toString() %></td>
					<td class="even" style="text-align:center;"><%=totalStackTable.get(i+1).toString() %></td>
					<td class="even" style="text-align:center;"><%=totalStackTable.get(i+2).toString() %></td>
					<td class="even" style="text-align:center;"><%=totalStackTable.get(i+4).toString() %></td>
					<td class="even" style="text-align:center;"><%=totalStackTable.get(i+5).toString() %></td>
					<td class="even" style="text-align:center;"><%=totalStackTable.get(i+6).toString() %> Pack</td>
				</tr>
		<%
				j++;
			}
		}
		%>
	</tbody>
</table>
</body>
</html>