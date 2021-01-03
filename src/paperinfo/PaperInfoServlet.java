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
@WebServlet("/PaperInfoServlet")
public class PaperInfoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String size = request.getParameter("size");
		response.getWriter().write(getJSON(size));
	}
	
	public String getJSON(String size) {
		if(size==null) {
			size = "";
		}
		
		StringBuffer result = new StringBuffer("");
		
		PaperinfoDAO paperInfoDAO = new PaperinfoDAO();
		ArrayList<Paperinfo> paperinfo = paperInfoDAO.getPaperTypeServlet(size);
		
		for(int i=0; i<paperinfo.size(); i++) {
			result.append(paperinfo.get(i).getPinfo_kind()+",");
		}
	
		return result.toString();
	}

}
