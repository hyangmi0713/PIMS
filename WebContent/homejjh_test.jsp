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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>


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
						<%
							String[] btnname = new String [10];
							Pm_inventoryDAO pm_inventoryDAO = new Pm_inventoryDAO();
               						ArrayList<Pm_inventory> list = pm_inventoryDAO.getPm_inventory();

							btnname [i] = 	list.get(i).getPaper_inv_size();

							/* 자주사용한 용지를 순서대로 가져와서 버튼 생성 */
							String[] btnname = {"A2","A3","A4","B4","B5","LTR","LDR","EXEC","STMT","A6"};
							int btnsize = btnname.length;
							String selectedPaper;
							
							for(int i=0; i<btnsize;i++){
						%>
							<button class="btn btn-inverse" id="btncheck<%= btnname[i] %>" name="btncheck<%= btnname[i] %>" onclick="btncheck('<%= btnname[i] %>');"><%= btnname[i] %></button>
						
						<%}%>
					</div>
					
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

</script>

<%
	PaperStockDAO paperstockDAO = new PaperStockDAO();
	ArrayList<PaperStock> list = paperstockDAO.getPaperStock();

	/* 프로젝트별 수량을 담당으로 묶기위해 dao접근 */
	PaperStockDAO paperListDAO = new PaperStockDAO();
	ArrayList<Object> temp = paperListDAO.paperSizeList2();

	/* System.out.println("0번값:"+temp.get(0).toString());
	System.out.println("0번값:"+temp.get(1).toString()); */

	for(int i33=0; i33<temp.size(); i33++) {
	   System.out.println(temp.get(i33).toString());
	}
	   
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
			label: '기타'
		}],
		
		labels:graphlabel
	},
	options: {
		responsive: false,
		maintainAspectRatio:true,
		scales:{
			xAxes:[{stacked:true}],
			yAxes:[{stacked:true}]
		}
	}
};
												
window.onload = function() {
	var ctx = document.getElementById('chart-area').getContext('2d');
	window.myPie = new Chart(ctx, config);
};

function btncheck(btnname){
 	selectedPaper = btnname;
	<%-- alert(selectedPaper);
	var listObject = "<%=list.get(6).getPaper_list_size()%>";
	alert(listObject); --%>
	
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
	
	var sizejtos, kindjtos, gramjtos, q_sysjtos, q_devjtos, q_certjtos, q_mecajtos, q_qajtos, graphlabeljtos;
	$.ajax({
		url: 'http://localhost:8080/PIMS/home_data.jsp',
		//url: 'http://10.1.2.180:8080/PIMS/homejjh2.jsp',
		type : 'POST',
		data:{'size':selectedPaper},
		dataType: 'text',
		success : function(data){
			var obj = JSON.parse(data.replace('<meta http-equiv="X-UA-Compatible" content="IE=11">', ''))
			// 윗부분 야매로 지운거라 정확하게 지우는 법 찾기
			sizejtos = obj.sizejtos;
			kindjtos = obj.kindjtos;
			gramjtos = obj.gramjtos;
			q_sysjtos = obj.q_sysjtos;
			q_devjtos = obj.q_devjtos;
			q_certjtos = obj.q_certjtos;
			q_mecajtos = obj.q_mecajtos;
			q_qajtos = obj.q_qajtos;
			graphlabeljtos = obj.graphlabeljtos;
			
			/* JSP배열을 스크립트 배열로 받아옴 */
/* 			size2=[sizejtos];
			kind2=[kindjtos];
			gram2=[gramjtos];
			q_sys2=[q_sysjtos];
			q_dev2=[q_devjtos];
			q_cert2=[q_certjtos];
			q_meca2=[q_mecajtos];
			q_qa2=[q_qajtos];
			graphlabel2=[graphlabeljtos]; */
			
			/* JSON에서 String으로 받아와서 분리시켜 뿌려줌 */
			var size3 = sizejtos;
			var size4 = size3.split(",");
			var kind3 = kindjtos;
			var kind4 = kind3.split(",");
			var gram3 = gramjtos;
			var gram4 = gram3.split(",");
			var q_sys3 = q_sysjtos;
			var q_sys4 = q_sys3.split(",");
			var q_dev3 = q_devjtos;
			var q_dev4 = q_dev3.split(",");
			var q_cert3 = q_certjtos;
			var q_cert4 = q_cert3.split(",");
			var q_meca3 = q_mecajtos;
			var q_meca4 = q_meca3.split(",");
			var q_qa3 = q_qajtos;
			var q_qa4 = q_qa3.split(",");
			var graphlabel3 = graphlabeljtos;
			var graphlabel4 = graphlabel3.split("\",\"");
		  
			/* 버튼 누를때 그래프 데이터 갱신 */
			var newData ={
					datasets: [		
						{data: q_sys4, backgroundColor:"#49494b", label: '시스템평가담당'},
						{data: q_dev4, backgroundColor:"#8e8e90", label: '디바이스평가담당'},																
						{data: q_cert4, backgroundColor: "#bd8c7d", label: '인증평가담당'},																
						{data: q_meca4, backgroundColor:"#d1bfa7", label: '메카프로설계'},														
						{data: q_qa4, backgroundColor: "#d1ccc1", label: '기타'}],
						labels:graphlabel4
			}
				window.myPie.data=newData;
				window.myPie.update();
		}
	})
}

var colorNames = Object.keys(window.chartColors);	
</script>
</html>