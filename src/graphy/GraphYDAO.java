package graphy;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class GraphYDAO {
	private Connection conn;
	private PreparedStatement psmt;
	private ResultSet rs;

	public GraphYDAO() {
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
	
	public ArrayList<GraphY> getGraphY(String size) {
		String SQL = "SELECT pm_paperinfo.pinfo_no, pm_paperinfo.pinfo_name, SUM(pm_stock.stock_paperStock) AS paperStockSum\r\n"
				+ "FROM pm_paperinfo, pm_stock\r\n"
				+ "WHERE pm_paperinfo.pinfo_no = pm_stock.stock_paperNo AND pm_paperinfo.pinfo_size=? GROUP BY pm_paperinfo.pinfo_no, pm_paperinfo.pinfo_name ORDER BY paperStockSum DESC";
		ArrayList<GraphY> graphy = new ArrayList<GraphY>();

		try {
			psmt = conn.prepareStatement(SQL);
			psmt.setString(1, size);
			
			rs = psmt.executeQuery();
			while (rs.next()) {
				GraphY graphyDAO = new GraphY();
				graphyDAO.setGraphNo(rs.getInt(1));
				graphyDAO.setGraphName(rs.getString(2));
				graphyDAO.setGraphStockSum(rs.getInt(3));
				graphy.add(graphyDAO);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return graphy;
	}
	
	public int getGraphX(int paperNo, int partNo) {
		String SQL = "SELECT SUM(stock_paperStock) AS paperStockSum FROM pm_stock WHERE stock_paperNo=? AND stock_partNo=?";
		int result = 0;
		
		try {
			psmt = conn.prepareStatement(SQL);
			psmt.setInt(1, paperNo);
			psmt.setInt(2, partNo);
			
			rs = psmt.executeQuery();
			while (rs.next()) {
				result = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public int getGraphXPart5(int paperNo) {
		String SQL = "SELECT SUM(stock_paperStock) AS paperStockSum FROM pm_stock WHERE stock_paperNo=? AND NOT stock_partNo IN (1,2,3,4)";
		int result = 0;
		
		try {
			psmt = conn.prepareStatement(SQL);
			psmt.setInt(1, paperNo);
			
			rs = psmt.executeQuery();
			while (rs.next()) {
				result = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

}
