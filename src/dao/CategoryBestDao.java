package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import common.DBConnection;
import vo.*;

public class CategoryBestDao {
	//상품 목록 중 이미지 제외한 모든정보
	public ArrayList<ProductVo> getAllProductVoList() { 
		Connection conn = DBConnection.getConnection();
		ArrayList<ProductVo> cbRet = new ArrayList<ProductVo>();
		String sql = "SELECT * FROM product"; 
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql); 
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) { 
				int productIdx = rs.getInt("product_idx");
				String brandName = rs.getString("brand_name");
				String name = rs.getString("name");
				int discount = rs.getInt("discount"); 
				int beforePrice = rs.getInt("before_price");
				int afterPrice = rs.getInt("after_price");
				double starReviewAvg = rs.getDouble("star_review_avg"); 
				int freeDeli = rs.getInt("free_deli"); 
				int category = rs.getInt("category"); 
				ProductVo pvs = new ProductVo(productIdx, brandName, name, discount, beforePrice, afterPrice, starReviewAvg, freeDeli, category);
				cbRet.add(pvs); 
				} 
			rs.close();
			pstmt.close();
			conn.close();
			} catch(SQLException e) {
				e.printStackTrace(); 
			} 
		return cbRet;
	}
	//상품 목록 all
	public ArrayList<ProductAllVo> getAllProductAllVoList() {
		Connection conn = DBConnection.getConnection();
		ArrayList<ProductAllVo> paRet = new ArrayList<ProductAllVo>();
		String sql = "SELECT p.product_idx, p.brand_name, p.name, p.discount, p.after_price, p.star_review_avg, pmi.img_url, pmi.img_idx"  
					+ " FROM product p, product_main_img pmi"  
					+ " WHERE p.product_idx = pmi.product_idx"  
					+ " AND pmi.img_idx =1";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				int productIdx = rs.getInt("product_idx");
				String brandName = rs.getString("brand_name");
				String name = rs.getString("name");
				int discount = rs.getInt("discount");
				int afterPrice = rs.getInt("after_price");
				double starReviewAvg = rs.getDouble("star_review_avg");
				String imgUrl = rs.getString("img_url");
				int imgIdx = rs.getInt("img_idx");
				ProductAllVo pav = new ProductAllVo(productIdx, brandName, name, discount, afterPrice, starReviewAvg, imgUrl, imgIdx);
				paRet.add(pav);
			}
		rs.close();
		pstmt.close();
		conn.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}
		return paRet;
	}
	
	public String getDepth1ByCategoryIdx(int categoryIdx) {
		Connection conn = DBConnection.getConnection();
		String strRet = "";
		String sql = "select depth0 from category where category_idx=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql); 
			pstmt.setInt(1, categoryIdx);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) { 
				strRet = rs.getString("depth0");
			}
			rs.close();
			pstmt.close();
			conn.close();
		} catch(SQLException e) { e.printStackTrace(); }
		return strRet;
	}

	public ArrayList<ProductVo> getAllProductVoListByCateNames(String cateName1, String cateName2, String cateName3) {
		Connection conn = DBConnection.getConnection();
		ArrayList<ProductVo> cbRet = new ArrayList<ProductVo>();
		String sql = "";
		sql = "SELECT category_idx FROM category WHERE depth1=? AND depth2=? AND depth3=?";
		int categoryIdx = 0;
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, cateName1);
			pstmt.setString(2, cateName2);
			pstmt.setString(3, cateName3);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) { 
				categoryIdx = rs.getInt(1);
			}
			rs.close();
			pstmt.close();
		} catch(SQLException e) { e.printStackTrace(); }
		
		sql = "SELECT * FROM product WHERE category=?"; 
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, categoryIdx);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) { 
				int productIdx = rs.getInt("product_idx");
				String brandName = rs.getString("brand_name");
				String name = rs.getString("name");
				int discount = rs.getInt("discount"); 
				int beforePrice = rs.getInt("before_price");
				int afterPrice = rs.getInt("after_price");
				double starReviewAvg = rs.getDouble("star_review_avg"); 
				int freeDeli = rs.getInt("free_deli"); 
				int category = rs.getInt("category"); 
				ProductVo pvs = new ProductVo(productIdx, brandName, name, discount, beforePrice, afterPrice, starReviewAvg, freeDeli, category);
				cbRet.add(pvs); 
			} 
			rs.close();
			pstmt.close();
			conn.close();
		} catch(SQLException e) {
			e.printStackTrace(); 
		} 
		return cbRet;
	}
}

