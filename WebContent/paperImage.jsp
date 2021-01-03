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
%>
<%
	int pageNumber = 0;
	/* Pm_inventoryDAO inventoryDAO = new Pm_inventoryDAO();
	ArrayList<Pm_inventory> getExpenditureDAO = inventoryDAO.allExpenditureList(1);
	ArrayList<Pm_inventory> getIncomeDAO = inventoryDAO.allExpenditureList(0);
	ArrayList<Pm_inventory> getRentDAO = inventoryDAO.rentExpenditureList(); */
	
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
	<nav class="navbar navbar-default" >
		<jsp:include page="navbar.jsp" flush="false" />
	</nav>
	<table style="margin-left: auto; margin-right: auto;">
		<tr>
			<td width="108" style="background-image: url('imageNew/home1_30.png'); background-repeat:repeat-y; " valign="top">
				<table>
					<tr>
						<td width="108" style="background-image: url('imageNew/home_22.png'); background-repeat:no-repeat; background-position: top right; padding-top:30px;">
							<table>
								<tr><td><a href="admin.jsp"><img src="imageNew/leftMenu_26.png" ></a></td></tr>
								<tr><td><a href="manageProject.jsp"><img src="imageNew/leftMenu_28.png" ></a></td></tr>
							</table>						
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
								<div class="memberAdd">
									<button type="button" class="btn btn-default pull-right" style="margin-right:4px; font-size:10pt;">회원추가</button>
								</div>
								<br>
								<table class="type10" style="font-size:10pt;">
									<thead>
										<tr>
											<th scope="cols" style="text-align:center;" width="50">No.</th>
											<th scope="cols" style="text-align:center;" width="250">아이디</th>
											<th scope="cols" style="text-align:center;">이름</th>
											<th scope="cols" style="text-align:center;">소속</th>
											<th scope="cols" style="text-align:center;">권한</th>
											<th scope="cols" style="text-align:center;" width="80">편집</th>
											<th scope="cols" style="text-align:center;" width="80">삭제</th>
										</tr>
									</thead>
									<tbody>
										<%
										int pageStartNumberMember = 0;
										int pageEndNumberMember = 0;
										
										if(pageNumber == 0) {
											pageStartNumberMember = 0;
											if (pageStartNumberMember+9 < getUserList.size()) {
												pageEndNumberMember = pageStartNumberMember+10;
											}
											else {
												pageEndNumberMember = getUserList.size();
											}
										}
										else {
											pageStartNumberMember = pageNumber*10;
											if (pageStartNumberMember+9 < getUserList.size()) {
												pageEndNumberMember = pageStartNumberMember+10;
											}
											else {
												pageEndNumberMember = getUserList.size();
											}
										}
										
										for(int i=pageStartNumberMember; i<pageEndNumberMember; i++) {
											if(i%2 != 0) {
										%>
											<tr class="first">
												<td style="padding-top:15px; text-align:center; "><%=i+1 %></td>
												<td style="padding-top:15px; text-align:center; "><%=getUserList.get(i).getUserID() %></td>
												<td style="padding-top:15px; text-align:center; "><%=getUserList.get(i).getUserName() %></td>
												<td style="padding-top:15px; text-align:center; "><%=getUserList.get(i).getUserPart() %></td>
												<td style="padding-top:15px; text-align:center; ">
												<%
												if(getUserList.get(i).getUserGrade().equals("1")) {
												%>
													일반사용자
												<%
												}
												%>
												<%
												if(getUserList.get(i).getUserGrade().equals("0")) {
												%>
													관리자
												<%
												}
												%>
												</td>
												<td style="text-align:center;">
													<div class="button"><button type="button" class="btn btn-default pull-right" id="editMember" name="editMember" 
														onclick="editMemberFun('<%=getUserList.get(i).getUserID() %>',
														'<%=getUserList.get(i).getUserPassword() %>',
														'<%=getUserList.get(i).getUserName() %>',
														'<%=getUserList.get(i).getUserPart() %>',
														'<%=getUserList.get(i).getUserGrade() %>')">편집</button></div>
												</td>
												<td style="text-align:center;">
													<div class="button"><button type="button" class="btn btn-default pull-right" id="selectDelID" name="selectDelID" 
														onclick="delMemberFun('<%=getUserList.get(i).getUserID() %>')">삭제</button></div>
												</td>
											</tr>
										<%
											}
											else {
										%>
											<tr class="first">
												<td class="even" style="padding-top:15px; text-align:center; "><%=i+1 %></td>
												<td class="even" style="padding-top:15px; text-align:center; "><%=getUserList.get(i).getUserID() %></td>
												<td class="even" style="padding-top:15px; text-align:center; "><%=getUserList.get(i).getUserName() %></td>
												<td class="even" style="padding-top:15px; text-align:center; "><%=getUserList.get(i).getUserPart() %></td>
												<td class="even" style="padding-top:15px; text-align:center; ">
												<%
												if(getUserList.get(i).getUserGrade().equals("1")) {
												%>
													일반사용자
												<%
												}
												%>
												<%
												if(getUserList.get(i).getUserGrade().equals("0")) {
												%>
													관리자
												<%
												}
												%>
												</td>
												<td class="even" style="text-align:center;">
													<div class="button"><button type="button" class="btn btn-default pull-right" id="editMember" name="editMember" 
														onclick="editMemberFun('<%=getUserList.get(i).getUserID() %>',
														'<%=getUserList.get(i).getUserPassword() %>',
														'<%=getUserList.get(i).getUserName() %>',
														'<%=getUserList.get(i).getUserPart() %>',
														'<%=getUserList.get(i).getUserGrade() %>')">편집</button></div>
												</td>
												<td class="even" style="text-align:center;">
													<div class="button"><button type="button" class="btn btn-default pull-right" id="selectDelID" name="selectDelID" 
														onclick="delMemberFun('<%=getUserList.get(i).getUserID() %>')">삭제</button></div>
												</td>
											</tr>
										<%
											}
										}
										%>
										<tr>
											<td colspan="7">
												<table style="margin-left: auto; margin-right: auto;">
													<tr>
														<td style="text-align: right; padding-right:15px;">
															<a href="javascript:void(0);" onClick="movePage('0'); return false;"><img src="images/preIcon.png"></a>
														</td>
														<td style="text-align: center; font-size:10pt;">
														<%
														if (getUserList.size()/10 < 10) {
															for (int j=0; j<(getUserList.size()/10)+1; j++) {
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
																if (pageNumber+6 > (getUserList.size()/10)) {
																	totalPageStartNum = pageNumber-(9-((getUserList.size()/10)-pageNumber));
																	totalPageEndNum = (getUserList.size()/10)+1;
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
															<a href="javascript:void(0);" onClick="movePage('<%=(getUserList.size()/10) %>'); return false;"><img src="images/nextIcon.png"></a>
														</td>
													</tr>
													<%pageNumber = 0; %>
												</table>
											</td>
										</tr>
									</tbody>
								</table>
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
						<br><span style="padding-left:10px; "><img src="images/title_04.png" ></span>
						<form name="ActionJoin" action="ActionJoin.jsp" method="POST" onSubmit="joinSubmit(); return false" >
							<table class="table">
								<tr>
									<td width="150px" style="padding-top:12px; font-size:10pt">아이디</td>
									<td style="text-align:left">
										<input type="text" class="form-control" id="userID" name="userID" onkeydown="checkID()" required>
										<p id="checkId" class="help-block" style="font-size:9pt;">ID를 영문 및 숫자로 입력해주세요.(최대 12자)</p>
									</td>
								</tr>
								<tr>
									<td style="padding-top:12px; font-size:10pt">비밀번호</td>
									<td style="padding-top:12px; text-align:left; font-size:10pt">1234</td>
								</tr>
								<tr>
									<td style="padding-top:12px; font-size:10pt">이름</td>
									<td><input type="text" class="form-control" id="userName" name="userName"></td>
								</tr>
								<tr>
									<td style="padding-top:12px; font-size:10pt">소속</td>
									<td>
										<select class="form-control" id="userPart" name="userPart">
											<%
											for(int i=0; i<getPartList.size(); i++) {
											%>
												<option value="<%=getPartList.get(i).getPartName()%>"><%=getPartList.get(i).getPartName()%></option>
											<%
											}
											%>
										</select>
									</td>
								</tr>
								<tr>
									<td style="padding-top:12px; font-size:10pt">등급</td>
									<td>
										<select class="form-control" id="userGrade" name="userGrade" >
											<option value="0" >관리자</option>
											<option value="1">일반사용자</option>
										</select>
									</td>
								</tr>
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
						<br><span style="padding-left:10px; "><img src="images/title_03.png" ></span>
						<form name="ActionEditMember" action="ActionEditMember.jsp" method="POST" onSubmit="editMemberSubmit(); return false" >
							<table class="table">
								<tr>
									<td width="150px" style="padding-top:12px; font-size:10pt;">아이디</td>
									<td style="text-align:left; padding-top:12px;">
										<span id="editMemberSpanID"></span>
										<input type="hidden" id="userEditID" name="userEditID">
										<p id="checkId" class="help-block" style="font-size:9pt;">ID는 변경할 수 없습니다.</p>
									</td>
								</tr>
								<tr>
									<td style="padding-top:12px; font-size:10pt;">비밀번호</td>
									<td style="padding-top:12px; text-align:left">
										<input type="password" class="form-control" id="userEditPW" name="userEditPW" >
									</td>
								</tr>
								<tr>
									<td style="padding-top:12px; font-size:10pt;">이름</td>
									<td><input type="text" class="form-control" id="userEditName" name="userEditName"></td>
								</tr>
								<tr>
									<td style="padding-top:12px; font-size:10pt;">소속</td>
									<td>
										<select class="form-control" id="userEditPart" name="userEditPart">
											<%
											for(int i=0; i<getPartList.size(); i++) {
											%>
												<option value="<%=getPartList.get(i).getPartName()%>"><%=getPartList.get(i).getPartName()%></option>
											<%
											}
											%>
										</select>
									</td>
								</tr>
								<tr>
									<td style="padding-top:12px; font-size:10pt;">등급</td>
									<td>
										<select class="form-control" id="userEditGrade" name="userEditGrade">
											<option value="0">관리자</option>
											<option value="1">일반사용자</option>
										</select>
									</td>
								</tr>
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
	    f.action = "./admin.jsp"
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