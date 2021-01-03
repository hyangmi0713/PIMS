package paper;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;

import paper.PaperStock;
import user.User;
import part.Part;
import project.Project;
import project.ProjectDAO;

public class PaperStockDAO {

	private Connection conn;
	private PreparedStatement pstmt, pstmt2, pstmt3;
	private ResultSet rs, rs2, rs3;
	
	public PaperStockDAO() {
		try {
			//String dbURL = "jdbc:sqlserver://localhost:1433; DatabaseName=CroB";
			String dbURL = "jdbc:sqlserver://localhost:1433; DatabaseName=PM";
			String dbID = "crob";
			String dbPassword = "1111";
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public ArrayList<PaperStock> getPaperStock() {
		//String SQL = "SELECT * FROM pm_paperlist WHERE paper_list_size='A4'";
		String SQL = "SELECT * FROM pm_paperlist";
		ArrayList<PaperStock> list = new ArrayList<PaperStock>();
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				PaperStock paperStock = new PaperStock();
				paperStock.setPaper_list_no(rs.getInt(1));
				paperStock.setPaper_list_size(rs.getString(2));
				paperStock.setPaper_list_kind(rs.getString(3));
				paperStock.setPaper_list_gram(rs.getString(4));
				paperStock.setPaper_list_quantity_sys(rs.getInt(5));
				paperStock.setPaper_list_quantity_dev(rs.getInt(6));
				paperStock.setPaper_list_quantity_cer(rs.getInt(7));
				paperStock.setPaper_list_quantity_mec(rs.getInt(8));
				paperStock.setPaper_list_quantity_qa(rs.getInt(9));
				list.add(paperStock);				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}
	
	public ArrayList<Object> paperSizeList2() {

		ArrayList<Object> list = new ArrayList<Object>();
		int rowCount = 0;
		int a = 0;
		String[] rowName;
		
		try {

			pstmt = conn.prepareStatement("SELECT count(DISTINCT project_paperlist_name) from pm_project");
			rs = pstmt.executeQuery();
			while (rs.next()) {
				rowCount = rs.getInt(1);
			}
			
			rowName = new String[rowCount];

			  
			pstmt2 = conn.prepareStatement("SELECT DISTINCT project_paperlist_name from pm_project ORDER BY project_paperlist_name DESC"); 
			rs2 = pstmt2.executeQuery(); 
			while (rs2.next()) 
			{ 
				rowName[a] = rs2.getString(1);
				a++;
			}
	 

			System.out.println("길이:" + rowCount);
			System.out.println("길이2:" + rowName[2]);


			pstmt3 = conn.prepareStatement("SELECT * FROM pm_paperlist");
			rs3 = pstmt3.executeQuery();

			while (rs3.next()) {
				for (int b = 0; b < rowCount; b++) {
					list.add(rs3.getInt(rowName[b]));
					//list.add(rs3.getInt("paper_list_quantity_sys_1"));
					//list.add(rs3.getInt("paper_list_quantity_sys_29"));
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}
	
	/*
	public ArrayList<PaperStock> getPaperStock_A3() {
		String SQL = "SELECT * FROM pm_paperlist WHERE paper_list_size='A3'";
		
		ArrayList<PaperStock> list = new ArrayList<PaperStock>();
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				PaperStock paperStock = new PaperStock();
				paperStock.setPaper_list_no(rs.getInt(1));
				paperStock.setPaper_list_size(rs.getString(2));
				paperStock.setPaper_list_kind(rs.getString(3));
				paperStock.setPaper_list_gram(rs.getString(4));
				paperStock.setPaper_list_quantity_sys(rs.getInt(5));
				paperStock.setPaper_list_quantity_dev(rs.getInt(6));
				paperStock.setPaper_list_quantity_cer(rs.getInt(7));
				paperStock.setPaper_list_quantity_mec(rs.getInt(8));
				paperStock.setPaper_list_quantity_qa(rs.getInt(9));
				list.add(paperStock);				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}
	
	public ArrayList<PaperStock> getPaperStock_A5() {
		String SQL = "SELECT * FROM pm_paperlist WHERE paper_list_size='A5'";
		
		ArrayList<PaperStock> list = new ArrayList<PaperStock>();
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				PaperStock paperStock = new PaperStock();
				paperStock.setPaper_list_no(rs.getInt(1));
				paperStock.setPaper_list_size(rs.getString(2));
				paperStock.setPaper_list_kind(rs.getString(3));
				paperStock.setPaper_list_gram(rs.getString(4));
				paperStock.setPaper_list_quantity_sys(rs.getInt(5));
				paperStock.setPaper_list_quantity_dev(rs.getInt(6));
				paperStock.setPaper_list_quantity_cer(rs.getInt(7));
				paperStock.setPaper_list_quantity_mec(rs.getInt(8));
				paperStock.setPaper_list_quantity_qa(rs.getInt(9));
				list.add(paperStock);				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}
	
	public ArrayList<PaperStock> getPaperStock_B4B5() {
		String SQL = "SELECT * FROM pm_paperlist WHERE paper_list_size='B4' OR paper_list_size='B5'";
		
		ArrayList<PaperStock> list = new ArrayList<PaperStock>();
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				PaperStock paperStock = new PaperStock();
				paperStock.setPaper_list_no(rs.getInt(1));
				paperStock.setPaper_list_size(rs.getString(2));
				paperStock.setPaper_list_kind(rs.getString(3));
				paperStock.setPaper_list_gram(rs.getString(4));
				paperStock.setPaper_list_quantity_sys(rs.getInt(5));
				paperStock.setPaper_list_quantity_dev(rs.getInt(6));
				paperStock.setPaper_list_quantity_cer(rs.getInt(7));
				paperStock.setPaper_list_quantity_mec(rs.getInt(8));
				paperStock.setPaper_list_quantity_qa(rs.getInt(9));
				list.add(paperStock);				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}
	
	public ArrayList<PaperStock> getPaperStock_LTR() {
		String SQL = "SELECT * FROM pm_paperlist WHERE paper_list_size='LTR'";
		
		ArrayList<PaperStock> list = new ArrayList<PaperStock>();
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				PaperStock paperStock = new PaperStock();
				paperStock.setPaper_list_no(rs.getInt(1));
				paperStock.setPaper_list_size(rs.getString(2));
				paperStock.setPaper_list_kind(rs.getString(3));
				paperStock.setPaper_list_gram(rs.getString(4));
				paperStock.setPaper_list_quantity_sys(rs.getInt(5));
				paperStock.setPaper_list_quantity_dev(rs.getInt(6));
				paperStock.setPaper_list_quantity_cer(rs.getInt(7));
				paperStock.setPaper_list_quantity_mec(rs.getInt(8));
				paperStock.setPaper_list_quantity_qa(rs.getInt(9));
				list.add(paperStock);				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}
	
	public ArrayList<PaperStock> getPaperStock_LGLLDR() {
		String SQL = "SELECT * FROM pm_paperlist WHERE paper_list_size='LGL' OR paper_list_size='LDR'";
		
		ArrayList<PaperStock> list = new ArrayList<PaperStock>();
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				PaperStock paperStock = new PaperStock();
				paperStock.setPaper_list_no(rs.getInt(1));
				paperStock.setPaper_list_size(rs.getString(2));
				paperStock.setPaper_list_kind(rs.getString(3));
				paperStock.setPaper_list_gram(rs.getString(4));
				paperStock.setPaper_list_quantity_sys(rs.getInt(5));
				paperStock.setPaper_list_quantity_dev(rs.getInt(6));
				paperStock.setPaper_list_quantity_cer(rs.getInt(7));
				paperStock.setPaper_list_quantity_mec(rs.getInt(8));
				paperStock.setPaper_list_quantity_qa(rs.getInt(9));
				list.add(paperStock);				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}
	
	public ArrayList<PaperStock> getPaperStock_A2A6() {
		String SQL = "SELECT * FROM pm_paperlist WHERE paper_list_size='A2' OR paper_list_size='A6'";
		
		ArrayList<PaperStock> list = new ArrayList<PaperStock>();
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				PaperStock paperStock = new PaperStock();
				paperStock.setPaper_list_no(rs.getInt(1));
				paperStock.setPaper_list_size(rs.getString(2));
				paperStock.setPaper_list_kind(rs.getString(3));
				paperStock.setPaper_list_gram(rs.getString(4));
				paperStock.setPaper_list_quantity_sys(rs.getInt(5));
				paperStock.setPaper_list_quantity_dev(rs.getInt(6));
				paperStock.setPaper_list_quantity_cer(rs.getInt(7));
				paperStock.setPaper_list_quantity_mec(rs.getInt(8));
				paperStock.setPaper_list_quantity_qa(rs.getInt(9));
				list.add(paperStock);				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}
	
	public ArrayList<PaperStock> getPaperStock_EXECSTMT() {
		String SQL = "SELECT * FROM pm_paperlist WHERE paper_list_size='EXEC' OR paper_list_size='STMT'";
		
		ArrayList<PaperStock> list = new ArrayList<PaperStock>();
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				PaperStock paperStock = new PaperStock();
				paperStock.setPaper_list_no(rs.getInt(1));
				paperStock.setPaper_list_size(rs.getString(2));
				paperStock.setPaper_list_kind(rs.getString(3));
				paperStock.setPaper_list_gram(rs.getString(4));
				paperStock.setPaper_list_quantity_sys(rs.getInt(5));
				paperStock.setPaper_list_quantity_dev(rs.getInt(6));
				paperStock.setPaper_list_quantity_cer(rs.getInt(7));
				paperStock.setPaper_list_quantity_mec(rs.getInt(8));
				paperStock.setPaper_list_quantity_qa(rs.getInt(9));
				list.add(paperStock);				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}
	
	public ArrayList<PaperStock> getPaperStock_16K8K() {
		String SQL = "SELECT * FROM pm_paperlist WHERE paper_list_size='K16' OR paper_list_size='K8'";
		
		ArrayList<PaperStock> list = new ArrayList<PaperStock>();
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				PaperStock paperStock = new PaperStock();
				paperStock.setPaper_list_no(rs.getInt(1));
				paperStock.setPaper_list_size(rs.getString(2));
				paperStock.setPaper_list_kind(rs.getString(3));
				paperStock.setPaper_list_gram(rs.getString(4));
				paperStock.setPaper_list_quantity_sys(rs.getInt(5));
				paperStock.setPaper_list_quantity_dev(rs.getInt(6));
				paperStock.setPaper_list_quantity_cer(rs.getInt(7));
				paperStock.setPaper_list_quantity_mec(rs.getInt(8));
				paperStock.setPaper_list_quantity_qa(rs.getInt(9));
				list.add(paperStock);				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}
	
	public ArrayList<PaperStock> getPaperStock_ENV() {
		String SQL = "SELECT * FROM pm_paperlist WHERE paper_list_size LIKE 'ENV%'";
		
		ArrayList<PaperStock> list = new ArrayList<PaperStock>();
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				PaperStock paperStock = new PaperStock();
				paperStock.setPaper_list_no(rs.getInt(1));
				paperStock.setPaper_list_size(rs.getString(2));
				paperStock.setPaper_list_kind(rs.getString(3));
				paperStock.setPaper_list_gram(rs.getString(4));
				paperStock.setPaper_list_quantity_sys(rs.getInt(5));
				paperStock.setPaper_list_quantity_dev(rs.getInt(6));
				paperStock.setPaper_list_quantity_cer(rs.getInt(7));
				paperStock.setPaper_list_quantity_mec(rs.getInt(8));
				paperStock.setPaper_list_quantity_qa(rs.getInt(9));
				list.add(paperStock);				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}
	*/
	
	public ArrayList<PaperStock> getPaperSize() {
		String SQL = "select pinfo_size from pm_paperinfo group by pinfo_size having COUNT (pinfo_size) >= 1";
				
		ArrayList<PaperStock> list = new ArrayList<PaperStock>();
		try {
			pstmt = conn.prepareStatement(SQL);
			
			rs = pstmt.executeQuery();
			while (rs.next()) {
				PaperStock paperStock = new PaperStock();
				paperStock.setPaper_list_size(rs.getString(1));
				list.add(paperStock);				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}
	
	public ArrayList<PaperStock> getPaperType(String paperSize) {
		String SQL = "select pinfo_kind from pm_paperinfo where pinfo_size=? group by pinfo_kind having COUNT (pinfo_kind) >= 1";
			
		ArrayList<PaperStock> list = new ArrayList<PaperStock>();
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, paperSize);
			
			rs = pstmt.executeQuery();
			while (rs.next()) {
				PaperStock paperStock = new PaperStock();
				paperStock.setPaper_list_kind(rs.getString(1));
				list.add(paperStock);				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}
		
	public ArrayList<PaperStock> getPaperGram(String paperSize, String paperType) {
		String SQL = "select pinfo_gram from pm_paperinfo where pinfo_size=? AND pinfo_kind=? group by pinfo_gram having COUNT (pinfo_gram) >= 1";
				
		ArrayList<PaperStock> list = new ArrayList<PaperStock>();
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, paperSize);
			pstmt.setString(2, paperType);
			
			rs = pstmt.executeQuery();
			while (rs.next()) {
				PaperStock paperStock = new PaperStock();
				paperStock.setPaper_list_gram(rs.getString(1));
				list.add(paperStock);				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}
	
	public ArrayList<PaperStock> paperSizeList() {
		String SQL = "SELECT paper_list_no, paper_list_size, paper_list_kind, paper_list_gram FROM pm_paperlist ORDER BY paper_list_size";
		
		ArrayList<PaperStock> list = new ArrayList<PaperStock>();
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				PaperStock paperStock = new PaperStock();
				paperStock.setPaper_list_no(rs.getInt(1));
				paperStock.setPaper_list_size(rs.getString(2));
				paperStock.setPaper_list_kind(rs.getString(3));
				paperStock.setPaper_list_gram(rs.getString(4));
				list.add(paperStock);				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}
	
	public int paperListDel(String delMemberId) {		
		String SQL = "DELETE FROM pm_paperlist where paper_list_no = ?";		
				
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, delMemberId);
			
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int paperListEdit(String paperListEditNo, String paperListEditSize, String paperListEditKind, String paperListEditGram) {
		String SQL = "UPDATE pm_paperlist SET paper_list_size=?, paper_list_kind=?, paper_list_gram=? WHERE paper_list_no=?";
		
		try {
			int paperListEditNoInt = Integer.parseInt(paperListEditNo);
			
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, paperListEditSize);
			pstmt.setString(2, paperListEditKind);
			pstmt.setString(3, paperListEditGram);
			pstmt.setInt(4, paperListEditNoInt);
			
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // DB ERR
	}
	
	public int paperListAdd(String paperListEditSize, String paperListEditKind, String paperListEditGram) {
		int endCol = getPaperListColumns()-4;
		String SQL = "INSERT INTO pm_paperlist VALUES (?, ?, ?, ";
		
		for (int i=0; i<endCol; i++) {
			if(i!=endCol-1)
				SQL = SQL + "0, ";
			else
				SQL = SQL + "0";
		} 
		
		SQL = SQL + ");";
						
		try {
			PreparedStatement psmt = conn.prepareStatement(SQL);
			
			psmt = conn.prepareStatement(SQL);
			psmt.setString(1,  paperListEditSize);
			psmt.setString(2,  paperListEditKind);
			psmt.setString(3,  paperListEditGram);
			
			return psmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // DB 오류
	}
	
	public int getPaperListColumns() {
		String SQL = "SELECT COUNT(*) from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='pm_paperlist';";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				return rs.getInt(1); // 비번 리턴
			}
			else {
				return -1; // 일치하는 정보 없음
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -2;
	}
	
	public int getPaperNo(String paperListEditSize, String paperListEditKind, String paperListEditGram) {
		String SQL = "SELECT paper_list_no FROM pm_paperlist WHERE paper_list_size=? AND paper_list_kind=? AND paper_list_gram=?;";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, paperListEditSize);
			pstmt.setString(2, paperListEditKind);
			pstmt.setString(3, paperListEditGram);
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				return rs.getInt(1); // 비번 리턴
			}
			else {
				return -1; // 일치하는 정보 없음
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -2;
	}
	
	public int updatePaperStock(List<String> expaper, ArrayList<Project> getProjectList, int flag) {
		String paper_list_quantity = null;
		String changeNum = null;
		String size = null;
		String kind = null;
		String gram = null;
		int projectNo = 0;
		String project = null;
		int result = 0;
		
		try {
			for(int i=0; i<expaper.size(); i++) {
				size = expaper.get(i);
				kind = expaper.get(i+1);
				gram = expaper.get(i+2);
				changeNum = expaper.get(i+3);
				projectNo = Integer.parseInt(expaper.get(i+5));
				project = expaper.get(i+6);
								
				for(int j=0; j<getProjectList.size(); j++) {
					if(getProjectList.get(j).getProjectNo()==projectNo) {
						paper_list_quantity = getProjectList.get(j).getProjectPaperListName();
						
					}
				}
				
				i=i+7;
				
				String SQL = null;
				
				if(flag == 1) {
					SQL = "UPDATE pm_paperlist SET "+paper_list_quantity+" = "+paper_list_quantity+"-"+changeNum+" where paper_list_size='"+size
						+"' AND paper_list_kind='"+kind+"' AND paper_list_gram='"+gram+"';";
				}
				else if(flag == 0) {					
					SQL = "UPDATE pm_paperlist SET "+paper_list_quantity+" = "+paper_list_quantity+"+"+changeNum+" where paper_list_size='"+size
						+"' AND paper_list_kind='"+kind+"' AND paper_list_gram='"+gram+"';";
				}
				
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				result = pstmt.executeUpdate();
			}
					
			return result;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // DB ERR
	}
	
	public int getpaperStockSum(String sumPart) {
		String SQL = "SELECT SUM("+sumPart+") FROM pm_paperlist;";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				return rs.getInt(1); // 비번 리턴
			}
			else {
				return -1; // 일치하는 정보 없음
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -2;
	}
	
	public int delPartDevPlus(ArrayList<Project> delPartColName) {
		String SQL = "UPDATE pm_paperlist SET paper_list_quantity_dev_2 = paper_list_quantity_dev_2 + ";
		
		for (int i=0; i<delPartColName.size(); i++) {
			SQL = SQL + delPartColName.get(i).getProjectPaperListName();
			
			if (i!=delPartColName.size()-1) {
				SQL = SQL + " + ";
			}
		}
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // DB ERR
	}
	
	public int stockEct(String partNo, String paperlistName) {
		ProjectDAO projectDAO = new ProjectDAO();
		ArrayList<Project> getProjectList = projectDAO.allPartProjectList1();
		String ectColName = null;
		
		for (int i=0; i<getProjectList.size(); i++) {
			if (getProjectList.get(i).getProjectPartNo()==Integer.parseInt(partNo) && getProjectList.get(i).getProjectName().contentEquals("기타")) {
				ectColName = getProjectList.get(i).getProjectPaperListName();
			}
		}
		
		String SQL = "UPDATE pm_paperlist SET " + ectColName + " = " + ectColName + "+" + paperlistName;
			
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // DB ERR
	}
	
	public boolean delRow(ArrayList<Project> delPartColName) {
		String SQL = "ALTER TABLE pm_paperlist DROP COLUMN ";
		
		for (int i=0; i<delPartColName.size(); i++) {
			SQL = SQL + delPartColName.get(i).getProjectPaperListName();
			
			if (i!=delPartColName.size()-1) {
				SQL = SQL + ", ";
			}
		}
		
		try {
			PreparedStatement psmt;
			psmt = conn.prepareStatement(SQL);
			
			return psmt.execute();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return true; 
	}
	
	public boolean delProject(String colName) {
		String SQL = "ALTER TABLE pm_paperlist DROP COLUMN "+colName;
		
		try {
			PreparedStatement psmt;
			psmt = conn.prepareStatement(SQL);
			
			return psmt.execute();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return true; 
	}
	
	/***************************************************************************************************************/
	public List<String> temp(String name) {
		String SQL = "SELECT "+name+" FROM pm_paperlist ORDER BY paper_list_size";
		
		List<String> list = new ArrayList<String>();
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				
				list.add(rs.getString(1));				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}
}



		

