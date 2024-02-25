package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import common.DBConnection;
import vo.NoticeVo;

public class NoticeDao {

	public ArrayList<NoticeVo> getNoticeList() {
		ArrayList<NoticeVo> listNoticeVo = new ArrayList<NoticeVo>();
		Connection conn = DBConnection.getConnection();
		
		String sql = "SELECT * " + 
					" FROM notice" + 
					" ORDER BY notice_idx DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				int noticeIdx = rs.getInt("notice_idx");
				String title = rs.getString("title");
				String writeDate = rs.getString("write_date");
				String content = rs.getString("content");
				NoticeVo Vo = new NoticeVo(noticeIdx, title, writeDate, content);
				listNoticeVo.add(Vo);
//				listNoticeVo.get(1);
			}
			rs.close();
			pstmt.close();
			conn.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}
		return listNoticeVo;
	}
	
	//NoticeDetail
	public NoticeVo getNoticeDetail(int ParamNoticeIdx) {
		Connection conn = DBConnection.getConnection();
		NoticeVo vo = null;
		
		String sql = "SELECT *" + 
				" FROM notice" + 
				" WHERE notice_idx=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, ParamNoticeIdx);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				int noticeIdx = rs.getInt("notice_idx");
				String noticeTitle = rs.getString("title");
				String noticeWriteDate = rs.getString("write_date");
				String noticeContent = rs.getString("content");
				vo = new NoticeVo(noticeIdx, noticeTitle, noticeWriteDate, noticeContent);
			}
			rs.close();
			pstmt.close();
			conn.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}
		return vo;
	}
	
	
	
	
}
