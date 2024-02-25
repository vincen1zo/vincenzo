package action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import dao.MemberDao;

public class AjaxMemberIdCheckAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		System.out.println("ajax check Id 들어옴");
		String tempMemberId = request.getParameter("blank");
//		System.out.println(tempMemberId);
		MemberDao mDao = new MemberDao();
		boolean result = mDao.ajaxMemberIdCheck(tempMemberId);
		
		response.setContentType("application/json");
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		JSONObject obj = new JSONObject();
		if(result) {
			obj.put("result", "OKAY");
		} else if(!result) {
			obj.put("result", "FAIL");
		}
		out.println(obj);
	}
	
}
