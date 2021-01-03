package pm_inventory;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.*;

import part.PartDAO;
import user.User;
import stock.Stock;
import stock.StockDAO;

public class Pm_inventoryDAO {

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	public Pm_inventoryDAO() {
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
	
	public int addExpaperInput(List<String> expaper, String part, String userName, int partNo) {
		SimpleDateFormat format1 = new SimpleDateFormat ("yyyy-MM-dd HH:mm:ss");
		Date time = new Date();
		String today = format1.format(time);
		
		String SQL = "INSERT INTO pm_inventory VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		
		int result = 0;
		
		try {
			for(int i=0; i<expaper.size(); i++) {	
				//0size, 1kind, 2gram, 3name, partNo, 5projectNo, 4count
				StockDAO stockDAO = new StockDAO();
				int updateStock = stockDAO.updatePaperStock(expaper.get(i), expaper.get(i+1), expaper.get(i+2), expaper.get(i+3),
						Integer.toString(partNo), expaper.get(i+5), expaper.get(i+4), 1);
				
				if(updateStock != -1) {
					pstmt = conn.prepareStatement(SQL);
					pstmt.setString(1,  today);
					pstmt.setString(2,  expaper.get(i)); //size
					pstmt.setString(3,  expaper.get(i+1)); //kind
					pstmt.setString(4,  expaper.get(i+2)); //gram
					pstmt.setString(5,  expaper.get(i+3)); //name
					pstmt.setString(6,  expaper.get(i+4)); //count
					pstmt.setString(7,  part); //part
					pstmt.setString(8,  part);
					pstmt.setString(9,  userName);
					pstmt.setString(10,  expaper.get(i+5)); //projectNo
					pstmt.setString(11,  expaper.get(i+6)); //project
					pstmt.setString(12,  expaper.get(i+7)); //note
					pstmt.setString(13,  "1");
					
					result = pstmt.executeUpdate();
					
					i=i+7;
				}
				else {
					return -1;
				}
			}
				
			return result;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // DB 오류
	}
	
	public int addIncomeInput(List<String> expaper, String part, String userName) {
		SimpleDateFormat format1 = new SimpleDateFormat ("yyyy-MM-dd HH:mm:ss");
		Date time = new Date();
		String today = format1.format(time);
		
		String SQL = "INSERT INTO pm_inventory VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		
		int result = 0;
		
		try {
			for(int i=0; i<expaper.size(); i++) {
				//0size, 1kind, 2gram, 3name, 5partNo, 7projectNo, 4count
				StockDAO stockDAO = new StockDAO();
				int updateStock = stockDAO.updatePaperStock(expaper.get(i), expaper.get(i+1), expaper.get(i+2), expaper.get(i+3),
						expaper.get(i+5), expaper.get(i+7), expaper.get(i+4), 0);
				
				if(updateStock != -1) {
					pstmt = conn.prepareStatement(SQL);
					pstmt.setString(1,  today);
					pstmt.setString(2,  expaper.get(i)); //size
					pstmt.setString(3,  expaper.get(i+1)); //kind
					pstmt.setString(4,  expaper.get(i+2)); //gram
					pstmt.setString(5,  expaper.get(i+3)); //name
					pstmt.setString(6,  expaper.get(i+4)); //count
					pstmt.setString(7,  expaper.get(i+6)); //part
					pstmt.setString(8,  part);
					pstmt.setString(9,  userName);
					pstmt.setString(10,  expaper.get(i+7)); //projectNo
					pstmt.setString(11,  expaper.get(i+8)); //project
					pstmt.setString(12,  expaper.get(i+9)); //note
					pstmt.setString(13,  "0");
					
					result = pstmt.executeUpdate();
					
					i=i+9;
				}
				else {
					return -1;
				}
			}
				
			return result;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // DB 오류
	}
	
	public ArrayList<Pm_inventory> allExpenditureList(int flag) {
		String SQL = "SELECT * FROM pm_inventory WHERE paper_inv_inout=? ORDER BY paper_inv_date DESC";
		ArrayList<Pm_inventory> allExpenditure = new ArrayList<Pm_inventory>();
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, flag);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Pm_inventory expenditureList = new Pm_inventory();
				expenditureList.setPaper_inv_date(rs.getString(2));
				expenditureList.setPaper_inv_size(rs.getString(3));
				expenditureList.setPaper_inv_kind(rs.getString(4));
				expenditureList.setPaper_inv_gram(rs.getString(5));
				expenditureList.setPaper_inv_name(rs.getString(6));
				expenditureList.setPaper_inv_quantity(rs.getString(7));
				expenditureList.setPaper_inv_request(rs.getString(8));
				expenditureList.setMem_no(rs.getString(9));
				expenditureList.setMen_derpartment(rs.getString(10));
				expenditureList.setPaper_project_no(rs.getInt(11));
				expenditureList.setPaper_project(rs.getString(12));
				expenditureList.setPaper_inv_note(rs.getString(13));
				allExpenditure.add(expenditureList);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return allExpenditure; 
	}
	
	/*
	 * public ArrayList<Pm_inventory> rentExpenditureList() { String SQL =
	 * "SELECT * FROM pm_inventory WHERE paper_rent=1 ORDER BY paper_inv_date DESC";
	 * ArrayList<Pm_inventory> rentExpenditure = new ArrayList<Pm_inventory>();
	 * 
	 * try { pstmt = conn.prepareStatement(SQL); rs = pstmt.executeQuery(); while
	 * (rs.next()) { Pm_inventory expenditureList = new Pm_inventory();
	 * expenditureList.setPaper_inv_date(rs.getString(2));
	 * expenditureList.setPaper_inv_size(rs.getString(3));
	 * expenditureList.setPaper_inv_kind(rs.getString(4));
	 * expenditureList.setPaper_inv_gram(rs.getString(5));
	 * expenditureList.setPaper_inv_quantity(rs.getString(6));
	 * expenditureList.setPaper_inv_request(rs.getString(7));
	 * expenditureList.setMem_no(rs.getString(8));
	 * expenditureList.setMen_derpartment(rs.getString(9));
	 * expenditureList.setPaper_inv_note(rs.getString(10));
	 * rentExpenditure.add(expenditureList); } } catch (Exception e) {
	 * e.printStackTrace(); } return rentExpenditure; }
	 */
	 public ArrayList<Pm_inventory> getPm_inventory(){
		 String SQL = "SELECT paper_inv_size, count(paper_inv_size) FROM pm_inventory where paper_inv_inout = '1' Group by paper_inv_size ORDER BY count(paper_inv_size) DESC";
		 ArrayList<Pm_inventory> list = new ArrayList<Pm_inventory>();
		 
		 try {
				pstmt = conn.prepareStatement(SQL);
				rs = pstmt.executeQuery();
				while (rs.next()) {
					Pm_inventory pm_inventory = new Pm_inventory();
					pm_inventory.setPaper_inv_size(rs.getString(1));
				
					list.add(pm_inventory);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			return list; 
		 
	 }
}

