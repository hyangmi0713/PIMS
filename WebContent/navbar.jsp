<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.*, java.text.*"  %>
<%@ page import="user.User" %>
<%@ page import="user.UserDAO" %>
<%
	String menId = null;
	
	if(session.getAttribute("menId") != null) {
		menId = (String) session.getAttribute("menId");
	}

	UserDAO userListDAO = new UserDAO();
	String getUserPart = userListDAO.finduserpart(menId);
	String getUserName = userListDAO.findusername(menId);
	int getUserGrage = userListDAO.findusergrade(menId);
	
	if(getUserGrage==-1 || getUserGrage==-2) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('에러가 발생하였습니다.\n관리자에게 문의하세요.')");
		script.println("history.back()");
		script.println("</script>");
	}
%>
<%
	// 현재 URL 갖고오기
	String pageURL = request.getRequestURL().toString();
	String target = "PIMS/";
	int target_num = pageURL.indexOf(target);
	String resultURL = pageURL.substring(target_num+5, (pageURL.substring(target_num).indexOf(".jsp")+target_num));
%>

<style>
a#subMenu01 {
    display:inline-block;
    width:94px;
    height:75px;
    background:url("images/menu_07.png") no-repeat;
}

a#subMenu01:hover{
    background:url("images/menuOver_07.png") no-repeat;
}

a#subMenu01Select {
    display:inline-block;
    width:94px;
    height:75px;
    background:url("images/menuOver_07.png") no-repeat;
}

a#subMenu01Select:hover{
    background:url("images/menuOver_07.png") no-repeat;
}
a#subMenu02 {
    display:inline-block;
    width:94px;
    height:75px;
    background:url("images/menu_08.png") no-repeat;
}

a#subMenu02:hover{
    background:url("images/menuOver_08.png") no-repeat;
}

a#subMenu02Select {
    display:inline-block;
    width:94px;
    height:75px;
    background:url("images/menuOver_08.png") no-repeat;
}

a#subMenu02Select:hover{
    background:url("images/menuOver_08.png") no-repeat;
}
a#subMenu03 {
    display:inline-block;
    width:94px;
    height:75px;
    background:url("images/menu_09.png") no-repeat;
}

a#subMenu03:hover{
    background:url("images/menuOver_09.png") no-repeat;
}

a#subMenu03Select {
    display:inline-block;
    width:94px;
    height:75px;
    background:url("images/menuOver_09.png") no-repeat;
}

a#subMenu03Select:hover{
    background:url("images/menuOver_09.png") no-repeat;
}
a#subMenu04 {
    display:inline-block;
    width:94px;
    height:75px;
    background:url("images/menu_10.png") no-repeat;
}

a#subMenu04:hover{
    background:url("images/menuOver_10.png") no-repeat;
}

a#subMenu04Select {
    display:inline-block;
    width:94px;
    height:75px;
    background:url("images/menuOver_10.png") no-repeat;
}

a#subMenu04Select:hover{
    background:url("images/menuOver_10.png") no-repeat;
}
a#subMenu05 {
    display:inline-block;
    width:94px;
    height:75px;
    background:url("images/menu_11.png") no-repeat;
}

a#subMenu05:hover{
    background:url("images/menuOver_11.png") no-repeat;
}

a#subMenu05Select {
    display:inline-block;
    width:94px;
    height:75px;
    background:url("images/menuOver_11.png") no-repeat;
}

a#subMenu05Select:hover{
    background:url("images/menuOver_11.png") no-repeat;
}
a#subMenu06 {
    display:inline-block;
    width:94px;
    height:75px;
    background:url("images/menu_12.png") no-repeat;
}

a#subMenu06:hover{
    background:url("images/menuOver_12.png") no-repeat;
}

a#subMenu06Select {
    display:inline-block;
    width:94px;
    height:75px;
    background:url("images/menuOver_12.png") no-repeat;
}

a#subMenu06Select:hover{
    background:url("images/menuOver_12.png") no-repeat;
}
a#subMenu07 {
    display:inline-block;
    width:94px;
    height:75px;
    background:url("images/menu_13.png") no-repeat;
}

a#subMenu07:hover{
    background:url("images/menuOver_13.png") no-repeat;
}

a#subMenu07Select {
    display:inline-block;
    width:94px;
    height:75px;
    background:url("images/menuOver_13.png") no-repeat;
}

a#subMenu07Select:hover{
    background:url("images/menuOver_13.png") no-repeat;
}
a#subMenu08 {
    display:inline-block;
    width:94px;
    height:75px;
    background:url("images/menu_14.png") no-repeat;
}

a#subMenu08:hover{
    background:url("images/menuOver_14.png") no-repeat;
}

a#subMenu08Select {
    display:inline-block;
    width:94px;
    height:75px;
    background:url("images/menuOver_14.png") no-repeat;
}

a#subMenu08Select:hover{
    background:url("images/menuOver_14.png") no-repeat;
}
a#subMenu09 {
    display:inline-block;
    width:94px;
    height:75px;
    background:url("images/home_08.png") no-repeat;
}

a#subMenu09:hover{
    background:url("images/home_07.png") no-repeat;
}

a#subMenu09Select {
    display:inline-block;
    width:94px;
    height:75px;
    background:url("images/home_07.png") no-repeat;
}

a#subMenu09Select:hover{
    background:url("images/home_07.png") no-repeat;
}
</style>

<div style="background-color: #e5dfd5; ">
	<table width="1324px" style="margin-left: auto; margin-right: auto;">
		<tr>
			<td height="79px;" width="1032px;" style="padding-top:20px;">
				<a href="home.jsp"><img src="imageNew/home_03.png"></a>
			</td>
			<td style="font-size:9pt; padding-top:40px; text-align: right;">
				<a href="javascript:void(window.open('changeMyInfo.jsp?userID=<%=menId %>', 'Change My Info','width=500, height=450'))">
					<%=getUserPart %>&nbsp;&nbsp;<%=getUserName %>님
				</a>
				<a href="logoutAction.jsp" style="padding-left:10px;"><img src="images/logouticon.png"></a>
			</td>
		</tr>
	</table>
</div>
<div style="background-color: #d4938e; height:7px; ">
</div>
<div style="background-color: #f9f6f1; height:75px; margin:0; padding:0; ">
	<table width="662px" style="margin-left: auto; margin-right: auto;">
		<tr>
			<td height="75px;" >
				<a href="home.jsp" id="<%=resultURL.equals("home")?"subMenu09Select":"subMenu09" %>"></a>
			</td>
			<td>
				<a href="expenditure.jsp" id="<%=resultURL.equals("expenditure")?"subMenu01Select":"subMenu01" %>"></a>
			</td>
			<td>
				<a href="income.jsp" id="<%=resultURL.equals("income")?"subMenu02Select":"subMenu02" %>"></a>
			</td>
			<td>
				<a href="rent.jsp" id="<%=resultURL.equals("rent")?"subMenu03Select":"subMenu03" %>"></a>
			</td>
			<td>
				<a href="recordExpenditure.jsp" id="<%=resultURL.equals("recordExpenditure")?"subMenu04Select":"subMenu04" %>"></a>
			</td>
			<td>
				<a href="recordIncome.jsp" id="<%=resultURL.equals("recordIncome")?"subMenu05Select":"subMenu05" %>"></a>
			</td>
			<td>
				<a href="recordRent.jsp" id="<%=resultURL.equals("recordRent")?"subMenu06Select":"subMenu06" %>"></a>
			</td>
			<td>
				<a href="managePaper.jsp" id="<%=resultURL.equals("managePaper")?"subMenu07Select":"subMenu07" %>"></a>
			</td>
			<td>
				<%
				if(getUserGrage==0) {
				%>
				<a href="admin.jsp" id="<%=resultURL.equals("admin")||resultURL.equals("manageProject")?"subMenu08Select":"subMenu08" %>"></a>
				<%
				}
				%>
			</td>
		</tr>
	</table>
</div>