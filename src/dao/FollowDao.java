package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import common.DBConnection;

public class FollowDao {	
	public String insertOrDeleteHousepartyFollow(String memberId, String followedMemberId) {
		Connection conn = DBConnection.getConnection();
		String sql = "SELECT count(*) FROM follow WHERE member_id=? AND followed_member_id=?";
		int cnt = 0;
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberId);
			pstmt.setString(2, followedMemberId);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				cnt = rs.getInt(1);
			}
			rs.close();
			pstmt.close();
		} catch(SQLException e) { e.printStackTrace(); }
		
		String result = "";
		if(cnt>0) {
			sql = "DELETE FROM follow WHERE member_id=? AND followed_member_id=?";
			result = "DELETED";
		} else {
			sql = "INSERT INTO follow(member_id, followed_member_id, follow_date) VALUES (?,?,sysdate)";
			result = "INSERTED";
		}
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberId);
			pstmt.setString(2, followedMemberId);
			pstmt.executeUpdate();
			pstmt.close();
		} catch(SQLException e) { e.printStackTrace(); }
		return result;
	}
}