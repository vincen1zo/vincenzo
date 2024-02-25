package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import common.DBConnection;
import vo.OzipReplyVo;
import vo.OzipDetailVo;
import vo.OzipDetailVo2;
import vo.OzipModifyVo;
import vo.OzipVo;

public class OMainDao {

	public ArrayList<OzipVo> getAllList(int pageNum) {
		ArrayList<OzipVo> listOzipRet = new ArrayList<OzipVo>();
		Connection conn = DBConnection.getConnection();
		
		int ozipEndRNum = pageNum * 10;
		int ozipStartRNum = ozipEndRNum - 9;
	 	
	 	try {
		 	// 1) OzipVo (1)
			/*
			 * String sql =
			 * "SELECT o.ozip_idx, o.title, o.member_id, o.writedate, cn.c_num,o.hitcount, o.hashtag"
			 * + " FROM ozip o, comment_num cn" + " WHERE cn.ozip_idx(+) = o.ozip_idx " +
			 * " ORDER BY o.ozip_idx DESC";
			 */
	 		String sql = "SELECT t2.*" + 
	 					" FROM (" + 
	 					" SELECT rownum rnum, t.*" + 
	 					" FROM (" + 
	 					" SELECT o.ozip_idx, o.title, o.member_id, o.writedate, cn.c_num,o.hitcount, o.hashtag" + 
	 					" FROM ozip o, comment_num cn" + 
	 					" WHERE cn.ozip_idx(+) = o.ozip_idx" + 
	 					" ORDER BY o.ozip_idx DESC" + 
	 					" ) t) t2" + 
	 					" WHERE t2.rnum>=? AND t2.rnum<=?";
		 	PreparedStatement pstmt = conn.prepareStatement(sql);
		 	pstmt.setInt(1, ozipStartRNum);
		 	pstmt.setInt(2, ozipEndRNum);
		 	ResultSet rs = pstmt.executeQuery();
		 	
		 	while(rs.next()) {
		 		int ozipIdx = rs.getInt("ozip_idx");
		 		String title = rs.getString("title");
		 		String memberId = rs.getString("member_id");
		 		String writedate = rs.getString("writedate");
		 		int cNum = rs.getInt("c_num");
		 		int hitcount = rs.getInt("hitcount");
		 		String hashtag = rs.getString("hashtag");
		 		
		 		// 2) OzipVo (2)
				
				 String sql2 = "SELECT t.*" + " FROM (" + "    SELECT  ozip_idx," +
						 	" (SELECT img_url FROM view_ozip_img_imgurlnotnull WHERE img_idx=(SELECT min(img_idx) FROM view_ozip_img_imgurlnotnull WHERE ozip_idx=oi.ozip_idx)) img_url," +
						 	" (SELECT description FROM view_ozip_img_descnotnull WHERE img_idx=(SELECT min(img_idx) FROM view_ozip_img_descnotnull WHERE ozip_idx=oi.ozip_idx)) description"+ 				
						 	" FROM ozip_img oi" + "    GROUP BY ozip_idx " + " ) t " +
						 	" WHERE ozip_idx=?";
				 
		 		/*String sql2 = "SELECT  t2.* " + 
		 					" FROM (SELECT rownum rnum, t.* " + 
		 					" FROM ( SELECT  ozip_idx, (SELECT img_url FROM view_ozip_img_imgurlnotnull WHERE img_idx=(SELECT min(img_idx) FROM view_ozip_img_imgurlnotnull WHERE ozip_idx=oi.ozip_idx)) img_url," + 
		 					" ( SELECT description FROM view_ozip_img_descnotnull WHERE img_idx=(SELECT min(img_idx) FROM view_ozip_img_descnotnull WHERE ozip_idx=oi.ozip_idx)) description" + 
		 					" FROM ozip_img oi GROUP BY ozip_idx  ) t" + 
		 					" WHERE ozip_idx=? ) t2" + 
		 					" WHERE t2.rnum>=? AND t2.rnum<=?";*/
		 		PreparedStatement pstmt2 = conn.prepareStatement(sql2);
		 		pstmt2.setInt(1, ozipIdx);
//		 		pstmt2.setInt(2, ozipStartRNum);
//		 		pstmt2.setInt(3, ozipEndRNum);
		 		ResultSet rs2 = pstmt2.executeQuery();
		 		if(rs2.next()) {
		 			String imgUrl = rs2.getString("img_url");
		 			String description = rs2.getString("description");
		 			OzipVo vo = new OzipVo(ozipIdx, title, memberId, writedate, cNum, hitcount, hashtag, imgUrl, description);
		 			listOzipRet.add(vo);
		 		}
		 		rs2.close();
		 		pstmt2.close();
		 	}
		 	rs.close();
		 	pstmt.close();
		 	conn.close();
	 	} catch(SQLException e) {
	 		e.printStackTrace();
	 	}
	 	return listOzipRet;
	}
	
	//마지막 페이지 번호를 리턴 ----- 사용X (sort도 생겼고, query도 생겼는데, 여기에는 미반영 그래서 삭제 예정)
/*	public int getLastPageNum() {
		
		Connection conn = DBConnection.getConnection();
		
		int cnt = 0;
		String sql ="SELECT count(*) FROM ozip"; 
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				cnt = rs.getInt(1);
			}
			rs.close();
			pstmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		if(cnt%10==0) {
			return cnt/10;
		} else {
			return cnt/10 + 1;
		}
	}
*/
	
	// paramSort : "recent", "popular", "comment"
	public ArrayList<OzipVo> getAllListSorted(int pageNum, String paramSort) {
		String strOrderBy = "";
		switch(paramSort) {
		case "recent": strOrderBy = "o.ozip_idx DESC"; break;
		case "popular": strOrderBy = "o.hitcount DESC"; break;
		case "comment": strOrderBy = "(SELECT NVL(max(comment_idx), 0)" 
									+ " FROM view_oc_write"
									+ " WHERE ozip_idx=o.ozip_idx) DESC"; break;      
		}
		
		ArrayList<OzipVo> listOzipRet = new ArrayList<OzipVo>();
		Connection conn = DBConnection.getConnection();
		
		int ozipEndRNum = pageNum * 10;
		int ozipStartRNum = ozipEndRNum - 9;
	 	
	 	try {
		 	// 1) OzipVo (1)
			/*
			 * String sql =
			 * "SELECT o.ozip_idx, o.title, o.member_id, o.writedate, cn.c_num,o.hitcount, o.hashtag"
			 * + " FROM ozip o, comment_num cn" + " WHERE cn.ozip_idx(+) = o.ozip_idx " +
			 * " ORDER BY o.ozip_idx DESC";
			 */
	 		String sql = "SELECT t2.*" + 
	 					" FROM (" + 
	 					" SELECT rownum rnum, t.*" + 
	 					" FROM (" + 
	 					" SELECT o.ozip_idx, o.title, o.member_id, o.writedate, cn.c_num,o.hitcount, o.hashtag" + 
	 					" FROM ozip o, comment_num cn" + 
	 					" WHERE cn.ozip_idx(+) = o.ozip_idx" + 
	 					" ORDER BY " + strOrderBy +
	 					" ) t) t2" + 
	 					" WHERE t2.rnum>=? AND t2.rnum<=?";
		 	PreparedStatement pstmt = conn.prepareStatement(sql);
		 	pstmt.setInt(1, ozipStartRNum);
		 	pstmt.setInt(2, ozipEndRNum);
		 	ResultSet rs = pstmt.executeQuery();
		 	
		 	while(rs.next()) {
		 		int ozipIdx = rs.getInt("ozip_idx");
		 		String title = rs.getString("title");
		 		String memberId = rs.getString("member_id");
		 		String writedate = rs.getString("writedate");
		 		int cNum = rs.getInt("c_num");
		 		int hitcount = rs.getInt("hitcount");
		 		String hashtag = rs.getString("hashtag");
		 		
		 		// 2) OzipVo (2)
				
				 String sql2 = "SELECT t.*" + " FROM (" + "    SELECT  ozip_idx," +
						 	" (SELECT img_url FROM view_ozip_img_imgurlnotnull WHERE img_idx=(SELECT min(img_idx) FROM view_ozip_img_imgurlnotnull WHERE ozip_idx=oi.ozip_idx)) img_url," +
						 	" (SELECT description FROM view_ozip_img_descnotnull WHERE img_idx=(SELECT min(img_idx) FROM view_ozip_img_descnotnull WHERE ozip_idx=oi.ozip_idx)) description"+ 				
						 	" FROM ozip_img oi" + "    GROUP BY ozip_idx " + " ) t " +
						 	" WHERE ozip_idx=?";
				 
		 		/*String sql2 = "SELECT  t2.* " + 
		 					" FROM (SELECT rownum rnum, t.* " + 
		 					" FROM ( SELECT  ozip_idx, (SELECT img_url FROM view_ozip_img_imgurlnotnull WHERE img_idx=(SELECT min(img_idx) FROM view_ozip_img_imgurlnotnull WHERE ozip_idx=oi.ozip_idx)) img_url," + 
		 					" ( SELECT description FROM view_ozip_img_descnotnull WHERE img_idx=(SELECT min(img_idx) FROM view_ozip_img_descnotnull WHERE ozip_idx=oi.ozip_idx)) description" + 
		 					" FROM ozip_img oi GROUP BY ozip_idx  ) t" + 
		 					" WHERE ozip_idx=? ) t2" + 
		 					" WHERE t2.rnum>=? AND t2.rnum<=?";*/
		 		PreparedStatement pstmt2 = conn.prepareStatement(sql2);
		 		pstmt2.setInt(1, ozipIdx);
//		 		pstmt2.setInt(2, ozipStartRNum);
//		 		pstmt2.setInt(3, ozipEndRNum);
		 		ResultSet rs2 = pstmt2.executeQuery();
		 		if(rs2.next()) {
		 			String imgUrl = rs2.getString("img_url");
		 			String description = rs2.getString("description");
		 			OzipVo vo = new OzipVo(ozipIdx, title, memberId, writedate, cNum, hitcount, hashtag, imgUrl, description);
		 			listOzipRet.add(vo);
//		 			System.out.println("ozipIdx : " + ozipIdx + ", title : " + title + ", memberId : " + memberId + ", writedate : " + writedate + ", cNum : " + cNum + ", hitcount : " + hitcount + ", hashtag : " + hashtag + ", imgUrl : " + imgUrl + ", description : " + description);
		 		}
		 		rs2.close();
		 		pstmt2.close();
		 	}
		 	rs.close();
		 	pstmt.close();
		 	conn.close();
	 	} catch(SQLException e) {
	 		e.printStackTrace();
	 	}
	 	return listOzipRet;
	}

	// arrQuery : (ex) ["외관", "외벽"] 
	// paramSort : "recent", "popular", "comment"
	public ArrayList<OzipVo> getAllListSortedKeyword(int pageNum, String paramSort, String[] arrQuery) {
		String strQueryKeyword = "";
		for(int i=0; i<=arrQuery.length-1; i++) {
			if(i>0) strQueryKeyword += " OR ";
			strQueryKeyword += " (o.title || o.hashtag LIKE '%" + arrQuery[i] + "%') ";
		}
		String strOrderBy = "";
		switch(paramSort) {
		case "recent": strOrderBy = "o.ozip_idx DESC"; break;
		case "popular": strOrderBy = "o.hitcount DESC"; break;
		case "comment": strOrderBy = "(SELECT NVL(max(comment_idx), 0)" 
									+ " FROM view_oc_write"
									+ " WHERE ozip_idx=o.ozip_idx) DESC"; break;      
		}
		
		ArrayList<OzipVo> listOzipRet = new ArrayList<OzipVo>();
		Connection conn = DBConnection.getConnection();
		
		int ozipEndRNum = pageNum * 10;
		int ozipStartRNum = ozipEndRNum - 9;
	 	
	 	try {
		 	// 1) OzipVo (1)
			/*
			 * String sql =
			 * "SELECT o.ozip_idx, o.title, o.member_id, o.writedate, cn.c_num,o.hitcount, o.hashtag"
			 * + " FROM ozip o, comment_num cn" + " WHERE cn.ozip_idx(+) = o.ozip_idx " +
			 * " ORDER BY o.ozip_idx DESC";
			 */
	 		String sql = "SELECT t2.*" + 
	 					" FROM (" + 
	 					" SELECT rownum rnum, t.*" + 
	 					" FROM (" + 
	 					" SELECT o.ozip_idx, o.title, o.member_id, o.writedate, cn.c_num,o.hitcount, o.hashtag" + 
	 					" FROM ozip o, comment_num cn" + 
	 					" WHERE cn.ozip_idx(+) = o.ozip_idx" +
	 					" AND (" + strQueryKeyword + ")" +	            
	 					" ORDER BY " + strOrderBy +
	 					" ) t) t2" + 
	 					" WHERE t2.rnum>=? AND t2.rnum<=?";
//	 		System.out.println("[OmainDao, getAllListSortedKeyword(), sql = " + sql);
		 	PreparedStatement pstmt = conn.prepareStatement(sql);
		 	pstmt.setInt(1, ozipStartRNum);
		 	pstmt.setInt(2, ozipEndRNum);
		 	ResultSet rs = pstmt.executeQuery();
		 	
		 	while(rs.next()) {
		 		int ozipIdx = rs.getInt("ozip_idx");
		 		String title = rs.getString("title");
		 		String memberId = rs.getString("member_id");
		 		String writedate = rs.getString("writedate");
		 		int cNum = rs.getInt("c_num");
		 		int hitcount = rs.getInt("hitcount");
		 		String hashtag = rs.getString("hashtag");
		 		
		 		// 2) OzipVo (2)
				
				 String sql2 = "SELECT t.*" + " FROM (" + "    SELECT  ozip_idx," +
						 	" (SELECT img_url FROM view_ozip_img_imgurlnotnull WHERE img_idx=(SELECT min(img_idx) FROM view_ozip_img_imgurlnotnull WHERE ozip_idx=oi.ozip_idx)) img_url," +
						 	" (SELECT description FROM view_ozip_img_descnotnull WHERE img_idx=(SELECT min(img_idx) FROM view_ozip_img_descnotnull WHERE ozip_idx=oi.ozip_idx)) description"+ 				
						 	" FROM ozip_img oi" + "    GROUP BY ozip_idx " + " ) t " +
						 	" WHERE ozip_idx=?";
				 
		 		/*String sql2 = "SELECT  t2.* " + 
		 					" FROM (SELECT rownum rnum, t.* " + 
		 					" FROM ( SELECT  ozip_idx, (SELECT img_url FROM view_ozip_img_imgurlnotnull WHERE img_idx=(SELECT min(img_idx) FROM view_ozip_img_imgurlnotnull WHERE ozip_idx=oi.ozip_idx)) img_url," + 
		 					" ( SELECT description FROM view_ozip_img_descnotnull WHERE img_idx=(SELECT min(img_idx) FROM view_ozip_img_descnotnull WHERE ozip_idx=oi.ozip_idx)) description" + 
		 					" FROM ozip_img oi GROUP BY ozip_idx  ) t" + 
		 					" WHERE ozip_idx=? ) t2" + 
		 					" WHERE t2.rnum>=? AND t2.rnum<=?";*/
		 		PreparedStatement pstmt2 = conn.prepareStatement(sql2);
		 		pstmt2.setInt(1, ozipIdx);
//		 		pstmt2.setInt(2, ozipStartRNum);
//		 		pstmt2.setInt(3, ozipEndRNum);
		 		ResultSet rs2 = pstmt2.executeQuery();
		 		if(rs2.next()) {
		 			String imgUrl = rs2.getString("img_url");
		 			String description = rs2.getString("description");
		 			OzipVo vo = new OzipVo(ozipIdx, title, memberId, writedate, cNum, hitcount, hashtag, imgUrl, description);
		 			listOzipRet.add(vo);
//		 			System.out.println("ozipIdx : " + ozipIdx + ", title : " + title + ", memberId : " + memberId + ", writedate : " + writedate + ", cNum : " + cNum + ", hitcount : " + hitcount + ", hashtag : " + hashtag + ", imgUrl : " + imgUrl + ", description : " + description);
		 		}
		 		rs2.close();
		 		pstmt2.close();
		 	}
		 	rs.close();
		 	pstmt.close();
		 	conn.close();
	 	} catch(SQLException e) {
	 		e.printStackTrace();
	 	}
	 	return listOzipRet;
	}
	
	public int getCountAllListSortedKeyword(int pageNum, String paramSort, String[] arrQuery) {
		Connection conn = DBConnection.getConnection();

		String strQueryKeyword = "";
		for(int i=0; i<=arrQuery.length-1; i++) {
			if(i>0) strQueryKeyword += " OR ";
			strQueryKeyword += " (o.title || o.hashtag LIKE '%" + arrQuery[i] + "%') ";
		}
		String strOrderBy = "";
		switch(paramSort) {
		case "recent": strOrderBy = "o.ozip_idx DESC"; break;
		case "popular": strOrderBy = "o.hitcount DESC"; break;
		case "comment": strOrderBy = "(SELECT NVL(max(comment_idx), 0)" 
									+ " FROM view_oc_write"
									+ " WHERE ozip_idx=o.ozip_idx) DESC"; break;      
		}
		
		int cnt = 0;
	 	try {
	 		String sql = "SELECT count(*)" + 
	 					" FROM (" + 
	 					" SELECT rownum rnum, t.*" + 
	 					" FROM (" + 
	 					" SELECT o.ozip_idx, o.title, o.member_id, o.writedate, cn.c_num,o.hitcount, o.hashtag" + 
	 					" FROM ozip o, comment_num cn" + 
	 					" WHERE cn.ozip_idx(+) = o.ozip_idx" +
	 					" AND (" + strQueryKeyword + ")" +	            
	 					" ORDER BY " + strOrderBy +
	 					" ) t) t2";
//System.out.println("[OmainDao, getCountAllListSortedKeyword(), sql = " + sql); 제데로 출력되는지 체크
		 	PreparedStatement pstmt = conn.prepareStatement(sql);
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
//	 	System.out.println(cnt);
		return cnt;
	}
	
	//오집인 상세페이지 -1 내용, 이미지
		public ArrayList<OzipDetailVo> ozipDetail1(int ozipIdx) {
			ArrayList<OzipDetailVo> listOzipDetailVo = new ArrayList<OzipDetailVo>();
			Connection conn = DBConnection.getConnection();
			
			String sql = "SELECT *" + 
					 	" FROM ozip_img" + 
					 	" WHERE ozip_idx = ?" +
					 	" ORDER BY img_idx ASC";
			try {
				PreparedStatement pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, ozipIdx);
				ResultSet rs = pstmt.executeQuery();
				while(rs.next()) {
					String ozipDetailImgUrl = rs.getString("img_url");
					String ozipDetailDescription = rs.getString("description");
					OzipDetailVo voDetail = new OzipDetailVo(ozipIdx, ozipDetailImgUrl, ozipDetailDescription);
					listOzipDetailVo.add(voDetail);
				}
				rs.close();
				pstmt.close();
				conn.close();
			} catch(SQLException e) {
				e.printStackTrace();
			}
			return listOzipDetailVo;
		}
	
	//오집인 상세페이지 -2 타이틀, 닉네임, 조회수, 태그 등등 
		public OzipDetailVo2 ozipDetail2(int ozipIdx) {
			OzipDetailVo2 vo = null;
			Connection conn = DBConnection.getConnection();
			
			String sql = "SELECT o.ozip_idx, o.title, o.member_id, o.writedate, cn.c_num,o.hitcount, o.hashtag" + 
						" FROM ozip o, comment_num cn" + 
						" WHERE cn.ozip_idx(+) = o.ozip_idx" + 
						" AND o.ozip_idx = ?" + 
						" ORDER BY o.ozip_idx DESC";
			try {
				PreparedStatement pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1,  ozipIdx);
				ResultSet rs = pstmt.executeQuery();
				if(rs.next()) {
					String ozipTitle = rs.getString("title");
					String ozipMemberId = rs.getString("member_id");
					String ozipWritedate = rs.getString("writedate");
					int ozipCNum = rs.getInt("c_num");
					int ozipHitcount = rs.getInt("hitcount");
					String ozipHashtag = rs.getString("hashtag");
					vo = new OzipDetailVo2(ozipIdx, ozipTitle, ozipMemberId, ozipWritedate, ozipCNum, ozipHitcount, ozipHashtag);
				}
				rs.close();
				pstmt.close();
				conn.close();
			} catch(SQLException e) {
				e.printStackTrace();
			}
			return vo;
		}
	
	
	//ozip내용을 작성 질문글 작성
	public int ozipWrite(String ozipTitle, String OzipDescription, String memberId) {
		Connection conn = DBConnection.getConnection();
		int ozipIdx = 0;
		String sql = "INSERT INTO ozip(ozip_idx, title, member_id, writedate, hitcount, hashtag)" + 
					" VALUES(SEQ_OZIPIDX.nextval, ?, ?, SYSDATE, 0, '가구배치/이동')";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, ozipTitle);
			pstmt.setString(2, memberId);
			pstmt.executeUpdate();
			
			pstmt.close();
			
			String sql2 = "INSERT INTO ozip_img(img_idx, ozip_idx, img_url, description)" + 
						" VALUES(SEQ_OZIPIMGIDX.nextval ,SEQ_OZIPIDX.currval, '', ?)";
			
			PreparedStatement pstmt2 = conn.prepareStatement(sql2);
			pstmt2.setString(1, OzipDescription);	//이거 2번째쿼리문
			pstmt2.executeUpdate();
			
			//이건 왜 들어가?
//			String sql3 = "INSERT INTO ozip_comment(comment_idx, ozip_idx)" + 
//						" VALUES(SEQ_OZIPCOMMENTIDX.nextval, SEQ_OZIPIDX.currval)";
	
//			PreparedStatement pstmt3 = conn.prepareStatement(sql3);
//			pstmt3.executeUpdate();
//			pstmt3.close();
			pstmt2.close();
			pstmt.close();
			conn.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}
		return ozipIdx;
	}
	
	
	// ozip질문글 삭제
	public void OzipDelete(int ozipIdx) {
		Connection conn = DBConnection.getConnection();
		String sql = "DELETE FROM ozip WHERE ozip_idx = ?";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, ozipIdx);
			pstmt.executeUpdate();
			pstmt.close();
			String sql2 = "DELETE FROM ozip_comment WHERE ozip_idx = ?";
			PreparedStatement pstmt2 = conn.prepareStatement(sql2);
			pstmt2.setInt(1, ozipIdx);
			pstmt2.executeUpdate();
			pstmt2.close();
			
			String sql3 = "DELETE FROM ozip_img WHERE ozip_idx = ?";
			
			PreparedStatement pstmt3 = conn.prepareStatement(sql3);
			pstmt3.setInt(1, ozipIdx);
			pstmt3.executeUpdate();
			pstmt3.close();
			conn.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}
	
	// ozip --> OzipVo객체를 리턴
	// ozip modify 페이지에 타이틀 컨텐츠 띄우기
	public OzipModifyVo getOzipModifyByOzipIdx(int ozipIdx) {
		OzipModifyVo vo = null;
		Connection conn = DBConnection.getConnection();
		
		String sql = "SELECT ozip_idx, title, hashtag" + 
					" FROM ozip" + 
					" WHERE ozip_idx = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, ozipIdx);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				String ozipTitle = rs.getString("title");
				String ozipHashtag = rs.getString("hashtag");
				vo = new OzipModifyVo(ozipIdx, ozipTitle, ozipHashtag);
			}
			rs.close();
			pstmt.close();
			conn.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}
		return vo;
	}
	
	// ozip modify 페이지 사진 내용
	
	
	/*
	 * String sql = "SELECT *" + " FROM ozip_img" + " WHERE ozip_idx = ?" +
	 * " ORDER BY img_idx"; PreparedStatement pstmt = conn.prepareStatement(sql);
	 * pstmt.setInt(1, ozipIdx); ResultSet rs = pstmt.execute
	 */
	// ozip내용을 작성 질문글 수정 Update
	
	public void ozipModify(int ozipIdx, String ozipTitle, String ozipDescription) {
	  	Connection conn = DBConnection.getConnection();
		String sql = "UPDATE ozip" + 
					" SET title=?, hashtag='도배'" + 		//도배도 바꿔야돼 해쉬태그도
					" WHERE ozip_idx = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, ozipTitle);
			pstmt.setInt(2, ozipIdx);
			pstmt.executeUpdate();
			
			String sql2 = "UPDATE ozip_img" + 
						" SET img_url='', description=?" + 
						" WHERE ozip_idx = ?";
			
			PreparedStatement pstmt2 = conn.prepareStatement(sql2);
			pstmt2.setString(1, ozipDescription);
			pstmt2.setInt(2, ozipIdx);
			pstmt2.executeUpdate();
			
			pstmt2.close();
			pstmt.close();
			conn.close();
		} catch(Exception e) {
			e.printStackTrace();
		} 
	}
	
	
	
	//OMainDetail reply댓글
	public ArrayList<OzipReplyVo> getReplyListByOzipIdx(int ozipIdx) {
		ArrayList<OzipReplyVo> listRet = new ArrayList<OzipReplyVo>();
		Connection conn = DBConnection.getConnection();
		
//		String sql = "SELECT *" 
//				+ " FROM ozip_comment"  
//				+ " WHERE ozip_idx = ?"  
//				+ " ORDER BY recomment_idx DESC, comment_order ASC";
		String sql = "SELECT (SELECT writedate FROM ozip_comment WHERE comment_idx=oc.recomment_idx) wd2, oc.* "
					+ " FROM ozip_comment oc "
					+ " WHERE ozip_idx = ? "
					+ " ORDER BY wd2 DESC, comment_order ASC";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, ozipIdx);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				int commentIdx = rs.getInt("comment_idx");
				int recommentIdx = rs.getInt("recomment_idx");
				int commentOrder = rs.getInt("comment_order");
				String memberId = rs.getString("member_id");
				String content = rs.getString("content");
				String imgUrl = rs.getString("img_url");
				String writedate = rs.getString("writedate");
					OzipReplyVo vo = new OzipReplyVo(commentIdx, recommentIdx, ozipIdx, commentOrder, memberId, content, imgUrl, writedate);
					listRet.add(vo);
			}
			rs.close();
			pstmt.close();
			conn.close();
		} catch(SQLException e) { e.printStackTrace(); }
		
		return listRet;
	}
	
	
	//댓글수 세기 comment_order가 0인 댓글을 5개 출력.. 나중에
	public int getCommentList(int ozipIdx, int commentPageNum) {
		Connection conn = DBConnection.getConnection();
		int cnt = 0;
		String sql = "SELECT count(*) " + 
					" FROM ozip_comment " + 
					" WHERE ozip_idx = ? " + 
					" AND comment_order = 0 " +
					" ORDER BY recomment_idx DESC, comment_order ASC";

		//이건 목록 띄울거
//		String sql = "SELECT t2.*" + 
//					" FROM " + 
//					" SELECT rownum rnum, t.*" + 
//					" FROM " + 
//					" SELECT * " + 
//					" FROM ozip_comment  " + 
//					" WHERE ozip_idx = 145020  " + 
//					" ORDER BY recomment_idx DESC, comment_order ASC" + 
//					" ) t) t2" + 
//					" WHERE comment_order = 0";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, ozipIdx);
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
		return cnt;
	}
	//ajax 댓글 달기
	public void ozipReply(int ozipIdx, String memberId, String content, String imgUrl) {
		Connection conn = DBConnection.getConnection();
		
		String sql = "INSERT INTO ozip_comment(comment_idx, recomment_idx, ozip_idx, comment_order, member_id, content, img_url, writedate)" + 
				"VALUES(SEQ_OZIPCOMMENTIDX.nextval, SEQ_OZIPCOMMENTIDX.nextval , ?, 0, ?, ?, ?, SYSDATE)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, ozipIdx);
			pstmt.setString(2, memberId);
			pstmt.setString(3, content);
			pstmt.setString(4, imgUrl);
			pstmt.executeUpdate();
			pstmt.close();
			conn.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}

	public OzipReplyVo writeReplyOzipDetail(int ozipIdx, String memberId, String comment) {
		Connection conn = DBConnection.getConnection();
		
		String sql = "INSERT INTO ozip_comment(comment_idx, recomment_idx, ozip_idx, comment_order, member_id, content, img_url, writedate)\r\n" + 
					" VALUES(SEQ_OZIPCOMMENTIDX.nextval, SEQ_OZIPCOMMENTIDX.nextval, ?, 0, ?, ?, '', sysdate)";
		OzipReplyVo voRet = null;
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, ozipIdx);
			pstmt.setString(2, memberId);
			pstmt.setNString(3, comment);
			pstmt.executeUpdate();  // 성공했으면, 1을 리턴.
		} catch(SQLException e) {
			e.printStackTrace();
		}
		
		sql = "SELECT * FROM ozip_comment WHERE member_id=? ORDER BY comment_idx DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberId);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				int commentIdx = rs.getInt("comment_idx");
				int recommentIdx = rs.getInt("recomment_idx");
				int commentOrder = rs.getInt("comment_order");
				String content = rs.getString("content");
				String imgUrl = rs.getString("img_url");
				String writedate = rs.getString("writedate");
				voRet = new OzipReplyVo(commentIdx, recommentIdx, ozipIdx, commentOrder, memberId, content, imgUrl, writedate);
			}
			rs.close();
			pstmt.close();
			conn.close();
		} catch(SQLException e) { e.printStackTrace(); }
		return voRet;
	}

	//댓글 삭제
	public boolean deleteReplyOzipDetail(int commentIdx) {
		Connection conn = DBConnection.getConnection();
		
		String sql = "DELETE FROM ozip_comment WHERE comment_idx = ?";
		int ret = -1;
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, commentIdx);
			ret = pstmt.executeUpdate();		//영향받은 행의 갯수
			pstmt.close();
			conn.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}
		return ret==1;
	}

	public void write(String loginId, String title, String hashtag, ArrayList<String> listFilename, ArrayList<String> listDesc) {
		Connection conn = DBConnection.getConnection();
		
		// 1) INSERT INTO ozip(ozip_idx, title, member_id, writedate, hitcount, hashtag)
		//    VALUES(SEQ_OZIPIDX.nextval, ?, ?, SYSDATE, 0, ?);   --  title, loginId, hashtag
		String sql = "INSERT INTO ozip(ozip_idx, title, member_id, writedate, hitcount, hashtag) " 
					+ " VALUES(SEQ_OZIPIDX.nextval, ?, ?, SYSDATE, 0, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, title);
			pstmt.setString(2, loginId);
			pstmt.setString(3, hashtag);
			pstmt.executeUpdate();		//영향받은 행의 갯수
			pstmt.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}

		// 2) SELECT max(ozip_idx) FROM ozip WHERE member_id=?
		// ----------> int ozipIdx.
		sql = "SELECT max(ozip_idx) FROM ozip WHERE member_id=?";
		int ozipIdx = 0;
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, loginId);
			ResultSet rs = pstmt.executeQuery();		//영향받은 행의 갯수
			if(rs.next()) {
				ozipIdx = rs.getInt(1);
			}
			rs.close();
			pstmt.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}
		
		// 3) INSERT INTO ozip_img(img_idx, ozip_idx, img_url, description)
		//    VALUES(SEQ_OZIPIMGIDX.nextval ,?, ?, ?);   -- ozipIdx, listFilename.get(i), listDesc.get(i)
		sql = "INSERT INTO ozip_img(img_idx, ozip_idx, img_url, description)" 
			+ " VALUES(SEQ_OZIPIMGIDX.nextval ,?, ?, ?)";
		for(int i=0; i<=listFilename.size()-1; i++) {
			try {
				PreparedStatement pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, ozipIdx);
				pstmt.setString(2, listFilename.get(i));
				pstmt.setString(3, listDesc.get(i));
				pstmt.executeUpdate();		//영향받은 행의 갯수
				pstmt.close();
			} catch(SQLException e) {
				e.printStackTrace();
			}
		}
		
		try {
			conn.close();
		} catch(Exception e) { e.printStackTrace(); }
	}
	// 댓글 수정
	public boolean updateReplyOzipDetail(int ozipIdx, String memberId, int commentIdx, String comment) {
		Connection conn = DBConnection.getConnection();
		
		String sql = "UPDATE ozip_comment  " + 
					" SET content = ?, writedate = SYSDATE  " + 
					" WHERE ozip_idx = ?   " + 
					" AND comment_idx = ?";
		int ret = -1;
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, comment);
			pstmt.setInt(2, ozipIdx);
			pstmt.setInt(3, commentIdx);
			ret = pstmt.executeUpdate();
			pstmt.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}
		return ret>=0;
	}
	
	
	
	
	
	
	
}
