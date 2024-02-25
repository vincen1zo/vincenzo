package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import common.DBConnection;
import vo.*;

public class CommunityMainDao {
	public ArrayList<UserSearchVo> getUserBySearch(String uId, String searchWord) {
		
System.out.println(uId + " / " + searchWord);		
		
		// searchWord에 해당하는 유저를 검색하고, 해당 유저가 uId와 팔로우관계인지 아닌지 판별하여 리스트로 반환
		searchWord = "%" + searchWord + "%";
		
		Connection conn = DBConnection.getConnection();
		ArrayList<UserSearchVo> usRet = new ArrayList<UserSearchVo>();
		String sql = "SELECT member_id, profile_img"
					+ " FROM member"
					+ " WHERE member_id like ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, searchWord);
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()) {
				String memberId = rs.getString("member_id");
				String profileImg = rs.getString("profile_img");
				
				if(uId != null) {
					if(uId.equals(memberId))
						continue;
					// 현재 로그인 중이라면 검색 유저와 로그인 계정과의 팔로잉 관계를 파악
					String sql2 = "SELECT count(*)" 
							+ " FROM follow"
							+ " WHERE member_id = ?"
							+ " AND followed_member_id = ?";
					PreparedStatement pstmt2 = conn.prepareStatement(sql2);
					pstmt2.setString(1, uId);
					pstmt2.setString(2, memberId);
					ResultSet rs2 = pstmt2.executeQuery();
					if(rs2.next()) {
						int following = rs2.getInt(1);
						boolean isFollowing = (following == 1 ? true : false);
						usRet.add(new UserSearchVo(profileImg, memberId, isFollowing));
						System.out.println("유저 : " + memberId + " , 프로필사진 : " + profileImg + " , " + uId + "랑 팔로우중임? : " + isFollowing);
					}
					rs2.close();
					pstmt2.close();
				} else {
					usRet.add(new UserSearchVo(profileImg, memberId, false));
					System.out.println("유저 : " + memberId + " , 프로필사진 : " + profileImg + " , 로그인중 아님");
				}
			}
			rs.close();
			pstmt.close();
			conn.close();
		} catch(SQLException e) {
			e.printStackTrace();
		} catch(NullPointerException e) {
			e.printStackTrace();
		}
		
		return usRet;
	}
	//어서와 모던 집들이는 처음이지?
	public ArrayList<HomeMainHpVo> getAllHomeMainHpVo() {
		Connection conn = DBConnection.getConnection();
		ArrayList<HomeMainHpVo> hmhRet = new ArrayList<HomeMainHpVo>();
		String sql = "SELECT * FROM home_main_hp";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()) {
				int housepartyIdx = rs.getInt("houseparty_idx");
				String subheadColor = rs.getString("subhead_color");
				String subhead = rs.getString("subhead");
				String coverImg = null;
				
				String sql2 = "SELECT h.cover_img cover_img "
							+ "	FROM houseparty h, home_main_hp hmh "
							+ " WHERE hmh.houseparty_idx = h.houseparty_idx "
							+ " AND hmh.houseparty_idx = ?";
				try {
					PreparedStatement pstmt2 = conn.prepareStatement(sql2);
					pstmt2.setInt(1, housepartyIdx);
					ResultSet rs2 = pstmt2.executeQuery();
					if(rs2.next()) {
						coverImg = rs2.getString("cover_img");
						hmhRet.add(new HomeMainHpVo(housepartyIdx, subheadColor,
									subhead, coverImg));
					}
					rs2.close();
					pstmt2.close();
				} catch(SQLException e) {
					e.printStackTrace();
				}
			}
			rs.close();
			pstmt.close();
			conn.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}
		return hmhRet;
	}
	
	//인테리어 리뷰 목록
	public ArrayList<UserInteriorReviewVo> getListUserInteriorReviewVo() {
		Connection conn = DBConnection.getConnection();
		ArrayList<UserInteriorReviewVo> listRet = new ArrayList<UserInteriorReviewVo>();
		String sql = "SELECT ir.review_idx, iri.img_url, i.name, ir.content"  
				+ " FROM interior_review ir, interior i, interior_review_img iri"  
				+ " WHERE ir.interior_idx = i.interior_idx" 
				+ " AND ir.review_idx = iri.review_idx" 
				+ " AND iri.img_order = (SELECT min(img_order) FROM interior_review_img WHERE review_idx=ir.review_idx)"  
				+ " ORDER BY review_idx DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				int reviewIdx = rs.getInt("review_idx");
				String imgUrl = rs.getString("img_url");
				String name = rs.getString("name");
				String content = rs.getString("content");
				UserInteriorReviewVo vo = new UserInteriorReviewVo(reviewIdx, imgUrl, name, content);
				listRet.add(vo);
			}
			rs.close();
			pstmt.close();
			conn.close();
		} catch(SQLException e) { e.printStackTrace(); }
		return listRet;
	}
}
