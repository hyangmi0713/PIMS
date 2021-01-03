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
<%@ page import="rent.Rent"%>
<%@ page import="rent.RentDAO"%>
<%@ page import="java.util.ArrayList"%>
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
%>
<%
	PartDAO partListDAO = new PartDAO();
	ArrayList<Part> getPartList = partListDAO.allPartList();
%>
<%
	PaperStockDAO paperListDAO = new PaperStockDAO();
	ArrayList<PaperStock> getPaperSizeListDAO = paperListDAO.paperSizeList();
	int getPaperCountDAO = paperListDAO.getPaperListColumns();
	
	RentDAO rentDAO = new RentDAO();
	ArrayList<Rent> getRentDAO = rentDAO.allRentList();
%>
<%
	int pageNumber = 0;
	Pm_inventoryDAO inventoryDAO = new Pm_inventoryDAO();
	ArrayList<Pm_inventory> getExpenditureDAO = inventoryDAO.allExpenditureList(1);
	ArrayList<Pm_inventory> getIncomeDAO = inventoryDAO.allExpenditureList(0);
	
	if (request.getParameter("pageNumber")!=null) {
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	}
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
								<th scope="cols" style="text-align:center;">No.</th>
								<th scope="cols" style="text-align:center;">날짜</th>
								<th scope="cols" style="text-align:center;">사이즈</th>
								<th scope="cols" style="text-align:center;">용지 종류</th>
								<th scope="cols" style="text-align:center;">평량(m/g)</th>
								<th scope="cols" style="text-align:center;">대여수량</th>
								
								<th scope="cols" style="text-align:center; background: #8ca6db;">인수자부서</th>
								<th scope="cols" style="text-align:center; background: #8ca6db;">인수자프로젝트</th>
								<th scope="cols" style="text-align:center; background: #8ca6db;">인수자이름</th>
																
								<th scope="cols" style="text-align:center; background: #b7a3eb;">인계자부서</th>
								<th scope="cols" style="text-align:center; background: #b7a3eb;">인계자프로젝트</th>
								<th scope="cols" style="text-align:center; background: #b7a3eb;">인계자이름</th>
								
								<th scope="cols" style="text-align:center;">비고</th>
								<th scope="cols" style="text-align:center;">상태</th>
								<th scope="cols" style="text-align:center;">편집</th>
							</tr>
						</thead>
						<tbody>
							<%
							int pageStartNumberIncome = 0;
							int pageEndNumberIncome = 0;
							
							if(pageNumber == 0) {
								pageStartNumberIncome = 0;
								if (pageStartNumberIncome+9 < getRentDAO.size()) {
									pageEndNumberIncome = pageStartNumberIncome+10;
								}
								else {
									pageEndNumberIncome = getRentDAO.size();
								}
							}
							else {
								pageStartNumberIncome = pageNumber*10;
								if (pageStartNumberIncome+9 < getRentDAO.size()) {
									pageEndNumberIncome = pageStartNumberIncome+10;
								}
								else {
									pageEndNumberIncome = getRentDAO.size();
								}
							}
							
							for(int i=pageStartNumberIncome; i<pageEndNumberIncome; i++) {
								if(i%2 != 0) {
							%>
								<tr class="first">
									<td style="padding-top:15px; text-align:center; "><%=i+1 %></td>
									<td style="padding-top:15px; text-align:center; "><%=getRentDAO.get(i).getDate() %></td>
									<td style="padding-top:15px; text-align:center; "><%=getRentDAO.get(i).getSize() %></td>
									<td style="padding-top:15px; text-align:center; "><%=getRentDAO.get(i).getKind() %></td>
									<td style="padding-top:15px; text-align:center; "><%=getRentDAO.get(i).getGram() %> m/g</td>
									<td style="padding-top:15px; text-align:center; "><%=getRentDAO.get(i).getCount() %> Pack</td>
									<td style="padding-top:15px; text-align:center; background: #f3f4ff;"><%=getRentDAO.get(i).getRentPart() %></td>
									<td style="padding-top:15px; text-align:center; background: #f3f4ff;"><%=getRentDAO.get(i).getRentProjectSel() %></td>
									<td style="padding-top:15px; text-align:center; background: #f3f4ff;"><%=getRentDAO.get(i).getRentName() %></td>
									<td style="padding-top:15px; text-align:center; background: #F1F0F3;"><%=getRentDAO.get(i).getLendPart() %></td>
									<td style="padding-top:15px; text-align:center; background: #F1F0F3;"><%=getRentDAO.get(i).getLendProjectSel() %></td>
									<td style="padding-top:15px; text-align:center; background: #F1F0F3;"><%=getRentDAO.get(i).getLendName() %></td>
									<td style="padding-top:15px; text-align:center; "><%=getRentDAO.get(i).getNote() %></td>
									<td style="padding-top:15px; text-align:center; ">
										<%
										String state = null;
										if(getRentDAO.get(i).getState() == 0) {
											state = "대여대기";
										}
										else {
											state = "대여완료";
										}
										%>
										<%=state %>
									</td>
									<td><button type="button" class="btn btn-default pull-right" id="editRent" name="editRent" 
											onclick="rentEditFun('<%=getRentDAO.get(i).getNo() %>',
											'<%=getRentDAO.get(i).getDate() %>',
											'<%=getRentDAO.get(i).getSize() %>',
											'<%=getRentDAO.get(i).getKind() %>',
											'<%=getRentDAO.get(i).getGram() %>',
											'<%=getRentDAO.get(i).getCount() %>',
											'<%=getRentDAO.get(i).getRentPart() %>',
											'<%=getRentDAO.get(i).getRentProjectSel() %>',
											'<%=getRentDAO.get(i).getRentName() %>',
											'<%=getRentDAO.get(i).getLendPart() %>',
											'<%=getRentDAO.get(i).getLendProjectSel() %>',
											'<%=getRentDAO.get(i).getLendName() %>',
											'<%=getRentDAO.get(i).getNote() %>',
											'<%=getRentDAO.get(i).getState() %>')">편집</button></td>
								</tr>
							<%
								}
								else {
							%>
								<tr class="first">
									<td class="even" style="padding-top:15px; text-align:center; "><%=i+1 %></td>
									<td class="even" style="padding-top:15px; text-align:center; "><%=getRentDAO.get(i).getDate() %></td>
									<td class="even" style="padding-top:15px; text-align:center; "><%=getRentDAO.get(i).getSize() %></td>
									<td class="even" style="padding-top:15px; text-align:center; "><%=getRentDAO.get(i).getKind() %></td>
									<td class="even" style="padding-top:15px; text-align:center; "><%=getRentDAO.get(i).getGram() %> m/g</td>
									<td class="even" style="padding-top:15px; text-align:center; "><%=getRentDAO.get(i).getCount() %> Pack</td>
									<td class="even" style="padding-top:15px; text-align:center; background: #f3f4ff;"><%=getRentDAO.get(i).getRentPart() %></td>
									<td class="even" style="padding-top:15px; text-align:center; background: #f3f4ff;"><%=getRentDAO.get(i).getRentProjectSel() %></td>
									<td class="even" style="padding-top:15px; text-align:center; background: #f3f4ff;"><%=getRentDAO.get(i).getRentName() %></td>
									<td class="even" style="padding-top:15px; text-align:center; background: #F1F0F3;"><%=getRentDAO.get(i).getLendPart() %></td>
									<td class="even" style="padding-top:15px; text-align:center; background: #F1F0F3;"><%=getRentDAO.get(i).getLendProjectSel() %></td>
									<td class="even" style="padding-top:15px; text-align:center; background: #F1F0F3;"><%=getRentDAO.get(i).getLendName() %></td>
									<td class="even" style="padding-top:15px; text-align:center; "><%=getRentDAO.get(i).getNote() %></td>
									<td class="even" style="padding-top:15px; text-align:center; ">
										<%
										String state = null;
										if(getRentDAO.get(i).getState() == 0) {
											state = "대여대기";
										}
										else {
											state = "대여완료";
										}
										%>
										<%=state %>
									</td>
									<td class="even" ><button type="button" class="btn btn-default pull-right" id="editRent" name="editRent" 
											onclick="rentEditFun('<%=getRentDAO.get(i).getNo() %>',
											'<%=getRentDAO.get(i).getDate() %>',
											'<%=getRentDAO.get(i).getSize() %>',
											'<%=getRentDAO.get(i).getKind() %>',
											'<%=getRentDAO.get(i).getGram() %>',
											'<%=getRentDAO.get(i).getCount() %>',
											'<%=getRentDAO.get(i).getRentPart() %>',
											'<%=getRentDAO.get(i).getRentProjectSel() %>',
											'<%=getRentDAO.get(i).getRentName() %>',
											'<%=getRentDAO.get(i).getLendPart() %>',
											'<%=getRentDAO.get(i).getLendProjectSel() %>',
											'<%=getRentDAO.get(i).getLendName() %>',
											'<%=getRentDAO.get(i).getNote() %>',
											'<%=getRentDAO.get(i).getState() %>')">편집</button></td>
								</tr>
							<%	
								}
							}
							%>
							<tr>
								<td colspan="15">
									<table style="margin-left: auto; margin-right: auto;">
										<tr>
											<td style="text-align: right; padding-right:15px;">
												<a href="javascript:void(0);" onClick="movePage('0'); return false;"><img src="images/preIcon.png"></a>
											</td>
											<td style="text-align: center;">
											<%
											if (getRentDAO.size()/10 < 10) {
												for (int j=0; j<(getRentDAO.size()/10)+1; j++) {
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
													if (pageNumber+6 > (getRentDAO.size()/10)) {
														totalPageStartNum = pageNumber-(9-((getRentDAO.size()/10)-pageNumber));
														totalPageEndNum = (getRentDAO.size()/10)+1;
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
												<a href="javascript:void(0);" onClick="movePage('<%=(getRentDAO.size()/10) %>'); return false;"><img src="images/nextIcon.png"></a>
											</td>
										</tr>
										<%pageNumber = 0; %>
									</table>
								</td>
							</tr>
						</tbody>
						</table>
					<form name="paging">
						<input type="hidden" name="pageNumber"/>
					</form>
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
	
<div id="modal4" class="searchModal">
	<div class="search-modal-content">
		<div class="card card-signin-pw ">
			<div class="alert-text">
				<div class="card">
					<div class="card-body">
						<br><span style="padding-left:10px; "><img src="images/title_10.png" ></span>
						<form name="ActionEditRentList" action="ActionEditRentList.jsp" method="POST" enctype="multipart/form-data" >
							<input type="hidden" id="rentNoEdit" name="rentNoEdit" >
							<table class="table">
								<tr>
									<td width="150px" style="padding-top:12px; font-size:10pt">날짜</td>
									<td style="text-align:left">
										<input type="text" class="form-control" id="rentDateEdit" name="rentDateEdit" >
									</td>
								</tr>
								<tr>
									<td width="150px" style="padding-top:12px; font-size:10pt">사이즈</td>
									<td style="text-align:left">
										<input type="text" class="form-control" id="rentSizeEdit" name="rentSizeEdit" >
									</td>
								</tr>
								<tr>
									<td style="padding-top:12px; font-size:10pt">용지종류</td>
									<td style="padding-top:12px; text-align:left; font-size:10pt">
										<input type="text" class="form-control" id="rentKindEdit" name="rentKindEdit" >
									</td>
								</tr>
								<tr>
									<td style="padding-top:12px; font-size:10pt">평량(g/m)</td>
									<td>
										<input type="text" class="form-control" id="rentGramEdit" name="rentGramEdit" >
									</td>
								</tr>
								<tr>
									<td style="padding-top:12px; font-size:10pt">대여수량</td>
									<td>
										<input type="text" class="form-control" id="rentBunoEdit" name="rentBunoEdit" >									
									</td>
								</tr>
								<tr>
									<td style="padding-top:12px; font-size:10pt">인수자부서</td>
									<td>
										<input type="text" class="form-control" id="rentPartEdit" name="rentPartEdit" >									
									</td>
								</tr>
								<tr>
									<td style="padding-top:12px; font-size:10pt">인수자프로젝트</td>
									<td>
										<input type="text" class="form-control" id="rentProjectEdit" name="rentProjectEdit" >
									</td>
								</tr>
								<tr>
									<td style="padding-top:12px; font-size:10pt">인수자이름</td>
									<td>
										<input type="text" class="form-control" id="rentNameEdit" name="rentNameEdit" >
									</td>
								</tr>
								<tr>
									<td style="padding-top:12px; font-size:10pt">인계자부서</td>
									<td>
										<input type="text" class="form-control" id="lendPartEdit" name="lendPartEdit" >									
									</td>
								</tr>
								<tr>
									<td style="padding-top:12px; font-size:10pt">인계자프로젝트</td>
									<td>
										<input type="text" class="form-control" id="lendProjectEdit" name="lendProjectEdit" >
									</td>
								</tr>
								<tr>
									<td style="padding-top:12px; font-size:10pt">인계자이름</td>
									<td>
										<input type="text" class="form-control" id="lendNameEdit" name="lendNameEdit" >
									</td>
								</tr>
								<tr>
									<td style="padding-top:12px; font-size:10pt">비고</td>
									<td>
										<input type="text" class="form-control" id="rentNote" name="rentNote" >
									</td>
								</tr>
								<tr>
									<td style="padding-top:12px; font-size:10pt">상태</td>
									<td>
										<select class="form-control" id="rentState" name="rentState">
											<option value="0">대여대기</option>
											<option value="1">대여완료</option>
										</select>
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

<script src="css_cmh/jquery.min.js"></script>
<!-- <script src="css_cmh/bootstrap.min.js"></script> -->
<script src="css_cmh/bootstrap_tab.min.js"></script>
<script src="css_cmh/popper.min.js"></script>
<script src="js/modal-join.js" type="text/javascript"  /></script>
<script>
	$('.memberAdd').click(function(){
		$("#modal").show();
	});
	function closeModal() {
		$('.searchModal').hide();
	};
	
	$('.editPart').click(function(){
		$("#modal1").show();
	});
	$('.paperListAdd').click(function(){
		$("#modal4").show();
	});
	
	function editMemberFun(id, pw, name, part, grade) {
		$("#modal2").show();
		
		document.getElementById("editMemberSpanID").innerHTML=id;
		document.getElementById("userEditID").value=id;
		document.getElementById("userEditPW").value=pw;
		document.getElementById("userEditName").value=name;
		
		var partNum = <%=getPartList.size()%>;
		
		for (i=0; i<partNum; i++) {
		    if (document.getElementById("userEditPart").options[i].value == part) {
		        document.getElementById("userEditPart").options[i].selected = "selected";
		    }
		}
		
		for (i=0; i<2; i++) {
		    if (document.getElementById("userEditGrade").options[i].value == grade) {
		        document.getElementById("userEditGrade").options[i].selected = "selected";
		    }
		}
	};
	
	function delMemberFun(id) {
		var inputCreateForm = document.createElement("form");
		
		inputCreateForm.name = "editMemberForm";
		inputCreateForm.method = "post";
		inputCreateForm.action = "ActionDelMember.jsp";
		
		var el;
		
		el = document.createElement("input");
		el.setAttribute("type", "hidden");
		el.setAttribute("name", "selectDelID");
		el.setAttribute("value", id);
		inputCreateForm.appendChild(el);
		
		document.body.appendChild(inputCreateForm);
		
		inputCreateForm.submit();
	};
	
	function movePage(pageNumber) {
		var f = document.paging;
	
	    f.pageNumber.value = pageNumber;
	    f.action = "./recordRent.jsp"
	    f.method = "post"
	    f.submit();
	};
	
	function delPaperList(id) {
		var inputCreateForm = document.createElement("form");
		
		inputCreateForm.name = "delPaperListForm";
		inputCreateForm.method = "post";
		inputCreateForm.action = "ActionDelPaperList.jsp";
		
		var el;
		
		el = document.createElement("input");
		el.setAttribute("type", "hidden");
		el.setAttribute("name", "delPaperList");
		el.setAttribute("value", id);
		inputCreateForm.appendChild(el);
		
		document.body.appendChild(inputCreateForm);
		
		inputCreateForm.submit();
	};
	
	function editPaperList(id, size, kind, gram) {
		$("#modal3").show();
		
		document.getElementById("paperListEditNo").value=id;
		document.getElementById("paperListEditSize").value=size;
		document.getElementById("paperListEditKind").value=kind;
		document.getElementById("paperListEditGram").value=gram;
	};
	
	function rentEditFun(no, date, size, kind, gram, count, rentpart, rentproject, rentname, lendpart, lendproject, lendname, note, state) {	
		$("#modal4").show();
		
		document.getElementById("rentNoEdit").value=no;
		document.getElementById("rentDateEdit").value=date;
		document.getElementById("rentSizeEdit").value=size;
		document.getElementById("rentKindEdit").value=kind;
		document.getElementById("rentGramEdit").value=gram;
		document.getElementById("rentBunoEdit").value=count;
		document.getElementById("rentPartEdit").value=rentpart;
		document.getElementById("rentProjectEdit").value=rentproject;
		document.getElementById("rentNameEdit").value=rentname;
		document.getElementById("lendPartEdit").value=lendpart;
		document.getElementById("lendProjectEdit").value=lendproject;
		document.getElementById("lendNameEdit").value=lendname;
		document.getElementById("rentNote").value=note;
		
		for (i=0; i<2; i++) {
		    if (document.getElementById("rentState").options[i].value == state) {
		        document.getElementById("rentState").options[i].selected = "selected";
		    }
		}
		
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
</body>
</html>