package action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import dao.MemberDao;

public class AjaxEmailAuthenticationCodeAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("ajax authenticationCode 들어옴");
		int authenticationCode = Integer.parseInt(request.getParameter("authenticationCode"));
		String email = request.getParameter("email");
		System.out.println("email"+email+"code"+authenticationCode);
		
		MemberDao mDao = new MemberDao();
		boolean result = mDao.ajaxAuthenticationCodeCheck(email, authenticationCode);
		if(result) {
			mDao.ajaxUpdateAuthenticationCodeToNull(email, authenticationCode);
		}
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
