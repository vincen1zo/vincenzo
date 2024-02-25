package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.sql.SQLException;

import common.DBConnection;
import vo.ODealVo;
import vo.ProductMainImgVo;

public class ODealDao {
	public ArrayList<ODealVo> getODealVoByProductIdx() {
		ArrayList<ODealVo> Odeals = new ArrayList<ODealVo>();
		Connection conn = DBConnection.getConnection();
		ODealVo voRet = null;
		
		String sql = " SELECT * "
					+ " FROM product p, o_deal od "
					+ " WHERE p.product_idx = od.product_idx";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				int pd_idx = rs.getInt("product_idx");
				String brandName = rs.getString("brand_name");
				String name = rs.getString("name");
				int discount = rs.getInt("discount");
				int afterPrice = rs.getInt("after_price");
				double starReviewAvg = rs.getDouble("star_review_avg");
				int freeDeli = rs.getInt("free_deli");
				String openDate = rs.getString("open_date");
				String closeDate = rs.getString("close_date");
				voRet = new ODealVo(pd_idx, brandName, name, discount, afterPrice, starReviewAvg, freeDeli, openDate, closeDate);
				Odeals.add(voRet);
			}
			pstmt.close();
			conn.close();
			rs.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}
		return Odeals;
	}
}