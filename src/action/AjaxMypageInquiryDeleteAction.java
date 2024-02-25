package action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import dao.MemberDao;

public class AjaxMypageInquiryDeleteAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("ajax mypage inquiry delete action 들어옴.");
		int inquiryIdx = Integer.parseInt(request.getParameter("inquiryIdx"));
		System.out.println("삭제할 inquiryIdx : " + inquiryIdx);
		
		MemberDao mDao = new MemberDao();
		boolean result = mDao.deleteMapageInquiry(inquiryIdx); 
		
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
