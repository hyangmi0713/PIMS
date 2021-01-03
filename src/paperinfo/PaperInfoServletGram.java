package paperinfo;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class PaperInfoServlet
 */
@WebServlet("/PaperInfoServletGram")
public class PaperInfoServletGram extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String size = request.getParameter("size");
		String type = request.getParameter("type");
		String gram = request.getParameter("gram");
		response.getWriter().write(getJSON(size, type, gram));
	}
	
	public String getJSON(String size, String type, String gram) {
		if(size==null) {
			size = "";
		}
		if(type==null) {
			type = "";
		}
		if(gram==null) {
			gram = "";
		}
		
		StringBuffer result = new StringBuffer("");
		
		PaperinfoDAO paperInfoDAO = new PaperinfoDAO();
		ArrayList<Paperinfo> paperinfo = paperInfoDAO.getPaperNameServlet(size, type, gram);
		
		for(int i=0; i<paperinfo.size(); i++) {
			result.append(paperinfo.get(i).getPinfo_name()+",");
		}
	
		return result.toString();
	}

}
