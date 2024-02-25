package action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;

import dao.MemberDao;
import dao.OMainDao;

public class AjaxWriteReplyAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		System.out.println("write reply에 들어옴");
		MemberDao mDao = new MemberDao();
		int ozipIdx = Integer.parseInt(request.getParameter("ozip_idx"));
		String memberId = mDao.getMemberId((String)session.getAttribute("loginEmail"));
		String content = request.getParameter("content");
		String imgUrl = request.getParameter("imgUrl");
		
		OMainDao omDao = new OMainDao();
		omDao.ozipReply(ozipIdx, memberId, content, imgUrl);
		
		response.setContentType("application/json");
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		JSONObject obj = new JSONObject();
		/*
		 * if(result) { obj.put("result", "OKAY"); } else { obj.put("result", "FAIL"); }
		 * out.println(obj);
		 */

	}
	
}
