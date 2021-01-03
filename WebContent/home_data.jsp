<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<meta http-equiv="X-UA-Compatible" content="IE=11">
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.*, java.text.*"  %>
<%@ page import="paper.PaperStock"%>
<%@ page import="paper.PaperStockDAO"%>
<%@ page import="java.sql.*"%>
<%@page import="org.json.simple.JSONObject"%>

<%
	String size = request.getParameter("size");
	PaperStockDAO paperstockDAO = new PaperStockDAO();
	ArrayList<PaperStock> list = paperstockDAO.getPaperStock();
	
	/* DAO결과값을 하나씩 받아오기 위한 변수 선언 */
	String size2str="";
	String kind2str="";
	String gram2str="";
	String graphlabel2str="";
	int q_sys2str=0;
	int q_dev2str=0;
	int q_cert2str=0;
	int q_meca2str=0;
	int q_qa2str=0;

	/* DB갯수만큼 모두 담기위한 배열 선언 */
	String size2arr[]=new String[list.size()];
	String kind2arr[]=new String[list.size()];
	String gram2arr[]=new String[list.size()];
	String graphlabel2arr[]=new String[list.size()];
	int q_sys2arr[] = new int[list.size()];
	int q_dev2arr[] = new int[list.size()];
	int q_cert2arr[] = new int[list.size()];
	int q_meca2arr[] = new int[list.size()];
	int q_qa2arr[] = new int[list.size()];
	
	/* DB전체 행 중 원하는 값이 있는 행갯수를 구하기 위한 변수 */
	int arridx=0;
	
	/* DB내용 중 조건에 맞는 값을 가져온다. */
	for(int i2=0; i2<list.size(); i2++){
		String listObject = list.get(i2).getPaper_list_size(); 
		if(listObject.equals(size)){ 
			size2str = list.get(i2).getPaper_list_size();
			kind2str = list.get(i2).getPaper_list_kind();
			gram2str = list.get(i2).getPaper_list_gram();
			q_sys2str = list.get(i2).getPaper_list_quantity_sys();
			q_dev2str = list.get(i2).getPaper_list_quantity_dev();
			q_cert2str = list.get(i2).getPaper_list_quantity_cer();
			q_meca2str = list.get(i2).getPaper_list_quantity_mec();
			q_qa2str = list.get(i2).getPaper_list_quantity_qa();
			graphlabel2str = list.get(i2).getPaper_list_size()+"_"+list.get(i2).getPaper_list_kind()+"_"+list.get(i2).getPaper_list_gram()+"g";
			
			size2arr[arridx] = size2str;
			kind2arr[arridx] = kind2str;
			gram2arr[arridx] = gram2str;
			q_sys2arr[arridx] = q_sys2str;
			q_dev2arr[arridx] = q_dev2str;
			q_cert2arr[arridx] = q_cert2str;
			q_meca2arr[arridx] = q_meca2str;
			q_qa2arr[arridx] = q_qa2str;
			graphlabel2arr[arridx] = graphlabel2str;
			
			arridx++;
		}
	}
	
	/* DB갯수만큼 배열을 선언했었기 때문에, 실제로 값이 있는 배열을 제외하고는 null이 들어가 있음. null값을 제거하고 순수 값만 남기기 위한 부분 */
	String sizearr[]=new String[arridx];
	String kindarr[]=new String[arridx];
	String gramarr[]=new String[arridx];
	String graphlabelarr[]=new String[arridx];
	int q_sysarr[] = new int[arridx];
	int q_devarr[] = new int[arridx];
	int q_certarr[] = new int[arridx];
	int q_mecaarr[] = new int[arridx];
	int q_qaarr[] = new int[arridx];
	
	/* 최종값은 아래 배열에 담김 */
	for(int i3=0; i3<arridx; i3++){
		sizearr[i3] = size2arr[i3];
		kindarr[i3] = kind2arr[i3];
		gramarr[i3] = gram2arr[i3];
		q_sysarr[i3] = q_sys2arr[i3];
		q_devarr[i3] = q_dev2arr[i3];
		q_certarr[i3] = q_cert2arr[i3];
		q_mecaarr[i3] = q_meca2arr[i3];
		q_qaarr[i3] = q_qa2arr[i3];
		graphlabelarr[i3] = graphlabel2arr[i3];
		System.out.println(kindarr[i3]);
	}
	
	/* script로 값을 넘기기 위한 작업 */
	String sizejtos = "";
	String kindjtos = "";
	String gramjtos = "";
	String q_sysjtos = "";
	String q_devjtos = "";
	String q_certjtos = "";
	String q_mecajtos = "";
	String q_qajtos = "";
	String graphlabeljtos = "";
	
	/* for(int i4=0; i4<sizearr.length; i4++)
	{
		if(i4==0){
			sizejtos = "'"+sizearr[i4]+"'";
			kindjtos = "'"+kindarr[i4]+"'";
			gramjtos = "'"+gramarr[i4]+"'";
			q_sysjtos = "'"+q_sysarr[i4]+"'";
			q_devjtos = "'"+q_devarr[i4]+"'";
			q_certjtos = "'"+q_certarr[i4]+"'";
			q_mecajtos = "'"+q_mecaarr[i4]+"'";
			q_qajtos = "'"+q_qaarr[i4]+"'";
			graphlabeljtos = "'"+graphlabelarr[i4]+"'";
		}
		else {
			sizejtos = sizejtos+",'"+sizearr[i4]+"'";
			kindjtos = kindjtos+",'"+kindarr[i4]+"'";
			gramjtos = gramjtos+",'"+gramarr[i4]+"'";
			q_sysjtos = q_sysjtos+",'"+q_sysarr[i4]+"'";
			q_devjtos = q_devjtos+",'"+q_devarr[i4]+"'";
			q_certjtos = q_certjtos+",'"+q_certarr[i4]+"'";
			q_mecajtos = q_mecajtos+",'"+q_mecaarr[i4]+"'";
			q_qajtos = q_qajtos+",'"+q_qaarr[i4]+"'";
			graphlabeljtos = graphlabeljtos+",'"+graphlabelarr[i4]+"'";
		}
	} */
	
	for(int i4=0; i4<sizearr.length; i4++)
	{
		if(i4==0){
			sizejtos = ""+sizearr[i4]+"";
			kindjtos = ""+kindarr[i4]+"";
			gramjtos = ""+gramarr[i4]+"";
			q_sysjtos = ""+q_sysarr[i4]+"";
			q_devjtos = ""+q_devarr[i4]+"";
			q_certjtos = ""+q_certarr[i4]+"";
			q_mecajtos = ""+q_mecaarr[i4]+"";
			q_qajtos = ""+q_qaarr[i4]+"";
			graphlabeljtos = ""+graphlabelarr[i4]+"";
		}
		else {
			sizejtos = sizejtos+"\""+","+"\""+sizearr[i4]+"";
			kindjtos = kindjtos+"\""+","+"\""+kindarr[i4]+"";
			gramjtos = gramjtos+"\""+","+"\""+gramarr[i4]+"";
			q_sysjtos = q_sysjtos+","+q_sysarr[i4]+"";
			q_devjtos = q_devjtos+","+q_devarr[i4]+"";
			q_certjtos = q_certjtos+","+q_certarr[i4]+"";
			q_mecajtos = q_mecajtos+","+q_mecaarr[i4]+"";
			q_qajtos = q_qajtos+","+q_qaarr[i4]+"";
			graphlabeljtos = graphlabeljtos+"\""+","+"\""+graphlabelarr[i4]+"";
		}
	}
	
	PrintWriter outs = response.getWriter();
	response.setContentType("application/json");
	JSONObject obj = new JSONObject();
	obj.put("sizejtos", sizejtos);
	obj.put("kindjtos", kindjtos);
	obj.put("gramjtos", gramjtos);
	obj.put("q_sysjtos", q_sysjtos);
	obj.put("q_devjtos", q_devjtos);
	obj.put("q_certjtos", q_certjtos);
	obj.put("q_mecajtos", q_mecajtos);
	obj.put("q_qajtos", q_qajtos);
	obj.put("graphlabeljtos", graphlabeljtos);
	
	outs.print(obj.toJSONString()); 
	
	//밑에는 라이브러리 못찾을 경우
	//String json = "{\"sizejtos\" :" + sizejtos + ",\"kindjtos\" :" + kindjtos + ",\"gramjtos\" :" + gramjtos + ",\"q_sysjtos\" :" + q_sysjtos + ",\"q_devjtos\" :" + q_devjtos + ",\"q_certjtos\" :" + q_certjtos + ",\"q_mecajtos\" :" + q_mecajtos + ",\"q_qajtos\" :" + q_qajtos + ",\"graphlabeljtos\" :" + graphlabeljtos + "}";

%>