package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;

import user.User;

public class UserDAO {
	private Connection conn;
	private PreparedStatement psmt;
	private ResultSet rs;

	public UserDAO() {
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

	public int login(String userID, String userPassword) {
		if (userID == null)
			return 2; // 미입력값 있음

		String SQL = "SELECT mem_pw FROM pm_memberlist WHERE mem_id = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				if (rs.getString(1).equals(userPassword)) {
					return 1;
				} else
					return 0;
			}
			return -1;

		} catch (Exception e) {
			e.printStackTrace();
		}
		return -2;
	}

	public String findpw(String menId, String menName, String menPart) {
		String SQL = "SELECT mem_pw FROM pm_memberlist WHERE mem_id=? AND mem_name=? AND mem_department=?";

		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, menId);
			pstmt.setString(2, menName);
			pstmt.setString(3, menPart);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				return rs.getString(1); // 비번 리턴
			} else {
				return "-1"; // 일치하는 정보 없음
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null; // DB ERR
	}

	public PreparedStatement getPsmt() {
		return psmt;
	}

	public void setPsmt(PreparedStatement psmt) {
		this.psmt = psmt;
	}

	public int changepw(String menId, String menPw) {
		String SQL = "UPDATE pm_memberlist SET mem_pw=? WHERE mem_id=?";

		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, menPw);
			pstmt.setString(2, menId);

			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // DB ERR
	}

	public String finduserpart(String menId) {
		String SQL = "SELECT mem_department FROM pm_memberlist WHERE mem_id=?";

		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, menId);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				return rs.getString(1); // 비번 리턴
			} else {
				return "-1"; // 일치하는 정보 없음
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null; // DB ERR
	}

	public String findusername(String menId) {
		String SQL = "SELECT mem_name FROM pm_memberlist WHERE mem_id=?";

		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, menId);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				return rs.getString(1); // 비번 리턴
			} else {
				return "-1"; // 일치하는 정보 없음
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null; // DB ERR
	}

	public int findusergrade(String menId) {
		String SQL = "SELECT mem_grade FROM pm_memberlist WHERE mem_id=?";

		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, menId);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				return rs.getInt(1); // 비번 리턴
			} else {
				return -1; // 일치하는 정보 없음
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -2; // DB ERR
	}

	public int idOverlapCheck(String userID) throws Exception {
		int re = 0;

		try {
			String SQL = "SELECT mem_id FROM pm_memberlist WHERE mem_id=?";
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				re = 1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return re;
	}

	public int memberJoin(User memId) {
		String SQL = "INSERT INTO pm_memberlist VALUES (?, ?, ?, ?, ?)";

		try {
			psmt = conn.prepareStatement(SQL);
			psmt.setString(1, memId.getUserID());
			psmt.setString(2, "1234");
			psmt.setString(3, memId.getUserName());
			psmt.setString(4, memId.getUserPart());
			psmt.setString(5, memId.getUserGrade());

			return psmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // DB 오류
	}

	public ArrayList<User> allUserList() {
		String SQL = "SELECT * FROM pm_memberlist";
		ArrayList<User> userInfo = new ArrayList<User>();

		try {
			psmt = conn.prepareStatement(SQL);
			rs = psmt.executeQuery();
			while (rs.next()) {
				User memberlist = new User();
				memberlist.setUserID(rs.getString(2));
				memberlist.setUserPassword(rs.getString(3));
				memberlist.setUserName(rs.getString(4));
				memberlist.setUserPart(rs.getString(5));
				memberlist.setUserGrade(rs.getString(6));
				userInfo.add(memberlist);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return userInfo;
	}

	public ArrayList<User> editUserList(String userID) {
		String SQL = "SELECT * FROM pm_memberlist WHERE mem_id=?";
		ArrayList<User> userInfo = new ArrayList<User>();

		try {
			psmt = conn.prepareStatement(SQL);
			psmt.setString(1, userID);
			rs = psmt.executeQuery();
			while (rs.next()) {
				User memberlist = new User();
				memberlist.setUserID(rs.getString(2));
				memberlist.setUserPassword(rs.getString(3));
				memberlist.setUserName(rs.getString(4));
				memberlist.setUserPart(rs.getString(5));
				memberlist.setUserGrade(rs.getString(6));
				userInfo.add(memberlist);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return userInfo;
	}

	public int memberEdit(String userEditID, String userEditPW, String userEditName, String userEditPart,
			int userEditGrade) {
		String SQL = "UPDATE pm_memberlist SET mem_pw=?, mem_name=?, mem_department=?, mem_grade=? WHERE mem_id=?";

		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userEditPW);
			pstmt.setString(2, userEditName);
			pstmt.setString(3, userEditPart);
			pstmt.setInt(4, userEditGrade);
			pstmt.setString(5, userEditID);

			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // DB ERR
	}

	public int memberDel(String delMemberId) {
		String SQL = "DELETE FROM pm_memberlist where mem_id = ?";

		try {
			psmt = conn.prepareStatement(SQL);
			psmt.setString(1, delMemberId);

			return psmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
}
