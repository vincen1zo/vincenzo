package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import common.DBConnection;
import vo.newVo;

public class newDao {

	//새소식 select
	public ArrayList<newVo> getNewVo(String memberId){
		ArrayList<newVo> listNew = new ArrayList<newVo>();
		Connection conn = DBConnection.getConnection();
		String sql = "SELECT  profile_img, send_member_id, who_member_id, sentence, wheen"
				+ " FROM    new"
				+ " WHERE   send_member_id= ? ";
		try {
			System.out.println("여기까진 나옴" + memberId);
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberId);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				String profileImg = rs.getString("profile_img");
				memberId = rs.getString("send_member_id");
				String whoMemberId = rs.getString("who_member_id");
				String sentence = rs.getString("sentence");
				String wheen = rs.getString("wheen");
				newVo vo = new newVo(profileImg, memberId, whoMemberId, sentence, wheen);
				listNew.add(vo);
				System.out.println("listsize : " + listNew.size());
			}
			rs.close();
			pstmt.close();
			conn.close();
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return listNew;
	}
	
	// insert 
	public void getNewInsert(String profileImg, String memberId, String sentence, String img) {
		Connection conn = DBConnection.getConnection();
		
		String sql = "INSERT INTO new(profile_img, member_id, sentence, wheen, img)"
				+ " VALUES(?, ?, ?, sysdate, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, profileImg);
			pstmt.setString(2, memberId);
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
	}
}
