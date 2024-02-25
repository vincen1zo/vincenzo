package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import common.DBConnection;
import vo.QAMainVo;
import vo.QAVo;

public class QADao {
	
	public ArrayList<QAVo> getQaAll() {
		ArrayList<QAVo> listQaRet = new ArrayList<QAVo>();
		Connection conn = DBConnection.getConnection();
		
		String sql ="SELECT * FROM qa ORDER BY qa_id ASC";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				int qaId = rs.getInt("qa_id");
				String qaCategory = rs.getString("category");
				String qaQuestion = rs.getString("q");
				String qaAnswer = rs.getNString("a");
				QAVo aAVo = new QAVo(qaId, qaCategory, qaQuestion, qaAnswer);
				listQaRet.add(aAVo);
			}
			rs.close();
			pstmt.close();
			conn.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return listQaRet;
		
	}

	public ArrayList<QAVo> getQaByCategory(String paramCategory) {
		ArrayList<QAVo> listQaRet = new ArrayList<QAVo>();
		Connection conn = DBConnection.getConnection();
		String sql= "";
		if(paramCategory.equals("전체")) {		//|| paramCategory==null
			sql ="SELECT * FROM qa ORDER BY qa_id ASC";
		} else {
			sql ="SELECT * FROM qa  WHERE category=? ORDER BY qa_id ASC";
		}
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			if(!paramCategory.equals("전체"))
				pstmt.setString(1, paramCategory);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				int qaId = rs.getInt("qa_id");
				String qaCategory = rs.getString("category");
				String qaQuestion = rs.getString("q");
				String qaAnswer = rs.getNString("a");
				QAVo aAVo = new QAVo(qaId, qaCategory, qaQuestion, qaAnswer);	
				listQaRet.add(aAVo);
//				System.out.println("qaId : " + qaId);		제대로 VO가 생성되었는지 들어가는지 체크
			}
			rs.close();
			pstmt.close();
			conn.close();
		} catch(Exception e) {
			e.printStackTrace(); 
		}
		return listQaRet;
	}

	public ArrayList<QAMainVo> getQaMain() {
		ArrayList<QAMainVo> listQAMainVo = new ArrayList<QAMainVo>();
		Connection conn = DBConnection.getConnection();
		
		String sql = "SELECT qm.*, q.q" + 
					" FROM QA_main qm, QA q" + 
					" WHERE q.qa_id = qm.qa_id" + 
					" ORDER BY qm.qa_order_idx ASC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				int qaId = rs.getInt("qa_id");
				int qaOrderIdx = rs.getInt("qa_order_idx");
				String q = rs.getString("q");
				QAMainVo vo = new QAMainVo(qaId, qaOrderIdx, q);
				listQAMainVo.add(vo);
			}
			rs.close();
			pstmt.close();
			conn.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}
		return listQAMainVo;
	}
	
}
