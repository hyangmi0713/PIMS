<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" charset="utf-8">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<title>Canon 용지 재고 관리 프로그램</title>
<link href="css_hyang/bootstrap.min.css" rel="stylesheet" type="text/css" media="all">
<link href="css_hyang/index.css" rel="stylesheet" type="text/css" media="all">
</head>

<body>
	<div class="register-card">
		<form method="post" action="loginAction.jsp">
			<div style="padding-top: 250px; padding-left: 307px;">
				<table>
					<tr>
						<td width="28px;" style="margin:0; padding:0">
							<img src="imageNew\index_06.png" style="float: left;"></img>							
						</td>
						<td style="padding-top: 17px;">
							<input
							type="text" id="userID" class="form-control"
							placeholder="아이디를 입력하세요" name="userID" maxlength="20"
							onkeydown="checkID(this)" style="border: none; background: transparent;">
						</td>
					</tr>
					<tr>
						<td colspan="2" style="background-color: #515151" height="1px"></td>
					</tr>
					<tr>
						<td>
							<img src="imageNew\index_09.png" style="float: left;"></img>							
						</td>
						<td style="padding-top: 17px;">
							<input
							type="password" id="userPassword"
							class="form-control" placeholder="비밀번호를 입력하세요"
							name="userPassword" maxlength="20" style="border: none; background: transparent;">
						</td>
					</tr>
					<tr>
						<td colspan="2" style="background-color: #515151" height="1px"></td>
					</tr>
					<tr>
						<td colspan="2" style="padding-top: 15px;">
							<table>
								<tr>
									<td>
										<a class="forgot-password"
											href="javascript:void(window.open('findPW.jsp', 'Find Password','width=500, height=275'))">
											<img src="imageNew\index_15.png">
										</a>
									</td>
									<td style="padding-right:118px;">
										<a class="forgot-password"
											href="javascript:void(window.open('changePW.jsp', 'Find Password','width=500, height=300'))">
											<img src="imageNew\index_16.png">
										</a>
									</td>
									<td>
										<input name="Submit" align="absmiddle" type="IMAGE"
										src="imageNew\index_18.png" value="로그인">
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</div>
		</form>
	</div>
</body>
</html>