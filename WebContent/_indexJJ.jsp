<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" charset="utf-8">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<title>Canon 용지 재고 관리 프로그램</title>

<!-- Style-CSS -->
<link href="css_index/bootstrap.min.css" rel="stylesheet" type="text/css" media="all">
<link href="css_index/login_register.css" rel="stylesheet" type="text/css" media="all">

</head>
<body>
	<nav class="navbar navbar-ct-transparent navbar-fixed-top" id="register-navbar" role="navigation-demo">
		<div class="container">
			<!-- Brand and toggle get grouped for better mobile display -->
			<div class="navbar-header"></div>

		</div>
	</nav>

	<div class="wrapper">
		<div class="register-background">
			<!-- ê³µì§ì¬í­ -->
			<div class="container">
				<div class="row" style="padding-top: 0px;">
					<div class="col-md-4 col-md-offset-4 col-sm-6 col-sm-offset-3 col-xs-10 col-xs-offset-1 ">
						<div class="register-card">
							<form method="post" action="loginAction.jsp" style="padding-left: 232px;">

								<div class="form-label-group" style="padding-top: 250px;">
									<img src="imageNew\index_06.png" style="float: left;"></img> <input
										type="text" id="userID" class="form-control"
										placeholder="아이디를 입력하세요" name="userID" maxlength="20"
										onkeydown="checkID(this)">
								</div>
								<img src="imageNew\index_11.png"></img>

								<div class="form-label-group"
									style="float: left; padding-top: 5px;">
									<img src="imageNew\index_09.png" style="float: left;"></img> <input
										style="float: left;" type="password" id="userPassword"
										class="form-control" placeholder="비밀번호를 입력하세요"
										name="userPassword" maxlength="20">
								</div>
								<img src="imageNew\index_11.png"></img>
								
								<div class="button_grp">
									<a class="forgot-password"
										href="javascript:void(window.open('findPW.jsp', 'Find Password','width=500, height=320'))">
										<img src="imageNew\index_15.png">
									</a> <a class="forgot-password"
										href="javascript:void(window.open('changePW.jsp', 'Find Password','width=500, height=360'))">
										<img src="imageNew\index_16.png">
									</a> <input name="Submit" align="absmiddle" type="IMAGE"
										src="imageNew\index_18.png" value="로그인">
								</div>
							</form>
							<!-- ID/ PW ìë ¥  -->
							<!-- <form class="form-horizontal"  action="loginAction.jsp" method="POST">                                
                                <input name="menId" class="inputid" id="menId" autofocus="" type="text" placeholder="ID" value="" maxlength="8"
                                	onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" />
                                <input name="menPw" class="inputpw" id="menPw" type="password" placeholder="Password" maxlength="20">
                                <input TYPE="IMAGE" src="imageNew\main_12.png" name="Submit" value="Submit"  align="absmiddle">
                            </form> -->
						</div>

						<!-- find password ë¶ë¶ -->
						<!-- <div class="havelogin" style="padding-left:250px">
                            <a class="btn btn-simple btn-mainbtn" href="javascript:void(window.open('findpw.jsp', 'Find Password','width=450, height=290'))">
                            	<img src="imageNew\main_17.png">
                            </a>
                        </div>

                        <div class="copyright" style="padding-top:1em;">
                            <img src="imageNew\main_23.png"></img>
                        </div> -->
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>