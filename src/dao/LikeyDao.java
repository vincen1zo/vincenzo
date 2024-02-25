package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import common.DBConnection;
import vo.LikeyProductVo;

public class LikeyDao {
	public ArrayList<LikeyProductVo> getListLikeyProductVo(String memberId) {
		ArrayList<LikeyProductVo> listRet = new ArrayList<LikeyProductVo>();
		Connection conn = DBConnection.getConnection();
		
		String sql ="SELECT l.product_idx, p.brand_name, p.name, p.discount, "
					+ " p.after_price, p.star_review_avg, p.free_deli, pmi.img_idx,"
					+ " pmi.img_url"  
			 		+ " FROM likey l, product p, product_main_img pmi"  
					+ " WHERE l.product_idx=p.product_idx "  
					+ " AND p.product_idx=pmi.product_idx"  
					+ " AND pmi.img_idx=1"  
					+ " AND l.member_id=? ";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberId);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				String likeDate = rs.getString("like_date");
				int productIdx = rs.getInt("product_idx");
				String brandName = rs.getString("brand_name");
				String name = rs.getString("name");
				int discount = rs.getInt("discount");
				int afterPrice = rs.getInt("after_price");
				double starReviewAvg = rs.getDouble("star_review_avg");
				int freeDeli = rs.getInt("free_deli");
				int category = rs.getInt("category");
				int imgIdx = rs.getInt("img_idx");
				String imgUrl = rs.getString("img_url");
				LikeyProductVo vo = new LikeyProductVo(memberId, likeDate, productIdx, brandName,
						name, discount, afterPrice, starReviewAvg, freeDeli, category, 
						imgIdx, imgUrl);
				listRet.add(vo);
			}
			rs.close();
			pstmt.close();
			conn.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}
		return listRet;
	}

	// 실행결과에 따라서, "INSERTED" 또는 "DELETED" 를 리턴함.
	//집들이 좋아요 버튼
	public String insertOrDeleteHousepartyLikey(String memberId, int housepartyIdx) {
		Connection conn = DBConnection.getConnection();
		String sql = "SELECT count(*) FROM likey WHERE member_id=? AND houseparty_idx=?";
		int cnt = 0;
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberId);
			pstmt.setInt(2, housepartyIdx);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				cnt = rs.getInt(1);
			}
			rs.close();
			pstmt.close();
		} catch(SQLException e) { 
			e.printStackTrace(); 
		}

		String result = "";
		if(cnt>0) {
			sql = "DELETE FROM likey WHERE member_id=? AND houseparty_idx=?";
			result = "DELETED";
		} else {
			sql = "INSERT INTO likey(member_id, houseparty_idx, like_date) VALUES (?, ?, sysdate)";
			result = "INSERTED";
		}
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberId);
			pstmt.setInt(2, housepartyIdx);
			pstmt.executeUpdate();
			pstmt.close();
		} catch(SQLException e) { e.printStackTrace(); }
		
		return result;
	}
	//상품 좋아요 버튼
	public String insertOrDeleteProductLikey(String memberId, int productIdx) {
		Connection conn = DBConnection.getConnection();
		String sql = "SELECT count(*) FROM likey WHERE member_id=? AND product_idx=?";
		int cnt = 0;
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberId);
			pstmt.setInt(2, productIdx);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next() ) {
				cnt = rs.getInt(1);
			}
			rs.close();
			pstmt.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}
		
		String result = "";
		if(cnt>0) {
			sql = "DELETE FROM likey WHERE member_id=? AND product_idx=?";
			result = "DELETED";
		} else {
			sql = "INSERT INTO likey(member_id, product_idx, like_date) VALUES (?, ?, sysdate)";
			result = "INSERTED";
		}
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberId);
			pstmt.setInt(2, productIdx);
			pstmt.executeUpdate();
			pstmt.close();
		} catch(SQLException e) { 
			e.printStackTrace(); 
		}
		return result;
	}
}