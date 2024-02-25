package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import common.DBConnection;
import vo.AptConReviewVo;
import vo.AptDetailVo;
import vo.AptReveiwPhotoVo;
import vo.AptSigongConVo;
import vo.AptVo;
import vo.AptSigongReviewVo;
public class AptDao {
	
	//아파트메인
	
	public ArrayList<AptVo> getSubscriptionListNearby(double lat, double lng) {
		ArrayList<AptVo> listRet = new ArrayList<AptVo>();
		Connection conn = DBConnection.getConnection();
		String sql = "SELECT (power(latitude-?,2)+power(longitude-?,2)) 거리 , a.* FROM apt a WHERE noh IS NULL ORDER BY 거리";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setDouble(1, lat);
			pstmt.setDouble(2, lng);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				int aptIdx = rs.getInt("apt_idx");
				String homeType = rs.getString("home_type");
				String name = rs.getString("name");
				//int noh = rs.getInt("noh");   // 세대수 
				//String dateCompletion = rs.getString("date_completion");
				String address = rs.getString("address");
				double latitude = rs.getDouble("latitude");
				double longitude = rs.getDouble("longitude");
				//int dong = rs.getInt("dong");
				//int parking = rs.getInt("parking");
				AptVo vo = new AptVo(aptIdx, homeType, name, 0, "", address, latitude, longitude, 0, 0);
				listRet.add(vo);
			}
			rs.close();
			pstmt.close();
			conn.close();
		} catch(SQLException e) { e.printStackTrace(); }
		return listRet;
	}
	public ArrayList<AptVo> getAptListNearby(double lat, double lng) {
		ArrayList<AptVo> listRet = new ArrayList<AptVo>();
		Connection conn = DBConnection.getConnection();
		String sql = "select (power(latitude-?,2)+power(longitude-?,2)) 거리 ,a.* from apt a order by 거리";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setDouble(1, lat);
			pstmt.setDouble(2, lng);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				int aptIdx = rs.getInt("apt_idx");
				String homeType = rs.getString("home_type");
				String name = rs.getString("name");
				int noh = rs.getInt("noh");   // 세대수 
				String dateCompletion = rs.getString("date_completion");
				String address = rs.getString("address");
				double latitude = rs.getDouble("latitude");
				double longitude = rs.getDouble("longitude");
				int dong = rs.getInt("dong");
				int parking = rs.getInt("parking");
				AptVo vo = new AptVo(aptIdx, homeType, name, noh, dateCompletion, address, latitude, longitude, dong, parking);
				listRet.add(vo);
			}
			rs.close();
			pstmt.close();
			conn.close();
		} catch(SQLException e) { e.printStackTrace(); }
		return listRet;
	}
	
	public AptVo getAptVoByAptIdx(int aptIdx) {
		AptVo vo = null;
		Connection conn = DBConnection.getConnection();
		String sql = "SELECT * FROM apt WHERE apt_idx=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setDouble(1, aptIdx);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				String homeType = rs.getString("home_type");
				String name = rs.getString("name");
				int noh = rs.getInt("noh");   // 세대수 
				String dateCompletion = rs.getString("date_completion");
				String address = rs.getString("address");
				double latitude = rs.getDouble("latitude");
				double longitude = rs.getDouble("longitude");
				int dong = rs.getInt("dong");
				int parking = rs.getInt("parking");
				vo = new AptVo(aptIdx, homeType, name, noh, dateCompletion, address, latitude, longitude, dong, parking);
			}
			rs.close();
			pstmt.close();
			conn.close();
		} catch(SQLException e) { e.printStackTrace(); }
		return vo;
	}
	
	//아파트디테일
	//평수 + 집들이
	public ArrayList<AptDetailVo> getlistAptDetail(int aptIdx){
		ArrayList<AptDetailVo> listAptDetail = new ArrayList<AptDetailVo>();
		
		Connection conn = DBConnection.getConnection();
		String sql = "SELECT  apt.apt_idx, apt.home_type, apt.name, apt.noh, apt.date_completion, ap.apt_py_idx, ap.py, ap.py_type, ap.img_url, "
				+ " 		  ap.py1, ap.py2, ap.noh AS \"pyTypeNho\", ap.room, ap.bath, h.houseparty_idx,h.cover_img, h.title"
				+ " FROM    apt apt, apt_py ap, houseparty h"
				+ " WHERE   apt.apt_idx = ap.apt_idx"
				+ "        AND ap.houseparty_idx = h.houseparty_idx(+)"
				+ "        AND apt.apt_idx = ? ";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, aptIdx);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				 aptIdx = rs.getInt("apt_idx");
				 String homeType = rs.getString("home_type");
				 String name = rs.getString("name");
				 int noh = rs.getInt("noh");  
				 String dateCompletion = rs.getString("date_completion");
				 int aptPyIdx = rs.getInt("apt_py_idx");
				 int py = rs.getInt("py");
				 String pyType = rs.getString("py_type");
				 String imgUrl = rs.getString("img_url");
				 double py1 = rs.getInt("py1");
				 double py2 = rs.getInt("py2");
				 int pyTypeNoh = rs.getInt("pyTypeNho");
				 int room = rs.getInt("room");
				 int bath = rs.getInt("bath");
				 int housePartyIdx = rs.getInt("houseparty_idx");
				 String coverImg = rs.getString("cover_img");
				 String title = rs.getString("title");
				 
//				 sql ="SELECT  ap.apt_idx,ap.apt_py_idx, ap.py, h.cover_img, h.title, h.budget_low, h.budget_high, h.family_type"
//				 		+ " FROM    apt_py ap, houseparty h"
//				 		+ " WHERE   ap.houseparty_idx = h.houseparty_idx(+)"
//				 		+ "        AND (SELECT py FROM apt_py WHERE apt_py_idx=?) = h.py";
//				 
//				 try {
//					 PreparedStatement pstmt2 = conn.prepareStatement(sql);
//						pstmt2.setInt(1, aptPyIdx);
//						ResultSet rs2 = pstmt2.executeQuery();
//						while(rs2.next()) {
//							aptIdx = rs.getInt("apt_idx");
//							aptPyIdx = rs.getInt("apt_py_idx");
//							py = rs.getInt("py");
//							coverImg = rs.getString("cover_img");
//							title = rs.getString("title");
//							int budgetLow = rs.getInt("budget_low");
//							int budgetHigh = rs.getInt("budget_high");
//							String familyType = rs.getString("family_type");
//							
//							
//						}
//						rs2.close();
//						pstmt2.close();
//				 }catch(SQLException e) {
//					 e.printStackTrace();
//				 }
				 
				 AptDetailVo vo = new AptDetailVo(aptIdx, homeType, name, noh, dateCompletion, aptPyIdx, py, pyType, imgUrl, py1, py2, pyTypeNoh, room, bath, housePartyIdx, coverImg, title);
				 listAptDetail.add(vo);
			}
			rs.close();
			pstmt.close();
			conn.close();
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return listAptDetail;
	}
	
	// 우리 아파트 시공리뷰
	public ArrayList<AptSigongReviewVo> getlistAptSigongReview(int aptIdx){
		ArrayList<AptSigongReviewVo> listAptSigongReview = new ArrayList<AptSigongReviewVo>();
		
		Connection conn = DBConnection.getConnection();
		String sql = "SELECT  iri.review_idx AS imgReviewIdx, iri.img_order, iri.img_url, ir.review_idx AS reviewIdx, ir.apt_idx, ir.py,"
				+ " ir.con_price_low, ir.con_price_high, ir.content, ir.member_id, ir.writedate"
				+ " FROM    interior_review ir, interior_review_img iri"
				+ " WHERE   ir.apt_idx = ? "
				+ "        AND iri.review_idx = ir.review_idx"
				+ "        AND iri.img_order in (select min(img_order) from interior_review_img group by review_idx)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,aptIdx);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				int imgReviewIdx = rs.getInt("imgReviewIdx");
				int imgOrder = rs.getInt("img_order");
				String imgUrl = rs.getString("img_url");
				int reviewIdx = rs.getInt("reviewIdx");
				aptIdx = rs.getInt("apt_idx");
				String py = rs.getString("py");
				int conPriceLow = rs.getInt("con_price_low");
				int conPriceHigh = rs.getInt("con_price_high");
				String content = rs.getString("content");
				String memberId = rs.getString("member_id");
				String writedate = rs.getString("writedate");
				AptSigongReviewVo vo = new AptSigongReviewVo(imgReviewIdx, imgOrder, imgUrl, reviewIdx, aptIdx, py, conPriceLow, conPriceHigh, content, memberId, writedate);
				listAptSigongReview.add(vo);
			}
			rs.close();
			pstmt.close();
			conn.close();
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return listAptSigongReview;
	}
	
	//우리아파트 전문 시공업체
	public ArrayList<AptSigongConVo> getlistAptSigongCon(int aptIdx) {
		ArrayList<AptSigongConVo> listAptSigongCon = new ArrayList<AptSigongConVo>();
		
		Connection conn = DBConnection.getConnection();
		String sql = "SELECT  i.interior_idx, i.name, i.exp, h.houseparty_idx , h.interior_idx AS h_interior_idx ,h.cover_img"
				+ " FROM    interior i, houseparty h"
				+ " where   i.interior_idx in(SELECT  ai.interior_idx"
				+ "                        FROM    apt_interior ai"
				+ "                        WHERE   ai.apt_idx = ? )"
				+ "        AND i.interior_idx = h.interior_idx"
				+ "        AND houseparty_idx in(SELECT  min(houseparty_idx)"
				+ "                            FROM    houseparty"
				+ "                            GROUP BY interior_idx)";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, aptIdx);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				 int interiorIdx = rs.getInt("interior_idx");
				 String name = rs.getString("name");
				 String exp = rs.getString("exp");
				 int housepartyIdx = rs.getInt("houseparty_idx");
				 int hInteriorIdx = rs.getInt("h_interior_idx");
				 String coverImg = rs.getString("cover_img");
				 AptSigongConVo vo = new AptSigongConVo(interiorIdx, name, exp, housepartyIdx, hInteriorIdx, coverImg);
				 listAptSigongCon.add(vo);
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return listAptSigongCon;
	}
	
	//아파트 리뷰 디테일(사진제외)
	public AptConReviewVo getConReviewVoByReviewIdxVo(int reviewIdx) {
		AptConReviewVo ConReviewByReviewIdxVo = null;
		
		Connection conn = DBConnection.getConnection();
		String sql = "SELECT  i.name, i.starpoint_avg, ir.apt_idx, iri.review_idx, ir.interior_idx, m.profile_img, "
				+ "			ir.member_id, ir.con_review, ir.writedate, ir.o_con, ir.con_time, ir.con_price_low, ir.con_price_high,"
				+ " ir.address, ir.home_type, ir.con_field, ir.py, ir.content"
				+ " FROM    interior_review ir, member m, interior_review_img iri, interior i"
				+ " WHERE   ir.member_id = m.member_id"
				+ "        AND ir.interior_idx = iri.interior_idx"
				+ "        AND ir.review_idx = iri.review_idx"
				+ "        AND ir.interior_idx = i.interior_idx"
				+ "        AND ir.review_idx = ? "
				+ " ORDER BY ir.review_idx, iri.img_order";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, reviewIdx);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				String name = rs.getString("name");
				Double starPoingAvg = rs.getDouble("starpoint_avg");
				int aptIdx = rs.getInt("apt_idx");
				reviewIdx = rs.getInt("review_idx");  
				int interiorIdx = rs.getInt("interior_idx");
				String profileImg = rs.getString("profile_img");
				String memberId = rs.getString("member_id");
				int conReview = rs.getInt("con_review");
				String writedate = rs.getString("writedate");
				int oCon = rs.getInt("o_con");
				String conTime = rs.getString("con_time");
				int conPriceLow = rs.getInt("con_price_low");
				int conPriceHigh = rs.getInt("con_price_high");
				String address = rs.getString("address");
				String homeType = rs.getString("home_type");
				String conField = rs.getString("con_field");
				String py = rs.getString("py");
				String content = rs.getString("content");
				int likeyCount = 0;
				
				String sql2 = "SELECT count(*) FROM likey WHERE con_review_idx = ?";
				PreparedStatement pstmt2 = conn.prepareStatement(sql2);
				pstmt2.setInt(1, reviewIdx);
				ResultSet rs2 = pstmt2.executeQuery();
				if(rs2.next()) {
					likeyCount = rs2.getInt(1);
				}
				rs2.close();
				pstmt2.close();
				
				ConReviewByReviewIdxVo = new AptConReviewVo(name, starPoingAvg, aptIdx, reviewIdx, interiorIdx, profileImg, memberId, conReview, writedate, oCon, conTime, conPriceLow, conPriceHigh, address, homeType, conField, py, content, likeyCount);
			}
			rs.close();
			pstmt.close();
			conn.close();
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return ConReviewByReviewIdxVo;
	}
	
	//아파트 리뷰 디테일(사진)
	public ArrayList<AptReveiwPhotoVo> getListAptReviewPhoto(int reviewIdx){
		ArrayList<AptReveiwPhotoVo> listAptReviewPhoto = new ArrayList<AptReveiwPhotoVo>(); 
		
		Connection conn = DBConnection.getConnection();
		String sql = "SELECT iri.review_idx, iri.img_order, iri.img_url"
				+ " FROM  interior_review ir, interior_review_img iri  "
				+ " WHERE ir.review_idx = iri.review_idx"
				+ "        AND ir.review_idx= ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, reviewIdx);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				int imgOrder = rs.getInt("img_order");
				String imgUrl = rs.getString("img_url");
				AptReveiwPhotoVo vo = new AptReveiwPhotoVo(reviewIdx, imgOrder, imgUrl);
				listAptReviewPhoto.add(vo);
			}
			rs.close();
			pstmt.close();
			conn.close();
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return listAptReviewPhoto;
	}
	
}
