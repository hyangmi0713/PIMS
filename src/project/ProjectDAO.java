package project;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;

import part.Part;
import part.PartDAO;

public class ProjectDAO {
	private Connection conn;
	private PreparedStatement psmt;
	private ResultSet rs;

	public ProjectDAO() {
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
	
	public int projectAdd(String projectName, String [] projectPart) {	
		String SQL = "INSERT INTO pm_project VALUES (?, ?, ?, ?)";
		
		try {
			PartDAO partListDAO = new PartDAO();
			ArrayList<Part> getPartList = partListDAO.allPartList();
			
			int projectPartNo = 0;
			String projectPartName = null;
			
			int result = 0;
			
			for(int i=0; i<getPartList.size(); i++) {
				for(int j=0; j<projectPart.length; j++) {
					if(getPartList.get(i).getPartNo() == Integer.parseInt(projectPart[j])) {
						projectPartNo = getPartList.get(i).getPartNo(); 
						projectPartName = getPartList.get(i).getPartName();
						
						psmt = conn.prepareStatement(SQL);
						psmt.setString(1,  projectName);
						psmt.setInt(2,  projectPartNo);
						psmt.setString(3,  projectPartName);
						psmt.setString(4,  "0");
						
						result = psmt.executeUpdate();
					}
				}
			}
			
			return result;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; 
	}
	
	public int projectAddEct(String projectName, String projectPart) {	
		String SQL = "INSERT INTO pm_project VALUES (?, ?, ?, ?)";
		
		try {
			PartDAO partListDAO = new PartDAO();
			ArrayList<Part> getPartList = partListDAO.allPartList();
			
			int projectPartNo = 0;
			String projectPartName = null;
			
			int result = 0;
			
			for(int i=0; i<getPartList.size(); i++) {
				if(getPartList.get(i).getPartNo() == Integer.parseInt(projectPart)) {
					projectPartNo = getPartList.get(i).getPartNo(); 
					projectPartName = getPartList.get(i).getPartName();
					
					psmt = conn.prepareStatement(SQL);
					psmt.setString(1,  projectName);
					psmt.setInt(2,  projectPartNo);
					psmt.setString(3,  projectPartName);
					psmt.setString(4,  "0");
					
					result = psmt.executeUpdate();
				}
			}
			
			return result;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; 
	}
	
	public ArrayList<Project> allProjectList() {
		String SQL = "SELECT * FROM pm_project WHERE project_paperlist_name='0'";
		ArrayList<Project> projectInfo = new ArrayList<Project>();
		
		try {
			psmt = conn.prepareStatement(SQL);
			rs = psmt.executeQuery();
			while (rs.next()) {
				Project projectlist = new Project();
				projectlist.setProjectNo(rs.getInt(1));
				projectlist.setProjectName(rs.getString(2));
				projectlist.setProjectPartNo(rs.getInt(3));
				projectlist.setProjectPartName(rs.getString(4));
				projectInfo.add(projectlist);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return projectInfo; 
	}
	
	public ArrayList<Project> myProjectList(String getUserPart) {
		String SQL = "SELECT project_no, project_name FROM pm_project WHERE project_part_name=?;";
		ArrayList<Project> projectInfo = new ArrayList<Project>();
		
		try {
			psmt = conn.prepareStatement(SQL);
			psmt.setString(1, getUserPart);
			rs = psmt.executeQuery();
			while (rs.next()) {
				Project projectlist = new Project();
				projectlist.setProjectNo(rs.getInt(1));
				projectlist.setProjectName(rs.getString(2));
				projectInfo.add(projectlist);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return projectInfo; 
	}
	
	public ArrayList<Project> allPartProjectList() {
		String SQL = "SELECT * FROM pm_project";
		ArrayList<Project> projectInfo = new ArrayList<Project>();
		
		try {
			psmt = conn.prepareStatement(SQL);
			rs = psmt.executeQuery();
			while (rs.next()) {
				Project projectlist = new Project();
				projectlist.setProjectNo(rs.getInt(1));
				projectlist.setProjectName(rs.getString(2));
				projectlist.setProjectPartNo(rs.getInt(3));
				projectlist.setProjectPartName(rs.getString(4));
				projectInfo.add(projectlist);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return projectInfo; 
	}
	
	public ArrayList<Project> allPartProjectList1() {
		String SQL = "SELECT * FROM pm_project";
		ArrayList<Project> projectInfo = new ArrayList<Project>();
		
		try {
			psmt = conn.prepareStatement(SQL);
			rs = psmt.executeQuery();
			while (rs.next()) {
				Project projectlist = new Project();
				projectlist.setProjectNo(rs.getInt(1));
				projectlist.setProjectName(rs.getString(2));
				projectlist.setProjectPartNo(rs.getInt(3));
				projectlist.setProjectPartName(rs.getString(4));
				projectlist.setProjectPaperListName(rs.getString(5));
				projectInfo.add(projectlist);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return projectInfo; 
	}
	
	public ArrayList<Project> allPartProjectListWithoutEct() {
		String SQL = "SELECT * FROM pm_project WHERE project_name != '±‚≈∏' ORDER BY project_part_name";
		ArrayList<Project> projectInfo = new ArrayList<Project>();
		
		try {
			psmt = conn.prepareStatement(SQL);
			rs = psmt.executeQuery();
			while (rs.next()) {
				Project projectlist = new Project();
				projectlist.setProjectNo(rs.getInt(1));
				projectlist.setProjectName(rs.getString(2));
				projectlist.setProjectPartNo(rs.getInt(3));
				projectlist.setProjectPartName(rs.getString(4));
				projectlist.setProjectPaperListName(rs.getString(5));
				projectInfo.add(projectlist);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return projectInfo; 
	}
	
	public boolean createRow(String rowName) {
		String SQL = "ALTER TABLE pm_paperlist ADD "+rowName+" int";
		
		try {
			psmt = conn.prepareStatement(SQL);
			
			return psmt.execute();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return true; 
	}
	
	public int createRowDefault(String rowName) {
		String SQL = "update pm_paperlist set "+rowName+" = 0;";

		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // DB ERR
	}
	
	public int changePaperlistName(String rowName, int projectNo) {
		String SQL = "UPDATE pm_project SET project_paperlist_name=? WHERE project_no=?";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, rowName);
			pstmt.setInt(2, projectNo);
			
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // DB ERR
	}
	
	public ArrayList<Project> getPaperListName(int partNum) {
		String partNo = null;
		
		if (partNum == 1) {
			partNo = "sys";
		}
		else if (partNum == 2) {
			partNo = "dev";
		}
		else if (partNum == 3) {
			partNo = "cer";
		}	
		else if (partNum == 4) {
			partNo = "mec";
		}
		else {
			partNo = Integer.toString(partNum);
		}
				
		String SQL = "SELECT project_paperlist_name FROM pm_project WHERE project_paperlist_name LIKE 'paper_list_quantity_"+partNo+"_%'";
		ArrayList<Project> projectInfo = new ArrayList<Project>();
		
		try {
			psmt = conn.prepareStatement(SQL);
			rs = psmt.executeQuery();
			while (rs.next()) {
				Project projectlist = new Project();
				projectlist.setProjectPaperListName(rs.getString(1));
				projectInfo.add(projectlist);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return projectInfo; 
	}
	
	public ArrayList<Project> getDelPartColName(String PartNo) {
		String SQL = "SELECT project_paperlist_name FROM pm_project WHERE project_part_no=?";
		ArrayList<Project> projectInfo = new ArrayList<Project>();
		
		try {
			psmt = conn.prepareStatement(SQL);
			psmt.setString(1, PartNo);
			rs = psmt.executeQuery();
			while (rs.next()) {
				Project projectlist = new Project();
				projectlist.setProjectPaperListName(rs.getString(1));
				projectInfo.add(projectlist);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return projectInfo; 
	}
	
	public int projectDel(String delProject) {		
		String SQL = "DELETE FROM pm_project where project_paperlist_name = ?";		
				
		try {
			psmt = conn.prepareStatement(SQL);
			psmt.setString(1, delProject);
			
			return psmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
}
