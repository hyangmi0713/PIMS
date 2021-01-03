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
								<th scope="cols" style="text-align:center;" width="50">No.</th>
								<th scope="cols" style="text-align:center;">날짜</th>
								<th scope="cols" style="text-align:center;">사이즈</th>
								<th scope="cols" style="text-align:center;">용지 종류</th>
								<th scope="cols" style="text-align:center;">평량(m/g)</th>									
								<th scope="cols" style="text-align:center;">용지이름</th>
								<th scope="cols" style="text-align:center;">출고 수량</th>
								<th scope="cols" style="text-align:center;">프로젝트</th>
								<th scope="cols" style="text-align:center;">출고자 소속</th>
								<th scope="cols" style="text-align:center;">이름</th>
								<th scope="cols" style="text-align:center;">비고</th>
								<!-- <th scope="cols" style="text-align:center;" width="80">편집</th> -->
							</tr>
						</thead>
						<tbody>
							<%
							int pageStartNumber = 0;
							int pageEndNumber = 0;
							
							if(pageNumber == 0) {
								pageStartNumber = 0;
								if (pageStartNumber+9 < getExpenditureDAO.size()) {
									pageEndNumber = pageStartNumber+10;
								}
								else {
									pageEndNumber = getExpenditureDAO.size();
								}
							}
							else {
								pageStartNumber = pageNumber*10;
								if (pageStartNumber+9 < getExpenditureDAO.size()) {
									pageEndNumber = pageStartNumber+10;
								}
								else {
									pageEndNumber = getExpenditureDAO.size();
								}
							}
							
							for(int i=pageStartNumber; i<pageEndNumber; i++) {
								if(i%2 != 0) {
							%>
								<tr class="first">
									<td style="padding-top:15px; text-align:center; "><%=i+1 %></td>
									<td style="padding-top:15px; text-align:center; "><%=getExpenditureDAO.get(i).getPaper_inv_date() %></td>
									<td style="padding-top:15px; text-align:center; "><%=getExpenditureDAO.get(i).getPaper_inv_size() %></td>
									<td style="padding-top:15px; text-align:center; "><%=getExpenditureDAO.get(i).getPaper_inv_kind() %></td>
									<%
									if(!getExpenditureDAO.get(i).getPaper_inv_gram().equals("-")) {
									%>
									<td style="padding-top:15px; text-align:center; "><%=getExpenditureDAO.get(i).getPaper_inv_gram() %> m/g</td>
									<%
									}
									else {
									%>
									<td style="padding-top:15px; text-align:center; ">-</td>
									<%
									}
									%>
									<td style="padding-top:15px; text-align:center; "><%=getExpenditureDAO.get(i).getPaper_inv_name() %></td>
									<td style="padding-top:15px; text-align:center; "><%=getExpenditureDAO.get(i).getPaper_inv_quantity() %> Pack</td>
									<td style="padding-top:15px; text-align:center; "><%=getExpenditureDAO.get(i).getPaper_project() %></td>
									<td style="padding-top:15px; text-align:center; "><%=getExpenditureDAO.get(i).getMem_no() %></td>
									<td style="padding-top:15px; text-align:center; "><%=getExpenditureDAO.get(i).getMen_derpartment() %></td>
									<td style="padding-top:15px; text-align:center; "><%=getExpenditureDAO.get(i).getPaper_inv_note() %></td>
									<!-- <td><button type="button" class="btn btn-default pull-right" id="editMember" name="editMember" 
											onclick="">편집</button></td> -->
								</tr>
							<%
								}
								else {
							%>
								<tr class="first">
									<td class="even"  style="padding-top:15px; text-align:center; "><%=i+1 %></td>
									<td class="even"  style="padding-top:15px; text-align:center; "><%=getExpenditureDAO.get(i).getPaper_inv_date() %></td>
									<td class="even"  style="padding-top:15px; text-align:center; "><%=getExpenditureDAO.get(i).getPaper_inv_size() %></td>
									<td class="even"  style="padding-top:15px; text-align:center; "><%=getExpenditureDAO.get(i).getPaper_inv_kind() %></td>
									<%
									if(!getExpenditureDAO.get(i).getPaper_inv_gram().equals("-")) {
									%>
									<td class="even"  style="padding-top:15px; text-align:center; "><%=getExpenditureDAO.get(i).getPaper_inv_gram() %> m/g</td>
									<%
									}
									else {
									%>
									<td class="even"  style="padding-top:15px; text-align:center; ">-</td>
									<%
									}
									%>
									<td class="even"  style="padding-top:15px; text-align:center; "><%=getExpenditureDAO.get(i).getPaper_inv_name() %></td>
									<td class="even"  style="padding-top:15px; text-align:center; "><%=getExpenditureDAO.get(i).getPaper_inv_quantity() %> Pack</td>
									<td class="even"  style="padding-top:15px; text-align:center; "><%=getExpenditureDAO.get(i).getPaper_project() %></td>
									<td class="even"  style="padding-top:15px; text-align:center; "><%=getExpenditureDAO.get(i).getMem_no() %></td>
									<td class="even"  style="padding-top:15px; text-align:center; "><%=getExpenditureDAO.get(i).getMen_derpartment() %></td>
									<td class="even"  style="padding-top:15px; text-align:center; "><%=getExpenditureDAO.get(i).getPaper_inv_note() %></td>
									<!-- <td class="even" ><button type="button" class="btn btn-default pull-right" id="editMember" name="editMember" 
											onclick="">편집</button></td> -->
								</tr>
							<%
								}
							}
							%>
							<tr>
								<td colspan="11">
									<table style="margin-left: auto; margin-right: auto;">
										<tr>
											<td style="text-align: right; padding-right:15px;">
												<a href="javascript:void(0);" onClick="movePage('0'); return false;"><img src="images/preIcon.png"></a>
											</td>
											<td style="text-align: center;">
											<%
											if (getExpenditureDAO.size()/10 < 10) {
												for (int j=0; j<(getExpenditureDAO.size()/10+1); j++) {
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
													if (pageNumber+6 > (getExpenditureDAO.size()/10)) {
														totalPageStartNum = pageNumber-(9-((getExpenditureDAO.size()/10)-pageNumber));
														totalPageEndNum = (getExpenditureDAO.size()/10)+1;
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
												<a href="javascript:void(0);" onClick="movePage('<%=(getExpenditureDAO.size()/10) %>'); return false;"><img src="images/nextIcon.png"></a>
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

<div id="modal" class="searchModal">
	<div class="search-modal-content">
		<form name="ActionJoin" action="ActionJoin.jsp" method="POST" onSubmit="joinSubmit(); return false" >
		<div>
			<div onClick="closeModal();">
				<br>
				<button type="button" class="close" data-dismiss="modal">
					<span aria-hidden="true">&times;</span> 
				</button>
			</div>
			<h4 class="modal-title" id="=modal3label">
				<img src="images/membership_add.png" width="30">&nbsp;&nbsp;회원 추가
			</h4>
		</div>
		<div class="modal-body">
			<p>추가할 회원 정보를 입력해주세요</p>
			<table class="table">
				<tr>
					<td width="150px" style="padding-top:12px;">아이디</td>
					<td style="text-align:left">
						<input type="text" class="form-control" id="userID" name="userID" onkeydown="checkID()" required>
						<p id="checkId" class="help-block" style="font-size:9pt;">ID를 영문 및 숫자로 입력해주세요.(최대 12자)</p>
					</td>
				</tr>
				<tr>
					<td style="padding-top:12px;">비밀번호</td>
					<td style="padding-top:12px; text-align:left">1234</td>
				</tr>
				<tr>
					<td style="padding-top:12px;">이름</td>
					<td><input type="text" class="form-control" id="userName" name="userName"></td>
				</tr>
				<tr>
					<td style="padding-top:12px;">소속</td>
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
					<td style="padding-top:12px;">등급</td>
					<td>
						<select class="form-control" id="userGrade" name="userGrade">
							<option value="0">관리자</option>
							<option value="1">일반사용자</option>
						</select>
					</td>
				</tr>
			</table>
		</div>
		<div class="modal-footer">
			<button type="submit" class="btn btn-default" data-dismiss="modal">확인</button>
			<button type="button" class="btn btn-default" data-dismiss="modal" onClick="closeModal();">취소</button>
		</div>
		</form>
	</div>
</div>

<%-- <div id="modal1" class="searchModal">
	<div class="search-modal-content">
		<form name="ActionEditPart" action="ActionEditPart.jsp" method="POST" onSubmit="editPartSubmit(); return false" >
		<div>
			<div onClick="closeModal();">
				<br>
				<button type="button" class="close" data-dismiss="modal">
					<span aria-hidden="true">&times;</span> 
				</button>
			</div>
			<h4 class="modal-title" id="=modal3label">
				<img src="images/membership_add.png" width="30">&nbsp;&nbsp;소속 관리
			</h4>
		</div>
		<div class="modal-body">
			<p>회원의 소속을 관리합니다</p>
			<table class="table">
				<tr>
					<td width="50px" style="padding-top:12px;">No.</td>
					<td style="text-align:left; padding-top:12px;">소속명</td>
					<td style="text-align:right; padding-top:12px;" width="90">삭제</td>
				</tr>
				<%
				for(int i=0; i<5; i++) {
				%>
				<tr>
					<td style="padding-top:12px;"><%=i+1 %></td>
					<td style="padding-top:12px; text-align:left">
						<input type="hidden" value="<%=getPartList.get(i).getPartNo() %>" id="editPartNo<%=i%>" name="editPartNo<%=i%>">
						<input type="text" value="<%=getPartList.get(i).getPartName() %>" class="form-control" width="70%" id="editPartName<%=i%>" name="editPartName<%=i%>">
					</td>
					<td style="padding-top:15px; text-align:right; font-size:9pt;">삭제불가</td>
				</tr>
				<%
				}
				%>
				<%
				for(int i=5; i<getPartList.size(); i++) {
				%>
				<tr>
					<td style="padding-top:12px;"><%=i+1 %></td>
					<td style="padding-top:12px; text-align:left">
						<input type="hidden" value="<%=getPartList.get(i).getPartNo() %>" id="editPartNo<%=i%>" name="editPartNo<%=i%>">
						<input type="text" value="<%=getPartList.get(i).getPartName() %>" class="form-control" width="70%" id="editPartName<%=i%>" name="editPartName<%=i%>">
					</td>
					<td style="padding-top:15px; text-align:right;"><input type="checkbox" name="partDel" id="partDel" style="padding-left:3px; width:20px; height:20px;" 
						value="<%=getPartList.get(i).getPartNo() %>" ></td>
				</tr>
				<%
				}
				%>
				<tr>
					<td colspan="3"><input type="text" name="partName" id="partName" class="form-control"></td>
				</tr>
			</table>
		</div>
		<div class="modal-footer">
			<button type="submit" class="btn btn-default" data-dismiss="modal">확인</button>
			<button type="button" class="btn btn-default" data-dismiss="modal" onClick="closeModal();">취소</button>
		</div>
		<input type="hidden" value="<%=getPartList.size() %>" id="getPartListNum" name="getPartListNum">
		</form>
	</div>
</div> --%>

<div id="modal2" class="searchModal">
	<div class="search-modal-content">
		<form name="ActionEditMember" action="ActionEditMember.jsp" method="POST" onSubmit="editMemberSubmit(); return false" >
		<div>
			<div onClick="closeModal();">
				<br>
				<button type="button" class="close" data-dismiss="modal">
					<span aria-hidden="true">&times;</span> 
				</button>
			</div>
			<h4 class="modal-title" id="=modal3label">
				<img src="images/membership_add.png" width="30">&nbsp;&nbsp;회원 정보 수정
			</h4>
		</div>
		<div class="modal-body">
			<p>수정할 회원 정보를 입력해주세요</p>
			<table class="table">
				<tr>
					<td width="150px" style="padding-top:12px;">아이디</td>
					<td style="text-align:left; padding-top:12px;">
						<span id="editMemberSpanID"></span>
						<input type="hidden" id="userEditID" name="userEditID">
						<p id="checkId" class="help-block" style="font-size:9pt;">ID는 변경할 수 없습니다.</p>
					</td>
				</tr>
				<tr>
					<td style="padding-top:12px;">비밀번호</td>
					<td style="padding-top:12px; text-align:left">
						<input type="password" class="form-control" id="userEditPW" name="userEditPW" >
					</td>
				</tr>
				<tr>
					<td style="padding-top:12px;">이름</td>
					<td><input type="text" class="form-control" id="userEditName" name="userEditName"></td>
				</tr>
				<tr>
					<td style="padding-top:12px;">소속</td>
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
					<td style="padding-top:12px;">등급</td>
					<td>
						<select class="form-control" id="userEditGrade" name="userEditGrade">
							<option value="0">관리자</option>
							<option value="1">일반사용자</option>
						</select>
					</td>
				</tr>
			</table>
		</div>
		<div class="modal-footer">
			<button type="submit" class="btn btn-default" data-dismiss="modal">확인</button>
			<button type="button" class="btn btn-default" data-dismiss="modal" onClick="closeModal();">취소</button>
		</div>
		</form>
	</div>
</div>

<div id="modal3" class="searchModal">
	<div class="search-modal-content">
		<form name="ActionEditPaperList" action="ActionEditPaperList.jsp" method="POST" onSubmit="editPaperListSubmit(); return false" >
		<div>
			<div onClick="closeModal();">
				<br>
				<button type="button" class="close" data-dismiss="modal">
					<span aria-hidden="true">&times;</span> 
				</button>
			</div>
			<h4 class="modal-title" id="=modal3label">
				<img src="images/membership_add.png" width="30">&nbsp;&nbsp;용지 종류 수정
			</h4>
		</div>
		<div class="modal-body">
			<p>수정할 용지 종류의 정보를 입력해주세요</p>
			<table class="table">
				<tr>
					<td width="150px" style="padding-top:12px;">사이즈</td>
					<td style="text-align:left; padding-top:12px;">
						<input type="hidden" id="paperListEditNo" name="paperListEditNo" >
						<input type="text" class="form-control" id="paperListEditSize" name="paperListEditSize" >
					</td>
				</tr>
				<tr>
					<td style="padding-top:12px;">용지종류</td>
					<td style="padding-top:12px; text-align:left">
						<input type="text" class="form-control" id="paperListEditKind" name="paperListEditKind" >
					</td>
				</tr>
				<tr>
					<td style="padding-top:12px;">평량</td>
					<td style="text-align:left">
						<input type="text" class="form-control" id="paperListEditGram" name="paperListEditGram" onkeypress="return checkNum(event, 'numbers');" onkeydown="checkNum2(this);">
						<p id="checkId" class="help-block" style="font-size:9pt;">평량은 숫자만 입력하세요.</p>
					</td>
				</tr>
			</table>
		</div>
		<div class="modal-footer">
			<button type="submit" class="btn btn-default" data-dismiss="modal">확인</button>
			<button type="button" class="btn btn-default" data-dismiss="modal" onClick="closeModal();">취소</button>
		</div>
		</form>
	</div>
</div>

<div id="modal4" class="searchModal">
	<div class="search-modal-content">
		<form name="ActionAddPaperList" action="ActionAddPaperList.jsp" method="POST" onSubmit="addPaperListSubmit(); return false" >
		<div>
			<div onClick="closeModal();">
				<br>
				<button type="button" class="close" data-dismiss="modal">
					<span aria-hidden="true">&times;</span> 
				</button>
			</div>
			<h4 class="modal-title" id="=modal3label">
				<img src="images/membership_add.png" width="30">&nbsp;&nbsp;용지 종류 추가
			</h4>
		</div>
		<div class="modal-body">
			<p>추가할 용지 종류의 정보를 입력해주세요. 추가된 용지의 부서별 재고는 모두 0으로 설정됩니다.</p>
			<table class="table">
				<tr>
					<td width="150px" style="padding-top:12px;">사이즈</td>
					<td style="text-align:left; padding-top:12px;">
						<input type="text" class="form-control" id="paperListEditSize" name="paperListEditSize" >
					</td>
				</tr>
				<tr>
					<td style="padding-top:12px;">용지종류</td>
					<td style="padding-top:12px; text-align:left">
						<input type="text" class="form-control" id="paperListEditKind" name="paperListEditKind" >
					</td>
				</tr>
				<tr>
					<td style="padding-top:12px;">평량</td>
					<td style="text-align:left;">
						<input type="text" class="form-control" id="paperListEditGram" name="paperListEditGram" onkeypress="return checkNum(event, 'numbers');" onkeydown="checkNum2(this);">
						<p id="checkId" class="help-block" style="font-size:9pt;">평량은 숫자만 입력하세요.</p>
					</td>
				</tr>
			</table>
		</div>
		<div class="modal-footer">
			<button type="submit" class="btn btn-default" data-dismiss="modal">확인</button>
			<button type="button" class="btn btn-default" data-dismiss="modal" onClick="closeModal();">취소</button>
		</div>
		</form>
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
	    f.action = "./recordExpenditure.jsp"
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