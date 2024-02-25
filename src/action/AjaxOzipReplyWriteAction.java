package action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import dao.OMainDao;
import vo.OzipReplyVo;

public class AjaxOzipReplyWriteAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int ozipIdx = Integer.parseInt(request.getParameter("ozipIdx"));
		String memberId = request.getParameter("memberId");
		String comment = request.getParameter("comment");
	
		OMainDao omDao = new OMainDao();
		OzipReplyVo vo = omDao.writeReplyOzipDetail(ozipIdx, memberId, comment);
		
		response.setContentType("application/json");
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		JSONObject obj = new JSONObject();
		obj.put("result", vo.getWritedate()!=null);
		obj.put("writedate", vo.getWritedate());
		obj.put("comment_idx", vo.getCommentIdx());
		out.println(obj);
		
	}

}
