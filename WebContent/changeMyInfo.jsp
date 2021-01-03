<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="part.PartDAO"%>
<%@ page import="part.Part"%>
<%@ page import="user.User" %>
<%@ page import="user.UserDAO" %>
<%
	PartDAO partListDAO = new PartDAO();
	ArrayList<Part> getPartList = partListDAO.allPartList();
	
	String userID = request.getParameter("userID");
	
	UserDAO userListDAO = new UserDAO();	
	String getUserPart = userListDAO.finduserpart(userID);
	String getUserName = userListDAO.findusername(userID);
	int getUserGrage = userListDAO.findusergrade(userID);
	String getUserPW = userListDAO.findpw(userID, getUserName, getUserPart);
%>

<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<title>Paper Inventory Management System</title>

<link href="css/login.css" rel="stylesheet" type="text/css" media="all" />
<link href="css/bootstrap_index.min.css" rel="stylesheet" type="text/css" media="all" />
<link href="css_hyang/bootstrap.min.css" rel="stylesheet" type="text/css" media="all">

<style type="text/css">
	input::placeholder {
	  font-size:10pt;
	}
</style>
</head>


<body>
	<div class="col-sm-9">
		<div class="card card-signin-pw ">
			<div class="alert-text">
				<div class="card">
					<div class="card-body">
						<img src="images/title_03.png" >
						<form name="ActionEditMember" action="ActionEditMemberNavbar.jsp" method="POST" >
							<table class="table">
								<tr>
									<td width="150px" style="padding-top:12px;">아이디</td>
									<td style="text-align:left; padding-top:12px;">
										<%=userID %>
										<input type="hidden" id="userEditID" name="userEditID" value="<%=userID%>">
										<p id="checkId" class="help-block" style="font-size:9pt;">ID는 변경할 수 없습니다.</p>
									</td>
								</tr>
								<tr>
									<td style="padding-top:12px;">비밀번호</td>
									<td style="padding-top:12px; text-align:left">
										<input type="password" class="form-control" id="userEditPW" name="userEditPW" value="<%=getUserPW%>" >
									</td>
								</tr>
								<tr>
									<td style="padding-top:12px;">이름</td>
									<td><input type="text" class="form-control" id="userEditName" name="userEditName" value="<%=getUserName%>" ></td>
								</tr>
								<tr>
									<td style="padding-top:12px;">소속</td>
									<td>
										<select class="form-control" id="userEditPart" name="userEditPart">
											<%
											for(int i=0; i<getPartList.size(); i++) {
												if(getUserPart.equals(getPartList.get(i).getPartName())) {
											%>
													<option selected value="<%=getPartList.get(i).getPartName()%>"><%=getPartList.get(i).getPartName()%></option>
											<%
												}
												else {
											%>
													<option value="<%=getPartList.get(i).getPartName()%>"><%=getPartList.get(i).getPartName()%></option>
											<%
												}
											}
											%>
										</select>
									</td>
								</tr>
								<tr>
									<td style="padding-top:12px;"></td>
									<td>
										<select  style="display:none" class="form-control" id="userEditGrade" name="userEditGrade">
											<%
											if(getUserGrage==0) {
											%>
												<option selected value="0">관리자</option>
												<option value="1">일반사용자</option>
											<%
											}
											else {
											%>
												<option value="0">관리자</option>
												<option selected value="1">일반사용자</option>
											<%
											}
											%>
										</select>
									</td>
								</tr>
							</table>
							
							<table>
								<tr>
									<td width="310"></td>
									<td>
										<input type="submit" style="background-color:#db8e8c; color:#FFFFFF; font-size:11pt;"
										class="btn btn-lg btn-block text-uppercase"
										type="button" value="확인">
									</td>
									<td width="5"></td>
									<td>
										<input type="button" style="background-color:#db8e8c; color:#FFFFFF; font-size:11pt;"
										class="btn btn-lg btn-block text-uppercase"
										type="button" value="취소" onClick="window.close()" >									
									</td>
								</tr>
							</table>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript" src="js/loginjsp.js"></script>
</body>
</html>


