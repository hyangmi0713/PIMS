<%@page buffer="100kb"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="user.User"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.net.URLEncoder"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="changePWuserID" />
<jsp:setProperty name="user" property="changePWuserPW" />
<jsp:setProperty name="user" property="changePWnewPW1" />
<jsp:setProperty name="user" property="changePWnewPW2" />

<!DOCTYPE html>
<html>

<head>

</head>


<body>
	<%
	if (user.getChangePWuserID()==null || user.getChangePWuserPW()==null || user.getChangePWnewPW1()==null || user.getChangePWnewPW2()==null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력값을 모두 입력하세요.')");
		script.println("history.back()");
		script.println("</script>");
	}
	else {
		UserDAO userDAO = new UserDAO();
		
		int resultConfirmPW = userDAO.login(user.getChangePWuserID(), user.getChangePWuserPW());
		
		if (resultConfirmPW == 1) {
			if (user.getChangePWnewPW1().equals(user.getChangePWnewPW2())) {
				int resultChangePW = userDAO.changepw(user.getChangePWuserID(), user.getChangePWnewPW1());
				
				if (resultChangePW == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('DB ERROR')");
					script.println("history.back()");
					script.println("</script>");
				}
				else if (resultChangePW == 1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('수정이 완료되었습니다.')");
					script.println("window.opener.location.reload();");
					script.println("window.close()");
					script.println("</script>");
				}
				else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('수정중 에러가 발생하였습니다.\n관리자에게 문의해주세요.')");
					script.println("window.opener.location.reload();");
					script.println("window.close()");
					script.println("</script>");
				}
			}
			else {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('신규 비빌번호와 비밀번호 확인 입력값이 일치하지 않습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
			
		}
		else if (resultConfirmPW == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('기존 비밀번호가 올바르지 않습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else if (resultConfirmPW == -1)
		{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('아이디가 올바르지 않습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else if (resultConfirmPW == -2)
		{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('데이터 베이스 오류')");
			script.println("history.back()");
			script.println("</script>");
		}
		
	}
%>
</body>
</html>


