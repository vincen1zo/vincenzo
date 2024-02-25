package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import common.DBConnection;
import vo.*;

public class HousepartyDao {
	public ArrayList<HousepartyVo> getAllHousepartyVoListSorted(String filtering) {
		Connection conn = DBConnection.getConnection();
		ArrayList<HousepartyVo> listHouseparty = new ArrayList<HousepartyVo>();
		
		String sqlPlusOrderBy = "";
		String sqlPlusWhere = "";
		switch(filtering) {
		case "recent": sqlPlusOrderBy = " ORDER BY write_date DESC"; break;
		case "popular": sqlPlusOrderBy = " ORDER BY likey_count DESC"; break;
		case "past": sqlPlusOrderBy = " ORDER BY write_date ASC"; break;
		case "ono": sqlPlusWhere = " AND h.home_type='원룸&오피스텔'"; break;
		case "apt" : sqlPlusWhere = " AND h.home_type='아파트'"; break;
		case "villant" : sqlPlusWhere = " AND h.home_type='빌라&연립'"; break;
		case "dandok" : sqlPlusWhere = " AND h.home_type='단독주택'"; break;
		case "office" : sqlPlusWhere = " AND h.home_type='사무공간'"; break;
		case "ht_etc" : sqlPlusWhere = " AND h.home_type='기타'"; break;
		case "1_9py" : sqlPlusWhere = " AND h.py BETWEEN 1 AND 9"; break;
		case "10spy" : sqlPlusWhere = " AND h.py BETWEEN 10 AND 19"; break;
		case "20spy" : sqlPlusWhere = " AND h.py BETWEEN 20 AND 29"; break;
		case "30spy" : sqlPlusWhere = " AND h.py BETWEEN 30 AND 39"; break;
		case "40spy" : sqlPlusWhere = " AND h.py BETWEEN 40 AND 49"; break;
		case "50spy" : sqlPlusWhere = " AND h.py BETWEEN 50 AND 59"; break;
		case "60spy" : sqlPlusWhere = " AND h.py BETWEEN 60 AND 69"; break;
		case "under1m" : sqlPlusWhere = "AND h.budget_low <= 0 AND h.budget_high >= 100"; break;
		case "1ms" : sqlPlusWhere = " AND h.budget_low <= 101 AND h.budget_high >= 199"; break;
		case "2ms" : sqlPlusWhere = " AND h.budget_low <= 110 AND h.budget_high >= 299"; break;
		case "3ms" : sqlPlusWhere = " AND h.budget_low <= 0 AND h.budget_high >= 10"; break;
		case "4ms" : sqlPlusWhere = " AND  h.budget_low <= 0 AND h.budget_high >= 10"; break;
		case "5ms" : sqlPlusWhere = " AND h.budget_low <= 0 AND h.budget_high >= 10"; break;
		case "10ms" : sqlPlusWhere = " AND h.budget_low <= 0 AND h.budget_high >= 10"; break;
		case "20ms" : sqlPlusWhere = " AND h.budget_low <= 0 AND h.budget_high >= 10"; break;
		case "30ms" : sqlPlusWhere = " AND h.budget_low <= 0 AND h.budget_high >= 10"; break;
		case "over40ms" : sqlPlusWhere = " AND h.budget_low <= 0 AND h.budget_high >= 10"; break;
		case "family1" : sqlPlusWhere = " AND h.family_type = '싱글라이프'"; break;
		case "family12" : sqlPlusWhere = " AND h.family_type = '신혼부부'"; break;
		case "family123" : sqlPlusWhere = " AND h.family_type = '아기가 있는 집'"; break;
		case "family3school" : sqlPlusWhere = " AND h.family_type = '취학 자녀와 함께'"; break;
		case "familyparents" : sqlPlusWhere = " AND h.family_type = '부모님과 함께'"; break;
		case "family_etc" : sqlPlusWhere = " AND h.family_type = '기타'"; break;
		case "st_modern" : sqlPlusWhere = " AND h.style like '%모던%'"; break;
		case "st_minisimple" : sqlPlusWhere = " AND h.style like '%미니멀&심플%'"; break;
		case "st_natural" : sqlPlusWhere = " AND h.style like '%내추럴%'"; break;
		case "st_neurope" : sqlPlusWhere = " AND h.style like '%북유럽%'"; break;
		case "st_vintage_retro" : sqlPlusWhere = " AND h.style like '%빈티지&레트로%'"; break;
		case "st_cls_ant" : sqlPlusWhere = " AND h.style like '%클래식&앤틱%'"; break;
		case "st_ft_pro" : sqlPlusWhere = " AND h.style like '%프렌치&프로방스%'"; break;
		case "st_lov_rom" : sqlPlusWhere = " AND h.style like '%러블리&로맨틱%'"; break;
		case "st_industrial" : sqlPlusWhere = " AND h.style like '%인더스트리얼%'"; break;
		case "st_kor_asia" : sqlPlusWhere = " AND h.style like '%한국&아시아%'"; break;
		case "st_uni_mix" : sqlPlusWhere = " AND h.style like '%유니크&믹스매치%'"; break;
		case "d_hmaru" : sqlPlusWhere = " AND detail_con_scope like '%헤링본 마루%'"; break;
		case "d_dr_badak" : sqlPlusWhere = " AND detail_con_scope like '%대리석 바닥%'"; break;
		case "d_wmaru" : sqlPlusWhere = " AND detail_con_scope like '%원목마루%'"; break;
		case "d_porcelain_tile" : sqlPlusWhere = " AND detail_con_scope like '%포세린타일%'"; break;
		case "d_polishing_tile" : sqlPlusWhere = " AND detail_con_scope like '%폴리싱타일%'"; break;
		case "d_kitchen_remo" : sqlPlusWhere = " AND detail_con_scope like '%주방리모델링%'"; break;
		case "d_lighting" : sqlPlusWhere = " AND detail_con_scope like '%조명시공%'"; break;
		case "d_folding_door" : sqlPlusWhere = " AND detail_con_scope like '%폴딩도어%'"; break;
		case "d_middle_door" : sqlPlusWhere = " AND detail_con_scope like '%중문%'"; break;
		case "d_partition" : sqlPlusWhere = " AND detail_con_scope like '%가벽&파티션%'"; break;
		case "d_sliding_door" : sqlPlusWhere = " AND detail_con_scope like '%슬라이딩도어%'"; break;
		case "d_atryl" : sqlPlusWhere = " AND detail_con_scope like '%아트릴%'"; break;
		case "d_balcony" : sqlPlusWhere = " AND detail_con_scope like '%발코니확장%'"; break;
		case "p_remodeling" : sqlPlusWhere = " AND h.part = '리모델링'"; break;
		case "p_homestyling" : sqlPlusWhere = " AND h.part = '홈스타일링'"; break;
		case "p_detailpart" : sqlPlusWhere = " AND h.part = '부분공사'"; break;
		case "p_construct" : sqlPlusWhere = " AND h.part = '건축'"; break;
		case "w_remodeling" : sqlPlusWhere = " AND h.worker = '셀프•DIY'"; break;
		case "w_homestyling" : sqlPlusWhere = " AND h.worker = '반셀프'"; break;
		case "w_detail_construct" : sqlPlusWhere = " AND h.worker = '전문가'"; break;
		}
		
		String sql = "SELECT h.houseparty_idx, h.cover_img, h.title, h.member_id \"name\", m.profile_img, h.likey_count, h.hit_count, h.write_date"
				+ " FROM houseparty h, member m"
				+ " WHERE h.member_id = m.member_id(+)"
				+ " AND h.member_id IS NOT NULL" + sqlPlusWhere
				+ " UNION"
				+ " SELECT h.houseparty_idx, h.cover_img, h.title, i.name, i.profile_img_url, h.likey_count, h.hit_count, h.write_date"
				+ " FROM houseparty h, interior i"
				+ " WHERE h.interior_idx = i.interior_idx" + sqlPlusWhere
				+ sqlPlusOrderBy;
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				int housepartyIdx = rs.getInt("houseparty_idx");
				String coverImg = rs.getString("cover_img");
				String title = rs.getString("title");
				String name = rs.getString("name");
				String profileImg = rs.getString("profile_img");
				int likeyCount = rs.getInt("likey_count");
				int hitCount = rs.getInt("hit_count");
				String writeDate = rs.getString("write_date");
				HousepartyVo vo = new HousepartyVo(housepartyIdx, coverImg, title, name, profileImg, likeyCount, hitCount, writeDate);
				listHouseparty.add(vo);
			}
			rs.close();
			pstmt.close();
			conn.close();
		} catch(Exception e) {e.printStackTrace(); }
		return listHouseparty;
	}

	public int getCountHouseparty() { 
		int countRet = 0;
		Connection conn = DBConnection.getConnection();
		
		String sql = "SELECT count(*) FROM houseparty";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				countRet = rs.getInt(1);
			}
			rs.close();
			pstmt.close();
			conn.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}
		return countRet;
	}
	
	public HousepartyDetailVo getHousepartyPostVoByHousepartyIdx(int housepartyIdx) {
		HousepartyDetailVo voRet = null;
		Connection conn = DBConnection.getConnection();
		
		String sql = "SELECT * FROM houseparty WHERE houseparty_idx=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, housepartyIdx);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				String coverImg = rs.getString("cover_img");
				String title = rs.getString("title");
				String memberId = rs.getString("member_id");
				int interiorIdx = rs.getInt("interior_idx");
				String writeDate = rs.getString("write_date");
				int likeyCount = rs.getInt("likey_count");
				int commentCount = rs.getInt("comment_count");
				int hitCount = rs.getInt("hit_count");
				int shareCount = rs.getInt("share_count");
				String homeType = rs.getString("home_type");
				int py = rs.getInt("py");
				String part = rs.getString("part");
				String familyType = rs.getString("family_type");
				String worker = rs.getString("worker");
				int room = rs.getInt("room");
				String direction = rs.getString("direction");
				String year = rs.getString("year");
				String area = rs.getString("area");
				String style = rs.getString("style");
				String pet = rs.getString("pet");
				int familyNum = rs.getInt("family_num");
				String detailConScope = rs.getString("detail_con_scope");
				String period = rs.getString("period");
				int budgetLow = rs.getInt("budget_low");
				int budgetHigh = rs.getInt("budget_high");
				String profileImg = getProfileImgBymember(housepartyIdx, memberId);
				voRet = new HousepartyDetailVo(housepartyIdx, coverImg, title, memberId, interiorIdx, writeDate, likeyCount, commentCount, 
						hitCount, shareCount, homeType, py, part, familyType, worker, room, direction, year, area, style, pet, familyNum, 
						detailConScope, period, budgetLow, budgetHigh, profileImg);
			}
			rs.close();
			pstmt.close();
			conn.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}
		return voRet;
	}
	//유저 프로필 이미지
	public String getProfileImgBymember(int housepartyIdx, String memberId) {
		String strRet = "";
		Connection conn = DBConnection.getConnection();
		
		String sql = "SELECT m.profile_img FROM member m, houseparty h WHERE h.houseparty_idx=? AND m.member_id=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, housepartyIdx);
			pstmt.setString(2, memberId);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				strRet = rs.getString("profile_img");
			}
			rs.close();
			pstmt.close();
			conn.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return strRet;
	}
	// 리턴 : 이 집의 핵심 포인트 문자열.
	public String[] getArrSmallTalkHacksim(int housepartyIdx) {
		String[] arrStrRet = null;
		String smallTalk = "";
		Connection conn = DBConnection.getConnection();
		try {
			String sql = "SELECT small_talk "
						+ " FROM houseparty_pic_write "
						+ " WHERE houseparty_idx=?"
						+ " AND small_talk IS NOT NULL "
						+ " AND small_talk LIKE '%이 집의 핵심 포%'";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, housepartyIdx);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				smallTalk = rs.getString("small_talk");
			}
			rs.close();
			pstmt.close();
			conn.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}
		smallTalk = smallTalk.replace("<br><br>", "<br>");
		smallTalk = smallTalk.replace("✔", "");
		arrStrRet = smallTalk.split("<br>");	
		return arrStrRet;
	}
	
	// 리턴 : ArrayList<HousepartyPicWriteVo>
	public ArrayList<HousepartyPicWriteVo> getListHousepartyPicWriteVo(int housepartyIdx) {
		ArrayList<HousepartyPicWriteVo> listRet = new ArrayList<HousepartyPicWriteVo>();
		Connection conn = DBConnection.getConnection();
		String sql = "SELECT *"  
				+ " FROM houseparty_pic_write"  
				+ " WHERE houseparty_idx=?" 
				+ " ORDER BY pic_write_idx";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, housepartyIdx);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				 int picWriteIdx = rs.getInt("pic_write_idx");
				 String title = rs.getString("title");
				 String imgUrl = rs.getString("img_url");
				 String content = rs.getString("content");
				 String smallTalk = rs.getString("small_talk");
				 String linkUrl = rs.getString("link_url");
				 HousepartyPicWriteVo vo = new HousepartyPicWriteVo(picWriteIdx, housepartyIdx, title, imgUrl, content, smallTalk, linkUrl);
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
	
	// +icon
	public ArrayList<HousepartyPlusIconVo> getListHousepartyPlusIconVo(int picWriteIdx) {
		ArrayList<HousepartyPlusIconVo> listRet = new ArrayList<HousepartyPlusIconVo>();
		Connection conn = DBConnection.getConnection();
		String sql = "SELECT *" 
					+ " FROM houseparty_plus_icon" 
					+ " WHERE pic_write_idx=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, picWriteIdx);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				int productIdx = rs.getInt("product_idx");
				double xCoordinates = rs.getDouble("x_coordinates");
				double yCoordinates = rs.getDouble("y_coordinates");
				String note = rs.getString("note");
				
				HousepartyPlusIconVo vo = new HousepartyPlusIconVo(picWriteIdx, productIdx, xCoordinates, yCoordinates, note);
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
	
	//목록에 보여줄 첫 번째 사진
	public String getFirstImgUrlByProductIdx(int productIdx) {   // 해당 없으면 null 값을 리턴.
		Connection conn = DBConnection.getConnection();
		String strRet = null;
		String sql = "SELECT img_url" 
				+ " FROM product_main_img" 
				+ " WHERE product_idx=?" 
				+ " AND img_idx=1";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, productIdx);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				strRet = rs.getString("img_url");
			}
			rs.close();
			pstmt.close();
			conn.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}
		return strRet;
	}

	//댓글
	public ArrayList<HousepartyCommentVo> getListHousepartyCommentByHousepartyIdx(int housepartyIdx) {
		Connection conn = DBConnection.getConnection();
		ArrayList<HousepartyCommentVo> listRet = new ArrayList<HousepartyCommentVo>();
		String sql = "SELECT (SELECT write_date FROM houseparty_comment WHERE comment_idx=hc.re_comment_idx) wd2, hc.*, m.profile_img" + 
					" FROM houseparty_comment hc, member m" + 
					" WHERE hc.member_id = m.member_id(+)" + 
					" AND houseParty_idx=?" + 
					" ORDER BY wd2 DESC, comment_order";
		try {	
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, housepartyIdx);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				int commentIdx = rs.getInt("comment_idx");
				int reCommentIdx = rs.getInt("re_comment_idx");
				int commentOrder = rs.getInt("comment_order");
				String memberId = rs.getString("member_id");
				String hpComment = rs.getString("hp_comment");
				String writeDate = rs.getString("write_date");
				String profileImg = rs.getString("profile_img");
				HousepartyCommentVo vo = new HousepartyCommentVo(commentIdx, housepartyIdx, reCommentIdx, commentOrder, memberId, hpComment, writeDate, profileImg);
				listRet.add(vo);
			}
			rs.close();
			pstmt.close();
			conn.close();
		} catch(SQLException e) {e.printStackTrace();}
		return listRet;
	}
	
	// 대댓글의 원댓글의 작성자 MemberId 얻기.
	public String getMemberIdByCommentIdx(int commentIdx) {
		Connection conn = DBConnection.getConnection();
		String sql = "SELECT member_id FROM houseparty_comment WHERE comment_idx=?";
		String memberIdRet = null;
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, commentIdx);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				memberIdRet = rs.getString("member_id");
			}
			rs.close();
			pstmt.close();
			conn.close();
		} catch(SQLException e) { e.printStackTrace(); }
		return memberIdRet;
	}
	
	// 댓글 추가
	public void writeComment(String memberId, int housepartyIdx, String comment) {
		Connection conn = DBConnection.getConnection();
		
		String sql = "INSERT INTO houseparty_comment(comment_idx, houseparty_idx, re_comment_idx, comment_order, member_id, hp_comment, write_date)" + 
					" VALUES (SEQ_COMMENT_IDX.nextval,?,SEQ_COMMENT_IDX.currval,0,?,?,SYSDATE)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, housepartyIdx);
			pstmt.setString(2, memberId);
			pstmt.setString(3, comment);
			pstmt.executeQuery();
			pstmt.close();
			conn.close();
		} catch(SQLException e) { e.printStackTrace(); }
	}
	//댓글 삭제
	public void deleteComment(int commentIdx) {
		Connection conn = DBConnection.getConnection();
		
		String sql1 = "DELETE FROM houseparty_comment" 
				 	+ " WHERE comment_idx = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql1);
			pstmt.setInt(1, commentIdx);
			pstmt.executeUpdate();
			pstmt.close();
			int recommentIdx = 0;
			String sql2 = "SELECT re_comment_idx FROM houseparty_comment WHERE re_comment_idx = ?";
			
			PreparedStatement pstmt2 = conn.prepareStatement(sql2);
			pstmt2.setInt(1, commentIdx);
			ResultSet rs = pstmt2.executeQuery();
			while(rs.next()) {
				recommentIdx += rs.getInt("re_comment_idx");
			}
			if(recommentIdx > 0) {
				String sql3 = "delete from houseparty_comment"
							+  " where re_comment_idx = ?";
				pstmt2 = conn.prepareStatement(sql3);
				pstmt2.setInt(1, commentIdx);
				pstmt2.executeUpdate();
			}
			rs.close();
			pstmt2.close();
			conn.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}
	//댓글 수정
	public void modifyComment(String hpComment, int housepartyIdx, int commentIdx) {
		System.out.println("hpComment : " + hpComment);
		System.out.println("commentId : " + commentIdx);
		System.out.println("housepartyIdx : " + housepartyIdx);
		Connection conn = DBConnection.getConnection();
		String sql = "UPDATE houseparty_comment" + 
					" SET hp_comment = ?, write_date = SYSDATE" + 
					" WHERE houseparty_idx = ? " + 
					" and comment_idx = ?";
		System.out.println(1);
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, hpComment);
			pstmt.setInt(2, housepartyIdx);
			pstmt.setInt(3, commentIdx);
			pstmt.executeUpdate();
			pstmt.close();
			conn.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}
}