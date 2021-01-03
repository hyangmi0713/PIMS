package stock;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import paperinfo.Paperinfo;
import paperinfo.PaperinfoDAO;
import part.Part;
import part.PartDAO;
import pm_stock.Pm_stock;
import project.Project;
import project.ProjectDAO;

public class StockDAO {
	private Connection conn;
	private PreparedStatement psmt;
	private ResultSet rs;

	public StockDAO() {
		try {

			String dbURL = "jdbc:sqlserver://localhost:1433; DatabaseName=PM";
			String dbUser = "crob";
			String dbPass = "1111";
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public int updatePaperStock(String size, String kind, String gram, String name, String partNo, String projectNo, String count, int flag) {
		int result = 0;

		int paperNo = searchPaperNo(size, kind, gram, name);
		
		if(paperNo == -1) { 
			return -1;
		}
		else {
			String SQL0 = "IF EXISTS (\r\n" + 
					"		SELECT stock_paperStock FROM pm_stock WHERE stock_partNo=? AND stock_projectNo=? AND stock_paperNo=?\r\n" + 
					"	)\r\n" + 
					"	BEGIN\r\n" + 
					"		UPDATE pm_stock SET stock_paperStock=stock_paperStock+? WHERE stock_partNo=? AND stock_projectNo=? AND stock_paperNo=?\r\n" + 
					"	END\r\n" + 
					"ELSE\r\n" + 
					"	BEGIN\r\n" + 
					"		INSERT INTO pm_stock(stock_partNo, stock_projectNo, stock_paperNo, stock_paperStock) values (?, ?, ?, ?) \r\n" + 
					"	END";
			
			String SQL1 = "IF EXISTS (\r\n" + 
					"		SELECT stock_paperStock FROM pm_stock WHERE stock_partNo=? AND stock_projectNo=? AND stock_paperNo=?\r\n" + 
					"	)\r\n" + 
					"	BEGIN\r\n" + 
					"		UPDATE pm_stock SET stock_paperStock=stock_paperStock-? WHERE stock_partNo=? AND stock_projectNo=? AND stock_paperNo=?\r\n" + 
					"	END\r\n" + 
					"ELSE\r\n" + 
					"	BEGIN\r\n" + 
					"		INSERT INTO pm_stock(stock_partNo, stock_projectNo, stock_paperNo, stock_paperStock) values (?, ?, ?, ?) \r\n" + 
					"	END";
			
			String SQL = null;
			if(flag==0) {
				SQL = SQL0;
			}
			else {
				SQL = SQL1;
			}
			
			try {
				psmt = conn.prepareStatement(SQL);
				psmt.setInt(1, Integer.parseInt(partNo));
				psmt.setInt(2, Integer.parseInt(projectNo));
				psmt.setInt(3, paperNo);
				psmt.setInt(4, Integer.parseInt(count));
				psmt.setInt(5, Integer.parseInt(partNo));
				psmt.setInt(6, Integer.parseInt(projectNo));
				psmt.setInt(7, paperNo);
				psmt.setInt(8, Integer.parseInt(partNo));
				psmt.setInt(9, Integer.parseInt(projectNo));
				psmt.setInt(10, paperNo);
				psmt.setInt(11, Integer.parseInt(count));
												
				result = psmt.executeUpdate();
				
				return result;
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return -1;
	}
	
	public int searchPaperNo(String size, String kind, String gram, String name) {
		
		int paperNo = 0;
		String SQL = "select pinfo_no from pm_paperinfo where pinfo_size='"+size+"' AND pinfo_kind='"+kind+"' AND pinfo_gram='"+gram+"' AND pinfo_name='"+name+"'";
		
		try {
			psmt = conn.prepareStatement(SQL);
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				paperNo = Integer.parseInt(rs.getString(1));
			}
			return paperNo;
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return -1;
	}
	
	public ArrayList<Stock> selStockTable() {
		String SQL = "SELECT * FROM pm_stock ORDER BY stock_paperNo";
		ArrayList<Stock> selStock = new ArrayList<Stock>();
		
		try {
			psmt = conn.prepareStatement(SQL);
			rs = psmt.executeQuery();
			while (rs.next()) {
				Stock selStockDAO = new Stock();
				selStockDAO.setStockPartNo(rs.getInt(2));
				selStockDAO.setStockProjectNo(rs.getInt(3));
				selStockDAO.setStockPaperNo(rs.getInt(4));
				selStockDAO.setStockPaperStock(rs.getInt(5));
				selStock.add(selStockDAO);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return selStock; 
	}
}
