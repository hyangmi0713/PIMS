<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!doctype html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	
	<title>Canon 용지 재고 관리 프로그램</title>
	
	<link href="css/login.css" rel="stylesheet" type="text/css" media="all" />
	<link href="css/bootstrap_index.min.css" rel="stylesheet" type="text/css" media="all" />
	
	<style type="text/css">
		a:link {
			color: #666666;
			text-decoration: none;
		}
		
		a:visited {
			color: #666666;
			text-decoration: none;
		}
		
		a:hover {
			color: #0f0f0f;
			text-decoration: none;
		}
	</style>
</head>


<body>
	<div class="container">
		<div class="row">
			<div class="col-sm-9 col-md-7 col-lg-5 mx-auto">
				<div class="card card-signin my-5">
					<div class="alert-text">
						<div class="label">
							<div class="label-item1">
								<label for="1"> Paper Inventory Management System</label>
							</div>
						</div>
						<div class="card">
							<div class="card-body">
								<h5 class="card-title text-center">Login to PIMS</h5>
								<form method="post" action="loginAction.jsp">
									<div class="form-label-group">
										<input type="text" id="userID" class="form-control" placeholder="아이디를 입력하세요" name="userID"  maxlength="20" onkeydown="checkID(this)" > 
									</div>

									<div class="form-label-group">
										<input type="password" id="userPassword" class="form-control" placeholder="비밀번호를 입력하세요" name="userPassword" maxlength="20"> 
									</div>

									<div class="custom-control custom-checkbox mb-3">
										<a href="#" onClick="window.open('changePW.jsp','비밀번호 찾기','width=500, height=360, toolbar=no, menubar=no, scrollbars=no, resizable=yes');return false;" class="forgot-password float-right">비밀번호변경</a>
										<a href="#" onClick="window.open('findPW.jsp','비밀번호 찾기','width=500, height=320, toolbar=no, menubar=no, scrollbars=no, resizable=yes');return false;" class="forgot-password float-right">비밀번호찾기&nbsp;/&nbsp;</a>
									</div>

									<input type="submit" class="btn btn-lg btn-danger btn-block text-uppercase" type="button" value="로그인" >

									<img src="images/canon.png" alt="My Image" width="90" style="padding-top: 20px;">

								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript" src="js/loginjsp.js"></script>
	<script type="text/javascript">
	function checkID(obj) {
		if (event.keyCode==8 || event.keyCode==9 || event.keyCode==37 || event.keyCode==39 || event.keyCode==46) {
			return;
		}
		obj.value=obj.value.replace(/[^a-z0-9]/gi,'');
		
	}
	</script> 
</body>
</html>


