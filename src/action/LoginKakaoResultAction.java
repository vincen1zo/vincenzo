package action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.MemberDao;

public class LoginKakaoResultAction implements Action {
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
//		session.setAttribute("memberId", request.getParameter("memberId"));
//		String memberId = (String) session.getAttribute("memberId");
		MemberDao memberDao = new MemberDao();
		String email = (String) session.getAttribute("loginEmail");
		String memberId = memberDao.getMemberId(email);
//		System.out.println("***" + memberId);
		
		session.setAttribute("memberId", memberId);
		request.getRequestDispatcher("LoginKakaoResult.jsp").forward(request, response);
	}
}
