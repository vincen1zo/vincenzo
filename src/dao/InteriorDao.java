package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import common.DBConnection;
import vo.ConReviewListVo;
import vo.ConReviewVo;
import vo.HousepartySigongVo;
import vo.InteriorDetailSideVo;
import vo.InteriorInfoVo;
import vo.InteriorMainVo;
import vo.InteriorPhotoVo;
import vo.interiorReviewVo;

public class InteriorDao {
	//메인
	public ArrayList<InteriorMainVo> getListInteriorMainVo() {
		// 한칸씩 업체내용 뿌리기
		Connection conn = DBConnection.getConnection();
		ArrayList<InteriorMainVo> mainlist = new ArrayList<InteriorMainVo>();
		String sql = "SELECT  icimg.interior_idx, icimg.img_order, icimg.img_url, i.o_standard,"
				+ "        i.name, i.guarantee, i.starpoint_avg, i.con_review, i.recent_contracts, i.price_range, ino.title, ino.content"
				+ " FROM    interior i, interior_cover_img icimg, interior_notice ino"
				+ " WHERE   i.interior_idx = icimg.interior_idx"
				+ "        AND i.interior_idx = ino.interior_notice_idx"
				+ " ORDER BY icimg.interior_idx ASC, "
				+ "         icimg.img_order ASC";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				int interiorIdx = rs.getInt("interior_idx");
				int imgOrder = rs.getInt("img_order");
				String imgUrl = rs.getString("img_url");
				int Ostandard = rs.getInt("o_standard");
				String name = rs.getString("name");
				int guarantee = rs.getInt("guarantee");
				Double starpointAvg = rs.getDouble("starpoint_avg");
				starpointAvg = Math.round(starpointAvg*10)/10.0;
				int conReview = rs.getInt("con_review");
				int recentContracts = rs.getInt("recent_contracts");
				String priceRange = rs.getString("price_range");
				String title = rs.getString("title");
				String content = rs.getString("content");
				double distance = -1.0;   // -1.0 means '현재 위치가 없음 따라서 거리 개념이 없'
				InteriorMainVo vo = new InteriorMainVo(interiorIdx, imgOrder, imgUrl, Ostandard, name, guarantee, starpointAvg, conReview, recentContracts, priceRange, title, content, distance);
				mainlist.add(vo);
			}
			rs.close();
			pstmt.close();
			conn.close();
		}catch(SQLException e) {
			e.printStackTrace();
		}
		
		// -------------------- Now, mainlist2.
		ArrayList<InteriorMainVo> mainlist2 = new ArrayList<InteriorMainVo>();
		int previousInteriorIdx = 0;
		for(int i=0; i<=mainlist.size()-1; i++) {
			if(previousInteriorIdx != mainlist.get(i).getInteriorIdx()) {
				mainlist2.add(mainlist.get(i));
				previousInteriorIdx = mainlist.get(i).getInteriorIdx();
			} else {
				int lastIdx = mainlist2.size()-1;
				String imgUrl = mainlist2.get(lastIdx).getImgUrl();
				imgUrl += " " + mainlist.get(i).getImgUrl();
				InteriorMainVo vo = mainlist2.get(lastIdx);
				mainlist2.remove(lastIdx);
				
				int interiorIdx = vo.getInteriorIdx();
				int imgOrder = vo.getImgOrder();
				int oStandard = vo.getoStandard();
				String name = vo.getName();
				int guarantee = vo.getGuarantee();
				Double starpointAvg = vo.getStarpointAvg();
				int conReview = vo.getConReview();
				int recentContracts = vo.getRecentContracts();
				String priceRange = vo.getPriceRange();
				String title = vo.getTitle();
				String content = vo.getContent();
				double distance = vo.getDistance();
				InteriorMainVo vo2 = new InteriorMainVo(interiorIdx, imgOrder, imgUrl, oStandard, name, guarantee, starpointAvg, conReview, recentContracts, priceRange, title, content, distance);

				mainlist2.add(vo2);
				
			}
		}
		return mainlist2;
	}
	
	// 두 좌표 사이의 거리를 구하는 함수
    // dsitance(첫번쨰 좌표의 위도, 첫번째 좌표의 경도, 두번째 좌표의 위도, 두번째 좌표의 경도)
    private static double distance(double lat1, double lon1, double lat2, double lon2){
        double theta = lon1 - lon2;
        double dist = Math.sin(deg2rad(lat1))* Math.sin(deg2rad(lat2)) + Math.cos(deg2rad(lat1))*Math.cos(deg2rad(lat2))*Math.cos(deg2rad(theta));
        dist = Math.acos(dist);
        dist = rad2deg(dist);
        dist = dist * 60*1.1515*1609.344;

        return dist; //단위 meter
    }
    //10진수를 radian(라디안)으로 변환
    private static double deg2rad(double deg){
        return (deg * Math.PI/180.0);
    }
    //radian(라디안)을 10진수로 변환
    private static double rad2deg(double rad){
        return (rad * 180 / Math.PI);
    }
    
	public ArrayList<InteriorMainVo> getListInteriorMainVoNearBy(double lat, double lng) {
		// 한칸씩 업체내용 뿌리기
		Connection conn = DBConnection.getConnection();
		ArrayList<InteriorMainVo> mainlist = new ArrayList<InteriorMainVo>();
		String sql = "SELECT  icimg.interior_idx, icimg.img_order, icimg.img_url, i.o_standard,"
				+ "        i.name, i.guarantee, i.starpoint_avg, i.con_review, i.recent_contracts, i.price_range, ino.title, ino.content, "
				+ "		   (power(i.latitude-?,2)+power(i.longitude-?,2)) 거리, i.latitude, i.longitude"
				+ " FROM    interior i, interior_cover_img icimg, interior_notice ino"
				+ " WHERE   i.interior_idx = icimg.interior_idx"
				+ "        AND i.interior_idx = ino.interior_notice_idx"
				+ " ORDER BY 거리 ASC,"
				+ " 		icimg.interior_idx ASC,"
				+ "         icimg.img_order ASC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setDouble(1, lat);
			pstmt.setDouble(2, lng);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				int interiorIdx = rs.getInt("interior_idx");
				int imgOrder = rs.getInt("img_order");
				String imgUrl = rs.getString("img_url");
				int Ostandard = rs.getInt("o_standard");
				String name = rs.getString("name");
				int guarantee = rs.getInt("guarantee");
				Double starpointAvg = rs.getDouble("starpoint_avg");
				starpointAvg = Math.round(starpointAvg*10)/10.0;
				int conReview = rs.getInt("con_review");
				int recentContracts = rs.getInt("recent_contracts");
				String priceRange = rs.getString("price_range");
				String title = rs.getString("title");
				String content = rs.getString("content");
				//double distance = rs.getDouble("거리");  // NOT 'km 단위' ..
				double latitude = rs.getDouble("latitude");
				double longitude = rs.getDouble("longitude");
				double distance = distance(latitude, longitude, lat, lng) / 1000.0;  // 'km 단위'
				InteriorMainVo vo = new InteriorMainVo(interiorIdx, imgOrder, imgUrl, Ostandard, name, guarantee, starpointAvg, conReview, recentContracts, priceRange, title, content, distance);
				mainlist.add(vo);
			}
			rs.close();
			pstmt.close();
			conn.close();
		}catch(SQLException e) {
			e.printStackTrace();
		}
		
		// -------------------- Now, mainlist2.
		ArrayList<InteriorMainVo> mainlist2 = new ArrayList<InteriorMainVo>();
		int previousInteriorIdx = 0;
		for(int i=0; i<=mainlist.size()-1; i++) {
			if(previousInteriorIdx != mainlist.get(i).getInteriorIdx()) {
				mainlist2.add(mainlist.get(i));
				previousInteriorIdx = mainlist.get(i).getInteriorIdx();
			} else {
				int lastIdx = mainlist2.size()-1;
				String imgUrl = mainlist2.get(lastIdx).getImgUrl();
				imgUrl += " " + mainlist.get(i).getImgUrl();
				InteriorMainVo vo = mainlist2.get(lastIdx);
				mainlist2.remove(lastIdx);
				
				int interiorIdx = vo.getInteriorIdx();
				int imgOrder = vo.getImgOrder();
				int oStandard = vo.getoStandard();
				String name = vo.getName();
				int guarantee = vo.getGuarantee();
				Double starpointAvg = vo.getStarpointAvg();
				int conReview = vo.getConReview();
				int recentContracts = vo.getRecentContracts();
				String priceRange = vo.getPriceRange();
				String title = vo.getTitle();
				String content = vo.getContent();
				double distance = vo.getDistance();
				InteriorMainVo vo2 = new InteriorMainVo(interiorIdx, imgOrder, imgUrl, oStandard, name, guarantee, starpointAvg, conReview, recentContracts, priceRange, title, content, distance);

				mainlist2.add(vo2);
			}
		}
		return mainlist2;
	}

	
	
	
	
	//디테일
	
	//왼쪽 사이드 내용
	public InteriorDetailSideVo getInteriorDetailSideVo(String conName) {
		InteriorDetailSideVo sideVo = null;
		Connection conn = DBConnection.getConnection();
		
		String sql = " SELECT i.interior_idx, i.name, i.guarantee,exp, i.starpoint_avg, i.con_review, i.star_commu, i.star_price,"
				+ " i.star_result, i.star_schedule, i.star_as, ino.title, ino.content, i.o_standard, i.professional"
				+ " FROM interior i, interior_notice ino"
				+ " WHERE i.name = ?"
				+ " AND i.interior_idx = ino.interior_notice_idx";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, conName);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				int interiorIdx = rs.getInt("interior_idx");
				String name = rs.getString("name");
				int guarantee = rs.getInt("guarantee");
				String exp = rs.getString("exp");
				double starpointAvg = rs.getDouble("starpoint_avg");
				starpointAvg = Math.round(starpointAvg*10)/10.0;
				int conReview = rs.getInt("con_review");
				double starCommu = rs.getDouble("star_commu");
				starCommu = Math.round(starCommu*10)/10.0;
				double starPrice = rs.getDouble("star_price");
				starPrice = Math.round(starPrice*10)/10.0;
				double starResult = rs.getDouble("star_result");
				starResult = Math.round(starResult*10)/10.0;
				double starSchedule = rs.getDouble("star_schedule");
				starSchedule = Math.round(starSchedule*10)/10.0;
				double starAs = rs.getDouble("star_as");
				starAs = Math.round(starAs*10)/10.0;
				String title = rs.getString("title");
				String content = rs.getString("content");
				int oStandard = rs.getInt("o_Standard");
				int professional = rs.getInt("professional");
				sideVo = new InteriorDetailSideVo(interiorIdx, name, guarantee, exp, starpointAvg, conReview, starCommu, starPrice, starResult, starSchedule, starAs, title, content, oStandard, professional);
			}
			rs.close();
			pstmt.close();
			conn.close();
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return sideVo;
	}

	//오늘의집 계약 갯수 (왼쪽 사이드)
	public int getContractCount(String conName) {
		Connection conn = DBConnection.getConnection();
		
		String sql = "SELECT  count(*)"
				+ " FROM    interior_review ir, interior i"
				+ " WHERE   i.interior_idx = ir.interior_idx"
				+ "        AND ir.o_con = 1"
				+ "        AND i.name = ?  ";
		int count = 0;
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, conName);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}
			
			rs.close();
			pstmt.close();
			conn.close();
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return count;
	}

	//계약자 리뷰 (목록)
	private String getImgUrlFromReviewIdxOne(int reviewIdx) {
		String strRet = "";
		
		Connection conn = DBConnection.getConnection();
		String sql = "SELECT  iri.img_order, iri.img_url"
				+ " FROM    interior_review ir, interior_review_img iri"
				+ " WHERE   ir.review_idx = iri.review_idx"
				+ " AND     ir.review_idx = ?"
				+ " ORDER BY img_order";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, reviewIdx);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				strRet = rs.getString("img_url");
			}
			rs.close();
			pstmt.close();
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return strRet;
	}

	public ArrayList<ConReviewListVo> getListConReviewVo(String conName) {
		ArrayList<ConReviewListVo> listConReviewListVo = new ArrayList<ConReviewListVo>();

		Connection conn = DBConnection.getConnection();
		String sql = "SELECT  ir.review_idx, ir.member_id, ir.content"
				+ " FROM    interior_review ir, interior i "
				+ " WHERE   ir.interior_idx = i.interior_idx"
				+ " AND     i.name = ?";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, conName);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				int reviewIdx = rs.getInt("review_idx");
				String memberId = rs.getString("member_id");
				String content = rs.getString("content");
				String imgUrl = getImgUrlFromReviewIdxOne(reviewIdx);
				ConReviewListVo vo = new ConReviewListVo(memberId, content, imgUrl);
				listConReviewListVo.add(vo);
			}
			rs.close();
			pstmt.close();
			conn.close();
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return listConReviewListVo;
	}
	
	// 시공사례
	public ArrayList<HousepartySigongVo> getListHousepartySigongVo(String conName) {
		ArrayList<HousepartySigongVo> listSigong = new ArrayList<HousepartySigongVo>();
		Connection conn = DBConnection.getConnection();
		String sql = "SELECT h.houseparty_idx, h.cover_img, h.title, h.likey_count, h.hit_count"
				+ " FROM interior i, houseparty h "
				+ " WHERE i.interior_idx = h.interior_idx AND i.name = ?"
				+ " ORDER BY h.likey_count DESC";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, conName);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				int housepartyIdx = rs.getInt("houseparty_idx");
				String coverImg = rs.getString("cover_img");
				String title = rs.getString("title");
				int likeyCount = rs.getInt("likey_count");
				int hitCount = rs.getInt("hit_count");
				
				HousepartySigongVo vo = new HousepartySigongVo(housepartyIdx, coverImg, title, likeyCount, hitCount);
				listSigong.add(vo);
			}
			rs.close();
			pstmt.close();
			conn.close();
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return listSigong;
	}

	//사진
	public ArrayList<InteriorPhotoVo> getlistInteriorPhotoVo(String conName){
		ArrayList<InteriorPhotoVo> iPhotoList1 = new ArrayList<InteriorPhotoVo>();
		ArrayList<InteriorPhotoVo> listInteriorPhoto = new ArrayList<InteriorPhotoVo>();
		Connection conn = DBConnection.getConnection();
		String sql = "SELECT iimg.interior_idx, iimg.interior_img_idx, iimg.order_img_idx, iimg.img_url"
				+ " FROM interior_img iimg, interior i"
				+ " WHERE i.interior_idx = iimg.interior_idx AND i.name = ?"
				+ " ORDER BY iimg.interior_img_idx ASC, iimg.order_img_idx ASC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, conName);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				int interiorIdx = rs.getInt("interior_idx");
				int interiorImgIdx = rs.getInt("interior_img_idx");
				int orderImgIdx = rs.getInt("order_img_idx");
				String imgUrl = rs.getString("img_url");
				
				InteriorPhotoVo vo = new InteriorPhotoVo(interiorIdx, interiorImgIdx, orderImgIdx, imgUrl);
				iPhotoList1.add(vo);
			}
			rs.close();
			pstmt.close();
			conn.close();
		}catch(SQLException e) {
			e.printStackTrace();
		}
		
	// 사진 묶어서 뿌리기
		int current = iPhotoList1.get(0).getInteriorImgIdx(); 
		String imgUrls = "";
		for(int i=0; i<=iPhotoList1.size()-1; i++) {
			if(iPhotoList1.get(i).getInteriorImgIdx()==current) {
				String imgUrl = iPhotoList1.get(i).getImgUrl();
				if(imgUrls.length()>0) {
					imgUrls += " ";
				}
				imgUrls += imgUrl;
			} else {
				int interiorIdx = iPhotoList1.get(i-1).getInteriorIdx();
				int interiorImgIdx = iPhotoList1.get(i-1).getInteriorImgIdx();
				int orderImgIdx = iPhotoList1.get(i-1).getOrderImgIdx();
				//System.out.println("interiorImgIdx / ImgUrls : " + interiorImgIdx + "/" + imgUrls);
				InteriorPhotoVo vo = new InteriorPhotoVo(interiorIdx, interiorImgIdx, orderImgIdx, imgUrls);
				listInteriorPhoto.add(vo);
				imgUrls = "";
				current = iPhotoList1.get(i).getInteriorImgIdx();
				i--;
			}
		}
		return listInteriorPhoto;
	}
	
	//시공리뷰
	public ArrayList<ConReviewVo> getlistConReviewVo(String conName){
		ArrayList<ConReviewVo> listConReview = new ArrayList<ConReviewVo>();
		
		Connection conn = DBConnection.getConnection();
		String sql = "SELECT  i.name,iri.review_idx, ir.interior_idx, m.profile_img, ir.member_id, ir.con_review, ir.writedate, ir.o_con, ir.con_time, ir.con_price_low, ir.con_price_high, "
				+ "				ir.address, ir.home_type, ir.con_field, ir.py, iri.img_order, iri.img_url, ir.content"
				+ "				FROM    interior_review ir, member m, interior_review_img iri, interior i"
				+ "				WHERE   ir.member_id = m.member_id"
				+ "				        AND ir.interior_idx = iri.interior_idx"
				+ "				        AND ir.review_idx = iri.review_idx"
				+ "                        AND ir.interior_idx = i.interior_idx"
				+ "				        AND i.name = ? "
				+ "				 ORDER BY ir.review_idx, iri.img_order";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, conName);
			ResultSet rs = pstmt.executeQuery();
			int previousAddedReviewIdx = 0;
			while(rs.next()) {
				String name = rs.getString("name");
				int reviewIdx = rs.getInt("review_idx");  
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
				int imgOrder = rs.getInt("img_order");
				String imgUrl = rs.getString("img_url");
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
				
				if(reviewIdx != previousAddedReviewIdx) { 
					ConReviewVo vo = new ConReviewVo(name, reviewIdx, interiorIdx, profileImg, memberId, conReview, writedate, oCon, conTime, conPriceLow, conPriceHigh, address, 
													homeType, conField, py, imgOrder, imgUrl, content, likeyCount);
					listConReview.add(vo);
					previousAddedReviewIdx = reviewIdx;
				} else {
					ConReviewVo voLast = listConReview.get(listConReview.size()-1);
					listConReview.remove(listConReview.size()-1);
					String imgUrlNew = voLast.getImgUrl();
					imgUrlNew += " " + imgUrl;
					ConReviewVo vo2 = new ConReviewVo(voLast.getName(), voLast.getReviewIdx(), voLast.getInteriorIdx(), voLast.getProfileImg(), voLast.getMemberId(), voLast.getConReview(), 
							voLast.getWritedate(), voLast.getoCon(), voLast.getConTime(), voLast.getConPriceLow(), voLast.getConPriceHigh(), voLast.getAddress(), voLast.getHomeType(), 
							voLast.getConField(), voLast.getPy(), voLast.getImgOrder(), imgUrlNew, voLast.getContent(), voLast.getLikeyCount());
					listConReview.add(vo2);
				}
			}
			rs.close();
			pstmt.close();
			conn.close();
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return listConReview;
	}
	
	
	//업체정보
	public InteriorInfoVo getInfoVo(String conName) {
		InteriorInfoVo InfoVo = null;
		Connection conn = DBConnection.getConnection();
		String sql = "SELECT ino.interior_notice_idx, ino.title, ino.content, ino.img_url, i.interior_idx, i.field, i.recent_contracts, i.as_year, i.career, i.service"
				+ " FROM interior i, interior_notice ino"
				+ " WHERE i.interior_idx = ino.interior_idx AND i.name = ?";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, conName);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				int interiorNoticeIdx = rs.getInt("interior_notice_idx");
				String title = rs.getString("title");
				String content = rs.getString("content");
				String imgUrl = rs.getString("img_url");
				int interiorIdx = rs.getInt("interior_idx");
				String field = rs.getString("field");
				int recentContracts = rs.getInt("recent_contracts");
				String AsYear = rs.getString("as_year");
				String career = rs.getString("career");
				String service = rs.getString("service");
				InfoVo = new InteriorInfoVo(interiorNoticeIdx, title, content, imgUrl, interiorIdx, field, recentContracts, AsYear, career, service);
			}
			rs.close();
			pstmt.close();
			conn.close();
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return InfoVo;
	}
	
	//리뷰쓰기화면(업체명연결)
	public interiorReviewVo getInteriorReviewVo(String conName) {
		Connection conn = DBConnection.getConnection();
		interiorReviewVo iReviewVo = null;
		
		String sql = "SELECT  name, profile_img_url"
					+ " FROM    interior"
					+ " WHERE   name = ? ";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, conName);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				String name = rs.getString("name");
				String profileImgUrl = rs.getString("profile_img_url");
				iReviewVo = new interiorReviewVo(name, profileImgUrl);
			}
			rs.close();
			pstmt.close();
			conn.close();
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return iReviewVo;
	}
	
	//  도움이 됐어요
	public boolean getReviewLikeOrNot(String memberId, int reviewIdx) {
		int cnt = 0;
		Connection conn = DBConnection.getConnection();
		
		String sql = "SELECT count(*) FROM likey WHERE member_id=? AND con_review_idx=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberId);
			pstmt.setInt(2, reviewIdx);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				cnt = rs.getInt(1);
			}
			rs.close();
			pstmt.close();
			conn.close();
		} catch(SQLException e) {
			e.printStackTrace();
		} 
		return cnt==1;
	}
	
	public void insertReviewLike(String memberId, int reviewIdx) {
		String sql = "INSERT INTO likey(member_id, con_review_idx) VALUES (?, ?)";
		Connection conn = DBConnection.getConnection();
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberId);
			pstmt.setInt(2, reviewIdx);
			pstmt.executeUpdate();
			pstmt.close();
			conn.close();
		} catch(SQLException e) { e.printStackTrace(); }
	}
	
	public void deleteReviewLike(String memberId, int reviewIdx) {
		String sql = "DELETE FROM likey WHERE member_id=? AND con_review_idx=?";
		Connection conn = DBConnection.getConnection();
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberId);
			pstmt.setInt(2, reviewIdx);
			pstmt.executeUpdate();
			pstmt.close();
			conn.close();
		} catch(SQLException e) { e.printStackTrace(); }
		
	}
	
	
	//리뷰쓰기 (사진제외)
	public void interiorReviewWriteText(int interiorIdx, int aptIdx, String memberId, String writedate, String conTime, int conPriceLow, int conPriceHigh, String conField,
									String content, String phoneNumber, int starCommu, int starPrice, int starResult, int starSchedule, int starAs, String address, 
									String detailAddress, String fileName, int agree1, int agree2, String py, String homeType) {
		Connection conn = DBConnection.getConnection();
		
		String sql = "INSERT INTO interior_review (review_idx, interior_idx, apt_idx, member_id, con_review, writedate, o_con, con_time, con_price_low, con_price_hight, "
				+ "								con_field, content, phone_number, star_commu, star_price, star_result, star_schedule, star_as, "
				+ "                             address, detail_address, file_name, agree1, agree2, py, home_type)"
				+ " VALUES (SEQ_INTERIOR_REVIEW_IDX.nextval, ?, ?, ?, 1, ?, 1, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, interiorIdx);
			pstmt.setInt(2, aptIdx);
			pstmt.setString(3, memberId);
			pstmt.setString(4, writedate);
			pstmt.setString(5, conTime);
			pstmt.setInt(6, conPriceLow);
			pstmt.setInt(7, conPriceHigh);
			pstmt.setString(8, conField);
			pstmt.setString(9, content);
			pstmt.setString(10, phoneNumber);
			pstmt.setInt(11, starCommu);
			pstmt.setInt(12, starPrice);
			pstmt.setInt(13, starResult);
			pstmt.setInt(14, starSchedule);
			pstmt.setInt(15, starAs);
			pstmt.setString(16, address);
			pstmt.setString(17,detailAddress);
			pstmt.setString(18, fileName);
			pstmt.setInt(19, agree1);
			pstmt.setInt(20, agree2);
			pstmt.setString(21, py);
			pstmt.setString(22, homeType);
			pstmt.executeUpdate();
			pstmt.close();
			
			sql = "";
			
			conn.close();
		}catch(SQLException e) {
			e.printStackTrace();
		}
	}
	
	//리뷰쓰기(사진만)
//	public void interiorReviewWritePhoto () {
//		Connection conn = DBConnection.getConnection();
//		
//		String sql = ""
//		
//		try {
//			PreparedStatement pstmt = conn.prepareStatement(sql);
//			
//			
//			pstmt.executeUpdate();
//			
//			pstmt.close();
//			conn.close();
//		}catch(SQLException e) {
//			e.printStackTrace();
//		}
//	}
}
