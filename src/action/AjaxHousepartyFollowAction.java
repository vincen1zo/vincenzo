package action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import dao.FollowDao;

public class AjaxHousepartyFollowAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("ajax 요청이 서버에 들어왔다 우왕");
		String memberId = request.getParameter("member_id");
		String followedMemberId = request.getParameter("followed_member_id");
		
		FollowDao fDao = new FollowDao();
		String result = fDao.insertOrDeleteHousepartyFollow(memberId, followedMemberId);
		
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		JSONObject obj = new JSONObject();
		obj.put("result", result);
		out.println(obj);
	}	
}
