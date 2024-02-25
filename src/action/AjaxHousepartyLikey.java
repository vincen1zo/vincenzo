package action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import dao.LikeyDao;

public class AjaxHousepartyLikey implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("ajax 요청이 서버에 들어왔어유.");
		String memberId = request.getParameter("member_id");
		int housepartyIdx = Integer.parseInt(request.getParameter("houseparty_idx"));

		LikeyDao lDao = new LikeyDao();
		String result = lDao.insertOrDeleteHousepartyLikey(memberId, housepartyIdx);
		
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		JSONObject obj = new JSONObject();
		obj.put("result", result);
		out.println(obj);
	}

}
