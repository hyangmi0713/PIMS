<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<meta http-equiv="X-UA-Compatible" content="IE=11">
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.util.*, java.text.*"%>
<%@ page import="pm_inventory.Pm_inventoryDAO"%>
<%@ page import="pm_inventory.Pm_inventory"%>
<%@ page import="user.UserDAO"%>
<%@ page import="user.User"%>
<%@ page import="part.PartDAO"%>
<%@ page import="part.Part"%>
<%@ page import="paper.PaperStockDAO"%>
<%@ page import="paper.PaperStock"%>
<%@ page import="paperinfo.PaperinfoDAO"%>
<%@ page import="paperinfo.Paperinfo"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.io.File" %>
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
	UserDAO userListDAO = new UserDAO();
	ArrayList<User> getUserList = userListDAO.allUserList();
	
	int getUserGrage = userListDAO.findusergrade(menId);
	
	if(getUserGrage==-1 || getUserGrage==-2) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('에러가 발생하였습니다.\n관리자에게 문의하세요.')");
		script.println("history.back()");
		script.println("</script>");
	}
%>
<%
	PaperinfoDAO paperinfoDAO = new PaperinfoDAO();
	ArrayList<Paperinfo> getPaperinfo = paperinfoDAO.allPaperinfo();
%>
<%
	PartDAO partListDAO = new PartDAO();
	ArrayList<Part> getPartList = partListDAO.allPartList();
%>
<%
	PaperStockDAO paperListDAO = new PaperStockDAO();
	ArrayList<PaperStock> getPaperSizeListDAO = paperListDAO.paperSizeList();
	int getPaperCountDAO = paperListDAO.getPaperListColumns();
%>
<%
	int pageNumber = 0;
	Pm_inventoryDAO inventoryDAO = new Pm_inventoryDAO();
	ArrayList<Pm_inventory> getExpenditureDAO = inventoryDAO.allExpenditureList(1);
	ArrayList<Pm_inventory> getIncomeDAO = inventoryDAO.allExpenditureList(0);
	/* ArrayList<Pm_inventory> getRentDAO = inventoryDAO.rentExpenditureList(); */
	
	if (request.getParameter("pageNumber")!=null) {
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	}
%>
<%
	String directory = application.getRealPath("/paperImage/");
%>

<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width">
<title>Canon 용지 재고 관리 프로그램 - 관리자 모드</title>
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
	    width: 150px;
	    padding: 10px;
	    font-weight: bold;
	    vertical-align: top;
	    color: #fff;
	    background: #db8e8c;
	    margin: 20px 10px;
	}
	table.type10 tbody th {
	    width: 150px;
	    padding: 10px;
	}
	table.type10 td {
	    width: 350px;
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
	table.type01 {
	    border-collapse: collapse;
	    text-align: left;
	    line-height: 1.5;
	    margin : 10px 0px;
	}
	table.type01 th {
	    width: 150px;
	    padding: 10px;
	    font-weight: bold;
	    vertical-align: top;
	    border: 1px solid #ccc;
	}
	table.type01 td {
	    width: 350px;
	    padding: 10px;
	    vertical-align: top;
	    border: 1px solid #ccc;
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
	.filebox input[type="file"] { 
		position: absolute; 
		width: 1px; 
		height: 1px; 
		padding: 2; 
		margin: -1px; 
		overflow: hidden; 
		clip:rect(0,0,0,0); 
		border: 0; 
	}
	
	.filebox label { 
		display: inline-block; 
		padding: .5em .75em; 
		color: #868686; 
		line-height: normal; 
		vertical-align: middle; 
		background-color: #fdfdfd; 
		cursor: pointer; 
		border: 1px solid #ebebeb; 
		border-bottom-color: #e2e2e2; 
		border-radius: .25em; 
		font-size:13px;
		width: 100%;
		text-align: center;
	} /* named upload */ 
	
	.filebox .upload-name1 { 
		display: inline-block; 
		padding: .5em .75em; /* label의 패딩값과 일치 */ 
		font-size: inherit; 
		font-family: inherit; 
		line-height: normal; 
		vertical-align: middle; 
		background-color: #f5f5f5; 
		border: 1px solid #ebebeb; 
		border-bottom-color: #e2e2e2; 
		border-radius: .25em; 
		-webkit-appearance: none; /* 네이티브 외형 감추기 */ 
		-moz-appearance: none; 
		appearance: none; 
		font-size:12px;
		width:100%;
	}
	
	.filebox2 input[type="file"] { 
		position: absolute; 
		width: 1px; 
		height: 1px; 
		padding: 2; 
		margin: -1px; 
		overflow: hidden; 
		clip:rect(0,0,0,0); 
		border: 0; 
	}
	
	.filebox2 label { 
		display: inline-block; 
		padding: .5em .75em; 
		color: #868686; 
		line-height: normal; 
		vertical-align: middle; 
		background-color: #fdfdfd; 
		cursor: pointer; 
		border: 1px solid #ebebeb; 
		border-bottom-color: #e2e2e2; 
		border-radius: .25em; 
		font-size:13px;
		width: 100%;
		text-align: center;
	} /* named upload */ 
	.filebox2 .upload-name2 { 
		display: inline-block; 
		padding: .5em .75em; /* label의 패딩값과 일치 */ 
		font-size: inherit; 
		font-family: inherit; 
		line-height: normal; 
		vertical-align: middle; 
		background-color: #f5f5f5; 
		border: 1px solid #ebebeb; 
		border-bottom-color: #e2e2e2; 
		border-radius: .25em; 
		-webkit-appearance: none; /* 네이티브 외형 감추기 */ 
		-moz-appearance: none; 
		appearance: none; 
		font-size:12px;
		width:100%;
	}
</style>
</head>
<body>
	<nav class="navbar navbar-default" >
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
					<div class="row">
						<div class="col-md-12">
							<div class="tab-content">
								<!-- 회원 관리에 대한 표기 -->
								<div class="layout">
									<button type="button" class="btn btn-default pull-right" style="margin-right:4px; font-size:10pt;">용지창고 레이아웃</button>
								</div>
								<%
								if(getUserGrage==0) {
								%>
								<div class="paperAdd">
									<button type="button" class="btn btn-default pull-right" style="margin-right:4px; font-size:10pt;">용지추가</button>
								</div>
								<%
								}
								%>
								<br>
								<table class="type10" style="font-size:10pt;">
									<thead>
										<tr>
											<th scope="cols" style="text-align:center;" width="50">No.</th>
											<th scope="cols" style="text-align:center;">용지이름</th>
											<th scope="cols" style="text-align:center;">용지사이즈</th>
											<th scope="cols" style="text-align:center;">용지종류</th>
											<th scope="cols" style="text-align:center;">용지평량<br><span style="font-size:8pt">(g/m)</span></th>
											<th scope="cols" style="text-align:center;">위치</th>
											<th scope="cols" style="text-align:center;">부번</th>
											<th scope="cols" style="text-align:center;">단위<br><span style="font-size:8pt">(1팩)</span></th>
											<th scope="cols" style="text-align:center;">단위<br><span style="font-size:8pt">(1박스)</span></th>
											<th scope="cols" style="text-align:center;">단가</th>
											<th scope="cols" style="text-align:center;">최소발주단위</th>
											<th scope="cols" style="text-align:center;">배송기간</th>
											<th scope="cols" style="text-align:center;">VENDER</th>
											<th scope="cols" style="text-align:center;">비고</th>
											<th scope="cols" style="text-align:center;">용지사진</th>
											<%
											if(getUserGrage==0) {
											%>
											<th scope="cols" style="text-align:center;" width="80">편집</th>
											<th scope="cols" style="text-align:center;" width="80">삭제</th>
											<%
											}
											%>
										</tr>
									</thead>
									<tbody>
										<%
										/* int pageStartNumberMember = 0;
										int pageEndNumberMember = 0;
										
										if(pageNumber == 0) {
											pageStartNumberMember = 0;
											if (pageStartNumberMember+9 < getPaperinfo.size()) {
												pageEndNumberMember = pageStartNumberMember+10;
											}
											else {
												pageEndNumberMember = getPaperinfo.size();
											}
										}
										else {
											pageStartNumberMember = pageNumber*10;
											if (pageStartNumberMember+9 < getPaperinfo.size()) {
												pageEndNumberMember = pageStartNumberMember+10;
											}
											else {
												pageEndNumberMember = getPaperinfo.size();
											}
										} */
										
										for(int i=0; i<getPaperinfo.size(); i++) {
											if(i%2 != 0) {
										%>
											<tr class="first">
												<td style="padding-top:15px; text-align:center; "><%=i+1 %></td>
												<td style="padding-top:15px; text-align:center; "><%=getPaperinfo.get(i).getPinfo_name() %></td>
												<td style="padding-top:15px; text-align:center; "><%=getPaperinfo.get(i).getPinfo_size() %></td>
												<td style="padding-top:15px; text-align:center; "><%=getPaperinfo.get(i).getPinfo_kind() %></td>
												<td style="padding-top:15px; text-align:center; "><%=getPaperinfo.get(i).getPinfo_gram() %></td>
												<td style="padding-top:15px; text-align:center; "><%=getPaperinfo.get(i).getPinfo_location() %></td>
												<td style="padding-top:15px; text-align:center; "><%=getPaperinfo.get(i).getPinfo_bunum() %></td>
												<td style="padding-top:15px; text-align:center; "><%=getPaperinfo.get(i).getPinfo_pack() %>매</td>
												<td style="padding-top:15px; text-align:center; "><%=getPaperinfo.get(i).getPinfo_box() %>팩</td>
												<td style="padding-top:15px; text-align:center; "><%=getPaperinfo.get(i).getPinfo_cost() %></td>
												<td style="padding-top:15px; text-align:center; "><%=getPaperinfo.get(i).getPinfo_minimum() %></td>
												<td style="padding-top:15px; text-align:center; "><%=getPaperinfo.get(i).getPinfo_delivery() %></td>
												<td style="padding-top:15px; text-align:center; "><%=getPaperinfo.get(i).getPinfo_vender() %></td>
												<td style="padding-top:15px; text-align:center; "><%=getPaperinfo.get(i).getPinfo_note() %></td>
												<td style="padding-top:15px; text-align:center; ">
													<%
														String file = getPaperinfo.get(i).getPinfo_realfilename();
														
														if(file != null) {
										  					out.write("<a href=\""+request.getContextPath()+"/downloadAction?file="
															+java.net.URLEncoder.encode(file, "UTF-8")+"\">"+"<img src='images/imageIcon.png'>"+"</a></br>");	
														}
														else {
															out.write("-");
														}
								  					%>
												</td>
												<%
												if(getUserGrage==0) {
												%>
												<td style="text-align:center;">
													<div class="button"><button type="button" class="btn btn-default pull-right" id="paperEdit" name="paperEdit" 
														onclick="paperEditFun('<%=getPaperinfo.get(i).getPinfo_no() %>',
														'<%=getPaperinfo.get(i).getPinfo_name() %>',
														'<%=getPaperinfo.get(i).getPinfo_size() %>',
														'<%=getPaperinfo.get(i).getPinfo_kind() %>',
														'<%=getPaperinfo.get(i).getPinfo_gram() %>',
														'<%=getPaperinfo.get(i).getPinfo_realfilename() %>',
														'<%=getPaperinfo.get(i).getPinfo_filename() %>',
														'<%=getPaperinfo.get(i).getPinfo_location() %>',
														'<%=getPaperinfo.get(i).getPinfo_bunum() %>',
														'<%=getPaperinfo.get(i).getPinfo_pack() %>',
														'<%=getPaperinfo.get(i).getPinfo_box() %>',
														'<%=getPaperinfo.get(i).getPinfo_cost() %>',
														'<%=getPaperinfo.get(i).getPinfo_minimum() %>',
														'<%=getPaperinfo.get(i).getPinfo_delivery() %>',
														'<%=getPaperinfo.get(i).getPinfo_vender() %>',
														'<%=getPaperinfo.get(i).getPinfo_note() %>')">편집</button></div>
												</td>
												<td style="text-align:center;">
													<div class="paperDel">
														<button type="button" class="btn btn-default" style="margin-right:4px; font-size:10pt;"
														onclick="delPaperFun('<%=getPaperinfo.get(i).getPinfo_no() %>')">삭제</button>
													</div>
												</td>
												<%
												}
												%>
											</tr>
										<%
											}
											else {
										%>
											<tr class="first">
												<td class="even" style="padding-top:15px; text-align:center; "><%=i+1 %></td>
												<td class="even" style="padding-top:15px; text-align:center; "><%=getPaperinfo.get(i).getPinfo_name() %></td>
												<td class="even" style="padding-top:15px; text-align:center; "><%=getPaperinfo.get(i).getPinfo_size() %></td>
												<td class="even" style="padding-top:15px; text-align:center; "><%=getPaperinfo.get(i).getPinfo_kind() %></td>
												<td class="even" style="padding-top:15px; text-align:center; "><%=getPaperinfo.get(i).getPinfo_gram() %></td>
												<td class="even" style="padding-top:15px; text-align:center; "><%=getPaperinfo.get(i).getPinfo_location() %></td>
												<td class="even" style="padding-top:15px; text-align:center; "><%=getPaperinfo.get(i).getPinfo_bunum() %></td>
												<td class="even" style="padding-top:15px; text-align:center; "><%=getPaperinfo.get(i).getPinfo_pack() %>매</td>
												<td class="even" style="padding-top:15px; text-align:center; "><%=getPaperinfo.get(i).getPinfo_box() %>팩</td>
												<td class="even" style="padding-top:15px; text-align:center; "><%=getPaperinfo.get(i).getPinfo_cost() %></td>
												<td class="even" style="padding-top:15px; text-align:center; "><%=getPaperinfo.get(i).getPinfo_minimum() %></td>
												<td class="even" style="padding-top:15px; text-align:center; "><%=getPaperinfo.get(i).getPinfo_delivery() %></td>
												<td class="even" style="padding-top:15px; text-align:center; "><%=getPaperinfo.get(i).getPinfo_vender() %></td>
												<td class="even" style="padding-top:15px; text-align:center; "><%=getPaperinfo.get(i).getPinfo_note() %></td>
												<td class="even" style="padding-top:15px; text-align:center; ">
													<%
													String file = getPaperinfo.get(i).getPinfo_realfilename();
													
													if(file != null) {
									  					out.write("<a href=\""+request.getContextPath()+"/downloadAction?file="
														+java.net.URLEncoder.encode(file, "UTF-8")+"\">"+"<img src='images/imageIcon.png'>"+"</a></br>");	
													}
													else {
														out.write("-");
													}
								  					%>
												</td>
												<%
												if(getUserGrage==0) {
												%>
												<td class="even" style="text-align:center;">
													<div class="button"><button type="button" class="btn btn-default pull-right" id="paperEdit" name="paperEdit" 
														onclick="paperEditFun('<%=getPaperinfo.get(i).getPinfo_no() %>',
														'<%=getPaperinfo.get(i).getPinfo_name() %>',
														'<%=getPaperinfo.get(i).getPinfo_size() %>',
														'<%=getPaperinfo.get(i).getPinfo_kind() %>',
														'<%=getPaperinfo.get(i).getPinfo_gram() %>',
														'<%=getPaperinfo.get(i).getPinfo_realfilename() %>',
														'<%=getPaperinfo.get(i).getPinfo_filename() %>',
														'<%=getPaperinfo.get(i).getPinfo_location() %>',
														'<%=getPaperinfo.get(i).getPinfo_bunum() %>',
														'<%=getPaperinfo.get(i).getPinfo_pack() %>',
														'<%=getPaperinfo.get(i).getPinfo_box() %>',
														'<%=getPaperinfo.get(i).getPinfo_cost() %>',
														'<%=getPaperinfo.get(i).getPinfo_minimum() %>',
														'<%=getPaperinfo.get(i).getPinfo_delivery() %>',
														'<%=getPaperinfo.get(i).getPinfo_vender() %>',
														'<%=getPaperinfo.get(i).getPinfo_note() %>')">편집</button></div>												
												</td>
												<td class="even" style="text-align:center;">
													<div class="paperDel">
														<button type="button" class="btn btn-default" style="margin-right:4px; font-size:10pt;"
														onclick="delPaperFun('<%=getPaperinfo.get(i).getPinfo_no() %>')">삭제</button>
													</div>
												</td>
												<%
												}
												%>
											</tr>
										<%
											}
										}
										%>
										<%-- <tr>
											<td colspan="17">
												<table style="margin-left: auto; margin-right: auto;">
													<tr>
														<td style="text-align: right; padding-right:15px;">
															<a href="javascript:void(0);" onClick="movePage('0'); return false;"><img src="images/preIcon.png"></a>
														</td>
														<td style="text-align: center; font-size:10pt;">
														<%
														if (getPaperinfo.size()/10 < 10) {
															for (int j=0; j<(getPaperinfo.size()/10)+1; j++) {
																if (j==pageNumber) {
														%>
																	<b><%=j+1 %>&nbsp;</b>
														<%
																}
																else {
														%>
																	<a href="javascript:void(0);" onClick="movePage('<%=j %>'); return false;"><%=j+1 %></a>&nbsp;
														<%
																}
															}
														}
														else {
															int totalPageStartNum = 0;
															int totalPageEndNum = 0;
															
															if (pageNumber-3 <= 0) {
																totalPageStartNum = 0;
																totalPageEndNum = 10;
															}
															else {
																if (pageNumber+6 > (getPaperinfo.size()/10)) {
																	totalPageStartNum = pageNumber-(9-((getPaperinfo.size()/10)-pageNumber));
																	totalPageEndNum = (getPaperinfo.size()/10)+1;
																}
																else {
																	totalPageStartNum = pageNumber-4;
																	totalPageEndNum = pageNumber+6;	
																}														
															}
															
															for (int j=totalPageStartNum; j<totalPageEndNum; j++) {
																if (j==pageNumber) {
														%>
																	<b><%=j+1 %>&nbsp;</b>
														<%
																}
																else {
														%>
																		<a href="javascript:void(0);" onClick="movePage('<%=j %>'); return false;"><%=j+1 %></a>&nbsp;
														<%
																}
															}
														}
														%>
														</td>
														<td style="text-align: left;">
															<a href="javascript:void(0);" onClick="movePage('<%=(getPaperinfo.size()/10) %>'); return false;"><img src="images/nextIcon.png"></a>
														</td>
													</tr>
													<%pageNumber = 0; %>
												</table>
											</td>
										</tr> --%>
									</tbody>
								</table>
								<form name="paging">
									<input type="hidden" name="pageNumber"/>
								</form>
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
	<footer style="background-color: #e5dfd5; color: #d69994" height="50px;">
		<jsp:include page="footer.jsp" flush="false" />	
	</footer>
	
<div id="modal" class="searchModal">
	<div class="search-modal-content">
		<div class="card card-signin-pw ">
			<div class="alert-text">
				<div class="card">
					<div class="card-body">
						<br><span style="padding-left:10px; "><img src="images/title_07.png" ></span>
						<form name="ActionAddPaperList" action="ActionAddPaperList.jsp" method="POST" enctype="multipart/form-data" >
							<table class="table">
								<tr>
									<td width="150px" style="padding-top:12px; font-size:10pt">용지이름</td>
									<td style="text-align:left">
										<input type="text" class="form-control" id="paperName" name="paperName" >
									</td>
								</tr>
								<tr>
									<td width="150px" style="padding-top:12px; font-size:10pt">사이즈</td>
									<td style="text-align:left">
										<input type="text" class="form-control" id="paperSize" name="paperSize" >
									</td>
								</tr>
								<tr>
									<td style="padding-top:12px; font-size:10pt">용지종류</td>
									<td style="padding-top:12px; text-align:left; font-size:10pt">
										<input type="text" class="form-control" id="paperKind" name="paperKind" >
									</td>
								</tr>
								<tr>
									<td style="padding-top:12px; font-size:10pt">평량(g/m)</td>
									<td>
										<input type="text" class="form-control" id="paperGram" name="paperGram" >
									</td>
								</tr>
								<tr>
									<td style="padding-top:12px; font-size:10pt">부번</td>
									<td>
										<input type="text" class="form-control" id="paperBuNo" name="paperBuNo" >									
									</td>
								</tr>
								<tr>
									<td style="padding-top:12px; font-size:10pt">단위</td>
									<td>
										<table>
											<tr>
												<td width="100" style="text-align:center;"><span style="font-size:10pt;">1팩당 매수</span></td>
												<td><input type="text" class="form-control" id="paperPack" name="paperPack" ></td>
												<td width="110" style="text-align:center;"><span style="font-size:10pt;">1박스당 팩수</span></td>
												<td><input type="text" class="form-control" id="paperBox" name="paperBox" ></td>
											</tr>
										</table>
									</td>
								</tr>
								<tr>
									<td style="padding-top:12px; font-size:10pt">단가</td>
									<td>
										<input type="text" class="form-control" id="paperCost" name="paperCost" >
									</td>
								</tr>
								<tr>
									<td style="padding-top:12px; font-size:10pt">최소발주단위</td>
									<td>
										<input type="text" class="form-control" id="paperMinimum" name="paperMinimum" >
									</td>
								</tr>
								<tr>
									<td style="padding-top:12px; font-size:10pt">배송기간</td>
									<td>
										<input type="text" class="form-control" id="paperDelivery" name="paperDelivery" >
									</td>
								</tr>
								<tr>
									<td style="padding-top:12px; font-size:10pt">VENDER</td>
									<td>
										<input type="text" class="form-control" id="paperVender" name="paperVender" >
									</td>
								</tr>
								<tr>
									<td style="padding-top:12px; font-size:10pt">비고</td>
									<td>
										<input type="text" class="form-control" id="paperNote" name="paperNote" >
									</td>
								</tr>
								<tr>
									<td style="padding-top:12px; font-size:10pt">용지사진</td>
									<td>
										<div class="filebox">
											<input class="upload-name1" value="" disabled="disabled" >
											<label for="paperPicture" >Upload</label>
											<input type="file" id="paperPicture" class="upload-hidden1" name="paperPicture" >
										</div>
									</td>
								</tr>
								<tr>
									<td style="padding-top:12px; font-size:10pt">용지위치</td>
									<td>
										<table>
											<tr>
												<td colspan="5" style="background-color:#ffe6e5; text-align:center; padding-top: 4px; padding-bottom: 4px;">
													<span style="font-size:10pt; font-weight:bold; color:#9b5351">1층</span>
												</td>
											</tr>
											<tr>
												<td width="20%" valign="top">
													<table class="type01" style="font-size:10pt;">
														<tr>
															<td style="text-align:center;"><input type="checkbox" name="position0" id="position0" style="width:15px; height:15px;" value="A01 " > A01</td>
														</tr>
														<tr>
															<td style="text-align:center;"><input type="checkbox" name="position1" id="position1" style="width:15px; height:15px;" value="A02 " > A02</td>
														</tr>
														<tr>
															<td style="text-align:center;"><input type="checkbox" name="position2" id="position2" style="width:15px; height:15px;" value="A03 " > A03</td>
														</tr>
													</table>
												</td>
												<td width="10%" style="text-align:center;"><span style="font-size:8pt;">복도</span></td>
												<td width="40%" valign="top">
													<table class="type01" style="font-size:10pt;">
														<tr>
															<td style="text-align:center;"><input type="checkbox" name="position3" id="position3" style="width:15px; height:15px;" value="A04 " > A04</td>
															<td style="text-align:center;"><input type="checkbox" name="position4" id="position4" style="width:15px; height:15px;" value="A05 " > A05</td>
														</tr>
														<tr>
															<td style="text-align:center;"><input type="checkbox" name="position5" id="position5" style="width:15px; height:15px;" value="A06 " > A06</td>
															<td style="text-align:center;"><input type="checkbox" name="position6" id="position6" style="width:15px; height:15px;" value="A07 " > A07</td>
														</tr>
													</table>
												</td>
												<td width="10%" style="text-align:center;"><span style="font-size:8pt;">복도</span></td>
												<td width="20%" valign="top">
													<table class="type01" style="font-size:10pt;">
														<tr>
															<td style="text-align:center;"><input type="checkbox" name="position7" id="position7" style="width:15px; height:15px;" value="A08 " > A08</td>
														</tr>
														<tr>
															<td style="text-align:center;"><input type="checkbox" name="position8" id="position8" style="width:15px; height:15px;" value="A09 " > A09</td>
														</tr>
														<tr>
															<td style="text-align:center;"><input type="checkbox" name="position9" id="position9" style="width:15px; height:15px;" value="A10 " > A10</td>
														</tr>
													</table>
												</td>
											</tr>
											<tr>
												<td colspan="5" style="background-color:#ffe6e5; text-align:center; padding-top: 4px; padding-bottom: 4px;">
													<span style="font-size:10pt; font-weight:bold; color:#9b5351">2층</span>
												</td>
											</tr>
											<tr>
												<td width="20%" valign="top">
													<table class="type01" style="font-size:10pt;">
														<tr>
															<td style="text-align:center;"><input type="checkbox" name="position10" id="position10" style="width:15px; height:15px;" value="B01 " > B01</td>
														</tr>
														<tr>
															<td style="text-align:center;"><input type="checkbox" name="position11" id="position11" style="width:15px; height:15px;" value="B02 " > B02</td>
														</tr>
														<tr>
															<td style="text-align:center;"><input type="checkbox" name="position12" id="position12" style="width:15px; height:15px;" value="B03 " > B03</td>
														</tr>
													</table>
												</td>
												<td width="10%" style="text-align:center;"><span style="font-size:8pt;">복도</span></td>
												<td width="40%" valign="top">
													<table class="type01" style="font-size:10pt;">
														<tr>
															<td style="text-align:center;"><input type="checkbox" name="position13" id="position13" style="width:15px; height:15px;" value="B04 " > B04</td>
															<td style="text-align:center;"><input type="checkbox" name="position14" id="position14" style="width:15px; height:15px;" value="B05 " > B05</td>
														</tr>
														<tr>
															<td style="text-align:center;"><input type="checkbox" name="position15" id="position15" style="width:15px; height:15px;" value="B06 " > B06</td>
															<td style="text-align:center;"><input type="checkbox" name="position16" id="position16" style="width:15px; height:15px;" value="B07 " > B07</td>
														</tr>
													</table>
												</td>
												<td width="10%" style="text-align:center;"><span style="font-size:8pt;">복도</span></td>
												<td width="20%" valign="top">
													<table class="type01" style="font-size:10pt;">
														<tr>
															<td style="text-align:center;"><input type="checkbox" name="position17" id="position17" style="width:15px; height:15px;" value="B08 " > B08</td>
														</tr>
														<tr>
															<td style="text-align:center;"><input type="checkbox" name="position18" id="position18" style="width:15px; height:15px;" value="B09 " > B09</td>
														</tr>
														<tr>
															<td style="text-align:center;"><input type="checkbox" name="position19" id="position19" style="width:15px; height:15px;" value="B10 " > B10</td>
														</tr>
													</table>
												</td>
											</tr>
										</table>
									</td>
								</tr>
								<tr><td></td><td></td></tr>
							</table>
							
							<table>
								<tr>
									<td width="510"></td>
									<td>
										<input type="submit" style="background-color:#db8e8c; color:#FFFFFF; font-size:10pt;"
										class="btn btn-lg btn-block text-uppercase"
										type="button" value="확인"><br>
									</td>
									<td width="5"></td>
									<td>
										<input type="button" style="background-color:#db8e8c; color:#FFFFFF; font-size:11pt;"
										class="btn btn-lg btn-block text-uppercase"
										type="button" value="취소" onClick="closeModal();" >	<br>								
									</td>
								</tr>
							</table>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<div id="modal1" class="searchModal">
	<div class="search-modal-content">
		<div class="card card-signin-pw ">
			<div class="alert-text">
				<div class="card">
					<div class="card-body">
						<br><span style="padding-left:10px; "><img src="images/title_08.png" ></span>
						<form name="ActionEditPaperList" action="ActionEditaperList.jsp" method="POST" enctype="multipart/form-data" >
							<input type="hidden" id="paperNoEdit" name="paperNoEdit" >
							<table class="table">
								<tr>
									<td width="150px" style="padding-top:12px; font-size:10pt">용지이름</td>
									<td style="text-align:left">
										<input type="text" class="form-control" id="paperNameEdit" name="paperNameEdit" >
									</td>
								</tr>
								<tr>
									<td width="150px" style="padding-top:12px; font-size:10pt">사이즈</td>
									<td style="text-align:left">
										<input type="text" class="form-control" id="paperSizeEdit" name="paperSizeEdit" >
									</td>
								</tr>
								<tr>
									<td style="padding-top:12px; font-size:10pt">용지종류</td>
									<td style="padding-top:12px; text-align:left; font-size:10pt">
										<input type="text" class="form-control" id="paperKindEdit" name="paperKindEdit" >
									</td>
								</tr>
								<tr>
									<td style="padding-top:12px; font-size:10pt">평량(g/m)</td>
									<td>
										<input type="text" class="form-control" id="paperGramEdit" name="paperGramEdit" >
									</td>
								</tr>
								<tr>
									<td style="padding-top:12px; font-size:10pt">부번</td>
									<td>
										<input type="text" class="form-control" id="paperBuNoEdit" name="paperBuNoEdit" >									
									</td>
								</tr>
								<tr>
									<td style="padding-top:12px; font-size:10pt">단위</td>
									<td>
										<table>
											<tr>
												<td width="100" style="text-align:center;"><span style="font-size:10pt;">1팩당 매수</span></td>
												<td><input type="text" class="form-control" id="paperPackEdit" name="paperPackEdit" ></td>
												<td width="110" style="text-align:center;"><span style="font-size:10pt;">1박스당 팩수</span></td>
												<td><input type="text" class="form-control" id="paperBoxEdit" name="paperBoxEdit" ></td>
											</tr>
										</table>
									</td>
								</tr>
								<tr>
									<td style="padding-top:12px; font-size:10pt">단가</td>
									<td>
										<input type="text" class="form-control" id="paperCostEdit" name="paperCostEdit" >
									</td>
								</tr>
								<tr>
									<td style="padding-top:12px; font-size:10pt">최소발주단위</td>
									<td>
										<input type="text" class="form-control" id="paperMinimumEdit" name="paperMinimumEdit" >
									</td>
								</tr>
								<tr>
									<td style="padding-top:12px; font-size:10pt">배송기간</td>
									<td>
										<input type="text" class="form-control" id="paperDeliveryEdit" name="paperDeliveryEdit" >
									</td>
								</tr>
								<tr>
									<td style="padding-top:12px; font-size:10pt">VENDER</td>
									<td>
										<input type="text" class="form-control" id="paperVenderEdit" name="paperVenderEdit" >
									</td>
								</tr>
								<tr>
									<td style="padding-top:12px; font-size:10pt">비고</td>
									<td>
										<input type="text" class="form-control" id="paperNoteEdit" name="paperNoteEdit" >
									</td>
								</tr>
								<tr>
									<td style="padding-top:12px; font-size:10pt">용지사진</td>
									<td>
										<!-- <div id="fileNameEdit"></div> -->
										<input type="hidden" value="0" id="fileChangeFlag" name="fileChangeFlag">
										<input type="hidden" id="realfilenameChangeFlag" name="realfilenameChangeFlag">
										<input type="hidden" id="fileNameChangeFlag" name="fileNameChangeFlag">
										<div class="filebox2">
											<input id="upload-name2" class="upload-name2" value="" disabled="disabled" >
											<label for="paperPicture1" >Upload</label>
											<input type="file" id="paperPicture1" class="upload-hidden2" name="paperPicture1" >
										</div>
									</td>
								</tr>
								<tr>
									<td style="padding-top:12px; font-size:10pt">용지위치</td>
									<td>
										<table>
											<tr>
												<td colspan="5" style="background-color:#ffe6e5; text-align:center; padding-top: 4px; padding-bottom: 4px;">
													<span style="font-size:10pt; font-weight:bold; color:#9b5351">1층</span>
												</td>
											</tr>
											<tr>
												<td width="20%" valign="top">
													<table class="type01" style="font-size:10pt;">
														<tr>
															<td style="text-align:center;"><input type="checkbox" name="position0Edit" id="position0Edit" style="width:15px; height:15px;" value="A01 " > A01</td>
														</tr>
														<tr>
															<td style="text-align:center;"><input type="checkbox" name="position1Edit" id="position1Edit" style="width:15px; height:15px;" value="A02 " > A02</td>
														</tr>
														<tr>
															<td style="text-align:center;"><input type="checkbox" name="position2Edit" id="position2Edit" style="width:15px; height:15px;" value="A03 " > A03</td>
														</tr>
													</table>
												</td>
												<td width="10%" style="text-align:center;"><span style="font-size:8pt;">복도</span></td>
												<td width="40%" valign="top">
													<table class="type01" style="font-size:10pt;">
														<tr>
															<td style="text-align:center;"><input type="checkbox" name="position3Edit" id="position3Edit" style="width:15px; height:15px;" value="A04 " > A04</td>
															<td style="text-align:center;"><input type="checkbox" name="position4Edit" id="position4Edit" style="width:15px; height:15px;" value="A05 " > A05</td>
														</tr>
														<tr>
															<td style="text-align:center;"><input type="checkbox" name="position5Edit" id="position5Edit" style="width:15px; height:15px;" value="A06 " > A06</td>
															<td style="text-align:center;"><input type="checkbox" name="position6Edit" id="position6Edit" style="width:15px; height:15px;" value="A07 " > A07</td>
														</tr>
													</table>
												</td>
												<td width="10%" style="text-align:center;"><span style="font-size:8pt;">복도</span></td>
												<td width="20%" valign="top">
													<table class="type01" style="font-size:10pt;">
														<tr>
															<td style="text-align:center;"><input type="checkbox" name="position7Edit" id="position7Edit" style="width:15px; height:15px;" value="A08 " > A08</td>
														</tr>
														<tr>
															<td style="text-align:center;"><input type="checkbox" name="position8Edit" id="position8Edit" style="width:15px; height:15px;" value="A09 " > A09</td>
														</tr>
														<tr>
															<td style="text-align:center;"><input type="checkbox" name="position9Edit" id="position9Edit" style="width:15px; height:15px;" value="A10 " > A10</td>
														</tr>
													</table>
												</td>
											</tr>
											<tr>
												<td colspan="5" style="background-color:#ffe6e5; text-align:center; padding-top: 4px; padding-bottom: 4px;">
													<span style="font-size:10pt; font-weight:bold; color:#9b5351">2층</span>
												</td>
											</tr>
											<tr>
												<td width="20%" valign="top">
													<table class="type01" style="font-size:10pt;">
														<tr>
															<td style="text-align:center;"><input type="checkbox" name="position10Edit" id="position10Edit" style="width:15px; height:15px;" value="B01 " > B01</td>
														</tr>
														<tr>
															<td style="text-align:center;"><input type="checkbox" name="position11Edit" id="position11Edit" style="width:15px; height:15px;" value="B02 " > B02</td>
														</tr>
														<tr>
															<td style="text-align:center;"><input type="checkbox" name="position12Edit" id="position12Edit" style="width:15px; height:15px;" value="B03 " > B03</td>
														</tr>
													</table>
												</td>
												<td width="10%" style="text-align:center;"><span style="font-size:8pt;">복도</span></td>
												<td width="40%" valign="top">
													<table class="type01" style="font-size:10pt;">
														<tr>
															<td style="text-align:center;"><input type="checkbox" name="position13Edit" id="position13Edit" style="width:15px; height:15px;" value="B04 " > B04</td>
															<td style="text-align:center;"><input type="checkbox" name="position14Edit" id="position14Edit" style="width:15px; height:15px;" value="B05 " > B05</td>
														</tr>
														<tr>
															<td style="text-align:center;"><input type="checkbox" name="position15Edit" id="position15Edit" style="width:15px; height:15px;" value="B06 " > B06</td>
															<td style="text-align:center;"><input type="checkbox" name="position16Edit" id="position16Edit" style="width:15px; height:15px;" value="B07 " > B07</td>
														</tr>
													</table>
												</td>
												<td width="10%" style="text-align:center;"><span style="font-size:8pt;">복도</span></td>
												<td width="20%" valign="top">
													<table class="type01" style="font-size:10pt;">
														<tr>
															<td style="text-align:center;"><input type="checkbox" name="position17Edit" id="position17Edit" style="width:15px; height:15px;" value="B08 " > B08</td>
														</tr>
														<tr>
															<td style="text-align:center;"><input type="checkbox" name="position18Edit" id="position18Edit" style="width:15px; height:15px;" value="B09 " > B09</td>
														</tr>
														<tr>
															<td style="text-align:center;"><input type="checkbox" name="position19Edit" id="position19Edit" style="width:15px; height:15px;" value="B10 " > B10</td>
														</tr>
													</table>
												</td>
											</tr>
										</table>
									</td>
								</tr>
								<tr><td></td><td></td></tr>
							</table>
							
							<table>
								<tr>
									<td width="510"></td>
									<td>
										<input type="submit" style="background-color:#db8e8c; color:#FFFFFF; font-size:10pt;"
										class="btn btn-lg btn-block text-uppercase"
										type="button" value="확인"><br>
									</td>
									<td width="5"></td>
									<td>
										<input type="button" style="background-color:#db8e8c; color:#FFFFFF; font-size:11pt;"
										class="btn btn-lg btn-block text-uppercase"
										type="button" value="취소" onClick="closeModal();" >	<br>								
									</td>
								</tr>
							</table>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<div id="modal2" class="searchModal">
	<div class="search-modal-content">
		<div class="card card-signin-pw ">
			<div class="alert-text">
				<div class="card">
					<div class="card-body">
						<br><span style="padding-left:10px; "><img src="images/title_09.png" ></span>
						<table>
							<tr>
								<td colspan="5" style="background-color:#ffe6e5; text-align:center; padding-top: 4px; padding-bottom: 4px;">
									<span style="font-size:10pt; font-weight:bold; color:#9b5351">1층</span>
								</td>
							</tr>
							<tr>
								<td width="20%" valign="top">
									<table class="type01" style="font-size:10pt;">
										<tr>
											<td style="text-align:center;">A01</td>
										</tr>
										<tr>
											<td style="text-align:center;">A02</td>
										</tr>
										<tr>
											<td style="text-align:center;">A03</td>
										</tr>
									</table>
								</td>
								<td width="10%" style="text-align:center;"><span style="font-size:8pt;">복도</span></td>
								<td width="40%" valign="top">
									<table class="type01" style="font-size:10pt;">
										<tr>
											<td style="text-align:center;">A04</td>
											<td style="text-align:center;">A05</td>
										</tr>
										<tr>
											<td style="text-align:center;">A06</td>
											<td style="text-align:center;">A07</td>
										</tr>
									</table>
								</td>
								<td width="10%" style="text-align:center;"><span style="font-size:8pt;">복도</span></td>
								<td width="20%" valign="top">
									<table class="type01" style="font-size:10pt;">
										<tr>
											<td style="text-align:center;">A08</td>
										</tr>
										<tr>
											<td style="text-align:center;">A09</td>
										</tr>
										<tr>
											<td style="text-align:center;">A10</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td colspan="5" style="background-color:#ffe6e5; text-align:center; padding-top: 4px; padding-bottom: 4px;">
									<span style="font-size:10pt; font-weight:bold; color:#9b5351">2층</span>
								</td>
							</tr>
							<tr>
								<td width="20%" valign="top">
									<table class="type01" style="font-size:10pt;">
										<tr>
											<td style="text-align:center;">B01</td>
										</tr>
										<tr>
											<td style="text-align:center;">B02</td>
										</tr>
										<tr>
											<td style="text-align:center;">B03</td>
										</tr>
									</table>
								</td>
								<td width="10%" style="text-align:center;"><span style="font-size:8pt;">복도</span></td>
								<td width="40%" valign="top">
									<table class="type01" style="font-size:10pt;">
										<tr>
											<td style="text-align:center;">B04</td>
											<td style="text-align:center;">B05</td>
										</tr>
										<tr>
											<td style="text-align:center;">B06</td>
											<td style="text-align:center;">B07</td>
										</tr>
									</table>
								</td>
								<td width="10%" style="text-align:center;"><span style="font-size:8pt;">복도</span></td>
								<td width="20%" valign="top">
									<table class="type01" style="font-size:10pt;">
										<tr>
											<td style="text-align:center;">B08</td>
										</tr>
										<tr>
											<td style="text-align:center;">B09</td>
										</tr>
										<tr>
											<td style="text-align:center;">B10</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
						<table>
							<tr>
								<td width="580"></td>
								<td style="padding-bottom: 20px;">
									<input type="button" style="background-color:#db8e8c; color:#FFFFFF; font-size:11pt;"
									class="btn btn-lg btn-block text-uppercase" value="닫기" onClick="closeModal();" >
								</td>
							</tr>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<script src="css_cmh/jquery.min.js"></script>
<!-- <script src="css_cmh/bootstrap.min.js"></script> -->
<script src="css_cmh/bootstrap_tab.min.js"></script>
<script src="css_cmh/popper.min.js"></script>
<script>
	$('.paperAdd').click(function(){
		$("#modal").show();
	});
	$('.layout').click(function(){
		$("#modal2").show();
	});
	function paperEditFun(no, name, size, kind, gram, realfilename, filename, location, bunum, pack, box, cost, minimum, delivery, vender, note) {		
		$("#modal1").show();
		
		document.getElementById("paperNoEdit").value=no;
		document.getElementById("paperNameEdit").value=name;
		document.getElementById("paperSizeEdit").value=size;
		document.getElementById("paperKindEdit").value=kind;
		document.getElementById("paperGramEdit").value=gram;
		document.getElementById("paperBuNoEdit").value=bunum;
		document.getElementById("paperPackEdit").value=pack;
		document.getElementById("paperBoxEdit").value=box;
		document.getElementById("paperCostEdit").value=cost;
		document.getElementById("paperMinimumEdit").value=minimum;
		document.getElementById("paperDeliveryEdit").value=delivery;
		document.getElementById("paperVenderEdit").value=vender;
		
		if(filename == "null") {
			document.getElementById("upload-name2").value="";
		}
		else {
			document.getElementById("upload-name2").value=filename;
			document.getElementById("realfilenameChangeFlag").value=realfilename;
			document.getElementById("fileNameChangeFlag").value=filename;
		}
		
		if (location.indexOf('A01')!=-1) {
			document.getElementById("position0Edit").checked = true;
			document.getElementById("position1Edit").checked = false;
			document.getElementById("position2Edit").checked = false;
			document.getElementById("position3Edit").checked = false;
			document.getElementById("position4Edit").checked = false;
			document.getElementById("position5Edit").checked = false;
			document.getElementById("position6Edit").checked = false;
			document.getElementById("position7Edit").checked = false;
			document.getElementById("position8Edit").checked = false;
			document.getElementById("position9Edit").checked = false;
			document.getElementById("position10Edit").checked = false;
			document.getElementById("position11Edit").checked = false;
			document.getElementById("position12Edit").checked = false;
			document.getElementById("position13Edit").checked = false;
			document.getElementById("position14Edit").checked = false;
			document.getElementById("position15Edit").checked = false;
			document.getElementById("position16Edit").checked = false;
			document.getElementById("position17Edit").checked = false;
			document.getElementById("position18Edit").checked = false;
			document.getElementById("position19Edit").checked = false;			
		}
		else if (location.indexOf('A02')!=-1) {
			document.getElementById("position0Edit").checked = false;
			document.getElementById("position1Edit").checked = true;
			document.getElementById("position2Edit").checked = false;
			document.getElementById("position3Edit").checked = false;
			document.getElementById("position4Edit").checked = false;
			document.getElementById("position5Edit").checked = false;
			document.getElementById("position6Edit").checked = false;
			document.getElementById("position7Edit").checked = false;
			document.getElementById("position8Edit").checked = false;
			document.getElementById("position9Edit").checked = false;
			document.getElementById("position10Edit").checked = false;
			document.getElementById("position11Edit").checked = false;
			document.getElementById("position12Edit").checked = false;
			document.getElementById("position13Edit").checked = false;
			document.getElementById("position14Edit").checked = false;
			document.getElementById("position15Edit").checked = false;
			document.getElementById("position16Edit").checked = false;
			document.getElementById("position17Edit").checked = false;
			document.getElementById("position18Edit").checked = false;
			document.getElementById("position19Edit").checked = false;
		}
		else if (location.indexOf('A03')!=-1) {
			document.getElementById("position0Edit").checked = false;
			document.getElementById("position1Edit").checked = false;
			document.getElementById("position2Edit").checked = true;
			document.getElementById("position3Edit").checked = false;
			document.getElementById("position4Edit").checked = false;
			document.getElementById("position5Edit").checked = false;
			document.getElementById("position6Edit").checked = false;
			document.getElementById("position7Edit").checked = false;
			document.getElementById("position8Edit").checked = false;
			document.getElementById("position9Edit").checked = false;
			document.getElementById("position10Edit").checked = false;
			document.getElementById("position11Edit").checked = false;
			document.getElementById("position12Edit").checked = false;
			document.getElementById("position13Edit").checked = false;
			document.getElementById("position14Edit").checked = false;
			document.getElementById("position15Edit").checked = false;
			document.getElementById("position16Edit").checked = false;
			document.getElementById("position17Edit").checked = false;
			document.getElementById("position18Edit").checked = false;
			document.getElementById("position19Edit").checked = false;
		}
		else if (location.indexOf('A04')!=-1) {
			document.getElementById("position0Edit").checked = false;
			document.getElementById("position1Edit").checked = false;
			document.getElementById("position2Edit").checked = false;
			document.getElementById("position3Edit").checked = true;
			document.getElementById("position4Edit").checked = false;
			document.getElementById("position5Edit").checked = false;
			document.getElementById("position6Edit").checked = false;
			document.getElementById("position7Edit").checked = false;
			document.getElementById("position8Edit").checked = false;
			document.getElementById("position9Edit").checked = false;
			document.getElementById("position10Edit").checked = false;
			document.getElementById("position11Edit").checked = false;
			document.getElementById("position12Edit").checked = false;
			document.getElementById("position13Edit").checked = false;
			document.getElementById("position14Edit").checked = false;
			document.getElementById("position15Edit").checked = false;
			document.getElementById("position16Edit").checked = false;
			document.getElementById("position17Edit").checked = false;
			document.getElementById("position18Edit").checked = false;
			document.getElementById("position19Edit").checked = false;
		}
		else if (location.indexOf('A05')!=-1) {
			document.getElementById("position0Edit").checked = false;
			document.getElementById("position1Edit").checked = false;
			document.getElementById("position2Edit").checked = false;
			document.getElementById("position3Edit").checked = false;
			document.getElementById("position4Edit").checked = true;
			document.getElementById("position5Edit").checked = false;
			document.getElementById("position6Edit").checked = false;
			document.getElementById("position7Edit").checked = false;
			document.getElementById("position8Edit").checked = false;
			document.getElementById("position9Edit").checked = false;
			document.getElementById("position10Edit").checked = false;
			document.getElementById("position11Edit").checked = false;
			document.getElementById("position12Edit").checked = false;
			document.getElementById("position13Edit").checked = false;
			document.getElementById("position14Edit").checked = false;
			document.getElementById("position15Edit").checked = false;
			document.getElementById("position16Edit").checked = false;
			document.getElementById("position17Edit").checked = false;
			document.getElementById("position18Edit").checked = false;
			document.getElementById("position19Edit").checked = false;
		}
		else if (location.indexOf('A06')!=-1) {
			document.getElementById("position0Edit").checked = false;
			document.getElementById("position1Edit").checked = false;
			document.getElementById("position2Edit").checked = false;
			document.getElementById("position3Edit").checked = false;
			document.getElementById("position4Edit").checked = false;
			document.getElementById("position5Edit").checked = true;
			document.getElementById("position6Edit").checked = false;
			document.getElementById("position7Edit").checked = false;
			document.getElementById("position8Edit").checked = false;
			document.getElementById("position9Edit").checked = false;
			document.getElementById("position10Edit").checked = false;
			document.getElementById("position11Edit").checked = false;
			document.getElementById("position12Edit").checked = false;
			document.getElementById("position13Edit").checked = false;
			document.getElementById("position14Edit").checked = false;
			document.getElementById("position15Edit").checked = false;
			document.getElementById("position16Edit").checked = false;
			document.getElementById("position17Edit").checked = false;
			document.getElementById("position18Edit").checked = false;
			document.getElementById("position19Edit").checked = false;
		}
		else if (location.indexOf('A07')!=-1) {
			document.getElementById("position0Edit").checked = false;
			document.getElementById("position1Edit").checked = false;
			document.getElementById("position2Edit").checked = false;
			document.getElementById("position3Edit").checked = false;
			document.getElementById("position4Edit").checked = false;
			document.getElementById("position5Edit").checked = false;
			document.getElementById("position6Edit").checked = true;
			document.getElementById("position7Edit").checked = false;
			document.getElementById("position8Edit").checked = false;
			document.getElementById("position9Edit").checked = false;
			document.getElementById("position10Edit").checked = false;
			document.getElementById("position11Edit").checked = false;
			document.getElementById("position12Edit").checked = false;
			document.getElementById("position13Edit").checked = false;
			document.getElementById("position14Edit").checked = false;
			document.getElementById("position15Edit").checked = false;
			document.getElementById("position16Edit").checked = false;
			document.getElementById("position17Edit").checked = false;
			document.getElementById("position18Edit").checked = false;
			document.getElementById("position19Edit").checked = false;
		}
		else if (location.indexOf('A08')!=-1) {
			document.getElementById("position0Edit").checked = false;
			document.getElementById("position1Edit").checked = false;
			document.getElementById("position2Edit").checked = false;
			document.getElementById("position3Edit").checked = false;
			document.getElementById("position4Edit").checked = false;
			document.getElementById("position5Edit").checked = false;
			document.getElementById("position6Edit").checked = false;
			document.getElementById("position7Edit").checked = true;
			document.getElementById("position8Edit").checked = false;
			document.getElementById("position9Edit").checked = false;
			document.getElementById("position10Edit").checked = false;
			document.getElementById("position11Edit").checked = false;
			document.getElementById("position12Edit").checked = false;
			document.getElementById("position13Edit").checked = false;
			document.getElementById("position14Edit").checked = false;
			document.getElementById("position15Edit").checked = false;
			document.getElementById("position16Edit").checked = false;
			document.getElementById("position17Edit").checked = false;
			document.getElementById("position18Edit").checked = false;
			document.getElementById("position19Edit").checked = false;
		}
		else if (location.indexOf('A09')!=-1) {
			document.getElementById("position0Edit").checked = false;
			document.getElementById("position1Edit").checked = false;
			document.getElementById("position2Edit").checked = false;
			document.getElementById("position3Edit").checked = false;
			document.getElementById("position4Edit").checked = false;
			document.getElementById("position5Edit").checked = false;
			document.getElementById("position6Edit").checked = false;
			document.getElementById("position7Edit").checked = false;
			document.getElementById("position8Edit").checked = true;
			document.getElementById("position9Edit").checked = false;
			document.getElementById("position10Edit").checked = false;
			document.getElementById("position11Edit").checked = false;
			document.getElementById("position12Edit").checked = false;
			document.getElementById("position13Edit").checked = false;
			document.getElementById("position14Edit").checked = false;
			document.getElementById("position15Edit").checked = false;
			document.getElementById("position16Edit").checked = false;
			document.getElementById("position17Edit").checked = false;
			document.getElementById("position18Edit").checked = false;
			document.getElementById("position19Edit").checked = false;
		}
		else if (location.indexOf('A10')!=-1) {
			document.getElementById("position0Edit").checked = false;
			document.getElementById("position1Edit").checked = false;
			document.getElementById("position2Edit").checked = false;
			document.getElementById("position3Edit").checked = false;
			document.getElementById("position4Edit").checked = false;
			document.getElementById("position5Edit").checked = false;
			document.getElementById("position6Edit").checked = false;
			document.getElementById("position7Edit").checked = false;
			document.getElementById("position8Edit").checked = false;
			document.getElementById("position9Edit").checked = true;
			document.getElementById("position10Edit").checked = false;
			document.getElementById("position11Edit").checked = false;
			document.getElementById("position12Edit").checked = false;
			document.getElementById("position13Edit").checked = false;
			document.getElementById("position14Edit").checked = false;
			document.getElementById("position15Edit").checked = false;
			document.getElementById("position16Edit").checked = false;
			document.getElementById("position17Edit").checked = false;
			document.getElementById("position18Edit").checked = false;
			document.getElementById("position19Edit").checked = false;
		}
		else if (location.indexOf('B01')!=-1) {
			document.getElementById("position0Edit").checked = false;
			document.getElementById("position1Edit").checked = false;
			document.getElementById("position2Edit").checked = false;
			document.getElementById("position3Edit").checked = false;
			document.getElementById("position4Edit").checked = false;
			document.getElementById("position5Edit").checked = false;
			document.getElementById("position6Edit").checked = false;
			document.getElementById("position7Edit").checked = false;
			document.getElementById("position8Edit").checked = false;
			document.getElementById("position9Edit").checked = false;
			document.getElementById("position10Edit").checked = true;
			document.getElementById("position11Edit").checked = false;
			document.getElementById("position12Edit").checked = false;
			document.getElementById("position13Edit").checked = false;
			document.getElementById("position14Edit").checked = false;
			document.getElementById("position15Edit").checked = false;
			document.getElementById("position16Edit").checked = false;
			document.getElementById("position17Edit").checked = false;
			document.getElementById("position18Edit").checked = false;
			document.getElementById("position19Edit").checked = false;
		}
		else if (location.indexOf('B02')!=-1) {
			document.getElementById("position0Edit").checked = false;
			document.getElementById("position1Edit").checked = false;
			document.getElementById("position2Edit").checked = false;
			document.getElementById("position3Edit").checked = false;
			document.getElementById("position4Edit").checked = false;
			document.getElementById("position5Edit").checked = false;
			document.getElementById("position6Edit").checked = false;
			document.getElementById("position7Edit").checked = false;
			document.getElementById("position8Edit").checked = false;
			document.getElementById("position9Edit").checked = false;
			document.getElementById("position10Edit").checked = false;
			document.getElementById("position11Edit").checked = true;
			document.getElementById("position12Edit").checked = false;
			document.getElementById("position13Edit").checked = false;
			document.getElementById("position14Edit").checked = false;
			document.getElementById("position15Edit").checked = false;
			document.getElementById("position16Edit").checked = false;
			document.getElementById("position17Edit").checked = false;
			document.getElementById("position18Edit").checked = false;
			document.getElementById("position19Edit").checked = false;
		}
		else if (location.indexOf('B03')!=-1) {
			document.getElementById("position0Edit").checked = false;
			document.getElementById("position1Edit").checked = false;
			document.getElementById("position2Edit").checked = false;
			document.getElementById("position3Edit").checked = false;
			document.getElementById("position4Edit").checked = false;
			document.getElementById("position5Edit").checked = false;
			document.getElementById("position6Edit").checked = false;
			document.getElementById("position7Edit").checked = false;
			document.getElementById("position8Edit").checked = false;
			document.getElementById("position9Edit").checked = false;
			document.getElementById("position10Edit").checked = false;
			document.getElementById("position11Edit").checked = false;
			document.getElementById("position12Edit").checked = true;
			document.getElementById("position13Edit").checked = false;
			document.getElementById("position14Edit").checked = false;
			document.getElementById("position15Edit").checked = false;
			document.getElementById("position16Edit").checked = false;
			document.getElementById("position17Edit").checked = false;
			document.getElementById("position18Edit").checked = false;
			document.getElementById("position19Edit").checked = false;
		}
		else if (location.indexOf('B04')!=-1) {
			document.getElementById("position0Edit").checked = false;
			document.getElementById("position1Edit").checked = false;
			document.getElementById("position2Edit").checked = false;
			document.getElementById("position3Edit").checked = false;
			document.getElementById("position4Edit").checked = false;
			document.getElementById("position5Edit").checked = false;
			document.getElementById("position6Edit").checked = false;
			document.getElementById("position7Edit").checked = false;
			document.getElementById("position8Edit").checked = false;
			document.getElementById("position9Edit").checked = false;
			document.getElementById("position10Edit").checked = false;
			document.getElementById("position11Edit").checked = false;
			document.getElementById("position12Edit").checked = false;
			document.getElementById("position13Edit").checked = true;
			document.getElementById("position14Edit").checked = false;
			document.getElementById("position15Edit").checked = false;
			document.getElementById("position16Edit").checked = false;
			document.getElementById("position17Edit").checked = false;
			document.getElementById("position18Edit").checked = false;
			document.getElementById("position19Edit").checked = false;
		}
		else if (location.indexOf('B05')!=-1) {
			document.getElementById("position0Edit").checked = false;
			document.getElementById("position1Edit").checked = false;
			document.getElementById("position2Edit").checked = false;
			document.getElementById("position3Edit").checked = false;
			document.getElementById("position4Edit").checked = false;
			document.getElementById("position5Edit").checked = false;
			document.getElementById("position6Edit").checked = false;
			document.getElementById("position7Edit").checked = false;
			document.getElementById("position8Edit").checked = false;
			document.getElementById("position9Edit").checked = false;
			document.getElementById("position10Edit").checked = false;
			document.getElementById("position11Edit").checked = false;
			document.getElementById("position12Edit").checked = false;
			document.getElementById("position13Edit").checked = false;
			document.getElementById("position14Edit").checked = true;
			document.getElementById("position15Edit").checked = false;
			document.getElementById("position16Edit").checked = false;
			document.getElementById("position17Edit").checked = false;
			document.getElementById("position18Edit").checked = false;
			document.getElementById("position19Edit").checked = false;
		}
		else if (location.indexOf('B06')!=-1) {
			document.getElementById("position0Edit").checked = false;
			document.getElementById("position1Edit").checked = false;
			document.getElementById("position2Edit").checked = false;
			document.getElementById("position3Edit").checked = false;
			document.getElementById("position4Edit").checked = false;
			document.getElementById("position5Edit").checked = false;
			document.getElementById("position6Edit").checked = false;
			document.getElementById("position7Edit").checked = false;
			document.getElementById("position8Edit").checked = false;
			document.getElementById("position9Edit").checked = false;
			document.getElementById("position10Edit").checked = false;
			document.getElementById("position11Edit").checked = false;
			document.getElementById("position12Edit").checked = false;
			document.getElementById("position13Edit").checked = false;
			document.getElementById("position14Edit").checked = false;
			document.getElementById("position15Edit").checked = true;
			document.getElementById("position16Edit").checked = false;
			document.getElementById("position17Edit").checked = false;
			document.getElementById("position18Edit").checked = false;
			document.getElementById("position19Edit").checked = false;
		}
		else if (location.indexOf('B07')!=-1) {
			document.getElementById("position0Edit").checked = false;
			document.getElementById("position1Edit").checked = false;
			document.getElementById("position2Edit").checked = false;
			document.getElementById("position3Edit").checked = false;
			document.getElementById("position4Edit").checked = false;
			document.getElementById("position5Edit").checked = false;
			document.getElementById("position6Edit").checked = false;
			document.getElementById("position7Edit").checked = false;
			document.getElementById("position8Edit").checked = false;
			document.getElementById("position9Edit").checked = false;
			document.getElementById("position10Edit").checked = false;
			document.getElementById("position11Edit").checked = false;
			document.getElementById("position12Edit").checked = false;
			document.getElementById("position13Edit").checked = false;
			document.getElementById("position14Edit").checked = false;
			document.getElementById("position15Edit").checked = false;
			document.getElementById("position16Edit").checked = true;
			document.getElementById("position17Edit").checked = false;
			document.getElementById("position18Edit").checked = false;
			document.getElementById("position19Edit").checked = false;
		}
		else if (location.indexOf('B08')!=-1) {
			document.getElementById("position0Edit").checked = false;
			document.getElementById("position1Edit").checked = false;
			document.getElementById("position2Edit").checked = false;
			document.getElementById("position3Edit").checked = false;
			document.getElementById("position4Edit").checked = false;
			document.getElementById("position5Edit").checked = false;
			document.getElementById("position6Edit").checked = false;
			document.getElementById("position7Edit").checked = false;
			document.getElementById("position8Edit").checked = false;
			document.getElementById("position9Edit").checked = false;
			document.getElementById("position10Edit").checked = false;
			document.getElementById("position11Edit").checked = false;
			document.getElementById("position12Edit").checked = false;
			document.getElementById("position13Edit").checked = false;
			document.getElementById("position14Edit").checked = false;
			document.getElementById("position15Edit").checked = false;
			document.getElementById("position16Edit").checked = false;
			document.getElementById("position17Edit").checked = true;
			document.getElementById("position18Edit").checked = false;
			document.getElementById("position19Edit").checked = false;
		}
		else if (location.indexOf('B09')!=-1) {
			document.getElementById("position0Edit").checked = false;
			document.getElementById("position1Edit").checked = false;
			document.getElementById("position2Edit").checked = false;
			document.getElementById("position3Edit").checked = false;
			document.getElementById("position4Edit").checked = false;
			document.getElementById("position5Edit").checked = false;
			document.getElementById("position6Edit").checked = false;
			document.getElementById("position7Edit").checked = false;
			document.getElementById("position8Edit").checked = false;
			document.getElementById("position9Edit").checked = false;
			document.getElementById("position10Edit").checked = false;
			document.getElementById("position11Edit").checked = false;
			document.getElementById("position12Edit").checked = false;
			document.getElementById("position13Edit").checked = false;
			document.getElementById("position14Edit").checked = false;
			document.getElementById("position15Edit").checked = false;
			document.getElementById("position16Edit").checked = false;
			document.getElementById("position17Edit").checked = false;
			document.getElementById("position18Edit").checked = true;
			document.getElementById("position19Edit").checked = false;
		}
		else if (location.indexOf('B10')!=-1) {
			document.getElementById("position0Edit").checked = false;
			document.getElementById("position1Edit").checked = false;
			document.getElementById("position2Edit").checked = false;
			document.getElementById("position3Edit").checked = false;
			document.getElementById("position4Edit").checked = false;
			document.getElementById("position5Edit").checked = false;
			document.getElementById("position6Edit").checked = false;
			document.getElementById("position7Edit").checked = false;
			document.getElementById("position8Edit").checked = false;
			document.getElementById("position9Edit").checked = false;
			document.getElementById("position10Edit").checked = false;
			document.getElementById("position11Edit").checked = false;
			document.getElementById("position12Edit").checked = false;
			document.getElementById("position13Edit").checked = false;
			document.getElementById("position14Edit").checked = false;
			document.getElementById("position15Edit").checked = false;
			document.getElementById("position16Edit").checked = false;
			document.getElementById("position17Edit").checked = false;
			document.getElementById("position18Edit").checked = false;
			document.getElementById("position19Edit").checked = true;
		}
	};
	function closeModal() {
		$('.searchModal').hide();
	};
	function movePage(pageNumber) {
		var f = document.paging;
		
		f.pageNumber.value = pageNumber;
	    f.action = "./managePaper.jsp"
	    f.method = "post"
	    f.submit();
	};
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
	$(document).ready(
	function() {
		var fileTarget = $('.filebox .upload-hidden1');

		fileTarget.on('change', function() { // 값이 변경되면
			if (window.FileReader) { // modern browser 
				var filename = $(this)[0].files[0].name;
			} else { // old IE 
				var filename = $(this).val().split('/').pop().split(
						'\\').pop(); // 파일명만 추출 
			}

			// 추출한 파일명 삽입 
			$(this).siblings('.upload-name1').val(filename);
		});
	});
	
	$(document).ready(
	function() {
		var fileTarget = $('.filebox2 .upload-hidden2');

		fileTarget.on('change', function() { // 값이 변경되면
			if (window.FileReader) { // modern browser 
				var filename = $(this)[0].files[0].name;
			} else { // old IE 
				var filename = $(this).val().split('/').pop().split(
						'\\').pop(); // 파일명만 추출 
			}

			// 추출한 파일명 삽입 
			$(this).siblings('.upload-name2').val(filename);
			document.getElementById("fileChangeFlag").value="1";
		});
	});
	
	function delPaperFun(id) {
		var inputCreateForm = document.createElement("form");
		
		inputCreateForm.name = "delPaperForm";
		inputCreateForm.method = "post";
		inputCreateForm.action = "ActionDelPaper.jsp";
		
		var el;
		
		el = document.createElement("input");
		el.setAttribute("type", "hidden");
		el.setAttribute("name", "selectDelID");
		el.setAttribute("value", id);
		inputCreateForm.appendChild(el);
		
		document.body.appendChild(inputCreateForm);
		
		inputCreateForm.submit();
	};
</script>
</body>
</html>