import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Date;

import common.DBConnection;

public class Test {

//	public static void main(String[] args) {
//		CategoryBestDao cabeDao = new CategoryBestDao();
//		ProductDao pDao = new ProductDao();
//		ArrayList<ProductVo> listProductVo = cabeDao.getAllProductVoList();
//		for(ProductVo vo : listProductVo) {
//
//			System.out.print(vo.getProductIdx() + " ");  // 23
//			ArrayList<ProductMainImgVo>  listMainImg = pDao.getListProductMainImgVo(vo.getProductIdx());
//			String strImageMain = listMainImg.get(0).getImgUrl();
//			String strDepth1 = cabeDao.getDepth1ByCategoryIdx(vo.getCategory());
//			int countReview = pDao.getCountReviewByProductIdx(vo.getProductIdx());  ///////////
//		}
//	}

	public static void main(String[] args) throws Exception {
		Connection conn = DBConnection.getConnection();
		String sql = "SELECT * FROM member WHERE email='또랑이'";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		if(rs.next()) {
			String d1 = rs.getString("authentication_expire");
			System.out.println(d1);	
		}
		rs.close();
		pstmt.close();
		conn.close();
		
	}
	
}
