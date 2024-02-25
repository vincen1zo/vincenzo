package action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import dao.OMainDao;

public class AjaxOzipReplyDeleteAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int commentIdx = Integer.parseInt(request.getParameter("commentIdx"));
		
		OMainDao omDao = new OMainDao();
		boolean result = omDao.deleteReplyOzipDetail(commentIdx);
		
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
