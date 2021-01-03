<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<meta http-equiv="X-UA-Compatible" content="IE=11">
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.*, java.text.*"  %>
<%@ page import="user.User" %>
<%@ page import="user.UserDAO" %>
<%@ page import="paper.PaperStock" %>
<%@ page import="paper.PaperStockDAO" %>
<%@ page import="part.Part" %>
<%@ page import="part.PartDAO" %>
<%@ page import="project.ProjectDAO" %>
<%@ page import="project.Project" %>
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
	
	UserDAO userListDAO = new UserDAO();
	String getUserPart = userListDAO.finduserpart(menId);
	String getUserName = userListDAO.findusername(menId);
	
	PaperStockDAO paperSizeDAO = new PaperStockDAO();
	ArrayList<PaperStock> getPaperSize = paperSizeDAO.getPaperSize();
	
	PartDAO partDAO = new PartDAO();
	ArrayList<Part> getPartList = partDAO.allPartList();
	int getUserPartNo = partDAO.selPartNo(getUserPart);
	
	StringBuilder paperAllSize = new StringBuilder();
	StringBuilder paperAllType = new StringBuilder();
	StringBuilder paperAllGram = new StringBuilder();
	
	for (int i=0; i<getPaperSize.size(); i++) {
		paperAllSize.append(getPaperSize.get(i).getPaper_list_size()+",");
		ArrayList<PaperStock> getPaperType = paperSizeDAO.getPaperType(getPaperSize.get(i).getPaper_list_size());
		
		paperAllType.append(getPaperSize.get(i).getPaper_list_size()+",");
		paperAllGram.append(getPaperSize.get(i).getPaper_list_size()+",");
		
		for (int j=0; j<getPaperType.size(); j++) {			
			paperAllType.append(getPaperType.get(j).getPaper_list_kind()+",");
			
			ArrayList<PaperStock> getPaperGram = paperSizeDAO.getPaperGram(getPaperSize.get(i).getPaper_list_size(), getPaperType.get(j).getPaper_list_kind());

			paperAllGram.append(getPaperType.get(j).getPaper_list_kind()+",");
						
			for (int k=0; k<getPaperGram.size(); k++) {
				paperAllGram.append(getPaperGram.get(k).getPaper_list_gram()+",");
			}
		}
	}
	
	ProjectDAO projectDAO = new ProjectDAO();
	ArrayList<Project> getMyProjectDAO = projectDAO.myProjectList(getUserPart);
	ArrayList<Project> getAllProjectDAO = projectDAO.allPartProjectList1();
	
	StringBuilder allProject = new StringBuilder();
	
	for (int i=0; i<getAllProjectDAO.size(); i++) {
		allProject.append(getAllProjectDAO.get(i).getProjectPartName()+","+getAllProjectDAO.get(i).getProjectNo()+","+getAllProjectDAO.get(i).getProjectName()+",");
	}
%>

<!doctype html>
<html>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width" , intial-scale="1">
	<title>Canon 용지 재고 관리 프로그램 - 입고화면</title>
	<link rel="stylesheet" href="css/bootstrap.css">
	<link rel="stylesheet" href="css/PIMS.css">
	<style>
		body {
			  background-image: url("imageNew/home_02.png");
			  background-repeat:repeat-x;
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
		div.button
		{
		   margin: auto;
		   width: 50%;
		}
		div.button input
		{
		   padding: 0px;
		   width: 100%;
		}
	</style>
	<style>
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
			width: 700px; /* Could be more or less, depending on screen size */
		}
		.card-signin {
		  position: relative;
		  top: 12rem;
		  border: 0;
		  border-radius: 1rem;
		  box-shadow: 0 0.1rem 1rem 0 rgba(0, 0, 0, 0.1);
		  opacity: 1; 
		  z-index: 4;
		}
		
		.card-signin-pw {
		  position: relative;
		  top: 1rem;
		  border: 0;
		  border-radius: 1rem;
		  box-shadow: 0 0.1rem 1rem 0 rgba(0, 0, 0, 0.1);
		  opacity: 1; 
		  z-index: 4;
		}
		
		.card-signin .card-title {
		  margin-bottom: 2rem;
		  font-weight: 300;
		  font-size: 2rem;
		  z-index: auto;
		}
		
		.card-signin .card-body {
		  padding: 10rem;
		  background-color: rgb(255, 255, 255);
		}
	</style>
</head>

<body>
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
				<div class="container" style="padding-top:30px; ">
					<table width="98%" class="type10" style="font-size:10pt;">
						<thead>
							<tr>
								<th width="150" style="text-align:center;">사이즈</th>
								<th width="150" style="text-align:center;">용지 종류</th>
								<th width="150" style="text-align:center;">평량(m/g)</th>
								<th width="150" style="text-align:center;">용지이름</th>
								<th width="150" style="text-align:center;">입고수량(Pack)</th>
								<th width="150" style="text-align:center;">입고부서</th>
								<th width="150" style="text-align:center;">프로젝트</th>
								<th style="text-align:center;">비고</th>
								<th width="120" style="text-align:center;">추가</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>
									<select name="size" id="size" class="form-control" onchange="sizeChangeServlet(this)">
										<option value="none"></option>
										<%
											for(int i=0; i<getPaperSize.size(); i++) {
										%>
											
											<option value="<%=getPaperSize.get(i).getPaper_list_size() %>"><%=getPaperSize.get(i).getPaper_list_size() %></option>
										<%
										}
										%>
									</select>
								</td>
								<td>
									<select name="kind" id="kind" class="form-control" onchange="typeChangeServlet(this)">
										<option value="none"></option>
									</select>
								</td>
								<td>
									<select name="gram" id="gram" class="form-control" onchange="gramChangeServlet(this)">
										<option value="none"></option>
									</select>
								</td>
								<td>
									<select name="paperName" id="paperName" class="form-control">
										<option value="none"></option>
									</select>
								</td>
								<td><input type="text" id="count" name="count" class="form-control" onkeypress="return checkNum(event, 'numbers');" onkeydown="checkNum2(this);"></td>
								<td>
									<select name="part" id="part" class="form-control" onchange="partChange(this)" >
										<option value="<%=getUserPartNo %>,<%=getUserPart %>" class="active"><%=getUserPart %></option>
										<%
										for(int i=0; i<getPartList.size(); i++) {
											if(!getPartList.get(i).getPartName().equals(getUserPart)) {
										%>
											
												<option value="<%=getPartList.get(i).getPartNo() %>,<%=getPartList.get(i).getPartName() %>"><%=getPartList.get(i).getPartName() %></option>
										<%
											}
										}
										%>
									</select>
								</td>
								<td>
									<select name="projectSel" id="projectSel" class="form-control" >
										<option></option>
										<%
										for(int i=0; i<getMyProjectDAO.size(); i++) {
										%>
											<option value="<%=getMyProjectDAO.get(i).getProjectNo() %>,<%=getMyProjectDAO.get(i).getProjectName() %>"><%=getMyProjectDAO.get(i).getProjectName() %></option>
										<%
										}
										%>
									</select>
								</td>
								<td><input type="text" id="note" class="form-control"></td>
								<td><input type="button" onclick="tableCreate()" class="btn pull-center" value="추가" style="width: 100px;"></td>
							</tr>
						</tbody>
					</table>
					<img src="images/downArrow.png" style="margin-left: auto; margin-right: auto; display: block;" >
					<table width="98%" class="type10" id="dynamicTable" style="font-size:10pt;">
						<thead>
							<tr>
								<th style="text-align:center;">사이즈</th>
								<th style="text-align:center;">용지종류</th>
								<th style="text-align:center;">평량(g/m)</th>
								<th style="text-align:center;">용지이름</th>
								<th style="text-align:center;">입고수량(Pack)</th>
								<th style="text-align:center;">입고부서</th>
								<th style="text-align:center;">프로젝트</th>
								<th style="text-align:center;">비고</th>
							</tr>
						</thead>
						<tbody id="dynamicTbody">
						</tbody>
					</table>
					<input type="button" class="btn btn=primary pull-right" value="다음" onclick="inputCreate('<%=getUserPart %>', '<%=getUserName %>')" style="width: 100px;">
				</div>
				<br><br>
			</td>
			<td width="45" style="background-image: url('imageNew/home_25.png'); background-repeat:repeat-y; " valign="top">
				<img src="imageNew/home_24.png" >
			</td>
		</tr>
	</table>
	<footer style="background-color: #e5dfd5; color: #d69994" height="50px;">
		<jsp:include page="footer.jsp" flush="false" />	
	</footer>
	<script 
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<script src="../js/bootstrap.min.js"></script>
</body>
</html>

<script type="text/javascript">
	var selSizeServlet = null;
	var selTypeServlet = null;
	var selGramServlet = null;
	var request = new XMLHttpRequest();
	
	function sizeChangeServlet(e) {
		selSizeServlet = e.value;
		
		request.open("Post", "/PIMS/PaperInfoServlet?size="+encodeURIComponent(selSizeServlet), true);
		request.onreadystatechange = sizeChangeServletProcess;
		request.send(null);
	}
	
	function typeChangeServlet(e) {
		selTypeServlet = e.value;
		
		request.open("Post", "/PIMS/PaperInfoServletType?size="+encodeURIComponent(selSizeServlet)+"&type="+encodeURIComponent(selTypeServlet), true);
		request.onreadystatechange = typeChangeServletProcess;
		request.send(null);
	}
	
	function gramChangeServlet(e) {
		selGramServlet = e.value;
		
		request.open("Post", "/PIMS/PaperInfoServletGram?size="+encodeURIComponent(selSizeServlet)+"&type="+encodeURIComponent(selTypeServlet)+"&gram="+encodeURIComponent(selGramServlet), true);
		request.onreadystatechange = gramChangeServletProcess;
		request.send(null);
	}
	
	function sizeChangeServletProcess() {
		var targetType = document.getElementById("kind");
		
		if(request.readyState == 4 && request.status == 200) { 
			var object = request.responseText;
			
			var paperTypeAllSplit = new Array();
			paperTypeAllSplit = object.split(',');
			
			targetType.options.length=0;
						
			for (var z=0; z<paperTypeAllSplit.length; z++) {
				var opt = document.createElement("option");
				
				if (z==0) {
					opt.value = "";
					opt.innerHTML = "";
					targetType.appendChild(opt);
				} 
				else {
					opt.value = paperTypeAllSplit[z-1];
					opt.innerHTML = paperTypeAllSplit[z-1];
					targetType.appendChild(opt);
				}
			}
		}
	}
	
	function typeChangeServletProcess() {
		var targetGram = document.getElementById("gram");
	
		if(request.readyState == 4 && request.status == 200) { 
			var object = request.responseText;
			
			var paperGramAllSplit = new Array();
			paperGramAllSplit = object.split(',');
			
			targetGram.options.length=0;
						
			for (var z=0; z<paperGramAllSplit.length; z++) {
				var opt = document.createElement("option");
				
				if (z==0) {
					opt.value = "";
					opt.innerHTML = "";
					targetGram.appendChild(opt);
				} 
				else {
					opt.value = paperGramAllSplit[z-1];
					opt.innerHTML = paperGramAllSplit[z-1];
					targetGram.appendChild(opt);
				}
			}
		}
	}
	
	function gramChangeServletProcess() {
		var targetName = document.getElementById("paperName");
	
		if(request.readyState == 4 && request.status == 200) { 
			var object = request.responseText;
			
			var paperNameAllSplit = new Array();
			paperNameAllSplit = object.split(',');
			
			targetName.options.length=0;
						
			for (var z=0; z<paperNameAllSplit.length; z++) {
				var opt = document.createElement("option");
				
				if (z==0) {
					opt.value = "";
					opt.innerHTML = "";
					targetName.appendChild(opt);
				} 
				else {
					opt.value = paperNameAllSplit[z-1];
					opt.innerHTML = paperNameAllSplit[z-1];
					targetName.appendChild(opt);
				}
			}
		}
	}
</script>
<script>
	var expaper = new Array();
	var i=0;
	var length = 0;
	var html = '';

	function tableCreate() {
		if (document.getElementById("size").value == "") {
			alert("사이즈를 입력해주세요 !");
		} 
		/* else if (document.getElementById("kind").value == "") {
			alert("용지 종류를 입력해주세요 !");
		} else if (document.getElementById("gram").value == "") {
			alert("평량을 입력해주세요 !");
		} else if (document.getElementById("paperName").value == "") {
			alert("용지 이름을 입력해주세요 !");
		} else if (document.getElementById("count").value == "") {
			alert("신청 수량을 입력해주세요 !");
		} */ 
		else if (document.getElementById("size" && "kind" && "gram" && "paperName" && "count" && "part" && "projectSel").value != "") {

			var size = document.getElementById("size").value;
			var kind = document.getElementById("kind").value;
			var gram = document.getElementById("gram").value;
			var name = document.getElementById("paperName").value;
			var count = document.getElementById("count").value;
			var project = document.getElementById("projectSel").value;
			var note = document.getElementById("note").value;
			var part = document.getElementById("part").value;
			
			var partSplit = part.split(",");
			
			var partNo = partSplit[0];
			var partName = partSplit[1];
			
			var projectSplit = project.split(",");
			
			var projectNo = projectSplit[0];
			var projectName = projectSplit[1];
						
			html += '<tr>';
			html += '<td style="text-align:center;">' + size + '</td>';
			html += '<td style="text-align:center;">' + kind + '</td>';
			html += '<td style="text-align:center;">' + gram + '</td>';
			html += '<td style="text-align:center;">' + name + '</td>';
			html += '<td style="text-align:center;">' + count + '</td>';
			html += '<td style="text-align:center;">' + partName + '</td>';
			html += '<td style="text-align:center;">' + projectName + '</td>';
			html += '<td style="text-align:center;">' + note + '</td>';
			html += '</tr>';
			
			var temp= document.getElementById("dynamicTbody");
			temp.innerHTML = html;
			
			document.getElementById("size").value = "";
			document.getElementById("kind").value = "";
			document.getElementById("gram").value = "";
			document.getElementById("count").value = "";
			document.getElementById("paperName").value = "";
			document.getElementById("projectSel").value = "";
			document.getElementById("note").value = "";
			document.getElementById("part").value = "";

			var expaper_sub = new Array();
			
			expaper_sub[0] = size;
			expaper_sub[1] = kind;
			expaper_sub[2] = gram;
			expaper_sub[3] = name;
			
			expaper_sub[4] = count;
			
			expaper_sub[5] = partNo;
			expaper_sub[6] = partName;
			expaper_sub[7] = projectNo;
			expaper_sub[8] = projectName;
			expaper_sub[9] = note;
			
			expaper[i] = expaper_sub;
			i++;
		}
	}
	
	function inputCreate(part, name) {
		var inputCreateForm = document.createElement("form");
		
		inputCreateForm.name = "inputCreateForm";
		inputCreateForm.method = "post";
		inputCreateForm.action = "incomeAction.jsp";
		
		var el;
		for(var i=0; i<expaper.length; i++) {
			for(var j=0; j<10; j++) {
				el = document.createElement("input");
				el.setAttribute("type", "hidden");
				el.setAttribute("name", "expaperInput"+length);
				el.setAttribute("value", expaper[i][j]);	
				length++;
				
				inputCreateForm.appendChild(el);
			}
		}
		
		el = document.createElement("input");
		el.setAttribute("type", "hidden");
		el.setAttribute("name", "length");
		el.setAttribute("value", length);
		inputCreateForm.appendChild(el);
		
		el = document.createElement("input");
		el.setAttribute("type", "hidden");
		el.setAttribute("name", "department");
		el.setAttribute("value", part);
		inputCreateForm.appendChild(el);
		
		el = document.createElement("input");
		el.setAttribute("type", "hidden");
		el.setAttribute("name", "username");
		el.setAttribute("value", name);
		inputCreateForm.appendChild(el);
		
		document.body.appendChild(inputCreateForm);
		
		inputCreateForm.submit();
	}
</script>
<script type="text/javascript">
	function checkNum(event, type) {
		if(type=="numbers") {
			if (event.keyCode<48 || event.keyCode>57) {
				return false;
			}		
		}
	}
	
	function checkNum2(obj) {
		if (event.keyCode==8 || event.keyCode==9 || event.keyCode==37 || event.keyCode==39 || event.keyCode==46) {
			return;
		}
		obj.value=obj.value.replace(/[^a-z0-9]/gi,'');
		
	}
</script> 
<script type="text/javascript">
	var selSize = null;
	var selSizeNext = null;
	var selType = null;
	var selGram = null;
	
	function sizeChange(e) {
		selSize = e.value;
		
		var kindOption = [];
		var target = document.getElementById("kind");
		
		var paperSizeAll = "<%=paperAllSize.toString() %>";
		var paperTypeAll = "<%=paperAllType.toString() %>";
		
		var paperSizeAllSplit = new Array();
		var paperTypeAllSplit = new Array();
		
		paperSizeAllSplit = paperSizeAll.split(',');
		paperTypeAllSplit = paperTypeAll.split(',');
				
		var countSTART = 0;
		var countEND = 0;
		
		for (var i=0; i<paperSizeAllSplit.length; i++) {
			if(e.value==paperSizeAllSplit[i]) {
				for (var j=0; j<paperTypeAllSplit.length; j++) {
					if(paperSizeAllSplit[i]==paperTypeAllSplit[j]) {
						for (var k=0; k<paperTypeAllSplit.length; k++) {
							if(paperSizeAllSplit[i+1]==paperTypeAllSplit[k]) {
								countSTART = j;
								countEND = k;
							}
						}
					}
				}
			}	
		}
		
		var y=1;
		
		for (var x=countSTART+1; x<countEND; x++) {	
			kindOption[y] = paperTypeAllSplit[x];
			y++;
		}
		
		target.options.length=0;
		document.getElementById("gram").options.length=0;
		
		for (var z=0; z<kindOption.length; z++) {
			var opt = document.createElement("option");
			
			if (z==0) {
				opt.value = "";
				opt.innerHTML = "";
				target.appendChild(opt);
			} 
			else {
				alert(kindOption[z]);
				opt.value = kindOption[z];
				opt.innerHTML = kindOption[z];
				target.appendChild(opt);
			}
		}
	}
	
	function kindChange(e) {
		selType = e.value;
		
		var gramOption = [];
		var target = document.getElementById("gram");

		var paperTypeAll = "<%=paperAllType.toString() %>";
		var paperGramAll = "<%=paperAllGram.toString() %>";
		
		var paperTypeAllSplit = new Array();
		var paperGramAllSplit = new Array();
		
		paperTypeAllSplit = paperTypeAll.split(',');
		paperGramAllSplit = paperGramAll.split(',');
				
		var countSTART = 0;
		var countEND = 0;
		
		for (var i=0; i<paperTypeAllSplit.length; i++) {
			if(selSize==paperTypeAllSplit[i]) {
				if(e.value==paperTypeAllSplit[i]) {
					for (var j=0; j<paperGramAllSplit.length; j++) {
						if(paperTypeAllSplit[i]==paperGramAllSplit[j]) {
							for (var k=0; k<paperGramAllSplit.length; k++) {
								if(paperTypeAllSplit[i+1]==paperGramAllSplit[k]) {
									countSTART = j;
									countEND = k;								
								}
							}
						}
					}
				}
			}
		}
		
		var y=1;
		
		for (var x=countSTART+1; x<countEND; x++) {	
			gramOption[y] = paperGramAllSplit[x];
			y++;
		}
		
		target.options.length=0;
		
		for (var z=0; z<gramOption.length; z++) {
			var opt = document.createElement("option");
			
			if (z==0) {
				opt.value = "";
				opt.innerHTML = "";
				target.appendChild(opt);
			} 
			else {
				opt.value = gramOption[z];
				opt.innerHTML = gramOption[z];
				target.appendChild(opt);
			}
		}
	}
	
	function partChange(e) {		
		var selPart = e.value;
		var selPartSplit = selPart.split(',');
		
		var projectOption = [];
		var target = document.getElementById("projectSel");

		var allProject = "<%=allProject.toString() %>";
		
		var allProjectSplit = new Array();
		
		allProjectSplit = allProject.split(',');
				
		var selPartProject = new Array();
		var j=0;
		
		for (var i=0; i<allProjectSplit.length; i++) {
			if(selPartSplit[1]==allProjectSplit[i]) {
				selPartProject[j] = allProjectSplit[i+1];
				j++;
				selPartProject[j] = allProjectSplit[i+2];
				j++;
			}	
		}
		
		target.options.length=0;
		
		for (var z=0; z<selPartProject.length; z+=2) {
			var opt = document.createElement("option");

			opt.value = selPartProject[z]+","+selPartProject[z+1];
			opt.innerHTML = selPartProject[z+1];
			target.appendChild(opt);
		}
	}
</script>

