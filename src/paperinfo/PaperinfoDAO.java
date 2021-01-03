package paperinfo;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import paper.PaperStock;
import user.User;

public class PaperinfoDAO {
	private Connection conn;
	private PreparedStatement psmt;
	private ResultSet rs;

	public PaperinfoDAO() {
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
	
	public int addPaperInfo(int paperNo, String paperName, String paperSize, String paperKind, String paperGram, String fileRealName, String fileName, String lastPaperPosition,
			String paperBuNo, String paperPack, String paperBox, String paperCost, String paperMinimum, String paperDelivery, String peperVender, String paperNote) {
		String SQL = "INSERT INTO pm_paperinfo VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

		try {
			psmt = conn.prepareStatement(SQL);
			psmt.setString(1, paperName);
			psmt.setString(2, paperSize);
			psmt.setString(3, paperKind);
			psmt.setString(4, paperGram);
			psmt.setString(5, fileRealName);
			psmt.setString(6, fileName);
			psmt.setString(7, lastPaperPosition);
			psmt.setString(8, paperBuNo);
			psmt.setString(9, paperPack);
			psmt.setString(10, paperBox);
			psmt.setString(11, paperCost);
			psmt.setString(12, paperMinimum);
			psmt.setString(13, paperDelivery);
			psmt.setString(14, peperVender);
			psmt.setString(15, paperNote);
			
			return psmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // DB ¿À·ù
	}
	
	public ArrayList<Paperinfo> allPaperinfo() {
		String SQL = "SELECT * FROM pm_paperinfo order by pinfo_no";
		ArrayList<Paperinfo> paperInfoAll = new ArrayList<Paperinfo>();

		try {
			psmt = conn.prepareStatement(SQL);
			rs = psmt.executeQuery();
			while (rs.next()) {
				Paperinfo paperinfo = new Paperinfo();
				paperinfo.setPinfo_no(rs.getInt(1));
				paperinfo.setPinfo_name(rs.getString(2));
				paperinfo.setPinfo_size(rs.getString(3));
				paperinfo.setPinfo_kind(rs.getString(4));
				paperinfo.setPinfo_gram(rs.getString(5));
				paperinfo.setPinfo_realfilename(rs.getString(6));
				paperinfo.setPinfo_filename(rs.getString(7));
				paperinfo.setPinfo_location(rs.getString(8));
				paperinfo.setPinfo_bunum(rs.getString(9));
				paperinfo.setPinfo_pack(rs.getString(10));
				paperinfo.setPinfo_box(rs.getString(11));
				paperinfo.setPinfo_cost(rs.getString(12));
				paperinfo.setPinfo_minimum(rs.getString(13));
				paperinfo.setPinfo_delivery(rs.getString(14));
				paperinfo.setPinfo_vender(rs.getString(15));
				paperinfo.setPinfo_note(rs.getString(16));
				paperInfoAll.add(paperinfo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return paperInfoAll;
	}
	
	public int memberPaper(String delMemberId) {
		String SQL = "DELETE FROM pm_paperinfo where pinfo_no = ?";

		try {
			psmt = conn.prepareStatement(SQL);
			psmt.setString(1, delMemberId);

			return psmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int editPaperInfo(int paperNo, String paperName, String paperSize, String paperKind, String paperGram, String fileRealName, String fileName, String lastPaperPosition,
			String paperBuNo, String paperPack, String paperBox, String paperCost, String paperMinimum, String paperDelivery, String paperVender, String paperNote) {
		String SQL = "UPDATE pm_paperinfo SET pinfo_name=?, pinfo_size=?, pinfo_kind=?, pinfo_gram=?, pinfo_realfilename=?, pinfo_filename=?, pinfo_location=?, pinfo_bunum=?, pinfo_pack=?, pinfo_box=?," 
					+ "pinfo_cost=?, pinfo_minimum=?, pinfo_delivery=?, pinfo_vender=?, pinfo_note=?  WHERE pinfo_no=?";

		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, paperName);
			pstmt.setString(2, paperSize);
			pstmt.setString(3, paperKind);
			pstmt.setString(4, paperGram);
			pstmt.setString(5, fileRealName);
			pstmt.setString(6, fileName);
			pstmt.setString(7, lastPaperPosition);
			pstmt.setString(8, paperBuNo);
			pstmt.setString(9, paperPack);
			pstmt.setString(10, paperBox);
			pstmt.setString(11, paperCost);
			pstmt.setString(12, paperMinimum);
			pstmt.setString(13, paperDelivery);
			pstmt.setString(14, paperVender);
			pstmt.setString(15, paperNote);
			pstmt.setInt(16, paperNo);

			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // DB ERR
	}

	public ArrayList<Paperinfo> getPaperTypeServlet(String paperSize) {
		String SQL = "select pinfo_kind from pm_paperinfo where pinfo_size=? group by pinfo_kind having COUNT (pinfo_kind) >= 1";
			
		ArrayList<Paperinfo> list = new ArrayList<Paperinfo>();
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, paperSize);
			
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Paperinfo paperInfo = new Paperinfo();
				paperInfo.setPinfo_kind(rs.getString(1));
				list.add(paperInfo);	
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	public ArrayList<Paperinfo> getPaperGramServlet(String paperSize, String paperKind) {		
		String SQL = "select pinfo_gram from pm_paperinfo where pinfo_size=? AND pinfo_kind=? group by pinfo_gram having COUNT (pinfo_gram) >= 1";
			
		ArrayList<Paperinfo> list = new ArrayList<Paperinfo>();
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, paperSize);
			pstmt.setString(2, paperKind);
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				Paperinfo paperInfo = new Paperinfo();
				paperInfo.setPinfo_gram(rs.getString(1));
				list.add(paperInfo);	
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	public ArrayList<Paperinfo> getPaperNameServlet(String paperSize, String paperKind, String paperGram) {		
		String SQL = "select pinfo_name from pm_paperinfo where pinfo_size=? AND pinfo_kind=? AND pinfo_gram=? group by pinfo_name having COUNT (pinfo_name) >= 1";
			
		ArrayList<Paperinfo> list = new ArrayList<Paperinfo>();
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, paperSize);
			pstmt.setString(2, paperKind);
			pstmt.setString(3, paperGram);
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				Paperinfo paperInfo = new Paperinfo();
				paperInfo.setPinfo_name(rs.getString(1));
				list.add(paperInfo);	
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
}
