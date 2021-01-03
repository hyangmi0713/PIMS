package part;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;

import user.User;

public class PartDAO {
	private Connection conn;
	private PreparedStatement psmt;
	private ResultSet rs;

	public PartDAO() {
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
	
	public ArrayList<Part> allPartList() {
		String SQL = "SELECT * FROM pm_part";
		ArrayList<Part> partInfo = new ArrayList<Part>();
		
		try {
			psmt = conn.prepareStatement(SQL);
			rs = psmt.executeQuery();
			while (rs.next()) {
				Part partlist = new Part();
				partlist.setPartNo(rs.getInt(1));
				partlist.setPartName(rs.getString(2));
				partInfo.add(partlist);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return partInfo; 
	}
	
	public int addPart(String partName) {
		String SQL = "INSERT INTO pm_part VALUES (?)";
		
		try {
			psmt = conn.prepareStatement(SQL);
			psmt.setString(1,  partName);
			
			return psmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; 
	}
	
	public int selPartNo(String partName) {
		String SQL = "SELECT part_no FROM pm_part WHERE part_name=?";
		
		try {
			psmt = conn.prepareStatement(SQL);
			psmt.setString(1,  partName);
			
			rs = psmt.executeQuery();
			while (rs.next()) {
				return rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0; 
	}
	
	public int delPart(String delPartId) {		
		String SQL = "DELETE FROM pm_part where part_no = ?";		
				
		try {
			psmt = conn.prepareStatement(SQL);
			psmt.setString(1, delPartId);
			
			return psmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int updatePartInfo(List<String> paperEditName, List<String> paperEditNo) {
		String SQL = "UPDATE pm_part SET part_name=? WHERE part_no=?";
		
		int result = 0;
		
		try {			
			for (int i=0; i<paperEditName.size(); i++) {
				psmt = conn.prepareStatement(SQL);
				
				psmt.setString(1, paperEditName.get(i));
				psmt.setInt(2, Integer.parseInt(paperEditNo.get(i)));
				
				result = psmt.executeUpdate();
			}	
			return result;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // DB ERR
	}
}
