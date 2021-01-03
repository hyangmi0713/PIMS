<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

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

</head>


<body>
	<div class="col-sm-9">
		<div class="card card-signin-pw ">
			<div class="alert-text">
				<div class="card">
					<div class="card-body">
						<img src="images/title_01.png" >
						<form method="post" action="changePWAction.jsp">
							<div class="form-label-group">
								<input type="text" id="changePWuserID" name="changePWuserID" class="form-control"
									placeholder="아이디를 입력하세요" maxlength="20">
							</div>

							<div class="form-label-group">
								<input type="password" id="changePWuserPW" name="changePWuserPW" class="form-control"
									placeholder="기존비밀번호를 입력하세요" maxlength="20">
							</div>

							<div class="form-label-group">
								<input type="password" id="changePWnewPW1" name="changePWnewPW1" class="form-control"
									placeholder="신규비밀번호를 입력하세요" maxlength="20">
							</div>
							
							<div class="form-label-group">
								<input type="password" id="changePWnewPW2" name="changePWnewPW2" class="form-control"
									placeholder="신규비밀번호를 한번 더 입력하세요" maxlength="20">
							</div>

							<input type="submit" style="background-color:#db8e8c; color:#FFFFFF; font-size:10pt;"
								class="btn btn-lg btn-block text-uppercase"
								type="button" value="비밀번호 변경">
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript" src="js/loginjsp.js"></script>
</body>
</html>


