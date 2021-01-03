<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<meta http-equiv="X-UA-Compatible" content="IE=11">
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.*, java.text.*"  %>
<%@ page import="paper.PaperStock"%>
<%@ page import="paper.PaperStockDAO"%>
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


<style>
	body {
	  background-image: url("imageNew/home_02.png");
	  background-repeat:repeat-x;
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
</style>
</head>

<body>	
	<nav class="navbar navbar-default">
		<jsp:include page="navbar.jsp" flush="false" />
	</nav>
	<div class="container">
	<!-- <div class="flex-container">
		<div class="flex-item" id="a">aa</div>
		<div class="flex-item" id="b"> -->
			<div class="container">
				<div id="canvas-holder" style="width: 1150px">
					<canvas id="chart-area" style="width: 1100px; height: 500px; display: block;"></canvas>
				</div>
				<div>
				
					<div class="btn-group mr-2" style="padding-left: 250px; padding-top: 50px;">
					<!-- <form name="ActionDrawGraph" action="ActionDrawGraph.jsp" method="POST"> -->
						<%
							String[] btnname = {"A2","A3","A4","B4","B5","LTR","LDR","EXEC","STMT","A6"};
							int btnsize = btnname.length;
							String selectedPaper;
							
							for(int i=0; i<btnsize;i++){
						%>
								<button class="btn btn-inverse" id="btncheck" name="btncheck" onclick="btncheck('<%= btnname[i] %>');"><%= btnname[i] %></button>
						
						<%}%>
					</div>
					<!-- 
					<script>
						function btncheck(btnname){
							selectedPaper = btnname;
							alert(selectedPaper);
						
						}


					</script> -->
					<!-- </form> -->					
					
					
					<!-- <div class="btn-group mr-2" style="padding-left: 250px; padding-top: 50px;">
						<button class="btn btn-inverse" type="button" id="dataChange_A4">A4</button>
						<button class="btn btn-inverse" type="button" id="dataChange_A3">A3</button>
						<button class="btn btn-inverse" type="button" id="dataChange_A5">A5</button>
						<button class="btn btn-inverse" type="button" id="dataChange_B4B5">B4/B5</button>
						<button class="btn btn-inverse" type="button" id="dataChange_LTR">LTR</button>
						<button class="btn btn-inverse" type="button" id="dataChange_LGLLDR">LGL/LDR</button>
						<button class="btn btn-inverse" type="button" id="dataChange_A2A6">A2/A6</button>
						<button class="btn btn-inverse" type="button" id="dataChange_EXECSTMT">EXEC/STMT</button>
						<button class="btn btn-inverse" type="button" id="dataChange_16K8K">16K/8K</button>
						<button class="btn btn-inverse" type="button" id="dataChange_ENV">봉투</button>

						
					</div> -->
				</div>
			</div>
		</div>
		<!-- <div class="flex-item" id="c">cc</div>
	</div>
	</div> -->
	<br><br>
	<footer style="background-color: #e5dfd5; color: #d69994" height="50px;">
		<jsp:include page="footer.jsp" flush="false" />	
	</footer>
</body>
<script>
	var no = new Array();
	var size = new Array();
	var kind = new Array();
	var gram = new Array();
	var q_sys = new Array();
	var q_dev = new Array();
	var q_cert = new Array();
	var q_meca = new Array();
	var q_qa = new Array();
	var graphlabel = new Array();
	
	var A3_no = new Array();
	var A3_size = new Array();
	var A3_kind = new Array();
	var A3_gram = new Array();
	var A3_q_sys = new Array();
	var A3_q_dev = new Array();
	var A3_q_cert = new Array();
	var A3_q_meca = new Array();
	var A3_q_qa = new Array();
	var A3_graphlabel = new Array();
	
	var A5_no = new Array();
	var A5_size = new Array();
	var A5_kind = new Array();
	var A5_gram = new Array();
	var A5_q_sys = new Array();
	var A5_q_dev = new Array();
	var A5_q_cert = new Array();
	var A5_q_meca = new Array();
	var A5_q_qa = new Array();
	var A5_graphlabel = new Array();
	
	var B4B5_no = new Array();
	var B4B5_size = new Array();
	var B4B5_kind = new Array();
	var B4B5_gram = new Array();
	var B4B5_q_sys = new Array();
	var B4B5_q_dev = new Array();
	var B4B5_q_cert = new Array();
	var B4B5_q_meca = new Array();
	var B4B5_q_qa = new Array();
	var B4B5_graphlabel = new Array();
	
	var LTR_no = new Array();
	var LTR_size = new Array();
	var LTR_kind = new Array();
	var LTR_gram = new Array();
	var LTR_q_sys = new Array();
	var LTR_q_dev = new Array();
	var LTR_q_cert = new Array();
	var LTR_q_meca = new Array();
	var LTR_q_qa = new Array();
	var LTR_graphlabel = new Array();
	
	var LGLLDR_no = new Array();
	var LGLLDR_size = new Array();
	var LGLLDR_kind = new Array();
	var LGLLDR_gram = new Array();
	var LGLLDR_q_sys = new Array();
	var LGLLDR_q_dev = new Array();
	var LGLLDR_q_cert = new Array();
	var LGLLDR_q_meca = new Array();
	var LGLLDR_q_qa = new Array();
	var LGLLDR_graphlabel = new Array();
	
	var A2A6_no = new Array();
	var A2A6_size = new Array();
	var A2A6_kind = new Array();
	var A2A6_gram = new Array();
	var A2A6_q_sys = new Array();
	var A2A6_q_dev = new Array();
	var A2A6_q_cert = new Array();
	var A2A6_q_meca = new Array();
	var A2A6_q_qa = new Array();
	var A2A6_graphlabel = new Array();
	
	var EXECSTMT_no = new Array();
	var EXECSTMT_size = new Array();
	var EXECSTMT_kind = new Array();
	var EXECSTMT_gram = new Array();
	var EXECSTMT_q_sys = new Array();
	var EXECSTMT_q_dev = new Array();
	var EXECSTMT_q_cert = new Array();
	var EXECSTMT_q_meca = new Array();
	var EXECSTMT_q_qa = new Array();
	var EXECSTMT_graphlabel = new Array();
	
	var K16K8_no = new Array();
	var K16K8_size = new Array();
	var K16K8_kind = new Array();
	var K16K8_gram = new Array();
	var K16K8_q_sys = new Array();
	var K16K8_q_dev = new Array();
	var K16K8_q_cert = new Array();
	var K16K8_q_meca = new Array();
	var K16K8_q_qa = new Array();
	var K16K8_graphlabel = new Array();
	
	var ENV_no = new Array();
	var ENV_size = new Array();
	var ENV_kind = new Array();
	var ENV_gram = new Array();
	var ENV_q_sys = new Array();
	var ENV_q_dev = new Array();
	var ENV_q_cert = new Array();
	var ENV_q_meca = new Array();
	var ENV_q_qa = new Array();
	var ENV_graphlabel = new Array();
</script>

<%
	PaperStockDAO paperstockDAO = new PaperStockDAO();
	ArrayList<PaperStock> list = paperstockDAO.getPaperStock();
	ArrayList<PaperStock> list_A3 = paperstockDAO.getPaperStock_A3();
	ArrayList<PaperStock> list_A5 = paperstockDAO.getPaperStock_A5();
	ArrayList<PaperStock> list_B4B5 = paperstockDAO.getPaperStock_B4B5();
	ArrayList<PaperStock> list_LTR = paperstockDAO.getPaperStock_LTR();
	ArrayList<PaperStock> list_LGLLDR = paperstockDAO.getPaperStock_LGLLDR();
	ArrayList<PaperStock> list_A2A6 = paperstockDAO.getPaperStock_A2A6();
	ArrayList<PaperStock> list_EXECSTMT = paperstockDAO.getPaperStock_EXECSTMT();
	ArrayList<PaperStock> list_16K8K = paperstockDAO.getPaperStock_16K8K();
	ArrayList<PaperStock> list_ENV = paperstockDAO.getPaperStock_ENV();

	for(int i=0; i<list.size(); i++){
%>
	<script>
		no.push("<%= list.get(i).getPaper_list_no()%>");
		size.push("<%= list.get(i).getPaper_list_size()%>");
		kind.push("<%= list.get(i).getPaper_list_kind()%>");
		gram.push("<%= list.get(i).getPaper_list_gram()%>");
		q_sys.push("<%= list.get(i).getPaper_list_quantity_sys()%>");
		q_dev.push("<%= list.get(i).getPaper_list_quantity_dev()%>");
		q_cert.push("<%= list.get(i).getPaper_list_quantity_cer()%>");
		q_meca.push("<%= list.get(i).getPaper_list_quantity_mec()%>");
		q_qa.push("<%= list.get(i).getPaper_list_quantity_qa()%>");
		graphlabel.push("<%=list.get(i).getPaper_list_size()%>_<%=list.get(i).getPaper_list_kind()%>_<%=list.get(i).getPaper_list_gram()%>g");
	</script>
<%
	} 
	for(int i=0; i<list_A3.size(); i++){
%>
	<script>
		A3_no.push("<%= list_A3.get(i).getPaper_list_no()%>");
		A3_size.push("<%= list_A3.get(i).getPaper_list_size()%>");
		A3_kind.push("<%= list_A3.get(i).getPaper_list_kind()%>");
		A3_gram.push("<%= list_A3.get(i).getPaper_list_gram()%>");
		A3_q_sys.push("<%= list_A3.get(i).getPaper_list_quantity_sys()%>");
		A3_q_dev.push("<%= list_A3.get(i).getPaper_list_quantity_dev()%>");
		A3_q_cert.push("<%= list_A3.get(i).getPaper_list_quantity_cer()%>");
		A3_q_meca.push("<%= list_A3.get(i).getPaper_list_quantity_mec()%>");
		A3_q_qa.push("<%= list_A3.get(i).getPaper_list_quantity_qa()%>");
		A3_graphlabel.push("<%=list_A3.get(i).getPaper_list_size()%>_<%=list_A3.get(i).getPaper_list_kind()%>_<%=list_A3.get(i).getPaper_list_gram()%>g");
	</script>
<%
	}
    for(int i=0; i<list_A5.size(); i++){
%>
	<script>
		A5_no.push("<%= list_A5.get(i).getPaper_list_no()%>");
		A5_size.push("<%= list_A5.get(i).getPaper_list_size()%>");
		A5_kind.push("<%= list_A5.get(i).getPaper_list_kind()%>");
		A5_gram.push("<%= list_A5.get(i).getPaper_list_gram()%>");
		A5_q_sys.push("<%= list_A5.get(i).getPaper_list_quantity_sys()%>");
		A5_q_dev.push("<%= list_A5.get(i).getPaper_list_quantity_dev()%>");
		A5_q_cert.push("<%= list_A5.get(i).getPaper_list_quantity_cer()%>");
		A5_q_meca.push("<%= list_A5.get(i).getPaper_list_quantity_mec()%>");
		A5_q_qa.push("<%= list_A5.get(i).getPaper_list_quantity_qa()%>");
		A5_graphlabel.push("<%=list_A5.get(i).getPaper_list_size()%>_<%=list_A5.get(i).getPaper_list_kind()%>_<%=list_A5.get(i).getPaper_list_gram()%>g");
	</script>
<%
	}
    for(int i=0; i<list_B4B5.size(); i++){
%>
	<script>
		B4B5_no.push("<%= list_B4B5.get(i).getPaper_list_no()%>");
		B4B5_size.push("<%= list_B4B5.get(i).getPaper_list_size()%>");
		B4B5_kind.push("<%= list_B4B5.get(i).getPaper_list_kind()%>");
		B4B5_gram.push("<%= list_B4B5.get(i).getPaper_list_gram()%>");
		B4B5_q_sys.push("<%= list_B4B5.get(i).getPaper_list_quantity_sys()%>");
		B4B5_q_dev.push("<%= list_B4B5.get(i).getPaper_list_quantity_dev()%>");
		B4B5_q_cert.push("<%= list_B4B5.get(i).getPaper_list_quantity_cer()%>");
		B4B5_q_meca.push("<%= list_B4B5.get(i).getPaper_list_quantity_mec()%>");
		B4B5_q_qa.push("<%= list_B4B5.get(i).getPaper_list_quantity_qa()%>");
		B4B5_graphlabel.push("<%=list_B4B5.get(i).getPaper_list_size()%>_<%=list_B4B5.get(i).getPaper_list_kind()%>_<%=list_B4B5.get(i).getPaper_list_gram()%>g");
	</script>
<%
	}
    for(int i=0; i<list_LTR.size(); i++){
%>
	<script>
		LTR_no.push("<%= list_LTR.get(i).getPaper_list_no()%>");
		LTR_size.push("<%= list_LTR.get(i).getPaper_list_size()%>");
		LTR_kind.push("<%= list_LTR.get(i).getPaper_list_kind()%>");
		LTR_gram.push("<%= list_LTR.get(i).getPaper_list_gram()%>");
		LTR_q_sys.push("<%= list_LTR.get(i).getPaper_list_quantity_sys()%>");
		LTR_q_dev.push("<%= list_LTR.get(i).getPaper_list_quantity_dev()%>");
		LTR_q_cert.push("<%= list_LTR.get(i).getPaper_list_quantity_cer()%>");
		LTR_q_meca.push("<%= list_LTR.get(i).getPaper_list_quantity_mec()%>");
		LTR_q_qa.push("<%= list_LTR.get(i).getPaper_list_quantity_qa()%>");
		LTR_graphlabel.push("<%=list_LTR.get(i).getPaper_list_size()%>_<%=list_LTR.get(i).getPaper_list_kind()%>_<%=list_LTR.get(i).getPaper_list_gram()%>g");
	</script>
<%
	}
    for(int i=0; i<list_LGLLDR.size(); i++){
%>
	<script>
		LGLLDR_no.push("<%= list_LGLLDR.get(i).getPaper_list_no()%>");
		LGLLDR_size.push("<%= list_LGLLDR.get(i).getPaper_list_size()%>");
		LGLLDR_kind.push("<%= list_LGLLDR.get(i).getPaper_list_kind()%>");
		LGLLDR_gram.push("<%= list_LGLLDR.get(i).getPaper_list_gram()%>");
		LGLLDR_q_sys.push("<%= list_LGLLDR.get(i).getPaper_list_quantity_sys()%>");
		LGLLDR_q_dev.push("<%= list_LGLLDR.get(i).getPaper_list_quantity_dev()%>");
		LGLLDR_q_cert.push("<%= list_LGLLDR.get(i).getPaper_list_quantity_cer()%>");
		LGLLDR_q_meca.push("<%= list_LGLLDR.get(i).getPaper_list_quantity_mec()%>");
		LGLLDR_q_qa.push("<%= list_LGLLDR.get(i).getPaper_list_quantity_qa()%>");
		LGLLDR_graphlabel.push("<%=list_LGLLDR.get(i).getPaper_list_size()%>_<%=list_LGLLDR.get(i).getPaper_list_kind()%>_<%=list_LGLLDR.get(i).getPaper_list_gram()%>g");
	</script>
<%
	}
    for(int i=0; i<list_A2A6.size(); i++){
%>
	<script>
		A2A6_no.push("<%= list_A2A6.get(i).getPaper_list_no()%>");
		A2A6_size.push("<%= list_A2A6.get(i).getPaper_list_size()%>");
		A2A6_kind.push("<%= list_A2A6.get(i).getPaper_list_kind()%>");
		A2A6_gram.push("<%= list_A2A6.get(i).getPaper_list_gram()%>");
		A2A6_q_sys.push("<%= list_A2A6.get(i).getPaper_list_quantity_sys()%>");
		A2A6_q_dev.push("<%= list_A2A6.get(i).getPaper_list_quantity_dev()%>");
		A2A6_q_cert.push("<%= list_A2A6.get(i).getPaper_list_quantity_cer()%>");
		A2A6_q_meca.push("<%= list_A2A6.get(i).getPaper_list_quantity_mec()%>");
		A2A6_q_qa.push("<%= list_A2A6.get(i).getPaper_list_quantity_qa()%>");
		A2A6_graphlabel.push("<%=list_A2A6.get(i).getPaper_list_size()%>_<%=list_A2A6.get(i).getPaper_list_kind()%>_<%=list_A2A6.get(i).getPaper_list_gram()%>g");
	</script>
<%
	}
    for(int i=0; i<list_EXECSTMT.size(); i++){
%>
	<script>
		EXECSTMT_no.push("<%= list_EXECSTMT.get(i).getPaper_list_no()%>");
		EXECSTMT_size.push("<%= list_EXECSTMT.get(i).getPaper_list_size()%>");
		EXECSTMT_kind.push("<%= list_EXECSTMT.get(i).getPaper_list_kind()%>");
		EXECSTMT_gram.push("<%= list_EXECSTMT.get(i).getPaper_list_gram()%>");
		EXECSTMT_q_sys.push("<%= list_EXECSTMT.get(i).getPaper_list_quantity_sys()%>");
		EXECSTMT_q_dev.push("<%= list_EXECSTMT.get(i).getPaper_list_quantity_dev()%>");
		EXECSTMT_q_cert.push("<%= list_EXECSTMT.get(i).getPaper_list_quantity_cer()%>");
		EXECSTMT_q_meca.push("<%= list_EXECSTMT.get(i).getPaper_list_quantity_mec()%>");
		EXECSTMT_q_qa.push("<%= list_EXECSTMT.get(i).getPaper_list_quantity_qa()%>");
		EXECSTMT_graphlabel.push("<%=list_EXECSTMT.get(i).getPaper_list_size()%>_<%=list_EXECSTMT.get(i).getPaper_list_kind()%>_<%=list_EXECSTMT.get(i).getPaper_list_gram()%>g");
	</script>
<%
	}
    for(int i=0; i<list_16K8K.size(); i++){
%>
	<script>
		K16K8_no.push("<%= list_16K8K.get(i).getPaper_list_no()%>");
		K16K8_size.push("<%= list_16K8K.get(i).getPaper_list_size()%>");
		K16K8_kind.push("<%= list_16K8K.get(i).getPaper_list_kind()%>");
		K16K8_gram.push("<%= list_16K8K.get(i).getPaper_list_gram()%>");
		K16K8_q_sys.push("<%= list_16K8K.get(i).getPaper_list_quantity_sys()%>");
		K16K8_q_dev.push("<%= list_16K8K.get(i).getPaper_list_quantity_dev()%>");
		K16K8_q_cert.push("<%= list_16K8K.get(i).getPaper_list_quantity_cer()%>");
		K16K8_q_meca.push("<%= list_16K8K.get(i).getPaper_list_quantity_mec()%>");
		K16K8_q_qa.push("<%= list_16K8K.get(i).getPaper_list_quantity_qa()%>");
		K16K8_graphlabel.push("<%=list_16K8K.get(i).getPaper_list_size()%>_<%=list_16K8K.get(i).getPaper_list_kind()%>_<%=list_16K8K.get(i).getPaper_list_gram()%>g");
	</script>
<%
	}
    for(int i=0; i<list_ENV.size(); i++){
%>
	<script>
		ENV_no.push("<%= list_ENV.get(i).getPaper_list_no()%>");
		ENV_size.push("<%= list_ENV.get(i).getPaper_list_size()%>");
		ENV_kind.push("<%= list_ENV.get(i).getPaper_list_kind()%>");
		ENV_gram.push("<%= list_ENV.get(i).getPaper_list_gram()%>");
		ENV_q_sys.push("<%= list_ENV.get(i).getPaper_list_quantity_sys()%>");
		ENV_q_dev.push("<%= list_ENV.get(i).getPaper_list_quantity_dev()%>");
		ENV_q_cert.push("<%= list_ENV.get(i).getPaper_list_quantity_cer()%>");
		ENV_q_meca.push("<%= list_ENV.get(i).getPaper_list_quantity_mec()%>");
		ENV_q_qa.push("<%= list_ENV.get(i).getPaper_list_quantity_qa()%>");
		ENV_graphlabel.push("<%=list_ENV.get(i).getPaper_list_size()%>_<%=list_ENV.get(i).getPaper_list_kind()%>_<%=list_ENV.get(i).getPaper_list_gram()%>g");
	</script>
<%
	}
%>

<script>
var config = {
	type: 'horizontalBar',
	data: {
		datasets: [
		{
			data: q_sys,
			backgroundColor:"#49494b",
			label: '시스템평가담당'
		},
		
		{
			data: q_dev,
			backgroundColor:"#8e8e90",
			label: '디바이스평가담당'
		},
		
		{
			data: q_cert,
			backgroundColor:"#bd8c7d",
			label: '인증평가담당'
		},
		
		{
			data: q_meca,
			backgroundColor:"#d1bfa7",
			label: '메카프로설계'
		},
		
		{
			data: q_qa,
			backgroundColor:"#d1ccc1",
			label: 'QA'
		}],
		
		labels:graphlabel
	},
	options: {
		responsive: false,
		maintainAspectRatio:true,
		scales:{
			xAxes:[
				{stacked:true,}
			],
			yAxes:[
				{stacked:true}
			]
		}
	}
};
												
window.onload = function() {
	var ctx = document.getElementById('chart-area').getContext('2d');
	window.myPie = new Chart(ctx, config);
};


document.getElementById('dataChange_A4').addEventListener('click', function() {
	var newData ={
			datasets: [
				{data: q_sys, backgroundColor:"#49494b", label: '시스템평가담당'},
				{data: q_dev, backgroundColor:"#8e8e90", label: '디바이스평가담당'},																
				{data: q_cert, backgroundColor: "#bd8c7d", label: '인증평가담당'},																
				{data: q_meca, backgroundColor:"#d1bfa7", label: '메카프로설계'},																
				{data: q_qa, backgroundColor: "#d1ccc1", label: 'QA'}],
			labels:graphlabel
			}
		window.myPie.data=newData;
		window.myPie.update();
		
});

document.getElementById('dataChange_A3').addEventListener('click', function() {
	var newData ={
			datasets: [
				{data: A3_q_sys, backgroundColor:"#49494b", label: '시스템평가담당'},
				{data: A3_q_dev, backgroundColor:"#8e8e90", label: '디바이스평가담당'},																
				{data: A3_q_cert, backgroundColor: "#bd8c7d", label: '인증평가담당'},																
				{data: A3_q_meca, backgroundColor:"#d1bfa7", label: '메카프로설계'},																
				{data: A3_q_qa, backgroundColor: "#d1ccc1", label: 'QA'}],
			labels:A3_graphlabel
			}
		window.myPie.data=newData;
		window.myPie.update();
		
});

document.getElementById('dataChange_A5').addEventListener('click', function() {
	var newData ={
			datasets: [
				{data: A5_q_sys, backgroundColor:"#49494b", label: '시스템평가담당'},
				{data: A5_q_dev, backgroundColor:"#8e8e90", label: '디바이스평가담당'},																
				{data: A5_q_cert, backgroundColor: "#bd8c7d", label: '인증평가담당'},																
				{data: A5_q_meca, backgroundColor:"#d1bfa7", label: '메카프로설계'},																
				{data: A5_q_qa, backgroundColor: "#d1ccc1", label: 'QA'}],
			labels:A5_graphlabel
			}
		window.myPie.data=newData;
		window.myPie.update();
});

document.getElementById('dataChange_B4B5').addEventListener('click', function() {
	var newData ={
			datasets: [
				{data: B4B5_q_sys, backgroundColor:"#49494b", label: '시스템평가담당'},
				{data: B4B5_q_dev, backgroundColor:"#8e8e90", label: '디바이스평가담당'},																
				{data: B4B5_q_cert, backgroundColor: "#bd8c7d", label: '인증평가담당'},																
				{data: B4B5_q_meca, backgroundColor:"#d1bfa7", label: '메카프로설계'},																
				{data: B4B5_q_qa, backgroundColor: "#d1ccc1", label: 'QA'}],
			labels:B4B5_graphlabel
			}
		window.myPie.data=newData;
		window.myPie.update();
});

document.getElementById('dataChange_LTR').addEventListener('click', function() {
	var newData ={
			datasets: [
				{data: LTR_q_sys, backgroundColor:"#49494b", label: '시스템평가담당'},
				{data: LTR_q_dev, backgroundColor:"#8e8e90", label: '디바이스평가담당'},																
				{data: LTR_q_cert, backgroundColor: "#bd8c7d", label: '인증평가담당'},																
				{data: LTR_q_meca, backgroundColor:"#d1bfa7", label: '메카프로설계'},																
				{data: LTR_q_qa, backgroundColor: "#d1ccc1", label: 'QA'}],
			labels:LTR_graphlabel
			}
		window.myPie.data=newData;
		window.myPie.update();
});

document.getElementById('dataChange_LGLLDR').addEventListener('click', function() {
	var newData ={
			datasets: [
				{data: LGLLDR_q_sys, backgroundColor:"#49494b", label: '시스템평가담당'},
				{data: LGLLDR_q_dev, backgroundColor:"#8e8e90", label: '디바이스평가담당'},																
				{data: LGLLDR_q_cert, backgroundColor: "#bd8c7d", label: '인증평가담당'},																
				{data: LGLLDR_q_meca, backgroundColor:"#d1bfa7", label: '메카프로설계'},																
				{data: LGLLDR_q_qa, backgroundColor: "#d1ccc1", label: 'QA'}],
			labels:LGLLDR_graphlabel
			}
		window.myPie.data=newData;
		window.myPie.update();
});

document.getElementById('dataChange_A2A6').addEventListener('click', function() {
	var newData ={
			datasets: [
				{data: A2A6_q_sys, backgroundColor:"#49494b", label: '시스템평가담당'},
				{data: A2A6_q_dev, backgroundColor:"#8e8e90", label: '디바이스평가담당'},																
				{data: A2A6_q_cert, backgroundColor: "#bd8c7d", label: '인증평가담당'},																
				{data: A2A6_q_meca, backgroundColor:"#d1bfa7", label: '메카프로설계'},																
				{data: A2A6_q_qa, backgroundColor: "#d1ccc1", label: 'QA'}],
			labels:A2A6_graphlabel
			}
		window.myPie.data=newData;
		window.myPie.update();
});

document.getElementById('dataChange_EXECSTMT').addEventListener('click', function() {
	var newData ={
			datasets: [
				{data: EXECSTMT_q_sys, backgroundColor:"#49494b", label: '시스템평가담당'},
				{data: EXECSTMT_q_dev, backgroundColor:"#8e8e90", label: '디바이스평가담당'},																
				{data: EXECSTMT_q_cert, backgroundColor: "#bd8c7d", label: '인증평가담당'},																
				{data: EXECSTMT_q_meca, backgroundColor:"#d1bfa7", label: '메카프로설계'},																
				{data: EXECSTMT_q_qa, backgroundColor: "#d1ccc1", label: 'QA'}],
			labels:EXECSTMT_graphlabel
			}
		window.myPie.data=newData;
		window.myPie.update();
});

document.getElementById('dataChange_16K8K').addEventListener('click', function() {
	var newData ={
			datasets: [
				{data: K16K8_q_sys, backgroundColor:"#49494b", label: '시스템평가담당'},
				{data: K16K8_q_dev, backgroundColor:"#8e8e90", label: '디바이스평가담당'},																
				{data: K16K8_q_cert, backgroundColor: "#bd8c7d", label: '인증평가담당'},																
				{data: K16K8_q_meca, backgroundColor:"#d1bfa7", label: '메카프로설계'},																
				{data: K16K8_q_qa, backgroundColor: "#d1ccc1", label: 'QA'}],
			labels:K16K8_graphlabel
			}
		window.myPie.data=newData;
		window.myPie.update();
});

document.getElementById('dataChange_ENV').addEventListener('click', function() {
	var newData ={
			datasets: [
				{data: ENV_q_sys, backgroundColor:"#49494b", label: '시스템평가담당'},
				{data: ENV_q_dev, backgroundColor:"#8e8e90", label: '디바이스평가담당'},																
				{data: ENV_q_cert, backgroundColor: "#bd8c7d", label: '인증평가담당'},																
				{data: ENV_q_meca, backgroundColor:"#d1bfa7", label: '메카프로설계'},																
				{data: ENV_q_qa, backgroundColor: "#d1ccc1", label: 'QA'}],
			labels:ENV_graphlabel
			}
		window.myPie.data=newData;
		window.myPie.update();
});



document.getElementById('checkBtn').addEventListener('click', function() {
	var newData ={
			datasets: [
				{data: ENV_q_sys, backgroundColor:"#49494b", label: '시스템평가담당'},
				{data: ENV_q_dev, backgroundColor:"#8e8e90", label: '디바이스평가담당'},																
				{data: ENV_q_cert, backgroundColor: "#bd8c7d", label: '인증평가담당'},																
				{data: ENV_q_meca, backgroundColor:"#d1bfa7", label: '메카프로설계'},																
				{data: ENV_q_qa, backgroundColor: "#d1ccc1", label: 'QA'}],
			labels:ENV_graphlabel
			}
		window.myPie.data=newData;
		window.myPie.update();
});

function btncheck(btnname){
	selectedPaper = btnname;
	alert(selectedPaper);
	
	var no2 = new Array();
	var size2 = new Array();
	var kind2 = new Array();
	var gram2 = new Array();
	var q_sys2 = new Array();
	var q_dev2 = new Array();
	var q_cert2 = new Array();
	var q_meca2 = new Array();
	var q_qa2 = new Array();
	var graphlabel2 = new Array();
	</script>
	<%
	for(int i2=0; i2<q_sys.length(); i2++){
		if(q_sys[i2]=="A4")
		{%>
		<script>
			no2.push("<%= list.get(i2).getPaper_list_no()%>");
			size2.push("<%= list.get(i2).getPaper_list_no()%>");
			kind2.push("<%= list.get(i2).getPaper_list_no()%>");
			gram2.push("<%= list.get(i2).getPaper_list_no()%>");
			q_sys2.push("<%= list.get(i2).getPaper_list_no()%>");
			q_dev2.push("<%= list.get(i2).getPaper_list_no()%>");
			q_cert2.push("<%= list.get(i2).getPaper_list_no()%>");
			q_qa2.push("<%= list.get(i2).getPaper_list_no()%>");
			graphlabe2.push("<%=list.get(i2).getPaper_list_size()%>_<%=list.get(i2).getPaper_list_kind()%>_<%=list.get(i2).getPaper_list_gram()%>g");
		</script>
<%
		}
	
	}
	%>
	<script>
	var newData ={
			datasets: [
				{data: q_sys2, backgroundColor:"#49494b", label: '시스템평가담당'},
				{data: q_dev2, backgroundColor:"#8e8e90", label: '디바이스평가담당'},																
				{data: q_cert2, backgroundColor: "#bd8c7d", label: '인증평가담당'},																
				{data: q_meca2, backgroundColor:"#d1bfa7", label: '메카프로설계'},																
				{data: q_qa2, backgroundColor: "#d1ccc1", label: 'QA'}],
			labels:graphlabe2
			}
		window.myPie.data=newData;
		window.myPie.update();

labels:graphlabel
	
	
	
	
	
}

var colorNames = Object.keys(window.chartColors);	
</script>


</html>