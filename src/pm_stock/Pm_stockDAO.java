package pm_stock;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import paperinfo.Paperinfo;
import paperinfo.PaperinfoDAO;
import part.Part;
import part.PartDAO;
import project.Project;
import project.ProjectDAO;
import stock.StockDAO;

public class Pm_stockDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	public Pm_stockDAO() {
		try {
			String dbURL = "jdbc:sqlserver://localhost:1433; DatabaseName=PM";
			String dbID = "crob";
			String dbPassword = "1111";
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public ArrayList<Pm_stock> selStock() {
		String SQL = "SELECT * FROM pm_stock ORDER BY stock_paperNo";
		ArrayList<Pm_stock> selStock = new ArrayList<Pm_stock>();
		
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Pm_stock selStockDAO = new Pm_stock();
				selStockDAO .setStock_partNo(rs.getInt(2));
				selStockDAO.setStock_projectNo(rs.getInt(3));
				selStockDAO.setStock_paperNo(rs.getInt(4));
				selStockDAO.setStock_paperStock(rs.getInt(5));
				selStock.add(selStockDAO);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return selStock; 
	}
	
	public ArrayList allStockTable() {
		ArrayList allStockTable = new ArrayList();
		
		ArrayList<Pm_stock> selStockTable = new ArrayList<Pm_stock>();
		ArrayList<Paperinfo> selPaperTable = new ArrayList<Paperinfo>();
		ArrayList<Part> selPartTable = new ArrayList<Part>();
		ArrayList<Project> selProjectTable = new ArrayList<Project>();
		
		PaperinfoDAO paperinfoDAO = new PaperinfoDAO();
		PartDAO partDAO = new PartDAO();
		ProjectDAO projectDAO = new ProjectDAO();
		
		selStockTable = selStock();
		selPaperTable = paperinfoDAO.allPaperinfo();
		selPartTable = partDAO.allPartList();
		selProjectTable = projectDAO.allPartProjectList();
		
		System.out.println("************* "+selStockTable.size());
		
		for(int i=0; i<selStockTable.size(); i++) {
			// 용지사이즈
			for(int a=0; a<selPaperTable.size(); a++) {
				//selStockTable.get(i).getStock_paperNo()
			}
			
			allStockTable.add("");
		}
		
		return allStockTable;
	}
}
