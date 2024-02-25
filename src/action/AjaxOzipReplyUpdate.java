package action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import dao.MemberDao;
import dao.OMainDao;

public class AjaxOzipReplyUpdate implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("ajax reply update action 들어옴.");
		int ozipIdx = Integer.parseInt(request.getParameter("ozipIdx"));
		String email = request.getParameter("memberId");
		MemberDao mDao = new MemberDao();
		String memberId = mDao.getMemberId(email);
		int commentIdx = Integer.parseInt(request.getParameter("commentIdx"));
		String comment = request.getParameter("comment");

		
		OMainDao omDao = new OMainDao();
		boolean result = omDao.updateReplyOzipDetail(ozipIdx, memberId, commentIdx, comment);

		response.setContentType("application/json");
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		JSONObject obj = new JSONObject();
		if(result) {
			obj.put("result", "OKAY");
		} else {
			obj.put("result", "FAIL");
		}
		out.println(obj);
	}
	
}
