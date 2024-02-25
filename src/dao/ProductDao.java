package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import common.DBConnection;
import vo.ProductDetailImgVo;
import vo.ProductDetailVo;
import vo.ProductMainImgVo;
import vo.ProductOption1Vo;
import vo.ProductVo;

public class ProductDao {
	public ProductVo getProductVoByProductIdx(int productIdx) {
		ProductVo voRet = null;
		Connection conn = DBConnection.getConnection();

		String sql = "SELECT * FROM product WHERE product_idx=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, productIdx);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				String brandName = rs.getString("brand_name");
				String name = rs.getString("name");
				int discount = rs.getInt("discount");
				int beforePrice = rs.getInt("before_price");
				int afterPrice = rs.getInt("after_price");
				double starReviewAvg = rs.getDouble("star_review_avg");
				int freeDeli = rs.getInt("free_deli");
				int category = rs.getInt("category");
				voRet = new ProductVo(productIdx, brandName, name, discount, beforePrice, afterPrice, starReviewAvg, freeDeli, category);
			}
			rs.close();
			pstmt.close();
			conn.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}
		return voRet;
	}
	
	// (ex) 3 ---> "가구>서랍·수납장>수납장"
	public String getCategoryStringFromCategoryIdx(int categoryIdx) {
		String strRet = "";
		Connection conn = DBConnection.getConnection();
		
		String sql = "SELECT * FROM category WHERE category_idx=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, categoryIdx);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				String depth0 = rs.getString("depth0");
				String depth1 = rs.getString("depth1");
				String depth2 = rs.getString("depth2");
				String depth3 = rs.getString("depth3");
				strRet += depth0;
				if(depth1!=null) strRet += ">" + depth1;
				if(depth2!=null) strRet += ">" + depth2;
				if(depth3!=null) strRet += ">" + depth3;
			}
			rs.close();
			pstmt.close();
			conn.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}
		return strRet;
	}
	
	public ArrayList<ProductMainImgVo> getListProductMainImgVo(int productIdx) {
		ArrayList<ProductMainImgVo> listRet = new ArrayList<ProductMainImgVo>();
		Connection conn = DBConnection.getConnection();
		
		String sql = "select * from product_main_img where product_idx=? ORDER BY img_idx";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, productIdx);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				int imgIdx = rs.getInt("img_idx");
				String imgUrl = rs.getString("img_url");
				ProductMainImgVo vo = new ProductMainImgVo(productIdx, imgIdx, imgUrl);
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
	
	public int getLikeyCountByProductIdx(int productIdx) {
		int countRet = 0;
		Connection conn = DBConnection.getConnection();
		
		String sql = "SELECT count(*) FROM likey WHERE product_idx=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, productIdx);
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
	
	public int getCountReviewByProductIdx(int productIdx) {
		int countRet = 0;
		Connection conn = DBConnection.getConnection();
		
		String sql = "SELECT count(*) FROM product_review WHERE product_idx=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, productIdx);
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
	
	// (1) ProductDao, getOption1Name(int productIdx) --> String을 리턴.
	public String getOption1Name(int productIdx) {
		Connection conn = DBConnection.getConnection();
		String strRet = "";
		
		String sql = "SELECT distinct option1 FROM product_option WHERE product_idx=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, productIdx);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				strRet = rs.getString(1);
			}
			rs.close();
			pstmt.close();
			conn.close();
		} catch(SQLException e) { e.printStackTrace(); }
		return strRet;
	}
	
	// (2) ProductDao, getListProductOption1Vo(int productIdx) --> ArrayList<ProductOption1Vo> 를 리턴.
	public ArrayList<ProductOption1Vo> getListProductOption1Vo(int productIdx) {
		Connection conn = DBConnection.getConnection();
		ArrayList<ProductOption1Vo> listRet = new ArrayList<ProductOption1Vo>();
		
		String sql = "SELECT option_idx, option1_value, option1_price FROM product_option WHERE product_idx=? AND option2 IS NULL AND option3 IS NULL";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, productIdx);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				int optionIdx = rs.getInt("option_idx");
				String option1Value = rs.getString("option1_value");
				int option1Price = rs.getInt("option1_price");
				ProductOption1Vo vo = new ProductOption1Vo(optionIdx, option1Value, option1Price);
				listRet.add(vo);
			}
			rs.close();
			pstmt.close();
			conn.close();
		} catch(SQLException e) { e.printStackTrace(); }
		return listRet;
	}

	// 단일상품일 경우, product_idx 를 받아서 ---> option_idx 값을 리턴.
	public int getDanIlOptionIdxFromProductIdx(int productIdx) {
		Connection conn = DBConnection.getConnection();
		int optionIdx = -1;   // 초기값(DB에 없는 값으로 아무거나 선택한 것)
		String sql = "SELECT option_idx FROM product_option WHERE product_idx=? "
				   + " AND option1 IS NULL"
				   + " AND option2 IS NULL"
				   + " AND option3 IS NULL";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, productIdx);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				optionIdx = rs.getInt("option_idx");
			}
			rs.close();
			pstmt.close();
			conn.close();
		} catch(SQLException e) { e.printStackTrace(); }
		return optionIdx;  // -1 이 리턴되면, 해당 상품은 '단일상품으로 구입할 수 없는 상품'임.
	}
	
	// orderStr : "4_7/6_5/2_3" 과 같은 형식. payment : "카카오페이" 등.
	public int insertBaroMirotic(String memberId, int productIdx, String orderStr, String payment, int totalPrice) {
		Connection conn = DBConnection.getConnection();
		
		// Ex) 4_7/6_5/2_3  ----------> DAO에, insertBaroMirotic(String memberId, String orderStr)
		String sql = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		//1) mirotic 테이블에 insert
		//	INSERT INTO mirotic(order_idx, member_id, product_idx, payment, payment_price, payment_date, processed_state, cancel_reasons_idx, cancel_reasons_detail)
		//	VALUES (SEQ_ORDER_IDX.nextval, '뚱이', (상품idx), '카카오페이', (총가격), sysdate, '장바구니', null, null);
		try {
			sql = "INSERT INTO mirotic(order_idx, member_id, product_idx, payment, payment_price, payment_date, processed_state, cancel_reasons_idx, cancel_reasons_detail) "
				+ " VALUES (SEQ_ORDER_IDX.nextval, ?, ?, ?, ?, sysdate, '장바구니', null, null)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberId);
			pstmt.setInt(2, productIdx);
			pstmt.setString(3, payment);
			pstmt.setInt(4, totalPrice);
			pstmt.executeUpdate();
			pstmt.close();
		} catch(Exception e) { e.printStackTrace(); }

		//2) SEQ_ORDER_IDX.currval 값 확인 =====> "order_idx"값.
		//	SELECT SEQ_ORDER_IDX.currval FROM dual;
		int orderIdx = 0;
		try {
			sql = "SELECT SEQ_ORDER_IDX.currval FROM dual";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				orderIdx = rs.getInt(1);
			}
			rs.close();
			pstmt.close();
		} catch(Exception e) { e.printStackTrace(); }
		
		//3) 3번 insert
		//	INSERT INTO order_option(order_idx, option_idx, qty) 
		//	VALUES ( (order_idx값) , 4, 7 );
		//	INSERT INTO order_option(order_idx, option_idx, qty) 
		//	VALUES ( (order_idx값) , 6, 5 );
		//	INSERT INTO order_option(order_idx, option_idx, qty) 
		//	VALUES ( (order_idx값) , 2, 3 );
		String[] arr1 = orderStr.split("/");    // arr1 : ["4_7", "6_5", "2_3"]
		
		for(String s : arr1) {
			int idx1 = Integer.parseInt(s.split("_")[0]);
			int qty1 = Integer.parseInt(s.split("_")[1]);
			try {
				sql = "INSERT INTO order_option(order_idx, option_idx, qty)" 
					+ " VALUES ( ?, ?, ?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, orderIdx);
				pstmt.setInt(2, idx1);
				pstmt.setInt(3, qty1);
				pstmt.executeUpdate();
				pstmt.close();
			} catch(Exception e) { e.printStackTrace(); }
		}
		
		try {
			conn.close();
		} catch(Exception e) { e.printStackTrace(); }
		
		return orderIdx;
	}
	
	public void updateMirotic(int orderIdx) {
		Connection conn = DBConnection.getConnection();
		String sql = "UPDATE mirotic SET processed_state='구매확정' WHERE order_idx=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, orderIdx);
			pstmt.executeUpdate();
			pstmt.close();
			conn.close();
		} catch(Exception e) { e.printStackTrace(); }
	}

	public int getCategoryIdxFromCateNames(String cateName1, String cateName2, String cateName3) {
		Connection conn = DBConnection.getConnection();
		
		// category_idx 를 파악.
		String sql = "SELECT category_idx FROM category WHERE depth1=? AND depth2=? AND depth3=?";
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
			conn.close();
		} catch(SQLException e) { e.printStackTrace(); }
		return categoryIdx;
	}

	public int getProductCountByCategoryIdx(int categoryIdx) {
		Connection conn = DBConnection.getConnection();
		int cnt = 0;
		// category_idx 를 파악.
		String sql = "SELECT count(*) FROM product WHERE category=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, categoryIdx);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				cnt = rs.getInt(1);
			}
			rs.close();
			pstmt.close();
			conn.close();
		} catch(SQLException e) { e.printStackTrace(); }
		return cnt;
	}

	public ArrayList<ProductDetailImgVo> getListProductDetailImgVo(int productIdx) {
		Connection conn = DBConnection.getConnection();
		ArrayList<ProductDetailImgVo> listRet = new ArrayList<ProductDetailImgVo>();
		
		String sql = "SELECT * FROM product_detail_img WHERE product_idx=? ORDER BY img_order";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, productIdx);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				int imgOrder = rs.getInt("img_order");
				String imgUrl = rs.getString("img_url");
				String externalUrl = rs.getString("external_url");
				String imgUnderText = rs.getString("img_under_text");
				ProductDetailImgVo vo = new ProductDetailImgVo(productIdx, imgOrder, imgUrl, externalUrl, imgUnderText);
				listRet.add(vo);
			}
			rs.close();
			pstmt.close();
			conn.close();
		} catch(SQLException e) { e.printStackTrace(); }
		
		return listRet;
	}

	public ProductDetailVo getProductDetailVoByProductIdx(int productIdx) {
		Connection conn = DBConnection.getConnection();
		ProductDetailVo voRet = null;
		String sql = "SELECT * FROM product_detail WHERE product_idx=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, productIdx);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				String modelName = rs.getString("model_name");
				String kcAuth = rs.getString("kc_auth");
				String volt = rs.getString("volt");
				String efficiencyRating = rs.getString("efficiency_rating");
				String productOriginYear = rs.getString("product_origin_year");
				String manufacturer = rs.getString("manufacturer");
				String country = rs.getString("country");
				String swwd = rs.getString("swwd");
				String spec = rs.getString("spec");
				String qualityStandards = rs.getString("quality_standards");
				String asNumber = rs.getString("as_number");
				String lawCertified = rs.getString("law_certified");
				String color = rs.getString("color");
				String components = rs.getString("components");
				String material = rs.getString("material");
				String refurbished = rs.getString("refurbished");
				String installationCost = rs.getString("installation_cost");
				String age = rs.getString("age");
				String sizeWeightLimit = rs.getString("size_weight_limit");
				String handlingMethod = rs.getString("handling_method");
				String precautions = rs.getString("precautions");
				String deli = rs.getString("deli");
				String deliCost = rs.getString("deli_cost");
				String addDeliCost = rs.getString("add_deli_cost");
				String nonDeliArea = rs.getString("non_deli_area");
				String proportionalDeliCost = rs.getString("proportional_deli_cost");
				String regionalDeliCost = rs.getString("regional_deli_cost");
				String returnDeliCost = rs.getString("return_deli_cost");
				String exchangeDeliCost = rs.getString("exchange_deli_cost");
				String destination = rs.getString("destination");
				voRet = new ProductDetailVo(productIdx, modelName, kcAuth, volt, efficiencyRating, productOriginYear, manufacturer, country, swwd, spec, qualityStandards, asNumber, lawCertified, color, components, material, refurbished, installationCost, age, sizeWeightLimit, handlingMethod, precautions, deli, deliCost, addDeliCost, nonDeliArea, proportionalDeliCost, regionalDeliCost, returnDeliCost, exchangeDeliCost, destination);
			}
			rs.close();
			pstmt.close();
			conn.close();
		} catch(SQLException e) { e.printStackTrace(); }
		return voRet;
	}


}
	


