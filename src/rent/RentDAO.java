package rent;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import part.Part;
import part.PartDAO;
import project.Project;

public class RentDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	public RentDAO() {
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
	
	public int addRentInput(List<String> expaper) {
		SimpleDateFormat format1 = new SimpleDateFormat ("yyyy-MM-dd HH:mm:ss");
		Date time = new Date();
		String today = format1.format(time);
		
		String SQL = "INSERT INTO pm_rent VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		
		int result = 0;
		
		try {
			for(int i=0; i<expaper.size(); i++) {				
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1,  today);
				pstmt.setString(2,  expaper.get(i)); //size
				pstmt.setString(3,  expaper.get(i+1)); //kind
				pstmt.setString(4,  expaper.get(i+2)); //gram
				pstmt.setString(5,  expaper.get(i+3)); //count
				pstmt.setString(6,  expaper.get(i+4)); //note
				
				pstmt.setString(7,  expaper.get(i+5)); //rentPart
				pstmt.setString(8,  expaper.get(i+6)); //rentProjectNo
				pstmt.setString(9,  expaper.get(i+7)); //rentProjectSel
				pstmt.setString(10,  expaper.get(i+8)); //rentName
				
				pstmt.setString(11,  expaper.get(i+9)); //lendPart
				pstmt.setString(12,  expaper.get(i+10)); //lendProjectNo
				pstmt.setString(13,  expaper.get(i+11)); //lendProjectSel
				pstmt.setString(14,  expaper.get(i+12)); //lendName
				pstmt.setString(15,  "0"); //state
				
				result = pstmt.executeUpdate();
				
				i=i+12;
			}
				
			return result;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // DB ¿À·ù
	}
	
	public ArrayList<Rent> allRentList() {
		String SQL = "SELECT * FROM pm_rent";
		ArrayList<Rent> rentAllList = new ArrayList<Rent>();
		
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Rent rentList = new Rent();
				rentList.setNo(rs.getInt(1));
				rentList.setDate(rs.getString(2));
				
				rentList.setSize(rs.getString(3));
				rentList.setKind(rs.getString(4));
				rentList.setGram(rs.getString(5));
				rentList.setCount(rs.getString(6));
				rentList.setNote(rs.getString(7));
				
				rentList.setRentPart(rs.getString(8));
				rentList.setRentProjectNo(rs.getInt(9));
				rentList.setRentProjectSel(rs.getString(10));
				rentList.setRentName(rs.getString(11));
								
				rentList.setLendPart(rs.getString(12));
				rentList.setLendProjectNo(rs.getInt(13));
				rentList.setLendProjectSel(rs.getString(14));
				rentList.setLendName(rs.getString(15));
				
				rentList.setState(rs.getInt(16));
				
				rentAllList.add(rentList);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return rentAllList; 
	}
}
