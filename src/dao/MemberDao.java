package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import common.DBConnection;
import vo.MPOzipVo;
import vo.MemberEditVo;
import vo.MemberVo;
import vo.MypageProfileHousePartyVo;
import vo.MypageProfileMemberInfoVo;
import vo.MypageShoppingListVo;
import vo.MypageShoppingOrequestVo;
import vo.MypageShoppingPrequestVo;

public class MemberDao {
	public boolean loginCheck(String email, String pw) {
		Connection conn = DBConnection.getConnection();
		
		String sql = "SELECT count(*) FROM member WHERE email=? AND password=?";
		int cnt = 0;
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, email);
			pstmt.setString(2, pw);
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
	//회원가입시 이메일 중복체크
	public boolean ajaxEmailCheck(String tempEmail) {
		Connection conn = DBConnection.getConnection();
		String sql = "SELECT COUNT(email) FROM member WHERE email = ?";
		int cnt = 0;
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, tempEmail);
			ResultSet rs =pstmt.executeQuery();
			if(rs.next()) {
				cnt = rs.getInt(1);
			}
			rs.close();
			pstmt.close();
			conn.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}
		return cnt == 0;
	}
	
	//회원가입시 아이디 중복체크
	public boolean ajaxMemberIdCheck(String tempMemberId) {
		Connection conn = DBConnection.getConnection();
		String sql = "SELECT COUNT(member_id) FROM member WHERE member_id=?";
		
		/* boolean result = false; */
		int cnt = 0;
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, tempMemberId);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				cnt = rs.getInt(1);
			} 
			rs.close();
			pstmt.close();
			conn.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}
		return cnt == 0;
	}	
	
	//회원가입 input -  비번, agree1~5
		public void createAccount(String memberId, String email, String password, ArrayList<Integer> agreeList) {
			Connection conn = DBConnection.getConnection();
			String basicImg = "https://image.ohou.se/i/bucketplace-v2-development/uploads/users/profile_images/169201692597692053.jpeg?gif=1";
			
			String sql = "update  member" + 
						" set password = ? , agree1 = 1 , agree2 = 1, agree3 = 1, agree4 = ?, agree5 = ?, profile_img = ?, " + 
						"    homepage = '', birthday = '', gender = 0, one_liner = '', admin = 0, kakao_id = ''" + 
						" where member_id = ?";
			try {
				PreparedStatement pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, password);
				if(agreeList.get(3) == 4) {
					pstmt.setInt(2, 1);
				} else {
					pstmt.setInt(2, 0);
				}
				if(agreeList.get(4) == 5) {
					pstmt.setInt(3, 1);
				} else {
					pstmt.setInt(3, 0);
				}
				pstmt.setString(4, basicImg);
				pstmt.setString(5, memberId);
//				pstmt.setInt(6, agree3);
//				pstmt.setInt(7, agree4);
//				pstmt.setInt(8, agree5);
				pstmt.executeUpdate();
				pstmt.close();
				conn.close();
			} catch(SQLException e) {
				e.printStackTrace();
			}
		}

	public void updatePw(String memberId, String pw) {
		Connection conn = DBConnection.getConnection();
		
		String sql = "UPDATE member " + 
					" SET password = ?" + 
					" WHERE member_id = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, pw);
			pstmt.setString(2, memberId);
			pstmt.executeUpdate();
			pstmt.close();
			conn.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}

	// 카카오로그인시 kakao_id(ex.또랑이는 3320786347) ---> MemberVo 로 변환. 
	public MemberVo getMemberVoFromKakaoId(long kakaoId, String accountEmail) {
		Connection conn = DBConnection.getConnection();
		String sql = "SELECT * FROM member WHERE kakao_id=? AND email=?";

		MemberVo vo = null;
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setLong(1, kakaoId);
			pstmt.setString(2, accountEmail);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				String memberId = rs.getString("member_id");
				/* String email = rs.getString("email"); */
				int authenticationCode = rs.getInt("authentication_code");
				String authenticationExpire = rs.getString("authentication_expire");
				String password = rs.getString("password");
				int agree1 = rs.getInt("agree1");
				int agree2 = rs.getInt("agree2");
				int agree3 = rs.getInt("agree3");
				int agree4 = rs.getInt("agree4");
				int agree5 = rs.getInt("agree5");
				String profileImg = rs.getString("profile_img");
				String homepage = rs.getString("homepage");
				String birthday = rs.getString("birthday");
				int gender = rs.getInt("gender");
				String oneLiner = rs.getString("one_liner");
				int admin = rs.getInt("admin");
				vo = new MemberVo(memberId, accountEmail, authenticationCode, authenticationExpire, password, agree1, agree2, agree3, agree4, agree5, profileImg, homepage, birthday, gender, oneLiner, admin, kakaoId);
			} 
			rs.close();
			pstmt.close();
			conn.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}
		return vo;
	}
	
	public void createAccountWithKakao(String memberId,
			String email, /* String password, ArrayList<Integer> agreeList, */
			String profileImage, long kakaoId) {
		Connection conn = DBConnection.getConnection();
		
		String sql = "INSERT INTO member(member_id, email, authentication_code, authentication_expire, password, agree1, agree2, agree3, agree4, agree5, profile_img, homepage, birthday, gender, one_liner, admin, kakao_id)" + 
					" VALUES(?, ?, '', '', '', 1, 1, 1, 0, 0, ?,'', '', 0, '', 0, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberId);
			pstmt.setString(2, email);
//			pstmt.setString(3, password);
//			if(agreeList.get(3) == 4) {
//				pstmt.setInt(4, 1);
//			} else {
//				pstmt.setInt(4, 0);
//			}
//			if(agreeList.get(4) == 5) {
//				pstmt.setInt(5, 1);
//			} else {
//				pstmt.setInt(5, 0);
//			}
			pstmt.setString(3, profileImage);
			pstmt.setLong(4, kakaoId);
			pstmt.executeQuery();
			pstmt.close();
			conn.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}
	public String getMemberId(String email) {
		Connection conn = DBConnection.getConnection();
		
		String sql = "SELECT member_id FROM member WHERE email = ?";
System.out.println("getMemberId() 에서, 파라미터 email은 '"+email+"'");		
		String memberId = "";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, email);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				memberId = rs.getString("member_id");
			}
			rs.close();
			pstmt.close();
			conn.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}
		return memberId;
	}
	
	
	//회원가입시 이메일인증 만료시간
//	public static void main(String[] args) throws Exception {
//		Connection conn = DBConnection.getConnection();
//		String sql = "SELECT * FROM member WHERE email='또랑이'";
//		PreparedStatement pstmt = conn.prepareStatement(sql);
//		ResultSet rs = pstmt.executeQuery();
//		if(rs.next()) {
//			String d1 = rs.getString("authentication_expire");
//			System.out.println(d1);	
//		}
//		rs.close();
//		pstmt.close();
//		conn.close();
//	}
	//이메일 인증 버튼누름과 동시에 이메일과 닉네임이 입력되고 동시에 입력받은 만료시간을 가져온다.
	public String ajaxCaMemberIdEmailAuthentication(String memberId, String email, int authenticationCode) {
		
		Connection conn = DBConnection.getConnection();
		String dateExpire ="";
		String sql = "INSERT INTO member(member_id, email, authentication_code, authentication_expire, password, agree1, agree2, agree3, agree4, agree5, profile_img, homepage, birthday, gender, one_liner, admin, kakao_id)" + 
					" VALUES(?, ?, ?, sysdate+3/24/60, '', 0, 0, 0, 0, 0, '', '', '', null, '', 0, null)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberId);
			pstmt.setString(2, email);
			pstmt.setInt(3, authenticationCode);
			pstmt.executeUpdate();
			
			String sql2 = "SELECT * FROM member WHERE email=?";
			PreparedStatement pstmt2 = conn.prepareStatement(sql2);
			pstmt2.setString(1, email);
			ResultSet rs = pstmt2.executeQuery();
			if(rs.next()) {
				dateExpire = rs.getString("authentication_expire");
				System.out.println("dao, dateExpire = " + dateExpire);	
			}
			rs.close();
			pstmt2.close();
			pstmt.close();
			conn.close();
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return dateExpire;
	}
	
	//이메일 인증번호 체크
	public boolean ajaxAuthenticationCodeCheck(String email, int authenticationCode) {
		Connection conn = DBConnection.getConnection();
		int cnt = 0;
		String sql = "SELECT count(*)" + 
					" FROM member" + 
					" WHERE authentication_code = ?" + 
					" AND email = ?";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, authenticationCode);
			pstmt.setString(2, email);
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
	
	//인증완료시 인증번호 인증 만료시간 null값으로
	public void ajaxUpdateAuthenticationCodeToNull(String email, int authenticationCode) {
		Connection conn = DBConnection.getConnection();
		String sql = "UPDATE member" + 
					" SET authentication_code = null, authentication_expire = ''" + 
					" WHERE email = ?" + 
					" AND authentication_code = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, email);
			pstmt.setInt(2, authenticationCode);
			pstmt.executeUpdate();
			pstmt.close();
			conn.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}
	//이메일 재인증시
	public String ajaxReCaMemberIdEmailAuthentication(String memberId, String email, int authenticationCode) {
		Connection conn = DBConnection.getConnection();
		String dateExpire ="";
		String sql = "UPDATE member SET email = ?, authentication_code = ?, authentication_expire = sysdate+3/24/60 WHERE member_id = ?";
			
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, email);
			pstmt.setInt(2, authenticationCode);
			pstmt.setString(3, memberId);
			pstmt.executeUpdate();
			
			String sql2 = "SELECT * FROM member WHERE email=?";
			PreparedStatement pstmt2 = conn.prepareStatement(sql2);
			pstmt2.setString(1, email);
			ResultSet rs = pstmt2.executeQuery();
			if(rs.next()) {
				dateExpire = rs.getString("authentication_expire");
				System.out.println("dao, dateExpire = " + dateExpire);	
			}
			rs.close();
			pstmt2.close();
			pstmt.close();
			conn.close();
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return dateExpire;
	}
	//마이페이지 수정전 정보 띄우기
	public MemberEditVo getMapageMemberInfo(String memberId) {
		Connection conn = DBConnection.getConnection();
		MemberEditVo mvo = null;
		
		String sql="SELECT *" + 
					" FROM member" + 
					" WHERE  member_id = ?";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberId);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				String email = rs.getString("email");
				String homepage = rs.getString("homepage");
				int gender = rs.getInt("gender");
				String birthday = rs.getString("birthday");
				String proFileImg = rs.getString("profile_img");
				String oneLiner = rs.getString("one_liner");
				mvo = new MemberEditVo(email, memberId, homepage, gender, birthday, proFileImg, oneLiner);
			}
			rs.close();
			pstmt.close();
			conn.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}
		return mvo;
	}
	//마이페이지 유저정보 수정
	public void updateMemberInfo(String email, String memberId, String homepage, int gender, String birthday,
			String profileImg, String oneLiner) {
		Connection conn = DBConnection.getConnection();
		String sql = "UPDATE member" + 
					" SET member_id = ? , homepage = ? , gender = ? , birthday = ? , profile_img = ? , one_liner = ?" + 
					" WHERE  email = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberId);
			pstmt.setString(2, homepage);
			pstmt.setInt(3, gender);
			pstmt.setString(4, birthday);
			pstmt.setString(5, profileImg);
			pstmt.setString(6, oneLiner);
			pstmt.setString(7, email);
			pstmt.executeUpdate();
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}
	//마이페이지 쇼핑 리스트
	public ArrayList<MypageShoppingListVo> getMypageShoppingList(String memberId) {
		ArrayList<MypageShoppingListVo> listRet = new ArrayList<MypageShoppingListVo>();
		Connection conn = DBConnection.getConnection();
		String sql = "SELECT m.member_id, m.order_idx, m.product_idx,pmi.img_idx, pmi.img_url, p.brand_name, p.name, o.option_idx, po.option1_value,m.processed_state, " + 
					"        m.order_date, m.payment_date, op.qty, p.after_price" + 
					" FROM mirotic m, order_option o, product p, product_option po, product_main_img pmi, order_option op" + 
					" WHERE m.order_idx = o.order_idx" + 
					" AND m.product_idx = p.product_idx" + 
					" AND po.option_idx = o.option_idx" + 
					" AND pmi.product_idx = m.product_idx" + 
					" AND op.order_idx = o.order_idx" + 
					" AND pmi.img_idx = 1" + 
					" AND member_id=? " + 
				/* " AND processed_state='구매확정'" + */
					" ORDER BY order_date DESC";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			MypageShoppingListVo vo = null;
			pstmt.setString(1, memberId);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				int orderIdx =rs.getInt("order_idx"); 
				int productIdx =rs.getInt("product_idx"); 
				int imgIdx =rs.getInt("img_idx"); 
				String imgUrl =rs.getString("img_url"); 
				String brandName =rs.getString("brand_name"); 
				String name =rs.getString("name"); 
				int optionIdx =rs.getInt("option_idx"); 
				String optionValue =rs.getString("option1_value"); 
				String processedState =rs.getString("processed_state"); 
				String orderDate =rs.getString("order_date"); 
				String paymentDate =rs.getString("payment_date");
				int qty = rs.getInt("qty");
				int afterPrice = rs.getInt("after_price");
				vo = new MypageShoppingListVo(memberId, orderIdx, productIdx, imgIdx, imgUrl, brandName, name, optionIdx, optionValue, processedState, orderDate, paymentDate, qty, afterPrice);
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
	//마이페이지 상품문의 
	public ArrayList<MypageShoppingPrequestVo> getMypageShoppingPrequest(String memberId) {
		Connection conn = DBConnection.getConnection();
		ArrayList<MypageShoppingPrequestVo> mpShoppingPrequestRet = new ArrayList<MypageShoppingPrequestVo>();
		
		String sql = "SELECT p.name, p.brand_name, pi.*, m.processed_state, po.option1_value, po.option2_value, po.option3_value " + 
					" FROM product_inquiry pi, mirotic m, product_option po, product p " + 
					" WHERE pi.product_idx = m.product_idx " + 
					" AND m.product_idx = po.product_idx" + 
					" AND p.product_idx = pi.product_idx" + 
					" AND pi.member_id = ?" +
					" AND pi.order_idx IS NULL ";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberId);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				String name = rs.getString("name");
				String brandName = rs.getString("brand_name");
				int inquiryIdx = rs.getInt("inquiry_idx");
				int productIdx = rs.getInt("product_idx");
				int orderIdx = -1;
				int orderProductOption = rs.getInt("order_product_option");
				String category = rs.getString("category");
				String status = rs.getString("status");
				/* String memberId = rs.getInt("member_id"); */
				String q = rs.getString("q");
				String qWritedate = rs.getString("q_writedate");
				String a = rs.getString("a");
				String aWritedate = rs.getString("a_writedate");
				String processedState = rs.getString("processed_state");
				String option1Value = rs.getString("option1_value");
				String option2Value = rs.getString("option2_value");
				String option3Value = rs.getString("option3_value");
				MypageShoppingPrequestVo prVo = new MypageShoppingPrequestVo(name, brandName, inquiryIdx, productIdx, orderIdx, orderProductOption, category, status, memberId, q, qWritedate, a, aWritedate, processedState, option1Value, option2Value, option3Value);
				mpShoppingPrequestRet.add(prVo);
			}
			rs.close();
			pstmt.close();
			conn.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}
		return mpShoppingPrequestRet;
	}
	//주문문의 가져오기 명세서에 추가하기
	public ArrayList<MypageShoppingOrequestVo> getMypageShoppingOrequest(String memberId) {
		Connection conn = DBConnection.getConnection();
		ArrayList<MypageShoppingOrequestVo> mpShoppingOrequestRet = new ArrayList<MypageShoppingOrequestVo>();
		
		String sql = "SELECT p.name, p.brand_name, pi.*, m.processed_state, po.option1_value, po.option2_value, po.option3_value " + 
					" FROM product_inquiry pi, mirotic m, product_option po, product p " + 
					" WHERE pi.product_idx = m.product_idx " + 
					" AND m.product_idx = po.product_idx" + 
					" AND p.product_idx = pi.product_idx" + 
					" AND pi.member_id = ?" +
					" AND pi.order_idx IS NOT NULL ";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberId);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				String name = rs.getString("name");
				String brandName = rs.getString("brand_name");
				int inquiryIdx = rs.getInt("inquiry_idx");
				int productIdx = rs.getInt("product_idx");
				int orderIdx = rs.getInt("order_idx");
				int orderProductOption = rs.getInt("order_product_option");
				String category = rs.getString("category");
				String status = rs.getString("status");
				/* String memberId = rs.getInt("member_id"); */
				String q = rs.getString("q");
				String qWritedate = rs.getString("q_writedate");
				String a = rs.getString("a");
				String aWritedate = rs.getString("a_writedate");
				String processedState = rs.getString("processed_state");
				String option1Value = rs.getString("option1_value");
				String option2Value = rs.getString("option2_value");
				String option3Value = rs.getString("option3_value");
				MypageShoppingOrequestVo orVo = new MypageShoppingOrequestVo(name, brandName, inquiryIdx, productIdx, orderIdx, orderProductOption, category, status, memberId, q, qWritedate, a, aWritedate, processedState, option1Value, option2Value, option3Value);
				mpShoppingOrequestRet.add(orVo);
			}
			rs.close();
			pstmt.close();
			conn.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}
		return mpShoppingOrequestRet;
	}
	
	//마이페이지 프로필 with 오집인
	public ArrayList<MPOzipVo> getMemberProfileWithOzip(String memberId) {
		Connection conn = DBConnection.getConnection();
		ArrayList<MPOzipVo> listMPOzipVo = new ArrayList<MPOzipVo>();
		try {
		 	// 1) OzipVo (1)
		 	String sql = "SELECT o.ozip_idx, o.title, o.member_id, o.writedate, cn.c_num,o.hitcount, o.hashtag" + 
			 			" FROM ozip o, comment_num cn" + 
			 			" WHERE cn.ozip_idx(+) = o.ozip_idx " +
			 			" AND o.member_id = ? " +
			 			" ORDER BY o.ozip_idx DESC";
		 	PreparedStatement pstmt = conn.prepareStatement(sql);
		 	pstmt.setString(1, memberId);
		 	ResultSet rs = pstmt.executeQuery();
		 	while(rs.next()) {
		 		int ozipIdx = rs.getInt("ozip_idx");
		 		String title = rs.getString("title");
		 		String writedate = rs.getString("writedate");
		 		int cNum = rs.getInt("c_num");
		 		int hitcount = rs.getInt("hitcount");
		 		String hashtag = rs.getString("hashtag");
		 		
		 		// 2) OzipVo (2)
		 		String sql2 = "SELECT t.*" + 
			 				" FROM (" + 
			 				"    SELECT  ozip_idx," + 
			 				"    (SELECT img_url FROM view_ozip_img_imgurlnotnull WHERE img_idx=(SELECT min(img_idx) FROM view_ozip_img_imgurlnotnull WHERE ozip_idx=oi.ozip_idx)) img_url," + 
			 				"    (SELECT description FROM view_ozip_img_descnotnull WHERE img_idx=(SELECT min(img_idx) FROM view_ozip_img_descnotnull WHERE ozip_idx=oi.ozip_idx)) description" + 
			 				"    FROM ozip_img oi" + 
			 				"    GROUP BY ozip_idx " + 
			 				" ) t " + 
			 				" WHERE ozip_idx=?";
		 		PreparedStatement pstmt2 = conn.prepareStatement(sql2);
		 		pstmt2.setInt(1, ozipIdx);
		 		ResultSet rs2 = pstmt2.executeQuery();
		 		if(rs2.next()) {
		 			String imgUrl = rs2.getString("img_url");
		 			String description = rs2.getString("description");
		 			MPOzipVo MPvo = new MPOzipVo(ozipIdx, title, memberId, writedate, cNum, hitcount, hashtag, imgUrl, description);
		 			listMPOzipVo.add(MPvo);
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
		
		return listMPOzipVo;
	}
	//삭제할 문의글
	public boolean deleteMapageInquiry(int inquiryIdx) {
		Connection conn = DBConnection.getConnection();
		
		String sql = "DELETE FROM product_inquiry WHERE inquiry_idx = ?";
		int ret = -1;
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, inquiryIdx);
			ret = pstmt.executeUpdate();	//영향받은 행의 갯수
			pstmt.close();
			conn.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}
		
		return ret==1;
	}
	//마이페이지 집들이 커버띄우기
	public ArrayList<MypageProfileHousePartyVo> getMapageProfileHouseParty(String memberId) {
		Connection conn = DBConnection.getConnection();
		ArrayList<MypageProfileHousePartyVo> listMypageProfileHouseParty = new ArrayList<MypageProfileHousePartyVo>();
		
		String sql = "SELECT houseparty_idx, cover_img, title, member_id, share_count, hit_count" + 
					" FROM houseparty" + 
					" WHERE member_id = ?";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberId);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				int housePartyIdx = rs.getInt("houseparty_idx");
				String coverImg = rs.getString("cover_img");
				String title = rs.getString("title");
				int shareCount = rs.getInt("share_count");
				int hitCount = rs.getInt("hit_count");
				MypageProfileHousePartyVo vo = new MypageProfileHousePartyVo(housePartyIdx, coverImg, title, memberId, shareCount, hitCount);
				listMypageProfileHouseParty.add(vo);
			}
			rs.close();
			pstmt.close();
			conn.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}
		
		return listMypageProfileHouseParty;
	}
	//마이페이지에 멤버정보 띄우기용
	public ArrayList<MypageProfileMemberInfoVo> getMypageProfileMemberInfo(String memberId) {
		Connection conn = DBConnection.getConnection();
		ArrayList<MypageProfileMemberInfoVo> listMPMemberInfo = new ArrayList<MypageProfileMemberInfoVo>();
		String profileImg = null;
		String oneLiner = null;
		
		String sql = "SELECT member_id, profile_img, one_liner" + 
					" FROM member" + 
					" WHERE member_id = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberId);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				profileImg = rs.getString("profile_img");
				oneLiner = rs.getString("one_liner");
			}
			rs.close();
			pstmt.close();
			
			String sql2 = "SELECT DISTINCT (SELECT COUNT(member_id) FROM follow WHERE member_id = ?) follow, (SELECT COUNT(followed_member_id) FROM follow WHERE followed_member_id = ?) follower" + 
						" FROM follow" + 
						" WHERE member_id = ?" + 
						" OR followed_member_id = ?";
			PreparedStatement pstmt2 = conn.prepareStatement(sql2);
			pstmt2.setString(1, memberId);
			pstmt2.setString(2, memberId);
			pstmt2.setString(3, memberId);
			pstmt2.setString(4, memberId);
			ResultSet rs2 = pstmt2.executeQuery();
			if(rs2.next()) {
				int followCount = rs2.getInt("follow");
				int followerCount = rs2.getInt("follower");
				MypageProfileMemberInfoVo vo = new MypageProfileMemberInfoVo( memberId, profileImg, oneLiner, followCount, followerCount);
				listMPMemberInfo.add(vo);
			}
			rs2.close();
			pstmt2.close();
			conn.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}
		
		return listMPMemberInfo;
	}
	
	
	
	
}
