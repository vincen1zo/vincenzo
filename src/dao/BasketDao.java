package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import common.DBConnection;
import vo.BasketVo;

public class BasketDao {

	public ArrayList<BasketVo> getlistBasket(String memberId) {
		ArrayList<BasketVo> listBasket = new ArrayList<BasketVo>();
		
		Connection conn = DBConnection.getConnection();
		String sql = "SELECT m.member_id, m.order_idx, m.product_idx,pmi.img_idx, pmi.img_url, p.brand_name, p.name, o.option_idx,"
				+ " po.option1_value,m.processed_state, pd.deli, pd.deli_cost,o.qty, po.option1_price, p.free_deli"
				+ " FROM mirotic m, order_option o, product p, product_option po, product_main_img pmi, product_detail pd"
				+ " WHERE m.order_idx = o.order_idx"
				+ " AND m.product_idx = p.product_idx"
				+ " AND po.option_idx = o.option_idx"
				+ " AND pmi.product_idx = m.product_idx"
				+ " AND p.product_idx = pd.product_idx"
				+ " AND pmi.img_idx = 1"
				+ " AND member_id = ? "
				+ " AND processed_state='장바구니'"
				+ " ORDER BY order_date DESC";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberId);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				int orderIdx = rs.getInt("order_idx");
				int productIdx = rs.getInt("product_idx");
				int imgIdx = rs.getInt("img_idx");
				String imgUrl = rs.getString("img_url");
				String brandName = rs.getString("brand_name");
				String name = rs.getString("name");
				int optioinIdx = rs.getInt("option_idx");
				String option1Value = rs.getString("option1_value");
				String processedState = rs.getString("processed_state");
				String deli = rs.getString("deli");
				String deliCost = rs.getString("deli_cost");
				int Qty = rs.getInt("qty");
				int option1Price = rs.getInt("option1_price");
				int freeDeli = rs.getInt("free_deli");
				
				BasketVo vo = new BasketVo(memberId, orderIdx, productIdx, imgIdx, imgUrl, brandName, name, optioinIdx, option1Value, processedState, deli, deliCost, Qty, option1Price, freeDeli);
				listBasket.add(vo);
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return listBasket;
	}

}
