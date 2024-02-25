package action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import api.MailSender;
import dao.MemberDao;

public class AjaxCaFormEmailAuthenticationAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		System.out.println("ajax 들어옴");
		String memberId = request.getParameter("memberId");
		String email = request.getParameter("email");
		int authenticationCode = (int)(Math.random() * 900000) + 100000;	//인증번호
		System.out.println(memberId + "\\" + email);
		
		MemberDao mDao = new MemberDao();
		String dateExpire = mDao.ajaxCaMemberIdEmailAuthentication(memberId, email, authenticationCode);
		
		try {
		    MailSender smtpServer = new MailSender(); 
		    smtpServer.emailSending("rkwkalrms777@naver.com", email, "남의집 인증번호", ""+authenticationCode);  // 전송
		    System.out.println("이메일 전송 성공");
		}
		catch (Exception e) {
		    System.out.println("이메일 전송 실패");
		    e.printStackTrace();
		}
		
		response.setContentType("application/json");
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		JSONObject obj = new JSONObject();
		if(!(dateExpire.equals(null))) {
			obj.put("result", "OKAY");
			obj.put("authenticationCode", authenticationCode);
			String year = dateExpire.substring(0,4);  // "2024"
			String month = dateExpire.substring(5,7);  // "02"
			String day = dateExpire.substring(8,10);   // "03"
			String hour = dateExpire.substring(11,13);
			String minute = dateExpire.substring(14,16);
			String second = dateExpire.substring(17);
			System.out.println(year + "/" + month + "/" +day + "  " + hour + ":" + minute + ":" + second);
			obj.put("year", year);
			obj.put("month", month);
			obj.put("day", day);
			obj.put("hour", hour);
			obj.put("minute", minute);
			obj.put("second", second);
			//obj.put("dateExpire", dateExpire);
		} else if(dateExpire.equals(null)) {
			obj.put("result", "FAIL");
		}
		out.println(obj);
	}
}
