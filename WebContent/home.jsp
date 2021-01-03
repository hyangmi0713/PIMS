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
<%@ page import="graphy.GraphYDAO" %>
<%@ page import="graphy.GraphY" %>
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
<%
	String selSize = null;

	if (request.getParameter("btncheck")!=null) {
		selSize = request.getParameter("btncheck");
	}
	else {
		selSize = "A4";
	}
	
	GraphYDAO graphYDAO = new GraphYDAO();
	ArrayList<GraphY> arrayGraphY = new ArrayList<GraphY>();
	arrayGraphY = graphYDAO.getGraphY(selSize);
	
	String graphSizeY = "'";
	
	String graphSizeX1 = "";
	String graphSizeX2 = "";
	String graphSizeX3 = "";
	String graphSizeX4 = "";
	String graphSizeX5 = "";
	
	if(arrayGraphY.size() >= 5) {
		for(int i=0; i<5; i++) {
			if(i!=4) {
				graphSizeY = graphSizeY + arrayGraphY.get(i).getGraphName();
				graphSizeY = graphSizeY + "', '";

				graphSizeX1 = graphSizeX1 + Integer.toString(graphYDAO.getGraphX(arrayGraphY.get(i).getGraphNo(), 1));
				graphSizeX1 = graphSizeX1 + ", ";

				graphSizeX2 = graphSizeX2 + Integer.toString(graphYDAO.getGraphX(arrayGraphY.get(i).getGraphNo(), 2));
				graphSizeX2 = graphSizeX2 + ", ";
				
				graphSizeX3 = graphSizeX3 + Integer.toString(graphYDAO.getGraphX(arrayGraphY.get(i).getGraphNo(), 3));
				graphSizeX3 = graphSizeX3 + ", ";
				
				graphSizeX4 = graphSizeX4 + Integer.toString(graphYDAO.getGraphX(arrayGraphY.get(i).getGraphNo(), 4));
				graphSizeX4 = graphSizeX4 + ", ";
				
				graphSizeX5 = graphSizeX5 + Integer.toString(graphYDAO.getGraphXPart5(arrayGraphY.get(i).getGraphNo()));
				graphSizeX5 = graphSizeX5 + ", ";
			}
			else if(i==4) {
				graphSizeY = graphSizeY + arrayGraphY.get(i).getGraphName();
				graphSizeY = graphSizeY + "'";
				
				graphSizeX1 = graphSizeX1 + Integer.toString(graphYDAO.getGraphX(arrayGraphY.get(i).getGraphNo(), 1));

				graphSizeX2 = graphSizeX2 + Integer.toString(graphYDAO.getGraphX(arrayGraphY.get(i).getGraphNo(), 2));
				
				graphSizeX3 = graphSizeX3 + Integer.toString(graphYDAO.getGraphX(arrayGraphY.get(i).getGraphNo(), 3));
				
				graphSizeX4 = graphSizeX4 + Integer.toString(graphYDAO.getGraphX(arrayGraphY.get(i).getGraphNo(), 4));
				
				graphSizeX5 = graphSizeX5 + Integer.toString(graphYDAO.getGraphXPart5(arrayGraphY.get(i).getGraphNo()));
			}
		}
	}
	else {
		for(int i=0; i<arrayGraphY.size(); i++) {
			graphSizeY = graphSizeY + arrayGraphY.get(i).getGraphName();
			graphSizeY = graphSizeY + "', '";
			
			graphSizeX1 = graphSizeX1 + Integer.toString(graphYDAO.getGraphX(arrayGraphY.get(i).getGraphNo(), 1));
			graphSizeX1 = graphSizeX1 + ", ";

			graphSizeX2 = graphSizeX2 + Integer.toString(graphYDAO.getGraphX(arrayGraphY.get(i).getGraphNo(), 2));
			graphSizeX2 = graphSizeX2 + ", ";
			
			graphSizeX3 = graphSizeX3 + Integer.toString(graphYDAO.getGraphX(arrayGraphY.get(i).getGraphNo(), 3));
			graphSizeX3 = graphSizeX3 + ", ";
			
			graphSizeX4 = graphSizeX4 + Integer.toString(graphYDAO.getGraphX(arrayGraphY.get(i).getGraphNo(), 4));
			graphSizeX4 = graphSizeX4 + ", ";
			
			graphSizeX5 = graphSizeX5 + Integer.toString(graphYDAO.getGraphXPart5(arrayGraphY.get(i).getGraphNo()));
			graphSizeX5 = graphSizeX5 + ", ";
		}
		for(int j=0; j<4-arrayGraphY.size(); j++) {
			graphSizeY = graphSizeY + "', '";
			
			graphSizeX1 = graphSizeX1 + "0, ";

			graphSizeX2 = graphSizeX2 + "0, ";
			
			graphSizeX3 = graphSizeX3 + "0, ";
			
			graphSizeX4 = graphSizeX4 + "0, ";
			
			graphSizeX5 = graphSizeX5 + "0, ";
		}
		graphSizeY = graphSizeY + "'";
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
<script src="css_cmh/jquery.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script src="css_hyang/Chart.bundle.min.js"></script>
<script src="css_hyang/chartjs-plugin-labels.min.js"></script>
<script src="css_hyang/Utils.js"></script>

<style>
	body {
	  background-image: url("imageNew/home_02.png");
	  background-repeat:repeat-x;
	  margin: 0;
	  padding: 0;
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
	<form id="target" action="home.jsp" method="POST" >
	<nav class="navbar navbar-default">
		<jsp:include page="navbar.jsp" flush="false" />
	</nav>
	
	<table style="margin-left: auto; margin-right: auto;">
		<tr>
			<td width="108" style="background-image: url('imageNew/home1_30.png'); background-repeat:repeat-y; " valign="top">
				<table>
					<tr>
						<td width="108" style="background-image: url('imageNew/home_22.png'); background-repeat:no-repeat; background-position: top right; padding-top:30px;">
												
						</td>
					</tr>
				</table>
			</td>
			<td>
		<div class="container" style="padding-top:50px; ">
			<div class="container">
				<div>
					<button type="button" class="btn btn-default pull-right" style="margin-right:70px; font-size:10pt;" onclick="window.open('homeAllDetail.jsp')">전체현황상세</button>
				</div>
				<div id="canvas-holder" style="width:1300px; padding-top:40px;">
					<canvas id="stChart" style="width:1300px; height:550px; display: block;"></canvas>
				</div>
				<div>
					<div style="font-size:9pt; color:#666666; padding-left:1230px;"><b>단위 : pack</b></div>
					<div class="btn-group mr-2" style="padding-left: 410px;">
						<%
							String[] btnname = {"A4","A3","A5","LDR","LTR","LGL","B4","B5","8K","16K"};
							String btnSelStr = "btn btn-inverse";
							
							for(int i=0; i<btnname.length;i++){
								if(selSize.equals(btnname[i])) {
									btnSelStr = "btn activebtn";
								}
								else {
									btnSelStr = "btn btn-inverse";
								}
						%>
							<input type="submit" class="<%=btnSelStr %>" id="btncheck" name="btncheck" value="<%=btnname[i] %>" >
						<%
							}
						%>
					</div>
				</div>
			</div>
		</div>
		<br><br>
		</td>
		<td width="45" style="background-image: url('imageNew/home_25.png'); background-repeat:repeat-y; " valign="top">
			<img src="imageNew/home_24.png" >
		</td>
		</tr>
	</table>
	
	<footer style="background-color: #e5dfd5; color: #d69994; height:50px;">
		<jsp:include page="footer.jsp" flush="false" />	
	</footer>
	</form>
</body>

<script>
drawColumnChart();
function drawColumnChart() {
	var barOptions_stacked = {
		tooltips: {
			enabled: true
		},
		hover :{
			animationDuration:0
		},
		scales: {
			xAxes: [{
				ticks: {
					beginAtZero:true,
					fontFamily: "'Meiryo UI', sans-serif",
					fontSize:11
				},
				scaleLabel:{
					display:false
				},
				gridLines: {
				}, 
				stacked: true
			}],
			yAxes: [{
				gridLines: {
					display:false,
					color: "#fff",
					zeroLineColor: "#fff",
					zeroLineWidth: 0
				},
				ticks: {
					fontFamily: "'Meiryo UI', sans-serif",
					fontSize:11
				},
				stacked: true
			}]
		},
		legend:{
			display:true
		},
		pointLabelFontFamily : "Quadon Extra Bold",
		scaleFontFamily : "Quadon Extra Bold",
	};
	var ctx = document.getElementById("stChart");
	var myChart = new Chart(ctx, {
		type: 'horizontalBar',
		data: {
			labels: [<%=graphSizeY%>],
			
			datasets: [{
				data: [<%=graphSizeX1%>],
				backgroundColor: "rgba(211, 133, 135, 0.4)",
				hoverBackgroundColor: "rgba(211, 133, 135, 0.7)",
				label: '디바이스평가담당'
			},{
				data: [<%=graphSizeX2%>],
				backgroundColor: "rgba(135, 133, 211, 0.4)",
				hoverBackgroundColor: "rgba(135, 133, 211, 0.7)",
				label: '시스템평가담당'
			},{
				data: [<%=graphSizeX3%>],
				backgroundColor: "rgba(229, 223, 213, 0.5)",
				hoverBackgroundColor: "rgba(229, 223, 213, 0.8)",
				label: '인증평가담당'
			},{
				data: [<%=graphSizeX4%>],
				backgroundColor: "rgba(210, 133, 211, 0.4)",
				hoverBackgroundColor: "rgba(210, 133, 211, 0.7)",
				label: '메카프로설계담당'
			},{
				data: [<%=graphSizeX5%>],
				backgroundColor: "rgba(211, 175, 133, 0.4)",
				hoverBackgroundColor: "rgba(211, 175, 133, 0.7)",
				label: '기타'
			}]
		},

		options: barOptions_stacked
	});
}
</script>
</html>