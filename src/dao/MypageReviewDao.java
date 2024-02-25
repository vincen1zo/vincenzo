package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import common.DBConnection;
import vo.MypageReviewByReviewIdxVo;
import vo.MyWriteReviewVo;
import vo.MypageReviewVo;

public class MypageReviewDao {
	
	// 내가 구매한 상품 중 "구매확정" 상품들
	public ArrayList<MypageReviewVo> getlistProductReviewVo(String memberId){
		ArrayList<MypageReviewVo> listProductReview = new ArrayList<MypageReviewVo>();
		Connection conn = DBConnection.getConnection();
		String sql = "SELECT m.member_id, m.order_idx, m.product_idx, pmi.img_idx, pmi.img_url, p.brand_name, p.name, o.option_idx, po.option1_value,m.processed_state"
				+ " FROM mirotic m, order_option o, product p, product_option po, product_main_img pmi"
				+ " WHERE m.order_idx = o.order_idx"
				+ " AND m.product_idx = p.product_idx"
				+ " AND po.option_idx = o.option_idx"
				+ " AND pmi.product_idx = m.product_idx"
				+ " AND pmi.img_idx = 1"
				+ " AND member_id= ? "
				+ " AND processed_state='구매확정'"
				+ " ORDER BY order_date DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberId);
			ResultSet rs  = pstmt.executeQuery();
			while(rs.next()) {
				int orderIdx = rs.getInt("order_idx");
				int productIdx = rs.getInt("product_idx");
				int imgIdx = rs.getInt("img_idx");
				String imgUrl = rs.getString("img_url");
				String brandName = rs.getString("brand_name");
				String name = rs.getString("name");
				int optionIdx = rs.getInt("option_idx");
				String option1Value = rs.getString("option1_value");
				String processedState = rs.getString("processed_state");
				MypageReviewVo vo = new MypageReviewVo(memberId, orderIdx, productIdx, imgIdx, imgUrl, brandName, name, optionIdx, option1Value, processedState);
				listProductReview.add(vo);
			}
			rs.close();
			pstmt.close();
			conn.close();
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return listProductReview;
	} 
	
	
	// 리뷰쓰기(모달창)
	public void productReviewWrite (int productIdx, String memberId, String option1Value, int durability, int price, int design, int destination, String filename, String reviewTextarea, int orderIdx, int optionIdx) {
		Connection conn = DBConnection.getConnection();
		
		String sql = "INSERT INTO product_review(review_idx, product_idx, member_id, writedate, star_durability, star_price, star_design, star_delivery, option_idx, content, img_url, order_idx)"
				+ " VALUES(SEQ_MYPAGE_REVIEW_IDX.nextval, ?, ?, sysdate, ?, ?, ?, ?, ?, ?, ?, ?)";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, productIdx);
			pstmt.setString(2, memberId);
			pstmt.setInt(3,  durability);
			pstmt.setInt(4, price);
			pstmt.setInt(5, design);
			pstmt.setInt(6,  destination);
			pstmt.setInt(7, optionIdx);
			pstmt.setString(8, reviewTextarea);
			pstmt.setString(9, filename);
			pstmt.setInt(10, orderIdx);
			
			pstmt.executeUpdate();
			
			pstmt.close();
			conn.close();
		}catch(SQLException e) {
			e.printStackTrace();
		}
	}
	
	//내가 작성한 리뷰 보여주기
	public ArrayList<MyWriteReviewVo> getListWriteReviewVo(String memberId){
		ArrayList<MyWriteReviewVo> listWriteReview  = new ArrayList<MyWriteReviewVo>();
		
		Connection conn = DBConnection.getConnection();
		
		String sql = "  SELECT 	pr.product_idx, pr.review_idx, pr.member_id , p.brand_name, p.name, po.option1_value, pr.writedate, pr.content,"
				+ "				        (SELECT star_durability + star_price + star_design + star_delivery/4"
				+ "				        FROM product_review"
				+ "				        WHERE review_idx=pr.review_idx) as \"star_avg\" , pr.img_url"
				+ "				 FROM    product_review pr, product p, product_option po"
				+ "				 WHERE   pr.product_idx = p.product_idx"
				+ "				        AND pr.option_idx = po.option_idx"
				+ "				        AND pr.member_id = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberId);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				int productIdx = rs.getInt("product_idx");
				int reviewIdx = rs.getInt("review_idx");
				String brandName = rs.getString("brand_name");
				String name = rs.getString("name");
				String option1Value = rs.getString("option1_value");
				String writedate = rs.getString("writedate");
				String conent = rs.getString("content");
				Double starAvg = rs.getDouble("star_avg");
				String imgUrl = rs.getString("img_url");
				MyWriteReviewVo vo = new MyWriteReviewVo(productIdx, reviewIdx, memberId, brandName, name, option1Value, writedate, conent, starAvg, imgUrl);
				listWriteReview.add(vo);
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return listWriteReview;
	}
	
	//리뷰 수정 버튼 클릭시 해당 리뷰만 보여줌
	public MypageReviewByReviewIdxVo getWriteReviewVoByReviewIdx(int reviewIdx) {
		Connection conn = DBConnection.getConnection();
		MypageReviewByReviewIdxVo MypageReviewVo = null;
		
		String sql = "SELECT 	pr.review_idx, p.brand_name, p.name, po.option1_value, "
				+ "				pr.content, pr.star_durability, pr.star_price, pr.star_design, pr.star_delivery, pr.img_url"
				+ " FROM    product_review pr, product p, product_option po"
				+ " WHERE   pr.product_idx = p.product_idx"
				+ " AND     pr.option_idx = po.option_idx"
				+ " AND     pr.review_idx = ?";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, reviewIdx);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				reviewIdx = rs.getInt("review_idx");
				String brandName = rs.getString("brand_name");
				String name = rs.getString("name");
				String option1Value = rs.getString("option1_value");
				String content = rs.getString("content");
				int starDurability = rs.getInt("star_durability");
				int starPrice = rs.getInt("star_price");
				int starDesign = rs.getInt("star_design");
				int starDelivery = rs.getInt("star_delivery");
				String imgUrl = rs.getString("img_url");
				MypageReviewVo = new MypageReviewByReviewIdxVo(reviewIdx, brandName, name, option1Value, content, starDurability, starPrice, starDesign, starDelivery, imgUrl);
			}
			rs.close();
			pstmt.close();
			conn.close();
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return MypageReviewVo;
	}
	
	// 내가 작성한 리뷰 수정 
	public void productReviewModify(int reviewIdx, int durability, int price, int design, int destination, String content, String imgUrl ) {
		Connection conn = DBConnection.getConnection();
		
		String sql = "UPDATE  product_review"
				+ " SET star_durability=?, star_price=?, star_design=?, star_delivery=?,content=?, img_url=?"
				+ " WHERE   review_idx = ?";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, durability);
			pstmt.setInt(2, price);
			pstmt.setInt(3, design);
			pstmt.setInt(4, destination);
			pstmt.setString(5, content);
			pstmt.setString(6, imgUrl);
			pstmt.setInt(7, reviewIdx);
			pstmt.executeUpdate();
			
			pstmt.close();
			conn.close();
		}catch(SQLException e) {
			e.printStackTrace();
		}
	}
	
	// 내가 작성한 리뷰 삭제
	public void productReviewDelete(int reviewIdx) {
		Connection conn = DBConnection.getConnection();
		
		String sql = "DELETE FROM product_review WHERE review_idx= ? ";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, reviewIdx);
			pstmt.executeUpdate();
			pstmt.close();
			conn.close();
		}catch(SQLException e) {
			e.printStackTrace();
		}
	}
	
	
}
