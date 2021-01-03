<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="part.PartDAO"%>
<%@ page import="part.Part"%>
<%
	PartDAO partListDAO = new PartDAO();
	ArrayList<Part> getPartList = partListDAO.allPartList();
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
						<img src="images/title_01.png" >
						<form method="post" action="findPWAction.jsp">
							<div class="form-label-group">
								<input type="text" id="findPWuserID" name="findPWuserID" class="form-control"
									placeholder="아이디를 입력하세요" maxlength="20">
							</div>

							<div class="form-label-group">
								<input type="text" id="findPWuserName" name="findPWuserName" class="form-control"
									placeholder="이름을 입력하세요" maxlength="20">
							</div>

							<div class="form-label-group">
								<select id="findPWuserPart" name="findPWuserPart" class="form-control">
									<%
									for(int i=0; i<getPartList.size(); i++) {
									%>
										<option value="<%=getPartList.get(i).getPartName()%>"><%=getPartList.get(i).getPartName()%></option>
									<%
									}
									%>
								</select>
							</div>

							<input type="submit" style="background-color:#db8e8c; color:#FFFFFF; font-size:11pt;"
								class="btn btn-lg btn-block text-uppercase"
								type="button" value="비밀번호 찾기">
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript" src="js/loginjsp.js"></script>
</body>
</html>


